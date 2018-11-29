<html>
    <body>
<?php
    $numtelefone = $_REQUEST['numtelefone'];
    $instantechamada = $_REQUEST['instantechamada'];
    $nomepessoa = $_REQUEST['nomepessoa'];
    $moradalocal = $_REQUEST['moradalocal'];
    $numprocessosocorro = $_REQUEST['numprocessosocorro'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->beginTransaction();

        $sql1 = "SELECT numprocessosocorro FROM eventoemergencia WHERE numprocessosocorro = :numprocessosocorro;";
        $sql2 = "INSERT INTO processosocorro VALUES(:numprocessosocorro);";
        $sql3 = "INSERT INTO eventoemergencia VALUES(:numtelefone,:instantechamada,:nomepessoa,:moradalocal,:numprocessosocorro);";

        $result1 = $db->prepare($sql1);
        $result1->execute(array($numprocessosocorro));

        if ($result1->rowCount() == 0){
          $result2 = $db->prepare($sql2);
          $result2->execute(array($numprocessosocorro));
        }

        $result3 = $db->prepare($sql3);
        $result3->execute(array($numtelefone,$instantechamada,$nomepessoa,$moradalocal,$numprocessosocorro));

        $db->commit();

        echo("<p>O Evento de Emergencia foi inserido\n</p><p>Numero de telefone: {$numtelefone}\n</p><p>Instante de Chamada: {$instantechamada}</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
