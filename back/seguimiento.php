<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$ID_ALUMNO = $_POST['ID_ALUMNO'];
$EXPECTATIVA = $_POST['EXPECTATIVA'];


$sql = "INSERT INTO seguimiento (ID_ALUMNO, EXPECTATIVA)
VALUES ('$ID_ALUMNO','$EXPECTATIVA')";

if ($conn->query($sql) === TRUE) {
    echo "seguimiento registrado exitosamente";
} else {
    echo "Error al registrar la seguimiento: " . $conn->error;
}

$conn->close();
?>
