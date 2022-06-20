select CASE WHEN nt.nota <= 7 THEN
			'NULL'
		ELSE
			al.nome
		END nome , 
        nt.nota, al.valor 
from alunos al, notas nt
where al.valor between nt.Valor_Min and nt.Valor_Max
order by nt.nota desc, nome, al.valor;