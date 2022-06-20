CREATE SEQUENCE S_EQUIPES MINVALUE 0 MAXVALUE 999999 START WITH 0;
      
CREATE TABLE equipes (oid number PRIMARY KEY,
                      nome VARCHAR(100), 
                      nome_b1 VARCHAR(100), 
                      nome_b2 VARCHAR(100), 
                      nome_b3 VARCHAR(100), 
                      status number,
CONSTRAINT ck_status CHECK (status IN (0,1)
));

CREATE SEQUENCE S_TAREFAS START WITH 1;

CREATE TABLE tarefas (oid number PRIMARY KEY,
                      nome varchar(100), 
                      data_criacao  DATE, 
                      area varchar(100), 
                      equipe_resp number,
CONSTRAINT fk_equipe
    FOREIGN KEY (equipe_resp)
    REFERENCES equipes(oid));


CREATE SEQUENCE S_LOG_PROCESSO START WITH 1;

CREATE TABLE log_processo (oid number PRIMARY KEY,
                           data  date, 
                           codigo number, 
                           descricao varchar(100));
 