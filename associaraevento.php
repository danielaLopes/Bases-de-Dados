<html>
    <body>
      <?php
          $numprocessosocorro1 = $_REQUEST['numprocessosocorro'];
          $numtelefone1 = $_REQUEST['numtelefone'];
          $instantechamada1 = $_REQUEST['instantechamada'];

          echo("<form action='updateassociacaoevento.php?&numprocessosocorro1={$numprocessosocorro1}&numtelefone1={$numtelefone1}&instantechamada1={$instantechamada1}&numprocessosocorro2={$numprocessosocorro2}' method='post'>");
          echo("<table border=\"0\" cellspacing=\"5\">\n");
          echo("<tr><td><h3>Associar Processo a Meio:</h3></td></tr>");
          echo("<tr><td>Numero do Processo de Socorro: </td><td><input type='text' name='numprocessosocorro2'/></td></tr>");
          echo("<tr><td><input type='submit' value='Associar'/></td></tr></table>");
          echo("</form>");
        ?>
    </body>
</html>
