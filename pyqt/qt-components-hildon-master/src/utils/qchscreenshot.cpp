/*
 * Copyright (C) 2016 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "qchscreenshot.h"
#include <QFile>
#include <QApplication>
#include <QDesktopWidget>
#include <QPainter>
#include <QGraphicsObject>
#include <QStyleOptionGraphicsItem>
#include <QDeclarativeInfo>

class QchScreenShotPrivate
{

public:
    QchScreenShotPrivate(QchScreenShot *parent) :
        q_ptr(parent),
        target(0),
        overwrite(false),
        smooth(false),
        width(-1),
        height(-1),
        targetX(0),
        targetY(0),
        targetWidth(-1),
        targetHeight(-1)
    {
    }
    
    QString getFileName() {
        if (overwrite) {
            return fileName;
        }

        QString name = fileName.remove(QRegExp("\\(\\d+\\)(?=(\\.\\w+|$))"));

        if (!name.contains(QRegExp("\\.\\w{3,4}$"))) {
            name.append(".png");
        }

        int i = 1;

        while ((QFile::exists(name)) && (i < 100)) {
            int lastDot = fileName.lastIndexOf('.');
            name = QString("%1(%2)%3").arg(fileName.left(lastDot)).arg(i).arg(fileName.mid(lastDot));
            i++;
        }

        return name;
    }

    QchScreenShot *q_ptr;

    QObject *target;

    QString fileName;

    bool overwrite;

    bool smooth;

    int width;
    int height;

    int targetX;
    int targetY;
    int targetWidth;
    int targetHeight;

    QPixmap pixmap;

    Q_DECLARE_PUBLIC(QchScreenShot)
};

/*!
    \class ScreenShot
    \brief Grabs an snapshot from the screen and saves it to a file.
    
    \ingroup utils
    
    \include screenshot.qml
*/
QchScreenShot::QchScreenShot(QObject *parent) :
    QObject(parent),
    d_ptr(new QchScreenShotPrivate(this))
{
}

QchScreenShot::QchScreenShot(QchScreenShotPrivate &dd, QObject *parent) :
    QObject(parent),
    d_ptr(&dd)
{
}

QchScreenShot::~QchScreenShot() {}

/*!
    \brief The item of which a screen shot will be saved.
    
    The default value is \c null, meaning the screen shot will be of the entire screen.
*/
QObject* QchScreenShot::target() const {
    Q_D(const QchScreenShot);
    return d->target;
}

void QchScreenShot::setTarget(QObject *obj) {
    if (obj != target()) {
        Q_D(QchScreenShot);
        d->target = obj;
        emit targetChanged();
    }
}

void QchScreenShot::resetTarget() {
    setTarget(0);
}

/*!
    \brief The file to which the screen shot will be saved.
*/
QString QchScreenShot::fileName() const {
    Q_D(const QchScreenShot);
    return d->fileName;
}

void QchScreenShot::setFileName(const QString &name) {
    if (name != fileName()) {
        Q_D(QchScreenShot);
        d->fileName = name;
        emit fileNameChanged();
    }
}

/*!
    \brief Whether an existing file will be overwritten when a screen shot is saved.
    
    The default value is false, meaning that the screen shot will be saved to a file with "($NUMBER)" inserted before 
    the file suffix.
*/
bool QchScreenShot::overwriteExistingFile() const {
    Q_D(const QchScreenShot);
    return d->overwrite;
}

void QchScreenShot::setOverwriteExistingFile(bool o) {
    if (o != overwriteExistingFile()) {
        Q_D(QchScreenShot);
        d->overwrite = o;
        emit overwriteExistingFileChanged();
    }
}

/*!
    \brief Whether smooth scaling should be used when saving the screen shot.
    
    \sa width, height
*/
bool QchScreenShot::smooth() const {
    Q_D(const QchScreenShot);
    return d->smooth;
}

void QchScreenShot::setSmooth(bool s) {
    if (s != smooth()) {
        Q_D(QchScreenShot);
        d->smooth = s;
        emit smoothChanged();
    }
}

/*!
    \brief The width to be used when scaling the screen shot.
    
    By default, the screen shot is not scaled.
    
    \sa height, smooth
*/
int QchScreenShot::width() const {
    Q_D(const QchScreenShot);
    return d->width;
}

void QchScreenShot::setWidth(int w) {
    if (w != width()) {
        Q_D(QchScreenShot);
        d->width = w;
        emit widthChanged();
    }
}

void QchScreenShot::resetWidth() {
    setWidth(-1);
}

