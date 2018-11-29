<html>
    <body>
<?php
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

        $sql1 = "DELETE FROM meio WHERE nomeentidade =:nomeentidade;";
        $sql2 = "DELETE FROM entidademeio WHERE nomeentidade =:nomeentidade;";

        $result1 = $db->prepare($sql1);
        $result2 = $db->prepare($sql2);
        $result1->execute([':nomeentidade' => $nomeentidade]);
        $result2->execute([':nomeentidade' => $nomeentidade]);

        $db->commit();
        
        echo("<p>{$nomeentidade} foi removida</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
