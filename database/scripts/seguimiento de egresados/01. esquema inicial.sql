use SWIITL;

/*********************  INICIO MODIFICACIONES MIÉRCOLES 8 DE MAYO 2019 *********************************
 * CONTROL DE CAMBIOS EN AMBIENTES
 * LOCAL:      PENDIENTE (FECHA DE APLICACIÓN)
 * PRUEBAS:    PENDIENTE (FECHA DE APLICACIÓN)
 * PRODUCCIÓN: PENDIENTE (FECHA DE APLICACIÓN)
*/

-- AQUÍ SE INDICAN TODOS LOS CAMBIOS QUE SE HAGAN DURANTE EL DÍA O RANGO DE FECHAS

-- DDL PARA LAS TABLAS: CAT_ENCUESTA, CATR_SECCION, CAT_TIPO_PREGUNTA, CATR_PREGUNTA, TR_SECCION_PREGUNTA, CATR_RESPUESTA_POSIBLE, TR_APLICACION_ENCUESTA, TR_RESPUESTA_USUARIO_ENCUESTA
CREATE TABLE CAT_ENCUESTA(
	PK_ENCUESTA INT NOT NULL IDENTITY,
	NOMBRE VARCHAR (100) NOT NULL,
	OBJETIVO TEXT,
	INSTRUCCIONES TEXT,
	FK_USUARIO_REGISTRO INT,
	FK_USUARIO_MODIFICACION INT,
	FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
	FECHA_MODIFICACION DATETIME,
	BORRADO NCHAR(1) DEFAULT '0' NOT NULL
	PRIMARY KEY (PK_ENCUESTA)
)
go

CREATE TABLE CAT_TIPO_PREGUNTA(
    PK_TIPO_PREGUNTA  INT NOT NULL IDENTITY,
	NOMBRE_TIPO_PREGUNTA VARCHAR (100) NOT NULL,
	FK_USUARIO_REGISTRO INT,
	FK_USUARIO_MODIFICACION INT,
	FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
	FECHA_MODIFICACION DATETIME,
	BORRADO NCHAR(1) DEFAULT '0' NOT NULL
	PRIMARY KEY (PK_TIPO_PREGUNTA)
)
go

CREATE TABLE CATR_SECCION(
	PK_SECCION INT NOT NULL IDENTITY,
	NOMBRE_SECCION VARCHAR (100) NOT NULL,
	NUMERO_SECCION INT NOT NULL,
	OBJETIVO TEXT,
	INSTRUCCIONES TEXT,
	FK_ENCUESTA INT,
	FK_USUARIO_REGISTRO INT,
	FK_USUARIO_MODIFICACION INT,
	FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
	FECHA_MODIFICACION DATETIME,
	BORRADO NCHAR(1) DEFAULT '0' NOT NULL
	PRIMARY KEY (PK_SECCION)
	FOREIGN KEY (FK_ENCUESTA) REFERENCES CAT_ENCUESTA (PK_ENCUESTA)
)
go

CREATE TABLE CATR_PREGUNTA(
	PK_PREGUNTA INT NOT NULL IDENTITY,
    ORDEN INT NOT NULL,
    PLANTEAMIENTO VARCHAR(300) NOT NULL,
    TEXTO_GUIA VARCHAR(100) NOT NULL,
    FK_TIPO_PREGUNTA INT,
    FK_SECCION INT,
    FK_USUARIO_REGISTRO INT,
    FK_USUARIO_MODIFICACION INT,
    FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
    FECHA_MODIFICACION DATETIME,
    BORRADO NCHAR(1) DEFAULT '0' NOT NULL
    PRIMARY KEY (PK_PREGUNTA)
    FOREIGN KEY (FK_TIPO_PREGUNTA) REFERENCES CAT_TIPO_PREGUNTA (PK_TIPO_PREGUNTA)
    FOREIGN KEY (FK_SECCION) REFERENCES CATR_SECCION (PK_SECCION)
)
go


CREATE TABLE CATR_RESPUESTA_POSIBLE(
	PK_RESPUESTA_POSIBLE INT NOT NULL IDENTITY,
	RESPUESTA VARCHAR(100),
	FK_PREGUNTA INT,
	FK_USUARIO_REGISTRO INT,
	FK_USUARIO_MODIFICACION INT,
	FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
	FECHA_MODIFICACION DATETIME,
	BORRADO NCHAR(1) DEFAULT '0' NOT NULL
	PRIMARY KEY (PK_RESPUESTA_POSIBLE)
	FOREIGN KEY (FK_PREGUNTA) REFERENCES CATR_PREGUNTA (PK_PREGUNTA)
)
go

CREATE TABLE TR_APLICACION_ENCUESTA(
    PK_APLICACION_ENCUESTA INT NOT NULL IDENTITY,
    FECHA_APLICACION DATETIME,
    FK_USUARIO INT,
    FK_ENCUESTA INT,
    FK_USUARIO_REGISTRO INT,
    FK_USUARIO_MODIFICACION INT,
    FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
    FECHA_MODIFICACION DATETIME,
    BORRADO NCHAR(1) DEFAULT '0' NOT NULL
    PRIMARY KEY (PK_APLICACION_ENCUESTA)
    FOREIGN KEY (FK_ENCUESTA) REFERENCES CAT_ENCUESTA (PK_ENCUESTA),
    FOREIGN KEY (FK_USUARIO) REFERENCES users (PK_USUARIO)
)

CREATE TABLE TR_RESPUESTA_USUARIO_ENCUESTA(
    PK_RESPUESTA_USUARIO_ENCUESTA INT NOT NULL IDENTITY,
    RESPUESTA_ABIERTA TEXT,
    FK_RESPUESTA_POSIBLE INT,
    FK_APLICACION_ENCUESTA INT,
    FK_USUARIO_REGISTRO INT,
    FK_USUARIO_MODIFICACION INT,
    FECHA_REGISTRO DATETIME DEFAULT getdate() NOT NULL,
    FECHA_MODIFICACION DATETIME,
    BORRADO NCHAR(1) DEFAULT '0' NOT NULL
    PRIMARY KEY (PK_RESPUESTA_USUARIO_ENCUESTA)
    FOREIGN KEY (FK_RESPUESTA_POSIBLE) REFERENCES CATR_RESPUESTA_POSIBLE(PK_RESPUESTA_POSIBLE),
    FOREIGN KEY (FK_APLICACION_ENCUESTA) REFERENCES TR_APLICACION_ENCUESTA (PK_APLICACION_ENCUESTA)
)


/*********************  FIN MODIFICACIONES MIÉRCOLES 8 DE MAYO 2019 *********************************/


-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
