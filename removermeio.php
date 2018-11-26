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

        $sql = "DELETE FROM meio WHERE nummeio =:nummeio AND nomeentidade =:nomeentidade ;";

        $result = $db->prepare($sql);
        $result->execute(array($nummeio, $nomeentidade));

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
