/*RESTRICOES DE INTEGRIDADE*/
/*a) Um coordenador só pode solicitar vídeos de câmaras colocadas num local cujo accionamento
de meios esteja a ser (ou tenha sido) auditado por ele próprio*/

create table solicita
     (idCoordenador	  integer	not null,
      dataHoraInicioVideo    timestamp	not null,
      numCamara   integer not null,
      dataHoraInicio   timestamp	not null,
      dataHoraFim   timestamp	not null,
      primary key(idCoordenador, dataHoraInicioVideo, numCamara),
      foreign key(idCoordenador)
          references coordenador(idCoordenador),
      foreign key(dataHoraInicioVideo, numCamara)
          references video(dataHoraInicio, numCamara),
      check (datahoraInicio < datahoraFim),
      check (dataHoraInicioVideo <= datahoraInicio),
      check (dataHoraInicioVideo <= current_date)),
      constraint coordenador_solicita_valid check (check_validity_coordenador_solicita(
          idCoordenador));

create or replace function check_validity_coordenador_solicita(id integer)
      returns boolean
      as $$
      declare result boolean;
      begin
          select exists(
              select 1
              from audita natural join acciona
              where idCoordenador = id)
          into result;

          return result;
      end;
      $$ language plpgsql;


/*b) Um Meio de Apoio só pode ser alocado a Processos de Socorro para os quais tenha sido accionado*/
create table alocado
     (numMeio	  integer	not null,
      nomeEntidade	varchar(200)	not null,
      numHoras  integer not null,
      numProcessoSocorro integer not null,
      primary key(numMeio, nomeEntidade, numProcessoSocorro),
      foreign key(numMeio, nomeEntidade)
          references meioApoio(numMeio, nomeEntidade),
      foreign key(numProcessoSocorro)
          references processoSocorro(numProcessoSocorro),
      constraint meio_alocado_valid check (check_validity_meio_alocado(
          numProcessoSocorro)));

create or replace function check_validity_meio_alocado(processo integer)
      returns boolean
      as $$
      declare result boolean;
      begin
          select exists(
              select 1
              from acciona
              where numProcessoSocorro = processo)
          into result;

          return result;
      end;
      $$ language plpgsql;

/*ÍNDICES*/
/*Para testar a influência do uso dos índices populou-se a base de dados usando um script que
gerou, consoante a alínea:
-> 1 000 coordenadores, 1 000 câmaras, 100 moradaLocal, 1 000 vigia e 6 000 vídeos
(100 dos quais filmados pela câmara 10 em Loures)
-> 6 000 eventos de emergência, 6 000 processoSocorro, 6 000 entidades, 6 000 meios,
6 000 meios de socorro e 100 transporta.

Para a análise dos índices necessários, analisou-se o comportamento e desempenho das queries sem o uso de
índices (excepto o índice por defeito da chave primária) através do uso do comando EXPLAIN do PostgreSQL.*/

/*a)*/
/*1. Liste todos os vídeos filmados pela câmara 10 em Loures*/

/*QUERY PLAN
-------------------------------------------------------------------------------------
Nested Loop  (cost=0.27..127.07 rows=32 width=16)
->  Index Only Scan using vigia_pkey on vigia i  (cost=0.27..8.29 rows=1 width=4)
Index Cond: ((moradalocal = 'Loures'::text) AND (numcamara = 10))
->  Seq Scan on video v  (cost=0.00..118.46 rows=32 width=20)
Filter: (numcamara = 10)*/
E PRECISO DIZER SE SAO PRIMARIOS OU SECUNDARIOS???????????????
/*Tabela: Video, Atributos: numCamara, Hash, Desagrupado, Denso
Tabela: Vigia, Atributos: numCamara , moradaLocal,  Hash, Agrupado, Denso

Ambos são Hash porque estamos a tratar de comparações diretas, não havendo comparações
com intervalos ou booleanos.
Ambos são Densos pois, apesar de ocupar mais espaço, é mais rápido pois não tem de fazer procura na Tabela
e no nosso caso não faria sentido usar índices esparsos pois não queremos aceder a
conteúdos da tabela ordenados e dentro de um certo intervalo (com o índice a apontar
para o início do intervalo).

Na tabela video escolhemos apenas o atributo numCamara pois é o único que é necessário
para as comparações feitas na query, sendo os outros atributos desnecessários e iria
ser muito ineficiente. É desagrupado pois não está de acordo com a primary key da Tabela.

Na tabela vigia escolhemos os atributos numCamara e moradaLocal, que correspondem à
primary key da tabela, pois ambos são necessários para as comparações e assim esta
tabela não tem de ser acedida cada vez que a query é feita. É Agrupado pois está de
acordo com a primary key da Tabela, pelo que segue a ordem da mesma.*/


