select 
	p.nome,
    c.data_hora_realizacao,
    e.nome

from consulta as c
inner join paciente as p
on c.paciente_id = p.id
inner join especialidade as e
on c.especialidade_id = e.id
where data_nascimento > '2005-01-01' and especialidade_id <> 'Pediatria'
order by c.data_hora_realizacao desc;