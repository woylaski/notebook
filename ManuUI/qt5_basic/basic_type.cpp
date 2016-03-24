
#include <QString>
#include <QList>

void basic_string()
{
    QString str_1 = "Hello";
    const QChar data[4] = { 0x0055, 0x006e, 0x10e3, 0x03a3 };
    QString str_2(data, 4);

    QString str;
    str.resize(4);

    str[0] = QChar('U');
    str[1] = QChar('n');
    str[2] = QChar(0x10e3);
    str[3] = QChar(0x03a3);

    for (int i = 0; i < str.size(); ++i) {
        if (str.at(i) >= QChar('a') && str.at(i) <= QChar('f'))
            qDebug() << "Found character in range [a-f]";
    }

    QString str = "and";
    str.prepend("rock ");     // str == "rock and"
    str.append(" roll");        // str == "rock and roll"
    str.replace(5, 3, "&");   // str == "rock & roll"

    QString str = "We must be <b>bold</b>, very <b>bold</b>";
    int j = 0;

    while ((j = str.indexOf("<b>", j)) != -1) {
        qDebug() << "Found <b> tag at index position" << j;
        ++j;
    }

    QString().isNull();               // returns true
    QString().isEmpty();              // returns true

    QString("").isNull();             // returns false
    QString("").isEmpty();            // returns true

    QString("abc").isNull();          // returns false
    QString("abc").isEmpty();         // returns false

    str.fromUtf8();
    str.fromLatin1();
    str.fromRawData();

    str.toUtf8();
    str.toLatin1();

}

void basic_list()
{
    QList<int> integerList;
    QList<QDate> dateList;
    QList<QString> list;
    list << "one" << "two" << "three";
    // list: ["one", "two", "three"]

    list.prepend("111");
    list.prepend("222");
    list.append("333");

    cout<<"list count: "<<list.count()<<endl;
    cout<<"first: "<<list.first()<<endl;
    cout<<"last: "<<list.last()<<endl;
    cout<<"index 2:"<<list.at(2)<<endl;

    list << "A" << "B" << "C" << "D" << "E" << "F";
    list.swap(1, 4);

    cout<<list.size()<<endl;

    if (list[0] == "Bob")
        list[0] = "Robert";

    for (int i = 0; i < list.size(); ++i) {
        if (list.at(i) == "Jane")
            cout << "Found Jane at position " << i << endl;
    }

    int i = list.indexOf("Jane");
    if (i != -1)
        cout << "First occurrence of Jane is at position " << i << endl;

    list.pop_back();
    list.pop_front();
    list.push_back();
    list.push_front();

    list.removeAll("111");
    list.removeAt(3);
    list.removeFirst();
    list.removeLast();
    list.removeOne("qt");

    while (!list.isEmpty())
        delete list.takeFirst();

    delete list.takeLast();
    delete list.takeAt(0);

    list.clear();
}

void basic_set()
{
    QStringList list;
    list << "Julia" << "Mike" << "Mike" << "Julia" << "Julia";

    QSet<QString> set = list.toSet();
    set.contains("Julia");  // returns true
    set.contains("Mike");   // returns true
    set.size();             // returns 2
}

void basic_vector()
{
    QStringList list;
    list << "Sven" << "Kim" << "Ola";

    QVector<QString> vect = list.toVector();
    // vect: ["Sven", "Kim", "Ola"]
}
