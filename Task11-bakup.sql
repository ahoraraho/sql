
go
sp_addumpdevice 'disk','Almacen_backup','D:\Almacen.bak' --crear disp de copia de seguridad
go
backup database Almacen to Almacen_backup with init -- copia completa inicializando
go
use Almacen
insert into Existencias values('A090','Articulo sss','Kilos',274,80)
backup database Almacen to Almacen_backup with differential, noinit--1
insert into Existencias values('A005','Articulo ttt','Litros',91,164) --copias de seguridad diferencial
backup database Almacen to Almacen_backup with differential, noinit--2
insert into Existencias values('A830','Articulo ggg','Metros',450,200)
backup database Almacen to Almacen_backup with differential, noinit--3
go
sp_addumpdevice 'disk','Almacen_log','D:\Almacen_Log.bak'  --copia de registro de transacciones
backup database Almacen to Almacen_log with init
backup log Almacen to Almacen_log with noinit

USE master;  
ALTER DATABASE Almacen SET RECOVERY FULL;

restore filelistonly from Almacen_backup --verificar base de datos y archivo de transacciones
restore verifyonly from Almacen_backup

restore database Almacen from Almacen_backup with norecovery,replace --restaurar copias de seguridad
restore database Almacen from Almacen_backup with file=2, norecovery--1
use Almacen
select * from Existencias
restore database Almacen from Almacen_backup with norecovery,replace
restore database Almacen from Almacen_backup with file=2, norecovery--2
select * from Existencias
restore database Almacen from Almacen_backup with norecovery,replace
restore database Almacen from Almacen_backup with file=2, norecovery--3
select * from Existencias

restore database Almacen from Almacen_log with norecovery, replace--restaurar base de datos completa
restore log Almacen from Almacen_log with recovery
select * from Existencias


sp_helpdevice
go
sp_dropdevice 'Almacen_backup'
go
sp_dropdevice 'Almacen_log'
go
sp_dropdevice 'Almacen_bu'

RESTORE DATABASE Almacen FROM DISK = 'D:\Almacen.bak' WITH NORECOVERY
RESTORE DATABASE Almacen FROM DISK = 'D:\Almacen.bak' WITH RECOVERY