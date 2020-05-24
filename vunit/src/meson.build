pkg = import('pkgconfig')
g_ir_compiler = find_program('g-ir-compiler')


vunit_src = [
    'TestBase.vala'
]

vunit_base_name = meson.project_name() + '-' + meson.project_version()#'vunit-1.0.'
vunit_gir = vunit_base_name + '.gir'
vunit_typelib = vunit_base_name + '.typelib'

libvunit = shared_library(
    meson.project_name(),
    vunit_src,
    dependencies : lib_dependencies,

    vala_header: meson.project_name() + '.h',
    vala_vapi: meson.project_name() + '-' + meson.project_version() + '.vapi',
    vala_gir: vunit_gir,

    #version: meson.project_version(),
    install: true,
    install_dir: [true, true, true, true]
)



custom_target(vunit_typelib,
    depends: libvunit,
    command: [g_ir_compiler, '--output', '@OUTPUT@', meson.current_build_dir() / vunit_gir],
    #input: meson.current_build_dir() / 'vunit-0.1.gir',
    output: vunit_typelib,
    install: true,
    install_dir: get_option('libdir') / 'girepository-1.0')




vunit_dep = declare_dependency(link_with: libvunit, include_directories: include_directories('.'))

vunit_pc = pkg.generate(
    libvunit,
    name: meson.project_name() + '-' + meson.project_version(),
    requires: lib_dependencies,
    description: 'A xUnit like test implementation library',
    version: meson.project_version(),
    url: 'https://github.com/Lindegaard-IT/VUnit'
)
