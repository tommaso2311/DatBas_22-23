<!DOCTYPE html>

<?php
require 'connect.php';
$conn = connectToDatabase();
?>

<html>
<style>
    form {
        display: flex;
        flex-direction: column;
        width: 300px;
    }
</style>

<body>

    <form action="register.php" method="post">

        <label for="email">e-mail:</label>
        <input type="email" name="email" id="email" placeholder="e-mail">

        <label for="name">Nome: </label>
        <input type="text" name="nome" id="name" placeholder="nome">

        <label for="lastname">Cognome:</label>
        <input type="text" name="cognome" id="lastname" placeholder="cognome">

        <label for="a">Anno di Nascita: </label>
        <input type="number" name="annoNascita" min="1900" max="2023" step="1" placeholder="anno di nascita" id="anno">

        <label for="luogo">Luogo di Nascita: </label>
        <input type="text" name="luogoNascita" placeholder="luogo di nascita" id="luogo">

        <input type="submit" value="invia">

    </form>
</body>

</html>