-- Consultas estudiantiles --
USE e_ntrenate;

DROP PROCEDURE IF EXISTS cons_info_tutor;
DROP PROCEDURE IF EXISTS cons_horario;
DROP PROCEDURE IF EXISTS cons_est_materia;
DROP PROCEDURE IF EXISTS cons_link;
DROP PROCEDURE IF EXISTS cons_encuestas;
DROP PROCEDURE IF EXISTS cons_nota_materia;
DROP PROCEDURE IF EXISTS cons_inasistencias;
DROP PROCEDURE IF EXISTS cons_materias_inscritas;
DROP PROCEDURE IF EXISTS cons_count_inasistencias;
DROP PROCEDURE IF EXISTS cons_total_encuestas;
DROP PROCEDURE IF EXISTS cons_materia;
DROP PROCEDURE IF EXISTS cons_horario_materia;
DROP FUNCTION IF EXISTS promedio_nota;
DROP PROCEDURE IF EXISTS cons_actividades;
DROP PROCEDURE IF EXISTS cons_nota_actividad;
DROP PROCEDURE IF EXISTS Todaslasmaterias;
DROP PROCEDURE IF EXISTS Miinfo;

DELIMITER $$
Create procedure Todaslasmaterias (id_materia_elegida varchar(40))
BEGIN
Select Mat_id, Mat_Nombre, Grup_Nombre, tut_Nombre, Tut_Correo, Tut_Telefono, Hor_Dia, Hor_Hora_De_Inicio, Hor_Hora_De_Fin  from materia natural join tutor natural join horario where mat_id = id_materia_elegida;
END $$

Create procedure Miinfo (correoestudiante varchar(60))
begin
Select Est_id, Est_nombre, Est_correo, Est_Telefono from estudiante where Est_correo = correoestudiante;
END $$

CREATE PROCEDURE cons_actividades(mat_id varchar(255) )
BEGIN

SELECT DISTINCT Act_nombre,Act_descripcion,Act_tipoActividad,Act_Fecha_entrega,act_tipoEntrega,tema_nombre FROM actividad natural join tema WHERE tema.mat_id=mat_id;

END $$

CREATE PROCEDURE cons_nota_actividad(est_id  varchar(255), act_nombre  varchar(255))
BEGIN
SELECT DISTINCT nota FROM actividad  natural join nota
where nota.est_correo=est_id and  actividad.act_nombre=act_nombre;

END$$

drop procedure if Exists infotablahorario;
Create Procedure infotablahorario (correo varchar(60))
Begin
Select Hor_Dia, Hor_Hora_De_Inicio, Hor_Hora_De_Fin, Mat_Nombre, Grup_Nombre from Estudiante NATURAL JOIN inscripcion_materia NATURAL JOIN planilla natural join materia natural join Horario where Est_correo = "andreabalaguera12@gmail.com";
End $$


CREATE PROCEDURE cons_materia(mat_id varchar(255) )
BEGIN

SELECT * from materia where materia.mat_id=mat_id;
END $$

CREATE PROCEDURE cons_info_tutor(tutor_correo varchar(255) )
BEGIN

-- 1. Consultar  toda la información sobre los tutores de dicha materia
SELECT Tut_Nombre as Nombre,Tut_Correo as Correo,Tut_Telefono as Telefono 
FROM  tutor NATURAL JOIN (materia NATURAL JOIN  planilla)  
WHERE tut_correo = tutor_correo;

END $$

CREATE PROCEDURE cons_horario( est_correo varchar(255))
BEGIN

-- 2. Consultar los horarios en los que ve clase

SELECT Mat_id,Mat_nombre,Hor_dia,Hor_Hora_De_Inicio,Hor_Hora_De_Fin FROM  horario NATURAL JOIN( inscripcion_materia NATURAL JOIN  planilla) natural join materia
WHERE inscripcion_materia.Est_correo = est_correo;

END $$

CREATE PROCEDURE cons_horario_materia ( mat_id varchar(255))
BEGIN

-- 2. Consultar los horarios en los que ve clase

SELECT Hor_dia,Hor_Hora_De_Inicio,Hor_Hora_De_Fin FROM  horario NATURAL JOIN materia
WHERE materia.mat_id= mat_id;

END $$
CREATE PROCEDURE cons_est_materia(mat_id varchar(255) )
BEGIN

-- 3. Consultar información de los estudiantes que lo acompañan en una materia en la que esté inscrito
SELECT DISTINCT Est_nombre as Nombre, Est_correo as Correo, Est_telefono as Telefono FROM  
estudiante NATURAL JOIN planilla NATURAL JOIN inscripcion_materia WHERE planilla.Mat_id = mat_id ;

END $$


CREATE PROCEDURE cons_link(est_correo varchar(255)) 
BEGIN

-- 4. Consultar el link de los grupos a los que pertenezca

SELECT DISTINCT Grup_Nombre,Grup_link AS grupo FROM (materia NATURAL JOIN inscripcion_materia NATURAL JOIN  planilla)
WHERE inscripcion_materia.Est_correo = est_correo;

END $$


CREATE PROCEDURE cons_encuestas(est_correo varchar(255) )
BEGIN
-- 5. Consultar preguntas y respuestas realizadas en encuestas

SELECT Enc_id,Pregunta,Respuestas FROM encuesta NATURAL JOIN pregunta  NATURAL JOIN respuesta WHERE respuesta.Est_correo = est_correo;
END $$


CREATE PROCEDURE cons_total_encuestas( )
BEGIN
-- 5. Consultar preguntas y respuestas realizadas en encuestas

SELECT * from encuesta;
END $$


CREATE PROCEDURE cons_nota_materia(est_correo varchar(255) , mat_id varchar(255) )
BEGIN

-- 5. Consultar la nota final de una materia
SELECT promedio_nota(est_correo,mat_id);

END $$



CREATE PROCEDURE cons_materias_inscritas( est_correo varchar(255))
BEGIN
-- Consultar todas las materias inscritas

SELECT DISTINCT Mat_id,Mat_nombre,Grup_nombre,Tut_correo FROM MATERIA NATURAL JOIN inscripcion_materia  NATURAL JOIN planilla WHERE inscripcion_materia.EST_CORREO=est_correo;
END $$





CREATE PROCEDURE cons_inasistencias(est_correo varchar(255), mat_id varchar(255))
BEGIN
SELECT fecha_inasistencia from inasistencia NATURAL JOIN materia where inasistencia.est_correo=est_correo and inasistencia.mat_id=mat_id;
END $$

CREATE PROCEDURE cons_count_inasistencias(est_correo varchar(255), mat_id varchar(255))
BEGIN
-- consultar todas las fallas de todas las materias

SELECT count(*) from inasistencia NATURAL JOIN materia where inasistencia.est_correo=est_correo and inasistencia.mat_id=mat_id ;
END $$


-- FUNCION PARA PROMEDIAR NOTAS
CREATE FUNCTION promedio_nota(est_correo varchar (255) , materia varchar(255)) RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE notaint INT;
DECLARE n INT;

SELECT SUM(nota) FROM nota NATURAL JOIN actividad NATURAL JOIN tema NATURAL JOIN materia WHERE nota.est_correo=est_correo and mat_id=materia INTO notaint;
SELECT COUNT(nota) FROM nota NATURAL JOIN actividad NATURAL JOIN tema  NATURAL JOIN materia  WHERE nota.est_correo=est_correo and mat_id=materia INTO n;
RETURN notaint/n;
END $$

DELIMITER ;
