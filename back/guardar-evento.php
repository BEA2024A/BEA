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

$idUsuario = $_POST['id_usuario'];
$titulo = $_POST['titulo'];
$fecha = $_POST['fecha'];
$hora = $_POST['hora'];
$color = $_POST['color'];



$sql = "INSERT INTO eventos (id_usuario, titulo, fecha, hora, color) VALUES (?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("issss", $idUsuario, $titulo, $fecha, $hora, $color);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $conn->error]);
}

$stmt->close();
$conn->close();
?>

