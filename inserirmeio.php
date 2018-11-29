<html>
    <body>
<?php
    $nummeio = $_REQUEST['nummeio'];
    $nomemeio = $_REQUEST['nomemeio'];
    $nomeentidade = $_REQUEST['nomeentidade'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->beginTransaction();

        $sql = "INSERT INTO meio VALUES(:nummeio,:nomemeio,:nomeentidade);";

        $result = $db->prepare($sql);
        $result->execute(array($nummeio,$nomemeio,$nomeentidade));

        $db->commit();
        
        echo("<p>O meio foi inserido\n</p><p>Nome do Meio: {$nomemeio}\n</p><p>Nome da Entidade: {$nomeentidade}</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
