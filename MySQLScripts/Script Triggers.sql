-- SCRIPT DE CREACIÓN DE TRIGGERS

use e_ntrenate;
-- LOG DE NOTAS (GENERAL)

DROP TABLE IF EXISTS log_notas;
CREATE TABLE log_notas(
	Fecha VARCHAR(45),
    Mat_id VARCHAR(45),
    Mat_Nombre VARCHAR(45),
    Act_id INT,
    Act_nombre VARCHAR(40),
    Est_correo VARCHAR(45),
    Nota INT,
    Accion ENUM('INSERT','UPDATE', 'DELETE')
);

DROP TABLE IF EXISTS log_tutor;
CREATE TABLE log_tutor(
	Fecha VARCHAR(45),
    Tut_id VARCHAR(45),
    Tut_correo VARCHAR(45),
    Tut_nombre VARCHAR(45),
    Tut_telefono BIGINT,
    old_tut_id VARCHAR(40) DEFAULT 'none', 
    old_tut_correo VARCHAR(40) DEFAULT 'none',
    old_tut_nombre VARCHAR(40) DEFAULT 'none',
    old_tut_telefono BIGINT DEFAULT 0,
    Accion ENUM('INSERT','UPDATE', 'DELETE')
);

DROP TABLE IF EXISTS log_estudiante;
CREATE TABLE log_estudiante(
	Fecha VARCHAR(45),
    est_id VARCHAR(45),
    est_correo VARCHAR(45),
    est_nombre VARCHAR(45),
    est_telefono BIGINT,
    old_est_id VARCHAR(45),
    old_est_correo VARCHAR(45),
    old_est_nombre VARCHAR(45),
    old_est_telefono BIGINT,
    
    Accion ENUM('INSERT','UPDATE', 'DELETE')
);


-- LOG DE ACTIVIDADES (GENERAL)
DROP TABLE IF EXISTS log_actividades;
CREATE TABLE log_actividades(
	Fecha VARCHAR(45),
    Mat_id VARCHAR(45),
    Mat_Nombre VARCHAR(45),
    Act_id INT,
    Act_nombre VARCHAR(40),
    Tema_id INT,
    Tema_Nombre VARCHAR(45),
    Accion ENUM('INSERT','UPDATE', 'DELETE')
);


-- LOG DE TEMAS (GENERAL)
DROP TABLE IF EXISTS log_temas;
CREATE TABLE log_temas(
	Fecha VARCHAR(45),
    Mat_id VARCHAR(45),
    Mat_Nombre VARCHAR(45),
    Tema_id INT,
    Tema_Nombre VARCHAR(45),
    Accion ENUM('INSERT','UPDATE', 'DELETE')
);


-- LOG DE INASISTENCIAS (GENERAL)
DROP TABLE IF EXISTS log_inasistencias;
CREATE TABLE log_inasistencias(
	Fecha VARCHAR(45),
    Est_Correo VARCHAR(45),
    Mat_id VARCHAR(45),
    Mat_Nombre VARCHAR(45),
    Usuario VARCHAR(45),
    Accion ENUM('INSERT','UPDATE', 'DELETE')
);


-- TRIGGERS SOBRE NOTA
DROP TRIGGER IF EXISTS tr_notas_in;
DELIMITER |
CREATE TRIGGER tr_notas_in BEFORE INSERT ON nota
FOR EACH ROW BEGIN
DECLARE id_materia VARCHAR(45);
DECLARE nombre_materia VARCHAR(45);
DECLARE nombre_actividad VARCHAR(40);

SELECT Mat_id INTO id_materia FROM actividad NATURAL JOIN tema NATURAL JOIN materia WHERE Act_id = NEW.Act_id;
SELECT Mat_nombre INTO nombre_materia FROM actividad NATURAL JOIN tema NATURAL JOIN materia WHERE Act_id = NEW.Act_id;
SELECT Act_nombre INTO nombre_actividad FROM actividad WHERE Act_id = NEW.Act_id;

