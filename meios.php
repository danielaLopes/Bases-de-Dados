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

              $sql = "SELECT * FROM meio;";

              $result = $db->prepare($sql);
              $result->execute();

              echo("<table border=\"0\" cellspacing=\"5\">\n");

              foreach($result as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['nummeio']}</td>\n");
                  echo("<td>{$row['nomemeio']}</td>\n");
                  echo("<td>{$row['nomeentidade']}</td>\n");
                  echo("<td><a href=\"removermeio.php?nummeio{$row['nummeio']}&nomeentidade={$row['nomeentidade']}\">Remover Meio</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table>\n");

              echo("<form action='inserirmeio.php' method='post'>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td><h3>Inserir Meio</h3></td></tr>");
              echo("<tr><td>Numero do Meio: </td><td><input type='text' name='nummeio'/></td></tr>");
              echo("<tr><td>Nome do Meio: </td><td><input type='text' name='nomemeio'/></td></tr>");
              echo("<tr><td>Nome da Entidade: </td><td><input type='text' name='nomeentidade'/></td></tr>");
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
