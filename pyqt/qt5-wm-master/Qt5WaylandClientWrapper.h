#ifndef QT5WAYLANDCLIENTWRAPPER_H
#define QT5WAYLANDCLIENTWRAPPER_H

#include "defs.h"

class Qt5WaylandXdgSurface;

class Qt5WaylandClientWrapper : public QObject {
    Q_OBJECT
    Q_PROPERTY (int x READ getX WRITE setX NOTIFY xChanged)
    Q_PROPERTY (int y READ getY WRITE setY NOTIFY yChanged)
    Q_PROPERTY (int z READ getZ WRITE setZ NOTIFY zChanged)
    Q_PROPERTY (int w READ getW WRITE setW NOTIFY wChanged)
    Q_PROPERTY (int h READ getH WRITE setH NOTIFY hChanged)
    Q_PROPERTY (bool current READ isCurrent WRITE setCurrent NOTIFY currentChanged)
    Q_PROPERTY (bool minimized READ isMinimized WRITE setMinimzed NOTIFY minimizedChanged)
    Q_PROPERTY (bool decorated READ isDecorated WRITE setDecorated NOTIFY decoratedChanged)
    Q_PROPERTY (QString title READ getTitle WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY (QString icon READ getIcon WRITE setIcon NOTIFY iconChanged)
    //Q_PROPERTY (QWaylandQuickSurface * surface READ getSurface CONSTANT)
    //Q_PROPERTY (QWaylandSurfaceItem * item READ getItem CONSTANT)

public:
    explicit Qt5WaylandClientWrapper (Qt5WaylandXdgSurface * surface = Q_NULLPTR, QObject * parent = Q_NULLPTR);

    static QHash<Qt5WaylandXdgSurface *, Qt5WaylandClientWrapper *> & clientSurfacesHash (void) {
        static QHash<Qt5WaylandXdgSurface *, Qt5WaylandClientWrapper *> ret;
        return ret;
    }

    int getX (void) const { return m_x; }
    int getY (void) const { return m_y; }
    int getZ (void) const { return m_z; }
    int getW (void) const { return m_w; }
    int getH (void) const { return m_h; }
    bool isCurrent (void) const { return m_current; }
    bool isMinimized (void) const { return m_minimized; }
    bool isDecorated (void) const { return m_decorated; }
    QString getTitle (void) const { return m_title; }
    QString getIcon (void) const { return m_icon; }
    //QWaylandQuickSurface * getSurface (void) const { return m_surface; }
    //QWaylandSurfaceItem * getItem (void) const { return static_cast<QWaylandSurfaceItem *> (m_surface->views ().first ()); }

public slots:
    void setX (int x);
    void setY (int y);
    void setZ (int z);
    void setW (int w);
    void setH (int h);
    void setTitle (QString title);
    void setCurrent (bool current);
    void setMinimzed (bool minimized);
    void setDecorated (bool decorated);
    void setIcon (QString icon);

signals:
    void xChanged (int x);
    void yChanged (int y);
    void zChanged (int z);
    void wChanged (int w);
    void hChanged (int h);
    void currentChanged (bool current);
    void minimizedChanged (bool minimized);
    void decoratedChanged (bool decorated);
    void titleChanged (QString title);
    void iconChanged (QString icon);

private:
    int m_x, m_y, m_z, m_w, m_h;
    bool m_current, m_decorated, m_minimized;
    QString m_title, m_icon;
    Qt5WaylandXdgSurface * m_surface;
};

#endif // QT5WAYLANDCLIENTWRAPPER_H
