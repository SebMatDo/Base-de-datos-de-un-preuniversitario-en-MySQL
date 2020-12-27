#Importar elementos de la biblioteca PyQt5.
from PyQt5 import QtWidgets, QtGui

#Importar Ventanas.
from Ventanas.Python.Login import Ui_Login
from Ventanas.Python.InterfazPrincipal import Ui_InterfazPrincipal
from Ventanas.Python.MiHorario import Ui_MiHorario
from Ventanas.Python.MiInformacion import Ui_miPerfil
from Ventanas.Python.AdministrarUsuarios import Ui_AdministrarUsuarios
from Ventanas.Python.AdministrarMaterias import Ui_AdministrarMaterias
from Ventanas.Python.InsertarEstudiante import Ui_InsertarEstudiante
from Ventanas.Python.EditarEstudiante import Ui_EditarEstudiante
from Ventanas.Python.InsertarTutor import Ui_InsertarTutor
from Ventanas.Python.EditarTutor import Ui_EditarTutor
from Ventanas.Python.DatosMateria import Ui_DatosMateria
from Ventanas.Python.InformacionCurso import Ui_InfoCurso
from Ventanas.Python.MisMaterias import Ui_misMaterias
from Ventanas.Python.Planilla import Ui_Planilla


import sys
import conexion as bk
import funcionesPyQt as fPyQt


#LOGIN.
global user
global passw

class loginWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(loginWindow, self).__init__()
        self.ui = Ui_Login()
        self.ui.setupUi(self)

        self.ui.password.setEchoMode(QtWidgets.QLineEdit.Password)
        self.ui.ingresar.setShortcut('Return')

        #EVENT LISTENERS.
        self.ui.ingresar.clicked.connect(self.show_interfazPrincipal)
        self.ui.salir.clicked.connect(lambda: self.close())


    def show_interfazPrincipal(self):
        """Función para crear y abrir la Interfaz Principal."""
        global user
        global passw

        user = self.ui.user.text()
        passw = self.ui.password.text()
        ans = bk.start_conection(user, passw)


        if ans == 1:
            self.interfazPrincipal = Interfaz()
            self.interfazPrincipal.show()
            self.close()
        elif ans == 0:
            fPyQt.show_error("Error al verificar credenciales.")



