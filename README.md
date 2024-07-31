# examen-sql2

*JHON ARLEY ROA SUAREZ*

## consultas basicas

### Consultar todos los productos y sus categorías

```sql
SELECT p.nombre, p.precio_venta, p.stock, p.estado, c.descripcion
FROM productos p
JOIN categorias c USING(id_categoria);
```

### Consultar todas las compras y los clientes que las realizaron

```sql
SELECT cli.nombre, c.fecha, c.medio_pago, c.comentario 
FROM compras AS c
JOIN clientes AS cli USING(id_cliente);
```

### Consultar los productos comprados en una compra específica

```sql
SELECT com.id_compra, p.nombre, p.precio_venta, p.estado
FROM compras com
JOIN compras_producto USING(id_compra)
JOIN productos p USING(id_producto)
WHERE com.id_compra = 1;
```

### Agregar un nuevo producto

```sql
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, stock, estado)
VALUES ('Tablet', 1, '98217694323', 700.00, 100, 'A');
```

### Actualizar el stock de un producto

```sql
UPDATE productos
SET stock = stock - 10
WHERE id_producto = LAST_INSERT_ID();
```

### Consultar todas las compras de un cliente específico

```sql
SELECT c.id_compra, c.fecha, c.medio_pago, c.comentario 
FROM compras c
JOIN clientes cli USING(id_cliente)
WHERE cli.id_cliente = 'CLI001';
```

### Consultar todos los clientes y sus correos electrónicos

```sql
SELECT CONCAT(nombre, ' ', apellido) AS cliente,
correo
FROM clientes;
```

### Consultar la cantidad total de productos comprados en cada compra

```sql
SELECT com.id_compra, COUNT(*) AS total_comprado
FROM compras com
JOIN compras_producto USING(id_compra)
JOIN productos USING(id_producto)
GROUP BY com.id_compra;
```

### Consultar las compras realizadas en un rango de fechas

```sql
SELECT c.id_compra, c.fecha, c.medio_pago, c.comentario 
FROM compras c
WHERE c.fecha BETWEEN '2022-01-01' AND '2022-01-10';
```

## Consultas usando funciones agregadas

### Contar la cantidad de productos por categoría

```sql
SELECT cat.descripcion, COUNT(*) AS total_productos
FROM categorias cat
JOIN productos USING(id_categoria)
GROUP BY cat.descripcion;
```

### Calcular el precio total de ventas por cada cliente

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, SUM(cp.total) AS total_gastado
FROM clientes cli 
JOIN compras USING(id_cliente)
JOIN compras_producto AS cp USING(id_compra)
GROUP BY cli.id_cliente;
```

### Calcular el precio promedio de los productos por categoría

```sql
SELECT cat.descripcion, AVG(p.precio_venta) AS promedio_categoria
FROM categorias AS cat
JOIN productos AS p USING(id_categoria)
GROUP BY cat.descripcion;
```

### Encontrar la fecha de la primera y última compra registrada

```sql
SELECT c.id_compra, c.fecha, c.medio_pago, c.comentario
FROM compras AS c
WHERE c.fecha = (SELECT MIN(fecha) FROM compras)
OR c.fecha = (SELECT MAX(fecha) FROM compras)
ORDER BY c.fecha;
```

### Calcular el total de ingresos por ventas

```sql
SELECT c.id_compra, SUM(cp.total) AS total_ingresos
FROM compras_producto AS cp 
JOIN compras AS c USING(id_compra)
GROUP BY c.id_compra;
```

### Contar la cantidad de compras realizadas por cada medio de pago

```sql
SELECT c.medio_pago, COUNT(*)
FROM compras AS c
GROUP BY c.medio_pago;
```

### Calcular el total de productos vendidos por cada producto

```sql
SELECT p.id_producto, p.nombre, SUM(cp.cantidad) AS total_vendido
FROM productos AS p
JOIN compras_producto AS cp USING(id_producto)
GROUP BY p.id_producto, p.nombre;
```

### Obtener el promedio de cantidad de productos comprados por compra

```sql
SELECT AVG(cp.cantidad) AS promedio_comprado
FROM compras_producto AS cp
JOIN compras AS c USING(id_compra);
```

### Encontrar los productos con el stock más bajo

```sql
SELECT p.nombre, p.precio_venta, p.stock, p.estado
FROM productos AS p
ORDER BY p.stock
LIMIT 3;
```

### Calcular el total de productos comprados y el total gastado por cliente

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, SUM(cp.total) AS total_gastado, COUNT(*)
FROM compras AS c
JOIN clientes AS cli USING(id_cliente)
JOIN compras_producto AS cp USING(id_compra)
GROUP BY cli.id_cliente, cli.nombre, cli.apellido;
```

## Consultas usando join

### Consultar todos los productos con sus categorías

