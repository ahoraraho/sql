/*1) VALORES null: es la constante nulo, null significa dato desconocido o valor inexistente, p.ej en la BD “Libreria” y en la tabla
“libros” un campo precio puede tener valor null, si es que no se estableció el precio de venta, así mismo algunos campos no deben
admitir valores null p.ej. el campo autor.*/

--para empesar tenemos que creara la base de datos Lireria

CREATE DATABASE Libreria

use Libreria

--DROP TABLE LIBROS3

--2)Eliminar la tabla Libros usar: drop table NOMBRETABLE

DROP TABLE Libros 

--3)Crear la tabla libros: usar create...

CREATE TABLE Libros(
titulo varchar(150) not null, --no admite valores null
autor varchar(100) not null, --no admite valores null
editorial varchar(50) null, --si admite valores null
precio float --por default si admite valores null
);
--alteramos los campos de la tabla con el siguiente comando
ALTER TABLE Libros ALTER COLUMN autor varchar(100);  

--4)Insertar 5 registros en la tabla libros, dos de ellos que graven valores 
--null; usar: insert into NOMBRETABLA(campos) values(datos)

INSERT INTO Libros(titulo, autor, editorial,precio) VALUES
('Rich Dad Poor Dad','Robert T. Kiyosaki','Sirio', null),
('El millonario de la puerta de al lado','Thomas J. Stanley','Sirio',115),
('Los secretos de la mente millonaria','T.Harv Eker','Sirio',99),
('El hombre más rico de Babilonia','George S Clason',null,180),
('El Tao de Warren Buffett','Warren Buffett','Sirio',200)

select * from libros
--5)Verificar que campos admiten valores null en la columna IS_NULLABLE; usar: sp_columns NOMBRETABLA

sp_columns Libros

--6)Ver los registros con valores null en precio usar: select * from NOMBRETABLA where precio is null

select * from Libros where precio is null

--7)Insertar un registro con valor 0 (cero) en el campo precio, usar: insert…

INSERT INTO Libros(titulo, autor, editorial,precio) VALUES
('El cuadrante de flujo del dinero','Robert T. Kiyosaki','Sirio', 0)

--8)Insertar un registro con valor ' ' (cadena vacia) en el campo editorial y otro con valor null en editorial: usar insert…

INSERT INTO Libros(titulo, autor, editorial,precio) VALUES
('LA CIENCIA DEL DESASTRE','DANIEL SANTIAGO','', 102),
('1816 UNA NOVELA GOTICA','ANDRES MAROTE TREJOS',null, 85)

--9)Ver los registros con valores null en precio usar: select...where precio is null

select * from Libros where precio is null

--10)Ver los registros con valores null en editorial usar: select...where editorial is null

select * from Libros where editorial is null

--11)Insertar un registro con valores null en los campos titulo, autor y otro con ' ' (cadena vacia) en esos campos usar: insert…

INSERT INTO Libros(titulo, autor, editorial,precio) VALUES
(null,null,'Casa del libro', 152),
('','','Casa del libro', 147)

--12)Ver los registros con valores diferentes de null en precio usar: select...where precio is not null

select * from Libros where precio is not null

--13)Ver los registros con valores diferentes de null en editorial usar: select...where editorial is not null

select * from Libros where editorial is not null

--14)Ver todos los registros grabados usar: select * ...

select * from Libros 

--15)Ver los registros con precio 0 (cero) usar: select * ... where precio=0;

select * from libros where precio = 0

--16)Ver los registros con editorial con ‘ ‘ (cadena vacía) usar: select * ... where editorial=' ';

select * from libros where editorial = ''

--17)CLAVE PRIMARIA: Es un campo que identifica un solo registro o fila en la tabla, pues almacena un valor único que no se repite.
--Usar la sintaxis:
/*
create table NOMBRETABLA(
NOMBRECAMPO TipoDato,
primary key(nombrecampo)
);
*/
--Aplicación: elimine la tabla usuarios si existe y luego crear la estructura de la tabla usuarios

