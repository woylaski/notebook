/* qjsCoreEngineJS.cpp ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 20:12:05 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 67
 */

/* Change Log:
 *
 */

#include "qjsCoreColor.h"
#include "qjsCoreEngineJS.h"

#include <QtQml>

class qjsCoreEngineJSPrivate
{
public:
    QJSEngine *engine;
};

qjsCoreEngineJS::qjsCoreEngineJS(QObject *parent) : qjsCoreEngine(parent)
{
    d = new qjsCoreEngineJSPrivate;
    d->engine = new QJSEngine(this);
}

qjsCoreEngineJS::~qjsCoreEngineJS(void)
{
    delete d;
}

qjsCoreEngine::EvaluationResult qjsCoreEngineJS::evaluate(const QString& statement)
{
    qjsCoreEngine::EvaluationResult result = qjsCoreEngine::evaluate(statement);

    if(result != qjsCoreEngine::Fail)
        return result;

    QJSValue returned = d->engine->evaluate(statement);

    QString output;

    if (returned.isError()) {
        output.append(qjsCoreColor::foreground(Qt::red));
        result = qjsCoreEngine::Fail;
    } else {
        output.append(qjsCoreColor::foreground(Qt::green));
        result = qjsCoreEngine::Succ;
    }

    output.append(returned.toString());
    output.append(qjsCoreColor::clear());

    if(returned.toString().isEmpty())
        return result;

    if(returned.toString() == "undefined")
        return result;

    qDebug() << qPrintable(output);

    return result;
}
