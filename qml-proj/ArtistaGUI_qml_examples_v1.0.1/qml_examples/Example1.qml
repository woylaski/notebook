import QtQuick 1.1

Rectangle {
    id: rectangle11
    width: 480
    height: 272
    color: "#eeee69"

//SIGNAL DECLARATIONS:
    signal writeModbusRegistersInt16(int startAddress, string value);//value must be string, not int, to be able to send arrays
    signal readModbusRegistersInt16(int startAddress, int numberOfConsecutiveRegisters);
//    signal pollModbusRegistersInt16(int startAddress, int numberOfConsecutiveRegisters, int pollingIntervalMs);

    signal writeModbusRegistersString(int startAddress, string value, int numberOfConsecutiveRegisters);
    signal readModbusRegistersString(int startAddress, int numberOfConsecutiveRegisters);
//    signal pollModbusRegistersString(int startAddress, int numberOfConsecutiveRegisters, int pollingIntervalMs);

    signal useSwappedByteOrderForInt16(bool doSwap);
    signal useSwappedByteOrderForString(bool doSwap);

    //FOLLOWING SIGNALS ARE VALID IN onLoad()
    signal setupRs232(string port, int baudRate, string parity, int dataBits, int stopBits);
    signal setModbusSlaveId(int targetDeviceSlaveId);
    signal setModbusByteTimeout(int timeoutMs);
    signal setModbusResponseTimeout(int timeoutMs);
//END SIGNAL DECLARATIONS

    function networkPropertyWriteError(propertyName, errorMessage) {}
    function networkPropertyWriteSuccess(propertyName) {}
    function networkPropertyReadError(propertyName, errorMessage) {}
    function networkPropertyReadSuccess(propertyName,value) {}
    function tagWriteError(tagName, errorMessage) {}
    function tagWriteSuccess(tagName) {}
    function tagReadError(tagName, errorMessage) {}
    function tagReadSuccess(tagName, value) {}
    
    signal writeArtistaNetworkProperty(string propertyName, string value);
    signal readArtistaNetworkProperty(string propertyName);
    signal writeArtistaTag(string tagName, string Value);
    signal readArtistaTag(string tagName);
    signal resetArtistaNetworking();

    function onLoad()
    {
        setupRs232("/dev/ttyUSB0", 9600, "none", 8, 2);
//        pollModbusRegistersInt16(10, 2, 3000);
    }

    function int16Received(address, value)
    {
        var ar = value.split(',');
        switch (address)
        {
            case 10://40010
                textTotal.text = ar[0];
                textAvailable.text = ar[1];
                break;
        }
    }  // slot

    function stringReceived(address, value)
    {
        //no strings in use
    }

    function modbusReadError(startAddress, registerCount, errorCode, errorMessage)
    {
        switch (startAddress)
        {
            case 10:
                textTotal.text = "--";
                textAvailable.text = "--";
                break;
        }
    }

    function modbusWriteError(startAddress, registerCount, errorCode, errorMessage)
    {
       //nothing gets written
    }

    function modbusWriteSuccess(startAddress, registerCount)
    {
    }

    Timer
    {
        interval: 3000; running: true; repeat: true; triggeredOnStart: true;
        onTriggered: readModbusRegistersInt16(10, 2);
    }

    Text {
        id: label1
        x: 111
        y: 128
        width: 39
        height: 15
        text: qsTr("Total")
        font.pixelSize: 12
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    Text {
        id: textTotal
        x: 175
        y: 124
        text: qsTr("120")
        font.pixelSize: 21
    }

    Text {
        id: label2
        x: 241
        y: 128
        width: 59
        height: 15
        text: qsTr("Available")
        font.pixelSize: 12
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    Text {
        id: textAvailable
        x: 316
        y: 124
        text: qsTr("25")
        font.pixelSize: 21
        onTextChanged: color = text > 10 ? "green" : "red";
    }
}