```sql
SELECT p.nombre, p.precio_venta, p.stock, p.estado, c.descripcion
FROM productos p
JOIN categorias c USING(id_categoria);
```

### consultar todas las compras y los clientes que las realizaron

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, DATE(c.fecha) AS fecha, c.comentario
FROM compras AS c
JOIN clientes AS cli USING(id_cliente);
```

### Consultar los productos comprados en cada compra

```sql
SELECT c.id_compra, DATE(c.fecha) AS fecha, c.comentario, p.nombre
FROM compras AS c
JOIN compras_producto USING(id_compra)
JOIN productos AS p USING(id_producto)
ORDER BY c.id_compra;
```

### Consultar las compras realizadas por un cliente específico

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, DATE(c.fecha) AS fecha, c.comentario
FROM compras AS c
JOIN clientes AS cli USING(id_cliente)
WHERE cli.id_cliente = 'CLI001';
```

### Consultar el total gastado por cada cliente

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, SUM(cp.total) AS total_gastado
FROM clientes cli 
JOIN compras USING(id_cliente)
JOIN compras_producto cp USING(id_compra)
GROUP BY cli.id_cliente;
```

### Consultar el stock disponible de productos y su categoría

```sql
SELECT p.id_producto, p.nombre, p.stock, c.descripcion
FROM productos AS p
JOIN categorias AS c USING(id_categoria)
ORDER BY p.id_producto;
```

### Consultar los detalles de compras junto con la información del cliente y el producto

```sql
SELECT c.id_compra, cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, p.id_producto, p.nombre, cp.cantidad, cp.total
FROM productos AS p
JOIN compras_producto AS cp USING(id_producto)
JOIN compras AS c USING(id_compra)
JOIN clientes AS cli USING(id_cliente)
ORDER BY c.id_compra;
```

### Consultar los productos que han sido comprados por más de una cantidad específica

```sql
SELECT DISTINCT p.id_producto, p.nombre
FROM productos AS p
JOIN compras_producto AS cp USING(id_producto)
WHERE cp.cantidad >= 2
ORDER BY p.id_producto DESC;
```

### Consultar la cantidad total de productos vendidos por categoría

```sql
SELECT cat.descripcion, SUM(cp.cantidad) AS cantidad_vendida
FROM categorias AS cat
JOIN productos AS p USING(id_categoria)
JOIN compras_producto AS cp USING(id_producto)
GROUP BY cat.descripcion;
```

### Consultar los clientes que han realizado compras en un rango de fechas específico

```sql
SELECT DISTINCT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente
FROM clientes AS cli
JOIN compras AS c USING(id_cliente)
WHERE c.fecha BETWEEN '2022-01-01' AND '2022-01-10';
```

### Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, SUM(cp.total) AS total_gastado, COUNT(*)
FROM compras AS c
JOIN clientes AS cli USING(id_cliente)
JOIN compras_producto AS cp USING(id_compra)
GROUP BY cli.id_cliente, cli.nombre, cli.apellido;
```

### Consultar los productos que nunca han sido comprados

```sql
SELECT p.id_producto, p.nombre 
FROM productos AS p
LEFT JOIN compras_producto AS cp USING(id_producto)
WHERE cp.id_producto IS NULL;
```

### Consultar los clientes que han realizado más de una compra y el total gastado por ellos

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, SUM(cp.total) AS total_gastado
FROM compras AS c
JOIN clientes AS cli USING(id_cliente)
JOIN compras_producto AS cp USING(id_compra)
GROUP BY cli.id_cliente, cli.nombre, cli.apellido
HAVING COUNT(*) > 1;
```

### Consultar los productos más vendidos por categoría

```sql
SELECT cat.descripcion AS categoria, p.nombre AS producto, SUM(cp.cantidad) AS cantidad_vendida
FROM compras_producto AS cp
JOIN productos AS p USING(id_producto)
JOIN categorias AS cat USING(id_categoria)
GROUP BY cat.descripcion, p.nombre
ORDER BY cat.descripcion, cantidad_vendida DESC;
```

### Consultar las compras realizadas por clientes de una ciudad específica y el total gastado

```sql
SELECT cli.id_cliente, CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, c.id_compra, SUM(cp.total) AS total_gastado
FROM compras AS c
JOIN clientes AS cli USING(id_cliente)
JOIN ciudades AS ci USING(id_ciudad)
JOIN compras_producto AS cp USING(id_compra)
WHERE ci.nombre = 'ciudad 1'
GROUP BY cli.id_cliente, cli.nombre, cli.apellido, c.id_compra;
```

### Consultar los proveedores que han suministrado productos y la cantidad total suministrada

```sql
SELECT pro.nombre, SUM(p.stock) AS cantidad_suministrada
FROM proveedores AS pro
JOIN productos AS p USING(id_proveedor)
GROUP BY pro.nombre;
```

## Subconsultas

### Consultar los productos que tienen un precio de venta superior al precio promedio de todos los productos

```sql
SELECT p.id_producto, p.nombre, p.precio_venta
FROM productos AS p
WHERE p.precio_venta > (SELECT AVG(precio_venta) FROM productos);
```

### Consultar los clientes que han gastado más del promedio general en sus compras

```sql
SELECT 
  cli.id_cliente, 
  CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, 
  SUM(cp.total) AS total_gastado
