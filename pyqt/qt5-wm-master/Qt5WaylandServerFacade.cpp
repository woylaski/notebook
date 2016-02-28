
#include "Qt5WaylandServerFacade.h"
#include "Qt5WaylandClientWrapper.h"

// http://wayland.freedesktop.org/docs/html/

// global = singleton advertised to clients (versioned)
// implement interface = callbacks to handle client requests
// resource = opaque container for custom data (versioned) of a client
// send = post events to clients with resource

const QByteArray & Qt5WaylandServerFacade::s_waylandName = QByteArrayLiteral ("qt5wm-0");

Qt5WaylandServerFacade::Qt5WaylandServerFacade (QObject * parent)
    : QObject (parent)
    , m_waylandFd (0)
    , m_waylandGlobalCompositor (Q_NULLPTR)
    , m_waylandGlobalXdgShell (Q_NULLPTR)
    , m_waylandGlobalOutput (Q_NULLPTR)
    , m_waylandDisplay (Q_NULLPTR)
    , m_waylandEventLoop (Q_NULLPTR)
    , m_waylandSharedMem (Q_NULLPTR)
    , m_desktopWin (Q_NULLPTR)
    , m_notifier (Q_NULLPTR)
{

}

void Qt5WaylandServerFacade::init (QObject * desktopWindow) {
    qDebug () << "SERVER FACADE : INIT";
    m_desktopWin = qobject_cast<QWindow *> (desktopWindow);
    if (m_desktopWin != Q_NULLPTR) {
        m_desktopWin->setGeometry (QGuiApplication::primaryScreen ()->virtualGeometry ());
        m_waylandDisplay = wl_display_create ();
        wl_display_add_socket (m_waylandDisplay, s_waylandName);
        wl_display_init_shm (m_waylandDisplay);
        //wl_display_add_shm_format (m_waylandDisplay, WL_SHM_FORMAT_ARGB8888);
        //wl_display_add_shm_format (m_waylandDisplay, WL_SHM_FORMAT_RGBA8888);
        m_waylandEventLoop = wl_display_get_event_loop (m_waylandDisplay);
        m_waylandGlobalCompositor = wl_global_create (m_waylandDisplay,
                                                      &wl_compositor_interface, 3,
                                                      new Qt5WaylandCompositor (this),
                                                      &Qt5WaylandServerFacade::callbackCompositorBind);
        m_waylandGlobalOutput = wl_global_create (m_waylandDisplay,
                                                  &wl_output_interface, 2,
                                                  new Qt5WaylandOutput (this),
                                                  &Qt5WaylandServerFacade::callbackOutputBind);
        m_waylandGlobalXdgShell = wl_global_create (m_waylandDisplay,
                                                    &xdg_shell_interface, 1,
                                                    new Qt5WaylandXdgShell (this),
                                                    &Qt5WaylandServerFacade::callbackXdgShellBind);
        m_waylandFd = wl_event_loop_get_fd (m_waylandEventLoop);
        m_notifier = new QSocketNotifier (m_waylandFd, QSocketNotifier::Read, this);
        connect (m_notifier, &QSocketNotifier::activated, this, &Qt5WaylandServerFacade::doProcessWaylandEvents);
        qputenv ("GDK_BACKEND", "wayland"); // for GTK3+
        qputenv ("CLUTTER_BACKEND", "wayland"); // for Clutter
        qputenv ("QT_QPA_PLATFORM", "wayland-egl"); // for Qt5
        qputenv ("SDL_VIDEODRIVER", "wayland"); // for SDL2.0.2+
        qputenv ("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1"); // for QPA
        qputenv ("WAYLAND_DISPLAY", s_waylandName);
        QTimer::singleShot (1000, this, SLOT (doTests ()));
    }
}

