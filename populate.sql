----------------------------------------
-- Auxiliary Functions
----------------------------------------
/*increments given number by one*/
Create or replace function incrementingInt(num int) returns int as
$$
begin
  return (num + 1);
end;
$$ language plpgsql;

/*returns random integer between a and b*/
Create or replace function randomIntegerBetween(a int, b int) returns int as
$$
begin
  return floor(random() * (b - a + 1)) + a;
end;
$$ language plpgsql;

/*returns random integer between a and b*/
/*Create or replace function generateTimeStamps() returns timestamp[] as
$$
declare
  times timestamp[];
begin
  times = generate_series(
       (date '2018-01-01')::timestamp,
       (date '2018-12-31')::timestamp,
       interval '1 day');
  raise notice 'Value: %', times[0];

    return (times);
end;
$$ language plpgsql;*/

Create or replace function random_string(length integer) returns text as
$$
declare
  chars text[] := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
  result text := '';
  i integer := 0;
begin
  if length < 0 then
    raise exception 'Given length cannot be less than 0';
  end if;
  for i in 1..length loop
    result := result || chars[1+random()*(array_length(chars, 1)-1)];
  end loop;
  return result;
end;
$$ language plpgsql;

Create or replace function random_numeric_string(length integer) returns text as
$$
declare
  chars text[] := '{1,2,3,4,5,6,7,8,9}';
  result text := '';
  i integer := 0;
begin
  if length < 0 then
    raise exception 'Given length cannot be less than 0';
  end if;
  for i in 1..length loop
    result := result || chars[1+random()*(array_length(chars, 1)-1)];
  end loop;
  return result;
end;
$$ language plpgsql;

Create or replace function random_morada_local() returns text as
$$
declare
  locals text[] := '{Abrantes,Agueda,Alandroal,Albergaria-a-Velha,Albufeira,Alcanena,
      Alcobaça,Alcochete,Alenquer,Alcoutim,Aljezur,Aljustrel,Almada,Almeida,Almeirim,
      Almodovar,Alpiarça,Amadora,Alvaiazere,Alvito,Arouca,Aveiro,Amarante,
      Amares,Anadia,Angra do Heroismo,Arcos de Valdevez,Arganil,Arraiolos,
      Avis,Arruda dos Vinhos,Azambuja,Barcelos,Barrancos,Barreiro,Batalha,Beja,
      Bombarral,Braga,Braganca,Benavente,Borba,Boticas,Cadaval,Castelo Branco,
      Chamusca,Chaves,Coimbra,Campo Maior,Cantanhede,Carregal do Sal,Cartaxo,
      Cascais,Castanheira de Pera,Castelo de Paiva,Castelo de Vide,Castro Daire,Coruche,Elvas,Entroncamento,
      Espinho,Esposende,Estarreja,Estremoz,Evora,Faro,Funchal,Gondomar,Gouveia,Guarda,
      Lagos,Leiria,Lisboa,Loures,Lousada,Mafra,Mangualde,Matosinhos,Moita,
      Monchique,Montijo,Nisa,Odemira,Odivelas,Oeiras,Oliveira do Hospital,Ourique,
      Penacova,Penafiel,Peniche,Pombal,Porto,Sabrosa,Sabugal,Santana,Serpa,
      Tavira,Tomar,Tondela,Viseu}';
  i integer := randomIntegerBetween(0,array_length(locals,1)-1);
begin
  return locals[i];
end;
$$ language plpgsql;

Create or replace function random_nome_Pessoa() returns text as
$$
declare
  names text[] := '{Daniela, Madalena, Afonso, Jorge, Pedro, Taissa,
        Joana, Maria, Joaquim, Oliver, Bruno, Mariana, Antonio,
        Julia, Manuel, Catarina, Candido, Ines, Margarida, Magda}';
  i integer := randomIntegerBetween(0,array_length(names,1)-1);
begin
  return names[i];
end;
$$ language plpgsql;

Create or replace function random_nome_entidade() returns text as
$$
declare
  entities text[] := '{Bombeiros Voluntarios, INEM, Protecao Civil,
        Forca Aerea, Comandos Distritais de Operacoes de Socorro, PSP, GNR}';
  i integer := randomIntegerBetween(0,array_length(entities,1)-1);
begin
  return entities[i];
end;
$$ language plpgsql;

