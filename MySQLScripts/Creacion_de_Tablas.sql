DROP SCHEMA IF EXISTS `E_ntrenate` ;
CREATE SCHEMA IF NOT EXISTS `E_ntrenate` DEFAULT CHARACTER SET utf8 ;
USE `E_ntrenate` ;


-- Table `E_ntrenate`.`Grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Grupo ;
CREATE TABLE IF NOT EXISTS Grupo (
  `Grup_Nombre` VARCHAR(45) NOT NULL,
  `Grup_Num participantes` INT NOT NULL,
  `Grup_Link` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Grup_Nombre`),
  UNIQUE INDEX `Link_UNIQUE` (`Grup_Link` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Grup_Nombre` ASC) VISIBLE);

-- Table `E_ntrenate`.`Tutor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Tutor ;
CREATE TABLE IF NOT EXISTS Tutor (
  `Tut_id` INT AUTO_INCREMENT ,
  `Tut_Correo` VARCHAR(45) NOT NULL,
  `Tut_Nombre` VARCHAR(45) NOT NULL,
  `Tut_Telefono` BIGINT NOT NULL,
  PRIMARY KEY (`Tut_id`),
  UNIQUE INDEX `Correo_UNIQUE` (`Tut_Correo` ASC) VISIBLE
);

-- Table `E_ntrenate`.`Materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Materia ;
CREATE TABLE IF NOT EXISTS Materia (
  `Mat_id` VARCHAR(45) NOT NULL,
  `Mat_Nombre` VARCHAR(45) NOT NULL,
  `Grup_Nombre` VARCHAR(45) NOT NULL,
  `Tut_Correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Mat_id`, `Grup_Nombre`),
  UNIQUE INDEX `idMateria_UNIQUE` (`Mat_id` ASC) VISIBLE,
  INDEX `fk_Materia_Tutor1_idx` (`Tut_Correo` ASC) VISIBLE,
  CONSTRAINT `fk_Materia_Grupo1`
    FOREIGN KEY (`Grup_Nombre`)
    REFERENCES Grupo (`Grup_Nombre`),
  CONSTRAINT `fk_Materia_Tutor1`
    FOREIGN KEY (`Tut_Correo`)
    REFERENCES Tutor (`Tut_Correo`)
);

-- Table `E_ntrenate`.`Planilla`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Planilla ;
CREATE TABLE IF NOT EXISTS Planilla (
  `Plan_id` VARCHAR(45) NOT NULL,
  `Mat_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Plan_id`, `Mat_id`),
  UNIQUE INDEX `Inscripción_idMateria_UNIQUE` (`Plan_id` ASC) VISIBLE,
  INDEX `fk_Planilla_Materia1_idx` (`Mat_id` ASC) VISIBLE,
  CONSTRAINT `fk_Planilla_Materia1`
    FOREIGN KEY (`Mat_id`)
    REFERENCES Materia (`Mat_id`)
);


-- Table `E_ntrenate`.`Tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Tema ;
CREATE TABLE IF NOT EXISTS Tema (
  `Tema_id` INT AUTO_INCREMENT,
  `Tema_Nombre` VARCHAR(45) NOT NULL,
  `Tema_Fecha_Inicio` VARCHAR(45) NOT NULL,
  `Tema_Fecha_Final` VARCHAR(45) NOT NULL,
  `Mat_id` VARCHAR(45) NOT NULL,
  INDEX `fk_Tema_Temario1_idx` (`Mat_id` ASC) VISIBLE,
  PRIMARY KEY (`Tema_id`),
  UNIQUE INDEX `nombreTema_UNIQUE` (`Tema_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Tema_Temario1`
    FOREIGN KEY (`Mat_id`)
    REFERENCES Materia (`Mat_id`)
);

-- Table `E_ntrenate`.`Actividad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Actividad;
CREATE TABLE IF NOT EXISTS Actividad (
  `Act_id` INT(40) auto_increment ,
  `Act_nombre` VARCHAR(40) NOT NULL,
  `Act_descripcion` VARCHAR(255) DEFAULT "Actividad en clase",
  `Act_TipoActividad` VARCHAR(45) DEFAULT "Tarea",
  `Act_Fecha_entrega` VARCHAR(45) NOT NULL,
  `Act_MaxNota` TINYINT(1) DEFAULT 0,
  `Act_MinNota` TINYINT(1) DEFAULT 0,
  `Act_TipoEntrega` VARCHAR(45) DEFAULT 'Classroom',
  `Tema_id` INT NOT NULL,
  PRIMARY KEY (`Act_id`),
  UNIQUE INDEX `nombre_UNIQUE` (`Act_nombre` ASC) VISIBLE,
  FOREIGN KEY (`Tema_id`)
  REFERENCES Tema(`Tema_id`)
  
  );




-- Table `E_ntrenate`.`Estudiante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Estudiante ;
CREATE TABLE IF NOT EXISTS Estudiante (
  `Est_id` INT AUTO_INCREMENT  ,
  `Est_correo` VARCHAR(45) NOT NULL,
  `Est_nombre` VARCHAR(45) NOT NULL,
  `Est_telefono` BIGINT NOT NULL,
  UNIQUE INDEX `Correo_UNIQUE` (`Est_correo` ASC) VISIBLE,
  PRIMARY KEY (`Est_id`));

-- Table `E_ntrenate`.`Estudiante_has_Planilla`
-- -----------------------------------------------------
DROP TABLE IF EXISTS inscripcion_materia ;
CREATE TABLE IF NOT EXISTS inscripcion_materia (
  `Est_correo` VARCHAR(45) NOT NULL,
  `Plan_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Est_correo`, `Plan_id`),
  INDEX `fk_Estudiante_has_Planilla_Planilla1_idx` (`Plan_id` ASC) VISIBLE,
  INDEX `fk_Estudiante_has_Planilla_Estudiante1_idx` (`Est_correo` ASC) VISIBLE,
  CONSTRAINT `fk_Estudiante_has_Planilla_Estudiante1`
    FOREIGN KEY (`Est_correo`)
    REFERENCES Estudiante (`Est_correo`),
  CONSTRAINT `fk_Estudiante_has_Planilla_Planilla1`
    FOREIGN KEY (`Plan_id`)
    REFERENCES Planilla (`Plan_id`)
);


-- Table `E_ntrenate`.`Inscripción`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Nota ;
CREATE TABLE IF NOT EXISTS Nota(
  `not_id` INT AUTO_INCREMENT,
  `Est_correo` VARCHAR(45) NOT NULL,
  `Act_id` INT NOT NULL, 
  `Nota` INT DEFAULT 0,
  PRIMARY KEY (`not_id`),  
  INDEX `index_est_correo` (`Est_correo` ASC) VISIBLE,
  CONSTRAINT `index_est_correo`
  FOREIGN KEY (`Est_correo`)
  REFERENCES Estudiante (`Est_correo`),
  FOREIGN KEY (`Act_id`)
  REFERENCES Actividad (`Act_id`)
    
);

DROP TABLE IF EXISTS Inasistencia ;
CREATE TABLE IF NOT EXISTS Inasistencia(
  `ina_id` INT AUTO_INCREMENT,
  `Est_correo` VARCHAR(45) NOT NULL,
  `Mat_id` VARCHAR(45) NOT NULL,
  `fecha_inasistencia` VARCHAR(20) DEFAULT ("Agregar fecha"),
  PRIMARY KEY (`ina_id`),
  INDEX `fk_Estudiante_has_Materia_Estudiante1_idx` (`Est_correo` ASC) VISIBLE,
    FOREIGN KEY (`Est_correo`)
    REFERENCES Estudiante (`Est_correo`),
    FOREIGN KEY (`Mat_id`)
    REFERENCES Materia (`Mat_id`)
);
-- Table `E_ntrenate`.`Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Horario ;
CREATE TABLE IF NOT EXISTS Horario(
  `Hor_id` INT AUTO_INCREMENT,
  `Mat_id` VARCHAR(45) NOT NULL,
  `Hor_Dia` VARCHAR(45) NOT NULL,
  `Hor_Hora_De_Inicio` VARCHAR(45) NOT NULL,
  `Hor_Hora_De_Fin` VARCHAR(45) NOT NULL,
  INDEX `fk_Horario_Materia1_idx` (`Mat_id` ASC) VISIBLE,
  PRIMARY KEY (`Hor_id`),
  CONSTRAINT `fk_Horario_Materia1`
    FOREIGN KEY (`Mat_id`)
    REFERENCES Materia (`Mat_id`)
);

-- Table `E_ntrenate`.`Encuesta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Encuesta ;
CREATE TABLE IF NOT EXISTS Encuesta (
  `Enc_id` VARCHAR(45) NOT NULL,
  `Enc_Tipo` VARCHAR(45) NOT NULL,
  `Enc_Fecha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Enc_id`),
  UNIQUE INDEX `idEncuesta_UNIQUE` (`Enc_id` ASC) VISIBLE);