void Qt5WaylandServerFacade::doTests (void) {
    static int currTest = 0;
    QStringList tests;
    tests << "weston-info" /*<< "weston-simple-shm" << "weston-terminal"*/ << "lxqt-about";
    if (currTest < tests.size ()) {
        QString program = tests.at (currTest);
        QProcess * process = new QProcess (this);
        connect (process, SIGNAL (finished (int)), this, SLOT (onTestFinished (void)));
        qDebug () << "RUNNING" << program << "on" << s_waylandName;
        process->setWorkingDirectory (QDir::homePath ());
        process->start (program, QProcess::ReadOnly);
    }
    currTest++;
}

void Qt5WaylandServerFacade::onTestFinished (void) {
    QProcess * process = qobject_cast<QProcess *> (sender ());
    if (process != Q_NULLPTR) {
        if (process->exitCode ()) {
            process->setReadChannel (QProcess::StandardError);
            qDebug () << "STDERR" << process->program () << ":\n" << qPrintable (process->readAll ());
        }
        else {
            process->setReadChannel (QProcess::StandardOutput);
            qDebug () << "STDOUT" << process->program () << ":\n" << qPrintable (process->readAll ());
        }
        process->deleteLater ();
    }
    QTimer::singleShot (0, this, SLOT(doTests()));
}

void Qt5WaylandServerFacade::doProcessWaylandEvents () {
    wl_event_loop_dispatch (m_waylandEventLoop, 0);
    wl_display_flush_clients (m_waylandDisplay);
}

/***************************** INTERNAL CALLBACKS FOR LIB-WAYLAND *********************************/

void Qt5WaylandServerFacade::callbackXdgShellBind (wl_client * client, void * data, quint32 version, quint32 id) {
    qDebug () << "SERVER FACADE : XDG SHELL BIND" << id;
    Qt5WaylandXdgShell * qt5xdgShell = (Qt5WaylandXdgShell *) data;
    if (qt5xdgShell != Q_NULLPTR) {
        wl_resource * resXdgShell = wl_resource_create (client,
                                                        &xdg_shell_interface, version,
                                                        id);
        wl_resource_set_implementation (resXdgShell,
                                        &Qt5WaylandXdgShell::waylandInterface,
                                        qt5xdgShell,
                                        Q_NULLPTR);
    }
}

void Qt5WaylandServerFacade::callbackOutputBind (wl_client * client, void * data, quint32 version, quint32 id) {
    qDebug () << "SERVER FACADE : OUTPUT BIND" << id;
    Qt5WaylandOutput * qt5output = (Qt5WaylandOutput *) data;
    if (qt5output != Q_NULLPTR) {
        Qt5WaylandServerFacade * qt5wm = qobject_cast<Qt5WaylandServerFacade *> (qt5output->parent ());
        wl_resource * resOutput = wl_resource_create (client, &wl_output_interface, version, id);
        QScreen * qtScreen = qt5wm->m_desktopWin->screen ();
        qint32 winW = qt5wm->m_desktopWin->width ();
        qint32 winH = qt5wm->m_desktopWin->height ();
        qint32 phyW = (qtScreen->physicalSize ().width () * winW / qtScreen->geometry ().width ());
        qint32 phyH = (qtScreen->physicalSize ().height () * winH / qtScreen->geometry ().height ());
        wl_output_send_geometry (resOutput,
                                 0, 0,
                                 phyW, phyH,
                                 WL_OUTPUT_SUBPIXEL_NONE,
                                 "unknown make", "unknown model",
                                 WL_OUTPUT_TRANSFORM_NORMAL);
        wl_output_send_mode (resOutput,
                             WL_OUTPUT_MODE_CURRENT | WL_OUTPUT_MODE_PREFERRED,
                             winW, winH,
                             qint32 (qtScreen->refreshRate () * 1000));
        //wl_output_send_scale (resOutput, 1);
        //wl_output_send_done (resOutput);
    }
}

