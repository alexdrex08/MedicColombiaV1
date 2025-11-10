-- top X productos mas facturados 
SELECT dv.producto_id, p.nombre_prod, SUM(dv.cantidad) AS total_vendido
FROM detalle_venta dv
JOIN producto p ON p.id_producto = dv.producto_id
GROUP BY dv.producto_id, p.nombre_prod
ORDER BY total_vendido DESC
LIMIT 10; -- X

-- venta x fecha x cliente
SELECT c.id_cliente, c.nombre_cliente, COUNT(vr.id_venta) AS numero_ventas,
       SUM(vr.total_venta) AS total_facturado
FROM venta_registro vr
JOIN cliente c ON c.id_cliente = vr.cliente_id
WHERE vr.fecha_venta BETWEEN '2025-01-01' AND '2025-10-31' -- modificable
GROUP BY c.id_cliente, c.nombre_cliente
ORDER BY total_facturado DESC;

-- venta mensual
SELECT DATE_FORMAT(fecha_venta, '%Y-%m') AS mes, COUNT(id_venta) AS ventas_count,
       SUM(total_venta) AS total_mes
FROM venta_registro
WHERE fecha_venta BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY mes
ORDER BY mes;

-- stock merma
SELECT id_producto, nombre_prod, stock, fecha_expiracion
FROM producto
WHERE fecha_expiracion < NOW()
ORDER BY fecha_expiracion ASC;

-- valor total x pedido
SELECT pc.id_pedido, pr.nombre_prov, SUM(dp.cantidad * dp.precio_unitario) AS total_valor
FROM pedido_compra pc
JOIN detalle_pedido dp ON dp.pedido_compra_id = pc.id_pedido
JOIN proveedor pr ON pr.id_proveedor = pc.proveedor_id
GROUP BY pc.id_pedido, pr.nombre_prov
ORDER BY total_valor DESC;

-- infor proveedor - pedido
SELECT pr.id_proveedor, pr.nombre_prov, SUM(dp.precio_unitario * dp.cantidad) AS costo_historial
FROM proveedor pr
LEFT JOIN pedido_compra pc ON pc.proveedor_id = pr.id_proveedor
LEFT JOIN detalle_pedido dp ON dp.pedido_compra_id = pc.id_pedido
GROUP BY pr.id_proveedor, pr.nombre_prov
ORDER BY costo_historial DESC;










