CREATE DATABASE Araho

USE Araho

CREATE TABLE Proveedor	
(
Idprovee	int	PRIMARY KEY IDENTITY,
Nomprovee	varchar(65) NOT NULL,
Dirprovee	varchar(128) NOT NULL,
rucprovee	varchar(11) NOT NULL,
telprovee	varchar(9) NOT NULL,
mailprovee	varchar(128) NOT NULL,
)
 /*-----------------------------------------------------*/


CREATE TABLE Categorias	
(
idcategoria	int	PRIMARY KEY IDENTITY,
nomcategoria	varchar(128),
estado	varchar(1)
)

CREATE TABLE Usuario
(
idusuario int	PRIMARY KEY IDENTITY,
loginn	varchar(15),
Ape	varchar(64),
Nom	varchar(64),
password varchar(128),
email	varchar(128),
estado	varchar(2)
)

CREATE TABLE TipoVenta
(
Idtipo	int	PRIMARY KEY IDENTITY,
Nomtipo	varchar(25) NOT NULL
)

CREATE TABLE Ubigeo	
(
idubigeo	varchar(6) PRIMARY KEY,
nomdistrito	varchar(128),
idprovincia	varchar(4),
iddepto	varchar(2)
)

CREATE TABLE DistritosVentas
(
Iddistrito	int NOT NULL PRIMARY KEY IDENTITY,
Nomdistrito	varchar(128),
Ubigeo	varchar(6) Foreign key References Ubigeo(idubigeo),
)

CREATE TABLE CategoriasProveedor
(
Id	int	PRIMARY KEY IDENTITY,
idprovee int Foreign key References Proveedor(idprovee),
idcategoria	int Foreign key References Categorias(idcategoria)
)

CREATE TABLE Zonas_ventas
(
idzona	int	PRIMARY KEY IDENTITY,
nomzona	varchar(128) NOT NULL,
iddistrito Int Foreign key References DistritosVentas(iddistrito) 
)

CREATE TABLE Cliente(
Idcliente int NOT NULL PRIMARY KEY IDENTITY,
Nomcliente	varchar(65),
Dircliente	varchar(128),
ruccliente	varchar(11),
telcliente	varchar(9),
mailcliente	varchar(128),
idzona int Foreign key References Zonas_ventas(idzona)
)

CREATE TABLE Ventas		
(
idVenta	int	PRIMARY KEY IDENTITY,
fecha	date NOT NULL,
idcliente int Foreign key References Cliente(idcliente),
Idtipo int Foreign key References TipoVenta(idtipo),
Nrodocumento varchar(10) NOT NULL,
Idusuario int Foreign key References Usuario(idusuario),
Importe	decimal(10,4) NOT NULL,
IGV	decimal(10,4) NOT NULL
)

CREATE TABLE Producto
(
Idproducto	int	PRIMARY KEY IDENTITY,
Nomprodu	varchar(128) NOT NULL,
Unimed	varchar(64) NOT NULL,
StockProdu	int	NOT NULL,
Cosuni	decimal(10,4) NOT NULL,
Preuni	decimal(10,4) NOT NULL,
StockMin	int	NOT NULL,
StockMax	int	NOT NULL,
idcategoria	int Foreign key References Categorias(idcategoria),
estado	varchar(1) NULL
)

CREATE TABLE DetalleVentas	
(
iddetalle	int	PRIMARY KEY IDENTITY,
idventa		int Foreign key References Ventas(idVenta),
idproducto	int Foreign key References Producto(Idproducto),
cosuni	decimal(10,4) NOT NULL,
preuni	decimal(10,4) NOT NULL,
canttidad int NOT NULL,
)


--1.- Ingrese al SSMS		

--2.- Proceda a crear la base de datos Ventas y las tablas respectivas, añada registros a las tablas mediante 								
     --la instrucción INSERT a cada una de ellas
	
INSERT INTO Proveedor(Nomprovee, Dirprovee, rucprovee, telprovee, mailprovee) VALUES
('AMERICATEL PERU S.A.','PERU','74859632478','987456321','email@americalmobil.com'),
('AVATAR S.A.C.','PERU','17896348579','974856874','email@avatar.com'),
('CESEL S.A.','PERU','258741697846','978148575','email@cesel.com'),
('APPLE ING','EEUU','17947895632','974856782','email@apple.com'),
('SAMSUNG ING','California EEUU','58741968745','384579846','email@samsung.com')