if object_id('usuarios') is not null
drop table usuarios;

--crear la estructura de la tabla usuarios

create table usuarios(
dni varchar(8) not null,
nombre varchar(30) not null,
telefono varchar(9) not null,
edad int null,
primary key(dni)
);

--18)Ver el contenido de la columna IS_NULLABLE de la tabla usuarios: usar sp_columns...

sp_columns usuarios

--19)Insertar cinco registros en la tabla usuarios usar: insert…

INSERT INTO usuarios(dni, nombre, telefono, edad) VALUES
('78945618','Vernardov Gamarra','987456321', 45),
('78744346','Julieta Martines','956784156', 14),
('89754654','Grabriela Ventancur','967414212', 26),
('32545645','Bernardo Maoma','9783548', 36),
('23465484','Juliana Gabilda','987456321', 75)


--20)Insertar un registro con null en el campo nombre usar: insert…

INSERT INTO usuarios(dni, nombre, telefono, edad) VALUES
('78945615',null,'987456347', 25)

--21)Insertar un registro con un dato ya grabado en el campo nombre (yo le puese la clave primaria en le DNI) intentando duplicarlo usar: insert…

INSERT INTO usuarios(dni, nombre, telefono, edad) VALUES
('78945618','Berta Gosueta','987296321', 44),

--22)Intentar actualizar el campo nombre (DNI) de un registro colocando un nombre ya existente en la tabla usar: update usuarios set
--nombre='un nombre' where nombre='otro nombre';

UPDATE usuarios 
    SET dni = '32545645'  --es la persona de nombre  Bernardo Maoma
    WHERE nombre = 'Juliana Gabilda' 

--23)CAMPO CON ATRIBUTO identity: se aplica a campos numéricos enteros para que estos sean autonuméricos o autogenerados
--produciendo valores únicos, solo puede haber un campo con identity, codificar:
CREATE TABLE libros2(
codigo int identity,
titulo varchar(40) not null,
autor varchar(30) not null,
editorial varchar(15),
precio float
);

--24)Insertar cinco registros en la tabla libros2 usar: insert into libros2(titulo,autor,editorial,precio) values... /*un campo identity no
--es editable*/

INSERT INTO Libros2(titulo, autor, editorial,precio) VALUES
('Rich Dad Poor Dad','Robert T. Kiyosaki','Sirio', 125),
('El millonario de la puerta de al lado','Thomas J. Stanley','Sirio',115),
('Los secretos de la mente millonaria','T.Harv Eker','Sirio',99),
('El hombre más rico de Babilonia','George S Clason','SBS',180),
('El Tao de Warren Buffett','Warren Buffett','Sirio',200)

--25)Ve la estructura de la tabla libros2, en las columnas TYPE_NAME y IS_NULLABLE: usar sp_columns...

sp_columns Libros2

--26)Ver los registros almacenados el libros2 usar: select…

SELECT * FROM Libros2

--27)Insertar un registro con un numero en el campo codigo de la tabla libros2 usar: insert…

INSERT INTO Libros2(titulo, autor, editorial,precio) VALUES
( 6,'Rich Dad Poor Dad','Robert T. Kiyosaki','Sirio', 125),

--28)Intente actualizar el campo codigo usar: update libros2 set codigo=2 where titulo='un titulo';

update libros2 set codigo=2 where titulo='Rich Dad Poor Dad';

--29)Eliminar el ultimo registro de libros2 usar: delete from libros2 where autor='un autor';

delete from libros2 where autor='Warren Buffett';

--30)Insertar un nuevo registro en libros2 usar: insert…

INSERT INTO Libros2(titulo, autor, editorial,precio) VALUES
('Jubilate joven','Robert T. Kiyosaki','SBS', 105)

--31)Ver todos los registros grabados en libros2 en especial código usar: select…

select * from  libros2

--32)Crear la tabla libros3, digitar:

