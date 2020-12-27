-- Procedures Administrador
USE e_ntrenate;
DROP PROCEDURE IF EXISTS cons_estudiantes_total;
DROP PROCEDURE IF EXISTS cons_tutores_total;

DELIMITER $$
CREATE PROCEDURE cons_estudiantes_total()
BEGIN

SELECT Est_correo,Est_nombre,Est_telefono FROM estudiante;
END $$ 

CREATE PROCEDURE cons_tutores_total()
BEGIN

SELECT tut_correo,tut_nombre,tut_telefono FROM tutor;

END $$ 

    END ;
    
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_estudiante;
DELIMITER $$
CREATE PROCEDURE delete_estudiante(old_est_correo varchar(255))
BEGIN
START TRANSACTION;
	DELETE FROM inscripcion_materia WHERE est_correo=old_est_correo;
	DELETE FROM nota WHERE est_correo=old_est_correo;
	DELETE FROM respuesta WHERE est_correo=old_est_correo;
	DELETE FROM inasistencia where inasistencia.est_correo=old_est_correo;
	DELETE FROM ESTUDIANTE WHERE est_correo=old_est_correo;
	CALL drop_user(old_est_correo);
COMMIT;

END $$ 
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_tutor;
DELIMITER $$
CREATE PROCEDURE delete_tutor(old_tut_correo varchar(255))
BEGIN
START TRANSACTION;
	UPDATE materia SET tut_correo='none';
	DELETE FROM TUTOR WHERE tut_correo=old_tut_correo;
	CALL drop_old_views(old_tut_correo);
	CALL drop_user(old_tut_correo);
    
COMMIT;

END $$ 
DELIMITER ;

-- Procedimiento insertar estudiante a materia.
DROP PROCEDURE IF EXISTS ins_est_materia;
DELIMITER &&
CREATE PROCEDURE ins_est_materia(correo VARCHAR(45), materia VARCHAR(45))
	BEGIN
		DECLARE exist_est_id int(10);
		DECLARE planillaid VARCHAR(45);
        SELECT Plan_id INTO planillaid FROM planilla WHERE Mat_id = materia;
        SELECT  est_id from estudiante where est_correo=correo into exist_est_id;
		START TRANSACTION;
			IF planillaid = Null THEN
				ROLLBACK;
			ELSE
				INSERT INTO inscripcion_materia VALUES(correo, planillaid);
            END IF;
        COMMIT;
        
    END &&;
DELIMITER ;


DROP PROCEDURE IF EXISTS ins_est;
DELIMITER &&
CREATE PROCEDURE ins_est(correo VARCHAR(45), materia VARCHAR(45), nombre varchar(255), telefono bigint)
	BEGIN
		DECLARE exist_est_id int(10);
        SELECT  est_id from estudiante where est_correo=correo into exist_est_id;
		START TRANSACTION;
			IF exist_est_id != Null THEN
				ROLLBACK;
			ELSE
				INSERT INTO estudiante (est_correo,est_nombre,est_telefono) VALUES (correo,nombre,telefono);
                call ins_est_materia(correo,materia);
                call create_new_student(correo,'123456');
            END IF;
        COMMIT;
        
    END &&;
DELIMITER ;


-- Procedimiento insertar nueva materia.
DROP PROCEDURE IF EXISTS ins_materia;
DELIMITER &&
CREATE PROCEDURE ins_materia(nombre VARCHAR(45), grupo VARCHAR(45), tutor VARCHAR(45))
	BEGIN
		DECLARE cantidad INT DEFAULT 0;
        DECLARE materiaid VARCHAR(45);
        DECLARE filas INT;
        SELECT COUNT(*) INTO cantidad FROM materia WHERE Mat_Nombre = nombre;
        SELECT COUNT(*) INTO filas FROM materia WHERE Grup_Nombre = grupo;
        
        START TRANSACTION;
			IF  cantidad > 0 THEN
				ROLLBACK;
			ELSE
				IF grupo = "ICFES" THEN
					SET materiaid = CONCAT("ICFES-", filas+1);
				ELSEIF grupo = "Study Group" THEN
					SET materiaid = CONCAT("SG-", filas+1);
				INSERT INTO materia VALUES (materiaid, nombre, grupo, tutor);
                END IF;
			END IF;
		COMMIT;
    END &&;
DELIMITER ;


