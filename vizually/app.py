"""
    :author: Team Complexity:Complicated
    :brief: A small image processing app with UI in Qt and core in OpenCV
"""

import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

if __name__ == '__main__':
    # Set up the application window

    app = QGuiApplication(sys.argv)

    # Load the qml file into an engine
    engine = QQmlApplicationEngine('ui/main.qml')

    # find the root object of the engine
    win = engine.rootObjects()[0]

    win.show()
    app.exec_()
