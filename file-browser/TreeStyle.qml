import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TreeViewStyle{
    id: styleId;
    backgroundColor: "transparent"
    indentation: 20
    itemDelegate: checkBoxDelegate;
    branchDelegate: branchDelegateId

    property variant linkDepthArray:[0]
    property int linkWidth: 0
    property int linkHeight: 0
    property color linkColor: "#5F5F5F"


    Component {
        id: branchDelegateId
        Item {
            id: branchItemId; x: -5;
            width: 12; height: 12;
            Rectangle {
                anchors.fill: parent;
                color: "transparent";
                Image{anchors.fill : parent
                    source: styleData.isExpanded ? "qrc:/minus.png" : "qrc:/plus.png"
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
            id: container
            CheckBox{
                id: checkBox;
                checkedState: styleData.value;
                text: myModel.getText(styleData.index);
                onClicked:
                {
                    console.log("Checked index", styleData.index)
                    myModel.setDataInModel(checked, styleData.index);
                }
            }

            Rectangle{
                id: rectId;
                x: -35 * styleData.depth + 10 * (styleData.depth - 1);
                y: -3;
                width: 2; height: styleData.depth ? 20 : 0;
                color:"blue";
            }

            Rectangle{
                x: -35 * styleData.depth + 10 * (styleData.depth - 1);
                y: container.height / 2;
                height: 2; width : (styleData.depth == 1) ? 20 : 0;
                color:"blue";
            }

            Rectangle{
                x: -23 * styleData.depth + 10 ;
                y: -3;
                width: 2; height: (styleData.depth == 2) ? 22 : 0;
                color:"blue";
            }

            Rectangle{
                x: -23 * styleData.depth + 10 ;
                y: container.height / 2;
                height: 2; width : (styleData.depth == 2) ? 25 : 0;
                color:"blue";
            }
        }
    }

    /*
    Component {
        id: checkBoxDelegate
        Item {
            GQITreeViewItem{
                anchors.fill: parent;
                branchHeight: linkHeight; branchWidth: linkWidth;
                treeModel: control.model; depthArray: linkDepthArray;
                index: styleData.index; widthOffset: indentation
            }
        }
    }
    */

    //    Component {
    //        id: checkBoxDelegate
    //        Item {
    //            id: container;
    //            property int offset: (height - branchHeight) / 2.0
    //            GQICheckBox{id: checkBox; anchors.verticalCenter : container.verticalCenter
    //                checkedState: styleData.value;
    //                text: control.model.GetText(styleData.index);
    //                onClicked:
    //                {
    //                    console.log("value", styleData.value)
    //                    console.log("Checked index", styleData.index)
    //                    control.model.SetData(checked, styleData.index);
    //                }

    //                Component.onCompleted: {
    //                    updateLine(control.model.GetDepth(styleData.index));
    //                    //console.log("Checked height", container.height)
    //                }
    //            }

    //            property Item rectItem
    //            function updateLine(depth){
    //                for (var i=0; i<depth; i++){
    //                    var posX = depthArray[i] - (i+1) * indentation
    //                    var drawLine = true;
    //                    if(i > 0 && control.model.IsLastElement(styleData.index, i))
    //                        drawLine = false;
    //                    if(drawLine)
    //                    {
    //                        rectItem = linkComponentId.createObject(container);
    //                        rectItem.x = posX; rectItem.height = (i+1) * container.height;
    //                        if(control.model.IsFirstElement(styleData.index)){
    //                            rectItem.y = -offset; rectItem.height += offset;
    //                        }
    //                        //to restrict height of rectangle
    //                        if(control.model.IsLastElement(styleData.index))
    //                            rectItem.height = (rectItem.height - rectItem.y) / 2.0;
    //                    }
    //                    if(i == 0){
    //                        rectItem = linkComponentId.createObject(container);
    //                        rectItem.x = posX; rectItem.width = container.x - posX - 5;
    //                        rectItem.height = 1; rectItem.y = container.height / 2.0;
    //                        if(control.model.IsParentNode(styleData.index))
    //                            rectItem.width = indentation - (branchWidth / 2.0) + 2;
    //                    }
    //                }
    //            }

    //            Component {id: linkComponentId
    //                Item {id: linkRectId;
    //                    width: 1; height: container.height;
    //                    Rectangle{
    //                        anchors.fill: parent;
    //                        color: linkColor;
    //                    }
    //                }

    //            }
    //        }
    //    }
}

