<?php
require 'connect.php';
$conn = connectToDatabase();

$email = $_GET['emailL'];

try {
   
    $exists = "CALL Login('$email', @result)";
    $result= $conn ->query($exists);
    $select = "SELECT @result as result";
    $result= $conn ->query($select);
    $isLogged = $result->fetch();

    
    if ($isLogged['result']==1){
    echo "Benvenuto";
    } else {
        header("Location: /index.php?status=401");
        exit();
    } 
} catch (PDOException $e) {
    echo ("[ERRORE] Query SQL (Insert) non riuscita. Errore: " . $e->getMessage());
    exit();
}
?>