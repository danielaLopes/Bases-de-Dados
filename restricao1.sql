insert into entidadeMeio values('bombeiros1');

insert into meio values(12, 'xxxxx', 'bombeiros1');

insert into meio values(14, 'xxyyxx', 'bombeiros1');

insert into acciona values(12, 'bombeiros1', 1);

insert into video values(timestamp '2018-10-23 00:00:00',timestamp '2018-10-23 00:04:00',3);
  insert into video values(timestamp '2018-10-22 00:00:00',timestamp '2018-10-22 00:04:00',3);

insert into audita values(12, 12, 'bombeiros1', 1, timestamp '2018-10-23 00:00:00', timestamp '2018-10-23 00:03:00', timestamp '2018-10-23 00:03:02', 'fjhngjgjnhgghn');

insert into vigia values('Loures',3);

insert into eventoEmergencia values('111111111', timestamp '2018-10-23 00:00:01', 'Daniela', 'Loures', 1);

insert into solicita values(12, timestamp '2018-10-23 00:00:00', 3, timestamp '2018-10-23 00:02:00', timestamp '2018-10-23 00:03:00');

insert into solicita values(13, timestamp '2018-10-22 00:00:00', 3, timestamp '2018-10-22 00:02:00', timestamp '2018-10-22 00:03:00');

insert into meioApoio values(12, 'bombeiros1');

insert into meioApoio values(14, 'bombeiros1');

insert into alocado values(12, 'bombeiros1', 2, 1);

insert into alocado values(14, 'bombeiros1', 2, 4);
