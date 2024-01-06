select 
	m.nome, 
    m.crm, 
    count(c.medico_id) as 'QTD Consultas'
from medico as m 
inner join consulta as c
on c.medico_id = m.id
group by c.medico_id;
