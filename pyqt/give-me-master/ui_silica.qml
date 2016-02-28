import QtQuick 2.0;
import Sailfish.Silica 1.0;

ApplicationWindow {
    visible: true;
    cover: Component {
        CoverBackground {
            Label {
                text: "Give'me";
                anchors.centerIn: parent;
            }
        }
    }
    initialPage: Component {
        Page {
            allowedOrientations: Orientation.All;

            GiveMe { }
        }
    }
}
