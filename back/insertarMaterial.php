<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Content-Type: application/json');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$target_dir = "uploads/";
$imageFile = $_FILES['imagen']['name'];
$target_file = $target_dir . basename($imageFile);

if (move_uploaded_file($_FILES['imagen']['tmp_name'], $target_file)) {
    $nombre = $_POST['nombre'];
    $autor = $_POST['autor'];
    $area = $_POST['area'];
    $tipo = $_POST['tipo'];
    $link = $_POST['link'];
    $imageUrl = 'http://localhost/BEA/back/uploads/' . basename($imageFile);

    $sql = "INSERT INTO materiales (nombre, autor, area, tipo, link, imagen) VALUES (?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("ssssss", $nombre, $autor, $area, $tipo, $link, $imageUrl);
        $executed = $stmt->execute();
        if ($executed) {
            echo json_encode(["success" => true, "message" => "Material registrado con éxito", "imageUrl" => $imageUrl]);
        } else {
            echo json_encode(["success" => false, "message" => "Error al registrar el material: " . $stmt->error]);
        }
        $stmt->close();
    } else {
        echo json_encode(["success" => false, "message" => "Error al preparar la consulta: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Error al subir la imagen"]);
}

$conn->close();
?>