/*!
    \brief The height to be used when scaling the screen shot.
    
    By default, the screen shot is not scaled.
    
    \sa width, smooth
*/
int QchScreenShot::height() const {
    Q_D(const QchScreenShot);
    return d->height;
}

void QchScreenShot::setHeight(int h) {
    if (h != height()) {
        Q_D(QchScreenShot);
        d->height = h;
        emit heightChanged();
    }
}

void QchScreenShot::resetHeight() {
    setHeight(-1);
}

/*!
    \brief The x coordinate from where the screen shot will be taken.
    
    The default value is 0.
    
    \sa targetX
*/
int QchScreenShot::targetX() const {
    Q_D(const QchScreenShot);
    return d->targetX;
}

void QchScreenShot::setTargetX(int x) {
    if (x != targetX()) {
        Q_D(QchScreenShot);
        d->targetX = x;
        emit targetXChanged();
    }
}

void QchScreenShot::resetTargetX() {
    setTargetX(0);
}

/*!
    \brief The y coordinate from where the screen shot will be taken.
    
    The default value is 0.
    
    \sa targetY
*/
int QchScreenShot::targetY() const {
    Q_D(const QchScreenShot);
    return d->targetY;
}

void QchScreenShot::setTargetY(int y) {
    if (y != targetY()) {
        Q_D(QchScreenShot);
        d->targetY = y;
        emit targetYChanged();
    }
}

void QchScreenShot::resetTargetY() {
    setTargetY(0);
}

/*!
    \brief The number of pixels to be grabbed horizontally.
    
    The default value is equal to the width of \link target\endlink.
*/
int QchScreenShot::targetWidth() const {
    Q_D(const QchScreenShot);
    return d->targetWidth;
}

void QchScreenShot::setTargetWidth(int w) {
    if (w != targetWidth()) {
        Q_D(QchScreenShot);
        d->targetWidth = w;
        emit targetWidthChanged();
    }
}

void QchScreenShot::resetTargetWidth() {
    setTargetWidth(-1);
}

/*!
    \brief The number of pixels to be grabbed vertically.
    
    The default value is equal to the height of \link target\endlink.
*/
int QchScreenShot::targetHeight() const {
    Q_D(const QchScreenShot);
    return d->targetHeight;
}

void QchScreenShot::setTargetHeight(int h) {
    if (h != targetHeight()) {
        Q_D(QchScreenShot);
        d->targetHeight = h;
        emit targetHeightChanged();
    }
}

void QchScreenShot::resetTargetHeight() {
    setHeight(-1);
}

/*!    
    Takes a screen shot of \link target\endlink, and returns true if the screen shot is successfully saved 
    to \link fileName\endlink.
*/
bool QchScreenShot::grab() {
    Q_D(QchScreenShot);
    d->pixmap = QPixmap();
    
    QObject *obj = target();
    
    if (obj) {
        if (obj->isWidgetType()) {
            QWidget *widget = qobject_cast<QWidget*>(obj);
            
            if (widget) {
                d->pixmap = QPixmap::grabWidget(widget, targetX(), targetY(), targetWidth(), targetHeight());
            }
        }
        else if (QGraphicsObject *go = qobject_cast<QGraphicsObject*>(obj)) {
            QRect rect = go->boundingRect().toRect();
            rect.moveLeft(qMax(0, targetX()));
            rect.moveTop(qMax(0, targetY()));
            rect.setWidth(qBound(1, targetWidth(), rect.width()));
            rect.setHeight(qBound(1, targetHeight(), rect.height()));
            
            QStyleOptionGraphicsItem styleOption;
            styleOption.rect = rect;
            
            d->pixmap = QPixmap(rect.size());
            d->pixmap.fill(Qt::transparent);
            
            QPainter painter(&d->pixmap);
            go->paint(&painter, &styleOption);
        }
        else {
            qmlInfo(this) << tr("Target must be a visual item.");
            return false;
        }
    }
    else {
        d->pixmap = QPixmap::grabWindow(QApplication::desktop()->winId(), targetX(), targetY(), targetWidth(),
                                        targetHeight());
    }

    if (!d->pixmap.isNull()) {
        QString name = d->getFileName();

        if (!name.isEmpty()) {
            setFileName(name);

            if ((width() > 0) && (height() > 0)) {
                d->pixmap = d->pixmap.scaled(width(), height(), Qt::IgnoreAspectRatio,
                                             smooth() ? Qt::SmoothTransformation : Qt::FastTransformation);
            }

            return d->pixmap.save(name);
        }
    }

    return false;
}

#include "moc_qchscreenshot.cpp"