/*2. Liste o número de vítimas transportado por meios de socorro em cada evento de
emergência.*/


/*Tabela: Transporta, Atributos: numProcessoSocorro, Hash, Desagrupado, Denso
Tabela: EventoEmergencia, Atributos: numProcessoSocorro, Hash, Desagrupado, Denso

Analogamente, */

/*b)*/
/*1-*/
CREATE INDEX video_idx on video USING HASH(numCamara);
/*Este índice tem por objetivo acelarar a execução de V.numCamara = I.numCamara e de
V.numCamara = 10, ambas condições de igualdade, pelo que o uso de uma função de dispersão
hash permite que a procura seja feita em 0(1).

/*CREATE INDEX vigia_idx on vigia USING HASH(numCamara, moradaLocal);*/
ESTE INDICE TORNARIA A PROCURA MAIS RAPIDA!!!!?????????
/*Não é necessário criar o outro índice associado à interrogação 1 pois o índice que
seria mais vantajoso para esta tabela seria o correspondente ao índice da primary key,
o qual já existe, apesar de o original ter btree em vez de hash*/

/*2-*/

/*Ambos estes índices têm por objetivo acelarar a execução da comparação de igualdade
T.numProcessoSocorro = E.numProcessoSocorro uma condição de igualdade, pelo que o uso
de uma função de dispersão hash permite que a procura seja feita em 0(1).*/

CREATE INDEX transporta_idx on transporta USING HASH(numProcessoSocorro);

CREATE INDEX evento_emergencia_idx on eventoEmergencia USING HASH(numProcessoSocorro);

/*MODELO MULTIDIMENSIONAL*/
/*Diagrama em Estrela*/
create table d_evento(
    idEvento          serial        not null,
    numTelefone       varchar(15)   not null,
    instanteChamada   timestamp     not null,
    primary key(idEvento)
);

create table d_meio(
    idMeio            serial        not null,
    numMeio           integer       not null,
    nomeMeio          varchar(80)   not null,
    nomeEntidade      varchar(200)  not null,
    tipo              varchar(80)   not null,
    primary key(idMeio)
);

create table d_tempo(
    dia               integer       not null,
    mes               integer       not null,
    ano               integer       not null,
    primary key(dia, mes, ano)
);

create table facts(
    idEvento          serial        not null,
    idMeio            serial        not null,
    dia               integer       not null,
    mes               integer       not null,
    ano               integer       not null,
    foreign key(idEvento)       references d_evento(idEvento),
    foreign key(idMeio)         references d_meio(idMeio),
    foreign key(dia, mes, ano)  references d_tempo(dia, mes, ano)
);

/*Carregar o esquema*/
create or replace function random_integer_between(a int, b int)
returns int as
$$
begin
  return floor(random() * (b - a + 1)) + a;
end;
$$ language plpgsql;

create or replace function date_to_int(data timestamp)
returns integer as
$$
declare result integer;
        dia integer;
        mes integer;
        ano integer;
begin
  dia := date


create or replace function load_d_evento()
returns void as
$$
begin
    insert into d_evento(numTelefone, instanteChamada)
      select numTelefone, instanteChamada from eventoEmergencia;
end;
$$ language plpgsql;

create or replace function load_d_meio()
returns void as
$$
declare tipos text[] := '{MeioApoio, MeioCombate, MeioSocorro}';
begin
    insert into d_meio(numMeio, nomeMeio, nomeEntidade, tipos[random_integer_between(0,2)])
      select numMeio, nomeMeio, nomeEntidade from meio;
end;
$$ language plpgsql;

create or replace function load_d_tempo()
returns void as
$$
begin
    insert into d_tempo(dia, mes, ano)
      select numMeio, nomeMeio, nomeEntidade from meio;
end;
$$ language plpgsql;


/*DATA ANALYTICS*/
/*com rollup*/
select tipo, count(*)
from facts natural join d_meio
where idEvento = 15
group by tipo, (group by ano, mes
                union
                group by ano)

/*sem rollup*/
select tipo, count(*)
from facts natural join d_meio
where idEvento = 15
group by tipo, rollup(ano, mes)
