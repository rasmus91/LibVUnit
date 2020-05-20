
#src = [
#    
#]


vunit_src = [
    'TestBase.vala'
]

vunit_lib = shared_library(
    meson.project_name(),
    vunit_src,
    dependencies : lib_dependencies,

    #vala_header: meson.project_name() + '.h',
    vala_gir: meson.project_name() + '-' + meson.project_version() + '.gir',
    vala_vapi: meson.project_name() + '-' + meson.project_version() + '.vapi',

    #version: meson.project_version(),
    install: true,
    install_dir: [true, true, true, true]
)

g_ir_compiler = find_program('g-ir-compiler')

#custom_target('vunit typelib',
#    depends: vunit_lib,
#    command: [g_ir_compiler, '--output', '@OUTPUT@', '@INPUT@'],
#    input: meson.current_build_dir() / 'vunit-0.1.gir',
#    output: meson.project_name() + '-' + meson.project_version() + '.typelib',
#    install: true,
#    install_dir: get_option('libdir') / 'girepository-1.0')

vunit_dep = declare_dependency(link_with: vunit_lib, include_directories: include_directories('.'))

