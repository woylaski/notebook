import QtQuick 2.3
import Material.Extras 0.1

Item {
    function makePromise() {
        var myvalue = "";

        var promise = new Promises.Promse();
        promise.info.myinfo = "cool info";
        promise.then(function( data, info ) {
                // send data to the next step
                return info.myinfo + " " + data;
        });

        promise.done(function( data, info ) {
                // do something with the data of resolve(...)
        });

        promise.error(function( error, info ) {
                // do something with the data of reject(...)
        });
    }
}