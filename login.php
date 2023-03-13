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
    
    function redirect( $statusCode = 401)
    {
        header('Location: /index.php', true, $statusCode);
        die();
    }
    
    if ($isLogged['result']==1){
    echo "Benvenuto";
    } else {
        
    } 
} catch (PDOException $e) {
    echo ("[ERRORE] Query SQL (Insert) non riuscita. Errore: " . $e->getMessage());
    exit();
}
?>