import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import Slideshow 1.0 as SS
import "." as App

SS.Slide {
    id: slide
    
    fontFamily: "Roboto Slab"

    header.border.width: 2
    header.line.visible: false

    header.font.bold: true
    header.text: "header"

    body.border.width: 2
    body.text: "body"

//    body.content.border.width: 2
//    body.text: "body.content"

    footer.border.width: 2
    footer.line.visible: false

    footer.leftText: ""
    footer.text: "footer"
    footer.rightText: ""
}
