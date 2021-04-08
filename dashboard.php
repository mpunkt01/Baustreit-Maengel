<?php
session_start();
?>

<html>
<head>
  <title>Dashboard</title>
</head>
<body>
<h1>Dashboard I</h1>

<?php
// In der If-Abfrage wird abgefragt, ob die beim Login
// gestartete Session aktiv ist
if (isset($_SESSION['session_user'])) {
    echo "<h2>Du bist angemeldet</h2>";
} else {
// Ist keine Session aktiv, kommt diese Anzeige:
    echo "<h2>Du bist nicht angemeldet</h2>";
};

?>
<br>
<!-- Hier binden wir einen Logout-Button ein -->
<form action="inc/logout-inc.php" method="POST">
   <button type="submit" name="submit">Ausloggen</button>
</form>
<br>
<a href="dashboard2.php">Seite II</a>

</body>
</html>