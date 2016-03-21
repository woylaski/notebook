import QtQuick 2.5
pragma Singleton
/*
  1英寸(in)=25.4毫米(mm)
  dpi=dots per inch，标准是160pix/inch
  dp = (DPI/(160像素/英寸))
  像素间距(pixel pitch)

  pix perl inch = dp*160pix/inch
  inch = dp*160 pix
  mm = dp*160/25.4 pix

  base pix size= 1/160 inch
  base pix size in device = dp*basepix

  以标准160pix/inch为参照目标
  dp为1上的设备一个pix的大小 需要dp为2的设备上两个pix的大小才能一样

  标准160pix/inch的一个像素的大小mm = 1*25.4/160 mm
  在一个dp为n的设备上同样大小需要 n*(1*25.4/160)

  这样不管在任何设备上详实一个dp（1）的大小都是 跟160标准上看到的是一样的

  在任何设备上dp(1)实际的物理大小都是一样的，都是160pix/inch上一个像素的大小
  pixel是相对大小，而dp是绝对大小
*/
Object {
    id: units
    objectName: "device"

    /*!
       \internal
       This holds the pixel density used for converting millimeters into pixels. This is the exact
       value from \l Screen:pixelDensity, but that property only works from within a \l Window type,
       so this is hardcoded here and we update it from within \l ApplicationWindow
     */
    property real pixelDensity: 4.46
    property real multiplier: 1.4 //default multiplier, but can be changed by user

    function setDensity(density){
        pixelDensity = density
        print("set density to ", density)
    }

    /*!
       This is the standard function to use for accessing device-independent pixels. You should use
       this anywhere you need to refer to distances on the screen.
     */
    function dp(number) {
        return Math.round(number*((pixelDensity*25.4)/160)*multiplier);
    }

    function gu(number) {
        return number * gridUnit
    }

    property int gridUnit: dp(64)

    function printUintsInfo(){
        print("units pixelDensity: ", pixelDensity)
        print("units multiplier: ", multiplier)
        print("units gridUnit: ", gridUnit/dp(1))
    }
}



