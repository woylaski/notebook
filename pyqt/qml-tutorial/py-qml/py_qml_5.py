#!/usr/bin/env python3

from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot, QRectF, Qt, QUrl, QObject
from PyQt5.QtGui import QColor, QGuiApplication, QPainter, QPen
from PyQt5.QtQml import qmlRegisterType
from PyQt5.QtQuick import QQuickView, QQuickPaintedItem

class PieChart(QQuickPaintedItem):
    chartCleared = pyqtSignal()# 定义信号

    @pyqtProperty(str)
    def name(self):
        print("get name:", self._name);
        return self._name

    @name.setter
    def name(self, name):
        print("set name:", name);
        self._name = name

    @pyqtProperty(QColor)
    def color(self):
        print("get color:", self._color);
        return self._color

    @color.setter
    def color(self, color):
        print("set color:", color);
        self._color = QColor(color)

    def __init__(self, parent=None):
        super(PieChart, self).__init__(parent)

        self._name = ''
        self._color = QColor()

    #QQuickPaintedItem.paint
    def paint(self, painter):
        print("paint pie")
        painter.setPen(QPen(self._color, 2))
        painter.setRenderHints(QPainter.Antialiasing, True)

        rect = QRectF(0, 0, self.width(), self.height()).adjusted(1, 1, -1, -1)
        painter.drawPie(rect, 90 * 16, 290 * 16)

    @pyqtSlot()
    def clearChart(self):
        self.color = QColor(Qt.transparent)
        self.update()

        # 发射信号
        self.chartCleared.emit() 

if __name__ == '__main__':
    import os
    import sys

    app = QGuiApplication(sys.argv)
    qmlRegisterType(PieChart, "Charts", 1, 0, "PieChart")

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    view.setSource(QUrl("test_5.qml"))
    view.show()

    sys.exit(app.exec_())