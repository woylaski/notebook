#!/usr/bin/python3

import inspect
import os.path
import sys

import PyQt5.QtGui
import PyQt5.QtQml

import models.base
import models.config
import models.helpers
import models.messages
import models.network
import viewmodels.main
import viewmodels.tabs

def main():
	app = PyQt5.QtGui.QGuiApplication(sys.argv)

	for module in (models.base, models.config, models.helpers, models.messages, models.network, viewmodels.main, viewmodels.tabs):
		for name, cls in inspect.getmembers(module, inspect.isclass):
			if issubclass(cls, PyQt5.QtCore.QObject):
				print('Registering ' + name)
				PyQt5.QtQml.qmlRegisterType(cls, 'Models', 1, 0, name)

	engine = PyQt5.QtQml.QQmlApplicationEngine(app)

	mainModel = viewmodels.main.Main(app)
	engine.rootContext().setContextProperty('mainModel', mainModel)
	engine.load(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'views', 'MainWindow.qml'))

	sys.exit(app.exec())


if __name__ == '__main__':
	main()
