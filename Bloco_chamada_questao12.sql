declare
  v_resultado  number;
  v_erro       number := 0;
begin

  v_resultado := om_pkg_task.fun_insere_tarefa(:p_nome_area,:p_area,v_erro);
  --
  if v_erro = 0 then
     dbms_output.put_line('Operação realizada com Sucesso');
     commit;
  else
     dbms_output.put_line('Operação com erros');  
     rollback;
  end if;
  --
end;