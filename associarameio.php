<html>
    <body>
      <?php
          $numprocessosocorro = $_REQUEST['$numprocessosocorro'];
          $nummeio = $_REQUEST['nummeio'];
          $nomeentidade = $_REQUEST['nomeentidade'];

          echo("<form action='updateassociacaomeio.php?&numprocessosocorro={$numprocessosocorro}&nummeio={$nummeio}&nomeentidade={$nomeentidade}' method='post'>");
          echo("<table border=\"0\" cellspacing=\"5\">\n");
          echo("<tr><td><h3>Associar Processo a Meio:</h3></td></tr>");
          echo("<tr><td>Numero do Processo de Socorro: </td><td><input type='text' name='numprocessosocorro'/></td></tr>");
          echo("<tr><td><input type='submit' value='Associar'/></td></tr></table>");
          echo("</form>");
        ?>
    </body>
</html>
