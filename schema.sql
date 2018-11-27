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
   (numCamara 	integer	not null,
   primary key(numCamara));

create table video
    (dataHoraInicio 	timestamp	not null,
    dataHoraFim   timestamp  not null,
    numCamara   integer not null,
    primary key(dataHoraInicio, numCamara),
    foreign key(numCamara)
        references camara(numCamara) on delete cascade on update cascade);

create table segmentoVideo
     (numSegmento 	integer	not null,
     duracao   interval  not null,
     dataHoraInicio   timestamp  not null,
     numCamara   integer not null,
     primary key(numSegmento, dataHoraInicio, numCamara),
     foreign key(dataHoraInicio, numCamara)
        references video(dataHoraInicio, numCamara) on delete cascade on update cascade);

create table local
    (moradaLocal 	varchar(255)	not null,
    primary key(moradaLocal));

create table vigia
     (moradaLocal 	varchar(255)	not null,
     numCamara   integer not null,
     primary key(moradaLocal, numCamara),
     foreign key(moradaLocal)
        references local(moradaLocal) on delete cascade on update cascade,
     foreign key(numCamara)
        references camara(numCamara) on delete cascade on update cascade);

create table processoSocorro
   /*RI: todo o processo de socorro esta associado a um ou mais eventoEmergencia??????????????????????????????????????????????????????????????????''*/
  (numProcessoSocorro	integer,
   primary key(numProcessoSocorro));

create table eventoEmergencia
      (numTelefone 	varchar(15)	not null,
      instanteChamada  timestamp not null,
      nomePessoa  varchar(80) not null,
      moradaLocal  varchar(255) not null,
      numProcessoSocorro  integer not null,
      unique(numTelefone, nomePessoa), /*restricao*/
      primary key(numTelefone, instanteChamada, moradaLocal, numProcessoSocorro),
      foreign key(moradaLocal)
          references local(moradaLocal) on delete cascade on update cascade,
      foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro) on delete cascade on update cascade);

create table entidadeMeio
     (nomeEntidade	varchar(200)	not null,
      primary key(nomeEntidade));

create table meio
     (numMeio	  integer	not null,
      nomeMeio	varchar(80)	not null,
      nomeEntidade  varchar(200)	not null,
      primary key(numMeio, nomeEntidade),
      foreign key(nomeEntidade)
          references entidadeMeio(nomeEntidade) on delete cascade on update cascade);

create table meioCombate
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      primary key(numMeio, nomeEntidade),
      foreign key(numMeio, nomeEntidade)
          references meio(numMeio, nomeEntidade) on delete cascade on update cascade);

create table meioApoio
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      primary key(numMeio, nomeEntidade),
      foreign key(numMeio, nomeEntidade)
          references meio(numMeio, nomeEntidade) on delete cascade on update cascade);

create table meioSocorro
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      primary key(numMeio, nomeEntidade),
      foreign key(numMeio, nomeEntidade)
          references meio(numMeio, nomeEntidade) on delete cascade on update cascade);

create table transporta
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      numVitimas  integer not null,
      numProcessoSocorro integer not null,
      primary key(numMeio, nomeEntidade, numProcessoSocorro),
      foreign key(numMeio, nomeEntidade)
          references meioSocorro(numMeio, nomeEntidade) on delete cascade on update cascade,
      foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro) on delete cascade on update cascade);

create table alocado
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      numHoras  integer not null,
      numProcessoSocorro integer not null,
      primary key(numMeio, nomeEntidade, numProcessoSocorro),
      foreign key(numMeio, nomeEntidade)
          references meioApoio(numMeio, nomeEntidade) on delete cascade on update cascade,
      foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro) on delete cascade on update cascade);

create table acciona
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      numProcessoSocorro  integer not null,
      primary key(numMeio, nomeEntidade, numProcessoSocorro),
      foreign key(numMeio, nomeEntidade)
          references meio(numMeio, nomeEntidade) on delete cascade on update cascade,
      foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro) on delete cascade on update cascade);

create table coordenador
     (idCoordenador	  integer	not null,
      primary key(idCoordenador));

create table audita
     (idCoordenador	  integer	not null,
      numMeio	  integer	not null,
      nomeEntidade  varchar(200)	not null,
      numProcessoSocorro  integer not null,
      datahoraInicio    timestamp	not null,
      datahoraFim   timestamp	not null,
      dataAuditoria   date	not null,
      texto text,
      primary key(idCoordenador, numMeio, nomeEntidade, numProcessoSocorro),
      foreign key(idCoordenador)
          references coordenador(idCoordenador) on delete cascade on update cascade,
      foreign key(numMeio, nomeEntidade, numProcessoSocorro)
          references acciona(numMeio, nomeEntidade, numProcessoSocorro) on delete cascade on update cascade,
      /*RI: datahoraInicio < datahoraFim*/
      check (datahoraInicio < datahoraFim),
      /*RI: dataAuditoria <= dataAtual*/
      check (dataAuditoria <= current_date));

create table solicita
     (idCoordenador	  integer	not null,
      dataHoraInicioVideo    timestamp	not null,
      numCamara   integer not null,
      dataHoraInicio   timestamp	not null,
      dataHoraFim   timestamp	not null,
      primary key(idCoordenador, dataHoraInicioVideo, numCamara),
      foreign key(idCoordenador)
          references coordenador(idCoordenador) on delete cascade on update cascade,
      foreign key(dataHoraInicioVideo, numCamara)
          references video(dataHoraInicio, numCamara) on delete cascade on update cascade);
