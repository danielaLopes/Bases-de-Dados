select dataHoraInicio, dataHoraFim
from video V, vigia I
where V.numCamara = I.numCamara
      and V.numCamara = 10
      and I.moradaLocal = 'Loures';


/*explain select sum(numVitimas)
from transporta T, eventoEmergencia E
where T.numProcessoSocorro = E.numProcessoSocorro
group by numTelefone, instanteChamada;*/
