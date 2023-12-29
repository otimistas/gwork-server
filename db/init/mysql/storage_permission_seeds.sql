DELIMITER //
CREATE PROCEDURE insert_m_storage_access_permissions()
BEGIN
  DECLARE i INT DEFAULT 0;
  WHILE i <= 777 DO
    INSERT INTO m_storage_access_permissions (mode) VALUES (LPAD(i, 3, '0'));
    SET i = i + 1;
  END WHILE;
END //
DELIMITER ;

CALL insert_m_storage_access_permissions();
