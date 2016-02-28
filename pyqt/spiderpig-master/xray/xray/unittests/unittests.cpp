#include "../parser.h"
#include "../recorder.h"

#include <QtTest/QtTest>

class TestParser: public QObject
 {
    Q_OBJECT
private slots:
    void testName();
    void testFileNameGeneration();
};

void TestParser::testName()
 {
    Parser parser;
    QByteArray exampleResult = "<XmlDoc resultId=\"\">\n<DateTimeGetResult status=\"OK\">\n<Day item=\"1\">11</Day>\n<Hour item=\"1\">12</Hour>\n<Minute item=\"1\">26</Minute>\n<Month item=\"1\">4</Month>\n<Second item=\"1\">29</Second>\n<Year item=\"1\">2014</Year>\n</DateTimeGetResult>\n</XmlDoc>";
    QCOMPARE(QString(Message::parseReplyName(exampleResult)), QString("DateTimeGetResult"));
}

void TestParser::testFileNameGeneration()
{
    QString cmd = "xcom Experimental Peripherals Connect ID: \"5C:FF:35:01:FA:4A\" Type: \"TouchPanel\" Name: \"Cisco TelePresence Touch\" SoftwareInfo: \"Unknown revision\" NetworkAddress: \"10.47.38.156\" HardwareInfo: \"Unknown hardware\" | resultId=\"2\"";
    QString name = "xcom_Experimental_Peripherals_Connect_ID.xml";
    QCOMPARE(name, Recorder::makeMessageName(cmd));

    QString cmd2 = "xgetxml History | resultId=\"11\"";
    QString name2 = "xgetxml_History.xml";
    QCOMPARE(name2, Recorder::makeMessageName(cmd2));


    QString cmd3 = "systemtools network ifconfig --xml";
    QString name3 = "systemtools_network_ifconfig_--xml.xml";
    QCOMPARE(name3, Recorder::makeMessageName(cmd3));

}

QTEST_MAIN(TestParser)
#include "unittests.moc"
