<?php
require 'connect.php';
$conn = connectToDatabase();

$email = $_POST['email'];

try {
    $insert = "INSERT INTO UTENTE (eMail) VALUES ('$email')";
    $conn->query($insert);
    echo "Aggiunto";
} catch (PDOException $e) {
    echo ("[ERRORE] Query SQL (Insert) non riuscita. Errore: " . $e->getMessage());
    exit();
}



?>