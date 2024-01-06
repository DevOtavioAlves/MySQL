select *
from consulta
where 
convenio_id is null and valor_consulta = (
	select
		max(valor_consulta)
        from consulta
    );

select *
from consulta
where 
convenio_id is null and valor_consulta = (
	select
		min(valor_consulta)
        from consulta
    );