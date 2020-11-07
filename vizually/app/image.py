from PyQt5 import QtCore, QtGui, QtQuick, QtQml
import numpy as np

from ..core.models.image import Image
from .utils.functions import functions
from collections import deque


class ImageViewer(QtQuick.QQuickPaintedItem):
    imageChanged = QtCore.pyqtSignal()

    widthChanged = QtCore.pyqtSignal()
    heightChanged = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        QtQuick.QQuickPaintedItem.__init__(self, parent)
        self.preview_img = QtGui.QImage()  # Preview Image
        self._image = Image()  # what is actually used
        self.img_src = ImageSource()
        self.dirty = False

    def paint(self, painter):
        if self.preview_img.isNull():
            return
        painter.drawImage(QtCore.QPoint(), self.preview_img)

    @QtCore.pyqtSlot(str)
    def load_image(self, path: str):
        self._image.load(path[7:])
        self.img_src.set_src(self._image.img)
        self.set_image(self._image)

    @QtCore.pyqtSlot(QtQml.QJSValue)
    def apply(self, config: QtQml.QJSValue):
        params = config.toVariant()
        func_name = params['func_name']
        params.pop('func_name')
        self._image.img = functions[func_name](self.img_src.current, params)
        self.set_image(self._image)

    def commit(self):
        self.img_src.commit(self._image.img)

    def undo(self):
        if self.img_src.undo():
            self._image.img = self.img_src.current
            self.set_image(self._image)

    def redo(self):
        if self.img_src.redo():
            self._image.img = self.img_src.current
            self.set_image(self._image)

    def image(self):
        return self.preview_img

    def set_image(self, image: Image):
        image = self.to_qimage(image)
        if self.preview_img == image:
            return
        self.preview_img = image
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


class ImageSource:
    def __init__(self):
        self.undo_stack = deque(maxlen=10)
        self.redo_stack = []

    def set_src(self, src: np.array):
        self.current = src.copy()

    def commit(self, src: np.array):
        """Replace src and add to stack"""
        self.redo_stack.clear()
        self.undo_stack.append(self.current)
        self.current = src.copy()

    def undo(self):
        """Undo"""
        if len(self.undo_stack) == 0:
            return False
        self.redo_stack.append(self.current)
        self.current = self.undo_stack.pop()
        return True

    def redo(self):
        """Redo"""
        if len(self.redo_stack) == 0:
            return False
        self.undo_stack.append(self.current)
        self.current = self.redo_stack.pop()
        return True
