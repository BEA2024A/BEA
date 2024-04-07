<?php

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');


$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";
$idUsuario = $_GET['idUsuario']; 

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$sql = "SELECT titulo, fecha, hora, color FROM eventos WHERE id_usuario = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idUsuario);
$stmt->execute();
$result = $stmt->get_result();

$eventos = array();

while($row = $result->fetch_assoc()) {
    $eventos[] = array(
        'title' => $row['titulo'],
        'date' => $row['fecha'],
        'time' => $row['hora'],
        'color' => $row['color']
    );
}

echo json_encode($eventos);

$conn->close();
?>
