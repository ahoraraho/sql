CREATE DATABASE ALMACEN

USE ALMACEN


CREATE TABLE PROVEEDOR(
RucProv VARCHAR(10) PRIMARY KEY CHECK (RucProv LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
RazProv VARCHAR(100) NOT NULL,
DireccioProv VARCHAR(50) NOT NULL,
Telefprov INT NOT NULL,
CelularProv VARCHAR(10) CHECK (CelularProv LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CorreoProv VARCHAR(50) 
);


CREATE TABLE EXISTENCIAS(
Codigo CHAR(4) PRIMARY KEY CHECK (Codigo LIKE 'A[0-9][0-9][0-9]') NOT NULL,
Descripcion VARCHAR(200) NOT NULL,
Medida VARCHAR(100) NOT NULL,
Precio MONEY DEFAULT(00) NOT NULL,
Stock INT 
);

CREATE TABLE RECEPCION(
NumOrden INT  PRIMARY KEY NOT NULL,
Fecha DATE,
RucProv VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES PROVEEDOR(RucProv),
);

CREATE TABLE DETALLE_RECEPCION(
NumOrden INT NOT NULL FOREIGN KEY REFERENCES RECEPCION(NumOrden),
Codigo CHAR(4) NOT NULL FOREIGN KEY REFERENCES EXISTENCIAS(Codigo),
Cantidad INT
);



INSERT INTO PROVEEDOR VALUES
('1090807022','Alfa S.A.','Av. Pizarro 130',424354,'936535961','alfa@gmail.com'),
('1029334544','Betha S.A.','Av. Lima 400', 402235,'926525962','betha@gmail.com'),
('1020405021','Gamma S.A.','Av. Independencia 868', 441020,'916545960','gamma@gmail.com')



INSERT INTO EXISTENCIAS VALUES
('A201','Articulo xxx','Kilos',10.50,100),
('A300','Articulo yyy','Metros',3.4,100),
('A150','Articulo zzz','litros',4.2,100),
('A500','Articulo www','Cajas',15.6,100),
('A400','Articulo vvv','Toneladas',250.5,100)

INSERT INTO RECEPCION VALUES
(100,'2022-07-15','1029334544'),
(110,'2022-07-17','1020405021'),
(120,'2022-07-22','1090807022')


INSERT INTO DETALLE_RECEPCION VALUES
(100,'A201',10),
(100,'A300',20),
(100,'A150',5),
(110,'A500',15),
(110,'A300',5),
(120,'A400',18),
(120,'A201',22),
(120,'A300',4)


--3)Crear una regla para el campo cantidad

create rule RG_cantidad_rango 
AS   
@cantidad>= $0 AND @cantidad <$10000; 

--ver si la regla fue creada

Sp_help;


--eliminar dicah rectriccion
Alter table EXISTENCIAS drop RG_cantidad_rango;

--asociar la regla al campo dni

Exec sp_bindrule RG_cantidad_rango, 'EXISTENCIAS.Stock';

--ver si la regla esta asociada a algún campo de existencias

Sp_helpconstraint EXISTENCIAS


--4) Crear una consulta ordenada

select * from DETALLE_RECEPCION ORDER BY NumOrden ASC

--5) Crear índices no agrupados

create nonclustered index I_libros_titulo on DETALLE_RECEPCION(NumOrden);

--ver los índices de la tabla libros

Sp_helpindex DETALLE_RECEPCION;

--6) Crear una consulta join de combinación de por lo menos dos tablas

Select E.Descripcion AS 'DESCRIPCION DEL ARTICULO', E.Medida AS 'TIPO DE MEDIDA', E.Precio AS 'PRECIO', D.Cantidad AS 'CANTIDAD VENDIDA' from EXISTENCIAS as E join DETALLE_RECEPCION as D on D.Codigo = E.codigo;

--7) Crear restricciones foreing key según el caso

--para creara una tabla nueva que registre los cambios que se hagan en la tabla existencias

CREATE TABLE HISTORIAL(
fecha datetime,
codigo char(4) FOREIGN KEY REFERENCES EXISTENCIAS(Codigo),
descripcion varchar(100), 
usuario varchar(20))


--8) Hacer una subconsulta

