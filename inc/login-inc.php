<?php
// Sitzung starten, damit der Benutzer eingeloggt bleibt
session_start();

// echo $_POST['email'], $_POST['password'];

if (isset($_POST['submit'])) {

    include 'db.php';

    $email = mysqli_real_escape_string($connection, $_POST['email']);
    $password = mysqli_real_escape_string($connection, $_POST['password']);

    // Error handlers
    // Existiert der Benutzername?
    $sql = "SELECT * FROM verfasser WHERE email = '$email'";
    $result = mysqli_query($connection, $sql);
    
  
    echo '<table border="1">';
while ($zeile = mysqli_fetch_array( $result, MYSQLI_ASSOC))
{
  echo "<tr>";
  echo "<td>". $zeile['Name'] . "</td>";
  echo "<td>". $zeile['Email'] . "</td>";
  echo "<td>". $zeile['Passwort'] . "</td>";
  echo "</tr>";
}
echo "</table>"; 

    // mysqli_num_rows gibt die Anzahl an, wie oft die Bedingung von $sql erfüllt wird
    $resultCheck = mysqli_num_rows($result);
    echo '/ result', $resultCheck;

    if ($resultCheck < 1) {
        //?login=user gibt die Information an die index.php weiter";
        header("Location: ../index.php?login=email");
        exit();
    } else {
        echo "Ist das Passwort korrekt?\n";
        // Die Variable row wird als Array mit den Informationen aus der Datenbank befüllt
        while ($row = $result->fetch_assoc()) {
            printf("%s (%s)\n", $row["Name"], $row["Passwort"]);
        }

        if ($row = mysqli_fetch_assoc($result)) {
            echo $row['Email'];
            echo $row['id_verfasser'];
            echo $row['Passwort'];
            // De-Hashing des Passwortes 
            // password_verify($password, $row['password']) gibt true oder false zurück
            $hashedPassword = password_verify($password, $row['Passwort']);
           
            if ($hashedPassword == false) {
                
                
                header("Location: ../index.php?login=password");
                exit();
              // elseif fängt unvorhergesehene Fehler ab
            } elseif($hashedPassword == true){
              // Benutzer anmelden
              $_SESSION['session_id'] = $row['id-verfasser'];
              /*$_SESSION['session_user'] = $row['user'];
              $_SESSION['session_name'] = $row['name'];
              $_SESSION['session_rolle'] = $row['rolle']; */
              header("Location: ../dashboard.php");
              exit();
            }
        }
    }

} else {
    header("Location: ../index.php?login=error");
    exit();
}
