/****************************************************************************
**
** QML Resources manager
** Source: https://github.com/it-s/resqt
** (c) 2014 - Eugene Trounev (it-s)
** License: Apache License. See the LICENSE file for details
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Window 2.0

import "Scripts/Helpers.js" as Helpers
import "Scripts/Cache.js" as Cache

Item {
    id: manager

    visible: false // We don't want this element to be visible as it's just a holder

    property variant appWindow: null    //This has to be set to the main application window

    property string scalablePropertyPrefix: "s_"

    property int currentScreenWidth: 0
    property int currentScreenHeight: 0
    property int intendedScreenWidth: 0         //The width our original assets are targeted for
    property int intendedScreenHeight: 0        //The height our original assets are targeted for

    property bool scaleRoundUp: true
    property real scaleRatio: 1                 //Scale relation between our assets resolution and app resolution

    property bool refreshOnResize: false
    property bool ready: false

    //Signals Listeners -->
    //Signal we emit when resolution has changed and all the relevant values re-computed
    signal resolutionChanged

    function connectToAppWindow(){
        appWindow.widthChanged.connect(refreshScreenScaleRatio);
        appWindow.heightChanged.connect(refreshScreenScaleRatio);
    }

    function disconnectFromAppWindow(){
        appWindow.widthChanged.disconnect(refreshScreenScaleRatio);
        appWindow.heightChanged.disconnect(refreshScreenScaleRatio);
    }

    //Compute the scale ratio as soon as the Component is loaded
    Component.onCompleted: connectToAppWindow()

    //Internal "hidden*" functon to compute and set out scaleRatio, and scaleSuffix
    //relative to what application is at right now, versus what our resources support
    function refreshScreenScaleRatio(){
        var d, appd, suffixValue, suffixScale;
        var screenWidth = appWindow.width,
            screenHeight = appWindow.height;
        var cacheIsEmpty = Cache.isEmpty();
        ready = refreshOnResize? false : ready;
        //First lets check if all our required values are there:
        if (    !screenWidth ||
                !screenHeight||
                !intendedScreenWidth||
                !intendedScreenHeight||
                ready) return false;
        //Check if we already sclaed for this resolutionChanged
        //No need to do this again
        if (currentScreenWidth === screenWidth &&
                currentScreenHeight === screenHeight) return false;

        //Compute the diagonal length of the intended resolution (SHOULD)
        d = Math.sqrt(intendedScreenWidth*intendedScreenWidth + intendedScreenHeight*intendedScreenHeight);
        //Compute the diagonal length of the current app window (IS)
        appd = Math.sqrt(screenWidth*screenWidth + screenHeight*screenHeight);
        //Calculate the ration between what IS and what SHOULD be
        scaleRatio =  appd/d;

        //Refresh the presets
        for (var key in manager) {
            if (manager.hasOwnProperty(key)&&key.indexOf(scalablePropertyPrefix)===0&&key.indexOf("Changed")<0){
                //Save all the values for later
                if (cacheIsEmpty) Cache.set(key, manager[key]);
                manager[key] = scale(Cache.get(key));
            }
        }

        currentScreenWidth = screenWidth;
        currentScreenHeight = screenHeight;

        if (!refreshOnResize) disconnectFromAppWindow();

        resolutionChanged()
        return ready = true;
    }

//    Public Functions -->

    //Public function that calculates the value (width, height, top,...) based on current app screen scale
    // relative to what app was intended for, rounded to the next whole pixel
    function scale(n, ratio){
        // Choose the appropriate rounding method based on user prefference
        ratio = ratio || scaleRatio;
        var mFunc = scaleRoundUp? Math.ceil : Math.floor;
        return mFunc(n * ratio);
    }

    //Public function that calculates the width value relative to height, depending on the item specific sesttings
    // such as forceWidth/forceHeight, also taking in account other limitations such as min/max
    function scaleW(o){
        //Get object vars
        var p = Helpers.getResourceProperty(o, "width"),
            forceWidth = Helpers.getResourceProperty(o, "forceWidth"),
            forceHeight = Helpers.getResourceProperty(o, "forceHeight"),
            width = Helpers.getValue(p),
            height = Helpers.getValue(Helper.getResourceProperty(o, "height")),
                min = Helpers.getValue(p, "min"),
                max = Helpers.getValue(p, "max");
        //Check if we DON'T have the forced properties set
        // and then return scaled original width limited by min/max
        if ( forceWidth == 0 && forceHeight == 0 )
           return Helpers.clamp( scale( width ), min, max );
        //Check if forcedWidth is set and return that
        else if (forceWidth > 0) return forceWidth;
        //If none of the above is true then forceHeight is set for this element
        // so we calcualte item width relative to the forced height and return that
        else return scale( forceHeight, ( width / height ) );
    }

    //Public function that calculates the height value relative to width, depending on the item specific sesttings
    //such as forceWidth/forceHeight, also taking in account other limitations such as min/max
    function scaleH(o){
        //Get object vars
        var p = Helpers.getResourceProperty(o, "height"),
            forceWidth = Helpers.getResourceProperty(o, "forceWidth"),
            forceHeight = Helpers.getResourceProperty(o, "forceHeight"),
            width = Helpers.getValue(Helper.getResourceProperty(o, "width")),
            height = Helpers.getValue(p),
                min = Helpers.getValue(p, "min"),
                max = Helpers.getValue(p, "max");
        //Check if we DON'T have the forced properties set
        // and then return scaled original width limited by min/max
        if ( forceWidth ==0 && forceHeight == 0 )
            return Helpers.clamp( scale( height ), min, max );
        //Check if forceHeight is set and return that
        else if (forceHeight > 0) return forceHeight;
        //If none of the above is true then forceWidth is set for this element
        // so we calcualte item height relative to the forced width and return that
        else return scale( forceWidth, ( height / width ) );
    }
}
