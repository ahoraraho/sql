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
use DBSegura
go

--se crea la tabla cliente con una columna denominada TC que sea de tipo varbinary
--con el fn que contega la informacion emcriptada
create table dbo.Cliente 
(
CodCliente int not null identity(1,1),
Nombres varchar(100) not null,
TC varbinary(150)
)

--ahora se hace la inclusion de un valor
insert into dbo.Cliente(Nombres, TC)
VALUES ('AlanAtilio', ENCRYPTBYPASSPHRASE('FraseSecreta','4444-4444-4444-4444'))
go

--procedemos a hacer a  un select convencional

SELECT CodCliente, Nombres, TC
FROM dbo.Cliente

--se hace un select con una frese incorrecta

SELECT CodCliente, Nombres, CONVERT(VARCHAR(50), 
DECRYPTBYPASSPHRASE('NoFraseSecreta', TC))
FROM dbo.Cliente

--ahora se hace select con la frese corresta

SELECT CodCliente, Nombres, CONVERT(VARCHAR(50), 
DECRYPTBYPASSPHRASE('FraseSecreta', TC)) as 'clave'
FROM dbo.Cliente

--Se hace un select con una frase incorrecta

SELECT CodCliente, Nombres, CONVERT(VARCHAR(50), 
DECRYPTBYPASSPHRASE('NoFraseSecreta', TC))
FROM dbo.Cliente

--ahora se hace select con la frese corresta

SELECT CodCliente, Nombres, CONVERT(VARCHAR(50), 
DECRYPTBYPASSPHRASE('FraseSecreta', TC))
FROM dbo.Cliente


-- B.- Symmetrie Key
/*
Como se ha descrito, el proceso de encriptación mediante llaves simétricas tiene como principio de funcionamiento la encriptación y desencriptación
de la información a través del uso de una misma llave. Es decir que, se debe proteger la llave para que no sea publicada o accesible a todos los usuarios,
ya que todo el que tenga la llave podrá visualizar los datos importantes que se encuentran encriptados dentro de la BD. Ahora, la creación de una llave
simétrica, tiene que ser encriptada mediante un certificado, bien sea por medio de una llave de tipo asimétrica o a través de otra llave simétrica,
haciendo que se brinde mayor seguridad puesto que el usuario deberá intentar sobrepasar los mencionados métodos de encriptación y llegar a la llave
que le dará el permiso de encriptar o desencriptar el contenido que este en la BD, así:
*/

--se hace la limpieza del ambinete 

IF (DATABASEPROPERTYEX('DPSegura','version') > 0)
BEGIN 
USE master
ALTER DATABASE BSSegura SET single_user WITH ROLLBACKIMMEDIATE
DROP DATABASE DBSegura
END

--Se crea la base de datos para hacer las peuebas
USE master
go 
CREATE DATABASE DBSegura
go

-- se usa la base de datos recien creada

use DBSegura
go

--ahora se crea una tabla con una columna DocNum de tipo varbinary que contenga
--la informacion encriptada

CREATE TABLE dbo.SymetricKeyEncription
(
Nombres VARCHAR(100),
DocNum VARBINARY(128)
)

--SE Crea una Database Master Key

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ClaveSegura'

--se crea el certificado necesario

Create CERTIFICATE PrimerCertificado WITH SUBJECT = 'DBAMemoriesCertificate',
EXPIRY_DATE = '12/31/2022'

--Se hace la creacion de la llave simetrica

CREATE SYMMETRIC KEY LlaveSimetrica WITH 
KEY_SOURCE = 'MyKeySource',
IDENTITY_VALUE = 'MyIdentityValue',
ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE PrimerCertificado

--Se hace una consula y se visualiza las llaves simetricas de la base de datos para este 
--ejerciio tenemos sos la DMK y la llave simetrica creada a partir del certificado

SELECT name, algorithm_desc, create_date
FROM sys.symmetric_keys

--