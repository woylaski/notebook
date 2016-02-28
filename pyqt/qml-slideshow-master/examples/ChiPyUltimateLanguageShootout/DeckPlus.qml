import QtQuick 2.4
import QtQuick.Window 2.2
import Slideshow 1.0 as SS
import "." as App

SS.Deck {
    title: "ChiPy Ultimate Language Shootout"

    property string subtitle: "Python vs QML"

    focus: true

    Keys.onEnterPressed: {
        countdown.restart();
    }

    SS.Countdown {
        id: countdown
        seconds: 5 * 60  // 5 minutes.
    }

    App.GameOfLifeSlide {
        black: true
        grid.columns: 50
        grid.rows: 30
        interval: 500
    }

    App.Slide {
        header.visible: false;
        body.color: "Transparent"
        footer.visible: false;

        text: deck.subtitle
        body.font.bold: true
        body.font.family: "Roboto Slab"
        textHeight: 14

        gradient: Gradient {
            GradientStop { position: 0.0; color: "White" }
            GradientStop { position: 1.0; color: "Silver" }
        }
    }

    App.Slide {
        header.visible: false;
        body.color: "Transparent"
        footer.visible: false;

        image.source: "poster.jpeg"
        image.anchors.fill: image.parent
        image.fillMode: Image.Tile
        image.opacity: 0.3
        image.sourceSize.height: 300

        text: deck.subtitle
        body.font.bold: true
        body.font.family: "Roboto Slab"
        textHeight: 14

        body.__centralText.style: Text.Raised
        body.__centralText.styleColor: "Yellow"

        gradient: Gradient {
            GradientStop { position: 0.0; color: "White" }
            GradientStop { position: 1.0; color: "Black" }
        }
    }

    App.Slide {
        text: "
Pick any programming language. Present and introduce the language
at the May 14th ChiPy meeting. Do at least 1 comparison to Python.
"
    }

    App.Slide {
        text: "
Audience members will vote on their favorite presentation
and the winner takes home $100s in cash.
"
    }

    App.Slide {
        text: "
Talks should be approximately %1 minutes.
".arg(countdown.remainingText)
    }

    App.Slide {
        body.text: deck.subtitle
        body.font.bold: true
        body.font.family: "Roboto Slab"
        textHeight: 2
        Behavior on textHeight {
            NumberAnimation { duration: 2000 }
        }
        onEntered: textHeight = 15
        onExited: textHeight = 2
    }

    App.Slide {
        title: "Your Presenter Boasted"
        body.margin: margin * 6
        text: '
"If you think Python is Pythonic, wait until you see QML
from the point of view of an experienced Python developer."
'
    }

//    App.Slide {
//        title: "Your Presenter"
//        text: "Patrick Keith O'Brien"
//    }

//    App.Slide {
//        title: "Your Presenter"
//        text: "Pythonista since 1999"
//    }

//    App.Slide {
//        title: "Your Presenter"
//        text: "Worked with wxPython, PyGTK, PyQt"
//    }

//    App.Slide {
//        title: "What is QML?"
//        text: "
//QML, the Qt Meta Language or Qt Modeling Language, is a declarative
//language supported by the Qt application framework and GUI toolkit
//(written in C++).
//"
//    }

//    App.Slide {
//        title: "What does it mean to be Pythonic?"
//        codeHeight: 3
//        code: "
//>>> import this
//The Zen of Python, by Tim Peters

//Beautiful is better than ugly.
//Explicit is better than implicit.
//Simple is better than complex.
//Complex is better than complicated.
//Flat is better than nested.
//Sparse is better than dense.
//Readability counts.
//Special cases aren't special enough to break the rules.
//Although practicality beats purity.
//Errors should never pass silently.
//Unless explicitly silenced.
//In the face of ambiguity, refuse the temptation to guess.
//There should be one-- and preferably only one --obvious way to do it.
//Although that way may not be obvious at first unless you're Dutch.
//Now is better than never.
//Although never is often better than *right* now.
//If the implementation is hard to explain, it's a bad idea.
//If the implementation is easy to explain, it may be a good idea.
//Namespaces are one honking great idea -- let's do more of those!
//"
//    }

//    App.Slide {
//        title: deck.subtitle
//        text: '
//Working with QML gives me the same good *feelings* as when I work with Python.
//'
//    }

//    App.Slide {
//        title: deck.subtitle
//        topLeft: Text {
//            font.family: slide.fontFamily
//            font.pixelSize: slide.units(slide.textHeight - 2)
//            width: slide.grid.width / 2
//            wrapMode: Text.WordWrap
//            text: "
//Python:

//* procedural, functional, object-oriented

//* general purpose (not UI-centric)

//* easy to write, read, refactor

//* one and only one obvious way
//".trim()
//            }
//        topRight: Text {
//            font.family: slide.fontFamily
//            font.pixelSize: slide.units(slide.textHeight - 2)
//            width: slide.grid.width / 2
//            wrapMode: Text.WordWrap
//            text: "
//QML:

//* declarative, hierarchical, object-based

//* UI-centric (plus DSM Framework)

//* easy to write, read, refactor

//* no obvious way, many wrong ways
//".trim()
//            }
//    }

    App.Slide {
        title: deck.subtitle
        text: "
Python:

* general purpose (not UI-centric)

* procedural, functional, object-oriented

* easy to write, read, refactor

* one and only one obvious way
"
    }

    App.Slide {
        title: deck.subtitle
        text: "
QML:

* UI-centric (fully supported by PyQt)

* declarative, hierarchical, object-based

* easy to write, read, refactor

* no single obvious way, some wrong ways
"
    }

    App.Slide {
        title: "QML Code Sample 1"
        code: '
import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    width: 640
    height: 480
    title: "Simple Demo"
}
'
        Window {
            id: window1
            width: 640
            height: 480
            title: "Simple Demo"
            visible: false
        }
        onExited: window1.visible = false;
        onTriggered: window1.visible = true;
    }

    App.Slide {
        title: "QML Features"
        text: "
* Property Binding

* Signal and Handler Event System

* Scripting (but it's JavaScript)

* Declarative State Machine Framework

* Unit Testing Framework
"
    }

//    App.Slide {
//        title: "QML Code Sample"
//        code: '
//import QtQuick 2.4
//import QtQuick.Window 2.2

//Window {
//    width: 640
//    height: 480
//    title: "Simple Demo: " + width + " by " + height
//}
//'
//        Window {
//            id: window2
//            width: 640
//            height: 480
//            title: "Simple Demo: " + width + " by " + height
//            visible: false
//        }
//        onExited: window2.visible = false;
//        onTriggered: window2.visible = true;
//    }

    App.Slide {
        title: "QML Code Sample 2"
        code: '
import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    width: 640
    height: 480
    title: "Window at " + x + ", " + y

    Text {
        anchors.centerIn: parent
        color: (parent.height < 400) ? "Red" : "Blue"
        font.bold: (parent.height > parent.width / 2)
        font.pixelSize: parent.height / 4
        text: parent.width + " by " + parent.height
    }
}
'
        Window {
            id: window3
            width: 640
            height: 480
            title: "Window at " + x + ", " + y
            visible: false
            Text {
                anchors.centerIn: parent
                color: (parent.height < 400) ? "Red" : "Blue"
                font.bold: (parent.height < parent.width / 2)
                font.pixelSize: parent.height / 4
                text: parent.width + " by " + parent.height
            }
        }
        onExited: window3.visible = false;
        onTriggered: window3.visible = true;
    }

    App.Slide {
        title: "QML Code Sample 3"
        codeHeight: 3
        code: '
Window {
    id: window
    width: 640; height: 480; title: "Click Me!"

    function randomColor() {
        return Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
    }

    Text {
        id: someText
        property int count: 0
        anchors.centerIn: parent
        text: "Color Changes: " + count
        onColorChanged: count += 1;
        onCountChanged: if (count > 10) text = "Please Stop";
    }

    MouseArea {
        anchors.fill: parent
        onClicked: someText.color = window.randomColor();
    }
}
'
        Window {
            id: window4
            width: 640
            height: 480
            title: "Click Me!"
            visible: false

            function randomColor() {
                return Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
            }

            Text {
                id: someText
                property int count: 0
                anchors.centerIn: parent
                font.pixelSize: parent.height / 6
                text: "Color Changes: " + count
                onColorChanged: count += 1;
                onCountChanged: if (count > 10) text = "Please Stop";
            }

            MouseArea {
                anchors.fill: parent
                onClicked: someText.color = window4.randomColor();
            }
        }
        onExited: {
            someText.count = 0;
            someText.text = Qt.binding(function() {
                return "Color Changes: " + someText.count; });
            window4.visible = false;
        }
        onTriggered: window4.visible = true;
    }

