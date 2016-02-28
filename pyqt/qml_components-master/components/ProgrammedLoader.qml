
import QtQuick 2.2


Loader {
    property date begin_at
    property date end_at

    QtObject {
        id: internal
        property url delayed_source
        property var delayed_source_component
    }

    Component.onCompleted: {
        if (source != "") {
            internal.delayed_source = source
            source = (Date.now() >= begin_at && Date.now() < end_at) ? internal.delayed_source : ""
        } else if (typeof sourceComponent !== "undefined") {
            internal.delayed_source_component = sourceComponent
            sourceComponent = (Date.now() >= begin_at && Date.now() < end_at) ? internal.delayed_source_component : undefined
        }
    }
    Timer {
        interval: parent.begin_at - Date.now()
        onTriggered: { 
            if (internal.delayed_source != "")
                parent.source = internal.delayed_source
            else if (typeof internal.delayed_source_component !== "undefined")
                parent.sourceComponent = internal.delayed_source_component
        }
        running: parent.begin_at > Date.now()
    }
    Timer {
        interval: parent.end_at - Date.now()
        onTriggered: {
            if (internal.delayed_source != "")
                parent.source = ""
            else if (typeof internal.delayed_source_component !== "undefined")
                parent.sourceComponent = undefined
        }
        running: parent.end_at > Date.now()
    }
}
