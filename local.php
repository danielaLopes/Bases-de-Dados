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

              $sql = "SELECT * FROM local;";

              $result = $db->prepare($sql);
              $result->execute();

              $db->commit();

              echo("<h3>Local</h3>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td>Morada Local</td></tr>\n");

              foreach($result as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['moradalocal']}</td>\n");
                  echo("<td><a href=\"listarmeiossocorrolocal.php?moradalocal={$row['moradalocal']}\">Listar Meios de Socorro Acionados</a></td>\n");
                  echo("<td><a href=\"removerlocal.php?moradalocal={$row['moradalocal']}\">Remover Local</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table>\n");

              echo("<h3>Inserir Local</h3>");
              echo("<form action='inserirlocal.php' method='post'>");
              echo("<p>Morada Local: <input type='text' name='moradalocal'/></p>");
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
