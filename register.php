<?php
require 'connect.php';
$conn = connectToDatabase();

$email = $_POST['email'];
$nome = $_POST['nome'];
$cognome = $_POST['cognome'];
$anno = $_POST['annoNascita'];
$luogo = $_POST['luogoNascita'];

try {
    $insert = "CALL RegistrazioneUtente('$email', '$nome', '$cognome','$anno','$luogo')";
    $conn->query($insert);
    echo "Aggiunto";
} catch (PDOException $e) {
    echo ("[ERRORE] Query SQL (Insert) non riuscita. Errore: " . $e->getMessage());
    exit();
}



?>