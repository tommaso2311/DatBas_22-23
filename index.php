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
        $msg='';
        if (isset($_GET['error']) && $_GET['error']== 1) {
                $msg = "Credenziali sbagliate";
            }
      ?>
  <html>

  <body>
  	<form action="login.php" method="head">
  	<h2>Effettua il login se hai già un account</h2>
  	<?php
        if($msg!='')
        {
          echo "<font color='red'>".$msg."</font>";
        }
    ?>
  	<label for="emailL">e-mail:</label>
      <input type="email" name="emailL" id="emailL" placeholder="e-mail">
      <input type="submit" value="LogIn" class="submit">
  	</form>
  	
    <form action="register.php" method="post">
      <h2>Registrati</h2>

      <label for="email">e-mail:</label>
      <input type="email" name="email" id="email" placeholder="e-mail">
      <label for="name">Nome: </label>
      <input type="text" name="nome" id="name" placeholder="nome">
      <label for="lastname">Cognome:</label>
      <input type="text" name="cognome" id="lastname" placeholder="cognome">
      <label for="a">Anno di Nascita: </label>
      <input type="number" name="annoNascita" min="1900" max="2023" step="1" placeholder="anno di nascita" id="anno">
      <label for="luogo">Luogo di Nascita: </label>
      <input type="text" name="luogoNascita" placeholder= "luogo di nascita" id="luogo">
      <input type="submit" value="Invia" class="submit">
     </form>
  </body>

  </html>
</body>

</html>