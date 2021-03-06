# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'Login.ui'
#
# Created by: PyQt5 UI code generator 5.15.1
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_Login(object):
    def setupUi(self, Login):
        Login.setObjectName("Login")
        Login.resize(520, 380)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Login.sizePolicy().hasHeightForWidth())
        Login.setSizePolicy(sizePolicy)
        Login.setAutoFillBackground(False)
        self.centralwidget = QtWidgets.QWidget(Login)
        self.centralwidget.setObjectName("centralwidget")
        self.user = QtWidgets.QLineEdit(self.centralwidget)
        self.user.setGeometry(QtCore.QRect(180, 140, 281, 31))
        self.user.setObjectName("user")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(80, 140, 81, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(15)
        font.setKerning(True)
        self.label.setFont(font)
        self.label.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(self.centralwidget)
        self.label_2.setGeometry(QtCore.QRect(40, 200, 121, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(15)
        font.setKerning(True)
        self.label_2.setFont(font)
        self.label_2.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label_2.setObjectName("label_2")
        self.password = QtWidgets.QLineEdit(self.centralwidget)
        self.password.setGeometry(QtCore.QRect(180, 200, 281, 31))
        self.password.setText("")
        self.password.setObjectName("password")
        self.label_3 = QtWidgets.QLabel(self.centralwidget)
        self.label_3.setGeometry(QtCore.QRect(110, 70, 341, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(20)
        font.setKerning(True)
        self.label_3.setFont(font)
        self.label_3.setTextInteractionFlags(QtCore.Qt.LinksAccessibleByMouse)
        self.label_3.setObjectName("label_3")
        self.label_4 = QtWidgets.QLabel(self.centralwidget)
        self.label_4.setGeometry(QtCore.QRect(40, 140, 31, 31))
        self.label_4.setText("")
        self.label_4.setPixmap(QtGui.QPixmap("Assets/Iconos/user.png"))
        self.label_4.setScaledContents(True)
        self.label_4.setObjectName("label_4")
        self.ingresar = QtWidgets.QPushButton(self.centralwidget)
        self.ingresar.setGeometry(QtCore.QRect(240, 250, 81, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.ingresar.setFont(font)
        self.ingresar.setCheckable(False)
        self.ingresar.setAutoDefault(False)
        self.ingresar.setDefault(False)
        self.ingresar.setFlat(False)
        self.ingresar.setObjectName("ingresar")
        self.salir = QtWidgets.QPushButton(self.centralwidget)
        self.salir.setGeometry(QtCore.QRect(340, 250, 81, 31))
        font = QtGui.QFont()
        font.setFamily("Arial Rounded MT Bold")
        font.setPointSize(10)
        self.salir.setFont(font)
        self.salir.setCheckable(False)
        self.salir.setAutoDefault(False)
        self.salir.setDefault(False)
        self.salir.setFlat(False)
        self.salir.setObjectName("salir")
        self.label_5 = QtWidgets.QLabel(self.centralwidget)
        self.label_5.setGeometry(QtCore.QRect(340, 290, 31, 31))
        self.label_5.setText("")
        self.label_5.setPixmap(QtGui.QPixmap("../../Assets/Iconos/logout.png"))
        self.label_5.setScaledContents(True)
        self.label_5.setObjectName("label_5")
        self.label_6 = QtWidgets.QLabel(self.centralwidget)
        self.label_6.setGeometry(QtCore.QRect(470, 340, 47, 13))
        self.label_6.setObjectName("label_6")
        Login.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(Login)
        self.statusbar.setSizeGripEnabled(True)
        self.statusbar.setObjectName("statusbar")
        Login.setStatusBar(self.statusbar)

        self.retranslateUi(Login)
        QtCore.QMetaObject.connectSlotsByName(Login)

    def retranslateUi(self, Login):
        _translate = QtCore.QCoreApplication.translate
        Login.setWindowTitle(_translate("Login", "Bienvenido"))
        self.label.setText(_translate("Login", "Usuario:"))
        self.label_2.setText(_translate("Login", "Contraseña:"))
        self.label_3.setText(_translate("Login", "Base de Datos E-ntrenate"))
        self.ingresar.setText(_translate("Login", "Ingresar"))
        self.salir.setText(_translate("Login", "Salir"))
        self.label_6.setText(_translate("Login", "Beta 1.0"))
