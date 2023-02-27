<!DOCTYPE html>
<html lang="<?php echo $language; ?>">

<!--
   <label for="Nome">Nome </label>
      <input type="text" name="Nome" id="Nome" placeholder="Nome">

      <label for="Cognome">Cognome </label>
      <input type="text" name="Cognome" id="Cognome" placeholder="Cognome">

      <label for="email">e-mail
      </label><input type="email" name="email" id="email" placeholder="e-mail">

     questa parte di stile va nel CSS 
    -->

<head>

  <title>Progetto di Basi di Dati 2022-23</title>
  <style>
    form {
      display: flex;
      flex-direction: column;
      width: 300px;
    }
  </style>


</head>

<body>
  <h1>Progetto di Basi di Dati 2022-23</h1>
  <?php
  require_once 'connect.php';
  ?>
  <html>

  <body>
    <form action="register.php" method="post">
      <h2>Registrati </h2>

      <label for="email">e-mail </label>
      <input type="email" name="email" id="email" placeholder="e-mail">

      <input type="submit" value="invia">
  </body>

  </html>
</body>

</html>