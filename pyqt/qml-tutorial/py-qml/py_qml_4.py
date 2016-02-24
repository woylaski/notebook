#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from PyQt5.QtCore import QUrl, QObject, QTimer
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

'''
（4）Python调用QML函数
QML中创建一个函数，
Python中创建一个rootObject对象，并连接这个函数，
例子中，每隔1s，指针会旋转45 deg;。
'''

if __name__ == '__main__':
    app = QGuiApplication([])

    view = QQuickView()
    view.engine().quit.connect(app.quit)

	path = 'test_4.qml'   # 加载的QML文件
    view.setSource(QUrl(path))
    view.show()
 
    timer = QTimer()
    timer.start(2000)

    root = view.rootObject()
    timer.timeout.connect(root.updateRotater) # 调用QML函数                 
 
    app.exec_()