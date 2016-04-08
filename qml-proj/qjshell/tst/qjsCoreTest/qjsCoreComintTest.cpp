/* qjsCoreComintTest.cpp ---
 *
 * Author: Julien Wintz
 * Created: mar. mars 25 00:45:04 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 39
 */

/* Change Log:
 *
 */

#include "qjsCoreComintTest.h"

#include <qjsCore/qjsCoreComint.h>
#include <qjsCore/qjsCoreEngine.h>
#include <qjsCore/qjsCoreEngineJS.h>

class qjsCoreComintTestPrivate
{
public:
    qjsCoreEngine *engine;
};

qjsCoreComintTest::qjsCoreComintTest(void)
{
    d = new qjsCoreComintTestPrivate;
}

qjsCoreComintTest::~qjsCoreComintTest(void)
{
    delete d;
}

void qjsCoreComintTest::initTestCase(void)
{
    d->engine = new qjsCoreEngine;
}

void qjsCoreComintTest::testParseStream(void)
{

}

void qjsCoreComintTest::testParseFile(void)
{

}

void qjsCoreComintTest::cleanupTestCase(void)
{
    delete d->engine;
}

QTEST_MAIN(qjsCoreComintTest)
