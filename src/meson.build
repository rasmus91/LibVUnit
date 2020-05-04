
#src = [
#    
#]


testlib = shared_library(
    'vunit',
    src,
    dependencies : dependencies,

    install: true,

    vala_header: 'vunit.h',
    vala_vapi: 'vunit-0.0.1.vapi',
    vala_gir: 'vunit-0.0.1.gir',
    
    version: meson.project_version()
)

vunit_dep = declare_dependency(link_with: testlib, include_directories: include_directories('.'))
