from PyQt5 import QtCore, QtGui, QtQuick
import numpy as np

from ..core.models.image import Image

class ImageWriter(QtQuick.QQuickPaintedItem):
    imageChanged = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        QtQuick.QQuickPaintedItem.__init__(self, parent)
        self.m_image = QtGui.QImage() # what will be shown 
        self._image = Image() # what is actually used

    def paint(self, painter):
        if self.m_image.isNull():
            return
        painter.drawImage(QtCore.QPoint(), self.m_image)

    @QtCore.pyqtSlot(str)
    def load_image(self, path:str):
        self._image.load(path)
        self.set_image(self.to_qimage(self._image))
    
    @staticmethod
    def to_qimage(image: Image)->QtGui.QImage:
        new_image = QtGui.QImage(image.img, image.img.shape[1],
                                 image.img.shape[0], image.img.shape[1] * 3, 
                                 QtGui.QImage.Format_BGR888)
        return new_image

    def image(self):
        return self.m_image

    def set_image(self, image: QtGui.QImage):
        if self.m_image == image:
            return
        self.m_image = image
        self.imageChanged.emit()
        self.update()

    image = QtCore.pyqtProperty(QtGui.QImage, fget=image, fset=set_image,
                                notify=imageChanged)
