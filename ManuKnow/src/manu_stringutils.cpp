#include "manu_stringutils.h"

void AsciiToQString()
{
    QString s1 = "汉语";
    QString s2("漢語");
    QString s6 = u8"中文";//C++11
    QString s4 = QStringLiteral("中文");

    QString a[] = {"中","国","龙"};
    std::string a2 = a[2].toStdString();
}

void QStringToBytes()
{
    QByteArray bytes;
    std::string  stdstr;
    QString  str = "QStringToChar1你好123";
    bytes = str.toLatin1();
    bytes = str.toLocal8Bit();
    stdstr = str.toStdString();
    bytes = str.toUtf8();
}

void QStringToChar1()
{
    QString  str = "QStringToChar1你好123";
    char* ch;
    QByteArray ba = str.toUtf8();
    ch=ba.data();
    qDebug("QStringToChar1 %s\n", ch);
}

void QStringToChar2()
{
    QString  filename = "QStringToChar2你好123";
    std::string str = filename.toStdString();
    const char* ch = str.c_str();
    qDebug("QStringToChar2 %s\n", ch);
}

void CharToQString()
{
    char* mm = "CharToQString你好123";
    QString str = QString(mm);
    qDebug("CharToQString %s\n", str.toUtf8().data());
}

void QString_StdString()
{
    //std::string to QString
    std::string s1 = "std::string to QString你好123";
    QString qstr1 = QString::fromStdString(s1);
    qDebug("StdStringToQString: %s\n", qstr1.toUtf8().data());

    //QString to std::string
    QString qstr2 = "QString to std::string你好123";
    std::string s2 = qstr2.toStdString();
    qDebug("QStringToStdString: %s\n", s2.c_str());
}

void StdString_Char()
{
    //StdString To char*
    std::string qstr1 = "StdString_Char你好123";
    const char* c1 = qstr1.c_str();
    qDebug("StdString To char*: %s\n", c1);

    //char* To StdString
    char* c2 = "char* To StdString你好123";
    std::string qstr2 = c2;
    qDebug("char* To StdString: %s\n", qstr2.c_str());
}

void QByteArray_QString()
{
    //QByteArray To QString
    QByteArray qba1 = "QByteArray To QString你好123";
    QString str1(qba1);
    qDebug("QByteArray To QString: %s\n", str1.toUtf8().data());

    //QString To QByteArray
    QString str2 = "QString To QByteArray你好123";
    QByteArray qba2 = str2.toUtf8();
    qDebug("QString To QByteArray: %s\n", qba2.data());
}

void Char_QByteArray()
{
    //Char To QByteArray
    char* c1 = "Char To QByteArray你好123";
    QByteArray qba1(c1);
    qDebug("Char To QByteArray: %s\n", qba1.data());

    //QByteArray To Char
    QByteArray qba2 = "QByteArray To Char你好123";
    qDebug("QByteArray To Char: %s\n", qba2.data());
}

void QString_Int()
{
    //Int To QString
    QString qstr1 = QString::number(123);
    qDebug("Int To QString: %s\n", qstr1.toUtf8().data());
    //QString To Int
    int intNumber = atoi(qstr1.toStdString().c_str());
    qDebug("QString To Int: %d\n", intNumber);
}
