<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

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

// Leer los datos del formulario
$data = json_decode(file_get_contents("php://input"), true);

$id_usuario = $data['id_usuario'];
$nombre = $data['nombre'];
$a_paterno = $data['a_paterno'];
$a_materno = $data['a_materno'];
$carrera = 'gnreiei';
$semestre = $data['semestre'];
$motivo = $data['motivo'];
$expectativa = $data['expectativa'];

// Obtener un ID de psicólogo al azar
$query = "SELECT ID_ALUMNO FROM administradores ORDER BY RAND() LIMIT 1";
$result = $conn->query($query);
$row = $result->fetch_assoc();
$id_psicologo = $row['ID_ALUMNO'];

// Insertar la cita
$sql = "INSERT INTO citas (id_alumno, nombre, a_paterno, a_materno, carrera, semestre, motivo, expectativas, id_psicologo) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("isssisssi", $id_usuario, $nombre, $a_paterno, $a_materno, $carrera, $semestre, $motivo, $expectativa, $id_psicologo);

// Ejecutar y enviar la respuesta
if ($stmt->execute()) {
  echo json_encode(["mensaje" => "Cita guardada exitosamente."]);
} else {
  echo json_encode(["mensaje" => "Error al guardar la cita: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
