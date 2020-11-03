from PyQt5 import QtCore


class ApplicationSettings(QtCore.QSettings):
    def __init__(self):
        super().__init__()
