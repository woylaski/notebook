import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls.Styles 1.4 as Styles

Page {
    id: page

    default property alias content: tabView.data

    readonly property Tab selectedTab: tabView.count > 0
            ? tabView.getTab(selectedTabIndex) : null

    tabs: tabView

    onSelectedTabIndexChanged: tabView.currentIndex = page.selectedTabIndex

    Controls.TabView {
        id: tabView

        currentIndex: page.selectedTabIndex
        anchors.fill: parent

        tabsVisible: false

        // Override the style to remove the frame
        style: Styles.TabViewStyle {
            frameOverlap: 0
            frame: Item {}
        }

        onCurrentIndexChanged: page.selectedTabIndex = currentIndex

        onCountChanged: {
            for (var i = 0; i < count; i++) {
                var tab = getTab(i)
                if (tab.hasOwnProperty("index"))
                    tab.index = i
                if (tab.hasOwnProperty("__tabView"))
                    tab.__tabView = tabView
            }
        }
    }
}


