#include "textballoon.h"

TextBalloon::TextBalloon(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , rightAligned(false)
{
}

void TextBalloon::paint(QPainter *painter)
{
    QBrush brush(QColor("#007430"));

    painter->setBrush(brush);
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);

    painter->drawRoundedRect(0, 0, boundingRect().width(), boundingRect().height() - 10, 10, 10);

    if (rightAligned)
    {
        const QPointF points[3] = {
            QPointF(boundingRect().width() - 10.0, boundingRect().height() - 10.0),
            QPointF(boundingRect().width() - 20.0, boundingRect().height()),
            QPointF(boundingRect().width() - 30.0, boundingRect().height() - 10.0),
        };
        painter->drawConvexPolygon(points, 3);
    }
    else
    {
        const QPointF points[3] = {
            QPointF(10.0, boundingRect().height() - 10.0),
            QPointF(20.0, boundingRect().height()),
            QPointF(30.0, boundingRect().height() - 10.0),
        };
        painter->drawConvexPolygon(points, 3);
    }
}

bool TextBalloon::isRightAligned()
{
    return this->rightAligned;
}

void TextBalloon::setRightAligned(bool rightAligned)
{
    this->rightAligned = rightAligned;
}