void Qt5WaylandServerFacade::callbackCompositorBind (wl_client * client, void * data, quint32 version, quint32 id) {
    qDebug () << "SERVER FACADE : COMPOSITOR BIND" << id;
    Qt5WaylandCompositor * qt5compositor = (Qt5WaylandCompositor *) data;
    if (qt5compositor != Q_NULLPTR) {
        wl_resource * resCompositor = wl_resource_create (client,
                                                          &wl_compositor_interface,
                                                          version,
                                                          id);
        wl_resource_set_implementation (resCompositor,
                                        &Qt5WaylandCompositor::waylandInterface,
                                        qt5compositor,
                                        Q_NULLPTR);
    }
}

void Qt5WaylandServerFacade::callbackRegistryBind (wl_client * client, wl_resource * resource, quint32 name, const char * interface, quint32 version, quint32 id) {
    qDebug () << "SERVER FACADE : REGISTRY BIND" << id;

}

/***************************** PUBLIC API FOR QML *********************************/

void Qt5WaylandServerFacade::moveClient (Qt5WaylandClientWrapper * clientWindowItem, int x, int y) {

}

void Qt5WaylandServerFacade::closeClient (Qt5WaylandClientWrapper * clientWindowItem) {

}

void Qt5WaylandServerFacade::maximizeClient (Qt5WaylandClientWrapper * clientWindowItem) {

}

void Qt5WaylandServerFacade::minimizeClient (Qt5WaylandClientWrapper * clientWindowItem) {

}

/***************************** WAYLAND SHELL-SURFACE *********************************/

const struct xdg_surface_interface Qt5WaylandXdgSurface::waylandInterface = {
    .destroy = &Qt5WaylandXdgSurface::callbackDestroy,
    .set_parent = &Qt5WaylandXdgSurface::callbackSetParent,
    .set_title = &Qt5WaylandXdgSurface::callbackSetTitle,
    .set_app_id = &Qt5WaylandXdgSurface::callbackSetAppId,
    .show_window_menu = &Qt5WaylandXdgSurface::callbackShowWindowMenu,
    .move = &Qt5WaylandXdgSurface::callbackMove,
    .resize = &Qt5WaylandXdgSurface::callbackResize,
    .ack_configure = &Qt5WaylandXdgSurface::callbackAckConfigure,
    .set_window_geometry = &Qt5WaylandXdgSurface::callbackSetWindowGeometry,
    .set_maximized = &Qt5WaylandXdgSurface::callbackSetMaximized,
    .unset_maximized = &Qt5WaylandXdgSurface::callbackUnSetMaximized,
    .set_fullscreen = &Qt5WaylandXdgSurface::callbackSetFullscreen,
    .unset_fullscreen = &Qt5WaylandXdgSurface::callbackUnSetFullscreen,
    .set_minimized = &Qt5WaylandXdgSurface::callbackSetMinimized,
};

void Qt5WaylandXdgSurface::callbackDestroy (wl_client * client, wl_resource * self) {
    qDebug () << "XDG SURFACE : DESTROY";

}

void Qt5WaylandXdgSurface::callbackSetParent (wl_client * client, wl_resource * self, wl_resource * parent) {
    qDebug () << "XDG SURFACE : SET PARENT";

}

void Qt5WaylandXdgSurface::callbackSetAppId (wl_client * client, wl_resource * self, const char * app_id) {
    qDebug () << "XDG SURFACE : SET APP ID" << app_id;

}

void Qt5WaylandXdgSurface::callbackShowWindowMenu (wl_client * client, wl_resource * self, wl_resource * seat, quint32 serial, qint32 x, qint32 y) {
    qDebug () << "XDG SURFACE : SHOW WINDOW MENU" << serial << x << y;

}

void Qt5WaylandXdgSurface::callbackMove (wl_client * client, wl_resource * self, wl_resource * seat, quint32 serial) {
    qDebug () << "XDG SURFACE : MOVE" << serial;

}

void Qt5WaylandXdgSurface::callbackResize (wl_client * client, wl_resource * self, wl_resource * seat, quint32 serial, quint32 edges) {
    qDebug () << "XDG SURFACE : RESIZE" << serial;

}

