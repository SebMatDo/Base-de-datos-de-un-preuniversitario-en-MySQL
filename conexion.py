import mysql.connector
from mysql.connector import Error

global connection
global cursor


def start_conection(useri, passwordi):

    hosti = 'localhost'
    databasei = 'e_ntrenate'
    # useri = 'juanbermudezgomez@outlook.es'
    # passwordi= '123456'
    try:
        global connection
        connection = mysql.connector.connect(user=useri, password=passwordi,
                                             host=hosti, database=databasei)

        if connection.is_connected():
            print("Conectado exitosamente")
            global cursor
            cursor = connection.cursor()
            return 1


    except Error as e:
        print("Error while connecting to MySQL", e)
        return 0

def end_conection():
    if not connection.is_connected():
        return

    connection.close()
    cursor.close()
    print("MySQL connection is closed")

def get_role():
    try:
        query = "get_rol"
        result = cursor.callproc(query, [])
        for result in cursor.stored_results():
            myarr = result.fetchall()

        rol = myarr[len(myarr)-1]

        for i in rol:
            if 'Tutor' in i:
                rol='Tutor'
            elif 'Estudiante' in i:
                rol='Estudiante'
            elif 'Admin' in i:
                rol='Admin'
        return rol

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_materias_inscritas(user):
    try:
        ### TOMA TODA LA INFO DE LAS MATERIAS INSCRITAS

        query = "cons_materias_inscritas"
        result = cursor.callproc(query,[user,])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()

        myarr=[]
        ### REDUCE LA INFO A ID,NOMBRE,GRUPO,TUTOR
        for i in range(0,len(myarrtemp)):
            tup = myarrtemp[i][0:4]

        ###### USA OTRO PA PARA SABER LAS NOTAS PROMEDIO DE CADA MATERIA
            query = "cons_nota_materia"
            mat_id=myarrtemp[i][0]
            result = cursor.callproc(query, [user,mat_id, ])
            myarrtemp2 = cursor.stored_results()
            for j in myarrtemp2:
                nota=j.fetchone()[0]
                nota=str(nota)
                if len(nota)>1:
                    a=("0", )
                    tup=tup+a
                else:
                    nota=(nota, )
                    tup=tup+nota

        #### USA OTRO PA PARA SABER EL CONTEO DE INASISTENCIAS
            query = "cons_count_inasistencias"
            mat_id = myarrtemp[i][0]
            result = cursor.callproc(query, [user, mat_id, ])
            myarrtemp2 = cursor.stored_results()
            for j in myarrtemp2:
                fallas = j.fetchone()[0]
                fallas = str(fallas)
                if len(fallas) > 1:
                    a = ("N",)
                    tup = tup + a
                else:
                    fallas = (fallas,)
                    tup = tup + fallas

            myarr.append(tup)



        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_materias(grupo):
    try:
        ### TOMA TODA LA INFO DE LAS MATERIAS INSCRITAS

        query = "cons_materias_total"
        result = cursor.callproc(query,[grupo])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr
    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_encuestas():
    try:
        query = "cons_total_encuestas"
        result = cursor.callproc(query,[])
        for result in cursor.stored_results():
            myarr = result.fetchall()

        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_materias_dictadas(user):
    try:
        query = "cons_materias_dictadas"
        result = cursor.callproc(query,[user])
        for result in cursor.stored_results():
            myarr = result.fetchall()

        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_Todaslasmaterias(materia):
    try:
        query = "Todaslasmaterias"
        result = cursor.callproc(query,[materia])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_miinfo(correo):
    try:
        query = "Miinfo"
        result = cursor.callproc(query,[correo])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_actividades(materia):
    try:
        query = "cons_actividades"
        result = cursor.callproc(query,[materia, ])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()
        return tup_to_tupstr(myarrtemp)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_nota_actividad(estudiante,act_nombre):
    try:
        query = "cons_nota_actividad"
        result = cursor.callproc(query,[estudiante, act_nombre, ])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()
        return tup_to_tupstr(myarrtemp)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_inasistencias(correo,materia):
    try:
        query = "cons_inasistencias"
        result = cursor.callproc(query,[correo,materia, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_tutor(correo):
    try:
        query = "cons_info_tutor"
        result = cursor.callproc(query,[correo, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_materia(mat_id):
    try:
        query = "cons_materia"
        result = cursor.callproc(query,[mat_id, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_horario_materia(mat_id):
    try:
        query = "cons_horario_materia"
        result = cursor.callproc(query, [mat_id, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return tup_to_str(myarr)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def send_query(query):
    try:
        result = cursor.callproc(query,[ ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def tup_to_str(myarr):
    try:
        mystring=''
        for tup in myarr:
            for elem in tup:
                if type(elem)==str:
                    mystring +=  elem+" "
                else:
                    mystring += str(elem) + " "
        return mystring

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def tup_to_tupstr(myarrtemp):
    try:
        myarr=[]

        for tup in myarrtemp:
            tuparr = []
            for elem in tup:
                if type(elem) == str:
                    tuparr.append(elem)
                else:
                    tuparr.append(str(elem))

            myarr.append(tuple(tuparr))
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def add_estudiante(estudiante, mat_id, nombre, tel ):
    try:
        myarr = []
        query = "ins_est"
        result = cursor.callproc(query, [estudiante, mat_id, nombre, tel, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def add_materia_estudiante(estudiante, mat_id):
    try:
        myarr = []
        query = "ins_est_materia"
        result = cursor.callproc(query, [estudiante, mat_id ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def add_tutor(correo,nombre,tel,mat):
    try:
        myarr = []
        query = "ins_tutor"
        result = cursor.callproc(query, [correo, nombre, tel, mat, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0


def add_materia_tutor(tutor, mat_id):
    try:
        myarr = []
        query = "upd_tutor_materia_no_insert"
        result = cursor.callproc(query, [tutor, mat_id ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def upd_estudiante(old_est, est,nombre,tel):
    try:
        myarr = []
        query = "upd_estudiante"
        result = cursor.callproc(query, [old_est, nombre, est, tel])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def delete_user(query,correo):
    try:
        myarr = []
        result = cursor.callproc(query, [correo,])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0


def update_est(old_correo,correo,nombre,tel):
    try:
        query='upd_estudiante'
        myarr = []
        result = cursor.callproc(query, [old_correo,correo,nombre,tel,])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0



def update_tut(old_correo,correo,nombre,tel):
    try:
        query='upd_tutor_info'
        myarr = []
        result = cursor.callproc(query, [old_correo,correo,nombre,tel, ])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0


def horariostabla(correo):
    try:
        query = "infotablahorario"
        result = cursor.callproc(query, [correo])
        for result in cursor.stored_results():
            myarr = result.fetchall()
        return myarr

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0


def Dia(A):
    q = -1
    if A == "Lunes":
        q = 0
    elif A == "Martes":
        q = 1
    elif A == "Miercoles":
        q = 2
    elif A == "Jueves":
        q = 3
    elif A == "Viernes":
        q = 4
    elif A == "Sabado":
        q = 5
    elif A == "Domingo":
        q = 6
    return q


def hora(B):
    n = -1
    if B == "6:00":
        n = 0
    elif B == "7:00":
        n = 1
    elif B == "8:00":
        n = 2
    elif B == "9:00":
        n = 3
    elif B == "10:00":
        n = 4
    elif B == "11:00":
        n = 5
    elif B == "12:00":
        n = 6
    elif B == "13:00":
        n = 7
    elif B == "14:00":
        n = 8
    elif B == "15:00":
        n = 9
    elif B == "16:00":
        n = 10
    elif B == "17:00":
        n = 11
    elif B == "18:00":
        n = 12
    elif B == "19:00":
        n = 13
    elif B == "20:00":
        n = 14
    elif B == "21:00":
        n = 15
    elif B == "22:00":
        n = 16
    elif B == "23:00":
        n = 17
    elif B == "24:00":
        n = 18
    elif B == "01:00":
        n = 19
    return n


def verificacion(t):
    v = 0
    h = 0
    while v < len(t) - 2:
        h = 0
        while h < len(t[0]):
            if v < 15:
                if t[v][h] == t[v + 2][h] and t[v][h] != "":
                    t[v + 1][h] = t[v][h]
                elif t[v][h] == t[v + 3][h] and t[v][h] != "":
                    t[v + 2][h] = t[v][h]
            else:
                if t[v][h] == t[v + 2][h] and t[v][h] != "":
                    t[v + 1][h] = t[v][h]
            h += 1
        v += 1


def Horario(Z):
    X = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"]
    Y = ["6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00",
         "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
    m = len(X)
    n = len(Y)
    t = []
    X = 0
    for i in range(n):
        fila = [""] * m
        t.append(fila)
    for j in Z:
        t[hora(j[1])][Dia(j[0])] = j[3] + "-" + j[4]
        t[hora(j[2]) - 1][Dia(j[0])] = j[3] + "-" + j[4]
    verificacion(t)
    return (t)

# Para conexiones colocar estas funciones
def get_notastutor(materia):
    try:
        query = "notastutor"
        result = cursor.callproc(query,[materia])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()
        return tup_to_tupstr(myarrtemp)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_actividadestutor(materia):
    try:
        query = "actividadestutor"
        result = cursor.callproc(query,[materia])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()
        return tup_to_tupstr(myarrtemp)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_temastutor(materia):
    try:
        query = "temastutor"
        result = cursor.callproc(query,[materia])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()
        return tup_to_tupstr(myarrtemp)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0

def get_Inasistenciastutor(materia):
    try:
        query = "Inasistenciastutor"
        result = cursor.callproc(query,[materia])
        for result in cursor.stored_results():
            myarrtemp = result.fetchall()
        return tup_to_tupstr(myarrtemp)

    except Error as e:
        print("HUBO UN ERROR CRITICO", e)
        return 0