#include "livereload.h"

QQuickWindow * createWindow(QQmlEngine * engine_handler
                  , QQuickView* qxView, QPointer<QQmlComponent> component
                  , QUrl file
                  , QQuickWindow * window = NULL
                  )
{

//	if ( !component->isReady() ) {
//		fprintf(stderr, "%s\n", qPrintable(component->errorString()));
//		return -1;
//	}

    QObject *topLevel = component->create();
//	if (!topLevel && component->isError()) {
//		fprintf(stderr, "%s\n", qPrintable(component->errorString()));
//		return -1;
//	}

    QQuickWindow * r_window;

    //Oh scoped pointer
//	QScopedPointer<QQuickWindow> window(qobject_cast<QQuickWindow *>(topLevel));
//	if (NULL == window) window = qobject_cast<QQuickWindow *>(topLevel);
    if (window) {
        window->close();
    };
    window = qobject_cast<QQuickWindow *>(topLevel);
    r_window = window;
    qDebug() << r_window << window;


    if (window) {
#ifdef USE_ApplicationEngine
        delete(window);
        engine_handler = new QQmlApplicationEngine();
        qobject_cast<QQmlApplicationEngine *>(engine_handler)->load(file);
        qobject_cast<QQuickWindow *>(qobject_cast<QQmlApplicationEngine *>(engine_handler)->rootObjects().value(0))->show();
        return engine_handler;
#else
        engine_handler->setIncubationController(window->incubationController());
#endif
    } else {
        QQuickItem *contentItem = qobject_cast<QQuickItem *>(topLevel);
        if (contentItem) {
            //QQuickView* qxView = new QQuickView(&engine, NULL);
//			window.reset(qxView);
            window = qobject_cast<QQuickWindow *>(qxView);
            // Set window default properties; the qml can still override them
            QString oname = contentItem->objectName();
            window->setTitle(oname.isEmpty() ? QString::fromLatin1("QmlLive") : QString::fromLatin1("QmlLive: ") + oname);
            //if (options.resizeViewToRootItem)
            //    qxView->setResizeMode(QQuickView::SizeViewToRootObject);
            //else
            //    qxView->setResizeMode(QQuickView::SizeRootObjectToView);
            qxView->setResizeMode(QQuickView::SizeRootObjectToView);
            qxView->setContent(file, component, contentItem);
        }
    }

#if 0
    if (window) {
        QSurfaceFormat surfaceFormat = window->requestedFormat();
        if (options.multisample)
            surfaceFormat.setSamples(16);
        if (options.transparent) {
            surfaceFormat.setAlphaBufferSize(8);
            window->setClearBeforeRendering(true);
            window->setColor(QColor(Qt::transparent));
            window->setFlags(Qt::FramelessWindowHint);
        }
        window->setFormat(surfaceFormat);

        if (window->flags() == Qt::Window) // Fix window flags unless set by QML.
            window->setFlags(Qt::Window | Qt::WindowSystemMenuHint | Qt::WindowTitleHint | Qt::WindowMinMaxButtonsHint | Qt::WindowCloseButtonHint | Qt::WindowFullscreenButtonHint);

        if (options.fullscreen)
            window->showFullScreen();
        else if (options.maximized)
            window->showMaximized();
        else if (!window->isVisible())
            window->show();
    }
#endif

    return r_window;
}

LiveReload::LiveReload(QQmlEngine * a_engine_handler
                       , QQuickView* a_qxView, QPointer<QQmlComponent> a_component
                       , QUrl a_file
                       ):QObject()
{

    engine_handler = a_engine_handler;
    qxView = a_qxView;
    component = a_component;
    file = a_file;

//#ifdef USE_ApplicationEngine
//	engine_handler = qobject_cast<QQmlApplicationEngine *>(createWindow(engine_handler, qxView, component, options));
//#else
    window = createWindow(engine_handler, qxView, component, a_file);
//#endif

    QFileInfo fi(file.toLocalFile());
    watcher.addPath(fi.path());
    watcher.addPath(fi.filePath());

    connect(&watcher, SIGNAL(directoryChanged(const QString &)),
      this, SLOT(fileChanged(const QString &)));
    connect(&watcher, SIGNAL(fileChanged(const QString &)),
      this, SLOT(fileChanged(const QString &)));
}

void LiveReload::fileChanged(const QString & path)
{
    qDebug() << "file changed: " << path;

    engine_handler->clearComponentCache();
    QThread::msleep(50);
#ifdef USE_ApplicationEngine
    qobject_cast<QQmlApplicationEngine *>(engine_handler)->load(file);
    qobject_cast<QQuickWindow *>(qobject_cast<QQmlApplicationEngine *>(engine_handler)->rootObjects().value(0))->show();
#else
    component = new QQmlComponent(engine_handler);
    component->loadUrl(file);
    window = createWindow(engine_handler, qxView, component, file, window);
#endif
}

static bool checkVersion(const QUrl &url)
{
    if (!qgetenv("QMLSCENE_IMPORT_NAME").isEmpty())
        fprintf(stderr, "QMLSCENE_IMPORT_NAME is no longer supported.\n");

    QString fileName = url.toLocalFile();
    if (fileName.isEmpty()) {
        fprintf(stderr, "qmlscene: filename required.\n");
        return false;
    }

    QFile f(fileName);
    if (!f.open(QFile::ReadOnly | QFile::Text)) {
        fprintf(stderr, "qmlscene: failed to check version of file '%s', could not open...\n",
                 qPrintable(fileName));
        return false;
    }

    QRegExp quick1("^\\s*import +QtQuick +1\\.\\w*");
    QRegExp qt47("^\\s*import +Qt +4\\.7");

    QTextStream stream(&f);
    bool codeFound= false;
    while (!codeFound) {
        QString line = stream.readLine();
        if (line.contains("{")) {
            codeFound = true;
        } else {
            QString import;
            if (quick1.indexIn(line) >= 0)
                import = quick1.cap(0).trimmed();
            else if (qt47.indexIn(line) >= 0)
                import = qt47.cap(0).trimmed();

            if (!import.isNull()) {
                fprintf(stderr, "qmlscene: '%s' is no longer supported.\n"
                         "Use qmlviewer to load file '%s'.\n",
                         qPrintable(import),
                         qPrintable(fileName));
                return false;
            }
        }
    }

    return true;
}



