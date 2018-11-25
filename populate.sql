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
Create or replace function HundredTimeStamps() returns timestamp[] as
$$
begin
    return (generate_series(
         (date '2018-01-01')::timestamp,
         (date '2018-12-31')::timestamp,
         interval '1 day'
     ))::timestamp[];
end;
$$ language plpgsql;

/*random moradaLocal*/
Create or replace function random_string(length integer) returns varchar(length) as
$$
declare
  chars text[] := '{'',0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
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

Create or replace function random_numeric_string(length integer) returns varchar(length) as
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
DECLARE dHI integer; /*COMO FAZER COM TIMESTAMP???*/
        dHF integer; /*dataHoraFim*/
        n integer; /*numCamara*/
        i integer := 0,
        times timestamp[] := HundredTimeStamps();
BEGIN
/*loops until 100 camaras in table*/
FOR i IN 1..100
LOOP

    dHI := times[i];
    dHI := times[i + 1];
    n := randomIntegerBetween(1, 100);

    INSERT INTO video
    VALUES(dHI, dHF, n);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*segmentoVideo*/
/*insert into segmentoVideo values ('Downtown',	'Lisbon',		1900000);
insert into segmentoVideo values ('Central',	'Cascais',		2100000);
insert into segmentoVideo values ('Uptown',	'Amadora',		1700000);
insert into segmentoVideo values ('Metro',	'Amadora',	 	400200);*/

/*local*/
CREATE OR REPLACE FUNCTION populate_local()
RETURNS void AS
$$
DECLARE i integer := 0;

BEGIN
/*loops until 100 local in table*/
FOR i IN 1..100
LOOP
    INSERT INTO local
    VALUES(random_string(255)); /*moradaLocal*/
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
/*loops 100*/
FOR i IN 1..100
LOOP

    m := ;
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
    iC :=;
    nP :=;
    mL :=;
    numP :=;

    INSERT INTO eventoEmergencia
    VALUES(numT, iC, nP, mL, numP);

END LOOP;
END;
$$ LANGUAGE plpgsql;

/*entidadeMeio*/
CREATE OR REPLACE FUNCTION populate_entidade_meio()
RETURNS void AS
$$
DECLARE nM varchar(80); /*nomeMeio*/
        i integer := 0,
BEGIN
/*loops 100*/
FOR i IN 1..100
LOOP

    nM := random_numeric_string(9);

    INSERT INTO entidadeMeio
    VALUES(nM);

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
    nM := random_numeric_string(80);
    nE := random_numeric_string(200);

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
    /*PERFORM populate_video();*/
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
