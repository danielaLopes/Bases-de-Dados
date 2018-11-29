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

        $sql = "INSERT INTO processosocorro VALUES(:numprocessosocorro);";

        $result = $db->prepare($sql);
        $result->execute([':numprocessosocorro' => $numprocessosocorro]);

        $db->commit();
        
        echo("<p>O processo de socorro {$numprocessosocorro} foi inserido</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