INSERT INTO Categorias(nomcategoria, estado) VALUES
('CELULARES','1'),
('COMPUTADORAS','1'),
('ROPA VARON','1'),
('ROPA MUJER','1'),
('JUGETES','1'),
('UTENCILIOS','1'),
('TABLETAS','1'),
('PCs','1'),
('HERRMIENTAS','1'),
('COSINA','1'),
('MUEBLES','1'),
('ELECTRODOMENTICOS','1')


INSERT INTO Usuario(loginn, Ape, Nom, password, email, estado ) VALUES
('camila','FERSADUA VENRACRUS','CAMILA','camila123','camila@gmail.com','1'),
('fortunato','ESLOBEJO CANASA','FORTUNATO','fortunato132','fortu@gmil.com','0'),
('arom','CASTILLO ALBALUNA','AROM','arom123','aromqoutlook.com','0')


INSERT INTO TipoVenta(Nomtipo) VALUES 
('TARGETA DE CREDITO'),
('PAYPAL'),
('TRANFERENCIA'),
('CRYPTO')

INSERT INTO Ubigeo(idubigeo,nomdistrito, idprovincia, iddepto) VALUES
('0058','La Molina','lima','lima'),
('0040','San Salbador','lima','lima'),
('0089','Ventanilla','lima','lima'),
('0072','Miraflores','lima','lima')

INSERT INTO DistritosVentas(Nomdistrito, Ubigeo) VALUES
('La Molina','0058'),
('San Salbador','0040'),
('Ventanilla','0089'),
('Miraflores','0072')


INSERT INTO CategoriasProveedor(idprovee, idcategoria) VALUES
(1,8),
(2,10),
(3,2),
(5,6),
(5,3)


INSERT INTO Zonas_ventas(nomzona, iddistrito) VALUES
('NORTE',1),
('NORO-ESTE',2),
('SUR',3),
('ESTE',4)


INSERT INTO Cliente(Nomcliente, Dircliente, ruccliente, telcliente, mailcliente, idzona) VALUES
('FERSADUA VENRACRUS CAMILA','AREQUIPA','487858741795','987458621','camila@gmail.com',1),
('MAYTA CHAMBILLA ALFREDO','LIMA','578936478541','986352147','alfredo@outlook.com',2),
('GARMENDIA FLORES FRANCISCO','AV BOLOGNESI','17893547896','985896314','francisco@hotmail.com',3),
('VALDIVIA CHOQUE ANAVEL','AV MARIATEGUI','58741397845','978635218','anavel@outlook.com',4),
('VALDERRAMA AUINO SAMUEL','AV VERMEJO','74189578934','983657412','samuel@gmail.com',2),
('BENTURA VERMEJO FIORELA','AV AREQUIPA','58749687521','97896327','fiorela@gmail.com',1)


INSERT INTO Ventas(fecha, idcliente, Idtipo, Nrodocumento, Idusuario, Importe, IGV) VALUES
('2022-11-6',5,2,'78486978',5,100,18),
('2022-11-7',1,3,'98745861',5,500,18),
('2022-11-8',3,4,'37948215',5,999,18)


INSERT INTO Producto(Nomprodu, Unimed, StockProdu, Cosuni, Preuni, StockMin, StockMax, idcategoria, estado) VALUES
('','',1,1,2,3,1000,'',''),
('','',1,1,2,3,1000,'',''),
('','',1,1,2,3,1000,'',''),
('','',1,1,2,3,1000,'',''),
('','',1,1,2,3,1000,'','')



INSERT INTO DetalleVentas(idventa, idproducto, cosuni, preuni, canttidad) VALUES
(1,1,'','','');
(1,1,'','','');
(1,1,'','','');
--3.- Cree un login y un usuario para acceder a la base de datos ventas. (el usuario debe tener derechos de 								
      --administracion y podra hacerlo solo en la base de datos Ventas)	
	  


--4.- Crear un login y usuario que pueda acceder a la base de datos Ventas y solo pueda realizar consultas								
      --a las tablas ventas y detalleVentas	
	  


--5.- Realizar una tarea en el Agente de SQL server para realizar una consulta y grabarla en una carpeta en el								
      --disco duro donde se debe visualizar a partir de las 10 pm el listado de ventas del dia.								
      --Fecha, Nomcliente, Tipo, Importe, IGV, Ape, Nom (usuario que registro la venta)		
	  


--6.- Realizar una tarea en el Agente de SQL server para realizar una consulta de los productos vendidos en								
      --en el dia en cantidades y precios de venta. La tarea debe correr los viernes a las 9.00 pm								
