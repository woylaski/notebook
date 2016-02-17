http://doc.qt.io/qt-5/qml-qtquick-keys.html

QML中的Keys元素提供了一些附加属性，之所以说是“附加属性”，是因为它与其它的QML元素用法不同。Keys是专门用来处理键盘事件KeyEvent的，它定义了许多针对特定按键的信号，例如digit0Pressed(KeyEvent event)、spacePressed(KeyEvent event)等，不过使用pressed(KeyEvent event)和released(KeyEvent event)这两个普通的信号就可以处理大部分按键事件了，信号的参数类型是KeyEvent，参数名是event，包含了按键的详细信息。

如果某个QML对象要响应按键事件，首先必须设置其focus属性为true，因为这个属性默认为false。一般情况下，我们处理了某个按键事件时，就会设置其event.accepted属性为true，这样做的目的是防止它的父对象稍后也处理同一个按键事件，即使父对象的focus没有设置为ture。

Keys有三个属性：enabled、forwardTo、prioriry。
enabled属性默认为true，为false时不能响应按键事件，影响的只是当前QML对象。Keys的enabled不同于Item的enabled，后者默认为true，为false时按键事件和鼠标事件都不能响应，影响的是当前对象及所有孩子对象，这一点在使用是需要特别注意。
forwardTo是个列表属性list<Object>，设置按键事件传递的顺序，某个QML对象在这个列表属性中时，即使没有设置focus为true也能响应按键事件，如果某个按键事件被列表属性中前面的Item处理了，后面的Item就不会再收到这个按键信号。
priority属性用来设置处理按键事件时的优先级，默认是Keys.BeforeItem，也就是说优先处理Keys附加属性的按键事件，然后才是Item本身的按键事件，但Keys已经处理过的按键事件就不会再传递到当前Item了，反之Keys.afterItem亦然。

Signals
>asteriskPressed(KeyEvent event)
backPressed(KeyEvent event)
backtabPressed(KeyEvent event)
callPressed(KeyEvent event)
cancelPressed(KeyEvent event)
context1Pressed(KeyEvent event)
context2Pressed(KeyEvent event)
context3Pressed(KeyEvent event)
context4Pressed(KeyEvent event)
deletePressed(KeyEvent event)
digit0Pressed(KeyEvent event)
digit1Pressed(KeyEvent event)
digit2Pressed(KeyEvent event)
digit3Pressed(KeyEvent event)
digit4Pressed(KeyEvent event)
digit5Pressed(KeyEvent event)
digit6Pressed(KeyEvent event)
digit7Pressed(KeyEvent event)
digit8Pressed(KeyEvent event)
digit9Pressed(KeyEvent event)
downPressed(KeyEvent event)
enterPressed(KeyEvent event)
escapePressed(KeyEvent event)
flipPressed(KeyEvent event)
hangupPressed(KeyEvent event)
leftPressed(KeyEvent event)
menuPressed(KeyEvent event)
noPressed(KeyEvent event)
pressed(KeyEvent event)
released(KeyEvent event)
returnPressed(KeyEvent event)
rightPressed(KeyEvent event)
selectPressed(KeyEvent event)
spacePressed(KeyEvent event)
tabPressed(KeyEvent event)
upPressed(KeyEvent event)
volumeDownPressed(KeyEvent event)
volumeUpPressed(KeyEvent event)
yesPressed(KeyEvent event)

怎么用
forcus: true