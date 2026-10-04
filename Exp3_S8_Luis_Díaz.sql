

/*

    PARTE 1:

*/

DROP TABLE DETALLE_SERVICIO CASCADE CONSTRAINTS;
DROP TABLE MANTENCION CASCADE CONSTRAINTS;
DROP TABLE AUTOMOVIL CASCADE CONSTRAINTS;
DROP TABLE PREMIUM CASCADE CONSTRAINTS;
DROP TABLE ESTANDAR CASCADE CONSTRAINTS;
DROP TABLE MECANICO CASCADE CONSTRAINTS;
DROP TABLE MODELO CASCADE CONSTRAINTS;
DROP TABLE MARCA CASCADE CONSTRAINTS;
DROP TABLE TIPO_AUTOMOVIL CASCADE CONSTRAINTS;
DROP TABLE SERVICIO CASCADE CONSTRAINTS;
DROP TABLE SUCURSAL CASCADE CONSTRAINTS;
DROP TABLE CIUDAD CASCADE CONSTRAINTS;
DROP TABLE PAIS CASCADE CONSTRAINTS;
DROP TABLE CLIENTE CASCADE CONSTRAINTS;

DROP SEQUENCE seq_servicio;
DROP SEQUENCE seq_ciudad;


-- -----------------------------------------------


CREATE TABLE PAIS(

    id_pais NUMBER(3)
        GENERATED ALWAYS AS IDENTITY (START WITH 9 INCREMENT BY 3)
        CONSTRAINT t_pais_c_idpais_nnull NOT NULL,

    nom_pais VARCHAR2(30 CHAR)
        CONSTRAINT t_pais_c_nompais_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT pais_pk
        PRIMARY KEY(id_pais)

);



CREATE TABLE CIUDAD(

    id_ciudad NUMBER(3)
        CONSTRAINT t_ciu_c_idciu_nnull NOT NULL,

    nom_ciudad VARCHAR2(30 CHAR)
        CONSTRAINT t_ciu_c_nomciu_nnull NOT NULL,

    cod_pais NUMBER(3)
        CONSTRAINT t_ciu_cf_codpais_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT ciudad_pk
        PRIMARY KEY(id_ciudad),

    CONSTRAINT ciudad_fk_pais
        FOREIGN KEY(cod_pais)
        REFERENCES PAIS(id_pais)

);



CREATE TABLE SUCURSAL(

    id_sucursal CHAR(3 CHAR)
        CONSTRAINT t_suc_c_idsuc_nnull NOT NULL,

    nom_sucursal VARCHAR2(20 CHAR)
        CONSTRAINT t_suc_c_nomsuc_nnull NOT NULL,

    calle VARCHAR2(20 CHAR)
        CONSTRAINT t_suc_c_calle_nnull NOT NULL,

    num_calle NUMBER(4)
        CONSTRAINT t_suc_c_numcalle_nnull NOT NULL,

    cod_ciudad NUMBER(3)
        CONSTRAINT t_suc_cf_codciu_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT sucursal_pk
        PRIMARY KEY(id_sucursal),

    CONSTRAINT sucursal_fk_ciudad
        FOREIGN KEY(cod_ciudad)
        REFERENCES CIUDAD(id_ciudad)

);



CREATE TABLE SERVICIO(

    id_servicio NUMBER(3)
        CONSTRAINT t_ser_c_idser_nnull NOT NULL,

    descripcion VARCHAR2(100 CHAR)
        CONSTRAINT t_ser_c_desc_nnull NOT NULL,

    costo NUMBER(7)
        CONSTRAINT t_ser_c_costo_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT servicio_pk
        PRIMARY KEY(id_servicio)

);


CREATE TABLE MARCA(

    id_marca NUMBER(2)
        CONSTRAINT t_mar_c_idmar_nnull NOT NULL,

    descripcion VARCHAR2(20 CHAR)
        CONSTRAINT t_mar_c_desc_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT marca_pk
        PRIMARY KEY(id_marca)

);



