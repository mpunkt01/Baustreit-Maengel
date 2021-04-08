
<?php
// PHP-Funktion, damit über mehrere Seiten hinweg
// eine Session/Sitzung ermöglicht wird.
// Wir benötigen Sie auf allen unseren Seiten
// https://matterne.eu/ein-einfaches-login-registrierungsformular-php-sql-teil-1/

session_start();
?>
<html>
   <head>
     <title>Loginformular</title>
   </head>
<body>
<h1>Einloggen</h1>
<!-- mit action rufen wir das PHP-File auf, das die ganze Arbeit macht -->
<form action="inc/login-inc.php" method="POST">
  
   <input type="text" name="email" placeholder="Email"><br>
   <input type="password" name="password" placeholder="Passwort"><br>
   <button type="submit" name="submit">Login</button>
</form>
<br>
<a href="signup.php">Registrieren</a>

</body>
</html>