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

        $sql = "SELECT nummeio, nomeentidade FROM (meiosocorro NATURAL JOIN acciona NATURAL JOIN eventoemergencia) WHERE moradalocal = :moradalocal ;";

        $result = $db->prepare($sql);
        $result->execute([':moradalocal' => $moradalocal]);

        echo("<h3>Lista de Meios de Socorro Accionados em {$moradalocal}</h3>");
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        echo("<tr><td>Numero do Meio </td><td>Nome da Entidade </td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['nummeio']}</td>\n");
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
