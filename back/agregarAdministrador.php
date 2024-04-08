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
$query = "SELECT * FROM administradores WHERE ID_ALUMNO = '$ID_ALUMNO'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "El ID ya está registrado.";
    $conn->close();
    exit();
}

// Verificar si el correo ya existe en la base de datos
$query = "SELECT * FROM administradores WHERE CORREO = '$CORREO'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    echo "El correo ya está en uso con otro administrador.";
    $conn->close();
    exit();
}

// Si no hay duplicados, proceder con el registro
$NOMBRE = $_POST['NOMBRE'];
$APELLIDO_PATERNO = $_POST['APELLIDO_PATERNO'];
$APELLIDO_MATERNO = $_POST['APELLIDO_MATERNO'];
$CONTRASEÑA = hash('sha256', $_POST['CONTRASEÑA']);


$sql = "INSERT INTO administradores (ID_ALUMNO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, CORREO, CONTRASEÑA) 
VALUES ('$ID_ALUMNO', '$NOMBRE', '$APELLIDO_PATERNO', '$APELLIDO_MATERNO', '$CORREO', '$CONTRASEÑA')";

if ($conn->query($sql) === TRUE) {
    echo "Registro exitoso";
} else {
    echo "Error al registrar el administrador: " . $conn->error;
}

$conn->close();
?>