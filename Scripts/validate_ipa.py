#!/usr/bin/env python3
"""Validate packaging and summarize signature presence without exposing provisioning secrets.

This is a structural check, not Apple signature trust validation or an installability test.
"""
import argparse
import hashlib
import json
import plistlib
import struct
from pathlib import Path
from zipfile import ZipFile

parser = argparse.ArgumentParser()
parser.add_argument('ipa', type=Path)
args = parser.parse_args()
with ZipFile(args.ipa) as archive:
    assert archive.testzip() is None, 'ZIP CRC validation failed'
    names = archive.namelist()
    roots = [n for n in names if n.startswith('Payload/') and n.count('/') == 2 and n.endswith('.app/Info.plist')]
    assert len(roots) == 1, 'Expected exactly one root application Info.plist'
    info_name = roots[0]
    root = info_name.removesuffix('Info.plist')
    info = plistlib.loads(archive.read(info_name))
    for key in ['CFBundleIdentifier', 'CFBundleExecutable', 'CFBundleVersion', 'MinimumOSVersion']:
        assert info.get(key) and '$(' not in str(info[key]), f'Missing/unresolved {key}'
    assert info['CFBundlePackageType'] == 'APPL'
    binary = archive.read(root + info['CFBundleExecutable'])
    magic, cpu, subtype, filetype, count, command_bytes, flags, reserved = struct.unpack_from('<8I', binary)
    assert magic == 0xFEEDFACF, 'Expected 64-bit little-endian Mach-O'
    assert cpu == 0x0100000C, 'Expected arm64'
    assert filetype == 2, 'Expected executable Mach-O'
    offset = 32
    signed = False
    for _ in range(count):
        command, size = struct.unpack_from('<II', binary, offset)
        assert size >= 8 and offset + size <= 32 + command_bytes
        if command == 0x1D:
            start, length = struct.unpack_from('<II', binary, offset + 8)
            assert length > 0 and start + length <= len(binary)
            signed = True
        offset += size
    assert root + 'PrivacyInfo.xcprivacy' in names, 'Privacy manifest missing'
    plistlib.loads(archive.read(root + 'PrivacyInfo.xcprivacy'))
    schemes = [scheme for item in info.get('CFBundleURLTypes', []) for scheme in item.get('CFBundleURLSchemes', [])]
    assert 'sandboxresearchlab' in schemes, 'Own probe scheme missing'
    assert any('Icon' in n and n.endswith('.png') for n in names), 'App icon missing'
    assert not any(n.endswith(('.p12', '.key', '.pem')) for n in names), 'Private signing material in bundle'
    provisioned = root + 'embedded.mobileprovision' in names
    summary = {
        'artifact': args.ipa.name,
        'sha256': hashlib.sha256(args.ipa.read_bytes()).hexdigest(),
        'bundleIdentifier': info['CFBundleIdentifier'],
        'appVersion': info.get('CFBundleShortVersionString'),
        'build': info['CFBundleVersion'],
        'minimumOS': info['MinimumOSVersion'],
        'architecture': 'arm64',
        'machOSignaturePresent': signed,
        'provisioningProfilePresent': provisioned,
        'privacyManifestPresent': True,
        'ownURLSchemePresent': True,
        'interpretation': 'Signature structure present is not proof of Apple provisioning or device installability. Device validation is still required.'
    }
    print(json.dumps(summary, indent=2))
