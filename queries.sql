--QUERY 1
/*SELECT DISTINCT numprocessosocorro
FROM(
  SELECT numprocessosocorro, COUNT(*)
  FROM acciona
  GROUP BY numprocessosocorro
  HAVING COUNT(*) >= all (
    SELECT COUNT(*)
    FROM acciona
    GROUP BY numprocessosocorro)) as foo;*/

--QUERY 2
/*SELECT nomeentidade
FROM acciona NATURAL JOIN eventoemergencia
WHERE instantechamada BETWEEN timestamp '2018-06-21 00:00:00' AND timestamp '2018-09-23 23:59:59'
GROUP BY nomeentidade
HAVING COUNT(nomeEntidade) >= ALL (
  SELECT COUNT(nomeentidade)
  FROM acciona NATURAL JOIN eventoemergencia
  WHERE instantechamada BETWEEN timestamp '2018-06-21 00:00:00' AND timestamp '2018-09-23 23:59:59'
  GROUP BY nomeentidade);*/

--QUERY 3
/*SELECT numprocessosocorro
FROM eventoemergencia NATURAL JOIN acciona
WHERE moradalocal = 'Oliveira do Hospital' AND instantechamada BETWEEN timestamp '2018-01-01 00:00:00' AND timestamp '2018-12-31 23:59:59'
EXCEPT
SELECT numprocessosocorro
FROM audita;*/

--QUERY 4
/*SELECT COUNT(*)
FROM (
  SELECT *
  FROM vigia NATURAL JOIN(
    SELECT *
    FROM segmentovideo
    WHERE duracao > interval '60s' AND datahorainicio BETWEEN timestamp '2018-08-01 00:00:00' AND timestamp '2018-08-31 23:59:59') as foo
  WHERE moradalocal = 'Monchique') as foo2;*/

--QUERY 5
/*SELECT nummeio, nomeentidade
FROM (acciona NATURAL JOIN meiocombate) AS f7
EXCEPT
SELECT *
FROM meioapoio;*/

--QUERY 6
/*SELECT DISTINCT nomeentidade
FROM acciona d
WHERE NOT EXISTS(
  SELECT numprocessosocorro
  FROM acciona
  EXCEPT
  SELECT numprocessosocorro
  FROM (acciona NATURAL JOIN meiocombate) b
WHERE b.nomeentidade = d.nomeentidade);*/
