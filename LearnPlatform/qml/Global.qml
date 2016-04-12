import QtQuick 2.5
pragma Singleton

QtObject {
    property string os: Qt.platform.os
    property string workDir: {
        if(os=="windows") return "file:///E:/github/notebook/LearnPlatform";
        else if(os=="linux") return "file:///home/manu/work/github/notebook/LearnPlatform";
        else if(os=="android") return "";
        else if(os=="ios") return "";
        else return "";
    }
}

