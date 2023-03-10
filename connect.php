<?php
function connectToDatabase()
{
   $config = [
      $hostname = "localhost",
      $dbname = "DATABASE_PROJ",
      $user = "root", // da cambiare con i vostri dati
      $pass = "password", // da cambiare con i vostri dati
   ];

   try {
      $conn = new PDO("mysql:host=$hostname;dbname=$dbname", $user, $pass);
      $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $conn;
   } catch (PDOException $pe) {
      die("Could not connect to the database $dbname :" . $pe->getMessage());
   }
}

?>