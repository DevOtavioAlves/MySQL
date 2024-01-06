select 
	e.nome,
    e.cre,
    count(ie.internacao_id)
from enfermeiro as e
inner join internacao_enfermeiro as ie
on ie.internacao_id = e.id
inner join internacao as i
on ie.internacao_id = i.id
group by e.nome, e.cre
having count(ie.internacao_id) > 1;

/*select * from internacao;*/ 