SELECT *, AVG(valor_consulta)
FROM consulta
WHERE convenio_id IS NOT NULL AND YEAR(data_hora_realizacao) = '2020';

