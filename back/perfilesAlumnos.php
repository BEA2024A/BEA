<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Content-Type: application/json; charset=UTF-8');
header('Content-Type: application/json');


$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}


$idPsicologo = $_GET['idPsicologo'];


$sql = "SELECT r.NOMBRE, r.APELLIDO_PATERNO, r.APELLIDO_MATERNO, c.CARRERA, c.ID_ALUMNO 
        FROM citas c 
        JOIN registro r ON c.ID_ALUMNO = r.ID_ALUMNO
        WHERE c.ID_ADMIN = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idPsicologo);
$stmt->execute();
$result = $stmt->get_result();

$alumnos = [];

while ($row = $result->fetch_assoc()) {
    $nombreCompleto = $row['NOMBRE'] . ' ' . $row['APELLIDO_PATERNO'] . ' ' . $row['APELLIDO_MATERNO'];
    $alumnos[] = [
        'nombre' => $nombreCompleto,
        'carrera' => $row['CARRERA'],
        'ide' => $row['ID_ALUMNO'],
        'perfil' => '/perfil',
        'notas' => '/Notas',
        'imagen' => 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        'mostrarDescripcion' => false
    ];
}

echo json_encode($alumnos);

// Cerrar la conexión
$stmt->close();
$conn->close();
?>
