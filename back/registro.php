<?php
$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$ID_ALUMNO = $_POST['ID_ALUMNO'];
$NOMBRE = $_POST['NOMBRE'];
$APELLIDO_PATERNO = $_POST['APELLIDO_PATERNO'];
$APELLIDO_MATERNO = $_POST['APELLIDO_MATERNO'];
$CORREO = $_POST['CORREO'];
$CONTRASEÑA = $_POST['CONTRASEÑA'];

$sql = "INSERT INTO registro (ID_ALUMNO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, CORREO, CONTRASEÑA) 
VALUES ('$ID_ALUMNO', '$NOMBRE', '$APELLIDO_PATERNO', '$APELLIDO_MATERNO', '$CORREO', '$CONTRASEÑA')";

if ($conn->query($sql) === TRUE) {
    echo "Registro exitoso";
} else {
    echo "Error al registrar el usuario: " . $conn->error;
}

$conn->close();
?>