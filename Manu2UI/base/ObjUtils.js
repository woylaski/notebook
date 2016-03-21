.pragma library
.import QtQuick 2.5 as QtQuick

function listProperty(obj) {
    var keys = Object.keys(obj);
    for(var i = 0; i < keys.length; i++) {
        var key = keys[i];
        // prints all properties, signals, functions from object
        console.log(key + ' : ' + obj[key]);
        /*
        if (key === "x") {
            obj[key] = 100;
        }
        */
    }
}

function haveProperty(obj, property) {
    var keys = Object.keys(obj);
    for(var i = 0; i < keys.length; i++) {
        var key = keys[i];

        if(key == property) return true
        // prints all properties, signals, functions from object
        //console.log(key + ' : ' + obj[key]);
        /*
        if (key === "x") {
            obj[key] = 100;
        }
        */
    }

    return false
}

function fuzzyProperty(obj, keyword) {
    var keys = Object.keys(obj);
    for(var i = 0; i < keys.length; i++) {
        var key = keys[i];
        // prints all properties, signals, functions from object
        if(key.toLowerCase().match(keyword))
            console.log(key + ' : ' + obj[key]);
    }
}

function findRoot(obj) {
    while (obj.parent) {
        obj = obj.parent;
    }

    return obj;
}

function findRootChild(obj, objectName) {
    obj = findRoot(obj);

    var childs = new Array(0);
    childs.push(obj);
    while (childs.length > 0) {
        if (childs[0].objectName == objectName) {
            return childs[0];
        }
        for (var i in childs[0].data) {
            childs.push(childs[0].data[i]);
        }
        childs.splice(0, 1);
    }
    return null;
}

//QtObject对象只有一个属性就是objectName,c++里面可以通过objectName来查找对象
function findChild(obj,objectName) {
    var childs = new Array(0);
    childs.push(obj);
    while (childs.length > 0) {
        if (childs[0].objectName == objectName) {
            return childs[0];
        }
        for (var i in childs[0].data) {
            childs.push(childs[0].data[i]);
        }
        childs.splice(0, 1);
    }
    return null;
}

function newObject(path, args, parent) {
    if (!args)
        args = {};

    args.parent = parent;

    var component = Qt.createComponent(path);
    if (component.status === QtQuick.Component.Error) {
        // Error Handling
        print("Unable to load object: " + path + "\n" + component.errorString());
        return null;
    }

    return component.createObject(parent, args);
}
