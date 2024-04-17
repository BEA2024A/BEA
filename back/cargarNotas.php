<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Content-Type: application/json; charset=UTF-8');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$idAlumno = $_GET['idAlumno'];

// Consulta para obtener las notas del alumno
$sql = "SELECT numero_sesion, fecha, contenido FROM notas WHERE id_alumno = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idAlumno);
$stmt->execute();
$result = $stmt->get_result();

$notas = [];

// Recorrer los resultados y almacenar las notas en un array
while ($row = $result->fetch_assoc()) {
    $notas[] = [
        'numeroSesion' => $row['numero_sesion'],
        'fecha' => $row['fecha'],
        'contenido' => $row['contenido']
    ];
}

// Devolver las notas en formato JSON
echo json_encode($notas);

// Cerrar la conexión
$stmt->close();
$conn->close();
?>
