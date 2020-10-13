import sys
from PySide2 import QtCore, QtGui, QtWidgets
from PySide2.QtUiTools import QUiLoader

if __name__ == '__main__':
	loader = QUiLoader()
	app = QtWidgets.QApplication(sys.argv)
	window = loader.load("mainwindow.ui", None)
	window.show()
	app.exec_()