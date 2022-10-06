
--1)--Eliminamos tabla libros/crear tabla libros

if object_id ('libros') is not null
drop table usuarios;

create table libros(
titulo varchar(30) not null,
autor varchar(30) not null,
editorial varchar(15) null,
precio float
);


--2)--Insertar registro con null en precio

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',null);
insert into libros(titulo,autor,editorial,precio)
values('Alicia en el pais','Lewis Carrol',null,0);

--Ver registros de libros

select * from libros;


--3)--Tratar de insertar null en campos que no lo admiten

insert into libros(titulo,autor,editorial,precio)
values(null,'Borges2','Emece2',null);

--Ver que campos admiten valores nulos columna IS_NULLABLE

sp_columns libros;


--4)--Ingresar cadena vacia en editorial ' '


insert into libros(titulo,autor,editorial,precio)values
('Uno','Richard Bach','',18);

--Ver todos los registros de libros

select * from libros;

--Consultar los registros con null en precio

select * from libros where precio is null;

--Consultar los que tienen precio 0

select * from libros where precio=0;

--Consultar los libros con editorial null

select * from libros where editorial is null;

--Ver libros con editorial cadena vacia ''

select * from libros where editorial='';

--Ver los libros con precio diferente de null

select * from libros where precio is not null;


--5) CLAVE PRIMARIA

--TRABAJANDO CON LA TABLA USUARIOS/Eliminar/Crear
if object_id('usuarios') is not null
drop table usuarios;

create table usuarios(
nombre varchar(20),
clave varchar(10),
primary key(nombre)
);


--6)--ver la estructura...campo nombre columna ISNULLABLE

sp_columns usuarios;

--7)--Ingresar registros a usuarios

insert into usuarios(nombre,clave)
values('JuanPerez','Boca');
insert into usuarios(nombre,clave)
values('RaulGarcia','River');


--8)--intentar ingresar un nombre ya grabado

insert into usuarios(nombre,clave)
values('JuanPerez','pBoca');


--9)--intentar ingreso de null en la clave

insert into usuarios(nombre,clave)
values(null,'nBoca');


--10)--intentar actualizar con un nombre existente

update usuarios set nombre='JuanPerez'
where nombre='RaulGarcia';

--11)--Campo con atributo Identity/es numerico entero(autonumerico)
--no permite nulos/no permite ingresar datos se omite en insert/no es editable
--por lo grl. es clave primaria

if object_id('libros') is not null
drop table libros;

--crear tabla con campo identity

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar(30),
editorial varchar(15),
precio float
);

insert into libros(titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',23),
('Matematicas','Richard','Planeta',83),
('Aprenda Php','Mario Molina','Siglo XX',45.60),
('Alicia en el pais de las maravillas','Lewis carrol','Paidos',15.53);

--ver registros almacenados

select * from libros;

--12)--intentar ingresar un codigo

insert into libros(codigo,titulo,autor,editorial,precio)
values(55,'jEl aleph','jBorges','jEmece',23);

--13)--Tratar de actualizar codigo

update libros set codigo=3
where titulo='Matematicas';


--14)--ver la estructura de la tabla libros columnas TYPT_NAME, IS_NULLABLE

sp_columns libros;


--15)--Eliminar el ultimo registro

delete from libros
where autor='Lewis carrol';

--16)--Ingresar un registro y luego ver todos los almacenados

insert into libros(titulo,autor,editorial,precio)
values('DesAprenda Php','jMario Molina','jSiglo XXi',5.60);

--ver todos los datos

select * from libros;

--17)--Otras caracteristicas del atributo identity

if object_id('libros') is not null
drop table libros;

--crear tabla con campo identity

create table libros(
codigo int identity(100,5),
titulo varchar(40) not null,
autor varchar(30),
editorial varchar(15),
precio float
);

insert into libros(titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',23),
('Matematicas','Richard','Planeta',83),
('Aprenda Php','Mario Molina','Siglo XX',45.60),
('Alicia en el pais de las maravillas','Lewis carrol','Paidos',15.53);

--ver registros almacenados

select * from libros;

--18)--Truncate vacia la tabla deja la etructura//drop borra la tabla

