#!/usr/bin/env python3
"""Regenerate the checked-in Xcode project using only Python's standard library."""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[1]
objects = {}
def ident(key):
    return hashlib.sha1(key.encode()).hexdigest()[:24].upper()
def q(value):
    return json.dumps(str(value))
def add(key, body):
    uid = ident(key)
    objects[uid] = body
    return uid
def refs(values):
    return '(' + ', '.join(values) + (',' if values else '') + ')'

sources = sorted((ROOT / 'Sources/SandboxResearchLab').rglob('*.swift'))
file_refs = []
build_refs = []
for path in sources:
    relative = str(path.relative_to(ROOT))
    ref = add('file:' + relative, f'isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = {q(relative)}; sourceTree = "<group>";')
    file_refs.append(ref)
    build_refs.append(add('build:' + relative, f'isa = PBXBuildFile; fileRef = {ref};'))
resource_refs = []
resource_builds = []
for relative, kind in [('Resources/Assets.xcassets', 'folder.assetcatalog'), ('Resources/PrivacyInfo.xcprivacy', 'text.xml')]:
    ref = add('file:' + relative, f'isa = PBXFileReference; lastKnownFileType = {kind}; path = {q(relative)}; sourceTree = "<group>";')
    resource_refs.append(ref)
    resource_builds.append(add('build:' + relative, f'isa = PBXBuildFile; fileRef = {ref};'))
for relative in ['Resources/Info.plist', 'Resources/SandboxResearchLab.entitlements']:
    resource_refs.append(add('file:' + relative, f'isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = {q(relative)}; sourceTree = "<group>";'))
