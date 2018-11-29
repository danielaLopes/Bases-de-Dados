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

        $sql1 = "SELECT nummeio, nomeentidade FROM meio WHERE nummeio = :nummeio AND nomeentidade = :nomeentidade;";
        $sql2 = "INSERT INTO meio VALUES (:nummeio,:nomemeio,:nomeentidade);";
        $sql3 = "INSERT INTO $table VALUES (:nummeio,:nomeentidade);";

        $result1 = $db->prepare($sql1);
        $result1->execute(array($nummeio,$nomeentidade));

        if ($result1->rowCount() == 0){
          $result2 = $db->prepare($sql2);
          $result2->execute(array($nummeio,$nomemeio,$nomeentidade));
        }

        $result3 = $db->prepare($sql3);
        $result3->execute(array($nummeio,$nomeentidade));

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
