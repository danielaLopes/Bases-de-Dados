<html>
    <body>
      <?php
          $oldnummeio = $_REQUEST['nummeio'];
          $oldnomeentidade = $_REQUEST['nomeentidade'];
          $table = $_REQUEST['table'];
          echo("<form action='updatemeio.php?table={$table}&oldnummeio={$oldnummeio}&oldnomeentidade={$oldnomeentidade}' method='post'>");
          echo("<table border=\"0\" cellspacing=\"5\">\n");
          echo("<tr><td><h3>Editar Meio</h3></td></tr>");
          echo("<tr><td>Novo Numero do Meio: </td><td><input type='text' name='newnummeio'/></td></tr>");
          echo("<tr><td>Novo Nome da Entidade: </td><td><input type='text' name='newnomeentidade'/></td></tr>");
          echo("<tr><td><input type='submit' value='Inserir'/></td></tr></table>");
          echo("</form>");
        ?>
    </body>
</html>
