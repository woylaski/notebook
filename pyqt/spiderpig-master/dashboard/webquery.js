var callback;
var baseurl = "http://localhost:8080/"
var errorCallback = 0

function getData(query, callbackFunction, errorcallback) {

    callback = callbackFunction;
    errorCallback = errorcallback;
    getJsonFromUrl(baseurl + query);
}

function getJsonFromUrl(url) {
    var doc = new XMLHttpRequest();
    //console.log("url: " + url);
    var httpResponseValid = 200;

    doc.onreadystatechange = function() {

        if (doc.readyState == XMLHttpRequest.DONE) {
            if (doc.status != httpResponseValid) {
                if (errorCallback)
                    errorCallback();
                return;
            }

            //console.log("readystate: done. status=" + doc.status)
            parseResult(doc.responseText);
        }
    }

    doc.open("GET", url);
    doc.send();
}

function parseResult(result) {
    // Json string must be wrapped in () due to ambiguity in javascript syntax (http://www.json.org/js.html)
    result = "(" + result + ")";
    var data = eval(result);
    callback(data);
}

// useful to inspect a json object (debuggin etc)
// found on http://stackoverflow.com/questions/722668/traverse-all-the-nodes-of-a-json-object-tree-with-javascript
// Feb 2012
function inspect(json) {
    traverse(json, process);
}
function traverse(o,func) {
    for (var i in o) {
        func.apply(this,[i,o[i]]);
        if (typeof(o[i])=="object") {
            //going on step down in the object tree!!
            traverse(o[i],func);
        }
    }
}
//called with every property and it's value
function process(key,value) {
    console.log(key + " : "+value);
}
