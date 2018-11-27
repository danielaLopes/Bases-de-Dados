SELECT numprocessosocorro
FROM(
  SELECT numprocessosocorro, COUNT(nummeio)
  FROM acciona
  GROUP BY numprocessosocorro) as foo;
/*
  HAVING COUNT(nummeio) >= all (
    SELECT numprocessosocorro, COUNT(nummeio)
    FROM acciona
    GROUP BY numprocessosocorro)) as foo;*/

/*
SELECT nomeentidade
FROM r NATURAL JOIN (
  SELECT MAX(Count)
  FROM (
    SELECT nomeentidade, COUNT(*)
    FROM acciona NATURAL JOIN (
      SELECT *
      FROM eventoemergencia
      WHERE 21/06/2018 00:00 >= instantechamada >= 23/09/2018 23:59)
      GROUP BY nomeentidade) as r) as Count)


SELECT numprocesso
FROM (
  SELECT *
  FROM localincendio NATURAL JOIN(
    SELECT *
    FROM eventoemergencia NATURAL JOIN(
      SELECT *
      FROM acciona EXCEPT audita)
    WHERE 01/01/2018 00:00 >= instantechamada >= 31/12/2018 23:59)
  WHERE moradalocal = ‘Oliveira do Hospital’);


SELECT numsegmento
FROM (
  SELECT *
  FROM vigia NATURAL JOIN(
    SELECT *
    FROM segmentovideo
    WHERE duracao > 60s and 01/08/2018 00:00 >= datahorainicio >= 31/08/2018)
  WHERE moradalocal = ‘Monchique’)


SELECT nummeio, nomeentidade
FROM (( acciona NATURAL JOIN meiocombate) EXCEPT meioapoio);


SELECT nomeentidade
FROM acciona d
WHERE NOT EXISTS(
  SELECT numprocessosocorro
  FROM acciona
  EXCEPT
  SELECT numprocessosocorro
  FROM (acciona NATURAL JOIN meiocombate) b
WHERE b.nomeentidade = d.nomeentidade);*/
