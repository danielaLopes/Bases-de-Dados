<html>
    <body>
<?php
    $numtelefone = $_REQUEST['nummeio'];
    $instantechamada = $_REQUEST['nomeentidade'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "DELETE FROM meio WHERE nummeio =:nummeio AND nomeentidade =:nomeentidade ;";
        echo("<p>O evento representado pelo numero de telefone: {$nummeio} e pelo instante de chamada: {$nomeentidade} foi removido</p>");

        $result = $db->prepare($sql);
        $result->execute(array($nummeio, $nomeentidade));

        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
