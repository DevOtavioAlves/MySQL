DELIMITER //
CREATE TRIGGER AplicacaoSenha AFTER INSERT
ON usuario
FOR EACH ROW
BEGIN
    UPDATE senha
    SET NEW.senha = MD5(NEW.senha);
END //
DELIMITER ;
              