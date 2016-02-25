import QtWebChannel 1.0

import QtWebKit 3.0
import QtWebKit.experimental 1.0

//Now, let’s create an object that we want to publish to the HTML/JavaScript clients:

QtObject {
    id: myObject

    // the identifier under which this object
    // will be known on the JavaScript side
    WebChannel.id: "foo"

    // signals, methods and properties are
    // accessible to JavaScript code
    signal someSignal(string message);

    function someMethod(message) {
        console.log(message);
        someSignal(message);
        return "foobar";
    }

    property string hello: "world"
}

//Publishing the object to the HTML clients in your WebView is as simple as

WebView {
    experimental.webChannel.registeredObjects: [myObject]
}
To copy to clipboard, switch view to plain text mode
