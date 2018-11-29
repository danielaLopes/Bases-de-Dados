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

              $sql = "SELECT * FROM processosocorro;";

              $result = $db->prepare($sql);
              $result->execute();

              $db->commit();

              echo("<h3>Processo de Socorro</h3>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td>Numero do Processo de Socorro</td></tr>\n");

              foreach($result as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['numprocessosocorro']}</td>\n");
                  echo("<td><a href=\"removerprocesso.php?numprocessosocorro={$row['numprocessosocorro']}\">Remover</a></td>\n");
                  echo("<td><a href=\"listarmeiosacionados.php?numprocessosocorro={$row['numprocessosocorro']}\">Listar Meios Acionados</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table>\n");

              echo("<h3>Inserir Processo de Socorro</h3>");
              echo("<form action='inserirprocesso.php' method='post'>");
              echo("<p>Numero de Processo de Socorro: <input type='text' name='numprocessosocorro'/></p>");
              echo("<p><input type='submit' value='Inserir'/></p>");
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
