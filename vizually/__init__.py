import sys

from .app.application import Application

def vizually():
    # Set up the application window

	app = Application(sys.argv, "vizually/ui/main.qml")
	
	app.run()
