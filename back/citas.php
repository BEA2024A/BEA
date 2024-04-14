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
$CARRERA = $_POST['CARRERA'];
$SEMESTRE = $_POST['SEMESTRE'];
$MOTIVO = $_POST['MOTIVO'];
$EXPECTATIVA = $_POST['EXPECTATIVA'];

// Seleccionar un administrador al azar
$adminQuery = "SELECT ID_ALUMNO FROM administradores ORDER BY RAND() LIMIT 1";
$adminResult = $conn->query($adminQuery);
$ID_ADMIN = $adminResult->fetch_assoc()['ID_ALUMNO'];

$sql = "INSERT INTO citas (ID_ALUMNO, ID_ADMIN, CARRERA, SEMESTRE, MOTIVO, EXPECTATIVA)
VALUES ('$ID_ALUMNO', '$ID_ADMIN', '$CARRERA', '$SEMESTRE', '$MOTIVO', '$EXPECTATIVA')";

if ($conn->query($sql) === TRUE) {
    echo "Cita registrada exitosamente";
} else {
    echo "Error al registrar la cita: " . $conn->error;
}

$conn->close();
?>
