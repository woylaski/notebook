import QtQuick 2.1;
import QtQuick.Window 2.1;
//import CutePrez 1.0;
import "."

ManuPrez {
    id: prez;
    width: 800;
    height: 600;
    //theme: SimpleTheme {}
    pages: [
        ManuPrezPage {
            title: "Title test"
        },
        ManuPrezPage {
            transition: Component{ManuPrezPageZoom{side:bottomLeft}}
            Text {
                anchors.centerIn: parent;
                text: "page2";
            }
        },
        ManuPrezPage {
            transition: Component{ManuPrezPageFromSide{side:left}}
            Text {
                anchors.centerIn: parent;
                text: "page3";
            }
        },
        ManuPrezPage {
            transition: Component{ManuPrezPageFromSide{side:topLeft}}
            Text {
                anchors.centerIn: parent;
                text: "page4";
            }
        },
        ManuPrezPage {
            Text {
                anchors.centerIn: parent;
                text: "page5";
            }
        },
        ManuPrezPage {
            Text {
                anchors.centerIn: parent;
                text: "page6";
            }
        },
        ManuPrezPage {
            Text {
                anchors.centerIn: parent;
                text: "page7";
            }
        },
        ManuPrezPage {
            Text {
                anchors.centerIn: parent;
                text: "page8";
            }
        },
        ManuPrezPage {
            Text {
                anchors.centerIn: parent;
                text: "page9";
            }
        },
        ManuPrezPage {
            Text {
                anchors.centerIn: parent;
                text: "page10";
            }
        }
    ]
}

