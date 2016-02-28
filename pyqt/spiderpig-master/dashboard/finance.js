var callback;
var baseurl = "http://finance.google.com/finance/info?client=ig&q=";
//var ticker = "NASDAQ%3aCSCO";

function getCiscoStock(callbackFunction, ticker) {
    callback = callbackFunction;
    fetchQuote(ticker);
}

function fetchQuote(ticker) {
    getJsonFromUrl(baseurl+ticker);
}

function getJsonFromUrl(url) {
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {

        if (doc.readyState == XMLHttpRequest.DONE) {
            parseResult(doc.responseText);
        }
    }

    doc.open("GET", url);
    doc.send();
}

function parseResult(result) {
    result = result.replace("//", ""); // remove leading slashes
    var data = eval(result);
    var firstElement = data[0];
    callback(firstElement);
}

/*Example response text:
 // [ { "id": "99624" ,"t" : "CSCO" ,"e" : "NASDAQ" ,"l" : "19.06" ,"l_cur" : "19.06" ,"s": "0" ,"ltt":"4:00PM EST" ,"lt" : "Jan 13, 4:00PM EST" ,"c" : "-0.09" ,"cp" : "-0.47" ,"ccol" : "chr" } ]
*/
