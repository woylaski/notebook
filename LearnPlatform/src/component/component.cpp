#include "component.h"

//QQmlComponent(QQmlEngine * engine, QObject * parent = 0)
//QQmlComponent(QQmlEngine * engine, const QString & fileName, QObject * parent = 0)

QPointer<QQmlComponent> create_component(QQmlEngine *engine, QUrl *file)
{
    QPointer<QQmlComponent> component = new QQmlComponent(engine);
    component->loadUrl(*file);
    QQuickView* qxView = new QQuickView(engine, NULL);
    return component;
}

void clean_component(QQmlComponent *component)
{
    delete component;
}
