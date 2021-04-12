<?php
// Kontakt zur Datenbank herstellen nach dem Muster
// Serveradress, Benutzername, Passwort, Datenbankname
// alt: $connection = mysqli_connect('localhost', 'root', '', 'loginformular');

// http://localhost:8888/phpMyAdmin/db_structure.php?db=DB_LackTracking

$connection = mysqli_connect("localhost", "root", "root", "DB_LackTracking");
if(!$connection)
{
  exit("Verbindungsfehler: ".mysqli_connect_error());
}