create table libros3(
codigo int identity(100,5),
titulo varchar(150) not null,
autor varchar(100) not null,
editorial varchar(50),
precio float
);

--33)Ingresar cinco registros en libros3 usar: insert…

INSERT INTO Libros3(titulo, autor, editorial,precio) VALUES
('Rich Dad Poor Dad','Robert T. Kiyosaki','Sirio', 125),
('El millonario de la puerta de al lado','Thomas J. Stanley','Sirio',115),
('Los secretos de la mente millonaria','T.Harv Eker','Sirio',99),
('El hombre más rico de Babilonia','George S Clason','SBS',180),
('El Tao de Warren Buffett','Warren Buffett','Sirio',200)

--34)Ver todos los registros almacenados en libros3 usar: select…

select * from libros3

--35)Eliminar todos los registros de la tabla libros3 usar: delete from libros3;

delete from libros3;

--36)Ver los registros de la tabla libros3 usar: select…

select * from libros3

--37)Insertar cinco registros en la tabla libros3 usar: insert…

INSERT INTO Libros3(titulo, autor, editorial,precio) VALUES
('Rich Dad Poor Dad','Robert T. Kiyosaki','Sirio', 125),
('El millonario de la puerta de al lado','Thomas J. Stanley','Sirio',115),
('Los secretos de la mente millonaria','T.Harv Eker','Sirio',99),
('El hombre más rico de Babilonia','George S Clason','SBS',180),
('El Tao de Warren Buffett','Warren Buffett','Sirio',200)

--38)Ver los registros de la tabla libros3 usar: select…

select * from libros3

--39)Eliminar registros de la tabla libros3 usar: truncate table libros3;
--truncate elimina los registros y conserva la estructura de la tabla
--drop borra la tabla no queda ni la estructura

truncate table libros3;

--40)Ver las tablas existentes usar: sp_tables @table_owner=’dbo’;

sp_tables @table_owner='dbo';

--41)Insertar cinco registros en libros3 usar: insert…
INSERT INTO Libros3(titulo, autor, editorial,precio) VALUES
('Rich Dad Poor Dad','Robert T. Kiyosaki','Sirio', 125),
('El millonario de la puerta de al lado','Thomas J. Stanley','Sirio',115),
('Los secretos de la mente millonaria','T.Harv Eker','Sirio',99),
('El hombre más rico de Babilonia','George S Clason','SBS',180),
('El Tao de Warren Buffett','Warren Buffett','Sirio',200)--42)Ver los registros grabados en libros3 usar: select…
SELECT * FROM libros3

---------------------------------------------------------------------------------------------------------------
--_____________________________________________________________________________________________________________
---------------------------------------------------------------------------------------------------------------


--1)Eliminamos tabla libros/crear tabla libros

if object_id ('libros') is not null
drop table usuarios;

create table libros(
titulo varchar(30) not null,
autor varchar(30) not null,
editorial varchar(15) null,
precio float
);


--2)Insertar registro con null en precio

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',null);
insert into libros(titulo,autor,editorial,precio)
values('Alicia en el pais','Lewis Carrol',null,0);

--Ver registros de libros

select * from libros;


--3)Tratar de insertar null en campos que no lo admiten

insert into libros(titulo,autor,editorial,precio)
values(null,'Borges2','Emece2',null);

--Ver que campos admiten valores nulos columna IS_NULLABLE

sp_columns libros;


--4)Ingresar cadena vacia en editorial ' '


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


--5)CLAVE PRIMARIA

--TRABAJANDO CON LA TABLA USUARIOS/Eliminar/Crear
if object_id('usuarios') is not null
drop table usuarios;

create table usuarios(
nombre varchar(20),
clave varchar(10),
primary key(nombre)
);


--6)ver la estructura...campo nombre columna ISNULLABLE

sp_columns usuarios;

--7)Ingresar registros a usuarios

insert into usuarios(nombre,clave)
values('JuanPerez','Boca');
insert into usuarios(nombre,clave)
values('RaulGarcia','River');


