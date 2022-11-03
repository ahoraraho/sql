CREATE DATABASE VENTAS

USE VENTAS

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
idusuario	int	PRIMARY KEY IDENTITY,
loginn	varchar(15),
Ape	varchar(64),
Nom	varchar(64),
password	varchar(128),
email	varchar(128),
estado	varchar(2)
)

CREATE TABLE CLIENTE(
Idcliente int NOT NULL PRIMARY KEY IDENTITY,
Nomcliente	varchar(65),
Dircliente	varchar(128),
ruccliente	varchar(11),
telcliente	varchar(9),
mailcliente	varchar(128),
)