SELECT RazProv, DireccioProv, CorreoProv FROM PROVEEDOR 
WHERE  RucProv  IN (SELECT RucProv FROM RECEPCION WHERE Fecha = '2022-07-17')

--9) Crear un procedimiento almacenado

---------------------------------------------------------------------------
--CREAR UN PROCEDIMIENTO ALMACENADO DE INSERCION DE EXISTENCIAS, CON PARAMETROS
---------------------------------------------------------------------------

create procedure usp_nueva_existencia
--creamos los parametros segun su tipo de dato de la tabla existencias
@codigo char(4),
@descripcion varchar(200),
@medida varchar(100),
@precio money,
@stock int
as
	insert into EXISTENCIAS(Codigo, 
							Descripcion, 
							Medida,
							Precio,
							Stock) 
					values(	@codigo,
							@descripcion,
							@medida,
							@precio,
							@stock);
go



------------------------------------------------------------------------------
--CREAR UN PROCEDIMIENTO ALMACENADO DE ACTUALISACION DE EXISTENCIAS, CON PARAMETROS
------------------------------------------------------------------------------

create procedure usp_actualiszar_existencia
--creamos los parametros segun su tipo de dato de la tabla existencias
@codigo char(4),
@descripcion varchar(200),
@medida varchar(100),
@precio money,
@stock int
as
	 UPDATE EXISTENCIAS SET Descripcion = @descripcion, 
							Medida = @medida,
							Precio = @precio,
							Stock = @stock
					WHERE   Codigo = @codigo;
							
go


------------------------------------------------------------------------------
--CREAR UN PROCEDIMIENTO ALMACENADO DE ELIMINACION DE EXISTENCIAS, CON PARAMETROS
------------------------------------------------------------------------------

CREATE PROCEDURE usp_eliminar_existencia
@codigo char(4)
as
	DELETE FROM EXISTENCIAS WHERE Codigo = @codigo;
go

--para hacer uso de los procedimientos almacenados que cremos, lo haremos en el siguiente punto

--10) Crear un disparador

--para esto vamos a usar la tabla historial que creamos lineas arriba -> historial donde se registraran los cambios hechos


--revisamos el contenido de las tablas historial y existencias

select * from EXISTENCIAS
select * from HISTORIAL

-------------------------------------------------------------------------------------------
-----trigger de insertar existencias
-----------------------------------------------------------------

create trigger TR_existenciaInsertada
on EXISTENCIAS for insert
as
set nocount on
declare @codigo char(4)
select @codigo = Codigo from inserted 
insert into historial values(getdate(), @codigo, 'nuevo registro insertado', system_user)


--insertamos una nueva existencia usando el procedimiento guardado que creamos

insert into EXISTENCIAS values
('A415','Articulo xyz','Libras',192,150)

EXEC usp_nueva_existencia 'A415','Articulo xyz','Libras',192,150;

--verificamos que la nueva existencia se haya registrado corectamente y tambien que se gurado esa accion en la tabla historial

select * from EXISTENCIAS
select * from HISTORIAL


-------------------------------------------------------------------------------------------
-----trigger de actualisacion de existencias
-----------------------------------------------------------------
create trigger TR_existenciaActualizada
on EXISTENCIAS for update	
as
set nocount on
declare @codigo char(4)
select @codigo = Codigo from inserted   
insert into historial values(getdate(), @codigo, 'registro existente actualizado', system_user)


--usando procedure
EXEC usp_actualiszar_existencia 'A415','Articulo xyz','Libras',192,52;

--verificamos que la nueva existencia se haya registrado corectamente y tambien que se gurado esa accion en la tabla historial

select * from EXISTENCIAS
select * from HISTORIAL


--11) Crear una vista de por lo menos dos tablas

--La vista que vamos a crear es la que filtre la existencia que mas se vendio

CREATE VIEW NUMERO_MAX_EXISTENCIAS_VENDIDAS AS 

SELECT  E.Codigo, E.Descripcion, D.Cantidad AS 'CANTIDAD VENDIDA'
FROM EXISTENCIAS E INNER JOIN DETALLE_RECEPCION D 
ON E.Codigo= D.Codigo AND D.Cantidad = (SELECT MAX(Cantidad) FROM DETALLE_RECEPCION )


--Ejecutamos la vista 

SELECT * FROM NUMERO_MAX_EXISTENCIAS_VENDIDAS