INSERT INTO log_notas (Fecha, Mat_id, Mat_nombre, Act_id, Act_nombre, Est_correo, Nota, Accion)
VALUES (CURRENT_TIMESTAMP(), id_materia, nombre_materia, NEW.Act_id, nombre_actividad, NEW.Est_correo, NEW.nota, 'INSERT');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_notas_del;
DELIMITER |
CREATE TRIGGER tr_notas_del BEFORE DELETE ON nota
FOR EACH ROW BEGIN
DECLARE id_materia VARCHAR(45);
DECLARE nombre_materia VARCHAR(45);
DECLARE nombre_actividad VARCHAR(40);

SELECT Mat_id INTO id_materia FROM actividad NATURAL JOIN tema NATURAL JOIN materia WHERE Act_id = OLD.Act_id;
SELECT Mat_nombre INTO nombre_materia FROM actividad NATURAL JOIN tema NATURAL JOIN materia WHERE Act_id = OLD.Act_id;
SELECT Act_nombre INTO nombre_actividad FROM actividad WHERE Act_id = OLD.Act_id;

INSERT INTO log_notas (Fecha, Mat_id, Mat_nombre, Act_id, Act_nombre, Est_correo, Nota, Accion)
VALUES (CURRENT_TIMESTAMP(), id_materia, nombre_materia, OLD.Act_id, nombre_actividad, OLD.Est_correo, OLD.nota, 'DELETE');
END;
|
DELIMITER ;

DROP TRIGGER IF EXISTS tr_notas_upd;
DELIMITER |
CREATE TRIGGER tr_notas_upd BEFORE UPDATE ON nota
FOR EACH ROW BEGIN
DECLARE id_materia VARCHAR(45);
DECLARE nombre_materia VARCHAR(45);
DECLARE nombre_actividad VARCHAR(40);

SELECT Mat_id INTO id_materia FROM actividad NATURAL JOIN tema NATURAL JOIN materia WHERE Act_id = NEW.Act_id;
SELECT Mat_nombre INTO nombre_materia FROM actividad NATURAL JOIN tema NATURAL JOIN materia WHERE Act_id = NEW.Act_id;
SELECT Act_nombre INTO nombre_actividad FROM actividad WHERE Act_id = NEW.Act_id;

INSERT INTO log_notas (Fecha, Mat_id, Mat_nombre, Act_id, Act_nombre, Est_correo, Nota, Accion)
VALUES (CURRENT_TIMESTAMP(), id_materia, nombre_materia, NEW.Act_id, nombre_actividad, NEW.Est_correo, NEW.nota, 'UPDATE');
END;
|
DELIMITER ;



-- TRIGGERS SOBRE ACTIVIDAD

DROP TRIGGER IF EXISTS tr_actividad_in;
DELIMITER |
CREATE TRIGGER tr_actividad_in AFTER INSERT ON actividad
FOR EACH ROW BEGIN
DECLARE id_materia VARCHAR(45);
DECLARE nombre_materia VARCHAR(45);
DECLARE nombre_tema VARCHAR(45);

SELECT Mat_id INTO id_materia FROM tema NATURAL JOIN materia WHERE Tema_id = NEW.Tema_id;
SELECT Mat_nombre INTO nombre_materia FROM tema NATURAL JOIN materia WHERE Tema_id = NEW.Tema_id;
SELECT Tema_nombre INTO nombre_tema FROM tema WHERE Tema_id = NEW.Tema_id;

INSERT INTO log_actividades (Fecha, Mat_id, Mat_nombre, Act_id, Act_nombre, Tema_id, Tema_Nombre, Accion)
VALUES (CURRENT_TIMESTAMP(), id_materia, nombre_materia, NEW.Act_id, NEW.Act_nombre, NEW.Tema_id, nombre_tema, 'INSERT');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_actividad_upd;
DELIMITER |
CREATE TRIGGER tr_actividad_upd BEFORE UPDATE ON actividad
FOR EACH ROW BEGIN
DECLARE id_materia VARCHAR(45);
DECLARE nombre_materia VARCHAR(45);
DECLARE nombre_tema VARCHAR(45);

SELECT Mat_id INTO id_materia FROM tema NATURAL JOIN materia WHERE Tema_id = NEW.Tema_id;
SELECT Mat_nombre INTO nombre_materia FROM tema NATURAL JOIN materia WHERE Tema_id = NEW.Tema_id;
SELECT Tema_nombre INTO nombre_tema FROM tema WHERE Tema_id = NEW.Tema_id;

