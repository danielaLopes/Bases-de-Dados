<html>
    <body>
<?php
    $numtelefone1 = $_REQUEST['numtelefone1'];
    $instantechamada1 = $_REQUEST['instantechamada1'];
    $numprocessosocorro1 = $_REQUEST['numprocessosocorro1'];
    $numprocessosocorro2 = $_REQUEST['numprocessosocorro2'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql1 = "SELECT numtelefone, instantechamada FROM eventoemergencia WHERE numprocessosocorro =:numprocessosocorro2;";

        $result = $db->prepare($sql1);
        $result->execute(array($numprocessosocorro2));

        $sql2 = "UPDATE eventoemergencia ;";

        $result = $db->prepare($sql1);
        $result->execute(array($numprocessosocorro2));

        echo("<p>O processo numero:{$numprocessosocorro}\n</p><p>foi associado com o Meio numero: {$nummeio}\n</p><p>e nome da entidade: {$nomeentidade}</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
