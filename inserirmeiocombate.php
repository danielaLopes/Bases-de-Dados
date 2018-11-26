<html>
    <body>
<?php
    $nummeio = $_REQUEST['nummeiocombate'];
    $nomemeio = 'Meio de Combate';
    $nomeentidade = $_REQUEST['nomeentidadecombate'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "INSERT INTO meio VALUES(:nummeio,:nomemeio,:nomeentidade);";
        $sql1 = "INSERT INTO meiocombate VALUES(:nummeio,:nomeentidade);";

        $result = $db->prepare($sql);
        $result->execute(array($nummeio,$nomemeio,$nomeentidade));

        $result1 = $db->prepare($sql1);
        $result1->execute(array($nummeio,$nomeentidade));

        echo("<p>O meio de combate foi inserido\n</p><p>Nome do Meio: {$nomemeio}\n</p><p>Nome da Entidade: {$nomeentidade}</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
