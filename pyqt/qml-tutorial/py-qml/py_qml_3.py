'''
（3）QML连接信号到Python
当QML触发事件的时候，发射一个信号给Python，此时Python调用一个函数。                
先在QML中定义一个信号，
然后在捕获事件的时候，发射信号，
最后Python中创建一个rootObject对象，然后连接这个对象，
这个例子中，当点击鼠标的时候，控制台会打印信息。
'''

#!/usr/bin/env python3

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

def outputString(string):
	print(string)

if __name__ == '__main__':
	app = QGuiApplication([])

	view = QQuickView()
	view.engine().quit.connect(app.quit)

	path = 'test_3.qml'   # 加载的QML文件
	view.setSource(QUrl(path))
	view.show()

	context = view.rootObject()
	# 连接QML信号sendCLicked
	context.sendClicked.connect(outputString)

	app.exec_()
