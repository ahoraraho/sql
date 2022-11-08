CREATE DATABASE VENTAS

USE VENTAS

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
CREATE TABLE DistritosVentas
(
Iddistrito	int NOT NULL PRIMARY KEY ,
Nomdistrito	varchar(128),
Ubigeo	varchar(6)
)

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
password	varchar(128),
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
fecha	date	NOT NULL,
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