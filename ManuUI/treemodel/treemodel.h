#ifndef TREEMODEL_H
#define TREEMODEL_H

#include <QQuickItem>
#include <QAbstractItemModel>
#include <QModelIndex>
#include <QVariant>

class TreeItem;

//class TreeModel : public QQuickItem, public QAbstractItemModel
class TreeModel : public QAbstractItemModel
{
    Q_OBJECT
    Q_DISABLE_COPY(TreeModel)

    //QString text: 属性text,类型QString
    //READ text: 读取属性的方法text()
    //WRITE setText: 设置属性的方法setText()
    //NOTIFY textChanged: 属性变化的信号 textChanged
    Q_PROPERTY(QString mdata READ mdata WRITE setMdata NOTIFY mdataChanged)

public:
    //定义枚举类型
    enum DelegateEnum
    {
        NameEnum = 0,
        SummaryEnum,
        SizeEnum,
    };
    //将类型DelegateEnum对外提供给qml使用
    Q_ENUMS(DelegateEnum)

    //explicit 关键字只能用于类内部的构造函数声明上。
    //explicit 关键字作用于单个参数的构造函数。
    //在C++中，explicit关键字用来修饰类的构造函数，被修饰的构造函数的类，不能发生相应的隐式类型转换
    explicit TreeModel(QObject *parent = 0);
    //explicit TreeModel(const QString &data, QObject *parent = 0);
    ~TreeModel();

    //读取text
    QString mdata() const;

    //使用 Q_DECL_OVERRIDE 宏来声明这是一个对虚函数进行定义的方法
    //获取index记录的role字段的数据
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;

    Qt::ItemFlags flags(const QModelIndex &index) const Q_DECL_OVERRIDE;

    QVariant headerData(int section, Qt::Orientation orientation,
                            int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;

    QModelIndex index(int row, int column,
                          const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;

    QModelIndex parent(const QModelIndex &index) const Q_DECL_OVERRIDE;
    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;

    QHash<int, QByteArray> roleNames() const;

    //Q_INVOKABLE对外提供的方法，也可以发射信号, 可以被QML调用
    //Q_INVOKABLE void read();

public slots:
    //槽函数，用于设置属性，同时发射信号，同样可以被QML调用
    //当信号发出后，连接的槽就会被调用。槽是普通的c++函数，可以正常的调用；槽唯一的特性就是信号可以和它连接
    void setMdata(QString text);

signals:
    //信号，属性变化时发射的信号
    void mdataChanged(QString arg);

private:
    void setupModelData(const QStringList &lines, TreeItem *parent);
    TreeItem *rootItem;
    QString m_text;
};

#endif // TREEMODEL_H

