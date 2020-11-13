from PyQt5 import QtGui, QtQml, QtCore
class Project(QtCore.QObject):
	def __init__(self, parent=None):
		QtCore.QObject.__init__(self, parent)
		