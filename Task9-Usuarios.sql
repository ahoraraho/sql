
--crear un usuario general con contrseña 
USE Libreria;
GO

CREATE LOGIN Pablo
   WITH PASSWORD='P@$$w0rd';

--asignar el usuario a una base de datos
USE Libreria;
GO
CREATE USER Juan FOR LOGIN Juan;

--creamos un rol para asignarle a una tabla 
USE Libreria;
GO
CREATE ROLE RolSSMS;
GO
GRANT CREATE TABLE, CREATE VIEW to RolSSMS;