import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

Item {
  id: multiDelegate
  height: 80
  width: multiDelegate.ListView.view.width

  function bestDelegate(t) {
    if(t == "image")
      return imgDelegate;
    return txtDelegate; // t == "text"
  }

  Component {
    id: imgDelegate

    Image {
      id: img
      source: value
      fillMode: Image.PreserveAspectFit
      asynchronous: true
    }
  }

  Component {
    id: txtDelegate

    Text {
      id: txt
      text: value
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter
    }
  }

  Loader {
    id: itemDisplay
    anchors.fill: parent;
    anchors.topMargin: 2
    anchors.bottomMargin: 2
    sourceComponent: bestDelegate(type)
  }

  Rectangle {
    id: separator
    width: parent.width; height: 1; color: "#cccccc"
    anchors.bottom: parent.bottom
  }
}