-- Procedimiento insertar tutor
DROP PROCEDURE IF EXISTS ins_tutor;
DELIMITER &&
CREATE PROCEDURE ins_tutor(correo VARCHAR(45), nombre VARCHAR(45), telefono BIGINT, mat_id VARCHAR(45))
	BEGIN
		DECLARE cantidad INT;
        DECLARE tutor_materia VARCHAR(45) DEFAULT NULL;
        SELECT COUNT(*) INTO cantidad FROM tutor WHERE Tut_correo = correo OR Tut_Telefono = telefono;
        
        START TRANSACTION;
			IF cantidad > 0 OR tutor_materia != null THEN
				ROLLBACK;
			ELSE
				INSERT INTO tutor (Tut_Correo, Tut_Nombre, Tut_Telefono) VALUES (correo, nombre, telefono);
                UPDATE materia SET Tut_Correo = correo WHERE Materia.mat_id = mat_id;
                CALL create_new_tutor(correo,'123456');
            END IF;
        COMMIT;
    END &&;
DELIMITER ;



-- procedimiento actualizar un tutor

DROP PROCEDURE IF EXISTS upd_tutor_materia_no_insert;
DELIMITER &&
CREATE PROCEDURE upd_tutor_materia_no_insert(new_tutor varchar(45), materia varchar(45)  )
	BEGIN
    DECLARE nombre varchar(25);
	DECLARE act varchar(25);
    DECLARE ina varchar(25);
    DECLARE nota varchar(25);
    DECLARE tem varchar(25);
	DECLARE old_tut_id varchar (45);
    DECLARE old_tut_nombre varchar (45);
    DECLARE old_tut_telefono BIGINT (45);
    DECLARE old_tut_correo varchar(45);
    DECLARE `_rollback` BOOL DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;

	START TRANSACTION ;
		SELECT tut_correo from materia where  mat_id=materia into old_tut_correo;
		UPDATE materia SET tut_correo = new_tutor WHERE materia.mat_id=materia;
        DELETE FROM tutor where tut_correo=old_tut_correo;
      --  DROP USER old_tut_correo @'localhost';
      --  CALL drop_old_views(old_tut_correo);
        CALL create_new_tutor(new_tut_correo,'123456');
        SELECT tut_id from tutor where tutor.tut_correo=old_tut_correo into old_tut_id;
        SELECT tut_nombre from tutor where tutor.tut_correo=old_tut_correo into old_tut_nombre;
        SELECT tut_telefono from tutor where tutor.tut_correo=old_tut_correo into old_tut_telefono;
        
        INSERT INTO log_tutor VALUES (CURDATE(),new_tut_id,new_tut_correo,new_tut_nombre,new_tut_telefono,old_tut_id,old_tut_correo,old_tut_nombre,old_tut_telefono,'UPDATE');
        
	 IF `_rollback` THEN
			ROLLBACK;
        
    ELSE
        COMMIT;
	END IF;
        
    END &&;
DELIMITER ;

DROP PROCEDURE IF EXISTS upd_tutor_materia;
DELIMITER &&
CREATE PROCEDURE upd_tutor_materia(old_tut_correo VARCHAR(45), new_tut_correo VARCHAR(45), new_tut_nombre VARCHAR(45), new_tut_telefono varchar(45), materia varchar(45)  )
	BEGIN
    DECLARE nombre varchar(25);
	DECLARE act varchar(25);
    DECLARE ina varchar(25);
    DECLARE nota varchar(25);
    DECLARE tem varchar(25);
	DECLARE old_tut_id varchar (45);
    DECLARE old_tut_nombre varchar (45);
    DECLARE old_tut_telefono BIGINT (45);
    DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;

	START TRANSACTION ;
    
		INSERT tutor (tut_correo,tut_nombre,tut_telefono) VALUES (new_tut_correo,new_tut_nombre,new_tut_telefono);
		UPDATE materia SET tut_correo = new_tut_correo WHERE materia.tut_correo=old_tut_correo;
--        DELETE FROM tutor where tut_correo=old_tut_correo;
--        DROP USER old_tut_correo @'localhost';
--        CALL drop_old_views(old_tut_correo);
        CALL create_new_tutor(new_tut_correo,'123456');
        SELECT tut_id from tutor where tutor.tut_correo=old_tut_correo into old_tut_id;
        SELECT tut_nombre from tutor where tutor.tut_correo=old_tut_correo into old_tut_nombre;
        SELECT tut_telefono from tutor where tutor.tut_correo=old_tut_correo into old_tut_telefono;
        
        INSERT INTO log_tutor VALUES (CURDATE(),new_tut_id,new_tut_correo,new_tut_nombre,new_tut_telefono,old_tut_id,old_tut_correo,old_tut_nombre,old_tut_telefono,'UPDATE');
        
	 IF `_rollback` THEN
			ROLLBACK;
        
    ELSE
        COMMIT;
	END IF;
        
    END &&;
DELIMITER ;


DROP PROCEDURE IF EXISTS upd_tutor_info

