import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls

Controls.Action {
    //是否在这个Action后面显示分隔符
    property bool hasDividerAfter

    //Action对应的图标
    //iconName : string, iconName 是Controls.Action的属性可以直接使用
    //Controls.Action 里面本来就有iconSource,但是类型是url
    ////iconSource : url
    property string iconSource: "icon://" + iconName

    //Action显示的名字
    //text : string
    property string name
    text: name

    //提示，简介
    //tooltip : string
    //property string summary

    property bool visible: true

    //shortcut : keysequence,快捷方式，热键

    //checkable : bool
    //checked : bool
    //enabled : bool
    //exclusiveGroup : ExclusiveGroup，互斥分组

    /*!
       Set to \c true to rotate the icon 90 degrees on mouseover.
     */
    property bool hoverAnimation: false

    //toggled(checked ),切换时
    /*
    onToggled: {

    }
    */

    //triggered(QObject *source)。处罚时
    /*
    onTriggered: {

    }
    */
}