Create or replace function random_timestamp() returns text as
$$
declare
  day integer;
  month integer;
  hour integer;
  minute integer;
begin

end;
$$ language plpgsql;

----------------------------------------
-- Populate Relations
----------------------------------------
/*camara*/
CREATE OR REPLACE FUNCTION populate_camara()
RETURNS void AS
$$
DECLARE n integer := 0; /*numCamara*/
        i integer := 0;
BEGIN
/*loops until 100 camaras in table*/
FOR i IN 1..100
LOOP
    n := incrementingInt(n::int);
    INSERT INTO camara
    VALUES(n);
END LOOP;
END;
$$ LANGUAGE plpgsql;

/*video*/
CREATE OR REPLACE FUNCTION populate_video()
RETURNS void AS
$$
DECLARE dHI timestamp; /*dataHoraInicio*/
        dHF timestamp; /*dataHoraFim*/
        n integer; /*numCamara*/
        i integer := 0;
        times timestamp[] :=
                '{01-06-2018 00:00,02-06-2018 00:00,03-06-2018 00:00,04-06-2018 00:00,05-06-2018 00:00,
                06-06-2018 00:00,07-06-2018 00:00,08-06-2018 00:00,09-06-2018 00:00,10-06-2018 00:00,11-06-2018 00:00,
                12-06-2018 00:00,13-06-2018 00:00,14-06-2018 00:00,15-06-2018 00:00,16-06-2018 00:00,17-06-2018 00:00,
                18-06-2018 00:00,19-06-2018 00:00,20-06-2018 00:00,21-06-2018 00:00,22-06-2018 00:00,23-06-2018 00:00,
                24-06-2018 00:00,25-06-2018 00:00,26-06-2018 00:00,27-06-2018 00:00,28-06-2018 00:00,29-06-2018 00:00,
                30-06-2018 00:00,

                01-07-2018 00:00,02-07-2018 00:00,03-07-2018 00:00,04-07-2018 00:00,05-07-2018 00:00,
                06-07-2018 00:00,07-07-2018 00:00,08-07-2018 00:00,09-07-2018 00:00,10-07-2018 00:00,11-07-2018 00:00,
                12-07-2018 00:00,13-07-2018 00:00,14-07-2018 00:00,15-07-2018 00:00,16-07-2018 00:00,17-07-2018 00:00,
                18-07-2018 00:00,19-07-2018 00:00,20-07-2018 00:00,21-07-2018 00:00,22-07-2018 00:00,23-07-2018 00:00,
                24-07-2018 00:00,25-07-2018 00:00,26-07-2018 00:00,27-07-2018 00:00,28-07-2018 00:00,29-07-2018 00:00,
                30-07-2018 00:00,31-07-2018 00:00,

                01-08-2018 00:00,02-08-2018 00:00,03-08-2018 00:00,04-08-2018 00:00,05-08-2018 00:00,
                06-08-2018 00:00,07-08-2018 00:00,08-08-2018 00:00,09-08-2018 00:00,10-08-2018 00:00,11-08-2018 00:00,
                12-08-2018 00:00,13-08-2018 00:00,14-08-2018 00:00,15-08-2018 00:00,16-08-2018 00:00,17-08-2018 00:00,
                18-08-2018 00:00,19-08-2018 00:00,20-08-2018 00:00,21-08-2018 00:00,22-08-2018 00:00,23-08-2018 00:00,
                24-08-2018 00:00,25-08-2018 00:00,26-08-2018 00:00,27-08-2018 00:00,28-08-2018 00:00,29-08-2018 00:00,
                30-08-2018 00:00,31-08-2018 00:00,

                01-09-2018 00:00,02-09-2018 00:00,03-09-2018 00:00,04-09-2018 00:00,05-09-2018 00:00,
                06-09-2018 00:00,07-09-2018 00:00,08-09-2018 00:00,09-09-2018 00:00,10-09-2018 00:00}';
BEGIN

FOR i IN 1..100
LOOP

    dHI := times[i];
    dHF := times[i+1];
    n := randomIntegerBetween(1, 100);

    INSERT INTO video
    VALUES(dHI, dHF, n);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*segmentoVideo*/
