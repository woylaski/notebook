import QtQuick 2.5

Object {
    id: document

    //类似于json的字典类型，可以存储键值对
    property var data: {
        return {}
    }

    property int version: 1

    //获取name属性的值，def是默认值
    //如果有name属性的话，返回其属性值，否则返回默认值
    function get(name, def) {
        if (data.hasOwnProperty(name)) {
            return data[name]
        } else {
            return def
        }
    }

    //设置属性name值
    function set(name, value) {
        if ( data[name] !== value ) {
            data[name] = value
            //属性data的Changed信号
            dataChanged();
        }
    }

    function sync(name, value) {
        set(name,value);
        //属性绑定
        //Returns a JavaScript object representing a property binding.
        //bind to the result of the binding expression passed to Qt.binding()
        return Qt.binding(function() { return get(name, value) })
    }

    signal upgrade(var version)
    signal save()
    signal loaded()

    //从json串中加载
    function fromJSON(json) {
        if (!json) return
        data = JSON.parse(JSON.stringify(json))
        if (data.version < document.version) {
            //发射信号
            upgrade(data.version)
        } else if (data.version > document.version) {
            throw "Stored version is higher than the supported version: " + data.version + " > " + document.version
        }
        //发射信号
        loaded()
    }

    function toJSON() {
        //发射信号
        save()
        var json = JSON.parse(JSON.stringify(data))
        json.version = document.version
        return json
    }
}

