<?php
    session_start();
        require_once 'connect.php';
        $conn = connectToDatabase();
        $user = $_SESSION['name'];
        $query='';
        if(isset($_GET['inviti'])){
            $query = "CALL VisualizzaInviti('$user')";
        } else if(isset($_GET['sondaggio'])){
            $query = "CALL VisualizzaSondaggio('$user')";
        }
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
  		<form method="get" target="visualizza">
  			<input type="submit" class="userBtn" value="Visualizza Inviti" name="inviti"> 
			<input type="submit" class="userBtn" value="Visualizza sondaggio" name="sondaggio"> 
  	</form>
  </div>
  	
  <div class="view" id="visualizza">
  	 <?php    
 try{ 
     if($query != ''){
        $result = $conn -> query($query);
     }
 } catch (PDOException $e) {
    echo ("[ERRORE] Query SQL (Visualizza Inviti) non riuscita. Errore: " . $e->getMessage());
    exit();
 }
 foreach($result as $row){
     echo "<p id=''> Mittente: ".$row['Autore']." <br> Codice Sondaggio: ".$row['codiceSondaggio']."</p>";
 }
 ?>
  </div>
</div>
</body>

</html>

  			
  			
  			
  			
  			