INSERT INTO log_actividades (Fecha, Mat_id, Mat_nombre, Act_id, Act_nombre, Tema_id, Tema_Nombre, Accion)
VALUES (CURRENT_TIMESTAMP(), id_materia, nombre_materia, NEW.Act_id, NEW.Act_nombre, NEW.Tema_id, nombre_tema, 'UPDATE');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_actividad_del;
DELIMITER |
CREATE TRIGGER tr_actividad_del BEFORE DELETE ON actividad
FOR EACH ROW BEGIN
DECLARE id_materia VARCHAR(45);
DECLARE nombre_materia VARCHAR(45);
DECLARE nombre_tema VARCHAR(45);

SELECT Mat_id INTO id_materia FROM tema NATURAL JOIN materia WHERE Tema_id = OLD.Tema_id;
SELECT Mat_nombre INTO nombre_materia FROM tema NATURAL JOIN materia WHERE Tema_id = OLD.Tema_id;
SELECT Tema_nombre INTO nombre_tema FROM tema WHERE Tema_id = OLD.Tema_id;

INSERT INTO log_actividades (Fecha, Mat_id, Mat_nombre, Act_id, Act_nombre, Tema_id, Tema_Nombre, Accion)
VALUES (CURRENT_TIMESTAMP(), id_materia, nombre_materia, OLD.Act_id, OLD.Act_nombre, OLD.Tema_id, nombre_tema, 'DELETE');
END;
|
DELIMITER ;


-- TRIGGERS SOBRE TEMA
DROP TRIGGER IF EXISTS tr_tema_in;
DELIMITER |
CREATE TRIGGER tr_tema_in AFTER INSERT ON tema
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(45);

SELECT Mat_nombre INTO nombre_materia FROM materia WHERE Mat_id = NEW.Mat_id;

INSERT INTO log_temas (Fecha, Mat_id, Mat_nombre, Tema_id, Tema_Nombre, Accion)
VALUES (CURRENT_TIMESTAMP(), NEW.Mat_id, nombre_materia, NEW.Tema_id, NEW.Tema_Nombre, 'INSERT');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_tema_upd;
DELIMITER |
CREATE TRIGGER tr_tema_upd BEFORE UPDATE ON tema
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(45);

SELECT Mat_nombre INTO nombre_materia FROM materia WHERE Mat_id = NEW.Mat_id;

INSERT INTO log_temas (Fecha, Mat_id, Mat_nombre, Tema_id, Tema_Nombre, Accion)
VALUES (CURRENT_TIMESTAMP(), NEW.Mat_id, nombre_materia, NEW.Tema_id, NEW.Tema_Nombre, 'UPDATE');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_tema_del;
DELIMITER |
CREATE TRIGGER tr_tema_del BEFORE DELETE ON tema
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(45);

SELECT Mat_nombre INTO nombre_materia FROM materia WHERE Mat_id = OLD.Mat_id;

INSERT INTO log_temas (Fecha, Mat_id, Mat_nombre, Tema_id, Tema_Nombre, Accion)
VALUES (CURRENT_TIMESTAMP(), OLD.Mat_id, nombre_materia, OLD.Tema_id, OLD.Tema_Nombre, 'DELETE');
END;
|
DELIMITER ;

-- TRIGGER SOBRE INASISTENCIA
DROP TRIGGER IF EXISTS tr_inasistencia_in;
DELIMITER |
CREATE TRIGGER tr_inasistencia_in AFTER INSERT ON inasistencia
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(40);

SELECT Mat_Nombre INTO nombre_materia FROM materia WHERE Mat_id = NEW.Mat_id;

INSERT INTO log_inasistencias (Fecha, Est_correo, Mat_id, Mat_Nombre, Usuario, Accion)
VALUES (CURDATE(), NEW.Est_correo, NEW.Mat_id, nombre_materia, USER(), 'INSERT');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_inasistencia_upd;
DELIMITER |
CREATE TRIGGER tr_inasistencia_upd BEFORE UPDATE ON inasistencia
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(40);

SELECT Mat_Nombre INTO nombre_materia FROM materia WHERE Mat_id = NEW.Mat_id;

