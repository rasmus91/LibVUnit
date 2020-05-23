pkg = import('pkgconfig')
g_ir_compiler = find_program('g-ir-compiler')


vunit_src = [
    'TestBase.vala'
]

vunit_base_name = 'VUnit' + '-' + meson.project_version()
vunit_gir = vunit_base_name + '.gir'
vunit_vapi = vunit_base_name + '.vapi'

vunit_lib = shared_library(
    meson.project_name(),
    vunit_src,
    dependencies : lib_dependencies,

    vala_header: meson.project_name() + '.h',
    vala_vapi: vunit_vapi,
    vala_gir: vunit_gir,

    #version: meson.project_version(),
    install: true,
    install_dir: [true, true, true, true]
)



#custom_target('vunit typelib',
#    depends: vunit_lib,
#    command: [g_ir_compiler, '--output', '@OUTPUT@', '@INPUT@'],
#    input: meson.current_build_dir() / 'vunit-0.1.gir',
#    output: meson.project_name() + '-' + meson.project_version() + '.typelib',
#    install: true,
#    install_dir: get_option('libdir') / 'girepository-1.0')

vunit_dep = declare_dependency(link_with: vunit_lib, include_directories: include_directories('.'))

vunit_pc = pkg.generate(
    vunit_lib,
    name: meson.project_name() + '-' + meson.project_version(),
    requires: lib_dependencies,
    description: 'A xUnit like test implementation library',
    version: meson.project_version(),
    url: 'https://github.com/Lindegaard-IT/VUnit'
)
