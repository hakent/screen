
add_library(Qt5::QWaylandEglStreamBufferIntegrationPlugin MODULE IMPORTED)

_populate_WaylandCompositor_plugin_properties(QWaylandEglStreamBufferIntegrationPlugin RELEASE "wayland-graphics-integration-server/libwayland-eglstream-controller.so")

list(APPEND Qt5WaylandCompositor_PLUGINS Qt5::QWaylandEglStreamBufferIntegrationPlugin)