void Qt5WaylandXdgSurface::callbackAckConfigure (wl_client * client, wl_resource * self, quint32 serial) {
    qDebug () << "XDG SURFACE : ACK CONFIGURE" << serial;

}

void Qt5WaylandXdgSurface::callbackSetWindowGeometry (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 width, qint32 height) {
    qDebug () << "XDG SURFACE : SET WINDOW GEOMETRY" << x << y << width << height;
    Qt5WaylandXdgSurface * qt5xdgSurface = (Qt5WaylandXdgSurface *) wl_resource_get_user_data (self);
    if (qt5xdgSurface != Q_NULLPTR) {
        Qt5WaylandClientWrapper * wrapper = Qt5WaylandClientWrapper::clientSurfacesHash ().value (qt5xdgSurface);
        if (wrapper != Q_NULLPTR) {
            wrapper->setX (x);
            wrapper->setY (y);
            wrapper->setW (width);
            wrapper->setH (height);
        }
    }
}

void Qt5WaylandXdgSurface::callbackSetFullscreen (wl_client * client, wl_resource * self, wl_resource * output) {
    qDebug () << "XDG SURFACE : SET FULLSCREEN";

}

void Qt5WaylandXdgSurface::callbackUnSetFullscreen (wl_client * client, wl_resource * self) {
    qDebug () << "XDG SURFACE : UNSET FULLSCREEN";

}

void Qt5WaylandXdgSurface::callbackSetMaximized (wl_client * client, wl_resource * self) {
    qDebug () << "XDG SURFACE : MAXIMIZE";

}

void Qt5WaylandXdgSurface::callbackUnSetMaximized (wl_client * client, wl_resource * self) {
    qDebug () << "XDG SURFACE : RESTORE";

}

void Qt5WaylandXdgSurface::callbackSetTitle (wl_client * client, wl_resource * self, const char * title) {
    qDebug () << "XDG SURFACE : SET TITLE" << title;
    Qt5WaylandXdgSurface * qt5xdgSurface = (Qt5WaylandXdgSurface *) wl_resource_get_user_data (self);
    if (qt5xdgSurface != Q_NULLPTR) {
        Qt5WaylandClientWrapper * wrapper = Qt5WaylandClientWrapper::clientSurfacesHash ().value (qt5xdgSurface);
        if (wrapper != Q_NULLPTR) {
            wrapper->setTitle (QString::fromUtf8 (title));
        }
    }
}

void Qt5WaylandXdgSurface::callbackSetMinimized (wl_client * client, wl_resource * self) {
    qDebug () << "XDG SURFACE : MINIMIZE";
    Qt5WaylandXdgSurface * qt5xdgSurface = (Qt5WaylandXdgSurface *) wl_resource_get_user_data (self);
    if (qt5xdgSurface != Q_NULLPTR) {
        Qt5WaylandClientWrapper * wrapper = Qt5WaylandClientWrapper::clientSurfacesHash ().value (qt5xdgSurface);
        if (wrapper != Q_NULLPTR) {
            wrapper->setMinimzed (true);
        }
    }
}

/***************************** WAYLAND SURFACE *********************************/

const struct wl_surface_interface Qt5WaylandSurface::waylandInterface = {
    .destroy = &Qt5WaylandSurface::callbackDestroy,
    .attach = &Qt5WaylandSurface::callbackAttachBuffer,
    .damage = &Qt5WaylandSurface::callbackDamage,
    .frame = &Qt5WaylandSurface::callbackFrame,
    .set_opaque_region = &Qt5WaylandSurface::callbackSetOpaqueRegion,
    .set_input_region = &Qt5WaylandSurface::callbackSetInputRegion,
    .commit = &Qt5WaylandSurface::callbackCommitState,
    .set_buffer_transform = &Qt5WaylandSurface::callbackSetBufferTransform,
    .set_buffer_scale = &Qt5WaylandSurface::callbackSetBufferScale
};

