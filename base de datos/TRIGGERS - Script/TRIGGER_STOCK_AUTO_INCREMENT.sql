DELIMITER //
CREATE TRIGGER trg_actualizar_stock_pedido
AFTER UPDATE ON pedido_compra
FOR EACH ROW
BEGIN
  IF NEW.estado_pedido_id = 3 THEN
    UPDATE producto
    SET stock = stock + (
      SELECT SUM(dp.cantidad)
      FROM detalle_pedido dp
      WHERE dp.pedido_id = NEW.id_pedido
    )
    WHERE id_producto IN (
      SELECT producto_id
      FROM detalle_pedido
      WHERE pedido_id = NEW.id_pedido
    );
  END IF;
END //
DELIMITER ;