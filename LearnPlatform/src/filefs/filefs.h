#ifndef FILEFS_H
#define FILEFS_H

#include <QtCore/qabstractanimation.h>
#include <QtCore/qdir.h>
#include <QtCore/qmath.h>
#include <QtCore/qdatetime.h>
#include <QtCore/qpointer.h>
#include <QtCore/qscopedpointer.h>
#include <QtCore/qtextstream.h>
#include <QUrl>
#ifdef QT_WIDGETS_LIB
#include <QtWidgets/QApplication>
#include <QtWidgets/QFileDialog>
#endif

#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlContext>

QUrl *select_file(void);

#endif // FILEFS_H

