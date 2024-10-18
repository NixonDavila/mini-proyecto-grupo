
#Eidrian y Nixon

create database Empresa;

use Empresa;

create table Provedores(
 id_provedores INT AUTO_INCREMENT PRIMARY KEY,
 nombre_provedor varchar(100) not null,
 correo_provedor varchar(100) not null,
 telefono int not null,
 direccion varchar(100)
);


create table Categorias(
id_categorias INT AUTO_INCREMENT PRIMARY KEY,
nombre_categoria varchar(100) not null
);


create table Productos(
 id_productos INT AUTO_INCREMENT PRIMARY KEY,
 nombre_producto varchar(100) not null,
 descripcion varchar(200) not null,
 stok int not null ,
 precio int not null,
 id_provedores int ,
 id_categorias INT ,
 foreign key (id_provedores) references Provedores(id_provedores) ON DELETE SET NULL ,
 foreign key (id_categorias) references Categorias(id_categorias) ON DELETE SET NULL 
);


create table Clientes(
 id_clientes INT AUTO_INCREMENT PRIMARY KEY,
 nombre_cliente varchar(100) not null,
 correo varchar(100) not null,
 direccion varchar(100) not null,
 telefono int not null
);


create table Ventas(
 id_Ventas INT AUTO_INCREMENT PRIMARY KEY,
 fecha_ventas TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 id_clientes int ,
 foreign key  (id_clientes) references Clientes(id_clientes) ON DELETE SET NULL 
);

create table Detalles_Ventas(
id_detalle_venas INT AUTO_INCREMENT PRIMARY KEY,
id_ventas int ,
id_productos int,
precio_total int not null,
foreign key(id_productos) references Productos(id_productos) on delete set null,
foreign key(id_ventas) references Ventas(id_ventas)
);



-- Insertar en la tabla Provedores
INSERT INTO Provedores (nombre_provedor, correo_provedor, telefono, direccion)
VALUES 
('Jeffry', 'jefito@mail.com', 123456789, 'Fray Casiano'),
('Jenny', 'jenny@mail.com', 987654321, 'Roble'),
('Alejandro', 'ale@mail.com', 456123789, 'Esparza'),
('Jorge', 'jorelui@mail.com', 789456123, 'Santa Eduviges'),
('Reynol', 'Reyrey@mail.com', 321654987, 'Puntarenas');

-- Insertar en la tabla Categorias
delimiter $$
create procedure categoriaInsertar (in nombre varchar(100))
begin
 insert into categorias(nombre_categoria) values (nombre);
end $$
delimiter ;
call categoriaInsertar("videojuegos");

select * from categorias;

INSERT INTO Categorias (nombre_categoria)
VALUES 
('Cuidado personal'),
('Electronica'),
('Muebles'),
('Hogar'),
('Deportes');

-- Insertar en la tabla Productos

INSERT INTO Productos (nombre_producto, descripcion, stok, precio, id_provedores, id_categorias)
VALUES 
('Cepillo eléctrico', ' Cepillo de dientes eléctrico con 3 modos de cepillado ', 100, 40, 1, 1),
('Auriculares', ' Auriculares inalámbricos con cancelación de ruido ', 50, 420, 1, 2),
('Silla ergonómica ', 'Silla de oficina ergonómica con ajuste personalizado', 75, 1000, 2, 3),
('Sofá inflable ', ' Sofá inflable para dos personas', 120, 60, 2, 3),
('Tira LED inteligente', 'Tira de luces LED RGB, controlable por app', 80, 70, 3, 2),
('Cafetera Nespresso', ' Cafetera de cápsulas', 30, 149, 3, 4),
('Reloj inteligente ', ' Pulsera de actividad con monitoreo de frecuencia cardíaca', 30, 130, 4, 5),
('Termo Stanley', 'Termo de acero inoxidable de 1 litro', 30, 50, 4, 1),
('Guantes de futboll', 'Guantes de portero profecinal', 30, 50, 5, 5),
('Balon de futboll', 'diseñada para tener un alto rendimiento', 30, 60, 5, 5);


-- Insertar en la tabla Clientes

INSERT INTO Clientes (nombre_cliente, correo, direccion, telefono)
VALUES 
('jose', 'jdaniel@mail.com', 'Esparza', 123123123),
('Leonidas', 'leo@mail.com', 'Esparta', 321321321),
('Aquiles', 'quiles@mail.com', ' Ciudad de Tesalia', 456456456),
('Heracles', 'zeusSon@mail.com', 'Ciudad de Tebas', 654654654),
('Temistocles', 'temis@mail.com', 'Ciudad de Atenas', 789789789);

-- Insertar en la tabla Ventas
select * from ventas;
INSERT INTO Ventas (id_clientes , fecha_ventas)
VALUES 
(1 , '2024-02-15'),
(2 , '2024-04-03'),
(3 , '2024-06-21'),
(4 , '2024-07-08'),
(1 , '2024-09-17'),
(2 , '2024-10-27'),
(3 , '2024-11-02'),
(4 , '2024-05-11'),
(4 , '2024-03-25'),
(5 , '2024-08-19');

-- Insertar en la tabla Detalles_Ventas

INSERT INTO Detalles_Ventas (id_ventas, id_productos, precio_total,cantidad_productos)
VALUES 
(11, 2,840,2),
(11, 1,80,2),
(12, 3, 1000,1),
(12, 9,50,1),
(14, 5, 70,1),
(14, 4,130,2),
(15, 8, 50,1),
(15, 6, 149,1),
(14, 7, 130,1),
(11, 10, 60,1);


SELECT Productos.nombre_producto, Categorias.nombre_categoria, Provedores.nombre_provedor, COUNT(V.id_ventas) AS LibroVendido FROM Ventas V
JOIN productos productos ON V.id_clientes = Productos.id_productos
JOIN Categorias Categorias ON Productos.id_categorias = Categorias.id_categorias
JOIN provedores provedores ON Productos.id_provedores = Provedores.id_provedores
WHERE MONTH(V.fecha_ventas) = 09
GROUP BY Productos.id_productos;



SELECT * FROM Ventas;
SELECT ventas.id_clientes, COUNT(Ventas.id_ventas) AS Ventas FROM Ventas Ventas
JOIN clientes cliente ON Ventas.id_clientes = cliente.id_clientes
GROUP BY cliente.id_clientes asc;








select * from detalles_ventas;
select * from ventas;

delimiter $$
create procedure obtener_ventas_totales(in venta_fecha timestamp)
begin
 SELECT Productos.nombre_producto, Categorias.nombre_categoria, Provedores.nombre_provedor, COUNT(V.id_ventas) AS VentaTotal FROM Ventas V
	JOIN productos productos ON V.id_clientes = Productos.id_productos
	JOIN Categorias Categorias ON Productos.id_categorias = Categorias.id_categorias
	JOIN provedores provedores ON Productos.id_provedores = Provedores.id_provedores
	WHERE MONTH(V.fecha_ventas) = venta_fecha
GROUP BY Productos.id_productos;
end $$
delimiter ;

call obtener_ventas_totales(6)


