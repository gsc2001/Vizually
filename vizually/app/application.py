from PyQt5 import QtGui, QtQml, QtCore

from vizually.app.application_settings import ApplicationSettings


def create_application(args):
    new_app = QtGui.QGuiApplication(args)
    new_app.setOrganizationName("IIIT Buddies")
    new_app.setApplicationName("Vizually")
    new_app.setApplicationDisplayName("Vizually: Image Processing Application")
    new_app.setApplicationVersion("0.0.1")
    new_app.setAttribute(QtCore.Qt.AA_EnableHighDpiScaling)
    return new_app


class Application:
    def __init__(self, parent, args):
        self._application = create_application(args)
        self._settings = ApplicationSettings()

    def register_qml_types(self):
        QtQml.qmlRegisterType(ImageWriter, 'Image', 1, 0, "ImageCanvas")


"""
    Appilication
    -> list of open projects
    -> multiple projects
    -> single image
    -> 1 project -> multiple Images
"""