delimiter &&
CREATE PROCEDURE upd_tutor_info(old_tut_correo varchar(255),correo varchar(255),nombre varchar(255) , telefono bigint)
begin
SET FOREIGN_KEY_CHECKS=0;
update materia set tut_correo=correo where tut_correo=old_tut_correo;
update tutor set tut_correo = correo, tut_nombre=nombre,tut_telefono=telefono where tut_correo=old_tut_correo;
SET FOREIGN_KEY_CHECKS=1;
end&&
delimiter ;
-- call upd_tutor_materia("juanbermudezgomez@outlook.es","DonPeponsio@gmail.com",'Peponsio',3126543254,'ICF-01');

DROP PROCEDURE IF EXISTS drop_old_views;
DELIMITER &&
CREATE PROCEDURE drop_old_views(old_tut_correo varchar(45))
	BEGIN
    
  DECLARE nombre varchar(25);
    DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
    
    
START TRANSACTION; 
  select ( substring_index (old_tut_correo, '@',1)) into nombre;
    
 set @sql = concat(" DROP VIEW ", concat("e_ntrenate.actividad_",nombre));
 PREPARE stmt1 FROM @sql;
 EXECUTE stmt1;
 DEALLOCATE PREPARE stmt1;
 
 set @sql = concat(" DROP VIEW ", concat("e_ntrenate.inasistencia_",nombre));
 PREPARE stmt2 FROM @sql;
 EXECUTE stmt2;
 DEALLOCATE PREPARE stmt2;
 
 set @sql = concat(" DROP VIEW ", concat("e_ntrenate.nota_",nombre));
 PREPARE stmt3 FROM @sql;
 EXECUTE stmt3;
 DEALLOCATE PREPARE stmt3;
 
 set @sql = concat(" DROP VIEW ", concat("e_ntrenate.tema_",nombre));
 PREPARE stmt4 FROM @sql;
 EXECUTE stmt4;
 DEALLOCATE PREPARE stmt4;
 
 set @sql = concat(" DROP USER ","'", old_tut_correo,"'", " @ ","'","localhost","'");
 PREPARE stmt5 FROM @sql;
 EXECUTE stmt5;
 DEALLOCATE PREPARE stmt5;
 
 
 	 IF `_rollback` THEN
			ROLLBACK;
        
    ELSE
        COMMIT;
	END IF;

	END &&
DELIMITER ;

-- Consultar información de tutores
DROP PROCEDURE IF EXISTS cons_tutor;
DELIMITER &&
CREATE PROCEDURE cons_tutor(correo VARCHAR(45))
	BEGIN
		SELECT Tut_Nombre, Tut_Correo, Tut_Telefono, Mat_id, Mat_Nombre 
        FROM tutor NATURAL JOIN materia WHERE Tut_Correo = correo;
    END &&;
DELIMITER ;


-- Consultar información de estudiantes
DROP PROCEDURE IF EXISTS cons_estudiante;
DELIMITER &&
CREATE PROCEDURE cons_estudiante(correo VARCHAR(45))
	BEGIN
		SELECT Est_nombre, Est_correo, Est_telefono, Mat_id, Mat_Nombre, ina_inasistencia
        FROM estudiante NATURAL JOIN inscripcion_materia NATURAL JOIN planilla
        NATURAL JOIN materia NATURAL JOIN inasistencias
        WHERE Est_correo = correo;
        
    END &&;
DELIMITER ;


-- Editar estudiante
DROP PROCEDURE IF EXISTS upd_estudiante;
DELIMITER &&
CREATE PROCEDURE upd_estudiante(correo VARCHAR(45), nombre VARCHAR(45), correoNew VARCHAR(45), telefono BIGINT)
	BEGIN
		UPDATE estudiante SET Est_nombre = nombre, Est_correo = correoNew, Est_telefono = telefono 
        WHERE Est_correo = correo;
    END &&;
DELIMITER ;

DROP PROCEDURE IF EXISTS cons_materias_total;
DELIMITER &&
CREATE PROCEDURE cons_materias_total( grupo varchar(255) )
BEGIN
-- Consultar todas las materias inscritas
if grupo='ICFES'
then
SELECT DISTINCT * from materia where grup_nombre like 'ICF%';
elseif grupo ='Study Group'
THEN
SELECT DISTINCT * from materia where grup_nombre like 'Study Group%';
elseif grupo='Todo'
THEN
SELECT DISTINCT * from materia;
end if;
END &&;
DELIMITER ;


DROP PROCEDURE IF EXISTS log_estudiante;
DELIMITER &&
CREATE PROCEDURE log_estudiante()
	BEGIN
		SELECT * FROM log_estudiante;
    END &&;
DELIMITER ;



DROP PROCEDURE IF EXISTS log_tutor;
DELIMITER &&
CREATE PROCEDURE log_tutor()
	BEGIN
		SELECT * FROM log_tutor;
    END &&;
DELIMITER ;



