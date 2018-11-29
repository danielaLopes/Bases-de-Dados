<html>
    <body>
<?php
    $table = $_REQUEST['table'];
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

        $sql1 = "INSERT INTO meio VALUES (:nummeio,:nomemeio,:nomeentidade);";
        //$sql2 = "UPDATE meio SET nummeio= :nummeio WHERE nummeio= :nummeio AND nomeentidade = :nomeentidade";
        //$sql3 = "WITH upsert AS ($sql2 RETURNING *) $sql1 WHERE NOT EXISTS (SELECT * FROM upsert);";
        $sql4 = "INSERT INTO $table VALUES (:nummeio,:nomeentidade);";

        $result1 = $db->prepare($sql1);
        $result1->execute(array($nummeio,$nomemeio,$nomeentidade));

        $result4 = $db->prepare($sql4);
        $result4->execute(array($nummeio,$nomeentidade));

        echo($result1);

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
