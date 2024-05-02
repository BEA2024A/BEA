<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: GET, POST');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$idAlumno = isset($_GET['idAlumno']) ? $_GET['idAlumno'] : die('ID not provided');

$sql = "SELECT r.NOMBRE, r.APELLIDO_PATERNO, r.APELLIDO_MATERNO, c.CARRERA, c.ID_ALUMNO, c.MOTIVO, c.EXPECTATIVA, r.foto_perfil
        FROM citas c 
        JOIN registro r ON c.ID_ALUMNO = r.ID_ALUMNO
        WHERE c.ID_ALUMNO = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idAlumno);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_assoc();

echo json_encode($data);

$stmt->close();
$conn->close();
?>
