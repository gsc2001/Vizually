"""
    :author: Team Complexity:Complicated
    :brief: A small image processing app with UI in Qt and core in OpenCV
"""

import sys

import cv2
from PyQt5 import QtCore, QtGui, QtQuick, QtQml, QtWidgets

3
from vizually.core.models.image import Image

global current_image, app, win, engine


class LoadImage(QtCore.QObject):
    @QtCore.pyqtSlot(str)
    def load_image(self, path):
        current_image.load(path)
        print(path)

    @QtCore.pyqtSlot()
    def gray_color(self):
        current_image.img = cv2.cvtColor(current_image.img, cv2.COLOR_BGR2GRAY)




if __name__ == '__main__':
    # Set up the application window

    app = QtGui.QGuiApplication(sys.argv)

    QtQml.qmlRegisterType(ImageWriter, 'Images', 1, 0, 'ImageWriter')
    QtQml.qmlRegisterType(ImageLoader, 'Images', 1, 0, 'ImageLoader')

    current_image = Image()

    temp = LoadImage()

    # Load the qml file into an engine
    engine = QtQml.QQmlApplicationEngine()

    engine.load(QtCore.QUrl("ui/main.qml"))

    # img = image.img
    # img = QImage(img, img.shape[1], img.shape[0], img.shape[1] * 3, QImage.Format_RGB888)
    # pix = QPixmap(img)

    # find the root object of the engine
    win = engine.rootObjects()[0]

    win.show()
    app.exec_()