CREATE TABLE MODELO(

    id_modelo NUMBER(5)
        CONSTRAINT t_mod_c_idmod_nnull NOT NULL,

    marca_id NUMBER(2)
        CONSTRAINT t_mod_cf_marid_nnull NOT NULL,

    descripcion VARCHAR2(20 CHAR)
        CONSTRAINT t_mod_c_desc_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT modelo_pk
        PRIMARY KEY(id_modelo, marca_id),

    CONSTRAINT modelo_fk_marca
        FOREIGN KEY(marca_id)
        REFERENCES MARCA(id_marca)

);



CREATE TABLE TIPO_AUTOMOVIL(

    id_tipo CHAR(3 CHAR)
        CONSTRAINT t_taut_c_idtipo_nnull NOT NULL,

    descripcion VARCHAR2(20 CHAR)
        CONSTRAINT t_taut_c_desc_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT tipo_automovil_pk
        PRIMARY KEY(id_tipo)

);




CREATE TABLE CLIENTE(

    rut NUMBER(8)
        CONSTRAINT t_cli_c_rut_nnull NOT NULL,

    dv CHAR(1 CHAR)
        CONSTRAINT t_cli_c_dv_nnull NOT NULL,

    pnombre VARCHAR2(20 CHAR)
        CONSTRAINT t_cli_c_pnom_nnull NOT NULL,

    snombre VARCHAR2(20 CHAR),

    apaterno VARCHAR2(20 CHAR)
        CONSTRAINT t_cli_c_apat_nnull NOT NULL,

    amaterno VARCHAR2(20 CHAR)
        CONSTRAINT t_cli_c_amat_nnull NOT NULL,

    telefono VARCHAR2(12 CHAR),

    email VARCHAR2(40 CHAR),

    tipo_cli CHAR(1 CHAR)
        CONSTRAINT t_cli_c_tipocli_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT cliente_pk
        PRIMARY KEY(rut)

);



CREATE TABLE ESTANDAR(

    cl_rut NUMBER(8)
        CONSTRAINT t_est_cf_clrut_nnull NOT NULL,

    puntaje_fidelidad NUMBER(10)
        CONSTRAINT t_est_c_puntaje_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT estandar_pk
        PRIMARY KEY(cl_rut),

    CONSTRAINT estandar_fk_cliente
        FOREIGN KEY(cl_rut)
        REFERENCES CLIENTE(rut)

);




CREATE TABLE PREMIUM(

    cl_rut NUMBER(8)
        CONSTRAINT t_pre_cf_clrut_nnull NOT NULL,

    pesos_clientes NUMBER(10)
        CONSTRAINT t_pre_c_pesos_nnull NOT NULL,

    monto_credito NUMBER(10),

    -- Restricciones a nivel de tabla
    CONSTRAINT premium_pk
        PRIMARY KEY(cl_rut),

    CONSTRAINT premium_fk_cliente
        FOREIGN KEY(cl_rut)
        REFERENCES CLIENTE(rut)

);




CREATE TABLE MECANICO(

    cod_mecanico NUMBER(5)
        GENERATED ALWAYS AS IDENTITY (START WITH 460 INCREMENT BY 7)
        CONSTRAINT t_mec_c_codmec_nnull NOT NULL,

    pnombre VARCHAR2(20 CHAR)
        CONSTRAINT t_mec_c_pnom_nnull NOT NULL,

    snombre VARCHAR2(20 CHAR)
        CONSTRAINT t_mec_c_snom_nnull NOT NULL,

    apaterno VARCHAR2(20 CHAR)
        CONSTRAINT t_mec_c_apat_nnull NOT NULL,

    amaterno VARCHAR2(20 CHAR)
        CONSTRAINT t_mec_c_amat_nnull NOT NULL,

    bono_jefatura NUMBER(10),

    sueldo NUMBER(10)
        CONSTRAINT t_mec_c_sueldo_nnull NOT NULL,

    monto_impuestos NUMBER(10)
        CONSTRAINT t_mec_c_impuesto_nnull NOT NULL,

    cod_supervisor NUMBER(5),

    -- Restricciones a nivel de tabla
    CONSTRAINT mecanico_pk
        PRIMARY KEY(cod_mecanico),

    CONSTRAINT mecanico_fk_mecanico
        FOREIGN KEY(cod_supervisor)
        REFERENCES MECANICO(cod_mecanico)

);



