#!/usr/bin/env python3

from PyQt5.QtCore import QUrl, QObject, pyqtSlot
from PyQt5.QtGui import  QGuiApplication
from PyQt5.QtQuick import  QQuickView

class MyClass(QObject):
	@pyqtSlot(int, result=str)
	def returnValue(self, value):
		return str(value+10)

if __name__ == '__main__':
	path="test_2.qml"
	app=QGuiApplication([])
	view = QQuickView()
	context = view.rootContext()
	con = MyClass()
	context.setContextProperty("con", con)

	view.engine().quit.connect(app.quit)
	view.setSource(QUrl(path))
	view.show()
	app.exec_()
