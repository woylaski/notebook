#include "filefs.h"

void get_fileinfo(QUrl *file)
{
    if (file->isLocalFile()) {
        QFileInfo fi(file->toLocalFile());
    }
}

QUrl *select_file(void)
{
    QUrl *file=NULL;
#if defined(QT_WIDGETS_LIB) && !defined(QT_NO_FILEDIALOG)
    QString fileName = QFileDialog::getOpenFileName(0, "Open QML file", QString(), "QML Files (*.qml)");
    if (!fileName.isEmpty()) {
        QFileInfo fi(fileName);
        *file = QUrl::fromLocalFile(fi.canonicalFilePath());
    }
#else
    Q_UNUSED(file);
    puts("No filename specified...");
#endif

    return file;
}

static void loadDummyDataFiles(QQmlEngine &engine, const QString& directory)
{
    QDir dir(directory+"/dummydata", "*.qml");
    QStringList list = dir.entryList();
    for (int i = 0; i < list.size(); ++i) {
        QString qml = list.at(i);
        QQmlComponent comp(&engine, dir.filePath(qml));
        QObject *dummyData = comp.create();

        if(comp.isError()) {
            QList<QQmlError> errors = comp.errors();
            foreach (const QQmlError &error, errors)
                fprintf(stderr, "%s\n", qPrintable(error.toString()));
        }

        if (dummyData) {
            fprintf(stderr, "Loaded dummy data: %s\n", qPrintable(dir.filePath(qml)));
            qml.truncate(qml.length()-4);
            engine.rootContext()->setContextProperty(qml, dummyData);
            dummyData->setParent(&engine);
        }
    }
}
