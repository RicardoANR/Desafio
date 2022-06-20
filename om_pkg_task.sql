create or replace package om_pkg_task is

    function FUN_INSERE_TAREFA(p_nome_tarefa   in tarefas.nome%TYPE,
                               p_area_tarefa   in tarefas.area%TYPE,
                               p_erro   out number) return number;
                               
end om_pkg_task;
/

create or replace package body om_pkg_task is	

 FUNCTION FUN_INSERE_TAREFA (p_nome_tarefa tarefas.nome%TYPE,
                             p_area_tarefa tarefas.area%TYPE,
                             p_erro out number)
    RETURN NUMBER IS
	
	v_resultado  number;
	v_status     equipes.status%type;
	v_cod_equipe equipes.oid%type;
    v_descricao  log_processo.descricao%type;
	--
 
  BEGIN
    --
	--
    -- Pegar as informaçoes da Equipe
	Begin
     select oid, status into v_cod_equipe, v_status
	   from equipes
	   where nome_b1||'/'||nome_b2||'/'||nome_b3 = p_area_tarefa;
	exception when others then
	   v_cod_equipe := null;
	   v_status := null;
	end;
	--
	if v_status is not null then -- encontrou a area
	   --
	   if v_status = 1 then -- ativo
	      v_resultado  := 0;
	   else -- inativo
	      v_resultado  := -2;
          v_cod_equipe := 0;		  
	   end if;
	   --
	else -- nao encontro a area
	   v_resultado  := -1;
       v_cod_equipe := 0;		
	end if;
    --
    p_erro := 0;
    --
	BEGIN
	  insert into tarefas(oid,nome,data_criacao,area,equipe_resp)
	    values (s_tarefas.nextval,p_nome_tarefa,sysdate,p_area_tarefa,v_cod_equipe);
	exception when others then
	    p_erro := 1;
		null;
    end;
	--
     --
     if v_resultado = 0 then
        v_descricao := 'Equipe ATIVA encontrada na mesma area informada pelo usuario - Area digitada: '||p_area_tarefa;
     elsif v_resultado = -2 then
        v_descricao := 'Equipe INATIVA encontrada na mesma area informada pelo usuario - Area digitada: '||p_area_tarefa;
     else
        v_descricao := 'Equipe NÃO encontrada na tabela de equipes - Area digitada: '||p_area_tarefa;
     end if;
     --
     begin
      insert into log_processo(oid,data,codigo,descricao) values (s_log_processo.nextval, sysdate, v_resultado, v_descricao);
     exception when others then
    	 p_erro := 1;
         null;
     end;   
	--
    RETURN (v_resultado);
	--
  END FUN_INSERE_TAREFA;
  --

END om_pkg_task;
/
