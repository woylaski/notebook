
#include "TextFileHelper.h"

TextFileHelper::TextFileHelper (QObject * parent)
    : QObject (parent)
{

}

QString TextFileHelper::read (QString filePath) {
    QString ret;
    QFile file (filePath);
    if (file.open (QFile::ReadOnly)) {
        ret = QString::fromUtf8 (file.readAll ());
    }
    return ret;
}

void TextFileHelper::write (QString filePath, QString content) {
    QFile file (filePath);
    if (file.open (QFile::WriteOnly)) {
        file.write (content.toUtf8 ());
        file.flush ();
        file.close ();
    }
}