//    App.Slide {
//        title: "Randomly-Colored Grid"

//        grid.columns: 10


//        function randomColor() {
//            return Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
//        }

//        function update() {
//            for (var i = 0; i < repeater.items.length; i++) {
//                repeater.items[i].color = randomColor();
//            }
//        }

//        onEntered: update();
//        onTriggered: update();

//        Repeater {
//            id: repeater

//            property var items: []

//            model: 100

//            onItemAdded: items.push(item);

//            Rectangle {
//                border.width: 1
//                width: slide.grid.width / 10
//                height: slide.grid.height / 10

//                Text {
//                    anchors.centerIn: parent
//                    color: Qt.darker(parent.color)
//                    font.family: slide.fontFamily
//                    font.pixelSize: slide.units(slide.textHeight)
//                    text: modelData
//                }
//            }
//        }
//    }

//    App.Slide {
//        title: 'Returning to "The Zen of Python"'
//        codeHeight: 3
//        code: "
//>>> import this
//The Zen of Python, by Tim Peters

//Beautiful is better than ugly.
//Explicit is better than implicit.
//Simple is better than complex.
//Complex is better than complicated.
//Flat is better than nested.
//Sparse is better than dense.
//Readability counts.
//Special cases aren't special enough to break the rules.
//Although practicality beats purity.
//Errors should never pass silently.
//Unless explicitly silenced.
//In the face of ambiguity, refuse the temptation to guess.
//There should be one-- and preferably only one --obvious way to do it.
//Although that way may not be obvious at first unless you're Dutch.
//Now is better than never.
//Although never is often better than *right* now.
//If the implementation is hard to explain, it's a bad idea.
//If the implementation is easy to explain, it may be a good idea.
//Namespaces are one honking great idea -- let's do more of those!
//"
//    }

