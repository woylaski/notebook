import QtQuick 1.1

Rectangle {
   width: 480
   height: 272
   color: "#4d84c2"

   //SIGNAL DECLARATIONS:
       signal writeModbusRegistersInt16(int startAddress, string value);//value must be string, not int, to be able to send arrays
       signal readModbusRegistersInt16(int startAddress, int numberOfConsecutiveRegisters);
       signal pollModbusRegistersInt16(int startAddress, int numberOfConsecutiveRegisters, int pollingIntervalMs);

       signal writeModbusRegistersString(int startAddress, string value, int numberOfConsecutiveRegisters);
       signal readModbusRegistersString(int startAddress, int numberOfConsecutiveRegisters);
       signal pollModbusRegistersString(int startAddress, int numberOfConsecutiveRegisters, int pollingIntervalMs);

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

    //FUNCTION DEFINITIONS:
    function onLoad()
    {
        setupRs232("/dev/ttyUSB0", 9600, "none", 8, 2);
        readModbusRegistersInt16(20, 1);
    }

    function int16Received(address, value)
    {
        switch (address)
        {
        case 20:
            text1.text = value;
            break;
        }
    }

    function stringReceived(address, value)
    {
        //no strings in use
    }

    function modbusReadError(startAddress, registerCount, errorCode, errorMessage)
    {
    }

    function modbusWriteError(startAddress, registerCount, errorCode, errorMessage)
    {
    }

    function modbusWriteSuccess(startAddress, registerCount)
    {
    }
    //END FUNCTION DEFINITIONS


   Button
   {
      id: btnMore; x: 170; y: 38; text: "More"
      onClicked:
      {
         text1.text = parseInt(text1.text) + 1;
         a1.start();
      }
   }
   Button
   {
      id: btnLess; x: 170; y: 182; text: "Less"
      onClicked:
      {
         text1.text = parseInt(text1.text) - 1;
         a2.start();
      }
   }
   Button
   {
      id: btnReset; x: 14; y: 106; text: "Reset"
      onClicked: readModbusRegistersInt16(20, 1);
   }

   Button
   {
      id: btnSubmit; x: 323; y: 106; text: "Submit"
      onClicked: writeModbusRegistersInt16(20, text1.text);
   }

   PropertyAnimation{id: a1; target: text1; easing.type: Easing.InCubic; properties: "color"; from: "green"; to: "black"; duration: 500;}
   PropertyAnimation{id: a2; target: text1; easing.type: Easing.InCubic; properties: "color"; from: "red"; to: "black"; duration: 500;}


   Text {
       id: text1
       x: 170
       y: 106
       width: 140
       height: 76
       text: qsTr("0")
       verticalAlignment: Text.AlignVCenter
       horizontalAlignment: Text.AlignHCenter
       font.pixelSize: 24
       onTextChanged:
       {
          if (text1.text > 10)
          {
             text1.text = 10;
          }
          else if (text1.text < -10)
          {
             text1.text = -10;
          }
       }
   }
}
