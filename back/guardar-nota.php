<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}


$fecha = $_POST['fecha'];
$contenido = $_POST['contenido'];
$id_administrador = $_POST['id_administrador'];
$id_alumno = $_POST['id_alumno'];

// Verificar si es la primera sesión del usuario
$sql = "SELECT * FROM notas WHERE id_alumno = $id_alumno";
$result = $conn->query($sql);

if ($result->num_rows == 0) {
    // Es la primera sesión del usuario
    $numero_sesion = 1;
} else {
    // Obtener el último número de sesión registrado para el usuario
    $sql = "SELECT MAX(numero_sesion) AS ultimo_numero_sesion FROM notas WHERE id_alumno = $id_alumno";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    $ultimo_numero_sesion = $row['ultimo_numero_sesion'];
    // Calcular el número de sesión para la nueva nota
    $numero_sesion = $ultimo_numero_sesion + 1;
}

//  insertar la nota en la tabla
$sql = "INSERT INTO notas (numero_sesion, fecha, contenido, id_administrador, id_alumno) 
        VALUES ($numero_sesion, '$fecha', '$contenido', $id_administrador, $id_alumno)";


if ($conn->query($sql) === TRUE) {
    
    echo "Nota guardada exitosamente";
} else {
   
    echo "Error al guardar la nota: " . $conn->error;
}


$conn->close();
?>
