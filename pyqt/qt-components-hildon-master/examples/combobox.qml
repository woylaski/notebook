import QtQuick 1.0
import org.hildon.components 1.0

Window {
    id: window
    
    title: qsTr("ComboBox Example")
    visible: true
    
    Column {
        id: column
        
        anchors.centerIn: parent
        width: 300
        spacing: platformStyle.paddingMedium
        
//![ComboBoxStyle]      
        ComboBox {
            width: parent.width
            model: [1, 2, 3, 4, 5]
        }
//![ComboBoxStyle]

//![OssoComboBoxStyle]
        ComboBox {
            width: parent.width
            model: [1, 2, 3, 4, 5]
            editable: true
            style: OssoComboBoxStyle {}
        }
//![OssoComboBoxStyle]
    }
}
