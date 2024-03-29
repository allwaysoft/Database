/* SNAPSHOT CON SINONIMO PUBLICO*/
SET DEFINE OFF;
DROP PUBLIC SYNONYM IFZ_ENT_CLIENTES;


DROP MATERIALIZED VIEW GEM_IFZ.IFZ_ENT_CLIENTES_SNAP;

CREATE MATERIALIZED VIEW GEM_IFZ.IFZ_ENT_CLIENTES_SNAP 
TABLESPACE GEMDATSS
NOCACHE
LOGGING
NOPARALLEL
BUILD IMMEDIATE
REFRESH FORCE
START WITH TO_DATE('29-Nov-2007 07:32:27','dd-mon-yyyy hh24:mi:ss')
NEXT SYSDATE+30/1440 
WITH PRIMARY KEY
AS 
SELECT * FROM IFZ_ENT_CLIENTES;

COMMENT ON TABLE GEM_IFZ.IFZ_ENT_CLIENTES_SNAP IS 'snapshot table for snapshot GEM_IFZ.IFZ_ENT_CLIENTES_SNAP';

CREATE INDEX GEM_IFZ.IFZ_ENT_CLIENTES_SNAP_IND ON GEM_IFZ.IFZ_ENT_CLIENTES_SNAP
(ENT_CODIGO)
LOGGING
TABLESPACE GEMDATSS
NOPARALLEL;

GRANT REFERENCES, ON COMMIT REFRESH ON  GEM_IFZ.IFZ_ENT_CLIENTES_SNAP TO GEMINIS WITH GRANT OPTION;

GRANT SELECT ON  GEM_IFZ.IFZ_ENT_CLIENTES_SNAP TO GEM_GRL WITH GRANT OPTION;

GRANT ALTER, DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH ON  GEM_IFZ.IFZ_ENT_CLIENTES_SNAP TO RGEM_GRL_ALL;

GRANT ALTER, DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH ON  GEM_IFZ.IFZ_ENT_CLIENTES_SNAP TO RGEM_TV_ALL;

CREATE PUBLIC SYNONYM IFZ_ENT_CLIENTES FOR GEM_IFZ.IFZ_ENT_CLIENTES_SNAP;


/* VISTA DE LOS SNAPSHOT */

CREATE OR REPLACE VIEW LISTA_SNAP
(RV_DOMAIN, RV_MEANING, LAST_REFRESH_DATE, MVIEW_NAME, DETALLE)
AS 
SELECT A.RV_DOMAIN,A.RV_MEANING,B.LAST_REFRESH_DATE,B.MVIEW_NAME,A.RV_HIGH_VALUE FROM CG_REF_CODES A, ALL_MVIEWS B 
 WHERE A.RV_DOMAIN='SNAPSHOT'AND B.MVIEW_NAME=A.RV_LOW_VALUE
/


CREATE PUBLIC SYNONYM LISTA_SNAP FOR LISTA_SNAP
/


GRANT SELECT ON  LISTA_SNAP TO GEMINIS WITH GRANT OPTION
/

GRANT SELECT ON  LISTA_SNAP TO RGEM_GRL_ALL
/

GRANT SELECT ON  LISTA_SNAP TO RGEM_TV_ALL
/

/* PROCEDURE REFRESCA SNAP*/

CREATE OR REPLACE PROCEDURE         GEM_IFZ_REFRESCA_SNAP (NOM_SNAP IN VARCHAR2) IS
BEGIN
  DBMS_SNAPSHOT.REFRESH(
    LIST                 => 'GEM_IFZ.'||NOM_SNAP||''
   ,PUSH_DEFERRED_RPC    => TRUE
   ,REFRESH_AFTER_ERRORS => FALSE
   ,PURGE_OPTION         => 1
   ,PARALLELISM          => 0
   ,ATOMIC_REFRESH       => TRUE);
END;
/


CREATE PUBLIC SYNONYM GEM_IFZ_REFRESCA_SNAP FOR GEM_IFZ_REFRESCA_SNAP;


GRANT EXECUTE, DEBUG ON  GEM_IFZ_REFRESCA_SNAP TO GEM_GRL WITH GRANT OPTION;

GRANT EXECUTE, DEBUG ON  GEM_IFZ_REFRESCA_SNAP TO RGEM_GRL_ALL;

GRANT EXECUTE, DEBUG ON  GEM_IFZ_REFRESCA_SNAP TO RGEM_TV_ALL;



/*CON EL USUARIO GEM_GRL */

GRANT SELECT ON CG_REF_CODES TO GEM_IFZ WITH GRANT OPTION;

INSERT INTO M000_ITEMS ( SIS_CODIGO, ITM_CODIGO, ITM_DESCRIPCION, ITM_TIPO, ITM_LEYENDA,
ITM_GRAFICO, ITM_GRAF_TIPO, USR_NOMBRE_ALTA, F_ALTA, USR_NOMBRE_MODI, F_MODI, ITM_MCA_CONFIG,
ITM_CODIGO_NUMERICO, ITM_MCA_LNG ) VALUES ( 
'PUP', 'PPACTVIS', 'Actualizar Vistas', 'C', 'Actualiza Vistas', NULL, 'GIF', 'GEM_GRL'
,  TO_Date( '11/28/2007 09:10:04 AM', 'MM/DD/YYYY HH:MI:SS AM'), NULL, NULL, 'N', 4505
, 'N'); 
COMMIT;
INSERT INTO M000_ITEM_ITEMS ( ITM_CODIGO, SIS_CODIGO, IXI_ORDEN, ITM_CODIGO_DEPENDE,
SIS_CODIGO_DEPENDE, USR_NOMBRE_ALTA, F_ALTA, USR_NOMBRE_MODI, F_MODI, ITM_CODIGO_NUMERICO,
ITM_CODIGO_NUMERICO_DEPENDE ) VALUES ( 
'PPACTVIS', 'PUP', 2, 'CFGTV01', 'CFGTV', 'USER',  TO_Date( '11/28/2007 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, NULL, NULL, 4505, 4137); 
COMMIT;
INSERT INTO M000_ITEM_COMANDOS ( ITM_CODIGO, SIS_CODIGO, IXC_ORDEN, IXC_TIPO, IXC_COMANDO,
IXC_PARAM_NOMBRE, IXC_PARAM_VALOR, USR_NOMBRE_ALTA, F_ALTA, USR_NOMBRE_MODI, F_MODI,
IXC_OBSERVACION ) VALUES ( 
'PPACTVIS', 'PUP', 1, 'F', 'PPACTVIS', NULL, NULL, 'USER',  TO_Date( '11/28/2007 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, NULL, NULL, NULL); 
COMMIT;

INSERT INTO M000_FUNCION_ITEMS ( FXN_CODIGO, ITM_CODIGO, SIS_CODIGO, USR_NOMBRE_ALTA, F_ALTA,
USR_NOMBRE_MODI, F_MODI ) VALUES ( 
'ADSI', 'PPACTVIS', 'PUP', 'USER',  TO_Date( '11/28/2007 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
, NULL, NULL); 
COMMIT;


/* INSERT EN LA TABLA CG_REF_CODES CON DOMINIO SNAPSHOT*/

INSERT INTO CG_REF_CODES ( RV_LOW_VALUE, RV_HIGH_VALUE, RV_ABBREVIATION, RV_DOMAIN, RV_MEANING,
RV_TYPE ) VALUES ( 
'IFZ_ENT_CLIENTES_SNAP', 'Clientes', 'SNAP', 'SNAPSHOT', 'IFZ_ENT_CLIENTES', NULL);
COMMIT;