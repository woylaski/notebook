/* qjsCoreComint.cpp ---
 *
 * Author: Julien Wintz
 * Created: lun. mars 24 16:20:46 2014 (+0100)
 * Version:
 * Last-Updated:
 *           By:
 *     Update #: 317
 */

/* Change Log:
 *
 */

#include "qjsCoreColor.h"
#include "qjsCoreComint.h"
#include "qjsCoreEngine.h"

#include <readline/history.h>
#include <readline/readline.h>

#include <QtDebug>

// /////////////////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////

class qjsCoreComintPrivate
{
public:
    qjsCoreEngine *engine;

public:
    QString prompt;
};

// /////////////////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////

qjsCoreComint::qjsCoreComint(QObject *parent) : QObject(parent)
{
    d = new qjsCoreComintPrivate;
    d->engine = NULL;
    d->prompt = qjsCoreColor::foreground(Qt::magenta, true) + "qjs" + qjsCoreColor::clear() + "$ ";
}

qjsCoreComint::~qjsCoreComint(void)
{
    delete d;
}

void qjsCoreComint::grab(qjsCoreEngine *engine)
{
    d->engine = engine;
}

void qjsCoreComint::start(int argc, char **argv)
{
    if(!d->engine) {
        qDebug() << qjsCoreColor::foreground(Qt::magenta) << Q_FUNC_INFO << "No engine is set." << qjsCoreColor::clear();
        return;
    }

    this->parse(argc, argv);
    this->run();
}

void qjsCoreComint::parse(int argc, char **argv)
{
    if(argc < 2)
        return;

    *argv++;

    while (const char *arg = *argv++) {

        QString fileName = QString::fromLocal8Bit(arg);
        QString contents;

        if (fileName == QLatin1String("-")) {

            qDebug() << qPrintable(qjsCoreColor::foreground(Qt::blue) + "Interactive input. Hit ^D when done." + qjsCoreColor::clear());

            QTextStream stream(stdin, QFile::ReadOnly);
            contents = stream.readAll();

        } else {

            qDebug() << Q_FUNC_INFO << "Reading from file";

            QFile file(fileName);

            if (file.open(QFile::ReadOnly)) {

                QTextStream stream(&file);
                contents = stream.readAll();

                file.close();

                if (contents.startsWith("#!"))
                    contents.remove(0, contents.indexOf("\n"));
            }
        }

        if (contents.isEmpty())
            continue;
        else
            d->engine->evaluate(contents);
    }
}

void qjsCoreComint::run(void)
{
    qjsCoreEngine::EvaluationResult result;

    do {

        QString input = readline(qPrintable(d->prompt));

        if(!input.isNull() && !input.isEmpty())
            add_history(qPrintable(input));

        result = d->engine->evaluate(input);

        switch(result) {
        case qjsCoreEngine::Fail:
            break;
        case qjsCoreEngine::Succ:
            break;
        default:
            break;
        }
    } while(result);
}
