--1)Restricción Unique (UQ_TABLA_CAMPO): impide la duplicidad de claves alternas o no primarias, en uno o más campos, acepta
--null; se usa para asegurarse que otros datos de campos sean únicos p. e. DNI; ejecutar:
--Eliminar la tabla Alumnos si existe

if object_id('usuarios') is not null
drop table usuarios;

--Crear la tabla Alumnos e ingresarle datos:

create table alumnos(
ficha char(4) not null,
apellido varchar(20),
nombre varchar(20),
dni varchar(8),
domicilio varchar(30),
ciudad varchar(30),
notaFinal decimal(4,2)
);

--insertamos los datos en la tabla Alumnos

insert into Alumnos values 
('F100','Flores','Pedro','29334647','Av. Pizarro 130','Arequipa',14),
('F101','Castro','Lucero','28344546','Av. El sol','Arequipa',15)

--Agregar la restricción primary key al campo ficha

Alter table alumnos add constraint PK_alumnos_ficha Primary key(ficha);

--Agregar una restricción unique para el campo dni

Alter table alumnos add constraint UQ_alumnos_dni unique(dni);

--Agregamos una restricción check al campo notaFinal para que admita notas de 0..20

Alter table alumnos add constraint CK_alumnos_nota check (notaFinal>=0 and notaFinal<=20);

--Agregar una restricción default para el campo ciudad

Alter table alumnos add constraint DF_alumnos_ciudad default 'Arequipa' for ciudad;

--Insertar dos registros mas

insert into alumnos values 
('F102','Gamusa','Auyreliano','37918548','Av. Peru 58','Arequipa',14),
('F103','Vermejo','Lucas','27968438','Av. Los marines','Arequipa',15)

--consultar y mostrar todos los registros

select * from alumnos

--ver todas las restricciones    

exec sp_helpconstraint alumnos;

--desabilitar restricción check

Alter table alumnos nocheck constraint CK_alumnos_nota;

--ver todas las restricciones

exec sp_helpconstraint alumnos;

--eliminar restricciones (alter table TABLA drop RESTRICCION)

alter table TABLA drop RESTRICCION

--eliminar restricción default de ciudad

Alter table alumnos drop DF_alumnos_ciudad;

--ver todas las restricciones

exec sp_helpconstraint alumnos;

--eliminar restricicon check

--ver todas las restricciones

--2)Crear Regla (créate rule NOMBREREGLA as @VARIABLE CONDICION ) una regla especifica los valores de entrada a un
--campo, las reglas son objetos independientes de la tabla, si se elimina una tabla la regla queda, por ello borrar la regla con drop
--Asociar Reglas (exec sp_bindrule NOMBREREGLA, ‘TABLA.CAMPO’) La ejecución de este procedimiento almacenado permite
--asociar la regla a un campo

--eliminar la regla si existe asociada a alumnos.dni

If object_id('RG_dni_patron') is not null drop rule RG_dni_patron;

--crear una regla para dni

create rule RG_dni_patron as @valdni like '[0-9] [0-9] [0-9] [0-9] [0-9] [0-9] [0-9] [0-9]';
--ver si la regla fue creada

Sp_help;

--ver si la regla esta asociada a algún campo de alumnos

Sp_helpconstraint alumnos;

--insertar un registro con dni= 22bb3388

insert into alumnos values 
('F104','Margoro','Gabriela','22bb3388','Av. EEUU','Arequipa',18)

--asociar la regla al campo dni

Exec sp_bindrule RG_dni_patron, 'alumnos.dni';

--ver si la regla esta asociada a algún campo de alumnos

Sp_helpconstraint alumnos;

--insertar un registro con dni= 22bc3389

insert into alumnos values 
('F105','Alvarado','Ferderico','22bc3389','Av. lima','Cusco',18)


--insertar un registro con dni= 22113287

insert into alumnos values 
('F106','Margoro','Gabriela','22bc3389','Av. EEUU','Arequipa',18)

--ver todos los registros

select * from alumnos

--3)Crear valores predeterminados (créate default): estos se asocian con uno o varios campos o tipos de datos definidos por el
--usuario sintaxis: créate default NOMBREVALORPREDETERMINADO as VALORPREDETERMINADO.
--Asociar el valor predeterminado a un campo, sintaxis: exec sp_bindefault VP_NOMBREVALPRE, ‘tabla.campo’;
--crear valor prederminado para dni 00000000

create default VP_dni as '00000000';

--asociar el valor prederminado al campo dni de la tabla alumnos

Exec sp_bindefault VP_dni, 'alumnos.dni';

--insertar un registro con valores default



--ver si VP_dni existe


--ver los valores predeterminados asociados

Sp_helpconstraint alumnos;

--ver todos los registros



--ver el texto del valor

Sp_helptext VP_dni;

--ver todos los objetos de la base de datos

Sp_help;

--desasociar un valor con: sp_unbindefault ‘TABLA.CAMPO’;

--eliminar el valor predeterminado con : drop default VP_NOMBREVALPRED