--8)intentar ingresar un nombre ya grabado

insert into usuarios(nombre,clave)
values('JuanPerez','pBoca');


--9)intentar ingreso de null en la clave

insert into usuarios(nombre,clave)
values(null,'nBoca');


--10)intentar actualizar con un nombre existente

update usuarios set nombre='JuanPerez'
where nombre='RaulGarcia';

--11)Campo con atributo Identity/es numerico entero(autonumerico)
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

--12)intentar ingresar un codigo

insert into libros(codigo,titulo,autor,editorial,precio)
values(55,'jEl aleph','jBorges','jEmece',23);

--13)Tratar de actualizar codigo

update libros set codigo=3
where titulo='Matematicas';


--14)ver la estructura de la tabla libros columnas TYPT_NAME, IS_NULLABLE

sp_columns libros;


--15)Eliminar el ultimo registro

delete from libros
where autor='Lewis carrol';

--16)Ingresar un registro y luego ver todos los almacenados

insert into libros(titulo,autor,editorial,precio)
values('DesAprenda Php','jMario Molina','jSiglo XXi',5.60);

--ver todos los datos

select * from libros;

--17)Otras caracteristicas del atributo identity

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

--18)Truncate vacia la tabla deja la etructura//drop borra la tabla

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

--19)Ingresar registros

insert into libros(titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',23),
('Matematicas','Richard','Planeta',83),
('Aprenda Php','Mario Molina','Siglo XX',45.60),
('Alicia en el pais de las maravillas','Lewis carrol','Paidos',15.53);

--ver reg
select * from libros;

--20)Otros tipos de datos crear tabla visitantes
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

--21)Otros tipos numericos

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


--22)El tipo de dato fecha datetime se muestra "aa-mm-dd hh:mm:ss:ms"
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

---------------------------------------------------------------------------------------------------------------
--_____________________________________________________________________________________________________________
---------------------------------------------------------------------------------------------------------------

--1)valores por defecto- default
--crear tabla libros con campos con valor por default
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30) not null default 'Desconocido',
editorial varchar(20),
precio decimal(5,2),
cantidad tinyint default 0
);

--ingresar registros a la tabla libros

insert into libros (titulo,editorial,precio)
values('Java en diez','Paidos',30.567);
insert into libros (titulo,editorial)
values('Aprenda Php','Siglo XX');

select * from libros;

--visualizar la estructura de la tabla/ver columna COLUMN_DEF

sp_columns libros;

--Dar el valor por defecto

insert into libros(titulo,autor,precio,cantidad)
values('El gato con botas',default,default,100);

select * from libros;

--insertar todo con default valores

insert into libros default values;

select * from libros

--2)Columnas calculadas-operadores aritmeticos-de concatenacion
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
codigo int identity primary key,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0,
);

--ingresamos registros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','B0rges','Emece',25);
insert into libros
values('java en diez','Mario m','SigloXX',50.40,100);
insert into libros(titulo,autor,editorial,precio,cantidad)
values('Alicia en el pais','Lewis Carrrol','Emece',15,50);

--ver el monto total de cada libro-columna calculada precio*cantidad

select titulo,precio,cantidad,precio*cantidad from libros;

--ver el precio de cada libro con 10% de descuento-columna calculada descuento

select titulo,precio,precio-(precio*0.1) from libros

--actualizar precio con 10% de descuento-columna calculada

update libros set precio=precio-(precio*0.1);

select * from libros;

--Columnas concatenadas

select titulo+'-'+autor+'-'+editorial from libros;

--3Uso de Alias para nombres de columna trabajar con la tabla agenda

--NombreCampo as Alias
--eliminar tabla agenda si ezxiste

if object_id('agenda') is not null
drop table agenda;

--crear tabla agenda

create table agenda(
nombre varchar(30),
domicilio varchar(30),
telefono varchar(11)
);

--ingresar registros a agenda

insert into agenda
values('Perez','Avellaneda 400','424377’');
insert into agenda
values('Marta','Sucre 3400','4555577');
insert into agenda
values('Carlos','Sarmiento 900',null);

