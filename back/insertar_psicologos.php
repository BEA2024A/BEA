<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Content-Type: application/json; charset=UTF-8');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$nombre = $_POST['NOMBRE'];
$tipo = $_POST['TIPO'];
$telefono = $_POST['TELEFONO'];
$especialidad = $_POST['ESPECIALIDAD'];
$direccion = $_POST['DIRECCION'];
$poblacion = $_POST['POBLACION'];
$formacion = $_POST['FORMACION'];
$modalidad = $_POST['MODALIDAD'];
$imagenes = $_POST['IMAGENES'];

$sql = "INSERT INTO psicologos (nombre, tipo, telefono, especialidad, direccion, poblacion, formacion, modalidad, imagenes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sssssssss", $nombre, $tipo, $telefono, $especialidad, $direccion, $poblacion, $formacion, $modalidad, $imagenes);

if ($stmt->execute()) {
    echo "Registro exitoso";
} else {
    echo "Error al registrar el psicólogo: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