FROM 
  clientes AS cli
  JOIN compras AS c USING(id_cliente)
  JOIN compras_producto AS cp USING(id_compra)
GROUP BY 
  cli.id_cliente, cli.nombre, cli.apellido
HAVING 
  SUM(cp.total) > (SELECT AVG(total_gastado) FROM (
    SELECT id_cliente, SUM(cp.total) AS total_gastado
    FROM compras AS c
    JOIN compras_producto AS cp USING(id_compra)
    GROUP BY id_cliente
  ) AS subconsulta);
```

### Consultar las categorías que tienen más de 5 productos

```sql
SELECT c.descripcion, 
       (SELECT COUNT(*) 
        FROM productos p 
        WHERE p.id_categoria = c.id_categoria) AS cantidad_productos
FROM categorias c
WHERE (SELECT COUNT(*) 
       FROM productos p 
       WHERE p.id_categoria = c.id_categoria) > 5;
```

### Consultar los productos más vendidos (top 5) por categoría

```sql
SELECT c.descripcion AS categoria, p.nombre AS producto, SUM(cp.cantidad) AS cantidad_vendida
FROM  categorias c
JOIN productos p USING(id_categoria)
JOIN compras_producto cp USING(id_producto)
GROUP BY c.descripcion, p.nombre
ORDER BY c.descripcion, SUM(cp.cantidad) DESC
LIMIT 5;
```

### Consultar los clientes que han realizado compras en los últimos 30 días

```sql
SELECT cli.nombre, c.id_compra, c.fecha, c.medio_pago, c.comentario
FROM compras AS c
JOIN clientes AS cli USING(id_cliente)
WHERE c.fecha > (SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
ORDER BY c.fecha;
```

### Consultar las compras y sus productos para un cliente específico, mostrando solo las compras más recientes

```sql
SELECT 
  cli.id_cliente, 
  CONCAT(cli.nombre, ' ', cli.apellido) AS cliente, 
  c.id_compra, 
  (SELECT GROUP_CONCAT(p.nombre, ' ') 
   FROM compras_producto AS cp 
   JOIN productos AS p USING(id_producto) 
   WHERE cp.id_compra = c.id_compra) AS productos
FROM 
  compras AS c
  JOIN clientes AS cli USING(id_cliente)
WHERE 
  cli.id_cliente = 'CLI001'
ORDER BY 
  c.fecha DESC
LIMIT 3;
```

### Consultar las categorías que tienen productos con un stock por debajo del promedio general

```sql
SELECT DISTINCT c.descripcion AS categoria
FROM categorias AS c
JOIN productos AS p ON c.id_categoria = p.id_categoria
WHERE p.stock < (SELECT AVG(stock) FROM productos);
```

### Consultar los productos que han sido comprados por todos los clientes

```sql
SELECT p.nombre AS producto
FROM productos AS p
JOIN compras_producto AS cp USING(id_producto)
JOIN compras AS c USING(id_compra)
JOIN clientes AS cli USING(id_cliente)
GROUP BY p.nombre
HAVING COUNT(cli.id_cliente) = (SELECT COUNT(*) FROM clientes);
```

### Consultar las compras que tienen más productos que el promedio de productos por compra

```sql 
SELECT 
    c.id_compra, 
    SUM(cp.cantidad) AS cantidad_productos
FROM 
    compras AS c
    JOIN compras_producto AS cp USING(id_compra)
GROUP BY 
    c.id_compra
HAVING
    SUM(cp.cantidad) > (SELECT AVG(cantidad_productos) FROM (
        SELECT c.id_compra, SUM(cp.cantidad) AS cantidad_productos
        FROM compras AS c
        JOIN compras_producto AS cp USING(id_compra)
        GROUP BY c.id_compra
    ) AS subquery);
```

### Consultar los productos que se han vendido menos de la cantidad promedio de productos vendidos

```sql
SELECT 
    p.nombre, 
    SUM(cp.cantidad) AS cantidad_vendida
FROM 
    productos AS p
    JOIN compras_producto AS cp USING(id_producto)
GROUP BY 
    p.nombre
HAVING 
    SUM(cp.cantidad) < (SELECT AVG(cantidad_vendida) FROM(
        SELECT p.nombre, SUM(cp.cantidad) AS cantidad_vendida
        FROM productos AS p
        JOIN compras_producto AS cp USING(id_producto)
        GROUP BY p.nombre
    ) AS subquery);
```