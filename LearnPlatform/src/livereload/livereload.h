#ifndef LIVERELOAD_H
#define LIVERELOAD_H

#include <QtCore/qabstractanimation.h>
#include <QtCore/qdir.h>
#include <QtCore/qmath.h>
#include <QtCore/qdatetime.h>
#include <QtCore/qpointer.h>
#include <QtCore/qscopedpointer.h>
#include <QtCore/qtextstream.h>

#include <QtGui/QGuiApplication>

#include <QtQml/qqml.h>
#include <QtQml/qqmlengine.h>
#include <QtQml/qqmlcomponent.h>
#include <QtQml/qqmlcontext.h>

#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#ifdef QT_WIDGETS_LIB
#include <QtWidgets/QApplication>
#include <QtWidgets/QFileDialog>
#endif

#include <QtCore/QTranslator>
#include <QtCore/QLibraryInfo>

#include <QThread>
#include <QFileSystemWatcher>

#include <QQmlApplicationEngine>

class LiveReload: public QObject{
    Q_OBJECT
public:
    LiveReload(QQmlEngine * engine_handler
               , QQuickView* qxView, QPointer<QQmlComponent> component
               ,  QUrl afile
               );
private:
    QUrl file;
    QFileSystemWatcher watcher;
    QQmlEngine *engine_handler;
    QQuickView* qxView;
    QPointer<QQmlComponent> component;
    QQuickWindow * window;
private slots:
    void fileChanged(const QString & path);
};

#endif // LIVERELOAD_H

