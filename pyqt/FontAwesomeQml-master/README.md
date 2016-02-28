FontAwesomeQml
================

FontAwesomeQml provides the [Font Awesome] web fonts to Qt Quick/QML engine.

## How to use

1. Add the directory FontAwesome to your project ('sample' subdirectories could be removed in production)

2. Add 'FontAwesomQml.qrc' to your project ressources

RESOURCES += path_to/FontAwesomeQml/FontAwesomeQml.qrc
			
3. Import FontAwesome types

````javascript
import "qrc:/FontAwesome" 4.5
````

4. Using Font Awesome:

````javascript
// main.qml

import "qrc:/FontAwesome" 4.5   // Module version match FontAwesome releases

Window {
  Text {
    anchors.horizontalCenter: parent.horizontalCenter
    font.family: FontAwesome.family
    text: FontAwesome.fa_money
  }
}
````

## Avaliable Properties in FontAwesome singleton component

````javascript
// Directly acess individual font-awesome variables from FontAwesome component properties:
var myCharacter = FontAwesome.fa_money 
var myCharacter = FontAwesome.fa_dollar

// Property to chech if the Font Loader it is ready, if it is using the remote
// font-awesome CDN it is necessary to check and wait for to be true.
property alias loaded: false

// Set font-awesome Font Loader source: FontAwesome.source
property alias resource

// Return font family name: FontAwesome.family
readonly property string family: "FontAwesome"
````

## Considerations

Original Font Awesome "-" character where replaced by '_' because QML/JS doesn't accept minus character for variables name.

Icons codes are available in [FontAwesome.qml] file.

Setting a FA icon as a QML Button icon code has been removed from this fork, the following control could be used if necessary:
https://github.com/EMSSConsulting/font-awesome-qml/blob/master/controls/Button.qml

However the "right way" of inserting a FA icon in a Button control is either exporting it to multiple resolution PNG files or
providing a custom Qt Quick image provider.

## Versions Tested

````
Qt Version   : 5.6  (MSVC2015x64)
Font Awesome : 4.5.0
````

## Screenshot

![screenshot](/sample/screenshot/FontAwesomeQml.png?raw=true)

## Thanks

[Font Awesome] - The iconic font and CSS toolkit.

[Qt Project] - True cross-platform framework.

"[Using Fonts Awesome in QML]" by markg85.

## Credits

Created by Ricardo do Valle.

Forked from https://github.com/QMLCommunity/font-awesome-qml

Forked from https://github.com/EMSSConsulting/font-awesome-qml

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[Font Awesome]: http://fortawesome.github.io/Font-Awesome/
[Qt Quick]: http://qt-project.org/doc/qt-5/qtquick-index.html
[Qt Project]: http://qt-project.org
[Using Fonts Awesome in QML]: http://kdeblog.mageprojects.com/2012/11/20/using-fonts-awesome-in-qml/
[controls/Variables.qml]: controls/Variables.qml

## Licence

MIT