void Qt5WaylandSurface::callbackDestroy (wl_client * client, wl_resource * self) {
    qDebug () << "SURFACE : DESTROY";

}

void Qt5WaylandSurface::callbackAttachBuffer (wl_client * client, wl_resource * self, wl_resource * buffer, qint32 x, qint32 y) {
    qDebug () << "SURFACE : ATTACH BUFFER" << x << y;
    Qt5WaylandSurface * qt5surface = (Qt5WaylandSurface *) wl_resource_get_user_data (self);
    if (qt5surface != Q_NULLPTR) {
        wl_shm_buffer * waylandSharedMemBuffer = wl_shm_buffer_get (buffer);
        if (waylandSharedMemBuffer != Q_NULLPTR) {
            qDebug () << "waylandSharedMemBuffer=" << waylandSharedMemBuffer;
            qt5surface->waylandBuffer = waylandSharedMemBuffer;
        }
    }
}

void Qt5WaylandSurface::callbackDamage (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 w, qint32 h) {
    qDebug () << "SURFACE : DAMAGE" << x << y << w << h;

}

void Qt5WaylandSurface::callbackFrame (wl_client * client, wl_resource * self, quint32 callback) {
    qDebug () << "SURFACE : FRAME";

}

void Qt5WaylandSurface::callbackSetOpaqueRegion (wl_client * client, wl_resource * self, wl_resource * region) {
    qDebug () << "SURFACE : SET OPAQUE REGION";

}

void Qt5WaylandSurface::callbackSetInputRegion (wl_client * client, wl_resource * self, wl_resource * region) {
    qDebug () << "SURFACE : SET INPUT REGION";

}

void Qt5WaylandSurface::callbackCommitState (wl_client * client, wl_resource * self) {
    qDebug () << "SURFACE : COMMIT STATE";
    Qt5WaylandSurface * qt5surface = (Qt5WaylandSurface *) wl_resource_get_user_data (self);
    if (qt5surface != Q_NULLPTR) {
        if (qt5surface->waylandBuffer != Q_NULLPTR) {
            wl_shm_buffer_begin_access (qt5surface->waylandBuffer);
            qint32 bufferW = wl_shm_buffer_get_width (qt5surface->waylandBuffer);
            qint32 bufferH = wl_shm_buffer_get_height (qt5surface->waylandBuffer);
            qint32 bufferStride = wl_shm_buffer_get_stride (qt5surface->waylandBuffer);
            quint32 bufferFormat = wl_shm_buffer_get_format (qt5surface->waylandBuffer);
            void * bufferDataPtr = wl_shm_buffer_get_data (qt5surface->waylandBuffer);
            int pixelBytes = 0;
            switch ((wl_shm_format ) (bufferFormat)) {
                case WL_SHM_FORMAT_ARGB8888:
                    pixelBytes = 4;
                    qDebug () << "bufferFormat=ARGB";
                    break;
                case WL_SHM_FORMAT_RGBA8888:
                    qDebug () << "bufferFormat=RGBA";
                    pixelBytes = 4;
                    break;
                case WL_SHM_FORMAT_XRGB8888:
                    qDebug () << "bufferFormat=XRGB";
                    pixelBytes = 4;
                    break;
                default:
                    break;
            }
            const int bufferLen = (bufferH * bufferStride);
            qt5surface->pixelsBuffer.resize (bufferLen);
            memcpy (qt5surface->pixelsBuffer.data (), bufferDataPtr, bufferLen);
            wl_shm_buffer_end_access (qt5surface->waylandBuffer);
            QImage img (QSize (bufferW, bufferH), QImage::Format_ARGB32);
            memcpy (img.bits (), qt5surface->pixelsBuffer.data (), qt5surface->pixelsBuffer.size ());
            img.save ("test.png");
        }
    }
}

void Qt5WaylandSurface::callbackSetBufferTransform (wl_client * client, wl_resource * self, qint32 transform) {
    qDebug () << "SURFACE : SET BUFFER TRANSFORM" << transform;

}

