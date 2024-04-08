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

$CORREO = $_POST['CORREO'];
$CONTRASEÑA = hash('sha256', $_POST['CONTRASEÑA']);


$CORREO = mysqli_real_escape_string($conn, $CORREO);
$CONTRASEÑA = mysqli_real_escape_string($conn, $CONTRASEÑA);

// Intenta encontrar al usuario en la tabla de registros
$sql = "SELECT * FROM registro WHERE CORREO = '$CORREO' AND CONTRASEÑA = '$CONTRASEÑA'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $fila = $result->fetch_assoc();
    echo json_encode([
        'exito' => true,
        'nombreUsuario' => $fila['NOMBRE'],
        'correoUsuario' => $fila['CORREO'],
        'idUsuario' => $fila['ID_ALUMNO'],
        'tipoUsuario' => 'usuario',
    ]);
} else {
    // Intenta encontrar al usuario en la tabla de administradores
    $sqlAdmin = "SELECT * FROM administradores WHERE CORREO = '$CORREO' AND CONTRASEÑA = '$CONTRASEÑA'";
    $resultAdmin = $conn->query($sqlAdmin);

    if ($resultAdmin->num_rows > 0) {
        $filaAdmin = $resultAdmin->fetch_assoc();
        echo json_encode([
            'exito' => true,
            'nombreUsuario' => $filaAdmin['NOMBRE'],
            'correoUsuario' => $filaAdmin['CORREO'],
            'idUsuario' => $filaAdmin['ID_ALUMNO'],
            'tipoUsuario' => 'administrador',
        ]);
    } else {
        echo json_encode(['exito' => false]);
    }
}

$conn->close();
?>
