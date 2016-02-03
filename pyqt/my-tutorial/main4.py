# -*- coding: GBK -*-

from PyQt5.QtCore import QUrl, QTimer
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

if __name__ == '__main__':
    path = 'main4.qml'   # 加载的QML文件

    app = QGuiApplication([])
    view = QQuickView()
    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(path))
    view.show()

    timer = QTimer()
    timer.start(2000)
    root = view.rootObject()
    timer.timeout.connect(root.updateRotater)

    app.exec_()