CREATE TABLE AUTOMOVIL(

    patente CHAR(8 CHAR)
        CONSTRAINT t_aut_c_patente_nnull NOT NULL,

    annio NUMBER(4)
        CONSTRAINT t_aut_c_annio_nnull NOT NULL,

    cant_puertas NUMBER(1)
        CONSTRAINT t_aut_c_puertas_nnull NOT NULL,

    km NUMBER(6)
        CONSTRAINT t_aut_c_km_nnull NOT NULL,

    color VARCHAR2(30 CHAR)
        CONSTRAINT t_aut_c_color_nnull NOT NULL,

    cod_tipo_auto CHAR(3 CHAR)
        CONSTRAINT t_aut_cf_tipo_nnull NOT NULL,

    cod_modelo NUMBER(5)
        CONSTRAINT t_aut_cf_modelo_nnull NOT NULL,

    cod_marca NUMBER(2)
        CONSTRAINT t_aut_cf_marca_nnull NOT NULL,

    cl_rut NUMBER(8)
        CONSTRAINT t_aut_cf_clrut_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT automovil_pk
        PRIMARY KEY(patente),

    CONSTRAINT automovil_fk_cliente
        FOREIGN KEY(cl_rut)
        REFERENCES CLIENTE(rut),

    CONSTRAINT automovil_fk_modelo
        FOREIGN KEY(cod_modelo, cod_marca)
        REFERENCES MODELO(id_modelo, marca_id),

    CONSTRAINT automovil_fk_tipo
        FOREIGN KEY(cod_tipo_auto)
        REFERENCES TIPO_AUTOMOVIL(id_tipo)

);



CREATE TABLE MANTENCION(

    num_mantencion NUMBER(4)
        CONSTRAINT t_man_c_numman_nnull NOT NULL,

    cod_sucursal CHAR(3 CHAR)
        CONSTRAINT t_man_cf_codsuc_nnull NOT NULL,

    fecha_ingreso DATE
        CONSTRAINT t_man_c_fing_nnull NOT NULL,

    fecha_salida DATE,

    patente_auto CHAR(8 CHAR),

    cod_mecanico NUMBER(5)
        CONSTRAINT t_man_cf_codmec_nnull NOT NULL,

    costo_total NUMBER(7)
        CONSTRAINT t_man_c_costotot_nnull NOT NULL,

    estado VARCHAR2(15 CHAR),

    -- Restricciones a nivel de tabla
    CONSTRAINT mantencion_pk
        PRIMARY KEY(num_mantencion),

    CONSTRAINT mant_fk_automovil
        FOREIGN KEY(patente_auto)
        REFERENCES AUTOMOVIL(patente),

    CONSTRAINT mant_fk_mecanico
        FOREIGN KEY(cod_mecanico)
        REFERENCES MECANICO(cod_mecanico),

    CONSTRAINT mant_fk_sucursal
        FOREIGN KEY(cod_sucursal)
        REFERENCES SUCURSAL(id_sucursal)

);



CREATE TABLE DETALLE_SERVICIO(

    mantencion_num NUMBER(4)
        CONSTRAINT t_dser_cf_mantnum_nnull NOT NULL,

    cod_servicio NUMBER(3)
        CONSTRAINT t_dser_cf_codser_nnull NOT NULL,

    descuento_serv NUMBER(4,3)
        CONSTRAINT t_dser_c_descser_nnull NOT NULL,

    cantidad NUMBER(3)
        CONSTRAINT t_dser_c_cantidad_nnull NOT NULL,

    -- Restricciones a nivel de tabla
    CONSTRAINT detalle_servicio_pk
        PRIMARY KEY(mantencion_num, cod_servicio),

    CONSTRAINT det_serv_fk_mantencion
        FOREIGN KEY(mantencion_num)
        REFERENCES MANTENCION(num_mantencion),

    CONSTRAINT det_serv_fk_servicio
        FOREIGN KEY(cod_servicio)
        REFERENCES SERVICIO(id_servicio)

);

/*

    PARTE 2:

*/


ALTER TABLE MANTENCION DROP (costo_total);

ALTER TABLE DETALLE_SERVICIO DROP CONSTRAINT det_serv_fk_mantencion;

ALTER TABLE MANTENCION DROP CONSTRAINT mantencion_pk;

