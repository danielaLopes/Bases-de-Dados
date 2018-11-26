drop table if exists camara cascade;
drop table if exists video cascade;
drop table if exists segmentoVideo cascade;
drop table if exists local cascade;
drop table if exists vigia cascade;
drop table if exists eventoEmergencia cascade;
drop table if exists processoSocorro cascade;
drop table if exists entidadeMeio cascade;
drop table if exists meio cascade;
drop table if exists meioCombate cascade;
drop table if exists meioApoio cascade;
drop table if exists meioSocorro cascade;
drop table if exists transporta cascade;
drop table if exists alocado cascade;
drop table if exists acciona cascade;
drop table if exists coordenador cascade;
drop table if exists audita cascade;
drop table if exists solicita cascade;
----------------------------------------
-- Table Creation
----------------------------------------

-- Named constraints are global to the database.
-- Therefore the following use the following naming rules:
--   1. pk_table for names of primary key constraints
--   2. fk_table_another for names of foreign key constraints

create table camara
   (numCamara 	integer	not null unique,
   constraint pk_camara_num_camara primary key(numCamara));

create table video
    (dataHoraInicio 	timestamp	not null unique,
    dataHoraFim   timestamp  not null,
    numCamara   integer not null unique,
    constraint pk_video_data_hora_inicio primary key(dataHoraInicio),
    constraint fk_video_num_camara foreign key(numCamara)
        references camara(numCamara)) on delete cascade on update cascade;

create table segmentoVideo
     (numSegmento 	integer	not null unique,
     duracao   timestamp  not null,
     dataHoraInicio   timestamp  not null unique,
     numCamara   integer not null unique,
     constraint pk_segmento_video_numSegmento primary key(numSegmento),
     constraint fk_segmento_video_data_hora_inicio foreign key(dataHoraInicio)
        references video(dataHoraInicio) on delete cascade on update cascade,
     constraint fk_segmento_video_num_camara foreign key(numCamara)
        references video(numCamara)) on delete cascade on update cascade;

create table local
    (moradaLocal 	varchar(255)	not null unique,
    constraint pk_local_morada_local primary key(moradaLocal));

create table vigia
     (moradaLocal 	varchar(255)	not null unique,
     numCamara   integer not null unique,
     constraint fk_vigia_morada_local foreign key(moradaLocal)
        references local(moradaLocal) on delete cascade on update cascade,
     constraint fk_vigia_num_camara foreign key(numCamara)
        references camara(numCamara)) on delete cascade on update cascade;

create table processoSocorro
   /*RI: todo o processo de socorro esta associado a um ou mais eventoEmergencia??????????????????????????????????????????????????????????????????''*/
  (numProcessoSocorro	integer	unique,
   constraint pk_processo_socorro_num primary key(numProcessoSocorro));

create table eventoEmergencia
      (numTelefone 	varchar(15)	not null,
      instanteChamada  timestamp not null,
      nomePessoa  varchar(80) not null unique,
      moradaLocal  varchar(255) not null,
      numProcessoSocorro  integer, /*RI: pode ser null*/
      unique(numTelefone, nomePessoa), /*ver restricao*/
      constraint pk_evento_emergencia_num_telefone_instante_chamada primary key(numTelefone, instanteChamada),
      constraint fk_evento_emergencia_morada_local foreign key(moradaLocal)
          references local(moradaLocal) on delete cascade on update cascade,
      constraint fk_evento_emergencia_num_processo_socorro foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro)) on delete cascade on update cascade;

create table entidadeMeio
     (nomeEntidade	varchar(200)	not null unique,
      constraint pk_entidade_meio_nome_entidade primary key(nomeEntidade));

create table meio
     (numMeio	  integer	not null unique,
      nomeMeio	varchar(80)	not null,
      nomeEntidade  varchar(200)	not null unique,
      constraint pk_meio_num primary key(numMeio),
      constraint fk_meio_nome_entidade foreign key(nomeEntidade)
          references entidadeMeio(nomeEntidade)) on delete cascade on update cascade;

create table meioCombate
     (numMeio	  integer	not null unique,
      nomeEntidade	varchar(200)	not null unique,
      constraint fk_meio_combate_num_meio foreign key(numMeio)
          references meio(numMeio) on delete cascade on update cascade,
      constraint fk_meio_combate_nome_entidade foreign key(nomeEntidade)
          references meio(nomeEntidade)) on delete cascade on update cascade;

