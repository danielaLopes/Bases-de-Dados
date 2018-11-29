<html>
    <body>
<?php
    $table = $_REQUEST['table'];
    $nummeio = $_REQUEST['nummeio'];
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

        $sql1 = "DELETE FROM $table WHERE nummeio =:nummeio AND nomeentidade = :nomeentidade ;";

        $result1 = $db->prepare($sql1);
        $result1->execute(array($nummeio,$nomeentidade));

        $db->commit();

        echo("<p>O meio de apoio foi removido\n</p><p>Nome do Meio: {$nomemeio}\n</p><p>Nome da Entidade: {$nomeentidade}</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
