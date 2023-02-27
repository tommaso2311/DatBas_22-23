<?php
$config = [
   $host = "localhost",
   $dbname = "DATABASE_PROJ",
   $username = "root",
   $password = "root",
];

try {
   $conn = new PDO('mysql:host=localhost; dbname=DATABASE_PROJ', 'root', 'root');
   echo "Connected to $dbname at $host successfully." . "</br>";
} catch (PDOException $pe) {
   die("Could not connect to the database $dbname :" . $pe->getMessage());
}