ALTER TABLE MANTENCION ADD (
    CONSTRAINT mantencion_pk
        PRIMARY KEY(num_mantencion, cod_sucursal)
);

ALTER TABLE DETALLE_SERVICIO ADD (
    cod_sucursal CHAR(3 CHAR)
        CONSTRAINT t_dser_cf_codsuc_nnull NOT NULL
);

ALTER TABLE DETALLE_SERVICIO DROP CONSTRAINT detalle_servicio_pk;

    

ALTER TABLE DETALLE_SERVICIO ADD(
    CONSTRAINT detalle_servicio_pk
        PRIMARY KEY(mantencion_num, cod_sucursal, cod_servicio)
);

ALTER TABLE DETALLE_SERVICIO ADD (
        CONSTRAINT det_serv_fk_mantencion
            FOREIGN KEY(mantencion_num, cod_sucursal)
            REFERENCES MANTENCION(num_mantencion, cod_sucursal)
);


ALTER TABLE CLIENTE MODIFY (
    email 
        CONSTRAINT t_cli_c_email_un UNIQUE,
    dv
        CONSTRAINT t_cli_c_dv_ck
            CHECK (dv IN ('0','1' ,'2','3','4','5','6','7','8','9','K'))
        
);

ALTER TABLE MECANICO MODIFY(
    sueldo
        CONSTRAINT t_mec_c_sueldo_ck
            CHECK (sueldo >= 510000)
);

ALTER TABLE MANTENCION MODIFY(
    estado VARCHAR2 (9 CHAR) 
        CONSTRAINT t_man_c_est_ck
            CHECK (estado IN ('Reserva', 'Ingresado', 'Entregado', 'Anulado'))
);


/*

    PARTE 3:

*/

CREATE SEQUENCE seq_servicio
    START WITH 400
    INCREMENT BY 2;
    
CREATE SEQUENCE seq_ciudad
    START WITH 165
    INCREMENT BY 5;    
    
-- Inserto a PAIS ------------------- 
INSERT INTO PAIS (nom_pais)
    VALUES ('Chile');

INSERT INTO PAIS (nom_pais)
    VALUES ('Peru');

INSERT INTO PAIS (nom_pais)
    VALUES ('Colombia');

-- Inserto a CIUDAD ------------------- 
INSERT INTO CIUDAD(id_ciudad,nom_ciudad,cod_pais)
    VALUES (seq_ciudad.NEXTVAL, 'Santiago', 9);
    
INSERT INTO CIUDAD(id_ciudad,nom_ciudad,cod_pais)
    VALUES (seq_ciudad.NEXTVAL, 'Lima', 12);

INSERT INTO CIUDAD(id_ciudad,nom_ciudad,cod_pais)
    VALUES (seq_ciudad.NEXTVAL, 'Bogota', 15);
    
    
-- Inserto a SUCURSAL ------------------- 
INSERT INTO SUCURSAL(id_sucursal,nom_sucursal,calle,num_calle,cod_ciudad)
    VALUES ('S01', 'Providencia','Av. A. Varas', 234, 165);
    
INSERT INTO SUCURSAL(id_sucursal,nom_sucursal,calle,num_calle,cod_ciudad)
    VALUES ('S02', 'Las 4 esquinas','Av. Latina', 669, 170);

INSERT INTO SUCURSAL(id_sucursal,nom_sucursal,calle,num_calle,cod_ciudad)
    VALUES ('S03', 'El Cafetero','Av. El Faro', 900, 175);
    
-- Inserto a MECANICO ------------------- 
INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Jorge', 'Pablo','Soto','Sierpe', 5400000, 2759000,223580,NULL);
    
INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Pedro', 'Jose', 'Manriquez', 'Corral', NULL, 759000, 23980, NULL);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Sandra', 'Josefa', 'Letelier', 'S.', 0, 659000, 22358, 460);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Felipe', 'M.', 'Vidal', 'A.', NULL, 759000, 23580, 460);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Jose', 'Miguel', 'Troncoso', 'B.', NULL, 659000, 44580, 474);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Juan', 'Pablo', 'Sánchez', 'R.', NULL, 859000, 23380, 474);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Carlos', 'Felipe', 'Soto', 'J.', 0, 597000, 23580, 474);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Alberto', 'P.', 'Cerda', 'Ramírez', NULL, 559000, 22380, 460);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Alejandra', 'Gabriela', 'Infanti', 'R.', NULL, 659000, 22380, 460);

