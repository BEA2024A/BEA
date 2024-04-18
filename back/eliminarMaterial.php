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

// Primero, recuperar la URL de la imagen del material a eliminar
$sql = "SELECT imagen FROM materiales WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

if ($row) {
    $imageUrl = $row['imagen'];
    // Extraer el nombre del archivo de la URL
    $parts = parse_url($imageUrl);
    $path = $_SERVER['DOCUMENT_ROOT'] . $parts['path'];

    // Eliminar el archivo de imagen
    if (file_exists($path)) {
        unlink($path);
    }

    // Proceder a eliminar el registro del material
    $sqlDelete = "DELETE FROM materiales WHERE id = ?";
    $stmtDelete = $conn->prepare($sqlDelete);
    $stmtDelete->bind_param("i", $id);
    if ($stmtDelete->execute()) {
        echo json_encode(["success" => true, "message" => "Material y su imagen eliminados con éxito"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al eliminar el material"]);
    }
    $stmtDelete->close();
} else {
    echo json_encode(["success" => false, "message" => "Material no encontrado"]);
}

$stmt->close();
$conn->close();
?>