#INTERFAZ PRINCIPAL.
class Interfaz(QtWidgets.QMainWindow):

    def __init__(self):
        super(Interfaz, self).__init__()
        self.ui = Ui_InterfazPrincipal()
        self.ui.setupUi(self)


        #EVENT LISTENERS.
        self.ui.miHorario.clicked.connect(lambda: self.show_miHorario(self.ui.miHorario))
        self.ui.user.clicked.connect(self.show_miPerfil)
        self.ui.userControl.clicked.connect(self.show_userControl)
        self.ui.materiaControl.clicked.connect(self.show_materiaControl)
        self.ui.buscar.clicked.connect(self.buscarMaterias)
        self.ui.ayuda.clicked.connect(self.show_help)
        self.ui.salir.clicked.connect(lambda: self.show_login())


        #Se obtiene el rol del usuario.
        #Dependiendo del rol que se tenga, se muestran/esconden elementos.
        global rol
        rol = bk.get_role()


        if rol != 'Admin':
            self.setWindowTitle("Estudiante - " + user)

            #Esconde las pestañas que no le corresponden.
            self.ui.menu.setTabVisible(3, False)
            self.ui.menu.setTabVisible(4, False)
            self.ui.menu.setTabVisible(5, False)

            self.ui.menu.setTabEnabled(3, False)
            self.ui.menu.setTabEnabled(4, False)
            self.ui.menu.setTabEnabled(5, False)


            # Inserción de datos a la tabla de Información Académica.
            tablaPrincipal = self.ui.tabMateriasEst
            dataTemporal = bk.get_materias_inscritas(user)
            dataPrincipal = []
            for elem in dataTemporal:
                dataPrincipal.append(elem[1:])

            # Bloque if que verifica si el usuario tiene materias inscritas.
            # En caso de que no, no deja hacer nada en la pestaña principal (útil para tutores).
            if len(dataPrincipal) > 0:
                # El número de filas que hay en la tabla es el número de elementos en dataPrincipal.
                tablaPrincipal.setRowCount(len(dataPrincipal))
                fPyQt.llenarTabla(tablaPrincipal, dataPrincipal)


                # Se recorre la tabla.
                row = 0
                promedioGeneral = 0.0
                for tup in dataPrincipal:
                    # Cambio de Color en los nombres de las materias.
                    item = tup[0]
                    cellinfo = QtWidgets.QTableWidgetItem(item)
                    cellinfo.setForeground(QtGui.QBrush(QtGui.QColor(0, 0, 255)))
                    tablaPrincipal.setItem(row, 0, cellinfo)
                    row += 1

                    # Sumatoria de promedios por materia del estudiante.
                    promedioMateria = int(tup[3])
                    promedioGeneral += promedioMateria


                # Cálculo del promedio general del estudiante.
                if promedioGeneral != 0:
                    promedioGeneral /= len(dataPrincipal)
                round(promedioGeneral, 2)

                # Se muestra en pantalla el resultado.
                self.ui.promedioGeneralEst.setText(str(promedioGeneral))


                # Asociación de evento al clickear una materia.

                # Al dar click en una materia (fila) se muestra la ventana "misMaterias" con su información correspondiente.
                tablaPrincipal.itemClicked.connect(self.show_misMaterias)


            else:
                tablaPrincipal.setEnabled(False)
                self.ui.miHorario.setEnabled(False)
                self.ui.promedioGeneralEst.setText("None")


            # Encuestas
            try:
                data = bk.get_encuestas()
                for tup in data:
                    item = QtWidgets.QListWidgetItem(str(tup[0]))
                    self.ui.listaEncuestas.addItem(item)
            except Exception as e:
                fPyQt.show_error(e)



            if rol == 'Tutor':
                self.setWindowTitle("Tutor - " + user)

                #Activa la pestaña Panel Tutor.
                self.ui.menu.setTabVisible(3, True)
                self.ui.menu.setTabEnabled(3, True)

                #Llenado de lista con las materias que el tutor dicta.
                data = bk.get_materias_dictadas(user)
                for tup in data:
                    item = QtWidgets.QListWidgetItem(str(tup[0]))
                    item.setForeground(QtGui.QBrush(QtGui.QColor(0, 0, 255)))
                    self.ui.listaCursosTutor.addItem(item)
                self.ui.listaCursosTutor.itemClicked.connect(self.show_planillaTutor)



        if rol == 'Admin':
            self.setWindowTitle("Administrador - " + user)

            #Esconde las pestañas que no le corresponden.
            self.ui.menu.setTabVisible(0, False)
            self.ui.menu.setTabVisible(1, False)
            self.ui.menu.setTabVisible(2, False)
            self.ui.menu.setTabVisible(3, False)

            self.ui.menu.setTabEnabled(0, False)
            self.ui.menu.setTabEnabled(1, False)
            self.ui.menu.setTabEnabled(2, False)
            self.ui.menu.setTabEnabled(3, False)

            self.ui.menu.setCurrentIndex(4)
            self.ui.user.setEnabled(False)

            ### CARGAR LOGS
            data=bk.send_query('log_estudiante')
            data = bk.tup_to_tupstr(data)
            fPyQt.llenarTabla(self.ui.log1, data)
            data = bk.send_query('log_tutor')
            data = bk.tup_to_tupstr(data)
            fPyQt.llenarTabla(self.ui.log2, data)

    #FUNCIONES.
    def show_login(self):
        """Función para crear y abrir el Login."""
        self.close()
        self.login = loginWindow()
        self.login.show()
        bk.end_conection()


    def show_miHorario(self, button):
        """Función para crear y abrir la ventana que muestra el horario de un estudiante/tutor."""
        self.miHorario = horarioWindow(button)
        self.miHorario.show()
        self.ui.miHorario.setEnabled(False)


    def show_miPerfil(self):
        """Función para crear y abrir la ventana que muestra la información del usuario actual."""
        self.miPerfil = miPerfilWindow()
        self.miPerfil.show()


    def show_userControl(self):
        """Función para crear y abrir el panel de gestión de usuarios como administrador."""
        self.userControl = userControlWindow()
        self.userControl.show()


    def show_materiaControl(self):
        """Función para crear y abrir el panel de gestión de materias como administrador."""
        self.materiaControl = materiaControlWindow()
        self.materiaControl.show()


    def show_help(self):
        """Función para crear y abrir una ventana de diálogo con información de ayuda para el usuario."""
        helpBox = QtWidgets.QMessageBox()
        helpBox.setIcon(QtWidgets.QMessageBox.Information)
        helpBox.setText("Software Creado por:\n\n"+
                        "Juan Sebastián Cabezas Mateus\n"+
                        "Santiago Rodríguez Vallejo\n"+
                        "Julián Steven Vega Daza\n\n"+
                        "UNIVERSIDAD NACIONAL DE COLOMBIA. 2020")
        helpBox.setWindowTitle("Información.")
        helpBox.setStandardButtons(QtWidgets.QMessageBox.Ok)

        returnValue = helpBox.exec()


    def buscarMaterias(self):
        """Función que llena la lista en la pestaña Cursos al darle al botón Buscar. Siguiendo el filtro indicado por el QComboBox.
        Al dar click en un elemento de esta lista, se muestra la ventana con información al curso correspondiente."""
        try:
            self.ui.listaCursos.clear()
            grupo = str(self.ui.grupo.currentText())
            data = bk.get_materias(grupo)
            for tup in data:
                item = QtWidgets.QListWidgetItem(str(tup[0]))
                item.setForeground(QtGui.QBrush(QtGui.QColor(0, 0, 255)))
                self.ui.listaCursos.addItem(item)
            self.ui.listaCursos.itemClicked.connect(self.show_infoCurso)

        except Exception as e:
            fPyQt.show_error(e)


    def show_infoCurso(self, materia):
        """Función para crear y abrir la ventana con información general de una materia indicada."""
        self.curso = infoCursoWindow(materia)
        self.curso.show()


    def show_misMaterias(self, materia):
        """Función para crear y abrir la ventana con información personal de una materia indicada."""
        self.miMateria = misMateriasWindow(materia)
        self.miMateria.show()


    def show_planillaTutor(self, materia):
        self.planilla = planillaTutorWindow(materia)
        self.planilla.show()


