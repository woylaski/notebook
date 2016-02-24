#!/usr/bin/env python3

from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QRectF, Qt, QUrl, QObject
from PyQt5.QtGui import QColor, QGuiApplication, QPainter, QPen
from PyQt5.QtQml import qmlRegisterType
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem

def on_click():
    print("on click function")
    rootObject.set_text("Clicked")

app = QGuiApplication([])
view = QQuickView()
view.setSource(QUrl("test_9.qml"))

rootObject=view.rootObject()

rootObject.mclicked.connect(on_click)

view.show()
app.exec_()