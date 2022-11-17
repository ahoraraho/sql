--Cifrado de base de datos SQL Server utilizando TDE

--Imagen: Cifrado de datos transparente (TDE)

/*
Cuando alguien malintencionado roba las cintas de las copias de seguridad de las bases de datos, 
puede restaurar la base de datos en otro servidor y acceder a los datos. Una solución es encriptar 
la base de datos y usar un certificado para proteger las claves. Esta solución no dejará restaurar
la base de datos si no se tienen las claves. La encriptación TDE de SQL Server permite cumplir 
muchas leyes, normativas y directrices establecidas en diversos sectores. El Cifrado de datos 
transparente TDE realiza el cifrado y descifrado de E/S en tiempo real de los archivos de datos 
y de registro. Este cifrado usa una clave de cifrado de la base de datos. El registro de arranque 
de la base de datos almacena la clave para que esté disponible durante la recuperación. La clave 
de cifrado de la base de datos es una clave simétrica. Está protegida por un certificado que la 
base de datos maestra del servidor almacena.
*/

--Comando para ver si existen certificados: 

Select * from sys.certificates

/*----------------------------------------------------------------------------------*/
/*Paso1. Crear la clave maestra en la base de datos Master. (Create Master Key)*/
/*----------------------------------------------------------------------------------*/

--Debe ser creado en la base de datos MASTER:
USE Master; 
GO 
CREATE MASTER KEY ENCRYPTION 
BY PASSWORD='PasswordEncriptacion2020'; 
GO

/*
Se debe colocar una contaseña compleja, de lo contrario nos saldrá el siguiente mensaje. 
Mens. 15118, Nivel 16, Estado 1, Línea 1 
Error de validación de contraseña. La contraseña no cumple los requisitos de directiva de 
Windows porque no es bastante compleja.
*/

/*------------------------------------------------------------------*/
/*Paso 2. Crear el certificado protegido por la clave maestra*/
/*------------------------------------------------------------------*/

--Que protegerá la contraseña maestra de la base de datos MASTER:

Use Master; 
Go 
Create Certificate Certificado_TDE With Subject='PasswordCertificado2020'; 
Go 
--Ver si existe certificados 

Select * from sys.certificates 

--Resultado de la consulta: 
--Certificado_TDE


/*-----------------------------------------------------------------------------------------------------*/
/*Paso3. Crear clave de cifrado de base de datos de usuario, en este caso la base de datos NORTHWIND	*/
/*----------------------------------------------------------------------------------------------------*/

Use Northwind; 
Go 
Create Database Encryption Key With Algorithm=AES_256 Encryption 
by Server Certificate Certificado_TDE; 
Go

/*
Saldrá el siguiente mensaje: 
Advertencia: no se ha realizado una copia de seguridad del certificado usado para cifrar la clave 
de cifrado de la base de datos. Debería hacer inmediatamente una copia de seguridad del certificado 
y de la clave privada asociada con el certificado. Si el certificado llegara a no estar disponible 
o si tuviera que restaurar o asociar la base de datos en otro servidor, necesitará copias de seguridad
tanto del certificado como de la clave privada. De lo contrario, no podrá abrir la base de datos.
*/

/*------------------------------------------------------------------------------------------------------------*/
/*Paso4. Crear una Copia de seguridad del certificado (Certificado_TDE) para el cifrado de base de datos.	*/
/*---------------------------------------------------------------------------------------------------------------*/

Use Master; 
Go 
Backup Certificate Certificado_TDE to File = 'D:\Certificado_TDE\Certificado_TDE' 
with Private Key (file='D:\Certificado_TDE\Certificado_TDE.pri',
Encryption by Password='PasswordBackupCertificado2020')

/*
Poner contraseña compleja, de lo contrario saldrá el siguiente mensaje. 
Mens. 15118, Nivel 16, Estado 1, Línea 1 --Error de validación de contraseña. 
La contraseña no cumple los requisitos de directiva de Windows porque no es bastante compleja.*/