#MI HORARIO.
class horarioWindow(QtWidgets.QMainWindow):
    def __init__(self, button):
        super(horarioWindow, self).__init__()
        self.ui = Ui_MiHorario()
        self.ui.setupUi(self)

        self.button = button

        datoshorario = bk.horariostabla(str(user))
        datostablahorario = bk.Horario(datoshorario)
        fPyQt.llenarTabla(self.ui.horario, datostablahorario)

        #EVENT LISTENERS.
        self.ui.back.clicked.connect(lambda: self.close())

    def closeEvent(self, event):
        self.button.setEnabled(True)



#MI INFORMACIÓN.
class miPerfilWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(miPerfilWindow, self).__init__()
        self.ui = Ui_miPerfil()
        self.ui.setupUi(self)

        datosmiinfo = bk.get_miinfo(str(user))
        datosmiinfo.append(str(rol))
        self.ui.userId.setText(str(datosmiinfo[0][0]))
        self.ui.userNombre.setText(datosmiinfo[0][1])
        self.ui.userCorreo.setText(datosmiinfo[0][2])
        self.ui.userTelefono.setText(str(datosmiinfo[0][3]))
        self.ui.userRol.setText(datosmiinfo[1])


        #EVENT LISTENERS.
        self.ui.back.clicked.connect(lambda: self.close())



#MIS MATERIAS.
class misMateriasWindow(QtWidgets.QMainWindow):
    def __init__(self, materia):
        global user

        super(misMateriasWindow, self).__init__()
        self.ui = Ui_misMaterias()
        self.ui.setupUi(self)


        #EVENT LISTENERS.
        self.ui.back.clicked.connect(lambda: self.close())


        ## LLenado de la nueva ventana:
        ## LLENADO DE INFO MATERIA
        data = bk.get_materias_inscritas(user)
        self.ui.matId.setText(data[materia.row()][0])
        self.ui.matNombre.setText(data[materia.row()][1])
        self.ui.matGrupo.setText(data[materia.row()][2])


        ## LLENADO DE ACTIVIDADES
        data2 = bk.get_actividades(data[materia.row()][0])
        tablaActividades = self.ui.actividadesEst
        tablaActividades.setRowCount(len(data2))
        fPyQt.llenarTabla(tablaActividades, data2)


        ### LLENADO DE NOTAS
        for i in range(0, len(data2)):
            data3 = bk.get_nota_actividad(user, data2[i][0])
            print(data3)
            if data3 != []:
                cellinfo = QtWidgets.QTableWidgetItem(data3[0][0])
            else:
                cellinfo = QtWidgets.QTableWidgetItem('No calificado')
            tablaActividades.setItem(i, 6, cellinfo)


        ## LLENADO DE INASISTENCIAS
        data2 = bk.get_inasistencias(user, data[materia.row()][0])
        tablaInasistencias = self.ui.inasistenciasEst
        tablaInasistencias.setRowCount(len(data2))
        fPyQt.llenarTabla(tablaInasistencias, data2)



