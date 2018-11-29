<html>
    <body>
<?php
    $moradalocal = $_REQUEST['moradalocal'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->beginTransaction();

        $sql1 = "DELETE FROM vigia WHERE moradalocal =:moradalocal;";
        $sql2 = "DELETE FROM eventoemergencia WHERE moradalocal =:moradalocal;";
        $sql3 = "DELETE FROM local WHERE moradalocal =:moradalocal;";

        $result1 = $db->prepare($sql1);
        $result1->execute([':moradalocal' => $moradalocal]);

        $result2 = $db->prepare($sql2);
        $result2->execute([':moradalocal' => $moradalocal]);

        $result3 = $db->prepare($sql3);
        $result3->execute([':moradalocal' => $moradalocal]);

        $db->commit();

        echo("<p>{$moradalocal} foi removido</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