app = add('app', 'isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SandboxResearchLab.app; sourceTree = BUILT_PRODUCTS_DIR;')
package = add('package', 'isa = XCLocalSwiftPackageReference; relativePath = Core;')
product = add('package-product', f'isa = XCSwiftPackageProductDependency; package = {package}; productName = ResearchCore;')
framework = add('package-link', f'isa = PBXBuildFile; productRef = {product};')
source_phase = add('source-phase', f'isa = PBXSourcesBuildPhase; buildActionMask = 2147483647; files = {refs(build_refs)}; runOnlyForDeploymentPostprocessing = 0;')
resource_phase = add('resource-phase', f'isa = PBXResourcesBuildPhase; buildActionMask = 2147483647; files = {refs(resource_builds)}; runOnlyForDeploymentPostprocessing = 0;')
framework_phase = add('framework-phase', f'isa = PBXFrameworksBuildPhase; buildActionMask = 2147483647; files = ({framework},); runOnlyForDeploymentPostprocessing = 0;')
products = add('products', f'isa = PBXGroup; children = ({app},); name = Products; sourceTree = "<group>";')
main_group = add('main-group', f'isa = PBXGroup; children = {refs(file_refs + resource_refs + [products])}; sourceTree = "<group>";')
project_configs = []
target_configs = []
for name in ['Debug', 'Release']:
    pc = {'SDKROOT': 'iphoneos', 'IPHONEOS_DEPLOYMENT_TARGET': '17.0', 'SWIFT_VERSION': '5.0', 'CLANG_ENABLE_MODULES': 'YES', 'ENABLE_STRICT_OBJC_MSGSEND': 'YES', 'SWIFT_STRICT_CONCURRENCY': 'complete', 'DEBUG_INFORMATION_FORMAT': 'dwarf' if name == 'Debug' else 'dwarf-with-dsym', 'SWIFT_OPTIMIZATION_LEVEL': '-Onone' if name == 'Debug' else '-O'}
    if name == 'Debug':
        pc['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG $(inherited)'
    tc = {'PRODUCT_BUNDLE_IDENTIFIER': 'com.xsxs18.sandboxresearchlab', 'PRODUCT_NAME': 'SandboxResearchLab', 'INFOPLIST_FILE': 'Resources/Info.plist', 'GENERATE_INFOPLIST_FILE': 'YES', 'INFOPLIST_KEY_CFBundleExecutable': '$(EXECUTABLE_NAME)', 'INFOPLIST_KEY_CFBundleIdentifier': '$(PRODUCT_BUNDLE_IDENTIFIER)', 'CODE_SIGN_STYLE': 'Automatic', 'CODE_SIGN_ENTITLEMENTS': 'Resources/SandboxResearchLab.entitlements', 'TARGETED_DEVICE_FAMILY': '1,2', 'SUPPORTED_PLATFORMS': 'iphoneos iphonesimulator', 'SUPPORTS_MACCATALYST': 'NO', 'ASSETCATALOG_COMPILER_APPICON_NAME': 'AppIcon', 'LD_RUNPATH_SEARCH_PATHS': '$(inherited) @executable_path/Frameworks'}
    for key, settings, collection in [('project', pc, project_configs), ('target', tc, target_configs)]:
        body = ' '.join(f'{k} = {q(v)};' for k, v in settings.items())
        collection.append(add(key + '-config-' + name, f'isa = XCBuildConfiguration; buildSettings = {{{body}}}; name = {name};'))
def config_list(key, configs):
    return add(key, f'isa = XCConfigurationList; buildConfigurations = {refs(configs)}; defaultConfigurationIsVisible = 0; defaultConfigurationName = Release;')
target_config = config_list('target-config-list', target_configs)
project_config = config_list('project-config-list', project_configs)
target = add('target', f'isa = PBXNativeTarget; buildConfigurationList = {target_config}; buildPhases = ({source_phase}, {framework_phase}, {resource_phase},); buildRules = (); dependencies = (); name = SandboxResearchLab; packageProductDependencies = ({product},); productName = SandboxResearchLab; productReference = {app}; productType = "com.apple.product-type.application";')
project = add('project', f'isa = PBXProject; attributes = {{LastUpgradeCheck = 1600; TargetAttributes = {{{target} = {{CreatedOnToolsVersion = 16.0; }}; }}; }}; buildConfigurationList = {project_config}; compatibilityVersion = "Xcode 14.0"; developmentRegion = en; hasScannedForEncodings = 0; knownRegions = (en, Base); mainGroup = {main_group}; packageReferences = ({package},); productRefGroup = {products}; projectDirPath = ""; projectRoot = ""; targets = ({target},);')
text = '// !$*UTF8*$!\n{\n archiveVersion = 1;\n classes = {};\n objectVersion = 56;\n objects = {\n'
text += '\n'.join(f'  {uid} = {{{body}}};' for uid, body in objects.items())
text += f'\n }};\n rootObject = {project};\n}}\n'
project_dir = ROOT / 'SandboxResearchLab.xcodeproj'
project_dir.mkdir(exist_ok=True)
(project_dir / 'project.pbxproj').write_text(text)
scheme_dir = project_dir / 'xcshareddata/xcschemes'
scheme_dir.mkdir(parents=True, exist_ok=True)
reference = f'<BuildableReference BuildableIdentifier="primary" BlueprintIdentifier="{target}" BuildableName="SandboxResearchLab.app" BlueprintName="SandboxResearchLab" ReferencedContainer="container:SandboxResearchLab.xcodeproj"/>'
(scheme_dir / 'SandboxResearchLab.xcscheme').write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<Scheme LastUpgradeVersion="1600" version="1.3">
<BuildAction parallelizeBuildables="YES" buildImplicitDependencies="YES"><BuildActionEntries><BuildActionEntry buildForTesting="YES" buildForRunning="YES" buildForProfiling="YES" buildForArchiving="YES" buildForAnalyzing="YES">{reference}</BuildActionEntry></BuildActionEntries></BuildAction>
<TestAction buildConfiguration="Debug" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" shouldUseLaunchSchemeArgsEnv="YES"/>
<LaunchAction buildConfiguration="Debug" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" launchStyle="0" useCustomWorkingDirectory="NO" ignoresPersistentStateOnLaunch="NO" debugDocumentVersioning="YES" debugServiceExtension="internal" allowLocationSimulation="YES"><BuildableProductRunnable runnableDebuggingMode="0">{reference}</BuildableProductRunnable></LaunchAction>
<ProfileAction buildConfiguration="Release" shouldUseLaunchSchemeArgsEnv="YES" savedToolIdentifier="" useCustomWorkingDirectory="NO" debugDocumentVersioning="YES"><BuildableProductRunnable runnableDebuggingMode="0">{reference}</BuildableProductRunnable></ProfileAction>
<AnalyzeAction buildConfiguration="Debug"/>
<ArchiveAction buildConfiguration="Release" revealArchiveInOrganizer="YES"/>
</Scheme>
''')
print(f'Generated Xcode project with {len(sources)} Swift app sources and local ResearchCore package.')
