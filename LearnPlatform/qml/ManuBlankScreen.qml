import QtQuick 2.5
import "js/ObjUtils.js" as ObjUtils

Item {
    id: blankScreen

    enabled: {
        var topItem=ObjUtils.findRootChild(blankScreen,"docAreaStackView")
        if(typeof(topItem)=='undefined'){
            print("not have docAreaStackView item");
            return false;
        }

        print("docAreaStackView busy ", topItem.busy);
        //return topItem.busy
        return !topItem.busy
    }
}