--mostrar informacion con columna con alias-una sola expresion sin espacios

select nombre as NombreyApellido,domicilio,telefono from agenda;

--mostrar información con columna con alias-una sola expresión con espacios en blanco entre palabras

select nombre as 'Nombre y Apellido',domicilio,telefono from agenda;

----mostrar informacion con columna con alias-una sola expresion con espacios''sin as

select nombre 'Nombre y Apellido',domicilio,telefono from agenda;

--4)Funciones cadena,

--funciones para elmanejo de cadenas - str() convirte a cadena

select str(123.456,7,3);
select str(-123.456,7,3);
select str(123.956);
select str(123.856,3);
select str(123.856,2,3); --imprime ** por el segundo argumento menor

--funcion stuff rellenar por remplazo

select stuff('abcde',3,2,'opqrs');

--Funcion longitud

select len('hola');

--Funcion Ascii

select char(65);

--Funcion extrae cadena izquierda,derecha,minuscula,mayuscula,eliminar espacios,reemplazar, reversa...

select left('buenos dias',8);
select right('Buenos dias',8);
select lower('HOLA');
select upper('Hola Peru');
select ltrim(' hola ');
select rtrim(' hola ');
select replace('xxx.sqlserverya.com','x','w');
select replace('hola','o','i');

--Funcion patindex(patron,cadena) retorna posición de ocurrencia si encuentra, sino retorna 0.

select patindex('%Luis%','Jorge Luis Borges');
select patindex('%or%','Jorge Luis Borges');
select patindex('%o%','Jorge Luis Borges');

--Funciones buscar subcadena en cadena

select charindex('or','Jorge Luis borges',5);
select charindex('or','Jorge Luis borges');

--Funciones replicar, espacios
select replicate('hola',5);
select 'hola'+space(3)+'que tal';

--5)Aplicando funciones a la tabla libros
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
codigo int identity primary key,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0
);

--ingresar registros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',25);
insert into libros
values('java en 10...','Mario m','Siglo X',50.46,100);
insert into libros(titulo,autor,editorial,precio,cantidad)
values('Alicia enel pais','Carrol Lewis','Emece',15,50);

--aplicando funciones subdadena

select substring(titulo,1,12) as 'Titulos de Libro' from libros;
select left(titulo,12) as 'Titulos de Libro' from libros;
select titulo,str(precio,6,1) from libros;
select titulo,str(precio) from libros; --redondear a entero
select titulo,autor,upper(editorial) from libros;


--6)Funciones matemáticas:valor absoluto,redondeos,resto(%),potencia,raíz cuadrada

select abs(-20); --recibe un valor numerico y retorna un valor apsoluto
select ceiling(12.35) as 'redondea hacia arriba'; /*redondea hacia arriba*/
select floor(12.35); /*redondea hacia abajo*/
select 10%3; /*resto*/
select power(2,3); --potencia dos al cubo
select round(123.456,1);/*redonde desde primer decimal por ser positivo*/
select round(123.456,2);/*redondea desde primer valor entero*/
select sqrt(8); /*raíz cuadrada*/



--7)Aplicando funciones matematicas a la tabla libros de una librería
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros
create table libros(
codigo int identity primary key,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0,
);

--ingresar registros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',25);

insert into libros
values('java en 10...','Mario m','Siglo X',50.46,100);
insert into libros(titulo,autor,editorial,precio,cantidad)
values('Alicia enel pais','Carrol Lewis','Emece',15,50);

--Mostrar precios redondeados hacia abajo/arrriba
select * from libros

select titulo,autor,precio,
floor(precio) as PrecioAbajo,
ceiling(precio) as PrecioArriba
from libros;


--8)Funciones Fechahora: getdate(), datepart(partedefecha,fecha)

select getdate(); --retorna fecha y hora actuales
select datepart(month,getdate()); --retorna nro. de mes
select datepart(day,getdate()); --retorna dia actual
select datepart(hour,getdate()); --retorna hora actual

