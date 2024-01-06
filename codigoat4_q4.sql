select 
	receita_escrita 
from receita 
where 
	consulta_id = (
		select 
			min(consulta_id)
        from receita
    );