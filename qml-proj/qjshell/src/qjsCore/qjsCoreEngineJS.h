/* qjsCoreEngineJS.h ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 20:09:31 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 13
 */

/* Change Log:
 *
 */

#pragma once

#include "qjsCoreEngine.h"

class qjsCoreEngineJS : public qjsCoreEngine
{
    Q_OBJECT

public:
     qjsCoreEngineJS(QObject *parent = 0);
    ~qjsCoreEngineJS(void);

public:
    qjsCoreEngine::EvaluationResult evaluate(const QString&);

private:
    class qjsCoreEngineJSPrivate *d;
};