/*preciso de ter todos os segmentos de video???*/
CREATE OR REPLACE FUNCTION populate_segmento_video()
RETURNS void AS
$$
DECLARE nS integer := 1; /*numSegmento, cada video tem 8 segmentos*/
        d interval := '03:00'; /*duracao*/
        dHI timestamp; /*dataHoraInicio*/
        n integer; /*numCamara*/
        i integer := 0;
        times timestamp[] :=
                '{01-06-2018 00:00,02-06-2018 00:00,03-06-2018 00:00,04-06-2018 00:00,05-06-2018 00:00,
                06-06-2018 00:00,07-06-2018 00:00,08-06-2018 00:00,09-06-2018 00:00,10-06-2018 00:00,11-06-2018 00:00,
                12-06-2018 00:00,13-06-2018 00:00,14-06-2018 00:00,15-06-2018 00:00,16-06-2018 00:00,17-06-2018 00:00,
                18-06-2018 00:00,19-06-2018 00:00,20-06-2018 00:00,21-06-2018 00:00,22-06-2018 00:00,23-06-2018 00:00,
                24-06-2018 00:00,25-06-2018 00:00,26-06-2018 00:00,27-06-2018 00:00,28-06-2018 00:00,29-06-2018 00:00,
                30-06-2018 00:00,

                01-07-2018 00:00,02-07-2018 00:00,03-07-2018 00:00,04-07-2018 00:00,05-07-2018 00:00,
                06-07-2018 00:00,07-07-2018 00:00,08-07-2018 00:00,09-07-2018 00:00,10-07-2018 00:00,11-07-2018 00:00,
                12-07-2018 00:00,13-07-2018 00:00,14-07-2018 00:00,15-07-2018 00:00,16-07-2018 00:00,17-07-2018 00:00,
                18-07-2018 00:00,19-07-2018 00:00,20-07-2018 00:00,21-07-2018 00:00,22-07-2018 00:00,23-07-2018 00:00,
                24-07-2018 00:00,25-07-2018 00:00,26-07-2018 00:00,27-07-2018 00:00,28-07-2018 00:00,29-07-2018 00:00,
                30-07-2018 00:00,31-07-2018 00:00,

                01-08-2018 00:00,02-08-2018 00:00,03-08-2018 00:00,04-08-2018 00:00,05-08-2018 00:00,
                06-08-2018 00:00,07-08-2018 00:00,08-08-2018 00:00,09-08-2018 00:00,10-08-2018 00:00,11-08-2018 00:00,
                12-08-2018 00:00,13-08-2018 00:00,14-08-2018 00:00,15-08-2018 00:00,16-08-2018 00:00,17-08-2018 00:00,
                18-08-2018 00:00,19-08-2018 00:00,20-08-2018 00:00,21-08-2018 00:00,22-08-2018 00:00,23-08-2018 00:00,
                24-08-2018 00:00,25-08-2018 00:00,26-08-2018 00:00,27-08-2018 00:00,28-08-2018 00:00,29-08-2018 00:00,
                30-08-2018 00:00,31-08-2018 00:00,

                01-09-2018 00:00,02-09-2018 00:00,03-09-2018 00:00,04-09-2018 00:00,05-09-2018 00:00,
                06-09-2018 00:00,07-09-2018 00:00,08-09-2018 00:00,09-09-2018 00:00,10-09-2018 00:00}';
BEGIN

FOR i IN 1..100
LOOP

    dHI := times[i];
    n := randomIntegerBetween(1, 100);

    INSERT INTO segmentoVideo
    VALUES(numS, d, dHI, n);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*local*/
