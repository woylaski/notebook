
var urlPush = "/writeIncomingObject/";
var urlPull = "/readIncomingObject/";

function popIncomingObject(callback) {
    var url = urlPull;
    var data = "";
    $.get(url, data, function(response) {
        //console.log("success!", response);
        var data = JSON.parse(response);
        callback(data);
    });
}

function pushIncomingObject(jsonIncomingObject) {
    $.ajax({
        url: urlPush,
        type: "POST",
        data: JSON.stringify(jsonIncomingObject),
        dataType: "json",
        contentType: "application/json",
        success: function(response) {
            console.log("success!", response);
        }
    });
}
