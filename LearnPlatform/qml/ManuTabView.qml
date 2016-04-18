import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import "."

TabView{
    id: root
    anchors.fill: parent
    tabPosition: Qt.TopEdge //Qt.BottomEdge
    tabsVisible: true
    frameVisible: true

    function getTabCount(){
        return count;
    }

    function getCurrentIndex(){
        return currentIndex;
    }

    function add(title, comp){
        addTab(title, comp)
    }

    function get(index){
        getTab(index)
    }

    function insert(index, title, comp){
        insertTab(index, title, comp)
    }

    function move(from, to){
        moveTab(from,to)
    }

    function remove(index){
        removeTab(index)
    }

    /*Tab{
    }*/
}
