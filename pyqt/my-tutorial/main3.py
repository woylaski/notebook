# -*- coding: utf-8 -*-

from PyQt5.QtCore import QUrl, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

def outputString(string):
    """
    功能: 输出字符串
    参数: 输出的数据string
    返回值: 无
    """
    print(string)

if __name__ == '__main__':
    path = 'main3.qml'   # 加载的QML文件

    app = QGuiApplication([])
    view = QQuickView()
    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(path))
    view.show()
    context = view.rootObject()
    context.sendClicked.connect(outputString)   # 连接QML信号sendCLicked
    app.exec_()