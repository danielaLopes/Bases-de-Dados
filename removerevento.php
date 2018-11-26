<html>
    <body>
<?php
    $numtelefone = $_REQUEST['numtelefone'];
    $instantechamada = $_REQUEST['instantechamada'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "DELETE FROM eventoemergencia WHERE numtelefone =:numtelefone AND instantechamada =:instantechamada ;";

        $result = $db->prepare($sql);
        $result->execute(array($numtelefone, $instantechamada));

        echo("<p>O evento representado pelo numero de telefone: {$numtelefone} e pelo instante de chamada: {$instantechamada} foi removido</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
