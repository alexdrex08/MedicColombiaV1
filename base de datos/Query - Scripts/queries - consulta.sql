-- productos próximos a vencer. 
SELECT id_producto, nombre_prod, fecha_expiracion, stock
FROM producto
WHERE fecha_expiracion BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 30 DAY)
ORDER BY fecha_expiracion ASC;

-- Stock bajo, segun lo establecido 
SELECT id_producto, nombre_prod, stock
FROM producto
WHERE stock <= 10
ORDER BY stock ASC;


-- detalle de un pedido y stock pendiente
SELECT dp.id_detalle_pedido, dp.producto_id, p.nombre_prod, dp.cantidad, dp.precio_unitario,
       (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedido dp
JOIN producto p ON p.id_producto = dp.producto_id
WHERE dp.pedido_compra_id = 2; -- reemplazar " " por id_pedido a consultar

-- pedidos en camino + fecha estimada
SELECT pc.id_pedido, pc.fecha_pedido,
       DATE_ADD(pc.fecha_pedido, INTERVAL 3 DAY) AS fecha_estimada,
       pc.total_pedido, pr.nombre_prov, ep.nombre_estado
FROM pedido_compra pc
JOIN proveedor pr ON pr.id_proveedor = pc.proveedor_id
JOIN estado_pedido ep ON ep.id_estado_pedido = pc.estado_pedido_id
WHERE ep.nombre_estado = 'En camino'
ORDER BY fecha_estimada ASC;

-- ultimas X ventas por cliente
SELECT vr.id_venta, vr.fecha_venta, vr.total_venta, c.id_cliente, c.nombre_cliente
FROM venta_registro vr
LEFT JOIN cliente c ON c.id_cliente = vr.cliente_id
ORDER BY vr.fecha_venta DESC
LIMIT 20; -- Reemplazar " " por el numero limite de registros de ventas a mostrar. 

-- Detalle mas minucioso de una venta 
SELECT vr.id_venta, vr.fecha_venta, vr.total_venta, c.nombre_cliente,
       dv.id_detalle_venta, dv.producto_id, p.nombre_prod, dv.cantidad, dv.precio_unitario,
       (dv.cantidad * dv.precio_unitario) AS subtotal
FROM venta_registro vr
JOIN detalle_venta dv ON dv.venta_registro_id = vr.id_venta
JOIN producto p ON p.id_producto = dv.producto_id
LEFT JOIN cliente c ON c.id_cliente = vr.cliente_id
WHERE vr.id_venta = 1; -- reemplazar " " por el id de la venta a consultar. 

-- control de movimientos de los productos
SELECT m.id_movimiento_inv, m.fecha_movimiento, p.id_producto, p.nombre_prod,
       tm.nombre_movimiento AS tipo_mov, m.cantidad_desplazada, u.nombre_usu AS usuario
FROM movimiento_prod m
JOIN producto p ON p.id_producto = m.producto_id
JOIN tipo_movimiento tm ON tm.id_tipo_movimiento = m.tipo_movimiento_id
LEFT JOIN usuario u ON u.id_usuario = m.usuario_id
WHERE m.fecha_movimiento BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY m.fecha_movimiento DESC;

-- stock proyectado (inventario + en transito)
SELECT p.id_producto, p.nombre_prod, p.stock AS stock_actual,
       IFNULL(SUM(dp.cantidad),0) AS cantidad_en_pedidos_en_camino,
       (p.stock + IFNULL(SUM(dp.cantidad),0)) AS stock_proyectado
FROM producto p
LEFT JOIN detalle_pedido dp ON dp.producto_id = p.id_producto
LEFT JOIN pedido_compra pc ON pc.id_pedido = dp.pedido_compra_id
LEFT JOIN estado_pedido ep ON ep.id_estado_pedido = pc.estado_pedido_id AND ep.nombre_estado = 'En camino'
WHERE ep.nombre_estado = 'En camino' OR ep.nombre_estado IS NULL
GROUP BY p.id_producto, p.nombre_prod, p.stock
ORDER BY stock_proyectado ASC;

-- busqueda parcial de producto
SELECT id_producto, nombre_prod, stock, fecha_expiracion
FROM producto
WHERE nombre_prod LIKE CONCAT('%', 500, '%') -- reemplazar " " por el nombre "aproximado" del producto.
ORDER BY nombre_prod;