//    App.Slide {
//        title: deck.subtitle
//        text: "QML can be as Pythonic as Python"
//    }

//    App.Slide {
//        title: "Does that mean QML loses?"
//        text: "Although it is hard to find examples of this..."
//    }

//    App.Slide {
//        title: "QML and Python go great together"
//        text: 'Perhaps one day there will be "The Zen of QML"'
//    }

    App.GameOfLifeSlide {
        black: true
        grid.columns: 50
        grid.rows: 30
        interval: 500
    }

    App.GameOfLifeSlide {
        interval: 1
    }

    App.Slide {
        header.visible: false;
        body.color: "Transparent"
        footer.visible: false;

        image.source: "gunslinger.jpg"
        image.anchors.fill: image.parent

        bottomRight: Text {
            text: "Image courtesy of https://www.flickr.com/photos/jameson42/4202217374/in/pool-1363261@N24"
            font.family: "Roboto Condensed"
            font.pixelSize: slide.units(3)
            color: "Gray"
        }

        body.text: deck.subtitle
        body.font.bold: true
        body.font.family: "Roboto Slab"
        body.__centralText.style: Text.Raised
        body.__centralText.styleColor: "Yellow"

        textHeight: 2

        Behavior on textHeight {
            NumberAnimation { duration: 2000 }
        }
        Behavior on image.opacity {
            NumberAnimation { duration: 4000 }
        }

        onEntered: {
            image.opacity = 0.3
            textHeight = 15
        }

        onExited: {
            image.opacity = 1.0
            textHeight = 2
        }
    }

    App.Slide {
        text: "
Patrick Keith O'Brien

QML Slideshow: the Declarative Hierarchical Finite Slide Machine & Toolkit

https://github.com/pkobrien/qml-slideshow
"
    }
}