void Qt5WaylandSurface::callbackSetBufferScale (wl_client * client, wl_resource * self, qint32 transform) {
    qDebug () << "SURFACE : SET BUFFER SCALE" << transform;

}

void Qt5WaylandSurface::waylandResourceDestructor (wl_resource * self) {
    qDebug () << "SURFACE : DESTRUCTOR";
    Qt5WaylandSurface * qt5surface = (Qt5WaylandSurface *) wl_resource_get_user_data (self);
    if (qt5surface != Q_NULLPTR) {
        qt5surface->deleteLater ();
    }
}

/*************************************** WAYLAND SHELL *****************************************/

const struct xdg_shell_interface Qt5WaylandXdgShell::waylandInterface = {
    .destroy = &Qt5WaylandXdgShell::callbackDestroy,
    .use_unstable_version = &Qt5WaylandXdgShell::callbackUseUnstableVersion,
    .get_xdg_surface = &Qt5WaylandXdgShell::callbackGetXdgSurface,
    .get_xdg_popup = &Qt5WaylandXdgShell::callbackGetXdgPopup,
    .pong = &Qt5WaylandXdgShell::callbackPong,
};

void Qt5WaylandXdgShell::callbackDestroy (wl_client * client, wl_resource * self) {
    qDebug () << "XDG SHELL : DESTROY";

}

void Qt5WaylandXdgShell::callbackUseUnstableVersion (wl_client * client, wl_resource * self, qint32 version) {
    qDebug () << "XDG SHELL : USE UNSTABLE VERSION" << version;

}

void Qt5WaylandXdgShell::callbackGetXdgSurface (wl_client * client, wl_resource * self, quint32 id, wl_resource * surface) {
    qDebug () << "XDG SHELL : GET XDG SURFACE" << id;
    Qt5WaylandXdgShell * qt5xdgShell = (Qt5WaylandXdgShell *) wl_resource_get_user_data (self);
    if (qt5xdgShell != Q_NULLPTR) {
        Qt5WaylandServerFacade * qt5wm = qobject_cast<Qt5WaylandServerFacade *> (qt5xdgShell->parent ());
        wl_resource * resShellSurface = wl_resource_create (client,
                                                            &xdg_surface_interface, 1,
                                                            id);
        wl_surface * waylandSurface = (wl_surface *) wl_resource_get_user_data (surface);
        Qt5WaylandXdgSurface * qt5xdgSurface = new Qt5WaylandXdgSurface (qt5xdgShell);
        wl_resource_set_implementation (resShellSurface,
                                        &Qt5WaylandXdgSurface::waylandInterface,
                                        qt5xdgSurface,
                                        Q_NULLPTR);
        Qt5WaylandClientWrapper * clientWrapper = new Qt5WaylandClientWrapper (qt5xdgSurface);
        clientWrapper->setX (50);
        clientWrapper->setY (50);
        clientWrapper->setZ (1);
        clientWrapper->setW (640);
        clientWrapper->setH (480);
        wl_array statesArray;
        wl_array_init (&statesArray);
        QVector<quint32> statesVec;
        statesVec << XDG_SURFACE_STATE_MAXIMIZED << XDG_SURFACE_STATE_ACTIVATED;
        foreach (quint32 currState, statesVec) {
            quint32 * ptrState = (quint32 *) wl_array_add (&statesArray, sizeof (currState));
            *ptrState = currState;
        }
        xdg_surface_send_configure (resShellSurface,
                                    clientWrapper->getW (),
                                    clientWrapper->getH (),
                                    &statesArray,
                                    wl_display_next_serial (qt5wm->m_waylandDisplay));
        wl_array_release (&statesArray);
        emit qt5wm->clientAdded (clientWrapper);
    }
}

void Qt5WaylandXdgShell::callbackGetXdgPopup (wl_client * client, wl_resource * self, quint32 id, wl_resource * surface, wl_resource * parent, wl_resource * seat, quint32 serial, qint32 x, qint32 y) {
    qDebug () << "XDG SHELL : GET XDG POPUP" << x << y;

}

