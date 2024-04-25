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
    $imageUrl = 'http://localhost/BEA/back/uploads/' . basename($imageFile);
    
    // Obtener el valor de la imagen de fondo seleccionada
    $imagenFondo = $_POST['imagen_fondo'];

    $nombre = strtoupper($_POST['nombre']);
    $tipo = strtoupper($_POST['tipo']);
    $telefono = $_POST['telefono'];
    $especialidad = $_POST['especialidad'];
    $direccion = $_POST['direccion'];
    $poblacion = $_POST['poblacion'];
    $formacion = $_POST['formacion'];
    $modalidad = $_POST['modalidad'];

    $sql = "INSERT INTO psicologos (nombre, tipo, telefono, especialidad, direccion, poblacion, formacion, modalidad, imagen, imagen_fondo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("ssssssssss", $nombre, $tipo, $telefono, $especialidad, $direccion, $poblacion, $formacion, $modalidad, $imageUrl, $imagenFondo);
        $executed = $stmt->execute();
        if ($executed) {
            echo json_encode(["success" => true, "message" => "Psicólogo registrado con éxito", "imageUrl" => $imageUrl]);
        } else {
            echo json_encode(["success" => false, "message" => "Error al registrar el psicólogo: " . $stmt->error]);
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
