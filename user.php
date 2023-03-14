<?php
    session_start();
        require_once 'connect.php';
        $user = $_SESSION['name'];
      ?>
<!DOCTYPE html>
<html lang="it">
<head>
  <title>Progetto di Basi di Dati 2022-23</title>
  <link rel="stylesheet" href="styles.css">
</head>

<body>

   <header class="main-header">
   	<h1 id="title">Progetto di Basi di Dati 2022-23</h1>
   	<h2 id="subtitle">Benvenuto <?=$user?></h2>
   </header> 
  
<div class="container">
  <div class="userMenu">
  		<form method="get">
  			<input type="submit" class="userBtn" value="Visualizza inviti" name="inviti"> 
			<input type="submit" class="userBtn" value="Visualizza sondaggio" name="sondaggio"> 
  	</form>
  </div>
  	
  <div class="view">
  
  </div>
</div>
</body>

</html>