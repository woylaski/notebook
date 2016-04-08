/* qjsCoreComintTest.h ---
 *
 * Author: Julien Wintz
 * Created: mar. mars 25 00:39:09 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 31
 */

/* Change Log:
 *
 */

#include <QtTest>

class qjsCoreComintTest : public QObject
{
    Q_OBJECT

public:
     qjsCoreComintTest(void);
    ~qjsCoreComintTest(void);

private slots:
    void initTestCase(void);
    void cleanupTestCase(void);

private:
    class qjsCoreComintTestPrivate *d;
};
