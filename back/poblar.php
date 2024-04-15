<?php
header('Access-Control-Allow-Origin: *');


$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

/*************************************************************************************************************/

$datosJson = file_get_contents('psicologos.json');
$psicologos = json_decode($datosJson, true);

foreach ($psicologos as $psicologo) {
    $stmt = $conn->prepare("INSERT INTO psicologos (nombre, tipo, telefono, especialidad, direccion, poblacion, formacion, modalidad, imagen) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssssss", $psicologo['nombre'], $psicologo['tipo'], $psicologo['telefono'], $psicologo['especialidad'], $psicologo['direccion'], $psicologo['poblacion'], $psicologo['formacion'], $psicologo['modalidad'], $psicologo['imagen']);
    $stmt->execute();
}

echo "Datos insertados exitosamente";

/*************************************************************************************************************/
$stmt->close();
$conn->close();
?>
