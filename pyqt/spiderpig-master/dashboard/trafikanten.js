/** See example format bottom */

var callbackFunction;

function getBusData(callback, stop_id, direction) {
    callbackFunction = callback;
    //var STOP_ID_OKSENOYVEIEN = 2190040;
    var url = "http://api-test.trafikanten.no/RealTime/GetRealTimeData/" + stop_id //STOP_ID_OKSENOYVEIEN;
    getJsonFromUrl(url, direction);
}

function getJsonFromUrl(url, direction) {
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {

        if (doc.readyState == XMLHttpRequest.DONE) {
            //console.log(doc.responseText);
            //busText.text = doc.responseText;
            var busData = eval(doc.responseText);
            parseBusData(busData, direction);
        }
    }

    doc.open("GET", url);
    doc.send();
}

function parseTime(trafikantenString) {
    var t1 = (trafikantenString.split('(')[1]);
    var t2 = t1.split('+')[0];
    var t3 = parseInt(t2);
    return t3;//return new Date(t3);
}

function parseBusData(busData, direction) {
    var b = new Array();
    for (var i=0; i<busData.length; i++) {
        var data = busData[i];

        if (busData[i].DirectionName == direction) {
            //console.log(data.LineRef +", " + data.DestinationDisplay + ", " + new Date(parseTime(data.ExpectedArrivalTime)) + ", " + data.VehicleRef);
            b[b.length] = {};
            b[b.length-1].lineNumber = data.LineRef;
            b[b.length-1].lineName = data.DestinationDisplay;
            b[b.length-1].direction = data.DirectionName;
            b[b.length-1].expectedArrivalTime = new Date(parseTime(data.ExpectedArrivalTime));
            b[b.length-1].timeUntilArrival = parseInt((parseTime(data.ExpectedArrivalTime) - parseTime(data.RecordedAtTime)) / (1000*60));
            b[b.length-1].realtime = data.Monitored;
            b[b.length-1].id = data.VehicleRef;
        }
    }

    callbackFunction(b);
}

/**
  * Bus data example from url:
  {
    "RecordedAtTime": "\/Date(1326455752887+0100)\/",
    "PublishedLineName": "151",
    "DirectionName": "2",
    "LineRef": "151",
    "DirectionRef": "2",
    "OperatorRef": "Norgesbuss",
    "DestinationName": "Rykkinn",
    "Monitored": true,
    "VisitNumber": 12,
    "AimedArrivalTime": "\/Date(1326455760000+0100)\/",
    "ExpectedArrivalTime": "\/Date(1326455942000+0100)\/",
    "ArrivalPlatformName": "",
    "AimedDepartureTime": "\/Date(1326455760000+0100)\/",
    "ExpectedDepartureTime": "\/Date(1326455942000+0100)\/",
    "DeparturePlatformName": "2",
    "BlockRef": "1515281",
    "DestinationDisplay": "Rykkinn",
    "StopPointName": "",
    "MonitoringRef": "2190040",
    "Delay": "PT182S",
    "ProgressStatus": "",
    "VehicleRef": "328991",
    "NextStopPointName": "",
    "StopVisitNote": "",
    "FramedVehicleJourneyRef": [
      {
        "DataFrameRef": "2012-01-13",
        "DatedVehicleJourneyRef": "528103"
      }
    ],
    "VehicleFeatureRef": "",
    "TrainBlockPart": [],
    "VehicleFeature": "",
    "VehicleAtStop": "false",
    "InCongestion": "false",
    "DestinationRef": "2190795",
    "OriginName": "OBUS",
    "OriginRef": "3010619",
    "VehicleMode": "bus"
  }
*/

