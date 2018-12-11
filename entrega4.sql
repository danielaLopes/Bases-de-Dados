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
E PRECISO DIZER SE SAO PRIMARIOS OU SECUNDARIOS ou unique???????????????
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
ser muito ineficiente. É desagrupado pois não está de acordo com a primary key da Tabela
e é Esparso pois nao são guardadas todas as colunas da tabela, pelo que continuamos
a aceder à tabela para obter os atributos dataHoraInicio e dataHoraFim.

Na tabela vigia escolhemos os atributos numCamara e moradaLocal, que correspondem à
primary key da tabela, pois ambos são necessários para as comparações e assim esta
tabela não tem de ser acedida cada vez que a query é feita. É Agrupado pois está de
acordo com a primary key da Tabela, pelo que segue a ordem da mesma.*/


/*2. Liste o número de vítimas transportado por meios de socorro em cada evento de
emergência.*/


/*Tabela: Transporta, Atributos: numProcessoSocorro, Hash, Desagrupado, Denso
Tabela: EventoEmergencia, Atributos: numProcessoSocorro, Hash, Desagrupado, Denso

Analogamente, */
