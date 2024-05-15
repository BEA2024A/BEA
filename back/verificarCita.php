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


$idUsuario = isset($_GET['idUsuario']) ? $_GET['idUsuario'] : '';


$sql = "SELECT * FROM citas WHERE ID_ALUMNO = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idUsuario); 
$stmt->execute();
$result = $stmt->get_result();


if ($result->num_rows > 0) {
    echo json_encode(['hasCita' => true]);
} else {
    echo json_encode(['hasCita' => false]);
}


$stmt->close();
$conn->close();
?>
