import sys

from .app.application import Application

def vizually():
    # Set up the application window

	app = Application(sys.argv, "vizually/qml/main.qml")
	
	app.run()