INSERT INTO MECANICO(pnombre,snombre,apaterno,amaterno,bono_jefatura,sueldo,monto_impuestos,cod_supervisor)
    VALUES ('Roberto', 'Patricio', 'Gutierrez', 'Sosa', NULL, 859000, 22380, 460);

-- Inserto a SERVICIO ------------------- 
INSERT INTO SERVICIO(id_servicio, descripcion,costo)
    VALUES (seq_servicio.NEXTVAL,'Cambio Luces', 45000);
    
INSERT INTO SERVICIO(id_servicio,descripcion,costo)
    VALUES (seq_servicio.NEXTVAL,'Desabolladura', 67000);

INSERT INTO SERVICIO(id_servicio,descripcion,costo)
    VALUES (seq_servicio.NEXTVAL,'Revisión Frenos', 30000);
    
INSERT INTO SERVICIO(id_servicio,descripcion,costo)
    VALUES (seq_servicio.NEXTVAL,'Cambio Puerta Trasera', 50000);
    
-- Inserto a MANTENCION ------------------- 
INSERT INTO MANTENCION(num_mantencion,cod_sucursal,fecha_ingreso,fecha_salida,patente_auto,cod_mecanico,estado)
    VALUES (101, 'S01',TO_DATE('12-04-2023','DD-MM-YYYY'), NULL, NULL, 481, 'Reserva');
    
INSERT INTO MANTENCION(num_mantencion,cod_sucursal,fecha_ingreso,fecha_salida,patente_auto,cod_mecanico,estado)
    VALUES (102, 'S02', TO_DATE('21-02-2023','DD-MM-YYYY'), TO_DATE('21-02-2023','DD-MM-YYYY'), NULL, 502, 'Entregado');

INSERT INTO MANTENCION(num_mantencion,cod_sucursal,fecha_ingreso,fecha_salida,patente_auto,cod_mecanico,estado)
    VALUES (103, 'S02', TO_DATE('09-10-2023','DD-MM-YYYY'), NULL, NULL, 502, 'Anulado');

INSERT INTO MANTENCION(num_mantencion,cod_sucursal,fecha_ingreso,fecha_salida,patente_auto,cod_mecanico,estado)
    VALUES (104, 'S03', TO_DATE('11-08-2023','DD-MM-YYYY'), TO_DATE('18-08-2023','DD-MM-YYYY'), NULL, 509, 'Entregado');

INSERT INTO MANTENCION(num_mantencion,cod_sucursal,fecha_ingreso,fecha_salida,patente_auto,cod_mecanico,estado)
    VALUES (105, 'S03', TO_DATE('03-12-2023','DD-MM-YYYY'), NULL, NULL, 509, 'Ingresado'); 
   
   
COMMIT; 

/*

    PARTE 4:

*/
/*
    INFORME: 1
*/

SELECT cod_mecanico AS "ID MECANICO",
        pnombre || ' ' || apaterno AS "NOMBRE MECANICO",
        sueldo AS "SALARIO",
        monto_impuestos AS "IMPUESTO ACTUAL",
        monto_impuestos * 0.8 AS "IMPUESTO REBAJADO",
        sueldo - (monto_impuestos * 0.8) AS "SUELDO CON REBAJA IMPUESTOS"
FROM MECANICO 
WHERE bono_jefatura IS NULL
AND monto_impuestos < 40000
ORDER BY monto_impuestos DESC, apaterno ASC;


/*
    INFORME: 2
*/
SELECT cod_mecanico AS "IDENTIFICADOR",
        pnombre || ' ' || snombre || ' ' || apaterno  AS "MECANICO",
        sueldo AS "SALARIO ACTUAL",
        sueldo * 0.05  AS "AJUSTE",
        sueldo + (sueldo * 0.05) AS "SUELDO_REAJUSTADO"
FROM MECANICO
WHERE sueldo BETWEEN 600000 AND 900000
   OR cod_supervisor IS NULL
ORDER BY "SALARIO ACTUAL" ASC,"MECANICO" DESC;

