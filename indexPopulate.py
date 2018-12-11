import random
import time
from datetime import timedelta
import string

def randomize_time(start_timestamp,end_timestamp):
    return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(random.randrange(start_timestamp,end_timestamp)))

def random_string(length):
    return ''.join(random.choice(string.ascii_letters) for m in xrange(length))

def random_numeric_string(length):
    return ''.join(random.choice(string.digits) for m in xrange(length))

moradas = ['Abrantes','Agueda','Alandroal','Albergaria-a-Velha','Albufeira','Alcanena',
    'Alcobaca','Alcochete','Alenquer','Alcoutim','Aljezur','Aljustrel','Almada','Almeida','Almeirim',
    'Almodovar','Alpiarca','Amadora','Alvaiazere','Alvito','Arouca','Aveiro','Amarante',
    'Amares','Anadia','Angra do Heroismo','Arcos de Valdevez','Arganil','Arraiolos',
    'Avis','Arruda dos Vinhos','Azambuja','Barcelos','Barrancos','Barreiro','Batalha','Beja',
    'Bombarral','Braga','Braganca','Benavente','Borba','Boticas','Cadaval','Castelo Branco',
    'Chamusca','Chaves','Coimbra','Campo Maior','Cantanhede','Carregal do Sal','Cartaxo',
    'Cascais','Castanheira de Pera','Castelo de Paiva','Castelo de Vide','Castro Daire','Coruche','Elvas','Entroncamento',
    'Espinho','Esposende','Estarreja','Estremoz','Evora','Faro','Funchal','Gondomar','Gouveia','Guarda',
    'Lagos','Leiria','Lisboa','Loures','Lousada','Mafra','Mangualde','Matosinhos','Moita',
    'Monchique','Montijo','Nisa','Odemira','Odivelas','Oeiras','Oliveira do Hospital','Ourique',
    'Penacova','Penafiel','Peniche','Pombal','Porto','Sabrosa','Sabugal','Santana','Serpa',
    'Tavira','Tomar','Tondela','Viseu'];

for morada in moradas:
    print('insert into local values(\'' + morada + '\');')

for i in range(0, 1000):
    print('insert into camara values(' + str(i+1) + ');')
    print('insert into coordenador values(' + str(i+1) + ');')
    if (i == 9):
        print('insert into vigia values(\'Loures\',10);')
    else:
        indexMorada = random.randint(0, 99)
        print('insert into vigia values(\'' + moradas[indexMorada] + '\',' + str(i+1) + ');')

for i in range(0, 5900):
    start = time.mktime(time.strptime('2018-01-01  00:00:00', '%Y-%m-%d %H:%M:%S'))
    end = time.mktime(time.strptime('2018-12-31  00:00:00', '%Y-%m-%d %H:%M:%S'))
    startTime = randomize_time(start, end)
    endTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.mktime(time.strptime(startTime,
        '%Y-%m-%d %H:%M:%S')) + 60*60))
    numbers = list(range(1, 9)) + list(range(11, 1000))
    n = random.choice(numbers)

    print('insert into video values(timestamp \'' + startTime + '\', timestamp \'' +
        str(endTime) + '\',' + str(n) + ');')

for i in range(0, 100):
    start = time.mktime(time.strptime('2018-01-01  00:00:00', '%Y-%m-%d %H:%M:%S'))
    end = time.mktime(time.strptime('2018-12-31  00:00:00', '%Y-%m-%d %H:%M:%S'))
    startTime = randomize_time(start, end)
    endTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.mktime(time.strptime(startTime,
        '%Y-%m-%d %H:%M:%S')) + 60*60))

    print('insert into video values(timestamp \'' + startTime + '\', timestamp \'' +
        endTime + '\',10);')


for i in range(0, 6000):
    numTel = random_numeric_string(9)

    start = time.mktime(time.strptime('2018-01-01  00:00:00', '%Y-%m-%d %H:%M:%S'))
    end = time.mktime(time.strptime('2018-12-31  00:00:00', '%Y-%m-%d %H:%M:%S'))
    instanteChamada = randomize_time(start, end)

    nomePessoa = random_string(10)

    moradaLocal = moradas[(random.randint(0,99))]

    print('insert into processoSocorro values(' +  str(i+1) + ');')

    print('insert into eventoEmergencia values(\'' + numTel + '\', timestamp \'' +
        instanteChamada + '\', \'' + nomePessoa + '\',\'' + moradaLocal + '\',' +
        str(i+1) + ');')

    nomeEntidade = 'Bombeiros ' + str(i+1)

    nomeMeio = random_string(6)

    print('insert into entidadeMeio values(\'' + nomeEntidade + '\');')

    print('insert into meio values(' + str(i+1) + ',\'' + nomeMeio + '\',\'' + nomeEntidade + '\');')

    print('insert into meioSocorro values(' + str(i+1) + ',\'' + nomeEntidade + '\');')

    if i < 100:
        numVitimas = random.randint(1, 1000)
        print('insert into transporta values(' + str(i+1) + ',\'' + nomeEntidade + '\',' +
            str(numVitimas) + ',' + str(i+1) + ');')