/*El primer archivo Certificado_TDE contiene la copia de seguridad del certificado. 
El segundo archivo Certificado_TDE.pri contiene la clave privada.*/


/*----------------------------------------------------------------------------------*/
/*		Paso 5.- Cifrado de base de datos de usuario	*/
/*----------------------------------------------------------------------------------*/

/*Tenemos el servidor SQL Server y la base de datos de usuario preparados para cifrar bases de datos, 
pero todavía no se ha empezado a cifrar nada. Para hacerlo, hay que habilitar el proceso de cifrado 
con el siguiente comando:*/

Alter database Northwind set encryption on;
Go 
/*El proceso de cifrado de base de datos de usuario ha empezado(dependiendo del tamaño de la base de datos 
puede demorar algunos minutos). Se puede comprobar el estado del cifrado con el siguiente comando: */

Select * from sys.dm_database_encryption_keys

--Verificar el campo encryption_state que según su valor indica: 
--0 = No existe una clave de cifrado en la base de datos, no está cifrado 
--1 = No cifrado 
--2 = Se está cifrando la base de datos 
--3 = Cifrado 
--4 = Se está cambiando la clave de cifrado 
--5 = Se está descifrando 
--6 = Se está cambiando la protección. 
--El certificado o la clave asimétrica que ha cifrado la clave de cifrado de base de datos se está modificando. 
--comando para ver el nombre de la base de datos a partir del campo database_id

select DB_NAME(5)

--Al tratar de restaurar en otro Servidor,nos aparecera el siguiente mensaje: 
--No se encuentra el servidor certificado con la huella digital '0xCF3F424E8362C9540C2C6E5BACCB2DB067D4DFDF'. 
--Fin anómalo de RESTORE FILELIST. (.Net SqlClient Data Provider)

/*----------------------------------------------------------------------------------*/
/*		Recuperar el certificado para el cifrado de base de datos	

Para esto se requiere de la copia de seguridad del certificado de cifrado. Desde la consola de SQL Server, ejecutamos 
el siguiente comando para crear la clave maestra:  */
/*----------------------------------------------------------------------------------*/

Use Master; 
go 
Create master key encryption by password='PasswordEncriptacion2020S2'; 
go


/*	Generar el nuevo certificado:	*/

/*Si queremos restaurar la base de datos encriptada en otra instancia, saldrá el siguiente mensaje*/

/*captura*/


/*Generar el nuevo certificado a partir de la copia de seguridad, indicando la ruta del certificado, la ruta 
del archivo con la clave privada y la contraseña que se puso cuando se hizo la copia de 
seguridad del certificado:*/

--Use Master; 
go 
Create Certificate Certificado_TDE1 from file = 'C:\Certificado_TDE\Certificado_TDE' 
with Private key (File = 'C:\Certificado_TDE\Certificado_TDE.pri', 
Decryption By Password ='PasswordBackupCertificado2020') 

--El servidor ha recuperado el certificado en la base de datos, lo comprobamos: 

Select * from sys.certificates;


/*Restaurar la base de datos:*/

--Descifrar base de datos cifrada 
Alter database Northwind Set encryption off

--Para comprobar que se ha descifrado correctamente, el campo encryption_state debe tener como valor el número 1: 

Select * from sys.dm_database_encryption_keys 

--Verificar el campo encryption_state que según su valor indica: --0 = No existe una clave de cifrado en la base de datos, no está cifrado 
--1 = No cifrado 
--2 = Se está cifrando la base de datos 
--3 = Cifrado 
--4 = Se está cambiando la clave de cifrado 
--5 = Se está descifrando 
--6 = Se está cambiando la protección. 
--El certificado o la clave asimétrica que ha cifrado la clave de cifrado de base de datos se está modificando.

/*Eliminar la clave de cifrado de base de datos:*/

Use Northwind Drop database encryption key

--Recomendacion: 
--No utilizar el mismo certificado para cifrar todas las bases de datos del servidor o servidores. 
--Un certificado para cada base de datos..
