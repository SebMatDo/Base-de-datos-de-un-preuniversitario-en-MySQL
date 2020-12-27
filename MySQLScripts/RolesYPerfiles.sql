 USE e_ntrenate;
DROP ROLE IF EXISTS 'Observador';
DROP ROLE IF EXISTS 'Estudiante';
DROP ROLE IF EXISTS 'Tutor';
DROP ROLE IF EXISTS 'Admin';
DROP USER IF EXISTS "andreabalaguera12@gmail.com"@"localhost";
DROP USER IF EXISTS "Santiago@hotmail.com"@"localhost";
DROP USER IF EXISTS "juanbermudezgomez@outlook.es"@"localhost";

-- CREACION DE ROLES
CREATE ROLE 'Observador' ;
GRANT SELECT ON grupo TO 'Observador';
GRANT SELECT ON horario TO 'Observador';
GRANT SELECT ON materia TO 'Observador';
GRANT SELECT ON pregunta TO 'Observador';
GRANT SELECT ON respuesta TO 'Observador';
GRANT SELECT ON tutor TO 'Observador';
GRANT SELECT ON tema TO 'Observador';
GRANT SELECT ON inscripcion_materia TO 'Observador';
GRANT SELECT ON estudiante TO 'Observador';
GRANT SELECT ON encuesta TO 'Observador';
GRANT SELECT ON nota TO 'Observador';
GRANT SELECT ON actividad TO 'Observador';
GRANT SELECT ON inasistencia TO 'Observador';
GRANT EXECUTE ON e_ntrenate.* TO 'Observador';
CREATE ROLE 'Estudiante';
CREATE ROLE 'Tutor';
CREATE ROLE 'Admin';


-- CREACION DE ESTUDIANTES Y ADMINISTRADORES AUTOMATICAMENTE
DROP PROCEDURE IF EXISTS create_new_student ;
DROP PROCEDURE IF EXISTS create_new_admin ;
DROP PROCEDURE IF EXISTS create_new_tutor ;

DELIMITER $$
CREATE PROCEDURE create_new_student( `user_name` VARCHAR(50), `passwd` VARCHAR(255) )
BEGIN
	DECLARE loc varchar(25);
    SET loc ='localhost';
   set @sql = concat("CREATE USER '",`user_name`,"'@'",loc,"' IDENTIFIED BY '",`passwd`,"'");
   PREPARE stmt1 FROM @sql;
   EXECUTE stmt1;
   DEALLOCATE PREPARE stmt1;
	
   set @sql = concat("GRANT 'Observador' ","TO '",`user_name`,"'@'",loc,"'");
   PREPARE stmt2 FROM @sql;
   EXECUTE stmt2;
   DEALLOCATE PREPARE stmt2;
   
   set @sql = concat("GRANT 'Estudiante' ","TO '",`user_name`,"'@'",loc,"'");
   PREPARE stmt4 FROM @sql;
   EXECUTE stmt4;
   DEALLOCATE PREPARE stmt4;
   
   
  set @sql = concat("SET DEFAULT ROLE 'Observador', " ," 'Estudiante' ",  "TO '", `user_name`, "'@'",loc,"'");
  PREPARE stmt11 FROM @sql;
  EXECUTE stmt11;
  DEALLOCATE PREPARE stmt11;
 
   
	 
END$$

CREATE PROCEDURE create_new_admin( `user_name` VARCHAR(50), `passwd` VARCHAR(255) )
BEGIN
	DECLARE loc varchar(25);
    SET loc ='localhost';
   set @sql = concat("CREATE USER '",`user_name`,"'@'",loc,"' IDENTIFIED BY '",`passwd`,"'");
   PREPARE stmt1 FROM @sql;
   EXECUTE stmt1;
   DEALLOCATE PREPARE stmt1;
  
  set @sql = concat("GRANT ALL PRIVILEGES ON  e_ntrenate.* TO '",`user_name`,"'@'",loc,"'");
   PREPARE stmt2 FROM @sql;
   EXECUTE stmt2;
   DEALLOCATE PREPARE stmt2;
   
    set @sql = concat("GRANT 'Admin' ","TO '",`user_name`,"'@'",loc,"'");
   PREPARE stmt4 FROM @sql;
   EXECUTE stmt4;
   DEALLOCATE PREPARE stmt4;
   
     set @sql = concat("SET DEFAULT ROLE 'Admin' ",  "TO '", `user_name`, "'@'",loc,"'");
  PREPARE stmt5 FROM @sql;
  EXECUTE stmt5;
  DEALLOCATE PREPARE stmt5;
 
END$$

