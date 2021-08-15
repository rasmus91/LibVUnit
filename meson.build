project('vunit', 'vala', 'c', version: '0.1', license: 'GPL')

gnome = import('gnome')

#dependencies = [
#    dependency('gee-0.8'),
#    dependency('gdk-pixbuf-2.0'),
#    dependency('gio-2.0')
#]

g_deps = [
    dependency('glib-2.0'),
    dependency('gobject-2.0')
]

lib_dependencies = [
    g_deps,
    dependency('gee-0.8'),
    #dependency('gio-2.0'),
    #dependency('gdk-pixbuf-2.0'),
]

subdir('src')

#sample_deps = [
#    g_deps,
#    dependency('vunit-0.1')
#]

#subdir('sample')
#Stuff below this is to change if you want to run this on a different library of tests
