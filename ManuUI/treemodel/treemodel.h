#ifndef TREEMODEL_H
#define TREEMODEL_H

#include <QQuickItem>

class TreeModel : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(TreeModel)

public:
    TreeModel(QQuickItem *parent = 0);
    ~TreeModel();
};

#endif // TREEMODEL_H