create table meioApoio
     (numMeio	  integer	not null unique,
      nomeEntidade	varchar(200)	not null unique,
      constraint fk_meio_apoio_num_meio foreign key(numMeio) references meio(numMeio) on delete cascade on update cascade,
      constraint fk_meio_apoio_nome_entidade foreign key(nomeEntidade) references meio(nomeEntidade)) on delete cascade on update cascade;

create table meioSocorro
     (numMeio	  integer	not null unique,
      nomeEntidade	varchar(200)	not null unique,
      constraint fk_meio_socorro_num_meio foreign key(numMeio) references meio(numMeio) on delete cascade on update cascade,
      constraint fk_meio_socorro_nome_entidade foreign key(nomeEntidade) references meio(nomeEntidade)) on delete cascade on update cascade;

create table transporta
     (numMeio	  integer	not null unique,
      nomeEntidade	varchar(200)	not null unique,
      numVitimas  integer not null,
      numProcessoSocorro integer not null unique,
      constraint fk_tranporta_num_meio foreign key(numMeio)
          references meioSocorro(numMeio) on delete cascade on update cascade,
      constraint fk_tranporta_nome_entidade foreign key(nomeEntidade)
          references meioSocorro(nomeEntidade) on delete cascade on update cascade,
      constraint fk_tranporta_num_processo_socorro foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro)) on delete cascade on update cascade;

create table alocado
     (numMeio	  integer	not null unique,
      nomeEntidade	varchar(200)	not null unique,
      numHoras  integer not null,
      numProcessoSocorro integer not null unique,
      constraint fk_alocado_num_meio foreign key(numMeio)
          references meioApoio(numMeio) on delete cascade on update cascade,
      constraint fk_alocado_nome_entidade foreign key(nomeEntidade)
          references meioApoio(nomeEntidade) on delete cascade on update cascade,
      constraint fk_alocado_num_processo_socorro foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro)) on delete cascade on update cascade;

create table acciona
     (numMeio	  integer	not null unique,
      nomeEntidade	varchar(200)	not null unique,
      numProcessoSocorro  integer not null unique,
      constraint fk_alocado_num_meio foreign key(numMeio)
          references meio(numMeio) on delete cascade on update cascade,
      constraint fk_alocado_nome_entidade foreign key(nomeEntidade)
          references meio(nomeEntidade) on delete cascade on update cascade,
      constraint fk_alocado_num_processo_socorro foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro)) on delete cascade on update cascade;

create table coordenador
     (idCoordenador	  int	not null unique,
      constraint pk_coordenador_id primary key(idCoordenador));

create table audita
     (idCoordenador	  integer	not null unique,
      numMeio	  integer	not null unique,
      nomeEntidade  varchar(200)	not null unique,
      numProcessoSocorro  integer not null unique,
      datahoraInicio    timestamp	not null,
      datahoraFim   timestamp	not null,
      dataAuditoria   date	not null,
      texto text ,
      constraint fk_audita_id_coordenador foreign key(idCoordenador)
          references coordenador(idCoordenador) on delete cascade on update cascade,
      constraint fk_audita_num_meio foreign key(numMeio)
          references acciona(numMeio) on delete cascade on update cascade,
      constraint fk_audita_nome_entidade foreign key(nomeEntidade)
          references acciona(nomeEntidade) on delete cascade on update cascade,
      constraint fk_audita_num_processo_socorro foreign key(numProcessoSocorro)
          references acciona(numProcessoSocorro)) on delete cascade on update cascade,
      /*RI: datahoraInicio < datahoraFim*/
      check (datahoraInicio < datahoraFim),
      /*RI: dataAuditoria >= dataAtual*/
      check (dataAuditoria >= current_date);

create table solicita
     (idCoordenador	  integer	not null unique,
      dataHoraInicioVideo    timestamp	not null unique,
      numCamara   integer not null unique,
      dataHoraInicio   timestamp	not null,
      dataHoraFim   timestamp	not null,
      constraint fk_solicita_id_coordenador foreign key(idCoordenador)
          references coordenador(idCoordenador) on delete cascade on update cascade,
      constraint fk_solicita_data_hora_inicio foreign key(dataHoraInicio)
          references video(dataHoraInicio) on delete cascade on update cascade,
      constraint fk_solicita_num_camara foreign key(numCamara)
          references video(numCamara)) on delete cascade on update cascade;
