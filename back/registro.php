<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$ID_ALUMNO = $_POST['ID_ALUMNO'];
$CORREO = $_POST['CORREO'];

// Verificar si el ID ya existe en la base de datos
$query = "SELECT * FROM registro WHERE ID_ALUMNO = '$ID_ALUMNO'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "El ID ya está registrado. Por favor, inicia sesión con tu cuenta.";
    $conn->close();
    exit();
}

// Verificar si el correo ya existe en la base de datos
$query = "SELECT * FROM registro WHERE CORREO = '$CORREO'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "El correo ya está en uso con otra cuenta.";
    $conn->close();
    exit();
}

// Si no hay duplicados, proceder con el registro
$NOMBRE = $_POST['NOMBRE'];
$APELLIDO_PATERNO = $_POST['APELLIDO_PATERNO'];
$APELLIDO_MATERNO = $_POST['APELLIDO_MATERNO'];
$CONTRASEÑA = hash('sha256', $_POST['CONTRASEÑA']);
$FOTO_PERFIL = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'; // URL de la imagen de perfil predeterminada

$sql = "INSERT INTO registro (ID_ALUMNO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, CORREO, CONTRASEÑA, foto_perfil) 
VALUES ('$ID_ALUMNO', '$NOMBRE', '$APELLIDO_PATERNO', '$APELLIDO_MATERNO', '$CORREO', '$CONTRASEÑA', '$FOTO_PERFIL')";

if ($conn->query($sql) === TRUE) {
    echo "Registro exitoso";
} else {
    echo "Error al registrar el usuario: " . $conn->error;
}

$conn->close();
?>
