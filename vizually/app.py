"""
    :author: Team Complexity:Complicated
    :brief: A small image processing app with UI in Qt and core in OpenCV
"""

import sys

import cv2
from PyQt5 import QtCore, QtGui, QtQuick, QtQml

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


class ImageLoader(QtCore.QObject):
    imageReady = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super(ImageLoader, self).__init__(parent)
        self._image = QtGui.QImage()
        self.m_busy = False

    @QtCore.pyqtSlot(str)
    def load_image(self, path):
        current_image.load(path)
        image = current_image
        self.m_busy = True
        new_image = QtGui.QImage(image.img, image.img.shape[1],
                                 image.img.shape[0], image.img.shape[1] * 3, QtGui.QImage.Format_RGB888)
        self.m_busy = False
        self.set_image(new_image)

    def image(self):
        return self._image

    @QtCore.pyqtSlot(QtGui.QImage)
    def set_image(self, image):
        if self._image == image:
            return
        self._image = image
        self.imageReady.emit()

    image = QtCore.pyqtProperty(QtGui.QImage, fget=image, notify=imageReady)


class ImageWriter(QtQuick.QQuickPaintedItem):
    imageChanged = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        QtQuick.QQuickPaintedItem.__init__(self, parent)
        self.m_image = QtGui.QImage()

    def paint(self, painter):
        if self.m_image.isNull():
            return
        painter.drawImage(QtCore.QPoint(), self.m_image)

    def image(self):
        return self.m_image

    def set_image(self, image):
        if self.m_image == image:
            return
        self.m_image = image
        self.imageChanged.emit()
        self.update()

    image = QtCore.pyqtProperty(QtGui.QImage, fget=image, fset=set_image,
                                notify=imageChanged)


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
