CREATE SEQUENCE S_OM_RECORD START WITH 1;

create or replace TRIGGER TRG_TCALL
  after insert on TCALL
  for each row

begin

  prc_insere_om_record(:new.tipo, :new.subtipo);


end TRG_TCALL;

create or replace PROCEDURE PRC_INSERE_OM_RECORD
                                  (P_TIPO    in number, 
                                   P_SUBTIPO in number) AS

v_cod_natureza   om_record.natureza%type;

BEGIN
   -- Pegar a natureza
   Begin 
     select natureza into v_cod_natureza
       from om_record_natureza
       where tipo = p_tipo
       and   subtipo = p_subtipo;
   exception when others then
       v_cod_natureza := 0;   
   end;
   --
   Begin
    insert into om_record(oid,tipo,subtipo,natureza,data_criacao)
      values (s_om_record.nextval,p_tipo,p_subtipo,v_cod_natureza,sysdate);
   exception when others then
       null;    
   end;
   --
END PRC_INSERE_OM_RECORD;