CREATE OR REPLACE FUNCTION populate_local()
RETURNS void AS
$$
DECLARE i integer := 0;
        locals text[] := '{Abrantes,Agueda,Alandroal,Albergaria-a-Velha,Albufeira,Alcanena,
            Alcobaça,Alcochete,Alenquer,Alcoutim,Aljezur,Aljustrel,Almada,Almeida,Almeirim,
            Almodovar,Alpiarça,Amadora,Alvaiazere,Alvito,Arouca,Aveiro,Amarante,
            Amares,Anadia,Angra do Heroismo,Arcos de Valdevez,Arganil,Arraiolos,
            Avis,Arruda dos Vinhos,Azambuja,Barcelos,Barrancos,Barreiro,Batalha,Beja,
            Bombarral,Braga,Braganca,Benavente,Borba,Boticas,Cadaval,Castelo Branco,
            Chamusca,Chaves,Coimbra,Campo Maior,Cantanhede,Carregal do Sal,Cartaxo,
            Cascais,Castanheira de Pera,Castelo de Paiva,Castelo de Vide,Castro Daire,Coruche,Elvas,Entroncamento,
            Espinho,Esposende,Estarreja,Estremoz,Evora,Faro,Funchal,Gondomar,Gouveia,Guarda,
            Lagos,Leiria,Lisboa,Loures,Lousada,Mafra,Mangualde,Matosinhos,Moita,
            Monchique,Montijo,Nisa,Odemira,Odivelas,Oeiras,Oliveira do Hospital,Ourique,
            Penacova,Penafiel,Peniche,Pombal,Porto,Sabrosa,Sabugal,Santana,Serpa,
            Tavira,Tomar,Tondela,Viseu}';

BEGIN
/*loops until 100 local in table*/
FOR i IN 1..array_length(locals,1)
LOOP
    INSERT INTO local
    VALUES(locals[i]); /*moradaLocal*/
END LOOP;
END;
$$ LANGUAGE plpgsql;

/*vigia*/
CREATE OR REPLACE FUNCTION populate_vigia()
RETURNS void AS
$$
DECLARE m varchar(255); /*moradaLocal*/
        n integer; /*numCamara*/
        i integer := 0,
BEGIN

n := randomIntegerBetween(1, 100);
INSERT INTO vigia
VALUES('Monchique', n);
n := randomIntegerBetween(1, 100);
INSERT INTO vigia
VALUES('Oliveira do Hospital', n);

FOR i IN 3..100
LOOP

    m := random_morada_local();
    n := randomIntegerBetween(1, 100);

    INSERT INTO vigia
    VALUES(m, n);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*processoSocorro*/
CREATE OR REPLACE FUNCTION populate_processo_socorro()
RETURNS void AS
$$
DECLARE n integer; /*numProcessoSocorro*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    n := randomIntegerBetween(1, 100);

    INSERT INTO processoSocorro
    VALUES(n);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*eventoEmergencia*/
CREATE OR REPLACE FUNCTION populate_evento_emergencia()
RETURNS void AS
$$
DECLARE numT varchar(15); /*numTelefone*/
        iC timestamp; /*instanteChamada*/
        nP varchar(80); /*nomePessoa*/
        mL varchar (255); /*moradaLocal*/
        numP integer; /*numProcessoSocorro*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numT := random_numeric_string(9);
    iC := ;
    nP := random_nome_Pessoa();
    mL := random_morada_local();
    numP := randomIntegerBetween(1,100);

    INSERT INTO eventoEmergencia
    VALUES(numT, iC, nP, mL, numP);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*entidadeMeio*/
CREATE OR REPLACE FUNCTION populate_entidade_meio()
RETURNS void AS
$$
DECLARE n varchar(80); /*nomeEntidade*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP
    /*TEMOS DE TER 100 ENTIDADES DIFERENTES???*/
    n := ;

    INSERT INTO entidadeMeio
    VALUES(n);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*meio*/
CREATE OR REPLACE FUNCTION populate_meio()
RETURNS void AS
$$
DECLARE numM integer; /*numMeio*/
        nM varchar(80); /*nomeMeio*/
        nE varchar(200); /*nomeEntidade*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numM := randomIntegerBetween(1, 100);
    nM := random_string(10);
    nE := random_nome_entidade();

    INSERT INTO meio
    VALUES(numM, nM, nE);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*meioCombate*/
CREATE OR REPLACE FUNCTION populate_meio_combate()
RETURNS void AS
$$
DECLARE numM integer; /*numMeio*/
        nE varchar(200); /*nomeEntidade*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numM := randomIntegerBetween(1, 100);
    nE := random_numeric_string(200);

    INSERT INTO meioCombate
    VALUES(numM, nE);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*meioApoio*/
/*insert into meioApoio values ('Iacocca',	'L-17');
insert into meioApoio values ('Brown',	'L-23');
insert into meioApoio values ('Cook',	'L-15');
insert into meioApoio values ('Nguyen',	'L-14');
insert into meioApoio values ('Davis',	'L-93');*/

