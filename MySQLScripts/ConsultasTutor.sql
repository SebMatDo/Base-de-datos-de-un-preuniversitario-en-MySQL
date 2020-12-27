-- TUTOR
USE e_ntrenate;

DROP PROCEDURE IF EXISTS cons_estudiantes;
DROP PROCEDURE IF EXISTS cons_materias_dictadas;
DROP PROCEDURE IF EXISTS ins_nota_est;
DROP PROCEDURE IF EXISTS ins_actividad;
DROP PROCEDURE IF EXISTS ins_inasistencia;
DROP PROCEDURE IF EXISTS ins_tema;

DELIMITER $$
CREATE PROCEDURE cons_estudiantes(tutor_correo varchar(255))
BEGIN
-- 1. Consultar nombre y teléfono de los estudiantes inscritos a una de las clases que da
  
SELECT Mat_id,Mat_nombre,Est_correo,est_nombre,est_telefono FROM estudiante NATURAL JOIN inscripcion_materia NATURAL JOIN planilla NATURAL JOIN materia WHERE Tut_Correo= tutor_correo;
END $$

Create procedure notastutor (Materiadictada varchar(60))
begin
Select Est_correo, Act_nombre, Nota from tema natural join actividad natural join nota where Mat_Id = Materiadictada;
End $$


Create procedure actividadestutor (Materiadictada varchar(60))
begin
Select Act_id, Act_nombre, Act_descripcion, Act_TipoActividad, Act_Fecha_entrega, Act_MaxNota, Act_MinNota, Act_TipoEntrega, Tema_id from tema natural join actividad where Mat_Id = Materiadictada;
End $$

Create procedure temastutor (Materiadictada varchar(60))
begin
Select Tema_id, Tema_Nombre, Tema_Fecha_Inicio, Tema_Fecha_Final from tema where Mat_Id = Materiadictada;
End $$

Create procedure Inasistenciastutor (Materiadictada varchar(60))
begin
Select ina_id, fecha_inasistencia, Est_correo from inasistencia where Mat_Id = Materiadictada;
End $$

CREATE PROCEDURE cons_materias_dictadas(tutor_correo varchar(255))
BEGIN
SELECT Mat_id,Mat_nombre,grup_nombre FROM materia WHERE Tut_Correo= tutor_correo;
END $$


CREATE PROCEDURE ins_nota_est(estudiante varchar(255), act_id INT (6) ,nota INT(6),tut_nombre varchar(255))
BEGIN
   set @sql = concat("INSERT INTO ",  concat("e_ntrenate.Nota_",tut_nombre), " (Est_correo,act_id,nota) VALUES ","(","'",estudiante,"'",",","'",act_id,"'",",",nota,")" );
   PREPARE stmt1 FROM @sql;
   EXECUTE stmt1;
   DEALLOCATE PREPARE stmt1;
END $$

CREATE PROCEDURE ins_actividad(nombre varchar(255), descripcion varchar(255), tipo varchar(255), fecha varchar(255), tipoentrega varchar(255), tema_id varchar(255), tut_nombre varchar(255))
BEGIN
-- 2. Hacer un conteo de todos los estudiantes de su clase que su número de teléfono inicie con "311" Este es necesario?
   set @sql = concat("INSERT INTO ",  concat("e_ntrenate.actividad_",tut_nombre), " (Act_nombre,Act_descripcion,Act_tipoactividad,Act_fecha_entrega,act_tipoentrega,tema_id)
   VALUES (" , "'" , nombre , "'" , "," , "'" ,descripcion,"'" , "," ,"'" ,tipo,"'" , "," ,"'" ,fecha,"'" , "," ,"'" ,tipoentrega,"'" , "," ,tema_id, ")" );
   PREPARE stmt1 FROM @sql;
   EXECUTE stmt1;
   DEALLOCATE PREPARE stmt1;
END $$


CREATE PROCEDURE ins_inasistencia(estudiante varchar(255),materia varchar(255),fecha varchar(25), tut_nombre varchar(255))
BEGIN
   set @sql = concat("INSERT INTO ",  concat("e_ntrenate.inasistencia_",tut_nombre), " (Est_correo,Mat_id,fecha_inasistencia) VALUES ","(","'",estudiante,"'",",","'",materia,"'",",",fecha,")" );
   PREPARE stmt1 FROM @sql;
   EXECUTE stmt1;
   DEALLOCATE PREPARE stmt1;
END $$

CREATE PROCEDURE ins_tema(nombre varchar(255), inicio varchar(255), fin varchar(255), materia varchar(255), tut_nombre varchar(255))
BEGIN
INSERT INTO tema (Tema_nombre, tema_fecha_inicio,tema_fecha_final,mat_id) VALUES (nombre,inicio,fin,materia);
   set @sql = concat("INSERT INTO ",  concat("e_ntrenate.tema_",tut_nombre), "(Tema_nombre,tema_fecha_inicio,tema_fecha_final,mat_id) VALUES (" , "'", nombre, "'" ,",", "'" ,inicio , "'" ,
   "," , "'" , fin, "'" , "," , "'" , materia, "'",")" );
   PREPARE stmt1 FROM @sql;
   EXECUTE stmt1;
   DEALLOCATE PREPARE stmt1;
END $$