#Administrar Usuarios. Linea 384
class userControlWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(userControlWindow, self).__init__()
        self.ui = Ui_AdministrarUsuarios()
        self.ui.setupUi(self)



        #EVENT LISTENERS.
        self.ui.insertarEst.clicked.connect(self.show_insertarEst)
        self.ui.editarEst.clicked.connect(lambda: self.show_editarEst(self.ui.bdEst.item(self.ui.bdEst.currentRow(), 0)))
        self.ui.borrarEst.clicked.connect(lambda: self.borrarEst(self.ui.bdEst.item(self.ui.bdEst.currentRow(), 0)))
        self.ui.insertarTut.clicked.connect(self.show_insertarTut)
        self.ui.editarTut.clicked.connect(lambda: self.show_editarTut(self.ui.bdTut.item(self.ui.bdTut.currentRow(), 0)))
        self.ui.borrarTut.clicked.connect(lambda: self.borrarTut(self.ui.bdTut.item(self.ui.bdTut.currentRow(), 0)))
        self.ui.backEst.clicked.connect(lambda: self.close())
        self.ui.backTut.clicked.connect(lambda: self.close())

        ## LLENADO
        data = bk.send_query('cons_estudiantes_total')
        data = bk.tup_to_tupstr(data)
        self.ui.bdEst.setRowCount(len(data))
        fPyQt.llenarTabla(self.ui.bdEst, data)

        data = bk.send_query('cons_tutores_total')
        data = bk.tup_to_tupstr(data)
        self.ui.bdTut.setRowCount(len(data))
        fPyQt.llenarTabla(self.ui.bdTut, data)

        #filaEst = self.ui.bdEst.currentRow()
        #estudiante = self.ui.bdEst.item(filaEst, 0)
        #filaTut = self.ui.bdTut.currentRow()
        #tutor = self.ui.bdTut.item(filaTut, 0)


    #FUNCIONES
    def show_insertarEst(self):
        self.insertarEstudiante = insertarEstudianteWindow()
        self.insertarEstudiante.show()


    def show_editarEst(self, old_Est):
        self.editarEstudiante = editarEstudianteWindow(old_Est)
        self.editarEstudiante.show()


    def borrarEst(self, correo):
        est_correo=correo.text()
        result= bk.delete_user('delete_estudiante',est_correo)
        if result != 0:
            fPyQt.show_msg("Registro borrado con éxito!\nReinicie el software para visualizar cambios.")
            self.close()

        else:
            fPyQt.show_msg("Lo sentimos, hubo un error.\n Contactese con soporte: soporte@E-ntrenate.com")
            self.close()

    def show_insertarTut(self):
        self.insertarTutor = insertarTutorWindow()
        self.insertarTutor.show()


    def show_editarTut(self, old_Tut):
        self.editarTutor = editarTutorWindow(old_Tut)
        self.editarTutor.show()

    def borrarTut(self, correo):
        tut_correo=correo.text()
        result=bk.delete_user('delete_tutor', tut_correo)
        if result != 0:
            fPyQt.show_msg("Registro borrado con éxito!\nReinicie el software para visualizar cambios.")
            self.close()

        else:
            fPyQt.show_msg("Lo sentimos, hubo un error.\n Contactese con soporte: soporte@E-ntrenate.com")
            self.close()

#ADMINISTRAR MATERIAS.
class materiaControlWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(materiaControlWindow, self).__init__()
        self.ui = Ui_AdministrarMaterias()
        self.ui.setupUi(self)


        #EVENT LISTENERS.
        self.ui.insertar.clicked.connect(self.show_datosMateria)
        self.ui.editar.clicked.connect(self.show_datosMateria)
        self.ui.back.clicked.connect(lambda: self.close())


        data = bk.get_materias('Todo')
        self.ui.bdMat.setRowCount(len(data))
        fPyQt.llenarTabla(self.ui.bdMat, data)


    #FUNCIONES
    def show_datosMateria(self):
        self.datosMateria = datosMateriaWindow()
        self.datosMateria.show()