truncate table libros;

select * from libros;

--Ingresar registros

insert into libros(titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',23),
('Matematicas','Richard','Planeta',83),
('Aprenda Php','Mario Molina','Siglo XX',45.60),
('Alicia en el pais de las maravillas','Lewis carrol','Paidos',15.53);

--ver reg
select * from libros;

--Eliminar todos los reg con delete

delete from libros;

--ver reg

select * from libros;

--19)--Ingresar registros

insert into libros(titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',23),
('Matematicas','Richard','Planeta',83),
('Aprenda Php','Mario Molina','Siglo XX',45.60),
('Alicia en el pais de las maravillas','Lewis carrol','Paidos',15.53);

--ver reg
select * from libros;


--20)--Otros tipos de datos crear tabla visitantes
if object_id('visitantes') is not null
drop table visitantes;

create table visitantes(
nombre varchar(30),
edad integer,
sexo char,
domicilio varchar(30),
ciudad varchar(20),
telefono varchar(11)
);

insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono) values
('Pedro Juarez',33,'m','Av Independencia 898','Arequipa','424377'),
('marcela Morales',31,'f','Av Independencia 898','Arequipa',442437);

select * from visitantes;


--21)--Otros tipos numericos

if object_id('libros') is not null
drop table libros;

create table libros(
codigo smallint identity, /*rango -32000 a 32000*/
titulo varchar(40) not null,
autor varchar(30),
editorial varchar(15),
precio1 smallmoney, /* rango -200000 a 200000 */
precio2 decimal(5,2), /* 5 numeros pero dos son decimales */
cantidad tinyint
);

--Ingresar registros/ dato tinyint desbordado a 255-260
insert into libros(titulo,autor,editorial,precio1,precio2,cantidad)
values('ElAleph','Borges','Emece',26.60,24.558,260);

--Ingresar precio desbordado

insert into libros(titulo,autor,editorial,precio1,precio2,cantidad)
values('jElAleph','jBorges','jEmece',250000,24.553,260);

--Ingreaso con error en precio
insert into libros(titulo,autor,editorial,precio1,precio2,cantidad)
values('kElAleph','kBorges','kEmece','a26.60',24.558,260);

--ingreasr con cantidad expresada como cadena
insert into libros(titulo,autor,editorial,precio1,precio2,cantidad)
values('lElAleph','lBorges','lEmece',26.606,24.5538,'260');
select * from libros;


--22)--El tipo de dato fecha datetime se muestra "aa-mm-dd hh:mm:ss:ms"
--independientemente delformato elegido para entrar
--separadores de fecha - / .
--especificar formato de entrada con set dateformat FORMATO
--FORMATO mdy myd dmy dym ydm (d,m con 1 o 2 dig y con 2 o 4 dig
--crear tabla empleados

if object_id('empleados') is not null
drop table empleados;

create table empleados(
nombre varchar(20),
documento char(8),
fechaingreso datetime
);

--seteamos el formato de fecha para que guarde dmy 0000!!!1

set dateformat dmy;

--Ingresar registros a empleados/se omiten los nombres de campos porque
--se ingresan datos para todos

insert into empleados values
('ana','22222222','12-01-1980'),
('bernardo','33333333','15-03-81'),
('carla','44444444','20/05/1983'),
('daniel','5555555','2.5.1990');

--Ingresar datos solo para algunos campos

insert into empleados (nombre,documento) values('ferarla','9999999');
insert into empleados (nombre,fechaingreso) values('medaniel','8.5.1999');

--ver reg almacenados observar el formato de visualizacion

select * from empleados;

--Mostrar reg con fecha < 1985

select * from empleados where fechaingreso<1985;

--Actualizar condicionando la fecha

update empleados set nombre='Carla Juarez'
where fechaingreso='20.5.83';

--ver actualizacion

select * from empleados;

--borrar empleados condicionando por fecha

delete from empleados
where fechaingreso<>'20/05/1983';

--ver reg

select * from empleados;