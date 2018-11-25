<html>
    <body>
    <h3>SGIF</h3>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;

        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT account_number, branch_name, balance FROM account;";

        $result = $db->prepare($sql);
        $result->execute();

        echo("<a href=\"local.php\">Locais</a></br>");
        echo("<a href=\"eventoemergencia.php\">Eventos de Emergencia</a></br>");
        echo("<a href=\"processo.php\">Processos de Socorro</a></br>");
        echo("<a href=\"local.php\">Meios e Entidades</a></br>");

        /*echo("<table border=\"0\" cellspacing=\"5\">\n");

        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['account_number']}</td>\n");
            echo("<td>{$row['branch_name']}</td>\n");
            echo("<td>{$row['balance']}</td>\n");
            echo("<td><a href=\"local.php?account_number={$row['account_number']}\">Change balance</a></td>\n");
            echo("</tr>\n");
        }
        echo("</table>\n");*/

        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
