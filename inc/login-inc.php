<?php
// Sitzung starten, damit der Benutzer eingeloggt bleibt
session_start();

if (isset($_POST['submit'])) {

    include 'db.php';

    $email = mysqli_real_escape_string($connection, $_POST['email']);
    $password = mysqli_real_escape_string($connection, $_POST['password']);

    // Error handlers
    // Existiert der Benutzername?
    $sql = "SELECT * FROM verfasser WHERE Email = '$email'";
    $result = mysqli_query($connection, $sql);
    // mysqli_num_rows gibt die Anzahl an, wie oft die Bedingung von $sql erfüllt wird
    $resultCheck = mysqli_num_rows($result);
    if ($result < 1) {
        // ?login=user gibt die Information an die index.php weiter
        header("Location: ../index.php?login=email");
        exit();
    } else {
        // Ist das Passwort korrekt?
        // Die Variable row wird als Array mit den Informationen aus der Datenbank befüllt
        if ($row = mysqli_fetch_assoc($result)) {
            // De-Hashing des Passwortes 
            // password_verify($password, $row['password']) gibt true oder false zurück
            $hashedPassword = password_verify($password, $row['password']);
            if ($hashedPassword == false) {
                header("Location: ../index.php?login=password");
                exit();
              // elseif fängt unvorhergesehene Fehler ab
            } elseif($hashedPassword == true){
              // Benutzer anmelden
              $_SESSION['session_id'] = $row['id'];
              $_SESSION['session_user'] = $row['user'];
              $_SESSION['session_firstname'] = $row['firstname'];
              $_SESSION['session_lastname'] = $row['lastname'];
              header("Location: ../dashboard.php");
              exit();
            }
        }
    }

} else {
    header("Location: ../index.php?login=error");
    exit();
}