<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json; charset=UTF-8');
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

$data = json_decode(file_get_contents("php://input"), true);

$id_usuario = $data['id_usuario'];
$titulo = $data['titulo'];
$fecha = $data['fecha'];
$hora = $data['hora'];
$color = $data['color'];

$sql = "INSERT INTO eventos (id_usuario, titulo, fecha, hora, color) VALUES (?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("issss", $id_usuario, $titulo, $fecha, $hora, $color);

if ($stmt->execute()) {
  echo json_encode(["mensaje" => "Evento guardado exitosamente."]);
} else {
  echo json_encode(["mensaje" => "Error al guardar el evento: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
