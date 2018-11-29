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
      Alcobaca,Alcochete,Alenquer,Alcoutim,Aljezur,Aljustrel,Almada,Almeida,Almeirim,
      Almodovar,Alpiarca,Amadora,Alvaiazere,Alvito,Arouca,Aveiro,Amarante,
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
  i integer;
begin
  i := randomIntegerBetween(1,array_length(locals,1));
  return locals[i];
end;
$$ language plpgsql;

Create or replace function random_nome_Pessoa() returns text as
$$
declare
  names text[] := '{Daniela, Madalena, Afonso, Jorge, Pedro, Taissa,
        Joana, Maria, Joaquim, Oliver, Bruno, Mariana, Antonio,
        Julia, Manuel, Catarina, Candido, Ines, Margarida, Magda}';
  i integer := randomIntegerBetween(1,array_length(names,1));
begin
  return names[i];
end;
$$ language plpgsql;

Create or replace function random_timestamp() returns timestamp as
$$
begin
return date_trunc('second', to_timestamp('01-06-2018 00:00', 'DD-MM-YYYY HH24:MI') +
       random() * interval '3 months');
end;
$$ language plpgsql;

Create or replace function random_timestamp_after(start timestamp) returns timestamp as
$$
begin
return date_trunc('second', to_timestamp(to_char(start,'DD-MM-YYYY HH24:MI'),'DD-MM-YYYY HH24:MI')
    + random() * interval '1 day');
end;
$$ language plpgsql;

Create or replace function random_timestamp_after_1hour(start timestamp) returns timestamp as
$$
begin
return date_trunc('second', to_timestamp(to_char(start,'DD-MM-YYYY HH24:MI'),'DD-MM-YYYY HH24:MI')
    + random() * interval '1 hour');
end;
$$ language plpgsql;

Create or replace function random_date() returns date as
$$
begin
return date_trunc('day', to_timestamp(to_char(current_date,'DD-MM-YYYY'),'DD-MM-YYYY') -
       random() * interval '2 months');
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

/*video, segmentoVideo e vigia*/
CREATE OR REPLACE FUNCTION populate_video_segmento_video_vigia_solicita()
RETURNS void AS
$$
DECLARE iC integer; /*idCoordenador*/
        dHIS timestamp; /*dataHoraInicioSolicita*/
        dHFS timestamp; /*dataHoraFimSolicita*/

        numS integer := 1; /*numSegmento, cada video tem 4 segmentos*/
        d interval := '6 hours'; /*duracao*/
        dHI timestamp; /*dataHoraInicio*/
        dHIseg timestamp; /*dataHoraInicio do segmento*/
        dHF timestamp; /*dataHoraFim*/
        n integer; /*numCamara*/
        m varchar(255); /*moradaLocal*/
        i integer := 0;
        times text[] :=
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

    dHI := to_timestamp(times[i], 'DD-MM-YYYY HH24:MI');
    dHF := to_timestamp(times[i+1], 'DD-MM-YYYY HH24:MI');
    n := randomIntegerBetween(1, 100);
    INSERT INTO video
    VALUES(dHI, dHF, n);

    iC := randomIntegerBetween(1, 100);
    dHIS := random_timestamp_after(dHI);
    dHFS := random_timestamp_after_1hour(dHIS);
    INSERT INTO solicita
    VALUES(iC, dHI, n, dHIS, dHFS);

    FOR numS IN 1..4
    LOOP

        INSERT INTO segmentoVideo
        VALUES(numS, d, dHI, n);

    END LOOP;

END LOOP;

    INSERT INTO vigia
    VALUES('Monchique', n);

    FOR i IN (n+1)..100
    LOOP

        m := random_morada_local();

        INSERT INTO vigia
        VALUES(m, i); /*i corresponds to numCamara*/

    END LOOP;

    FOR i IN 1..(n-1)
    LOOP

        m := random_morada_local();

        INSERT INTO vigia
        VALUES(m, i); /*i corresponds to numCamara*/

    END LOOP;

END;
$$ LANGUAGE plpgsql;

/*local*/
CREATE OR REPLACE FUNCTION populate_local()
RETURNS void AS
$$
DECLARE i integer := 0;
        locals text[] := '{Abrantes,Agueda,Alandroal,Albergaria-a-Velha,Albufeira,Alcanena,
            Alcobaca,Alcochete,Alenquer,Alcoutim,Aljezur,Aljustrel,Almada,Almeida,Almeirim,
            Almodovar,Alpiarca,Amadora,Alvaiazere,Alvito,Arouca,Aveiro,Amarante,
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

/*processoSocorro*/
CREATE OR REPLACE FUNCTION populate_processo_socorro()
RETURNS void AS
$$
DECLARE i integer := 0;
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    INSERT INTO processoSocorro
    VALUES(i); /*i corresponds to numProcessoSocorro*/

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
        i integer := 0;
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    numT := random_numeric_string(9);
    iC := random_timestamp();
    nP := random_nome_Pessoa();
    mL := random_morada_local();
    numP := randomIntegerBetween(1,100);

    INSERT INTO eventoEmergencia
    VALUES(numT, iC, nP, mL, numP);

END LOOP;

FOR i IN 1..40
LOOP

  numT := random_numeric_string(9);
  iC := random_timestamp();
  nP := random_nome_Pessoa();
  numP := randomIntegerBetween(1,10);
  INSERT INTO eventoEmergencia
  VALUES(numT, iC, nP, 'Oliveira do Hospital', numP);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*entidadeMeio*/
