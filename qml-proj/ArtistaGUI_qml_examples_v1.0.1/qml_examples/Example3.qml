import QtQuick 1.1

Rectangle {
   width: 480
   height: 272
   color: "#4d84c2"

   //SIGNAL DECLARATIONS:
       signal writeModbusRegistersInt16(int startAddress, string value);//value must be string, not int, to be able to send arrays
       signal readModbusRegistersInt16(int startAddress, int numberOfConsecutiveRegisters);

       signal writeModbusRegistersString(int startAddress, string value, int numberOfConsecutiveRegisters);
       signal readModbusRegistersString(int startAddress, int numberOfConsecutiveRegisters);

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

    //ARTISTAGUI FUNCTION DEFINITIONS:
    function onLoad()
    {
        setupRs232("/dev/ttyUSB0", 9600, "none", 8, 2);
    }

    function int16Received(address, value)
    {
        var ar = value.split(',');
        switch (address)
        {
        case 20:
            text1.text = value;
            break;
         case 35:

             var dialogId = parseInt(ar[0]);
             var dialogStatus = parseInt(ar[1]);
             if (dialogStatus === 1) //received show dialog flag
             {
                 if (dialogId === 1)
                 {
                     showDialog("Changes accepted! Transaction id is " + ar[2] + " - " + ar[3],
                                1, 0);
                     writeModbusRegistersInt16(36, 2);
                 }
                 else if (dialogId === 2)
                 {
                     showDialog("Submit request declined", 1, 0);
                     writeModbusRegistersInt16(36, 2);
                 }
             }
             else if (dialogStatus === 9) //received hide dialog flag
             {
                 dialog.hide();
             }
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
       switch (startAddress)
       {
       case 30:
           showDialog("Submit failed: " + errorMessage, 1, 0);
           break;
       }
    }

    function modbusWriteSuccess(startAddress, registerCount)
    {

       switch (startAddress)
       {
       case 30:
           showDialog("Submitting new values...", 0, 0);
           break;
       }

    }
   //END ARTISTGUI FUNCTION DEFINITIONS

    //
   function showDialog(text, showOkBtn, showCancelBtn)
   {
       dialog.text = text;
       dialog.showOkButton = showOkBtn;
       dialog.showCancelButton = showCancelBtn;
       dialog.show();
       dialogTimer.running = true;
       //emit signal?
   }

   function hideDialog()
   {
       dialog.hide();
       //emit signal?
   }

   Timer
   {
       id: poll1
       interval: 3000; running: true; repeat: true; triggeredOnStart: true;
       onTriggered: readModbusRegistersInt16(35, 4);
   }

   Timer
   {
       id: dialogTimer
       interval: 10000; running: false; repeat: false;
       onTriggered: hideDialog();
   }


   Button
   {
      id: btnMore; x: 170; y: 38; text: "More"
      onClicked: text1.text = parseInt(text1.text) + 1;
   }
   Button
   {
      id: btnLess; x: 170; y: 182; text: "Less"
      onClicked: text1.text = parseInt(text1.text) - 1;
   }
   Button
   {
      id: btnReset; x: 14; y: 106; text: "Reset"
      onClicked: readModbusRegistersInt16(20, 1);
   }

   Button
   {
      id: btnSubmit; x: 323; y: 106; text: "Submit"
      onClicked:
      {
          writeModbusRegistersInt16(30, text1.text);
      }
   }

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


   ModalDialog {
       id:dialog
       x: 0
       y: 0
       anchors.rightMargin: 0
       anchors.bottomMargin: 0
       anchors.leftMargin: 0
       anchors.topMargin: 0
       anchors.fill: parent
//        fontName: visual.defaultFontFamily;
//        fontColor: visual.defaultFontColor;
//        fontColorButton: visual.defaultFontColorButton;
//        fontSize: visual.defaultFontSize;
       showCancelButton: false;
       dialogTimeoutMs: 3000;

       onAccepted:
       {
           console.log("Accepted");
           writeModbusRegistersInt16(36, 3);
       }
       onCancelled:
       {
           console.log("Canceled");
           writeModbusRegistersInt16(36, 4);
       }
       onTimeout:
       {
           console.log("Timeouted");
           writeModbusRegistersInt16(36, 5);
       }
   }

}
