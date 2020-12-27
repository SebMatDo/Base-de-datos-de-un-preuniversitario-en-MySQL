USE e_ntrenate;

-- Datos de Estudiantes --
-- Importar CSV's.


-- Datos de Grupos --
SHOW COLUMNS FROM grupo;
INSERT INTO grupo VALUES("Study Group", 144 ,"https://chat.whatsapp.com/123456789");
INSERT INTO grupo VALUES("ICFES", 200,"https://chat.whatsapp.com/123456789");

-- Datos de Tutores --

SHOW COLUMNS FROM tutor;
INSERT tutor values(0,'none','none',0);
INSERT INTO tutor (Tut_Correo,Tut_Nombre,Tut_Telefono) VALUES ("santix860@gmail.com", "Santiago Rodríguez", 3204192656);



-- Datos de Materias --

SHOW COLUMNS FROM materia;
INSERT INTO materia VALUES("SG-01", "Matemáticas Básicas", "Study Group", "tutor1@gmail.com");
INSERT INTO materia VALUES("SG-02", "Química", "Study Group", "tutor2@gmail.com");
INSERT INTO materia VALUES("SG-03", "Biología", "Study Group", "t3@gmail.com");
INSERT INTO materia VALUES("SG-04", "Análisis Textual", "Study Group", "t4@gmail.com");
INSERT INTO materia VALUES("SG-05", "Filosofía", "Study Group",  "ty@gmail.com");
INSERT INTO materia VALUES("SG-06", "Sociales", "Study Group",  "t5@gmail.com");
INSERT INTO materia VALUES("SG-07", "Análisis de Imagen", "Study Group", "t6@outlook.com");
INSERT INTO materia VALUES("SG-08", "Programación", "Study Group",  "t7@gmail.com");
INSERT INTO materia VALUES("SG-09", "Hábitos de Estudio", "Study Group", "t8@gmail.com");
INSERT INTO materia VALUES("SG-10", "Photoshop", "Study Group", "t9@unimagdalena.edu");
INSERT INTO materia VALUES("ICF-01", "Matemáticas", "ICFES",  "t7@outlook.es");
INSERT INTO materia VALUES("ICF-02", "Química", "ICFES", "t6@gmail.com");
INSERT INTO materia VALUES("ICF-03", "Física", "ICFES",  "t8@hotmail.com");
INSERT INTO materia VALUES("ICF-04", "Biología", "ICFES",  "t6@gmail.com");
INSERT INTO materia VALUES("ICF-05", "Lectura Crítica", "ICFES", "t3@gmail.com");
INSERT INTO materia VALUES("ICF-06", "Sociales", "ICFES",  "t2@gmail.com");
INSERT INTO materia VALUES("ICF-07", "Inglés", "ICFES",  "t1@gmail.com");

 -- Datos de horarios --

