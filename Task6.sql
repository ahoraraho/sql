/*1)Función grouping: se usa con rollup y cube para distinguir valores de detalle y resumen con esta
función aparece una nueva columna de salida por cada grouping con valores 1,0; 1 indica valores
resumen de rollup y cube y 0 valores de campo. Solo se usa grouping en los campos de group by
*/

--Creando tabla visitantes--

create table visitantes(
nombre varchar (30),
sexo char(1),
ciudad varchar(20),
);

--Ingresando datos

insert into visitantes values
('Rosa','F','Arequipa'),
('Maria','F','Arequipa'),
('Carlos','M','Arequipa'),
('Ana','F','Null'),
('Pedro','M','Null'),
('Teresa','F','Cuzco'),
('Raul','M','Cuzco'),
('Roxana','F','Cuzco'),
('Roberto','M','Cuzco');

--2)Contar visitantes agrupados por ciudad con rollup: 

Select ciudad, count(*) as CANTIDAD from visitantes 
Group by ciudad with rollup;

--3) Contar visitantes agrupados por ciudad con rollup y grouping: 

Select ciudad,count(*) as CANTIDAD, grouping(ciudad) as RESUMEN from visitantes
Group by ciudad with rollup;



--4)Clausula compute y compute by: generan resúmenes que aparecen en columnas extras al final del
--resultado, se usan con funciones de agrupamiento avg,count,sum,max,min; sintaxis:

/*El campo debe estar en la lista del select; compute by, genera cortes de control y subtotales y también trabaja
con order by con los mismos campos. Crear la tabla visitantes2:*/

create table visitantes2(
nombre varchar (30),
edad tinyint,
ciudad varchar(20),
provincia varchar(20),
mail varchar(30),
montocompra decimal(6,2),
);

insert into visitantes2 values
('Rosa','20','Arequipa','Arequipa','rosa@gmail',50),
('Maria','30','Arequipa','Arequipa','maria@gmail',25),
('Carlos','19','Arequipa','Arequipa','carlos@gmail',80),
('Ana','35','Arequipa','Castilla','ana@gmail',100),
('Pedro','40','Arequipa','Castilla','pedro@gmail',200),
('Teresa','25','Arequipa','Castilla','teresa@gmail',67),
('Raul','29','Arequipa','Castilla','raul@gmail',200),
('Roxana','45','Arequipa','Islay','roxana@gmail',150),
('Roberto','35','Arequipa','Islay','roberto@gmail',40),
('Sheyla','18','Arequipa','Islay','sheyla@gmail',20)

select * from visitantes2
--5)Con la tabla visitantes2 y aplicando compute, compute by; ver todos los datos y promedio compra


Select * from visitantes2 select avg(montocompra) as promedio from visitantes2;

Select edad,ciudad,montocompra from visitantes2 select avg(edad) as promedioEdad,sum(montocompra) as sumaCompra from visitantes2;

Select nombre,ciudad,provincia from visitantes2 order by provincia,ciudad
select count(provincia) as NumeroProvincias from visitantes2;

Select * from visitantes2 order by provincia,ciudad 
select avg(edad),sum(montocompra) from visitantes2
select avg(montocompra),count(provincia)  from visitantes2;

--6)Oviar registros duplicados con distinct; crear la tabla Libros2 con Primary key(código)

create table libros2(
codigo int identity primary key,
titulo varchar (20),
autor varchar (30),
editorial varchar(15),
precio decimal(6,2)
);

insert into libros2 values
('java','cuba','omega','25.50'),
('python','steve','planeta','30.9'),
('php','molina','planeta','39.66'),
('c++','ceballos','null','27.22'),
('base de datos','martin','null','40.1'),
('assembler','rosello','alfa','20.2'),
('java script','null','alfa','18.3'),
('html','null','paidos','19.4'),
('visual c','molina','paidos','22.5'),
('visual basic','ceballos','emece','24.6'),
('prolog','martin','omega','33.7'),
('lisp','rosello','emece','26.8')
;

--7)Ver registros aplicando distinct:

Select distinct autor from libros2;
Select distinct autor from libros2 where autor is not null;
Select count(distinct autor) from libros2;
Select distinct editorial from libros2;
Select count(distinct editorial) from libros2;
Select distinct autor from libros2 where editorial='Planeta';
Select editorial,count(distinct autor) from libros2 group by editorial;
Select distinct titulo,editorial from libros2 order by titulo;

--8)Clausula top para obtener los primeros n registros

Select top 2 * from libros2;
Select top 3 titulo,autor from libros2 order by autor;
Select top 5 with ties * from libros2 order by autor;

--9)Clave primaria compuesta formada por dos o mas campos. Crear la tabla Playa_Vehiculos , con Primary
--key(placa,horaLlegada)

create table playa_vehiculos(
placa char(8) primary key,
tipo char(1),
horallegada datetime unique,
horasalida datetime
);


insert into playa_vehiculos values
('AH-4068','A','8:00','10:00'),
('V5Q-609','C','9:00','10:10'),
('M7N-666','M','10:00','10:30'),
('AT-4068','A','11:00','11:30'),
('J5Q-369','C','11:15','12:00'),
('M9N-606','M','12:00','12:00'),
('AH-7968','A','01:00','2:00')

--10)Insertar un registro con la misma placa y horaLlegada(tercer registro de la tabla anterior)

insert into playa_vehiculos values
('M7N-666','M','8:00','10:30')
;
--11) Insertar un registro con la misma placa y diferente horaLlegada

insert into playa_vehiculos values
('M7N-666','M','12:45','12:30')

--12)Actualizar un registro con Uddate, repitiendo una clave primaria

update playa_vehiculos set placa='AH-4068'
where placa='V5Q-609'

--13)Insertar un registro con un valor null en hora de llegada

insert into playa_vehiculos values
('V5Q-609','Camioneta','null','null')

--14)Mostrar la estructura de la tabla y verifique la columna IS_NULLABLE

exec sp_columns playa_vehiculos;

/*15)Integridad de datos: Los datos almacenados en las tablas deben ser válidos, coherentes y exactos. Es
por ello que se puede agregar restricciones con el mandato Alter Table a una tabla ya existente usando la
sintaxis: Alter table NOMBRETABLA add constraint NOMBRECONSTRAINT default VALORPORDEFECTO for
NOMBRECAMPO*/

--ver restricciones de la tabla libros2
select * from libros2

exec sp_helpconstraint libros2;

--Agregar una restricción default usando Alter table en libros2

Alter table libros2 add constraint DF_libros2_autor default 'Desconocido' for autor;

--ver restricciones de la tabla libros2

exec sp_helpconstraint libros2;

--Insertar en la tabla libros2 asignar a los campos titulo, editorial los valores Borges,Emece

insert into libros2(titulo,editorial) values('borges','emece');

--Insertar en libros2 default valores

insert into libros2 default values;

--Agregar otra restricción default para el campo precio para que almacene el valor cero

alter table libros add constraint DF_libros_precio default 0 for precio;
--ver los registros almacenados

select * from libros2;

--ver restricciones de la tabla libros2

exec sp_helpconstraint libros2;

--16)Restriccion check:indica los valores que acepta un campo, sintaxis:

--Usar la tabla libros2, y adicionar una restricción para precio

Alter table libros2 add constraint CK_libros2_precio_positivo check (precio>0);

--ver restricciones de la tabla libros2

exec sp_helpconstraint libros2;