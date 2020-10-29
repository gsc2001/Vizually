import sys

import cv2
from PyQt5 import QtCore, QtGui, QtQuick, QtQml, QtWidgets

from .core.models.image import Image
from .app.image import ImageWriter


def vizually():
    # Set up the application window

    app = QtGui.QGuiApplication(sys.argv)

    QtQml.qmlRegisterType(ImageWriter, 'Images', 1, 0, 'ImageWriter')


    # Load the qml file into an engine
    engine = QtQml.QQmlApplicationEngine()

    engine.load(QtCore.QUrl("vizually/ui/main.qml"))

    # img = image.img
    # img = QImage(img, img.shape[1], img.shape[0], img.shape[1] * 3, QImage.Format_RGB888)
    # pix = QPixmap(img)

    # find the root object of the engine
    win = engine.rootObjects()[0]

    win.show()
    app.exec_()