-- Table `E_ntrenate`.`Pregunta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Pregunta ;
CREATE TABLE IF NOT EXISTS Pregunta (
  `Enc_id` VARCHAR(45) NOT NULL,
  `Preg_id` VARCHAR(45) NOT NULL,
  `Pregunta` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Enc_id`, `Preg_id`),
  UNIQUE INDEX `idPregunta_UNIQUE` (`Preg_id` ASC) VISIBLE,
  INDEX `fk_Pregunta_Encuesta1_idx` (`Enc_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pregunta_Encuesta1`
    FOREIGN KEY (`Enc_id`)
    REFERENCES Encuesta (`Enc_id`)
);

-- Table `E_ntrenate`.`Respuesta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS Respuesta ;
CREATE TABLE IF NOT EXISTS Respuesta (
  `Est_correo` VARCHAR(45) NOT NULL,
  `Preg_id` VARCHAR(100) NOT NULL,
  `Respuestas` VARCHAR(255) NOT NULL DEFAULT 'Sin respuesta',
  PRIMARY KEY (`Est_correo`, `Preg_id`),
  INDEX `fk_Respuesta_Estudiante1_idx` (`Est_correo` ASC) VISIBLE,
  CONSTRAINT `fk_Respuesta_Estudiante1`
    FOREIGN KEY (`Est_correo`)
    REFERENCES Estudiante (`Est_correo`),
  CONSTRAINT `fk_Respuesta_Pregunta1`
    FOREIGN KEY (`Preg_id`)
    REFERENCES Pregunta (`Preg_id`)
);