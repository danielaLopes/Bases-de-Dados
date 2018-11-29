<html>
    <body>
    <h3>SGIF - Grupo 55</h3>
<?php
    try
    {
        echo("<a href=\"local.php\">Locais</a></br>");
        echo("<a href=\"eventoemergencia.php\">Eventos de Emergencia</a></br>");
        echo("<a href=\"processo.php\">Processos de Socorro</a></br>");
        echo("<a href=\"meio.php\">Meios</a></br>");
        echo("<a href=\"entidade.php\">Entidades</a></br>");
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
