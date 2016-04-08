/* qjsCoreEngine.cpp ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 19:46:49 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 32
 */

/* Change Log:
 *
 */

#include "qjsCoreEngine.h"

qjsCoreEngine::qjsCoreEngine(QObject *parent) : QObject(parent)
{

}

qjsCoreEngine::~qjsCoreEngine(void)
{

}

qjsCoreEngine::EvaluationResult qjsCoreEngine::evaluate(const QString& statement)
{
    if(statement.isNull()) {
        qDebug() << "quit";
        return qjsCoreEngine::Quit;
    }

    if(statement == "quit")
        return qjsCoreEngine::Quit;

    if(statement.isEmpty())
        return qjsCoreEngine::Succ;

    return qjsCoreEngine::Fail;
}
