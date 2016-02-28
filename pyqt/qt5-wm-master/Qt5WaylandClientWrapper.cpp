
#include "Qt5WaylandClientWrapper.h"
#include "Qt5WaylandServerFacade.h"

Qt5WaylandClientWrapper::Qt5WaylandClientWrapper (Qt5WaylandXdgSurface * surface, QObject * parent) : QObject (parent) {
    m_surface = surface;
    m_x = m_y = m_z = m_w = m_h = 0;
    m_decorated = m_minimized = m_current = false;
    m_decorated = true;
    clientSurfacesHash ().insert (m_surface, this);
}

void Qt5WaylandClientWrapper::setX (int x) {
    if (m_x != x) {
        m_x = x;
        emit xChanged (x);
    }
}

void Qt5WaylandClientWrapper::setY (int y) {
    if (m_y != y) {
        m_y = y;
        emit yChanged (y);
    }
}

void Qt5WaylandClientWrapper::setZ (int z) {
    if (m_z != z) {
        m_z = z;
        emit zChanged (z);
    }
}

void Qt5WaylandClientWrapper::setW (int w) {
    if (m_w != w) {
        m_w = w;
        emit wChanged (w);
    }
}

void Qt5WaylandClientWrapper::setH (int h) {
    if (m_h != h) {
        m_h = h;
        emit hChanged (h);
    }
}

void Qt5WaylandClientWrapper::setTitle (QString title) {
    if (m_title != title) {
        m_title = title;
        emit titleChanged (title);
    }
}

void Qt5WaylandClientWrapper::setCurrent (bool current) {
    if (m_current != current) {
        m_current = current;
        emit currentChanged (current);
    }
}

void Qt5WaylandClientWrapper::setMinimzed (bool minimized) {
    if (m_minimized != minimized) {
        m_minimized = minimized;
        emit minimizedChanged (minimized);
    }
}

void Qt5WaylandClientWrapper::setDecorated (bool decorated) {
    if (m_decorated != decorated) {
        m_decorated = decorated;
        emit decoratedChanged (decorated);
    }
}

void Qt5WaylandClientWrapper::setIcon (QString icon) {
    if (m_icon != icon) {
        m_icon = icon;
        emit iconChanged (icon);
    }
}
