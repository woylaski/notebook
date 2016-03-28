import QtQuick 2.5
import QtQuick.Controls 1.4 as Controls
import "qrc:/base/base" as Base
import "qrc:/style/style" as Style

//slider: Provides a vertical or horizontal slider control
Controls.Slider {
    id: slider

    /*!
       Set to \c true to enable a floating numeric value label above the slider knob
     */
    property bool numericValueLabel: false

    /*!
       Set to \c true to always show the numeric value label, even when not pressed
     */
    property bool alwaysShowValueLabel: false

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    /*!
       The label to display within the value label knob, by default the sliders current value
     */
    property string knobLabel: slider.value.toFixed(0)

    /*!
       The diameter of the value label knob
     */
    property int knobDiameter: Base.Units.dp(32)

    property color color: darkBackground ? Base.Theme.dark.accentColor
                                         : Base.Theme.light.accentColor

    tickmarksEnabled: false

    implicitHeight: numericValueLabel ? Base.Units.dp(54) : Base.Units.dp(32)
    implicitWidth: Base.Units.dp(200)

    style: Style.SliderStyle {}
}

