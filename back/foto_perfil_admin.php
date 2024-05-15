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

// Obtener el nombre de la imagen 
$imageFile = $_FILES['imagen']['name'];

// Ruta donde se guardará la imagen
$target_dir = "uploads/";
$target_file = $target_dir . basename($imageFile);

// Mover la imagen al directorio de uploads
if (move_uploaded_file($_FILES['imagen']['tmp_name'], $target_file)) {
    // URL completa de la imagen
    $imageUrl = 'http://localhost/BEA/back/uploads/' . basename($imageFile);

    // ID del usuario logueado
    $idUsuario = $_POST['id_usuario'];

    // Consulta SQL para actualizar el campo foto_perfil del usuario
    $sql = "UPDATE administradores SET foto_perfil = '$imageUrl' WHERE id_alumno = '$idUsuario'";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true, "message" => "Foto de perfil actualizada correctamente", "imageUrl" => $imageUrl]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al actualizar la foto de perfil: " . $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Error al subir la imagen"]);
}

$conn->close();
?>