SHOW COLUMNS FROM horario;
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-06', "Lunes", "7:00", "10:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-02', "Lunes", "11:00", "13:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-01', "Lunes", "14:00", "15:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-07', "Lunes", "16:00", "17:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-03', "Lunes", "19:00", "20:00");
INSERT INTO horario  (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-04', "Martes", "9:00", "12:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-03', "Martes", "14:00", "16:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-01', "Martes", "14:00", "16:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-06', "Martes", "16:00", "18:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-01', "Miercoles", "11:00", "13:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-05', "Miercoles", "14:00", "17:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-07', "Miercoles", "16:00", "18:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-03', "Miercoles", "19:00", "21:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-10', "Miercoles", "20:00", "23:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-06', "Jueves", "7:00", "10:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-02', "Jueves", "11:00", "13:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-03', "Jueves", "14:00", "16:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-05', "Jueves", "17:00", "19:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-02', "Jueves", "19:00", "20:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-04', "Jueves", "20:00", "22:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-01', "Viernes", "11:00", "13:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-03', "Viernes", "14:00", "16:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-05', "Viernes", "17:00", "18:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-07', "Viernes", "17:00", "19:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-03', "Viernes", "19:00", "20:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-02', "Viernes", "19:00", "20:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-05', "Sabado", "14:00", "17:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-04', "Sabado", "15:00", "17:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-08', "Sabado", "18:00", "20:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-06', "Sabado", "18:00", "20:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('ICF-07', "Domingo", "17:00", "18:00");
INSERT INTO horario (Mat_id,Hor_dia,Hor_hora_de_inicio,Hor_hora_de_fin) VALUES('SG-09', "Domingo", "18:00", "19:00");

-- Datos de encuesta --
SHOW COLUMNS FROM encuesta;
INSERT INTO encuesta VALUES("ContacICFES","Descriptiva","Abril de 2020");
INSERT INTO encuesta VALUES("SondeoUNAL","Analitica","Abril de 2020");
INSERT INTO encuesta VALUES("Registro de Evento","Descriptiva","Junio de 2020");

-- Datos de Pregunta --
SHOW COLUMNS FROM pregunta;
INSERT INTO Pregunta VALUES("ContacICFES",	"ContacICFES_0",	"Lugar de Residencia");
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_1',	'Carrera a la que aspira');
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_2',	'¿Ha presentado usted antes las pruebas ICFES?');
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_3',	'Podría escribir aquí los temas que siente usted que más se le dificultan:');
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_4',	'¿Cuenta usted con tiempo disponible para asistir a las clases?');
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_5',	'¿Qué horario se le facilita?');
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_6',	'¿Cree usted necesario crear entrega de trabajos, talleres, etc?');
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_7',	'¿Está usted dispuesto a ser activo en el grupo y cumplir con los requisitos y así mismo promover a la mejoría de todos?'); 
INSERT INTO Pregunta VALUES('ContacICFES',	'ContacICFES_8',	'Por favor escriba aquí las sugerencias que tiene usted para las clases, y demás actividades de aprendizaje');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_0',		'¿Está usted de acuerdo con la realización de clases virtuales en E-ntrenate?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_1',		'¿Está usted dispuesto a asistir a todas o a la mayoría de clases en E-ntrenate?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_2',		'¿Qué plataforma o estrategia sugiere para la realización de las clases?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_3',		'¿En qué días de la semana sugiere usted que se realicen las clases?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_4',		'¿En qué horario sugiere que se hagan las clases?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_5',		'¿Qué duración sugiere usted que tenga cada una de las clases?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_6',		'¿Está de acuerdo con el uso de una plataforma adicional para dejar trabajos/talleres/hacer exámenes? En caso afirmativo, ¿cuál?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_7',		'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Matemáticas]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_8',     'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Química]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_9',	    'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Biología]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_10',	 'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Física]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_11',	'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Sociales]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_12',	'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Análisis Textual]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_13',	'Indique con una puntuación del 1 al 5 la importancia que requiere ser enseñada cada una de las siguientes materias. Donde 1 indica que no es importante enseñarla, y 5 indica que es fundamental enseñarla [Análisis de Imágen]');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_14',	'¿Cuál de las siguientes opciones le parece una buena estrategia para que los tutores den las clases?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_15',	'¿Qué herramientas adicionales desea que usen los tutores a la hora de dar su clase?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_16',	'¿Tiene alguna recomendación adicional?');
INSERT INTO Pregunta VALUES('SondeoUNAL',	'SondeoUNAL_17',	'¿Desea usted participar en la convocatoria para ser tutor?');
INSERT INTO Pregunta VALUES('Registro de Evento',	'Registro de Evento_0',		'Numero de telefono');
INSERT INTO Pregunta VALUES('Registro de Evento',	'Registro de Evento_1',		'¿Qué Materia desea estudiar? (puede seleccionar mas de una)');

-- Datos respuestas --


-- Datos de Inscripción --

-- Datos de  planilla--

SHOW COLUMNS FROM planilla;
INSERT INTO planilla VALUES ("Planilla01","SG-01");
INSERT INTO planilla VALUES ("Planilla02","SG-02");
INSERT INTO planilla VALUES ("Planilla03","SG-03");
INSERT INTO planilla VALUES ("Planilla04","SG-04");
INSERT INTO planilla VALUES ("Planilla05","SG-05");
INSERT INTO planilla VALUES ("Planilla06","SG-06");
INSERT INTO planilla VALUES ("Planilla07","SG-07");
INSERT INTO planilla VALUES ("Planilla08","SG-08");
INSERT INTO planilla VALUES ("Planilla09","SG-09");
INSERT INTO planilla VALUES ("Planilla10","SG-10");

INSERT INTO planilla VALUES ("Planilla11","ICF-01");
INSERT INTO planilla VALUES ("Planilla12","ICF-02");
INSERT INTO planilla VALUES ("Planilla13","ICF-03");
INSERT INTO planilla VALUES ("Planilla14","ICF-04");
INSERT INTO planilla VALUES ("Planilla15","ICF-05");
INSERT INTO planilla VALUES ("Planilla16","ICF-06");
INSERT INTO planilla VALUES ("Planilla17","ICF-07");


SHOW COLUMNS FROM tema;

SHOW COLUMNS FROM actividad;


Use e_ntrenate;
SELECT * FROM grupo;
SELECT * FROM actividad;
SELECT * FROM tema;
SELECT * FROM nota;
SELECT * FROM inasistencia;
SELECT * FROM estudiante;
SELECT * FROM tutor;
SELECT * FROM materia;
SELECT * FROM horario;
SELECT * FROM planilla;
SELECT * FROM encuesta;
SELECT * FROM pregunta;
SELECT * FROM respuesta;
SELECT * FROM inscripcion_materia;


