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

        $sql = "SELECT nummeio, nomemeio, nomeentidade FROM (meio NATURAL JOIN acciona) WHERE numprocessosocorro = :numprocessosocorro ;";

        $result = $db->prepare($sql);
        $result->execute([':numprocessosocorro' => $numprocessosocorro]);

        $db->commit();
        
        echo("<h3>Lista de Meios Accionados</h3>");
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<tr><td>Numero do Meio </td><td>Nome do Meio </td><td>Nome da Entidade </td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['nummeio']}</td>\n");
            echo("<td>{$row['nomemeio']}</td>\n");
            echo("<td>{$row['nomeentidade']}</td>\n");
            echo("</tr>\n");
        }
        echo("</table>\n");

        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