#INSERTAR ESTUDIANTE.
class insertarEstudianteWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(insertarEstudianteWindow, self).__init__()
        self.ui = Ui_InsertarEstudiante()
        self.ui.setupUi(self)


        #EVENT LISTENERS.
        self.ui.cancelar.clicked.connect(lambda: self.close())
        self.ui.confirmar_2.clicked.connect(self.ins_est)


        datatemp = bk.get_materias('Todo')
        data = []
        for tup in datatemp:
            data.append(tup[0:2])

        self.ui.materiasEstudiante.setRowCount(len(data))
        fPyQt.llenarTabla(self.ui.materiasEstudiante, data)
        for i in range(0, len(data)):
            combo = QtWidgets.QCheckBox()
            self.ui.materiasEstudiante.setCellWidget(i, 2, combo)


    #FUNCIONES
    def ins_est(self):
        est_correo = self.ui.correo.text()
        est_nombre = self.ui.nombre.text()
        est_telefono = int(self.ui.telefono.text())
        materia = []
        for i in range(0, self.ui.materiasEstudiante.rowCount()):
            combo = self.ui.materiasEstudiante.cellWidget(i, 2)
            mat_id = self.ui.materiasEstudiante.item(i, 0).text()
            if combo.isChecked():
                materia.append(mat_id)
        result = bk.add_estudiante(est_correo, materia[0], est_nombre, est_telefono)
        if len(materia) > 1:
            for i in range(1, len(materia)):
                result = bk.add_materia_estudiante(est_correo, materia[i])
        if result!=0:
            fPyQt.show_msg("Registro insertado con éxito!\nReinicie el software para visualizar cambios.")
            self.close()

        else:
            fPyQt.show_msg("Lo sentimos, hubo un error.\n Contactese con soporte: soporte@E-ntrenate.com")

### SANTIAGO acá darle feedback a la persona si se insertó correctamente y cerrar la ventanita y hacerle clear para poder insertar otros



#EDITAR ESTUDIANTE.

#EDITAR ESTUDIANTE. Linea 523
class editarEstudianteWindow(QtWidgets.QMainWindow):
    def __init__(self, old_Est):
        super(editarEstudianteWindow, self).__init__()
        self.ui = Ui_EditarEstudiante()
        self.ui.setupUi(self)


        #EVENT LISTENERS.
        self.ui.cancelar.clicked.connect(lambda: self.close())
        self.ui.confirmar.clicked.connect(lambda: self.edit_est(old_Est))


    #FUNCIONES
    def edit_est(self, old_Est):
        old_Est = old_Est.text()
        est = self.ui.correo.text()
        nombre = self.ui.nombre.text()
        tel = int(self.ui.telefono.text())
        result=bk.upd_estudiante(old_Est, est, nombre, tel)
        if result!=0:
            fPyQt.show_msg("Registro Actualizado con éxito!\nReinicie el software para visualizar cambios.")
            self.close()
        else:
            fPyQt.show_msg("Lo sentimos, hubo un error.\n Contactese con soporte: soporte@E-ntrenate.com")

# INSERTAR TUTOR.
class insertarTutorWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(insertarTutorWindow, self).__init__()
        self.ui = Ui_InsertarTutor()
        self.ui.setupUi(self)


        # EVENT LISTENERS.
        self.ui.cancelar.clicked.connect(lambda: self.close())
        self.ui.confirmar.clicked.connect(self.ins_tutor)


        datatemp = bk.get_materias('Todo')
        data = []
        for tup in datatemp:
            data.append(tup[0:2])
        self.ui.materiasTutor.setRowCount(len(data))
        fPyQt.llenarTabla(self.ui.materiasTutor, data)

        for i in range(0, len(data)):
            combo = QtWidgets.QCheckBox()
            self.ui.materiasTutor.setCellWidget(i, 2, combo)


    # FUNCIONES
    def ins_tutor(self):
        tut_correo = self.ui.correo.text()
        tut_nombre = self.ui.nombre.text()
        tut_telefono = int(self.ui.telefono.text())

        materia = []
        for i in range(0, self.ui.materiasTutor.rowCount()):
            combo = self.ui.materiasTutor.cellWidget(i, 2)
            mat_id = self.ui.materiasTutor.item(i, 0).text()
            if combo.isChecked():
                materia.append(mat_id)
        result=bk.add_tutor(tut_correo, tut_nombre, tut_telefono, materia[0])

        if len(materia) > 1:
            for i in range(1, len(materia)):
                result=bk.add_materia_tutor(tut_correo, materia[i])
        if result!=0:
            fPyQt.show_msg("Registro insertado con éxito!\nReinicie el software para visualizar cambios.")
            self.close()
        else:
            fPyQt.show_msg("Lo sentimos, hubo un error.\n Contactese con soporte: soporte@E-ntrenate.com")


