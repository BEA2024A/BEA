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

$idAlumno = $_POST['id_alumno'];
$titulo = $_POST['titulo'];
$fecha = $_POST['fecha'];
$hora = $_POST['hora'];
$color = $_POST['color'];
$idAdmin = $_POST['id_administrador'];

$sql = "INSERT INTO eventosAdmin (id_alumno, titulo, fecha, hora, color, id_administrador) VALUES (?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);

if ($stmt) {
    $stmt->bind_param("issssi", $idAlumno, $titulo, $fecha, $hora, $color, $idAdmin);
    if ($stmt->execute()) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "error" => $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "error" => "Error en la preparación de la consulta"]);
}

$conn->close();
?>