void Qt5WaylandXdgShell::callbackPong (wl_client * client, wl_resource * self, quint32 serial) {
    qDebug () << "XDG SHELL : PONG" << serial;

}

/****************************** WAYLAND COMPOSITOR *****************************/

const struct wl_compositor_interface Qt5WaylandCompositor::waylandInterface = {
    .create_surface = &Qt5WaylandCompositor::callbackCreateSurface,
    .create_region = &Qt5WaylandCompositor::callbackCreateRegion,
};

void Qt5WaylandCompositor::callbackCreateRegion (wl_client * client, wl_resource * self, quint32 id) {
    qDebug () << "COMPOSITOR : CREATE REGION :" << id;
    Qt5WaylandCompositor * qt5compositor = (Qt5WaylandCompositor *) wl_resource_get_user_data (self);
    wl_resource * resRegion = wl_resource_create (client,
                                                  &wl_region_interface, 3,
                                                  id);
    wl_resource_set_implementation (resRegion,
                                    &Qt5WaylandRegion::waylandInterface,
                                    new Qt5WaylandRegion (qt5compositor),
                                    Q_NULLPTR);
}

void Qt5WaylandCompositor::callbackCreateSurface (wl_client * client, wl_resource * self, quint32 id) {
    qDebug () << "COMPOSITOR : CREATE SURFACE :" << id;
    Qt5WaylandCompositor * qt5compositor = (Qt5WaylandCompositor *) wl_resource_get_user_data (self);
    wl_resource * resSurface = wl_resource_create (client,
                                                   &wl_surface_interface, 3,
                                                   id);
    Qt5WaylandSurface * qt5surface = new Qt5WaylandSurface (qt5compositor);
    wl_resource_set_implementation (resSurface,
                                    &Qt5WaylandSurface::waylandInterface,
                                    qt5surface,
                                    Q_NULLPTR);
    wl_resource_set_destructor (resSurface, &Qt5WaylandSurface::waylandResourceDestructor);
}

/****************************** WAYLAND REGION *******************************/

const struct wl_region_interface Qt5WaylandRegion::waylandInterface = {
    .destroy = &Qt5WaylandRegion::callbackDestroy,
    .add = &Qt5WaylandRegion::callbackAdd,
    .subtract = &Qt5WaylandRegion::callbackSubstract,
};

void Qt5WaylandRegion::callbackDestroy (wl_client * client, wl_resource * self) {
    qDebug () << "REGION : DESTROY";
    Q_UNUSED (client);
    Qt5WaylandRegion * qt5region = (Qt5WaylandRegion *) wl_resource_get_user_data (self);
    if (qt5region != Q_NULLPTR) {
        delete qt5region;
        wl_resource_set_user_data (self, Q_NULLPTR);
    }
    wl_resource_destroy (self);
}

void Qt5WaylandRegion::callbackAdd (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 w, qint32 h) {
    qDebug () << "REGION : ADD" << x << y << w << h;
    Q_UNUSED (client);
    Qt5WaylandRegion * qt5region = (Qt5WaylandRegion *) wl_resource_get_user_data (self);
    if (qt5region != Q_NULLPTR) {
        qt5region->m_qtRegion = qt5region->m_qtRegion.united (QRect (x, y, w, h));
    }
}

void Qt5WaylandRegion::callbackSubstract (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 w, qint32 h) {
    qDebug () << "REGION : SUBSTRACT" << x << y << w << h;
    Q_UNUSED (client);
    Qt5WaylandRegion * qt5region = (Qt5WaylandRegion *) wl_resource_get_user_data (self);
    if (qt5region != Q_NULLPTR) {
        qt5region->m_qtRegion = qt5region->m_qtRegion.subtracted (QRect (x, y, w, h));
    }
}

/************************** WAYLAND OUTPUT *************************/

//const struct wl_output_interface Qt5WaylandOutput::waylandInterface = {};
