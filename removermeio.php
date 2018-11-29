<html>
    <body>
<?php
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

        $sql1 = "DELETE FROM meiocombate WHERE nummeio =:nummeio AND nomeentidade =:nomeentidade ;";
        $sql2 = "DELETE FROM meioapoio WHERE nummeio =:nummeio AND nomeentidade =:nomeentidade ;";
        $sql3 = "DELETE FROM meiosocorro WHERE nummeio =:nummeio AND nomeentidade =:nomeentidade ;";
        $sql4 = "DELETE FROM meio WHERE nummeio =:nummeio AND nomeentidade =:nomeentidade ;";

        $result1 = $db->prepare($sql1);
        $result1->execute(array($nummeio, $nomeentidade));

        $result2 = $db->prepare($sql2);
        $result2->execute(array($nummeio, $nomeentidade));

        $result4 = $db->prepare($sql4);
        $result4->execute(array($nummeio, $nomeentidade));

        $result4 = $db->prepare($sql4);
        $result4->execute(array($nummeio, $nomeentidade));

        $db->commit();

        echo("<p>O meio representado pelo numero do meio: {$nummeio} e pelo nome da entidade: {$nomeentidade} foi removido</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
