# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'DatosTema.ui'
#
# Created by: PyQt5 UI code generator 5.15.1
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_DatosTema(object):
    def setupUi(self, DatosTema):
        DatosTema.setObjectName("DatosTema")
        DatosTema.resize(303, 267)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        DatosTema.setFont(font)
        self.centralwidget = QtWidgets.QWidget(DatosTema)
        self.centralwidget.setObjectName("centralwidget")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(30, 30, 61, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(14)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(10, 80, 61, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.label_3 = QtWidgets.QLabel(self.centralwidget)
        self.label_3.setGeometry(QtCore.QRect(10, 110, 91, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.label_3.setFont(font)
        self.label_3.setObjectName("label_3")
        self.label_4 = QtWidgets.QLabel(self.centralwidget)
        self.label_4.setGeometry(QtCore.QRect(10, 140, 91, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.label_4.setFont(font)
        self.label_4.setObjectName("label_4")
        self.nombre = QtWidgets.QLineEdit(self.centralwidget)
        self.nombre.setGeometry(QtCore.QRect(80, 80, 211, 20))
        self.nombre.setObjectName("nombre")
        self.confirmar = QtWidgets.QPushButton(self.centralwidget)
        self.confirmar.setGeometry(QtCore.QRect(160, 200, 131, 41))
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
        self.cancelar.setGeometry(QtCore.QRect(20, 200, 131, 41))
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
        self.fechaInicio = QtWidgets.QDateEdit(self.centralwidget)
        self.fechaInicio.setGeometry(QtCore.QRect(100, 110, 191, 22))
        self.fechaInicio.setMinimumDateTime(QtCore.QDateTime(QtCore.QDate(1752, 9, 14), QtCore.QTime(0, 0, 0)))
        self.fechaInicio.setMaximumTime(QtCore.QTime(23, 59, 59))
        self.fechaInicio.setCalendarPopup(True)
        self.fechaInicio.setDate(QtCore.QDate(2020, 12, 1))
        self.fechaInicio.setObjectName("fechaInicio")
        self.fechaFin = QtWidgets.QDateEdit(self.centralwidget)
        self.fechaFin.setGeometry(QtCore.QRect(100, 140, 191, 22))
        self.fechaFin.setMinimumDateTime(QtCore.QDateTime(QtCore.QDate(1752, 9, 14), QtCore.QTime(0, 0, 0)))
        self.fechaFin.setMaximumTime(QtCore.QTime(23, 59, 59))
        self.fechaFin.setCalendarPopup(True)
        self.fechaFin.setDate(QtCore.QDate(2020, 12, 1))
        self.fechaFin.setObjectName("fechaFin")
        DatosTema.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(DatosTema)
        self.statusbar.setObjectName("statusbar")
        DatosTema.setStatusBar(self.statusbar)

        self.retranslateUi(DatosTema)
        QtCore.QMetaObject.connectSlotsByName(DatosTema)

    def retranslateUi(self, DatosTema):
        _translate = QtCore.QCoreApplication.translate
        DatosTema.setWindowTitle(_translate("DatosTema", "Insertar Tema"))
        self.label.setText(_translate("DatosTema", "TEMA"))
        self.label_2.setText(_translate("DatosTema", "Nombre: "))
        self.label_3.setText(_translate("DatosTema", "Fecha Inicio: "))
        self.label_4.setText(_translate("DatosTema", "Fecha Final: "))
        self.confirmar.setText(_translate("DatosTema", "CONFIRMAR"))
        self.cancelar.setText(_translate("DatosTema", "CANCELAR"))