INSERT INTO log_inasistencias (Fecha, Est_correo, Mat_id, Mat_Nombre, Usuario, Accion)
VALUES (CURDATE(), NEW.Est_correo, NEW.Mat_id, nombre_materia, USER(), 'UPDATE');
END;
|
DELIMITER ;



DROP TRIGGER IF EXISTS tr_inasistencia_del;
DELIMITER |
CREATE TRIGGER tr_inasistencia_del BEFORE DELETE ON inasistencia
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(40);

SELECT Mat_Nombre INTO nombre_materia FROM materia WHERE Mat_id = OLD.Mat_id;

INSERT INTO log_inasistencias (Fecha, Est_correo, Mat_id, Mat_Nombre, Usuario, Accion)
VALUES (CURDATE(), OLD.Est_correo, OLD.Mat_id, nombre_materia, USER(), 'DELETE');
END;
|
DELIMITER ;


DROP TRIGGER IF EXISTS tr_delete_tutor;
DELIMITER |
CREATE TRIGGER tr_delete_tutor BEFORE DELETE ON tutor
FOR EACH ROW BEGIN

INSERT INTO log_tutor (fecha,tut_id,tut_correo,tut_nombre,tut_telefono,accion) VALUES (CURDATE(),old.tut_id,old.tut_correo,old.tut_nombre,old.tut_telefono,'DELETE');

END;
|
DELIMITER ;

DROP TRIGGER IF EXISTS tr_insert_tutor;
DELIMITER |
CREATE TRIGGER tr_insert_tutor AFTER insert ON tutor
FOR EACH ROW BEGIN
DECLARE nombre_materia VARCHAR(40);

INSERT INTO log_tutor   (fecha,tut_id,tut_correo,tut_nombre,tut_telefono,accion)  VALUES (CURDATE(),new.tut_id,new.tut_correo,new.tut_nombre,new.tut_telefono,'INSERT');

END;
|
DELIMITER ;

-- Borrado en cascada de un estudiante:

DROP TRIGGER IF EXISTS tr_delete_est;
DELIMITER |
CREATE TRIGGER tr_delete_est before delete ON estudiante
FOR EACH ROW BEGIN

INSERT INTO log_estudiante   (fecha,est_id,est_correo,est_nombre,est_telefono,accion)  VALUES (CURDATE(),old.est_id,old.est_correo,old.est_nombre,old.est_telefono,'DELETE');

END;
|
DELIMITER ;

DROP TRIGGER IF EXISTS tr_ins_est;
DELIMITER |
CREATE TRIGGER tr_ins_est AFTER insert ON estudiante
FOR EACH ROW BEGIN

INSERT INTO log_estudiante   (fecha,est_id,est_correo,est_nombre,est_telefono,accion)  VALUES (CURDATE(),new.est_id,new.est_correo,new.est_nombre,new.est_telefono,'INSERT');
END;
|
DELIMITER ;


DROP TRIGGER IF EXISTS tr_upd_est;
DELIMITER |
CREATE TRIGGER tr_upd_est BEFORE update ON estudiante
FOR EACH ROW BEGIN
SET FOREIGN_KEY_CHECKS=0;

UPDATE inscripcion_materia  SET est_correo=new.est_correo WHERE est_correo=old.est_correo;
UPDATE nota  SET nota.est_correo=new.est_correo WHERE est_correo=old.est_correo;
UPDATE respuesta  SET respuesta.est_correo=new.est_correo  WHERE est_correo=old.est_correo;
UPDATE inasistencia SET est_correo=new.est_correo  WHERE est_correo=old.est_correo;
INSERT INTO log_estudiante  VALUES (CURDATE(),new.est_id,new.est_correo,new.est_nombre,new.est_telefono,
																							old.est_id,old.est_correo,old.est_nombre,old.est_telefono,'UPDATE');
SET FOREIGN_KEY_CHECKS=1;
END;
|
DELIMITER ;

-- DELETE FROM estudiante WHERE est_correo='2004y1978@gmail.com';
-- UPDATE estudiante SET est_correo='WEYNO@gmail.com' WHERE est_correo='alysonvaron@gmail.com';