<html>
    <body>
<?php
    $numprocessosocorro = $_REQUEST['numprocessosocorro'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->beginTransaction();

        $sql1 = "DELETE FROM eventoemergencia WHERE numprocessosocorro =:numprocessosocorro;";
        $sql2 = "DELETE FROM transporta WHERE numprocessosocorro =:numprocessosocorro;";
        $sql3 = "DELETE FROM alocado WHERE numprocessosocorro =:numprocessosocorro;";
        $sql4 = "DELETE FROM audita WHERE numprocessosocorro =:numprocessosocorro;";
        $sql5 = "DELETE FROM acciona WHERE numprocessosocorro =:numprocessosocorro;";
        $sql6 = "DELETE FROM processosocorro WHERE numprocessosocorro =:numprocessosocorro;";

        $result1 = $db->prepare($sql1);
        $result1->execute([':numprocessosocorro' => $numprocessosocorro]);

        $result2 = $db->prepare($sql2);
        $result2->execute([':numprocessosocorro' => $numprocessosocorro]);

        $result3 = $db->prepare($sql3);
        $result3->execute([':numprocessosocorro' => $numprocessosocorro]);

        $result4 = $db->prepare($sql4);
        $result4->execute([':numprocessosocorro' => $numprocessosocorro]);

        $result5 = $db->prepare($sql5);
        $result5->execute([':numprocessosocorro' => $numprocessosocorro]);

        $result6 = $db->prepare($sql6);
        $result6->execute([':numprocessosocorro' => $numprocessosocorro]);

        $db->commit();

        echo("<p>{$numprocessosocorro} foi removido</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
