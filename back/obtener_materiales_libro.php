<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$sql = "SELECT id, nombre, autor, area, tipo, link, imagen FROM materiales WHERE tipo = 'libro'";
$result = $conn->query($sql);

$materiales = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $materiales[] = $row;
    }
    echo json_encode($materiales);
} else {
    echo json_encode([]);
}

$conn->close();
?>
