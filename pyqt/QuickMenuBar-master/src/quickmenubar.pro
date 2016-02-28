
TEMPLATE	= lib
LANGUAGE	= C++
DEFINES		+= QANAVA
TARGET		= quickmenubar
DESTDIR		= ../build
CONFIG		+= warn_on qt thread staticlib c++11
INCLUDEPATH	+= 
QT          += core widgets gui xml qml quick quickwidgets
 
SOURCES +=

DISTFILES   +=  QmbMenu.qml             \
                QmbMenuBar.qml          \
                QmbMenuLayout.qml       \
                QmbMenuItem.qml         \
                QmbMenuSeparator.qml    \
                QmbMenuStyle.qml

CONFIG(release, debug|release) {
    linux-g++*:     TARGET    = quickmenubar
    android:        TARGET    = quickmenubar
    win32-msvc*:    TARGET    = quickmenubar
    win32-g++*:     TARGET    = quickmenubar
}

CONFIG(debug, debug|release) {
    linux-g++*:     TARGET    = quickmenubard
    android:        TARGET    = quickmenubard
    win32-msvc*:    TARGET    = quickmenubard
    win32-g++*:     TARGET    = quickmenubard
}

RESOURCES += QuickMenuBar.qrc
