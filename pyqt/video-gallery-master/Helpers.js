.pragma library;

var extensions = ["mkv", "avi", "mp4", "m4v", "mov", "flv", "ogv"];

Array.prototype.contains = function (val) {
    return (this.indexOf (val) >= 0);
}

function formatMsecs (ms) {
    var ret = "";
    if (ms !== undefined) {
        var hh = Math.floor (ms / 3600000);
        ms -= (hh * 3600000);
        var mm = Math.floor (ms / 60000);
        ms -= (mm * 60000);
        var dd = Math.floor (ms / 1000);
        ret = ((hh >= 10 ? hh : "0" + hh) + ":" +
               (mm >= 10 ? mm : "0" + mm) + ":" +
               (dd >= 10 ? dd : "0" + dd));
    }
    return ret;
}
