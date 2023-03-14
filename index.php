<!DOCTYPE html>
<html lang="it">
<?php
        require_once 'connect.php';
        $msg='';
        if ((isset($_GET['status']) && $_GET['status']==401) ) {
                $msg = "Credenziali sbagliate";
            }
      ?>
<head>
  <title>Progetto di Basi di Dati 2022-23</title>
  <link rel="stylesheet" href="styles.css">
</head>

<body>

   <header class="main-header">
   	<h1 id="title">Progetto di Basi di Dati 2022-23</h1>
   </header> 
  
<div class="container">
  <div class="login">
  		<form action="login.php" method="head" class="indexForm">
  			<h2>Login</h2>
  			<h3>Accedi se hai già un account</h3>
  			<?php
                if($msg!='')
                {
                    echo "<font color='red' >".$msg."</font>";
                }
            ?>
  			<label for="emailL">e-mail:</label>
      		<input type="email" name="emailL" id="emailL" placeholder="e-mail" class="text">
      		<input type="submit" value="LogIn" class="submit">
  		</form>
  </div>
  	
  <div class="register">
    <form action="register.php" method="post" class="indexForm">
      	<h2>Registrati</h2>

      <label for="email">e-mail:</label>
      <input type="email" name="email" id="email" placeholder="e-mail" class="text">
      <label for="name">Nome: </label>
      <input type="text" name="nome" id="name" placeholder="nome" class="text">
      <label for="lastname">Cognome:</label>
      <input type="text" name="cognome" id="lastname" placeholder="cognome" class="text">
      <label for="a">Anno di Nascita: </label>
      <input type="number" name="annoNascita" min="1900" max="2023" step="1" placeholder="anno di nascita" id="anno" class="text">
      <label for="luogo">Luogo di Nascita: </label>
      <input type="text" name="luogoNascita" placeholder= "luogo di nascita" id="luogo" class="text">
      <input type="submit" value="Invia" class="submit">
     </form>
  </div>
</div>
</body>

</html>