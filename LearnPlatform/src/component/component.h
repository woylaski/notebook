#ifndef COMPONENT_H
#define COMPONENT_H

#include <QQmlEngine>
#include <qurl.h>
#include <QQuickView>
#include <QQmlComponent>
#include <QPointer>

QPointer<QQmlComponent> create_component(QQmlEngine *engine, QUrl file);

#endif // COMPONENT_H

