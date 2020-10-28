from PyQt5 import QtCore, QtGui, QtQuick


class ImageLoader(QtCore.QObject):
    imageReady = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super(ImageLoader, self).__init__(parent)
        self._image = QtGui.QImage()
        self.m_busy = False

    @QtCore.pyqtSlot(str)
    def load_image(self, path):
        current_image.load(path)
        self.m_busy = True
        new_image = self.to_qimage(current_image)
        self.m_busy = False
        self.set_image(new_image)

    @staticmethod
    def to_qimage(image):
        new_image = QtGui.QImage(image.img, image.img.shape[1],
                                 image.img.shape[0], image.img.shape[1] * 3, QtGui.QImage.Format_BGR888)
        return new_image

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
