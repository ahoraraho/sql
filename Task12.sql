/*Encriptación y Des encriptación de base de datos SQL Server 
A.- PassPhrase 
Este tipo de cifrado muestra la forma más sencilla y básica de encriptar los datos con SQL Server, 
a través de su mecanismo, se hace la encriptación de algún tipo de palabra o contraseña “asegurada” 
sin nada más, uno de los problemas es que no existe seguridad en la contraseña no exige mecanismos 
de contraseña segura, si la contraseña es expuesta se pierde toda la seguridad. Existe otra posibilidad 
de problema con esta metodología, es que puede que no todos los datos de una columna sean encriptados 
con la misma clave, éste es el problema que trae este mecanismo con lo cual la información quedaría 
irrecuperable, ejemplo*/

--primero se limpia el ambiente
if(DATABASEPROPERTY('DBSegura','version')>0)
BEGIN
USE master
ALTER DATABASE DBSegura SET single_user WITH ROLLBACKIMMEDIATE
DROP DATABASE DBSegura
END

--luego se crea la base de datos prueba con el nombre que se quiera
use master
go
create database DBSegura
go
--se usa la base de datos recien creada
use BDSegura
go

--se crea la tabla cliente con una columna denominada TC que sea de tipo varbinary
--con el fn que contega la informacion emcriptada
create table cliente 
(
CodCliente int not null identity(1,1),
Nombres varchar
)

