from PyQt5 import QtGui, QtQml, QtCore

from .application_settings import ApplicationSettings

from .image import ImageViewer


def create_application(args):
    new_app = QtGui.QGuiApplication(args)
    new_app.setOrganizationName("Complexity:Complicated")
    new_app.setApplicationName("Vizually")
    new_app.setApplicationDisplayName("Vizually: Image Processing Application")
    new_app.setApplicationVersion("0.0.1")
    return new_app


class Application:
    def __init__(self, args, qml: str):
        """ 
        Args:
            args: system level arguments
            qml : main qml file
        """
        self._app = create_application(args)
        self._engine = QtQml.QQmlApplicationEngine()
        self._settings = ApplicationSettings()
        self._engine.rootContext().setContextProperty("qtVersion", QtCore.QT_VERSION_STR)
        
        self.register_qml_types()

        self._engine.load(QtCore.QUrl(qml))        
        assert(len(self._engine.rootObjects()) > 0)


    def register_qml_types(self):
        QtQml.qmlRegisterType(ImageViewer, 'Images', 1, 0, "ImageViewer")
        
    def run(self):
        win = self._engine.rootObjects()[0]
        win.show()
        self._app.exec_()

