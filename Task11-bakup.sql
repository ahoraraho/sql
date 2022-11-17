USE ALMACEN

--crear usuario loguin y cambiar la contraceña en el proximo reinicio

create login alan with password = '1234' must_change, check_expiration = on

--verificar el login creado 

select * from master.sys.sql_logins

--modificar contraseña login

alter login alan with password = '123456'

--desactivar login

alter login alan disable 

--GESTIONAR USUARIOS

--usar la base de datos para el ususario a crear

use ALMACEN

--crear usuario

create user alan for login alan

--crear login y susario consicutivamente

create login iam with password = '321'
create user iam for login iam

--verificar que el y los usuarios se crearon correctamente

select name Nombre, TYPE_DESC Tipo
from sys.database_principals
where type_desc= 'SQL_USER'

--modificar el login de usuario

ALTER user iam with login = sa

--eliminar usuarios

drop user iam

/*--------------------------------------------------------------------------------------*/
/**---------------------------BACK UP DE LA BASE DE DATOS EN NUESTRO DISCO LOCAL--------*/
/*--------------------------------------------------------------------------------------*/


/*A.- Realice las siguientes actividades a través de las instrucciones TRANSACT-SQL para la base de
datos ALMACEN creada en trabajo practico anterior.*/

--a) Iniciar un nuevo query. Crear un dispositivo de copia de seguridad para la base de datos ALMACEN:

sp_addumpdevice 'disk','ALMACEN_backup','D:\ALMACEN.bak' 

--b) Realice una copia de seguridad completa de la base de datos ALMACEN, inicializando el dispositivo:

backup database ALMACEN to ALMACEN_backup with init 

--c) Ingrese un nuevo registro para la tabla EXISTENCIAS.

use ALMACEN
insert into Existencias values('A091','Articulo rrr','Kilos',274,80)

--d) Realice la primera copia de seguridad diferencial de la base de datos ALMACEN, en el dispositivo

backup database ALMACEN to ALMACEN_backup with differential, noinit

--d) Ingrese un nuevo registro para la tabla EXISTENCIAS.

insert into Existencias values('A105','Articulo loi','Litros',91,164)

--e) Realice la segunda copia de seguridad diferencial:

backup database ALMACEN to ALMACEN_backup with differential, noinit

--g) Ingrese un último registro a la tabla EXISTENCIAS. Realice una tercera copia de seguridad diferencial.

insert into Existencias values('A587','Articulo eqw','Metros',450,200)
backup database ALMACEN to ALMACEN_backup with differential, noinit

--h) Genere un segundo dispositivo para realizar la copia de seguridad del registro de transacciones:

sp_addumpdevice 'disk','ALMACEN_log','D:\ALMACEN_Log.bak' 

--i) Realice la copia de seguridad del registro de transacciones:

backup database ALMACEN to ALMACEN_log with init
backup log ALMACEN to ALMACEN_log with noinit

USE master;  
ALTER DATABASE ALMACEN SET RECOVERY FULL;

--j) Verifique la base de datos y archivo de transacciones que se respaldaron en el dispositivo de copia de
--seguridad ALMACEN_backup:

restore filelistonly from ALMACEN_backup 
restore verifyonly from ALMACEN_backup

--k) Restaure la primera copia de seguridad diferencial:

restore database ALMACEN from ALMACEN_backup with norecovery,replace 
restore database ALMACEN from ALMACEN_backup with file=1, norecovery


use ALMACEN
--l) Verifique el contenido de la tabla EXISTENCIAS.

select * from Existencias

--m) Restaure la segunda copia de seguridad diferencial

restore database ALMACEN from ALMACEN_backup with norecovery,replace
restore database ALMACEN from ALMACEN_backup with file=2, norecovery

--n) Verifique el contenido de la tabla EXISTENCIAS.

select * from Existencias

--o) Restaure la tercera copia de seguridad diferencial

restore database ALMACEN from ALMACEN_backup with norecovery,replace
restore database ALMACEN from ALMACEN_backup with file=3, norecovery--3

--p) Verifique el contenido de la tabla EXISTENCIAS.

select * from Existencias

--q) Restaure la base de datos completa y el registro de transacciones:

restore database ALMACEN from ALMACEN_log with norecovery, replace
restore log ALMACEN from ALMACEN_log with recovery

--r) Verifique el contenido de la tabla EXISTENCIAS

select * from Existencias

-- CONSULTAS EXTRA

sp_helpdevice
go
sp_dropdevice 'ALMACEN_backup'
go
sp_dropdevice 'ALMACEN_log'
go
sp_dropdevice 'ALMACEN_bu'


RESTORE DATABASE ALMACEN FROM DISK = 'D:\ALMACEN.bak' WITH NORECOVERY
RESTORE DATABASE ALMACEN FROM DISK = 'D:\ALMACEN.bak' WITH RECOVERY
