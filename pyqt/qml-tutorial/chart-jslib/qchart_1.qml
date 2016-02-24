import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import jbQuick.Charts 1.0

Chart {
    id: chart_line;
    width: 400;
    height: 400;

    chartAnimated: true;
    chartAnimationEasing: Easing.InOutElastic;
    chartAnimationDuration: 2000;
    chartType: Charts.ChartType.LINE;

    Component.onCompleted: {
        //chartData = ...;
        console.log("hello world")
    }
}