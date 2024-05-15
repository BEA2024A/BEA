<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$data = json_decode(file_get_contents("php://input"), true);
$id = $data['id'];

//recuperar la URL de la imagen del psicólogo a eliminar
$sql = "SELECT imagen FROM psicologos WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

if ($row) {
    $imagenUrl = $row['imagen'];
    // Extraer el nombre del archivo de la URL
    $parts = parse_url($imagenUrl);
    $path = $_SERVER['DOCUMENT_ROOT'] . $parts['path'];

    // Eliminar el archivo de imagen
    if (file_exists($path)) {
        unlink($path);
    }

    // Proceder a eliminar el registro del psicólogo
    $sqlDelete = "DELETE FROM psicologos WHERE id = ?";
    $stmtDelete = $conn->prepare($sqlDelete);
    $stmtDelete->bind_param("i", $id);
    if ($stmtDelete->execute()) {
        echo json_encode(["success" => true, "message" => "Psicólogo y su imagen eliminados con éxito"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al eliminar el psicólogo"]);
    }
    $stmtDelete->close();
} else {
    echo json_encode(["success" => false, "message" => "Psicólogo no encontrado"]);
}

$stmt->close();
$conn->close();
?>
