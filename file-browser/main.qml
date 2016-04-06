import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2

import "qrc:/ObjUtils.js" as ObjUtils

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("File System")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Row {
        id: row
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter

        ExclusiveGroup {
            id: eg
        }

        Repeater {
            model: [ "None", "Single", "Extended", "Multi", "Contig."]
            Button {
                text: modelData
                exclusiveGroup: eg
                checkable: true
                checked: index === 1
                onClicked: view.selectionMode = index
            }
        }
    }

    function autoExpand(index ) {
        print(index)
        var oneUp = index

        do {
            print(oneUp)
            oneUp = index.parent
            expand(oneUp)
            print("do")
            print(oneUp)
        } while (oneUp)

    }

    function expand(index) {
        if (index.valid && index.model !== model)
            console.warn("TreeView.expand: model and index mismatch")
        else
            modelAdaptor.expand(index)
    }

    ItemSelectionModel {
        id: sel
        model: fileSystemModel
        onSelectionChanged: {
            console.log("selected", selected)
            console.log("deselected", deselected)
            fileManagement.printFileNames(model, selectedIndexes)
        }
        onCurrentChanged: console.log("current", current)
    }

    TreeView {
        id: view
        anchors.fill: parent
        anchors.margins: 2 * 12 + row.height
        model: fileSystemModel
        selection: sel

        onCurrentIndexChanged: console.log("current index", currentIndex)

        /*
        itemDelegate: Rectangle {
            //color: ( styleData.row % 2 == 0 ) ? "white" : "lightblue"
            height: 40

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    var indexSelected = styleData.index ;
                    var indexParent   = indexSelected.parent;
                    //console.log("parent name is ",fileSystemModel.getParentName(indexParent));
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                text: styleData.value // this points to the role we defined in the TableViewColumn below; which one depends on which column this delegate is instantiated for.
            }
        }
        */

        style: TreeViewStyle {
            id: styleId;
            backgroundColor: "transparent"
            indentation: 20

            property variant linkDepthArray:[0]
            property int linkWidth: 0
            property int linkHeight: 0
            property color linkColor: "#5F5F5F"

            /*
            branchDelegate: Item {
                width: 16
                height: 16
                Text {
                    visible: styleData.column === 0 && styleData.hasChildren
                    text: styleData.isExpanded ? "\u25bc" : "\u25b6"
                    color: !control.activeFocus || styleData.selected ? styleData.textColor : "#666"
                    font.pointSize: 10
                    renderType: Text.NativeRendering
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: styleData.isExpanded ? 2 : 0
                }
            }
            */
            branchDelegate: branchDelegateId
            itemDelegate: checkBoxDelegate

            //https://msdn.microsoft.com/en-us/library/ms366759.aspx
            Component {
                id: branchDelegateId
                Item {
                    id: branchItemId; x: -5;
                    width: 12; height: 12;
                    Rectangle {
                        anchors.fill: parent;
                        color: "transparent";
                        Image{anchors.fill : parent
                            source: styleData.isExpanded ? "qrc:/images/minus.png" : "qrc:/images/plus.png"
                        }

                        Component.onCompleted: {
                            linkDepthArray[styleData.depth] = x - width;
                            linkWidth = width;
                            linkHeight = height;
                        }

                    }
                }
            }
/*
styleData.selected - if the item is currently selected
styleData.value - the value or text for this item
styleData.textColor - the default text color for an item
styleData.row - the index of the view row
styleData.column - the index of the view column
styleData.elideMode - the elide mode of the column
styleData.textAlignment - the horizontal text alignment of the column
styleData.pressed - true when the item is pressed
styleData.hasActiveFocus - true when the row has focus
styleData.index - the QModelIndex of the current item in the model
styleData.depth - the depth of the current item in the model
styleData.isExpanded - true when the item is expanded
styleData.hasChildren - true if the model index of the current item has or can have children
styleData.hasSibling - true if the model index of the current item has a sibling
*/
            //object createObject(Item parent, object properties)
            //var component = Qt.createComponent("Button.qml");
            //if (component.status == Component.Ready)
            //    component.createObject(parent, {"x": 100, "y": 100});
            //由于 Component 不是继承自 Item ，所以使用 anchors 锚布局无效，但 Loader 可以使用
            Component {
                id: checkBoxDelegate
                Rectangle {
                    id: itemrect
                    //color: ( styleData.row % 2 == 0 ) ? "white" : "lightblue"
                    height: 40

                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            var cords = itemrect.mapToItem(null, 0, 0)
                            //console.log("item x in root is ", cords.x)
                            //console.log("item y in root is ", cords.y)

                            var indexSelected = styleData.index ;
                            var indexParent   = indexSelected.parent;
                            console.log("data index is ",styleData.index)
                            console.log("data depth is ",styleData.depth)
                            console.log("data row is ",styleData.row)
                            console.log("data column is ",styleData.column)
                            console.log("parent x is ", view.x)
                            //console.log(parent.parent.children[0].item.value)
                            //console.log("data index is ",indexSelected.data)
                            //console.log("parent index is ",indexSelected.value)
                            //console.log("parent name is ",control.model.index(indexParent))
                            console.log("parent model data is ",control.model.data(indexParent))
                            console.log("select model data is ",control.model.data(indexSelected,0))
                            //console.log("parent name is ",fileSystemModel.getParentName(indexParent));
                            //console.log("model index property")
                            //ObjUtils.listProperty(indexSelected)
                            //ObjUtils.listProperty(indexParent)
                            fileManagement.printPath(control.model, styleData.index)
                        }
                    }

                    Row{
                        spacing: 10
                        Rectangle{
                            //x: {var cords = itemrect.mapToItem(null, 0, 0); return -cords.x;}
                            //x: {var cords = itemrect.mapToItem(null, 0, 0); return -cords.x;}
                            //width: -x
                            x: -styleId.indentation*styleData.depth
                            width: styleId.indentation*styleData.depth
                            height: 2
                            anchors.verticalCenter: parent.verticalCenter
                            //border.width: 0.5
                            border.color: "gray"
                            visible: styleData.hasChildren? false: styleData.column==0?true:false;

                        }
                        CheckBox{
                            id: checkBox;
                            visible: styleData.hasChildren? false: styleData.column==0?true:false;
                            checkedState: styleData.hasChildren? false: true;
                        }

                        Text {
                            //anchors.verticalCenter: parent.verticalCenter
                            //anchors.left: parent.left
                            // this points to the role we defined in the TableViewColumn below;
                            //which one depends on which column this delegate is instantiated for.
                            text: styleData.value+"_"+styleData.depth
                        }
                    }
                }
            }
            /*
            Component {
                id: checkBoxDelegate
                Item {
                    id: container;
                    property int offset: (height - branchHeight) / 2.0
                    CheckBox{
                        id: checkBox;
                        anchors.verticalCenter : container.verticalCenter
                        checkedState: styleData.value? true: false;
                        text: control.model.GetText(styleData.index);
                        onClicked:
                        {
                                console.log("value", styleData.value)
                                console.log("Checked index", styleData.index)
                                control.model.SetData(checked, styleData.index);
                        }

                        Component.onCompleted: {
                            updateLine(control.model.GetDepth(styleData.index));
                            //console.log("Checked height", container.height)
                        }
                    }

                    property Item rectItem
                    function updateLine(depth)
                    {
                        for (var i=0; i<depth; i++)
                        {
                            var posX = depthArray[i] - (i+1) * indentation
                            var drawLine = true;
                            if(i > 0 && control.model.IsLastElement(styleData.index, i))
                                drawLine = false;

                            if(drawLine)
                            {
                                    //先使用 Qt.createComponent(url, mode, parent) 从 QML 文件中创建一个组件，必要时可以根据 Component.status 属性判断创建状态，
                                    //然后使用 Component.createObject() 在某个父对象下实例化对象，最后使用 destroy() 销毁对象，函数参数可以指定一个时间，单位是毫秒
                                    rectItem = linkComponentId.createObject(container);
                                    rectItem.x = posX; rectItem.height = (i+1) * container.height;
                                    if(control.model.IsFirstElement(styleData.index)){
                                        rectItem.y = -offset; rectItem.height += offset;
                                    }
                                    //to restrict height of rectangle
                                    if(control.model.IsLastElement(styleData.index))
                                        rectItem.height = (rectItem.height - rectItem.y) / 2.0;
                            }

                            if(i == 0){
                                rectItem = linkComponentId.createObject(container);
                                rectItem.x = posX; rectItem.width = container.x - posX - 5;
                                rectItem.height = 1; rectItem.y = container.height / 2.0;
                                if(control.model.IsParentNode(styleData.index))
                                    rectItem.width = indentation - (branchWidth / 2.0) + 2;
                            }
                        }
                    }

                    Component {
                        id: linkComponentId
                        Item {
                            id: linkRectId;
                            width: 1; height: container.height;
                            Rectangle{
                                anchors.fill: parent;
                                color: linkColor;
                            }
                        }
                    }
                }
            }
            */
        }

        TableViewColumn {
            title: "Name"
            role: "fileName"
            resizable: true
        }

        TableViewColumn {
            title: "Permissions"
            role: "filePermissions"
            resizable: true
        }

        /*
        TableViewColumn {
            width: 50
            role: "description_role"
            title: "Icon"
            delegate: Image {
                source: styleData.value + ".png"
            }
        }
        */

        onClicked: {
            console.log("clicked", index)
            //fileSystemModel.data(index, "Title")
            fileManagement.printPath(index.model, index)
        }
        onDoubleClicked: isExpanded(index) ? collapse(index) : expand(index)

        Component.onCompleted: {
            //ObjUtils.listProperty(model)
        }
    }

    Component.onCompleted: fileManagement.test()
}
