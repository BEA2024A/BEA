<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Recibe los datos del correo y contraseña 
$CORREO = $_POST['CORREO'];
$CONTRASEÑA = md5( $_POST['CONTRASEÑA']);

// Previene inyección SQL escapando los valores
$CORREO = mysqli_real_escape_string($conn, $CORREO);
$CONTRASEÑA = mysqli_real_escape_string($conn, $CONTRASEÑA);

// Consulta la base de datos para verificar las credenciales
$sql = "SELECT * FROM registro WHERE CORREO = '$CORREO' AND CONTRASEÑA = '$CONTRASEÑA'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Si la consulta devuelve al menos una fila las credenciales son correctas
    $fila = $result->fetch_assoc(); // Obtiene los datos del usuario
    // Prepara y envía la respuesta como JSON
    echo json_encode([
        'exito' => true,
        'nombreUsuario' => $fila['NOMBRE'],
        'correoUsuario' => $fila['CORREO'], 
        'idUsuario' => $fila['ID_ALUMNO'], 
        'a_paternoUsuario' => $fila['APELLIDO_PATERNO'], 
        'a_maternoUsuario' => $fila['APELLIDO_MATERNO'], 
    ]);
    
} else {
    // Si la consulta no devuelve ninguna fila, las credenciales son incorrectas
    echo json_encode(['exito' => false]);
}

$conn->close();
?>
