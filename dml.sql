-- Insert data into ciudades table
INSERT INTO ciudades(nombre)
VALUES ('ciudad 1'),
('ciudad 2'),
('ciudad 3');

-- Insert data into clientes table
INSERT INTO clientes (id_cliente, nombre, apellido, celular, direccion, correo, id_ciudad)
VALUES
('CLI001', 'John', 'Doe', '123456789', '123 Main St', 'john.doe@example.com', 1),
('CLI002', 'Jane', 'Doe', '987654321', '456 Elm St', 'jane.doe@example.com', 2),
('CLI003', 'Bob', 'Smith', '555123456', '789 Oak St', 'bob.smith@example.com', 3);

-- Insert data into categorias table
INSERT INTO categorias (descripcion)
VALUES
('Electronics'),
('Clothing'),
('Home Goods');

-- Insert data into proveedores table
INSERT INTO proveedores (id_proveedor, nombre, direccion, telefono, correo, id_ciudad)
VALUES ( 'PROV001', 'Proveedor Uno', 'Calle 123', '1234567890', 'proveedor1@example.com', 1),
('PROV002', 'Proveedor Dos', 'Calle 456', '987654', 'proveedor2@example.com', 2);

-- Insert data into productos table
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, stock, estado, id_proveedor)
VALUES
('Smartphone', 1, '1234567890123', 500.00, 10, 'A', 'PROV001'),
('T-Shirt', 2, '9876543210987', 20.00, 50, 'A', 'PROV002'),
('Coffee Table', 3, '5551234567890', 100.00, 5, 'A', 'PROV001'),
('Laptop', 1, '1112223334445', 1000.00, 5, 'A', 'PROV001'),
('Dress', 2, '6667778889990', 50.00, 20, 'A', 'PROV001'),
('TV', 1, '4445556667778', 800.00, 10, 'A', 'PROV002');

-- Insert data into compras table
INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado)
VALUES
('CLI001', '2022-01-01 12:00:00', 'C', 'First purchase', 'A'),
('CLI002', '2022-01-15 14:00:00', 'P', 'Second purchase', 'A'),
('CLI003', '2022-02-01 10:00:00', 'C', 'Third purchase', 'A');

-- Insert data into compras_producto table
INSERT INTO compras_producto (id_compra, id_producto, cantidad, total)
VALUES
(1, 1, 2, 1000.00),
(1, 3, 1, 100.00),
(2, 2, 3, 60.00),
(2, 4, 1, 1000.00),
(3, 5, 2, 100.00),
(3, 6, 1, 800.00);