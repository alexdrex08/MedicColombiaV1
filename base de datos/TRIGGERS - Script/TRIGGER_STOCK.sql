DELIMITER //
CREATE TRIGGER trg_disminuir_stock_venta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
  UPDATE producto
  SET stock = stock - NEW.cantidad
  WHERE id_producto = NEW.producto_id;
END //
DELIMITER ;
