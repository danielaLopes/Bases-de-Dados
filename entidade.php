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

              $sql = "SELECT * FROM entidademeio;";

              $result = $db->prepare($sql);
              $result->execute();

              echo("<table border=\"0\" cellspacing=\"5\">\n");

              foreach($result as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['nomeentidade']}</td>\n");
                  echo("<td><a href=\"removerentidade.php?moradalocal={$row['nomeentidade']}\">Remover Entidade</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table>\n");

              echo("<h3>Inserir Entidade</h3>");
              echo("<form action='inserirentidade.php' method='post'>");
              echo("<p>Nome da Entidade: <input type='text' name='nomeentidade'/></p>");
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
