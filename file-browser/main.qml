import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2

ApplicationWindow {
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
                            source: styleData.isExpanded ? "qrc:/images/checkbox_unchecked.png" : "qrc:/images/checkbox_checked.png"
                        }

                        Component.onCompleted: {
                            linkDepthArray[styleData.depth] = x - width;
                            linkWidth = width;
                            linkHeight = height;
                        }

                    }
                }
            }

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
            fileManagement.printPath(index.model, index)
        }
        onDoubleClicked: isExpanded(index) ? collapse(index) : expand(index)
    }

    Component.onCompleted: fileManagement.test()
}
