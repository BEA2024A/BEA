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

$idAlumno = $_GET['idAlumno']; // Obtener el ID del alumno 

$sql = "SELECT EXPECTATIVA FROM seguimiento WHERE ID_ALUMNO = $idAlumno";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $no_seguimiento = 'el paciente aun no ha ddejado comentarios'
    $comentarios = array(
        'EXPECTATIVA' => $row['EXPECTATIVA']
    );
    echo json_encode($comentarios);
} else {
    echo json_encode($no_seguimiento); // Retorna un texto si no se encuentran comentarios
}

$conn->close();
?>