--Funciones fechahora: datename(partedefecha,fecha)

select datename(month,getdate()); --retorna nombre de mes
select datename(day,getdate()); --retorna nombre dia actual
select datename(hour,getdate()); --retorna nombre hora actual

--agregar cantidad a fecha

select dateadd(day,5,'1980/11/02'); --agrega cinco días
select dateadd(month,3,'1980/11/02'); --agrega tres meses
select dateadd(hour,5,'1980/11/02');
select dateadd(minute,5,'1980/11/02');

--calcula intervalo de dias por diferencia

select datediff(day,'2005/10/28','2005/11/29');
select datediff(year,'2003/05/18','2022/09/27');

--retorna dia-mes-año

select day(getdate());
select month(getdate());
select year(getdate());

--9)Aplicando funciones fechahora a la tabla libros

--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
titulo varchar(100) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20) default 'primera',
edicion datetime,
precio decimal(6,2),
cantidad int
);

truncate table libros
--ingresar registros

insert into libros
values('El Aleph','Borges','Primera','12-01-1980',99.5,123);
insert into libros
values('java en 10...','Mario m','Siglo X','05-05-2000',50.65,55);
insert into libros(titulo,autor,editorial,edicion,precio,cantidad)
values('Alicia enel pais','Carrol Lewis','Emece','2000/08/09',45.58,100);

--consultas de seleccion usando funciones fechahora

select titulo,datepart(year,edicion) from libros;
select titulo,datename(month,edicion) from libros;
select titulo,datediff(year,edicion,getdate()) from libros;
select titulo from libros where datepart(day,edicion) = 9;

--10)ordenar registros- order by
--Sintaxis: select * from NOMBRETABLA order by NOMBRECAMPO[o Nro.Campo];
--Por default el ordenamiento es ascendente(asc), pero puede indicarse descendente(desc)
--sepuede ordenar por varios campos y en sentidos distintos
--Order by no se aplica a campos text, ntext, image
--Aplicando order by a la tabla libros de BD libreria
--Eliminando la tabla libros para luego crearla

if object_id('libros') is not null
drop table libros;

--crear tabla libros

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
primary key (codigo)
);

--Ingresando registros a la tabla libros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',15.44);
insert into libros(titulo,autor,editorial,precio)
values('Antologia','Borges','Emece',35.44);
insert into libros(titulo,autor,editorial,precio)
values('Java en diez...','Molina','Sigl',55.33);
insert into libros(titulo,autor,editorial,precio)
values('Alicia en el pais','Carroll','Paidos',20.22);
insert into libros(titulo,autor,editorial,precio)
values('Aprenda Php','Molinas','Planeta',14.67);
insert into libros(titulo,autor,editorial,precio)
values('Aprenda C++','Ceballos',null,17.77);
insert into libros(titulo,autor,editorial,precio)
values('Assembler','Rosello',null,18.56);

--Recuperar ordenados por titulo,...,etc

select * from libros order by titulo;
select titulo,autor,precio from libros order by 3;
select * from libros order by editorial desc;
select * from libros order by titulo,editorial;
select * from libros order by titulo asc,editorial desc;
select titulo,autor from libros order by precio;
select titulo,autor,editorial,precio-(precio*0.1) as 'PRECIO CON DESCUENTO'
from libros
order by 4;

--11)Aplicando operadores logicos(and,or,not) con relacionales(=,<>,<,<,<=,>=,is null, is not null)

select * from libros where (autor='Borges') and (precio<20);
select * from libros where (autor='Borges') or (editorial='Planeta');
select * from libros where not editorial='Planeta';
select * from libros where (autor='Borges') or(editorial='Paidos' and precio<20); --observar resultado con la siguiente
select * from libros where (autor='Borges' or editorial='Paidos') and (precio<20);
select * from libros where editorial is null; -- observar resultado con la siguiente
select * from libros where editorial is not null;
