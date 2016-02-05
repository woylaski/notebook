from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

def outputString(string):
    print(string)


if __name__ == '__main__':
    # path = r'test\main.qml'
    path = 'main5.qml'

    app = QGuiApplication([])
    view = QQuickView()
    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(path))
    view.show()

    context = view.rootObject()
    context.sendClicked.connect(outputString)   # 连接QML文件中的sendClicked信号

    app.exec_()