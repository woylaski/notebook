import QtQuick 2.5

QtObject {
    id: units

    /*!
       This is the standard function to use for accessing device-independent pixels. You should use
       this anywhere you need to refer to distances on the screen.
     */
    function dp(number) {
        return Math.round(number * Units.dp);
    }

    function gu(number) {
        return dp(number * Device.gridUnit)
    }
}