CREATE OR REPLACE FUNCTION populate_entidade_meio()
RETURNS void AS
$$
DECLARE n varchar(80); /*nomeEntidade*/
        i integer := 0;
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    n := 'Bombeiros' || i::text ;

    INSERT INTO entidadeMeio
    VALUES(n);

END LOOP;
INSERT INTO entidadeMeio
VALUES('Bombeiros101');
END;
$$ LANGUAGE plpgsql;

/*meio, meioCombate, meioApoio, alocado, meioSocorro, transporta, acciona, audita*/
CREATE OR REPLACE FUNCTION populate_meios()
RETURNS void AS
$$
DECLARE iC integer; /*idCoordenador*/
        dhI timestamp; /*datahoraInicio*/
        dhF timestamp; /*datahoraFim*/
        dA date; /*dataAuditoria*/
        t text; /*texto*/

        nM varchar(80); /*nomeMeio*/

        numMC integer; /*numMeioCombate*/

        numMA integer; /*numMeioApoio*/
        numH integer; /*numHoras*/

        numMS integer; /*numMeioSocorro*/
        numV integer; /*numVitimas*/

        numP integer; /*numProcessoSocorro*/
        nE varchar(200); /*nomeEntidade*/
        i integer := 0;
BEGIN
/*loops entities*/
FOR i IN 1..100
LOOP

    nE := 'Bombeiros' || i::text;

    numMC := randomIntegerBetween(1, 100);
    nM := random_string(10);
    INSERT INTO meio
    VALUES(numMC, nM, nE);
    INSERT INTO meioCombate
    VALUES(numMC, nE);

    INSERT INTO meio
    VALUES(300 + i, nM,'Bombeiros101');
    INSERT INTO meioCombate
    VALUES(300 + i, 'Bombeiros101');

    numP := randomIntegerBetween(1, 100);

    IF (i<10) THEN INSERT INTO meioApoio VALUES(numMC, nE);
    END IF;

    IF (i<50) THEN INSERT INTO acciona VALUES(numMC, nE, numP);
    END IF;

    INSERT INTO acciona VALUES(300 + i, 'Bombeiros101', numP);

    IF (i<34) THEN
        iC := randomIntegerBetween(1,100);
        dhI := random_timestamp();
        dhF := random_timestamp_after(dhI);
        dA := random_date();
        t := random_string(20);
        INSERT INTO audita VALUES(iC, numMC, nE, numP, dhI, dhF, dA, t);
    END IF;

    numMA := randomIntegerBetween(101, 200);
    nM := random_string(10);
    INSERT INTO meio
    VALUES(400 + i, nM,'Bombeiros101');
    INSERT INTO meioCombate
    VALUES(400 + i, 'Bombeiros101');
    INSERT INTO meio
    VALUES(numMA, nM, nE);
    INSERT INTO meioApoio
    VALUES(numMA, nE);
    numH := randomIntegerBetween(0, 50);
    numP := randomIntegerBetween(1, 100);
    INSERT INTO alocado
    VALUES(numMA, nE, numH, numP);

    IF (i<50) THEN INSERT INTO acciona VALUES(numMA, nE, numP);
    END IF;

    INSERT INTO acciona VALUES(400 + i, 'Bombeiros101', numP);

    IF (i<34) THEN
        iC := randomIntegerBetween(1,100);
        dhI := random_timestamp();
        dhF := random_timestamp_after(dhI);
        dA := random_date();
        t := random_string(20);
        INSERT INTO audita VALUES(iC, numMA, nE, numP, dhI, dhF, dA, t);
    END IF;

    numMS := randomIntegerBetween(201, 300);
    nM := random_string(10);
    INSERT INTO meio
    VALUES(numMS, nM, nE);
    INSERT INTO meioSocorro
    VALUES(numMS, nE);
    INSERT INTO meio
    VALUES(500 + i, nM,'Bombeiros101');
    INSERT INTO meioCombate
    VALUES(500 + i, 'Bombeiros101');
    numV := randomIntegerBetween(0, 1000);
    numP := randomIntegerBetween(1, 100);
    INSERT INTO transporta
    VALUES(numMS, nE, numV, numP);

    IF (i<50) THEN INSERT INTO acciona VALUES(numMS, nE, numP);
    END IF;

    INSERT INTO acciona VALUES(500 + i, 'Bombeiros101', numP);

    IF (i<35) THEN
        iC := randomIntegerBetween(1,100);
        dhI := random_timestamp();
        dhF := random_timestamp_after(dhI);
        dA := random_date();
        t := random_string(20);
        INSERT INTO audita VALUES(iC, numMS, nE, numP, dhI, dhF, dA, t);
    END IF;

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*coordenador*/
CREATE OR REPLACE FUNCTION populate_coordenador()
RETURNS void AS
$$
DECLARE i integer := 0;
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    INSERT INTO coordenador
    VALUES(i);  /*i corresponds to idCoordenador*/

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*main*/
DO $$ BEGIN
    PERFORM populate_camara();
    PERFORM populate_local();
    PERFORM populate_coordenador();
    PERFORM populate_video_segmento_video_vigia_solicita();
    PERFORM populate_processo_socorro();
    PERFORM populate_evento_emergencia();
    PERFORM populate_entidade_meio();
    PERFORM populate_meios();
END $$;
