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

        $sql = "INSERT INTO eventoemergencia VALUES(:numtelefone,:instantechamada,:nomepessoa,:moradalocal,:numprocessosocorro);";
        echo("<p>O Evento de Emergencia foi inserido\nNumero de telefone: {$numtelefone}\nInstante de Chamada: {$instantechamada}</p>");

        $result = $db->prepare($sql);
        $result->execute(array($numtelefone,$instantechamada,$nomepessoa,$moradalocal,$numprocessosocorro));

        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
