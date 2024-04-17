<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

// Crear conexión a la base de datos
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar si la conexión fue exitosa
if ($conn->connect_error) {
  die("Conexión fallida: " . $conn->connect_error);
}

// Obtener los datos del formulario
$numero_sesion = $_POST['numero_sesion'];
$fecha = $_POST['fecha'];
$contenido = $_POST['contenido'];
$id_administrador = $_POST['id_administrador'];
$id_alumno = $_POST['id_alumno'];

// Preparar la consulta SQL para insertar la nota en la tabla 'notas'
$sql = "INSERT INTO notas (numero_sesion, fecha, contenido, id_administrador, id_alumno) 
        VALUES ('$numero_sesion', '$fecha', '$contenido', '$id_administrador', '$id_alumno')";

// Ejecutar la consulta SQL
if ($conn->query($sql) === TRUE) {
  // Si la inserción fue exitosa, devolver un mensaje de éxito
  echo "Nota guardada exitosamente";
} else {
  // Si hubo un error, devolver el mensaje de error
  echo "Error al guardar la nota: " . $conn->error;
}

// Cerrar la conexión a la base de datos
$conn->close();
?>
