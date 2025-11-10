DELIMITER //
CREATE PROCEDURE registrar_venta(
    IN p_cliente_id INT,
    IN p_usuario_id INT,
    IN p_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO venta_registro (cliente_id, usuario_id, fecha_venta, total_venta)
    VALUES (p_cliente_id, p_usuario_id, NOW(), p_total);
END //
DELIMITER ;