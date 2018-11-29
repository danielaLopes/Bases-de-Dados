<html>
    <body>
<?php
    $oldnummeio = $_REQUEST['oldnummeio'];
    $oldnomeentidade = $_REQUEST['oldnomeentidade'];
    $newnummeio = $_REQUEST['newnummeio'];
    $newnomeentidade = $_REQUEST['newnomeentidade'];
    $table = $_REQUEST['table'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist186458";
        $password = "bd2018yas";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->beginTransaction();

        $sql1 = "UPDATE meio SET nummeio = :newnummeio, nomeentidade = :newnomeentidade WHERE (nummeio = :oldnummeio and nomeentidade = :oldnomeentidade);";

        $result1 = $db->prepare($sql1);
        $result1->execute(array($newnummeio, $newnomeentidade, $oldnummeio, $oldnomeentidade));

        $db->commit();

        echo("<p>O meio representado pelo numero do meio: {$newnummeio} e pelo nome da entidade: {$newnomeentidade} foi atualizado.</p>");
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
