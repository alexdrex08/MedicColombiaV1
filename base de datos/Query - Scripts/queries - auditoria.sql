-- control mov por usuario 
SELECT m.id_movimiento_inv, m.fecha_movimiento, u.id_usuario, u.nombre_usu, tm.nombre_movimiento,
       p.nombre_prod, m.cantidad_desplazada, m.motivo_repor
FROM movimiento_prod m
JOIN usuario u ON u.id_usuario = m.usuario_id
JOIN tipo_movimiento tm ON tm.id_tipo_movimiento = m.tipo_movimiento_id
JOIN producto p ON p.id_producto = m.producto_id
WHERE m.fecha_movimiento BETWEEN '2025-10-01' AND '2025-10-31'
ORDER BY m.fecha_movimiento DESC;


-- registros o cambios critcos de alertas y si genereó o no reporte
SELECT a.id_alerta, a.fecha_creacion, a.tipo_alerta, a.descripcion_alerta,
       p.id_producto, p.nombre_prod, ri.id_reporte_inv
FROM alerta_inv a
LEFT JOIN producto p ON p.id_producto = a.producto_id
LEFT JOIN reporte_inv ri ON ri.alerta_inv_id = a.id_alerta
ORDER BY a.fecha_creacion DESC;

-- ultimo movimiento x producto
SELECT p.id_producto, p.nombre_prod, MAX(m.fecha_movimiento) AS ultima_modificacion
FROM producto p
LEFT JOIN movimiento_prod m ON m.producto_id = p.id_producto
GROUP BY p.id_producto, p.nombre_prod
ORDER BY ultima_modificacion DESC;