### SANTIAGO acá darle feedback a la persona si se insertó correctamente y cerrar la ventanita y hacerle clear para poder insertar otros
#EDITAR TUTOR. LINEA 596
class editarTutorWindow(QtWidgets.QMainWindow):
    def __init__(self, old_Tut):
        super(editarTutorWindow, self).__init__()
        self.ui = Ui_EditarTutor()
        self.ui.setupUi(self)

        #EVENT LISTENERS.
        self.ui.confirmar_2.clicked.connect(lambda: self.edit_tut(old_Tut))
        self.ui.cancelar.clicked.connect(lambda: self.close())


    #FUNCIONES
    def edit_tut(self, old_Tut):
        old_Tut = old_Tut.text()
        correo = self.ui.correo.text()
        nombre = self.ui.nombre.text()
        tel = int(self.ui.telefono.text())
        materia = ''
        result= bk.update_tut(old_Tut, correo, nombre, tel)
        if result!=0:
            fPyQt.show_msg("Registro Actualizado con éxito!\nReinicie el software para visualizar cambios.")
            self.close()
        else:
            fPyQt.show_msg("Lo sentimos, hubo un error.\n Contactese con soporte: soporte@E-ntrenate.com")
#DATOS MATERIA.
class datosMateriaWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(datosMateriaWindow, self).__init__()
        self.ui = Ui_DatosMateria()
        self.ui.setupUi(self)

        #EVENT LISTENERS.
        self.ui.cancelar.clicked.connect(lambda: self.close())



#INFORMACIÓN DE CURSO.
class infoCursoWindow(QtWidgets.QMainWindow):
    def __init__(self, materia):
        self.materia = materia.text()
        super(infoCursoWindow, self).__init__()
        self.ui = Ui_InfoCurso()
        self.ui.setupUi(self)


        #EVENT LISTENERS.
        self.ui.back.clicked.connect(lambda: self.close())


        data = bk.get_materia(self.materia)
        self.ui.matId.setText(data[0][0])
        self.ui.matNombre.setText(data[0][1])
        self.ui.matGrupo.setText(data[0][2])

        datatutor = bk.get_tutor(data[0][3])
        self.ui.matTutor.setText(datatutor[0][0])
        self.ui.matTutorCorreo.setText(datatutor[0][1])
        self.ui.matTutorTelefono.setText(str(datatutor[0][2]))

        data = bk.get_horario_materia(self.materia)
        self.ui.matHorario.setText(data)



#PLANILLA.
class planillaTutorWindow(QtWidgets.QMainWindow):
    def __init__(self, materia):
        self.materia = materia.text()
        super(planillaTutorWindow, self).__init__()
        self.ui = Ui_Planilla()
        self.ui.setupUi(self)
        datanotas = bk.get_notastutor(self.materia)
        fPyQt.llenarTabla(self.ui.bdNotas, datanotas)
        dataactividades = bk.get_actividadestutor(self.materia)
        fPyQt.llenarTabla(self.ui.bdActividades, dataactividades)
        datatemas = bk.get_temastutor(self.materia)
        fPyQt.llenarTabla(self.ui.bdTemas, datatemas)
        datainasistencias = bk.get_Inasistenciastutor(self.materia)
        fPyQt.llenarTabla(self.ui.bdInasistencias, datainasistencias)

        if rol == "Tutor":
            self.ui.insertarEstPlanilla.setEnabled(False)
            self.ui.borrarEstPlanilla.setEnabled(False)

        #EVENT LISTENERS.
        self.ui.backPlanilla.clicked.connect(lambda: self.close())
        self.ui.backNotas.clicked.connect(lambda: self.close())
        self.ui.backActividades.clicked.connect(lambda: self.close())
        self.ui.backTemas.clicked.connect(lambda: self.close())
        self.ui.backInasistencia.clicked.connect(lambda: self.close())





#-----------------------------------------------------------------------------------------------------------------------

#MAIN.
if __name__ == "__main__":
    '''Carga PyQT5 y crea y abre en primera instancia la ventana Login.'''
    app = QtWidgets.QApplication([])
    login = loginWindow()
    login.show()
    sys.exit(app.exec())