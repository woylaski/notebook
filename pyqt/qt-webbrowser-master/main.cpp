
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QOpenGLContext>

// QWebEngine needs a shared context in order for the GPU thread to upload textures.
#include <private/qopenglcontext_p.h>

int main (int argc, char * argv []) {
    QGuiApplication app (argc, argv);
    QOpenGLContext * shareContext = new QOpenGLContext (&app);
    shareContext->create();
    qt_gl_set_global_share_context (shareContext);
    QQmlApplicationEngine engine (QUrl ("qrc:/ui.qml"), &app);
    Q_UNUSED (engine)
    return app.exec ();
}
