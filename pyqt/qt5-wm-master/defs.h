#ifndef QT5WM_DEFS
#define QT5WM_DEFS

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QDir>
#include <QVariant>
#include <QRect>
#include <QTimer>
#include <QWindow>
#include <QScreen>
#include <QByteArray>
#include <QBuffer>
#include <QPixmap>
#include <QStringBuilder>
#include <QSocketNotifier>
#include <QTimer>
#include <QPainter>
#include <QMouseEvent>
#include <QQmlContext>
#include <QQuickItem>
#include <QQuickView>
#include <QProcess>
#include <QProcessEnvironment>
#include <QDebug>
#include <qqml.h>
#include <qmath.h>

#include <wayland-server.h>
#include <wayland-server-protocol.h>

#include "xdg-shell-server-protocol.h"

class Qt5WaylandServerFacade;
class Qt5WaylandClientWrapper;

inline QString getPixmapAsURI (QPixmap & pixmap) {
    QString ret;
    if (!pixmap.isNull ()) {
        QByteArray bytes;
        QBuffer buffer (&bytes);
        pixmap.save (&buffer, "PNG", 0);
        ret = QString (QStringLiteral ("data:image/png;base64,") % QString::fromLocal8Bit (bytes.toBase64 ()));
    }
    return ret;
}

#endif // QT5WM_DEFS

