UPDATE internacao
SET data_alta = date_add(data_entrada, INTERVAL 3 DAY);