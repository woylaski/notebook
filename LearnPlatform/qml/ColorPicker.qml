import QtQuick 2.0

Item {
    id: root
    property color color: Qt.hsla(hue, saturation, lightness, alpha)
    property alias hue: hueSlider.value
    property alias saturation: saturationSlider.value
    property alias lightness: lightnessSlider.value
    property alias alpha: alphaSlider.value
    property bool showAlphaSlider: true

    width: parent.width
    height: 1
    Image {
        anchors.fill: map
        source: "images/background.png"
        fillMode: Image.Tile
    }

    Rectangle {
        id: colorBox
        anchors.fill: map
        color: root.color
    }

    ShaderEffect {
        id: map
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 5
        width: 68
        height: width
        opacity: .1
        property real hue: root.hue

        fragmentShader: "
            varying mediump vec2 qt_TexCoord;
            uniform highp float qt_Opacity;
            uniform highp float hue;

            highp float hueToIntensity(highp float v1, highp float v2, highp float h) {
            h = fract(h);
            if (h < 1. / 6.)
                return v1 + (v2 - v1) * 6. * h;
            else if (h < 1. / 2.)
                return v2;
            else if (h < 2. / 3.)
                return v1 + (v2 - v1) * 6. * (2. / 3. - h);

             return v1;
         }

         highp vec3 HSLtoRGB(highp vec3 color) {
             highp float h = color.x;
             highp float l = color.z;
             highp float s = color.y;

             if (s < 1. / 256.)
                 return vec3(l, l, l);

             highp float v1;
             highp float v2;
             if (l < .5)
                 v2 = l * (1. + s);
             else
                 v2 = (l + s) - (s * l);

             v1 = 2. * l - v2;

             highp float d = 1. / 3.;
             highp float r = hueToIntensity(v1, v2, h + d);
             highp float g = hueToIntensity(v1, v2, h);
             highp float b = hueToIntensity(v1, v2, h - d);
             return vec3(r, g, b);
         }

         void main() {
             lowp vec4 c = vec4(1.);
             c.rgb = HSLtoRGB(vec3(hue, 1. - qt_TexCoord.t, qt_TexCoord.s));
             gl_FragColor = c * qt_Opacity;
         }
         "

         MouseArea {
             id: mapMouseArea
             anchors.fill: parent
             hoverEnabled: true
             preventStealing: true
             onPositionChanged: {
                 if (pressed) {
                     var xx = Math.max(, Math.min(mouse.x, parent.width))
                     var yy = Math.max(, Math.min(mouse.y, parent.height))
                     root.saturation = 1. - yy / parent.height
                     root.lightness = xx / parent.width
                 }
             }
             onPressed: positionChanged(mouse)

             onEntered: map.opacity = 1
             onReleased: {
                 if (mouse.x <  || mouse.x > parent.width || mouse.y <  || mouse.y > parent.height) {
                     map.opacity = .1;
                 }
             }
             onExited: {
                 if (!pressed) {
                     map.opacity = .1;
                 }
             }
         }

         Image {
             id: crosshair
             source: "images/slider_handle.png"
             x: root.lightness * parent.width - width / 2
             y: (1. - root.saturation) * parent.height - height / 2
         }
     }

     Column {
         anchors.left: parent.left
         anchors.right: parent.right

         ColorSlider {
             id: hueSlider
             minimum: .
             maximum: 1.
             value: .5
             caption: "H"
             trackItem: Rectangle {
                 width: parent.height
                 height: parent.width - 1
                 color: "red"
                 rotation: -9
                 transformOrigin: Item.TopLeft
                 y: width
                 x: 5
                 gradient: Gradient {
                     GradientStop {position: .; color: Qt.rgba(1, , , 1)}
                     GradientStop {position: .167; color: Qt.rgba(1, 1, , 1)}
                     GradientStop {position: .333; color: Qt.rgba(, 1, , 1)}
                     GradientStop {position: .5; color: Qt.rgba(, 1, 1, 1)}
                     GradientStop {position: .667; color: Qt.rgba(, , 1, 1)}
                     GradientStop {position: .833; color: Qt.rgba(1, , 1, 1)}
                     GradientStop {position: 1.; color: Qt.rgba(1, , , 1)}
                 }
             }
         }

         ColorSlider {
             id: saturationSlider
             minimum: .
             maximum: 1.
             value: 1.
             caption: "S"
             handleOpacity: 1.5 - map.opacity
             trackItem: Rectangle {
                 width: parent.height
                 height: parent.width - 1
                 color: "red"
                 rotation: -9
                 transformOrigin: Item.TopLeft
                 y: width
                 x: 5
                 gradient: Gradient {
                     GradientStop { position: ; color: Qt.hsla(root.hue, ., root.lightness, 1.) }
                     GradientStop { position: 1; color: Qt.hsla(root.hue, 1., root.lightness, 1.) }
                 }
             }
         }

         ColorSlider {
             id: lightnessSlider
             minimum: .
             maximum: 1.
             value: .5
             caption: "L"
             handleOpacity: 1.5 - map.opacity
             trackItem: Rectangle {
                 width: parent.height
                 height: parent.width - 1
                 color: "red"
                 rotation: -9
                 transformOrigin: Item.TopLeft
                 y: width
                 x: 5
                 gradient: Gradient {
                     GradientStop { position: ; color: 'black' }
                     GradientStop { position: .5; color: Qt.hsla(root.hue, root.saturation, .5, 1.) }
                     GradientStop { position: 1; color: 'white' }
                 }
             }
         }

         ColorSlider {
             id: alphaSlider
             minimum: .
             maximum: 1.
             value: 1.
             caption: "A"
             opacity: showAlphaSlider ? 1. : .
             trackItem:Item {
                 anchors.fill: parent
                 Image {
                     anchors {fill: parent; leftMargin: 5; rightMargin: 5}
                     source: "images/background.png"
                     fillMode: Image.TileHorizontally
                 }
                 Rectangle {
                     width: parent.height
                     height: parent.width - 1
                     color: "red"
                     rotation: -9
                     transformOrigin: Item.TopLeft
                     y: width
                     x: 5
                     gradient: Gradient {
                         GradientStop { position: ; color: "transparent" }
                         GradientStop { position: 1; color: Qt.hsla(root.hue, root.saturation, root.lightness, 1.) }
                     }
                 }
             }
         }

         Label {
             caption: "ARGB"
             text: "#" + ((Math.ceil(root.alpha * 255) + 256).toString(16).substr(1, 2) + root.color.toString().substr(1, 6)).toUpperCase();
         }
     }
 }

