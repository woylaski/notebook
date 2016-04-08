/* main.cpp ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 16:00:53 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 112
 */

/* Change Log:
 *
 */

#include <QtCore>

#include <qjsCore/qjsCoreColor>
#include <qjsCore/qjsCoreComint>
#include <qjsCore/qjsCoreEngine>
#include <qjsCore/qjsCoreEngineJS>

int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);

    qjsCoreEngine *engine = new qjsCoreEngineJS;
    qjsCoreComint *comint = new qjsCoreComint;
    comint->grab(engine);
    comint->start(argc, argv);

    delete comint;
    delete engine;

    return 0;
}
