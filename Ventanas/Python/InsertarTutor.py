# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'InsertarTutor.ui'
#
# Created by: PyQt5 UI code generator 5.15.1
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_InsertarTutor(object):
    def setupUi(self, InsertarTutor):
        InsertarTutor.setObjectName("InsertarTutor")
        InsertarTutor.resize(474, 480)
        InsertarTutor.setToolButtonStyle(QtCore.Qt.ToolButtonIconOnly)
        InsertarTutor.setAnimated(True)
        self.centralwidget = QtWidgets.QWidget(InsertarTutor)
        self.centralwidget.setObjectName("centralwidget")
        self.nombre = QtWidgets.QLineEdit(self.centralwidget)
        self.nombre.setGeometry(QtCore.QRect(150, 20, 281, 31))
        self.nombre.setText("")
        self.nombre.setObjectName("nombre")
        self.label_7 = QtWidgets.QLabel(self.centralwidget)
        self.label_7.setGeometry(QtCore.QRect(40, 20, 91, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(15)
        font.setKerning(True)
        self.label_7.setFont(font)
        self.label_7.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label_7.setObjectName("label_7")
        self.label_8 = QtWidgets.QLabel(self.centralwidget)
        self.label_8.setGeometry(QtCore.QRect(50, 60, 81, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(15)
        font.setKerning(True)
        self.label_8.setFont(font)
        self.label_8.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label_8.setObjectName("label_8")
        self.correo = QtWidgets.QLineEdit(self.centralwidget)
        self.correo.setGeometry(QtCore.QRect(150, 60, 281, 31))
        self.correo.setText("")
        self.correo.setObjectName("correo")
        self.label_9 = QtWidgets.QLabel(self.centralwidget)
        self.label_9.setGeometry(QtCore.QRect(30, 100, 91, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(15)
        font.setKerning(True)
        self.label_9.setFont(font)
        self.label_9.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label_9.setObjectName("label_9")
        self.telefono = QtWidgets.QLineEdit(self.centralwidget)
        self.telefono.setGeometry(QtCore.QRect(150, 100, 281, 31))
        self.telefono.setText("")
        self.telefono.setObjectName("telefono")
        self.label_10 = QtWidgets.QLabel(self.centralwidget)
        self.label_10.setGeometry(QtCore.QRect(30, 150, 311, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(20)
        font.setKerning(True)
        self.label_10.setFont(font)
        self.label_10.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label_10.setObjectName("label_10")
        self.materiasTutor = QtWidgets.QTableWidget(self.centralwidget)
        self.materiasTutor.setGeometry(QtCore.QRect(110, 190, 321, 211))
        self.materiasTutor.setRowCount(15)
        self.materiasTutor.setObjectName("materiasTutor")
        self.materiasTutor.setColumnCount(3)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.materiasTutor.setHorizontalHeaderItem(0, item)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.materiasTutor.setHorizontalHeaderItem(1, item)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.materiasTutor.setHorizontalHeaderItem(2, item)
        self.materiasTutor.verticalHeader().setVisible(False)
        self.confirmar = QtWidgets.QPushButton(self.centralwidget)
        self.confirmar.setGeometry(QtCore.QRect(330, 410, 131, 41))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        font.setBold(False)
        font.setWeight(50)
        self.confirmar.setFont(font)
        self.confirmar.setCheckable(False)
        self.confirmar.setAutoDefault(False)
        self.confirmar.setDefault(False)
        self.confirmar.setFlat(False)
        self.confirmar.setObjectName("confirmar")
        self.cancelar = QtWidgets.QPushButton(self.centralwidget)
        self.cancelar.setGeometry(QtCore.QRect(190, 410, 131, 41))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        font.setBold(False)
        font.setWeight(50)
        self.cancelar.setFont(font)
        self.cancelar.setCheckable(False)
        self.cancelar.setAutoDefault(False)
        self.cancelar.setDefault(False)
        self.cancelar.setFlat(False)
        self.cancelar.setObjectName("cancelar")
        InsertarTutor.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(InsertarTutor)
        self.statusbar.setObjectName("statusbar")
        InsertarTutor.setStatusBar(self.statusbar)

        self.retranslateUi(InsertarTutor)
        QtCore.QMetaObject.connectSlotsByName(InsertarTutor)

    def retranslateUi(self, InsertarTutor):
        _translate = QtCore.QCoreApplication.translate
        InsertarTutor.setWindowTitle(_translate("InsertarTutor", "Insertar Tutor"))
        self.label_7.setText(_translate("InsertarTutor", "Nombre:"))
        self.label_8.setText(_translate("InsertarTutor", "Correo:"))
        self.label_9.setText(_translate("InsertarTutor", "Teléfono:"))
        self.label_10.setText(_translate("InsertarTutor", "MATERIAS ASOCIADAS"))
        item = self.materiasTutor.horizontalHeaderItem(0)
        item.setText(_translate("InsertarTutor", "ID"))
        item = self.materiasTutor.horizontalHeaderItem(1)
        item.setText(_translate("InsertarTutor", "Nombre"))
        item = self.materiasTutor.horizontalHeaderItem(2)
        item.setText(_translate("InsertarTutor", "Check"))
        self.confirmar.setText(_translate("InsertarTutor", "CONFIRMAR"))
        self.cancelar.setText(_translate("InsertarTutor", "CANCELAR"))