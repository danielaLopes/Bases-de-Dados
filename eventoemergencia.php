<html>
    <body>
      <?php
          try
          {
              $host = "db.ist.utl.pt";
              $user ="ist186458";
              $password = "bd2018yas";
              $dbname = $user;

              $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
              $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

              $db->beginTransaction();

              $sql = "SELECT * FROM eventoemergencia;";

              $result = $db->prepare($sql);
              $result->execute();

              $db->commit();

              echo("<h3>Evento de Emergencia</h3>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td>Numero de Telefone</td><td>Instante da Chamada</td><td>Nome da Pessoa</td><td>Morada Local</td><td>Numero do Processo de Socorro</td></tr>\n");

              foreach($result as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['numtelefone']}</td>\n");
                  echo("<td>{$row['instantechamada']}</td>\n");
                  echo("<td>{$row['nomepessoa']}</td>\n");
                  echo("<td>{$row['moradalocal']}</td>\n");
                  echo("<td>{$row['numprocessosocorro']}</td>\n");
                  echo("<td><a href=\"removerevento.php?numtelefone={$row['numtelefone']}&instantechamada={$row['instantechamada']}\">Remover Evento de Emergencia</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table>\n");

              echo("<form action='inserirevento.php' method='post'>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td><h3>Inserir Evento de Emergencia</h3></td></tr>");
              echo("<tr><td>Numero de Telefone: </td><td><input type='text' name='numtelefone'/></td></tr>");
              echo("<tr><td>Instante de Chamada: </td><td><input type='text' name='instantechamada'/></td></tr>");
              echo("<tr><td>Nome Pessoa: </td><td><input type='text' name='nomepessoa'/></td></tr>");
              echo("<tr><td>Morada Local: </td><td><input type='text' name='moradalocal'/></td></tr>");
              echo("<tr><td>Numero do Processo de Socorro: </td><td><input type='text' name='numprocessosocorro'/></td></tr>");
              echo("<tr><td><input type='submit' value='Inserir'/></td></tr></table>");
              echo("</form>");

              $db = null;

            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>
