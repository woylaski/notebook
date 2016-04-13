pragma Singleton

import QtQuick 2.0

QtObject
{
    property double scaleRatio: {
        if (typeof c_dpi == 'undefined')
            return 1.0

        return c_dpi
    }

    function scale (input) {
        console.log("app scale func")
        console.log("input is ",input, "scaleRatio is ", scaleRatio)
        return input * scaleRatio
    }

    function getSize (string) {
        switch (string) {
        case "small":
            return scale (12)
        case "medium":
            return scale (14)
        case "large":
            return scale (18)
        case "x-large":
            return scale (22)
        }

        return scale (12)
    }

    function resolve(name)
    {
        if(!name)
            name = 'm1';

        var r = size[name];

        if(r)
            return r;
        else
            return name;
    }

    readonly property var size:
    {
        'h1': 89,
        'h2': 55,
        'h3': 34,
        'm2': 21,
        'm1': 13,
        's1': 8,
        's2': 5
    }
}
