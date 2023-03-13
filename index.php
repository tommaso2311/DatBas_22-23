<!DOCTYPE html>
<html lang="<?php echo $language; ?>">


<head>

  <title>Progetto di Basi di Dati 2022-23</title>
  <link rel="stylesheet" href="styles.css">

</head>

<body>
  <h1 id="title">Progetto di Basi di Dati 2022-23</h1>
  <?php
  require_once 'connect.php';
  $msg = '';
  if (isset($_GET['error']) && $_GET['error'] == 1) {
    $msg = "Credenziali sbagliate";
  }

  ?>
  <html>

  <body>
    <form action="login.php" method="head">
      <h2>Effettua il login se hai già un account</h2>
      <?php
      if ($msg != '') {
        echo "<font color='red'>" . $msg . "</font>";
      }
      ?>
      <label for="emailL">e-mail:</label>
      <input type="email" name="emailL" id="emailL" placeholder="e-mail">
      <input type="submit" value="LogIn">
    </form>

    <form action="registerPage.php" method="post">
      <h2>Registrati</h2>
      <input type="submit" value="invia">
    </form>
  </body>

  </html>
</body>

</html>