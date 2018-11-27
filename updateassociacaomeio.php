<html>
    <body>
<?php
    $nummeio = $_REQUEST['nummeio'];
    $nomeentidade = $_REQUEST['nomeentidade'];
    $numprocessosocorro = $_REQUEST['numprocessosocorro'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "INSERT INTO acciona VALUES(:nummeio,:nomentidade,:numprocessosocorro);";

        $result = $db->prepare($sql);
        $result->execute(array($nummeio,$nomeentidade,$numprocessosocorro));

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
