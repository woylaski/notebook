import QtQuick 1.1

Rectangle {
    id: page

    property Theme theme : Theme {}

    width: childrenRect.width
    height: childrenRect.height
    color: theme.dashboardBackground

    Column {
        spacing: theme.tileSpacing

        Row {
            id: row1
            spacing: theme.tileSpacing

            BusInfo {
                id: columnA
                width: theme.tileWidth
                height: theme.tileHeight
                themeColor: theme.themeColor
                textColor: theme.fontColor
                headingFontSize: theme.fontSizeMedium
                fontType: theme.fontFamily
                stopID: "2190040"
                direction: "1"
            }
            BusInfo {
                width: theme.tileWidth
                height: theme.tileHeight
                themeColor: theme.themeColor
                textColor: theme.fontColor
                headingFontSize: theme.fontSizeMedium
                fontType: theme.fontFamily
                stopID: "2190040"
                direction: "2"
            }
            BusInfo {
                width: theme.tileWidth
                height: theme.tileHeight
                themeColor: theme.themeColor
                textColor: theme.fontColor
                headingFontSize: theme.fontSizeMedium
                fontType: theme.fontFamily
                stopID: "2190106"
                direction: "1"
            }
            BusInfo {
                width: theme.tileWidth
                height: theme.tileHeight
                themeColor: theme.themeColor
                textColor: theme.fontColor
                headingFontSize: theme.fontSizeMedium
                fontType: theme.fontFamily
                stopID: "3012552"
                direction: "1"
            }
        }

        Row {
            spacing: theme.tileSpacing
            anchors.left: parent.left

//            Newsreader {
//                width: theme.tileWidth
//                height: theme.tileHeight
//                id: aftenposten
//                themeColor: theme.themeColor
//                textColor: theme.fontColor
//                fontType: theme.fontFamily
//                headingFontSize: theme.fontSizeMedium

//                urlLogo: "aftenposten.svg"
//                xmlModel: XmlListModel {
//                    source: "http://www.aftenposten.no/rss"
//                    query: "/rss/channel/item"
//                    XmlRole { name: "title"; query: "title/string()".trim() }
//                    XmlRole { name: "description"; query: "description/string()".trim()}
//                }
//            }

            FlipTile {
                id: ticker
                theme: page.theme

                Timer {running:true; interval: 30*1000; repeat: true;
                    onTriggered: ticker.flipped = ! ticker.flipped;}

                front: Finance {
                    smooth: true
                    theme: page.theme
                    ticker: "NASDAQ:CSCO"
                }

                back: Finance {
                    theme: page.theme
                    smooth: true
                    ticker: "NASDAQ:GOOG"
                }
            }

            Weather {
                theme: page.theme
                width: theme.tileWidth * 2 + theme.tileSpacing
                height: theme.tileHeight
            }
        }

        Row {
            spacing: theme.tileSpacing
            anchors.left: parent.left

//            Matchbox {
//                products: "endeavour, charlie, helmet, snoopy"
//                theme: page.theme
//            }
        }

    } // column

}
