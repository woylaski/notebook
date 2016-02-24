#!/usr/bin/env python3

from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QRectF, Qt, QUrl, QObject
from PyQt5.QtGui import QColor, QGuiApplication, QPainter, QPen
from PyQt5.QtQml import qmlRegisterType
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem


app = QGuiApplication([])

view = QQuickView()
rootContext = view.rootContext()
rootContext.setContextProperty("textData", "hi")

view.setSource(QUrl("test_6.qml"))
view.show()
app.exec_()