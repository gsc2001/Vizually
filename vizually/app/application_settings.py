from PyQt5 import QtCore


class ApplicationSettings(QtCore.QSettings):
    def __init__(self, parent):
        super(ApplicationSettings, self).__init__(parent)
