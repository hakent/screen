#ifndef CURTAIN_H
#define CURTAIN_H
#include <QGraphicsItem>
#include "inc/figure/figure.h"
#include <QColor>

class Curtain : public Figure {
    int m_number;
    QPointF prevPoints;
    bool close;

    void transformation(QGraphicsSceneMouseEvent *event);
public:
    Curtain(int x,int y,int width, int height,QPen pen,int number);
    bool isPointColor(QPoint p);
protected:
    void paint(QPainter *painter, const QStyleOptionGraphicsItem*, QWidget*);
    void hoverEnterEvent(QGraphicsSceneHoverEvent *event);
    void hoverLeaveEvent(QGraphicsSceneHoverEvent *event);
    void mousePressEvent(QGraphicsSceneMouseEvent *event);
    void mouseMoveEvent(QGraphicsSceneMouseEvent *event);
    void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
    void mouseDoubleClickEvent(QGraphicsSceneMouseEvent *event);
};

#endif // CURTAIN_H
