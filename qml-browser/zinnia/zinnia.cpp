#include "zinnia.h"

Zinnia::Zinnia(QQuickItem *parent):
    QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
    //recognizer = zinnia::Recognizer::create();
    //if (!recognizer->open("/usr/share/tegaki/models/zinnia/handwriting-zh_TW.model"))
    //    qDebug("can't load model file");
    //else qDebug("model \"handwriting-zh_TW.model\" loaded");

    //character = zinnia::Character::create();
    //character->clear();

    //character->set_width(300);
    //character->set_height(300);

}

Zinnia::~Zinnia()
{
}

void Zinnia::clear()
{
    qDebug() << "character cleared";
    //character->clear();
}

QString Zinnia::query(int s, int x, int y)
{
    str = QString("");
    //character->add(s, x, y);

    //result = recognizer->classify(*character, 8);
    //if (!result) qDebug("can't find resule");

    //for (size_t i = 0; i < result->size(); ++i) {
    //    str.append(result->value(i)).append(" ");
        //qDebug() << result->value(i);
    //}

    return str;
}