/*meioSocorro*/
/*insert into meioSocorro values ('Iacocca',	'L-17');
insert into meioSocorro values ('Brown',	'L-23');
insert into meioSocorro values ('Cook',	'L-15');
insert into meioSocorro values ('Nguyen',	'L-14');
insert into meioSocorro values ('Davis',	'L-93');*/

/*transporta*/
CREATE OR REPLACE FUNCTION populate_transporta()
RETURNS void AS
$$
DECLARE numM integer; /*numMeio*/
        nE varchar(200); /*nomeMeio*/
        numV integer; /*numVitimas*/
        numP integer; /*numProcessoSocorro*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numM := randomIntegerBetween(1, 100);
    nE := random_numeric_string(200);
    numV := randomIntegerBetween(0, 1000);
    numP := randomIntegerBetween(1, 100);

    INSERT INTO transporta
    VALUES(numM, nE, numV, numP);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*alocado*/
CREATE OR REPLACE FUNCTION populate_alocado()
RETURNS void AS
$$
DECLARE numM integer; /*numMeio*/
        nE varchar(200); /*nomeMeio*/
        numH integer; /*numHoras*/
        numP integer; /*numProcessoSocorro*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numM := randomIntegerBetween(1, 100);
    nE := random_numeric_string(200);
    numH := randomIntegerBetween(0, 50);
    numP := randomIntegerBetween(1, 100);

    INSERT INTO alocado
    VALUES(numM, nE, numH, numP);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*acciona*/
CREATE OR REPLACE FUNCTION populate_acciona()
RETURNS void AS
$$
DECLARE numM integer; /*numMeio*/
        nE varchar(200); /*nomeMeio*/
        numP integer; /*numProcessoSocorro*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numM := randomIntegerBetween(1, 100);
    nE := random_numeric_string(200);
    numP := randomIntegerBetween(1, 100);

    INSERT INTO acciona
    VALUES(numM, nE, numV, numP);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*coordenador*/
CREATE OR REPLACE FUNCTION populate_coordenador()
RETURNS void AS
$$
DECLARE iC integer; /*idCoordenador*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    iC := randomIntegerBetween(1, 100);

    INSERT INTO coordenador
    VALUES(iC);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*audita*/
CREATE OR REPLACE FUNCTION populate_audita()
RETURNS void AS
$$
DECLARE iC integer; /*idCoordenador*/
        numM integer; /*numMeio*/
        nE varchar(200); /*nomeMeio*/
        numP integer; /*numProcessoSocorro*/
        dhI timestamp; /*datahoraInicio*/
        dhF timestamp; /*datahoraFim*/
        dA date; /*dataAuditoria*/
        t text; /*texto*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    iC := randomIntegerBetween(1, 100);
    numM := randomIntegerBetween(1, 100);
    nE := random_numeric_string(200);
    numP := randomIntegerBetween(1, 100);
    dhI := ;
    dhF := ;
    dA := ;
    t = random_numeric_string(100);

    INSERT INTO audita
    VALUES(iC, numM, nE, numP, dhI, dhF, dA, t);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*solicita*/
CREATE OR REPLACE FUNCTION populate_solicita()
RETURNS void AS
$$
DECLARE iC integer; /*idCoordenador*/
        dHIV timestamp; /*dataHoraInicioVideo*/
        numC integer; /*numCamara*/
        dHI timestamp; /*dataHoraInicio*/
        dHF timestamp; /*dataHoraFim*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    iC := randomIntegerBetween(1, 100);
    dHIV := ;
    numC := randomIntegerBetween(1, 100);
    dHI := ;
    dHF := ;

    INSERT INTO solicita
    VALUES(iC, dHIV, numC, dHI, dHF);

END LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$ BEGIN
    PERFORM populate_camara();
    PERFORM populate_video();
    /*PERFORM populate_segmento_video();*/
    PERFORM populate_local();
    /*PERFORM populate_vigia();
    PERFORM populate_evento_emergencia();
    PERFORM populate_processo_socorro();
    PERFORM populate_entidade_meio();
    PERFORM populate_meio();
    PERFORM populate_meio_combate();
    PERFORM populate_meio_apoio();
    PERFORM populate_meio_socorro();
    PERFORM populate_transporta();
    PERFORM populate_alocado();
    PERFORM populate_acciona();
    PERFORM populate_coordenador();
    PERFORM populate_audita();
    PERFORM populate_solicita();*/
END $$;
