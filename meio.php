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

              $sql = "SELECT * FROM meio;";
              $sql1 = "SELECT * FROM meiocombate;";
              $sql2 = "SELECT * FROM meioapoio;";
              $sql3 = "SELECT * FROM meiosocorro;";

              $result = $db->prepare($sql);
              $result->execute();

              $result1 = $db->prepare($sql1);
              $result1->execute();

              $result2 = $db->prepare($sql2);
              $result2->execute();

              $result3 = $db->prepare($sql3);
              $result3->execute();

              $db->commit();

              /*meio-----------------------------------------------------------*/
              echo("<h3>Meio</h3>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td>Numero do Meio</td><td>Nome do Meio</td><td>Nome da Entidade</td></tr>\n");
              foreach($result as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['nummeio']}</td>\n");
                  echo("<td>{$row['nomemeio']}</td>\n");
                  echo("<td>{$row['nomeentidade']}</td>\n");
                  echo("<td><a href=\"associarameio.php?nummeio={$row['nummeio']}&nomeentidade={$row['nomeentidade']}\">Associar Processo</a></td>\n");
                  echo("<td><a href=\"removermeio.php?nummeio={$row['nummeio']}&nomeentidade={$row['nomeentidade']}\">Remover</a></td>\n");
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

              /*meios-----------------------------------------------------------*/
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td><h3>Meio de Combate</h3></td><td><h3>Meio de Apoio</h3></td><td><h3>Meio de Socorro</h3></td></tr>");

              /*meioCombate-----------------------------------------------------------*/
              echo("<tr><td><table>");
              echo("<tr><td>Numero do Meio</td><td>Nome da Entidade</td></tr>\n");
              foreach($result1 as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['nummeio']}</td>\n");
                  echo("<td>{$row['nomeentidade']}</td>\n");
                  echo("<td><a href=\"editarmeio.php?table=meiocombate&nummeio={$row['nummeio']}&&nomeentidade={$row['nomeentidade']}\">Editar</a></td>\n");
                  echo("<td><a href=\"removermeios.php?table=meiocombate&nummeio={$row['nummeio']}&nomeentidade={$row['nomeentidade']}\">Remover</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table></td>\n");

              /*meioApoio-----------------------------------------------------------*/
              echo("<td><table>");
              echo("<tr><td>Numero do Meio</td><td>Nome da Entidade</td></tr>\n");
              foreach($result2 as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['nummeio']}</td>\n");
                  echo("<td>{$row['nomeentidade']}</td>\n");
                  echo("<td><a href=\"editarmeio.php?table=meioapoio&nummeio={$row['nummeio']}&&nomeentidade={$row['nomeentidade']}\">Editar</a></td>\n");
                  echo("<td><a href=\"removermeios.php?table=meioapoio&nummeio={$row['nummeio']}&nomeentidade={$row['nomeentidade']}\">Remover</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table></td>\n");

              /*meioSocorro-----------------------------------------------------------*/
              echo("<td><table>");
              echo("<tr><td>Numero do Meio</td><td>Nome da Entidade</td></tr>\n");
              foreach($result3 as $row)
              {
                  echo("<tr>\n");
                  echo("<td>{$row['nummeio']}</td>\n");
                  echo("<td>{$row['nomeentidade']}</td>\n");
                  echo("<td><a href=\"editarmeio.php?table=meiosocorro&nummeio={$row['nummeio']}&&nomeentidade={$row['nomeentidade']}\">Editar</a></td>\n");
                  echo("<td><a href=\"removermeios.php?table=meiosocorro&nummeio={$row['nummeio']}&nomeentidade={$row['nomeentidade']}\">Remover</a></td>\n");
                  echo("</tr>\n");
              }
              echo("</table></td></tr>\n");

              /*meioCombate-----------------------------------------------------------*/
              echo("<tr><td>");

              echo("<form action='inserirmeios.php?table=meiocombate' method='post'>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td><h3>Inserir Meio de Combate</h3></td></tr>");
              echo("<tr><td>Numero do Meio: </td><td><input type='text' name='nummeio'/></td></tr>");
              echo("<tr><td>Nome do Meio: </td><td><input type='text' name='nomemeio'/></td></tr>");
              echo("<tr><td>Nome da Entidade: </td><td><input type='text' name='nomeentidade'/></td></tr>");
              echo("<tr><td><input type='submit' value='Inserir'/></td></tr></table>");
              echo("</form>");

              echo("</td>");

              /*meioApoio-----------------------------------------------------------*/
              echo("<td>");

              echo("<form action='inserirmeios.php?table=meioapoio' method='post'>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td><h3>Inserir Meio de Apoio</h3></td></tr>");
              echo("<tr><td>Numero do Meio: </td><td><input type='text' name='nummeio'/></td></tr>");
              echo("<tr><td>Nome do Meio: </td><td><input type='text' name='nomemeio'/></td></tr>");
              echo("<tr><td>Nome da Entidade: </td><td><input type='text' name='nomeentidade'/></td></tr>");
              echo("<tr><td><input type='submit' value='Inserir'/></td></tr></table>");
              echo("</form>");

              echo("</td>");

              /*meioSocorro-----------------------------------------------------------*/
              echo("<td>");

              echo("<form action='inserirmeios.php?table=meiosocorro' method='post'>");
              echo("<table border=\"0\" cellspacing=\"5\">\n");
              echo("<tr><td><h3>Inserir Meio de Socorro</h3></td></tr>");
              echo("<tr><td>Numero do Meio: </td><td><input type='text' name='nummeio'/></td></tr>");
              echo("<tr><td>Nome do Meio: </td><td><input type='text' name='nomemeio'/></td></tr>");
              echo("<tr><td>Nome da Entidade: </td><td><input type='text' name='nomeentidade'/></td></tr>");
              echo("<tr><td><input type='submit' value='Inserir'/></td></tr></table>");
              echo("</form>");

              echo("</td></tr>");


              echo("</table>\n");

              $db = null;

            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>
