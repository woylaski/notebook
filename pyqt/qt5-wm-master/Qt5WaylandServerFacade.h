#ifndef QT5WAYLANDCOMPOSITORFACADE_H
#define QT5WAYLANDCOMPOSITORFACADE_H

#include "defs.h"

class Qt5WaylandOutput : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandOutput (QObject * parent = Q_NULLPTR) : QObject (parent) { }

    //static const struct wl_output_interface waylandInterface;

private:

};

class Qt5WaylandRegion : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandRegion (QObject * parent = Q_NULLPTR) : QObject (parent) { }

    static void callbackDestroy (wl_client * client, wl_resource * self);
    static void callbackAdd (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 w, qint32 h);
    static void callbackSubstract (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 w, qint32 h);
    static const struct wl_region_interface waylandInterface;

private:
    QRegion m_qtRegion;
};

class Qt5WaylandCompositor : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandCompositor (QObject * parent = Q_NULLPTR) : QObject (parent) { }

    static void callbackCreateRegion (wl_client * client, wl_resource * resource, quint32 id);
    static void callbackCreateSurface (wl_client * client, wl_resource * resource, quint32 id);
    static const struct wl_compositor_interface waylandInterface;

private:

};

class Qt5WaylandXdgShell : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandXdgShell (QObject * parent = Q_NULLPTR) : QObject (parent) { }

    static void callbackDestroy (wl_client * client, wl_resource * self);
    static void callbackUseUnstableVersion (wl_client * client, wl_resource * self, qint32 version);
    static void callbackGetXdgSurface (wl_client * client, wl_resource * self, quint32 id, wl_resource * surface);
    static void callbackGetXdgPopup (wl_client * client, wl_resource * self, quint32 id, wl_resource * surface, wl_resource * parent, wl_resource * seat, quint32 serial, qint32 x, qint32 y);
    static void callbackPong (wl_client * client, wl_resource * self, quint32 serial);

    static const struct xdg_shell_interface waylandInterface;

private:

};

class Qt5WaylandXdgSurface : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandXdgSurface (QObject * parent = Q_NULLPTR) : QObject (parent) { }

    static void callbackMove (wl_client * client, wl_resource * self, wl_resource * seat, quint32 serial);
    static void callbackResize (wl_client * client, wl_resource * self, wl_resource * seat, quint32 serial, quint32 edges);
    static void callbackSetTitle (wl_client * client, wl_resource * self, const char * title);
    static void callbackDestroy (wl_client * client, wl_resource * self);
    static void callbackSetParent (wl_client * client, wl_resource * self, wl_resource * parent);
    static void callbackSetAppId (wl_client * client, wl_resource * self, const char * app_id);
    static void callbackShowWindowMenu (wl_client * client, wl_resource * self, wl_resource * seat, quint32 serial, qint32 x, qint32 y);
    static void callbackAckConfigure (wl_client * client, wl_resource * self, quint32 serial);
    static void callbackSetWindowGeometry (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 width, qint32 height);
    static void callbackSetFullscreen (wl_client * client, wl_resource * self, wl_resource * output);
    static void callbackUnSetFullscreen (wl_client * client, wl_resource * self);
    static void callbackSetMaximized (wl_client * client, wl_resource * self);
    static void callbackUnSetMaximized (wl_client * client, wl_resource * self);
    static void callbackSetMinimized (wl_client * client, wl_resource * self);

    static const struct xdg_surface_interface waylandInterface;

private:

};

class Qt5WaylandSurface : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandSurface (QObject * parent = Q_NULLPTR) : QObject (parent), waylandBuffer (Q_NULLPTR) { }

    static void callbackDestroy (wl_client * client, wl_resource * self);
    static void callbackAttachBuffer (wl_client * client, wl_resource * self, wl_resource * buffer, qint32 x, qint32 y);
    static void callbackDamage (wl_client * client, wl_resource * self, qint32 x, qint32 y, qint32 w, qint32 h);
    static void callbackFrame (wl_client * client, wl_resource * self, quint32 callback);
    static void callbackSetOpaqueRegion (wl_client * client, wl_resource * self, wl_resource * region);
    static void callbackSetInputRegion (wl_client * client, wl_resource * self, wl_resource * region);
    static void callbackCommitState (wl_client * client, wl_resource * self);
    static void callbackSetBufferTransform (wl_client * client, wl_resource * self, qint32 transform);
    static void callbackSetBufferScale (wl_client * client, wl_resource * self, qint32 transform);
    static void waylandResourceDestructor (wl_resource * self);
    static const struct wl_surface_interface waylandInterface;

private:
    wl_shm_buffer * waylandBuffer;
    QByteArray pixelsBuffer;

    friend class Qt5WaylandCompositor;
};

class Qt5WaylandServerFacade : public QObject {
    Q_OBJECT

public:
    explicit Qt5WaylandServerFacade (QObject * parent = Q_NULLPTR);

    static void callbackCompositorBind (wl_client * client, void * data, quint32 version, quint32 id);
    static void callbackRegistryBind (wl_client * client, wl_resource * resource, quint32 name, const char * interface, quint32 version, quint32 id);
    static void callbackOutputBind (wl_client * client, void * data, quint32 version, quint32 id);
    static void callbackXdgShellBind (wl_client * client, void * data, quint32 version, quint32 id);

public slots:
    void init (QObject * desktopWindow);
    void moveClient (Qt5WaylandClientWrapper * clientWindowItem, int x, int y);
    void closeClient (Qt5WaylandClientWrapper * clientWindowItem);
    void maximizeClient (Qt5WaylandClientWrapper * clientWindowItem);
    void minimizeClient (Qt5WaylandClientWrapper * clientWindowItem);

signals:
    void clientAdded   (Qt5WaylandClientWrapper * clientWindowItem);
    void clientRemoved (Qt5WaylandClientWrapper * clientWindowItem);

protected slots:
    void doTests (void);
    void doProcessWaylandEvents (void);

private slots:
    void onTestFinished (void);

private:
    static const QByteArray & s_waylandName;

    int m_waylandFd;
    wl_global * m_waylandGlobalCompositor;
    wl_global * m_waylandGlobalXdgShell;
    wl_global * m_waylandGlobalOutput;
    wl_display * m_waylandDisplay;
    wl_event_loop * m_waylandEventLoop;
    wl_shm * m_waylandSharedMem;
    QWindow * m_desktopWin;
    QSocketNotifier * m_notifier;

    friend class Qt5WaylandOutput;
    friend class Qt5WaylandSurface;
    friend class Qt5WaylandCompositor;
    friend class Qt5WaylandXdgShell;
    friend class Qt5WaylandXdgSurface;
};

#endif // QT5WAYLANDCOMPOSITORFACADE_H
