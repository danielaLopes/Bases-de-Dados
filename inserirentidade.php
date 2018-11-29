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

        $sql = "INSERT INTO entidademeio VALUES(:nomeentidade);";

        $result = $db->prepare($sql);
        $result->execute([':nomeentidade' => $nomeentidade]);

        $db->commit();
        
        echo("<p>A entidade {$nomeentidade} foi inserida</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
