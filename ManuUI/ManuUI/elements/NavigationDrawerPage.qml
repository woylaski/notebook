import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls

Page {
    id: navPage

    backAction: navDrawer.action
    title: page.title
    actions: page.actions
    actionBar.backgroundColor: page.actionBar.backgroundColor
    actionBar.decorationColor: page.actionBar.decorationColor

    property var navDrawer

    property var page

    function navigate(page) {
        navPage.page = page
        navDrawer.close()
    }

    onNavDrawerChanged: navDrawer.parent = navPage

    onPageChanged: stackView.push({ item: page, replace: true })

    Controls.StackView {
        id: stackView
        anchors.fill: parent
    }
}

