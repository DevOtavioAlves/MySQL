/* A parte abaixo é a de criação da Function */
DELIMITER //
CREATE FUNCTION TipoDeCliente(
    cliente_id INT
)
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
	DECLARE 
		totaldecompras DECIMAL(10,2);
        
    SELECT
		SUM(valor_total) INTO totaldecompras
        
    FROM venda
    
    WHERE
        data >= DATE_SUB(NOW(), INTERVAL 2 YEAR);
        
	IF
		totaldecompras > 10000 THEN
		RETURN 'Premium';
	ELSE
		RETURN 'Regular';
	END IF;
END //
DELIMITER ;

select TipoDeCliente(5000);