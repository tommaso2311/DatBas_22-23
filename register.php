<?php
try {
    $conn = new PDO('mysql:host=localhost; dbname=DATABASE_PROJ', 'root', 'root');
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo ("[ERRORE] Connessione al DB non riuscita. Errore: " . $e->getMessage());
    exit();
}


$email = $_POST['email'];
try {
    $sql = "INSERT INTO UTENTI (eMail) VALUES ('$email')";
    $conn->exec($sql);
    echo "aggiunto";

} catch (PDOException $e) {
    if ($e->errorInfo[1] == 1062) { // errore di duplicazione
        echo "Esiste già";
    }
}



?>