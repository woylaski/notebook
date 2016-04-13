import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField {
    id: searchBar;
    placeholderText: "";
    textColor: "#333";

    style: TextFieldStyle {
        placeholderTextColor: "white";
        background: Item {
            width: control.width;
            height: control.height;
        }
    }
}
