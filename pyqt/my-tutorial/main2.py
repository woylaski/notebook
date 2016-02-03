# -*- coding: GBK -*-
from PyQt5.QtCore import QUrl, QObject, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
class MyClass(QObject):
    @pyqtSlot(int, result=str)    # ����Ϊ�ۣ��������Ϊint���ͣ�����ֵΪstr����
    def returnValue(self, value):
        """
        ����: ����һ����
        ����: ����value
        ����ֵ: �ַ���
        """
        return str(value+10)
if __name__ == '__main__':
    path = 'main2.qml'   # ���ص�QML�ļ�
    app = QGuiApplication([])
    view = QQuickView()
    con = MyClass()
    context = view.rootContext()
    context.setContextProperty("con", con)
    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(path))
    view.show()
    app.exec_()