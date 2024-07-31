DROP DATABASE IF EXISTS compra_productos;
CREATE DATABASE compra_productos;
USE compra_productos;

CREATE TABLE ciudades (
    id_ciudad INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    CONSTRAINT pk_id_ciudad PRIMARY KEY (id_ciudad)
);

CREATE TABLE clientes (
    id_cliente VARCHAR(20),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    celular VARCHAR(20),
    direccion VARCHAR(50),
    id_ciudad INT,
    correo VARCHAR(100) UNIQUE,
    CONSTRAINT pk_id_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT fk_id_ciudad FOREIGN KEY (id_ciudad) 
    REFERENCES ciudades(id_ciudad)
);

CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT,
    id_cliente VARCHAR(20),
    fecha DATETIME,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),
    CONSTRAINT pk_id_compra PRIMARY KEY (id_compra),
    CONSTRAINT fk_id_cliente_compras FOREIGN KEY (id_cliente)
    REFERENCES clientes(id_cliente)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT,
    descripcion VARCHAR(45),
    CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE proveedores (
    id_proveedor VARCHAR(50),
    nombre VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100) UNIQUE,
    id_ciudad INT,
    CONSTRAINT pk_id_proveedor PRIMARY KEY (id_proveedor),
    CONSTRAINT fk_id_ciudad_proveedor FOREIGN KEY (id_ciudad)
    REFERENCES ciudades(id_ciudad)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(45),
    id_categoria INT,
    id_proveedor VARCHAR(50),
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL (16,2),
    stock INT,
    estado CHAR(1),
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_categoria_productos FOREIGN KEY (id_categoria)
    REFERENCES categorias(id_categoria),
    CONSTRAINT fk_id_proveedor_productos FOREIGN KEY (id_proveedor)
    REFERENCES proveedores(id_proveedor)
);

CREATE TABLE compras_producto (
    id_compra INT,
    id_producto INT,
    cantidad INT,
    total DECIMAL(16,2),
    CONSTRAINT pk_id_compra_producto PRIMARY KEY (id_compra, id_producto),
    CONSTRAINT fk_id_compra_compras_producto FOREIGN KEY (id_compra)
    REFERENCES compras(id_compra),
    CONSTRAINT fk_id_poducto_compras_producto FOREIGN KEY (id_producto)
    REFERENCES productos(id_producto)
);