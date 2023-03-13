<?php


$email = $_POST['emailLogin'];
try {
    $log = "SELECT COUNT(*) AS counter FROM UTENTE WHERE ('$email'=eMail)";
    $res = $conn->prepare($log);
    $res->execute();

} catch (PDOException $e) {
}

$row = $res->fetch();
if ($row['counter'] > 0) {
    session_start();
    echo "loggato!";
} else {
    echo "non esisti!";
}

?>