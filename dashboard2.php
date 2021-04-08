<?php

session_start();

?>
<html>
<head>
  <title>Dashboard</title>
</head>
<body>
<h1>Dashboard II</h1>

<?php

if (isset($_SESSION['session_user'])) {
    echo "<h2>Du bist immer noch angemeldet</h2>";
} else {
    echo "<h2>Du bist nicht angemeldet</h2>";
};

?>
<br>

<form action="inc/logout-inc.php" method="POST">
   <button type="submit" name="submit">Ausloggen</button>
</form>

<br>
<a href="dashboard.php">Seite I</a>

</body>
</html>