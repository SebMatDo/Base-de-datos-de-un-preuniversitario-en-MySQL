# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'InformacionEstudiante.ui'
#
# Created by: PyQt5 UI code generator 5.15.1
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_InformacionEstudiante(object):
    def setupUi(self, InformacionEstudiante):
        InformacionEstudiante.setObjectName("InformacionEstudiante")
        InformacionEstudiante.resize(339, 465)
        self.centralwidget = QtWidgets.QWidget(InformacionEstudiante)
        self.centralwidget.setObjectName("centralwidget")
        self.notas = QtWidgets.QTableWidget(self.centralwidget)
        self.notas.setGeometry(QtCore.QRect(20, 140, 311, 101))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.notas.setFont(font)
        self.notas.setObjectName("notas")
        self.notas.setColumnCount(2)
        self.notas.setRowCount(0)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.notas.setHorizontalHeaderItem(0, item)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.notas.setHorizontalHeaderItem(1, item)
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(20, 120, 47, 13))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(20, 270, 91, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.inasistencias = QtWidgets.QTableWidget(self.centralwidget)
        self.inasistencias.setGeometry(QtCore.QRect(20, 300, 311, 111))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.inasistencias.setFont(font)
        self.inasistencias.setObjectName("inasistencias")
        self.inasistencias.setColumnCount(2)
        self.inasistencias.setRowCount(0)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.inasistencias.setHorizontalHeaderItem(0, item)
        item = QtWidgets.QTableWidgetItem()
        item.setTextAlignment(QtCore.Qt.AlignCenter)
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        item.setFont(font)
        self.inasistencias.setHorizontalHeaderItem(1, item)
        self.back = QtWidgets.QPushButton(self.centralwidget)
        self.back.setGeometry(QtCore.QRect(250, 420, 75, 23))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.back.setFont(font)
        self.back.setObjectName("back")
        self.label_3 = QtWidgets.QLabel(self.centralwidget)
        self.label_3.setGeometry(QtCore.QRect(20, 20, 71, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        self.label_3.setFont(font)
        self.label_3.setObjectName("label_3")
        self.nombre = QtWidgets.QLabel(self.centralwidget)
        self.nombre.setGeometry(QtCore.QRect(90, 20, 241, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        self.nombre.setFont(font)
        self.nombre.setStyleSheet("background-color: rgb(255, 255, 255);")
        self.nombre.setText("")
        self.nombre.setObjectName("nombre")
        self.label_5 = QtWidgets.QLabel(self.centralwidget)
        self.label_5.setGeometry(QtCore.QRect(20, 50, 71, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        self.label_5.setFont(font)
        self.label_5.setObjectName("label_5")
        self.correo = QtWidgets.QLabel(self.centralwidget)
        self.correo.setGeometry(QtCore.QRect(90, 50, 241, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        self.correo.setFont(font)
        self.correo.setStyleSheet("background-color: rgb(255, 255, 255);")
        self.correo.setText("")
        self.correo.setObjectName("correo")
        self.label_7 = QtWidgets.QLabel(self.centralwidget)
        self.label_7.setGeometry(QtCore.QRect(20, 80, 71, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        self.label_7.setFont(font)
        self.label_7.setObjectName("label_7")
        self.telefono = QtWidgets.QLabel(self.centralwidget)
        self.telefono.setGeometry(QtCore.QRect(90, 80, 241, 16))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        self.telefono.setFont(font)
        self.telefono.setStyleSheet("background-color: rgb(255, 255, 255);")
        self.telefono.setText("")
        self.telefono.setObjectName("telefono")
        InformacionEstudiante.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(InformacionEstudiante)
        self.statusbar.setObjectName("statusbar")
        InformacionEstudiante.setStatusBar(self.statusbar)

        self.retranslateUi(InformacionEstudiante)
        QtCore.QMetaObject.connectSlotsByName(InformacionEstudiante)

    def retranslateUi(self, InformacionEstudiante):
        _translate = QtCore.QCoreApplication.translate
        InformacionEstudiante.setWindowTitle(_translate("InformacionEstudiante", "correo - Información Clase ID"))
        item = self.notas.horizontalHeaderItem(0)
        item.setText(_translate("InformacionEstudiante", "Actividad"))
        item = self.notas.horizontalHeaderItem(1)
        item.setText(_translate("InformacionEstudiante", "Nota"))
        self.label.setText(_translate("InformacionEstudiante", "Notas"))
        self.label_2.setText(_translate("InformacionEstudiante", "Inasistencias"))
        item = self.inasistencias.horizontalHeaderItem(0)
        item.setText(_translate("InformacionEstudiante", "ID"))
        item = self.inasistencias.horizontalHeaderItem(1)
        item.setText(_translate("InformacionEstudiante", "Fecha"))
        self.back.setText(_translate("InformacionEstudiante", "Atras"))
        self.label_3.setText(_translate("InformacionEstudiante", "Estudiante:"))
        self.label_5.setText(_translate("InformacionEstudiante", "Correo:"))
        self.label_7.setText(_translate("InformacionEstudiante", "Telefono:"))
