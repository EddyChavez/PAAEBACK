use SWIITL;

/*********************  INICIO MODIFICACIONES (RANGO DE FECHA O DÍA) (EJEMPLO LUNES 8 DE ABRIL) *********************************
 * CONTROL DE CAMBIOS EN AMBIENTES
 * LOCAL:      PENDIENTE (FECHA DE APLICACIÓN)
 * PRUEBAS:    PENDIENTE (FECHA DE APLICACIÓN)
 * PRODUCCIÓN: PENDIENTE (FECHA DE APLICACIÓN)
*/

-- AQUÍ SE INDICAN TODOS LOS CAMBIO QUE SE HAGAN DURANTE EL DÍA O RANGO DE FECHAS

CREATE PROCEDURE GENERAR_PREFICHA

@periodo INT,
-- Datos tabla users
@name VARCHAR(255),
@PRIMER_APELLIDO VARCHAR(255),
@SEGUNDO_APELLIDO VARCHAR(255),
@FECHA_NACIMIENTO DATE,
@SEXO CHAR(1),
@CURP VARCHAR(18),
@FK_ESTADO_CIVIL INT,
@CALLE VARCHAR(255),
@NUMERO_EXTERIOR INT,
@NUMERO_INTERIOR INT,
@FK_COLONIA INT,
@TELEFONO_CASA VARCHAR(255),
@TELEFONO_MOVIL VARCHAR(255),
@email VARCHAR(255),
-- Datos tabla CATR_ASPIRANTE
@PADRE_TUTOR VARCHAR(255),
@MADRE VARCHAR(255),
@FK_BACHILLERATO INT,
@ESPECIALIDAD NVARCHAR(255),
@PROMEDIO DECIMAL(3,1),
@NACIONALIDAD NVARCHAR(255),
@FK_CIUDAD INT,
@FK_CARRERA_1 INT,
@FK_CARRERA_2 INT,
@FK_PROPAGANDA_TECNOLOGICO INT,
@FK_UNIVERSIDAD INT,
@FK_CARRERA_UNIVERSIDAD INT,
@FK_DEPENDENCIA INT,
@TRABAJAS_Y_ESTUDIAS CHAR(1),
@AYUDA_INCAPACIDAD NVARCHAR(255)
AS  
    DECLARE @PREFICHA VARCHAR(10),
        @NUMERO_PREFICHA INT,
        @FK_PADRE int

    SET NOCOUNT ON


  
    IF ((SELECT COUNT(users.CURP) FROM CATR_ASPIRANTE LEFT JOIN users ON users.PK_USUARIO = CATR_ASPIRANTE.FK_PADRE WHERE users.CURP = @CURP)<>0)
        BEGIN
            IF ((SELECT COUNT(users.CURP) FROM CATR_ASPIRANTE LEFT JOIN users ON users.PK_USUARIO = CATR_ASPIRANTE.FK_PADRE WHERE FK_PERIODO = @periodo)<>0)
                BEGIN
                    SELECT 1 AS RESPUESTA; -- YA ESTA REGISTRADA ESA CURP EN ESTE PERIODO
                END
            
            ELSE IF ((SELECT COUNT(users.email) FROM users WHERE email = @email AND CURP <> @CURP)<>0)
                BEGIN
                    SELECT 2 AS RESPUESTA; -- YA ESTA REGISTRADO ESE CORREO A OTRO USUARIO
                END   
            
            ELSE IF(((SELECT ESTADO FROM users WHERE CURP=@CURP)=0) OR ((SELECT ESTADO FROM users WHERE CURP=@CURP)=5))
                BEGIN
                    IF ((SELECT COUNT(NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))<>0)
                        BEGIN
                            IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=1)
                                SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'000',NUMERO_PREFICHA+1),
                                    @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                                GROUP BY NUMERO_PREFICHA;
                            ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=2)
                                SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'00',NUMERO_PREFICHA+1),
                                    @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                                GROUP BY NUMERO_PREFICHA;
                            ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=3)
                                SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'0',NUMERO_PREFICHA+1),
                                    @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                                GROUP BY NUMERO_PREFICHA;
                            ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=4)
                                SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'',NUMERO_PREFICHA+1),
                                    @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                                GROUP BY NUMERO_PREFICHA;
                        END
                    ELSE
                            BEGIN
                                SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'000',1),
                                @NUMERO_PREFICHA = 1
                            END

                        UPDATE users
                        SET name=@name,PRIMER_APELLIDO=@PRIMER_APELLIDO,SEGUNDO_APELLIDO=@SEGUNDO_APELLIDO,FECHA_NACIMIENTO=@FECHA_NACIMIENTO,SEXO=@SEXO,CURP=@CURP,FK_ESTADO_CIVIL=@FK_ESTADO_CIVIL,CALLE=@CALLE,NUMERO_EXTERIOR=@NUMERO_EXTERIOR,NUMERO_INTERIOR=@NUMERO_INTERIOR,FK_COLONIA=@FK_COLONIA,TELEFONO_CASA=@TELEFONO_CASA,TELEFONO_MOVIL=@TELEFONO_MOVIL,email=@email
                        WHERE CURP= @CURP

                        SELECT @FK_PADRE = PK_USUARIO FROM users WHERE CURP = @CURP;

                        INSERT INTO CATR_ASPIRANTE (FK_PERIODO, PREFICHA, NUMERO_PREFICHA,PADRE_TUTOR,MADRE,FK_BACHILLERATO,ESPECIALIDAD,PROMEDIO,NACIONALIDAD,FK_CIUDAD,FK_CARRERA_1,FK_CARRERA_2,FK_PROPAGANDA_TECNOLOGICO, FK_UNIVERSIDAD, FK_CARRERA_UNIVERSIDAD,FK_DEPENDENCIA,TRABAJAS_Y_ESTUDIAS, AYUDA_INCAPACIDAD, AVISO_PRIVACIDAD,FK_PADRE,FK_ESTATUS)
                        VALUES (@periodo, @PREFICHA, @NUMERO_PREFICHA, @PADRE_TUTOR, @MADRE, @FK_BACHILLERATO, @ESPECIALIDAD, @PROMEDIO, @NACIONALIDAD, @FK_CIUDAD, @FK_CARRERA_1, @FK_CARRERA_2, @FK_PROPAGANDA_TECNOLOGICO, @FK_UNIVERSIDAD, @FK_CARRERA_UNIVERSIDAD, @FK_DEPENDENCIA, @TRABAJAS_Y_ESTUDIAS, @AYUDA_INCAPACIDAD
                    ,1,@FK_PADRE,1);


                    
                    SELECT 3 AS RESPUESTA; -- SE ACTUALIZO USUARIO Y SE REGISTRO LA PREFICHA

                END
            
        END
    ELSE IF ((SELECT COUNT(users.email) FROM users WHERE email = @email)<>0)
        BEGIN
            SELECT 4 AS RESPUESTA; -- YA ESTA REGISTRADO ESE CORREO A OTRO USUARIO
        END 
    ELSE
        BEGIN
            IF ((SELECT COUNT(NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))<>0)
                BEGIN
                    IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=1 AND (SELECT MAX (NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))<>9)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'000',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                    ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=1 AND (SELECT MAX (NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=9)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'00',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                    ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=2 AND (SELECT MAX (NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))<>99)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'00',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                    ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=2 AND (SELECT MAX (NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=99)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'0',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                    ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=3 AND (SELECT MAX (NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))<>999)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'0',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                    ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=3 AND (SELECT MAX (NUMERO_PREFICHA) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=999)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                    ELSE IF ((SELECT LEN ( MAX (NUMERO_PREFICHA)) FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo))=4)
                        SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'',NUMERO_PREFICHA+1),
                            @NUMERO_PREFICHA = MAX(NUMERO_PREFICHA)+1 FROM CATR_ASPIRANTE WHERE FK_PERIODO = (@periodo)
                        GROUP BY NUMERO_PREFICHA;
                END
            ELSE
                BEGIN
                    SELECT @PREFICHA = CONCAT('TL',FORMAT(GETDATE(),'yy'),'000',1),
                    @NUMERO_PREFICHA = 1
                END

            INSERT INTO users (name, PRIMER_APELLIDO, SEGUNDO_APELLIDO,FECHA_NACIMIENTO,SEXO,CURP,FK_ESTADO_CIVIL,CALLE,NUMERO_EXTERIOR,NUMERO_INTERIOR,FK_COLONIA,TELEFONO_CASA,TELEFONO_MOVIL,email, ESTADO) 
            VALUES (@name, @PRIMER_APELLIDO, @SEGUNDO_APELLIDO, @FECHA_NACIMIENTO, @SEXO, @CURP, @FK_ESTADO_CIVIL, @CALLE, @NUMERO_EXTERIOR, @NUMERO_INTERIOR, @FK_COLONIA, @TELEFONO_CASA, @TELEFONO_MOVIL, @email, 0);

            SELECT @FK_PADRE = PK_USUARIO FROM users WHERE CURP = @CURP;

            INSERT INTO CATR_ASPIRANTE (FK_PERIODO, PREFICHA, NUMERO_PREFICHA,PADRE_TUTOR,MADRE,FK_BACHILLERATO,ESPECIALIDAD,PROMEDIO,NACIONALIDAD,FK_CIUDAD,FK_CARRERA_1,FK_CARRERA_2,FK_PROPAGANDA_TECNOLOGICO, FK_UNIVERSIDAD, FK_CARRERA_UNIVERSIDAD,FK_DEPENDENCIA,TRABAJAS_Y_ESTUDIAS, AYUDA_INCAPACIDAD, AVISO_PRIVACIDAD,FK_PADRE,FK_ESTATUS)
            VALUES (@periodo, @PREFICHA, @NUMERO_PREFICHA, @PADRE_TUTOR, @MADRE, @FK_BACHILLERATO, @ESPECIALIDAD, @PROMEDIO, @NACIONALIDAD, @FK_CIUDAD, @FK_CARRERA_1, @FK_CARRERA_2, @FK_PROPAGANDA_TECNOLOGICO, @FK_UNIVERSIDAD, @FK_CARRERA_UNIVERSIDAD, @FK_DEPENDENCIA, @TRABAJAS_Y_ESTUDIAS, @AYUDA_INCAPACIDAD
        ,1,@FK_PADRE,1);

            INSERT INTO PER_TR_ROL_USUARIO (FK_ROL,FK_USUARIO) VALUES ((SELECT PK_ROL FROM PER_CATR_ROL WHERE NOMBRE = 'Aspirante'),@FK_PADRE);
                    
                    SELECT 5 AS RESPUESTA; -- SE REGISTRO CORRECTAMENTE
        END            
        SET NOCOUNT OFF
GO


CREATE PROCEDURE INSERTAR_INCAPACIDAD
@CURP VARCHAR(18),
@FK_INCAPACIDAD INT
AS  
    SET NOCOUNT ON
    DECLARE @FK_PADRE INT,
            @FK_ASPIRANTE INT

    SELECT @FK_PADRE = PK_USUARIO FROM users WHERE CURP = @CURP;

    SELECT @FK_ASPIRANTE = MAX(PK_ASPIRANTE) FROM CATR_ASPIRANTE WHERE FK_PADRE = @FK_PADRE;

    INSERT INTO TR_INCAPACIDAD_ASPIRANTE(FK_ASPIRANTE, FK_INCAPACIDAD)
    VALUES (@FK_ASPIRANTE, @FK_INCAPACIDAD); 
    SELECT 1 AS RESPUESTA; -- SE REGISTRO CORRECTAMENTE
        SET NOCOUNT OFF
GO

/*********************  FIN MODIFICACIONES (RANGO DE FECHA O DÍA) (EJEMPLO LUNES 8 DE ABRIL) *********************************/


-- --------------------------------------------------------------------------------------------------------------------------------