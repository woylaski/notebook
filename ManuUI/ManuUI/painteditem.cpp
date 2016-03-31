#include "PaintedItem.h"
#include <QPainter>
#include <QPen>
#include <QBrush>
#include <QColor>
#include <QDebug>

//QQuickPaintedItem的父类是QQuickItem
PaintedItem::PaintedItem(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , m_element(0)
    , m_bEnabled(true)
    , m_bPressed(false)
    , m_bMoved(false)
    , m_pen(Qt::black)
{
    //其实 QQuickItem 定义了一系列处理鼠标事件的虚函数，
    //比如 mousePressEvent 、 mouseMoveEvent 、 mouseMoveEvent 等，
    //它本身就可以处理鼠标事件，只不过 QQuickItem 没有导出这些函数，我们在 QML 中无法使用。
    //而之所以引入 QQuickMouseArea （QML 中的 MouseArea ），是为了方便鼠标事件的处理，
    //你不需要为每个 Item 像 QWidget 那样来重写很多方法，那样真的很烦的，
    //QML 的这种方式虽然多用了一个对象，但是更方便一些。
    //可是我们的 PaintedItem 类，如果绕回到 QML 中使用 MouseArea 来处理鼠标事件，
    //那我们跟踪鼠标轨迹来绘制线条时，就需要不断地将鼠标事件中携带的像素点信息再回传到 C++ 中来，
    //非常麻烦，性能也不好，所以我们直接重写 QQuickItem 的相关虚函数来处理鼠标事件。
    //setAcceptedMouseButtons是QQuickItem提供的一个成员函数
    //void	setAcceptedMouseButtons(Qt::MouseButtons buttons)
    //我们知道 MouseArea 有一个 acceptedButtons 属性，可以设置 Item 处理哪个鼠标按键，
    //而实际上，“要处理的鼠标按键”这个信息，是保存在 QQuickItem 中的，通过 setAcceptedMouseButtons() 方法来设置。
    //默认情况下， QQuickItem 不处理任何鼠标按键，
    //所以我们要处理鼠标按键，必须在我们的 PaintedItem 中来设置一下，就像 MouseArea 那样
    //我们只处理鼠标左键。如果你不设置这个，你收不到任何鼠标事件
    setAcceptedMouseButtons(Qt::LeftButton);
}

PaintedItem::~PaintedItem()
{
    //把 m_elements 内保存的所有绘图序列都删除
    purgePaintElements();
}

void PaintedItem::clear()
{
    //调用 purgePaintElements() ，把 m_elements 内保存的所有绘图序列都删除
    purgePaintElements();
    //void QQuickPaintedItem::update(const QRect &rect = QRect())
    //重画这个区域，但不是马上就重画，是有计划的，在需要重画的时候调用这个函数
    update();
}

void PaintedItem::undo()
{
    if(m_elements.size())
    {
        delete m_elements.takeLast();
        update();
    }
}

void PaintedItem::paint(QPainter *painter)
{
    painter->setRenderHint(QPainter::Antialiasing);

    int size = m_elements.size();
    ElementGroup *element;
    for(int i = 0; i < size; ++i)
    {
        element = m_elements.at(i);
        painter->setPen(element->m_pen);
        painter->drawLines(element->m_lines);
    }
}

//在 mousePressEvent() 中生成一个新的绘图序列，在 mouseMoveEvent() 中将当前点和上一个点组合为一条线，加入当前绘图序列(m_element)
void PaintedItem::mousePressEvent(QMouseEvent *event)
{
    m_bMoved = false;
    if(!m_bEnabled || !(event->button() & acceptedMouseButtons()))
    {
        QQuickPaintedItem::mousePressEvent(event);
    }
    else
    {
        qDebug() << "mouse pressed";
        m_bPressed = true;
        m_element = new ElementGroup(m_pen);
        m_elements.append(m_element);
        //const QPointF &QMouseEvent::localPos() const
        m_lastPoint = event->localPos();
        //QEvent: void	setAccepted(bool accepted)
        //Setting the accept parameter indicates that the event receiver wants the event.
        //Unwanted events might be propagated to the parent widget.
        //设置accepted就是说这个事件我处理了，同时不让这个事件再向外（向父对象）扩散（父对象收不到这个事件）
        event->setAccepted(true);
    }
}

//void QQuickItem::mouseMoveEvent(QMouseEvent *event)
void PaintedItem::mouseMoveEvent(QMouseEvent *event)
{
    if(!m_bEnabled || !m_bPressed || !m_element)
    {
        QQuickPaintedItem::mousePressEvent(event);
    }
    else
    {
        qDebug() << "mouse move";
        m_element->m_lines.append(QLineF(m_lastPoint, event->localPos()));
        m_lastPoint = event->localPos();
        update();
    }
}

//当 mouseReleaseEvent() 被调用时，把鼠标左键抬起时的指针位置的坐标也处理了，这样一个完整的绘图序列就生成了
void PaintedItem::mouseReleaseEvent(QMouseEvent *event)
{
    if(!m_element || !m_bEnabled || !(event->button() & acceptedMouseButtons()))
    {
        QQuickPaintedItem::mousePressEvent(event);
    }
    else
    {
        qDebug() << "mouse released";
        m_bPressed = false;
        m_bMoved = false;
        m_element->m_lines.append(QLineF(m_lastPoint, event->localPos()));
        update();
    }
}

//把 m_elements 内保存的所有绘图序列都删除
void PaintedItem::purgePaintElements()
{
    int size = m_elements.size();
    if(size > 0)
    {
        for(int i = 0; i < size; ++i)
        {
            delete m_elements.at(i);
        }
        m_elements.clear();
    }
    m_element = 0;
}
