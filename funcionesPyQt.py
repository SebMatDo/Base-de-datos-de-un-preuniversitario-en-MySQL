#Importar elementos de la biblioteca PyQt5.
from PyQt5 import QtWidgets
from PyQt5 import QtCore

def llenarTabla(tabla, data):
    try:
        row = 0
        for tup in data:
            col = 0
            for item in tup:
                cellinfo = QtWidgets.QTableWidgetItem(item)
                cellinfo.setFlags(QtCore.Qt.ItemIsSelectable | QtCore.Qt.ItemIsEnabled)
                tabla.setItem(row, col, cellinfo)
                col += 1
            row += 1

    except Exception as e:
        show_error(e)



def show_error(msg):
    print('ERROR CRITICO AT:', msg)
    errorBox = QtWidgets.QMessageBox()
    errorBox.setIcon(QtWidgets.QMessageBox.Warning)
    errorBox.setText(msg)
    errorBox.setWindowTitle("Advertencia.")
    errorBox.setStandardButtons(QtWidgets.QMessageBox.Ok)

    returnValue = errorBox.exec()
    return returnValue


def show_msg(msg):
    messageBox = QtWidgets.QMessageBox()
    messageBox.setIcon(QtWidgets.QMessageBox.Information)
    messageBox.setText(msg)
    messageBox.setWindowTitle("Información.")
    messageBox.setStandardButtons(QtWidgets.QMessageBox.Ok)

    returnValue = messageBox.exec()
    return returnValue