CREATE PROCEDURE create_new_tutor( `user_name` VARCHAR(50), `passwd` VARCHAR(255) )
BEGIN
DECLARE nombre varchar(25);
 DECLARE loc varchar(25);
 
 select ( substring_index (`user_name`, '@',1)) into nombre;
  
 SET loc ='localhost';
 set @sql = concat("CREATE USER '",`user_name`,"'@'",loc,"' IDENTIFIED BY '",`passwd`,"'");
 PREPARE stmt1 FROM @sql;
 EXECUTE stmt1;
 DEALLOCATE PREPARE stmt1;
 
 set @sql = concat(" CREATE VIEW ", concat("e_ntrenate.actividad_",nombre), 
 " AS SELECT act_id,act_nombre,act_descripcion,act_tipoactividad,act_fecha_entrega,act_maxnota,act_minnota,act_tipoentrega,tema_id FROM ACTIVIDAD NATURAL JOIN TEMA NATURAL JOIN MATERIA where tut_correo= " , "'" ,`user_name`,"'");
 PREPARE stmt2 FROM @sql;
 EXECUTE stmt2;
 DEALLOCATE PREPARE stmt2;
 
  
 set @sql = concat(" CREATE VIEW ", concat("e_ntrenate.Nota_",nombre), 
 " AS SELECT not_id,est_correo,act_id,nota FROM nota NATURAL JOIN MATERIA natural join actividad where tut_correo= " , "'" ,`user_name`,"'");
 PREPARE stmt3 FROM @sql;
 EXECUTE stmt3;
 DEALLOCATE PREPARE stmt3;
 
 set @sql = concat(" CREATE VIEW ", concat("e_ntrenate.Inasistencia_",nombre), 
 " AS  SELECT ina_id,est_correo,mat_id,fecha_inasistencia FROM inasistencia NATURAL JOIN materia WHERE tut_correo= " , "'" ,`user_name`,"'");
 PREPARE stmt4 FROM @sql;
 EXECUTE stmt4;
 DEALLOCATE PREPARE stmt4;
 
 set @sql = concat(" CREATE VIEW ", concat("e_ntrenate.tema_",nombre), 
 " AS  SELECT tema_id,tema_nombre,tema_fecha_inicio,tema_fecha_final,mat_id FROM tema NATURAL JOIN materia WHERE tut_correo= " , "'" ,`user_name`,"'");
 PREPARE stmt5 FROM @sql;
 EXECUTE stmt5;
 DEALLOCATE PREPARE stmt5;
 
 set @sql = concat("GRANT ALL ON ",  concat("e_ntrenate.actividad_",nombre), " TO ","'",`user_name`,"'@'",loc,"'");
 PREPARE stmt6 FROM @sql;
 EXECUTE stmt6;
 DEALLOCATE PREPARE stmt6;
 
  set @sql = concat("GRANT ALL ON ",  concat("e_ntrenate.Nota_",nombre), " TO ","'",`user_name`,"'@'",loc,"'");
 PREPARE stmt7 FROM @sql;
 EXECUTE stmt7;
 DEALLOCATE PREPARE stmt7;
  
    set @sql = concat("GRANT ALL ON ",  concat("e_ntrenate.Inasistencia_",nombre), " TO ","'",`user_name`,"'@'",loc,"'");
 PREPARE stmt8 FROM @sql;
 EXECUTE stmt8;
 DEALLOCATE PREPARE stmt8;
 
    set @sql = concat("GRANT ALL ON ",  concat("e_ntrenate.tema_",nombre), " TO ","'",`user_name`,"'@'",loc,"'");
 PREPARE stmt9 FROM @sql;
 EXECUTE stmt9;
 DEALLOCATE PREPARE stmt9;
 
 set @sql = concat("GRANT 'Observador' ", " TO ","'",`user_name`,"'@'",loc,"'");
 PREPARE stmt10 FROM @sql;
 EXECUTE stmt10;
 DEALLOCATE PREPARE stmt10;
 
  set @sql = concat("GRANT 'Tutor' ","TO '",`user_name`,"'@'",loc,"'");
   PREPARE stmt12 FROM @sql;
   EXECUTE stmt12;
   DEALLOCATE PREPARE stmt12;
 
  set @sql = concat("SET DEFAULT ROLE 'Observador', " ," 'Tutor' ",  "TO '", `user_name`, "'@'",loc,"'");
  PREPARE stmt11 FROM @sql;
  EXECUTE stmt11;
  DEALLOCATE PREPARE stmt11;
 
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS get_rol;

DELIMITER &&
CREATE PROCEDURE get_rol()
BEGIN
DECLARE useri varchar(255);
DECLARE us varchar(255);
SELECT user() into us;
  SELECT SUBSTRING_INDEX(us, '@', 2) into useri;
  set @sql = concat("SHOW GRANTS FOR ' ", useri, "'@'", "localhost'");
  PREPARE stmt1 FROM @sql;
  EXECUTE stmt1;
  DEALLOCATE PREPARE stmt1;
END&&&
DELIMITER ;

DROP PROCEDURE IF EXISTS drop_user
DELIMITER &&
CREATE PROCEDURE drop_user(correo varchar(45))
BEGIN

  set @sql = concat("DROP USER' ", correo, "'@'", "localhost'");
  PREPARE stmt1 FROM @sql;
  EXECUTE stmt1;
  DEALLOCATE PREPARE stmt1;
END&&
DELIMITER ;

CALL create_new_student('andrea@gmail.com','123456');
CALL create_new_admin('santix860@gmail.com','123456');
CALL create_new_tutor('tutor_user@outlook.es','123456');
FLUSH PRIVILEGES;
SELECT * FROM mysql.user;