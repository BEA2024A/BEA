<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";;

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, nombre, tipo AS puesto, imagen FROM psicologos";
$result = $conn->query($sql);

$psicologos = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $row['perfil'] = '/ps1';  
        $psicologos[] = $row;
    }
    echo json_encode($psicologos);
} else {
    echo json_encode([]);
}

$conn->close();
?>
