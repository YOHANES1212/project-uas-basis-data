-- 3_triggers_and_functions.sql
USE foodhall;
DELIMITER $$

CREATE TRIGGER trg_check_item_available
BEFORE INSERT ON OrderItem
FOR EACH ROW
BEGIN
  DECLARE available BOOLEAN DEFAULT TRUE;
  SELECT is_available INTO available FROM MenuItem WHERE item_id = NEW.item_id;
  IF available = FALSE THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Item not available';
  END IF;
END$$

CREATE PROCEDURE finalize_order (IN p_order_id INT, IN p_paid DECIMAL(12,2), IN p_method VARCHAR(50))
BEGIN
  DECLARE v_total DECIMAL(12,2);

  SELECT SUM(subtotal) INTO v_total FROM OrderItem WHERE order_id = p_order_id;

  IF v_total IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order empty';
  END IF;

  IF p_paid < v_total THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment insufficient';
  END IF;

  INSERT INTO Payment(order_id, paid_amount, method) VALUES (p_order_id, p_paid, p_method);
  UPDATE Orders SET total_amount = v_total, status = 'PAID' WHERE order_id = p_order_id;
END$$

DELIMITER ;
