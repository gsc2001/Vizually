from PyQt5 import QtCore, QtGui, QtQuick, QtQml
import numpy as np

from ..core.models.image import Image
from .utils.functions import functions


class ImageViewer(QtQuick.QQuickPaintedItem):
    imageChanged = QtCore.pyqtSignal()

    widthChanged = QtCore.pyqtSignal()
    heightChanged = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        QtQuick.QQuickPaintedItem.__init__(self, parent)
        self.m_image = QtGui.QImage()  # what will be shown
        self._image = Image()  # what is actually used
        # self._stack = []
        # self.

    def paint(self, painter):
        if self.m_image.isNull():
            return
        painter.drawImage(QtCore.QPoint(), self.m_image)

    @QtCore.pyqtSlot(str)
    def load_image(self, path: str):
        self._image.load(path[7:])
        self.set_image(self.to_qimage(self._image))

    @QtCore.pyqtSlot(QtQml.QJSValue)
    def apply(self, config: QtQml.QJSValue):
        params = config.toVariant()
        func_name = params['func_name']
        params.pop('func_name')
        self._image.apply(lambda img: functions[func_name](img, params))
        self.set_image(self.to_qimage(self._image))

    def image(self):
        return self.m_image

    def set_image(self, image: QtGui.QImage):
        if self.m_image == image:
            return
        self.m_image = image
        self.imageChanged.emit()
        self.widthChanged.emit()
        self.heightChanged.emit()
        self.update()

    def _width(self):
        if self._image.img is None:
            return 0
        return self._image.img.shape[1]

    def _height(self):
        if self._image.img is None:
            return 0
        return self._image.img.shape[0]

    @staticmethod
    def to_qimage(image: Image) -> QtGui.QImage:
        new_image = QtGui.QImage(image.img.data, image.img.shape[1],
                                 image.img.shape[0], image.img.strides[0],
                                 QtGui.QImage.Format_BGR888)
        return new_image

    image = QtCore.pyqtProperty(QtGui.QImage, fget=image, fset=set_image,
                                notify=imageChanged)

    _width = QtCore.pyqtProperty(int, fget=_width, notify=widthChanged)
    _height = QtCore.pyqtProperty(int, fget=_height, notify=heightChanged)
