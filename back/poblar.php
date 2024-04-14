<?php
header('Access-Control-Allow-Origin: *');


$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

/*************************************************************************************************************/



/*************************************************************************************************************/
$stmt->close();
$conn->close();
?>
