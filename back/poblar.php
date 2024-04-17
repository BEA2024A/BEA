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

// Función para obtener el ID del administrador asociado a la cita del alumno
function obtenerIdAdministrador($idAlumno) {
    global $conn;
    
    $sql = "SELECT ID_ADMIN FROM citas WHERE ID_ALUMNO = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $idAlumno);
    $stmt->execute();
    $stmt->bind_result($idAdmin);
    $stmt->fetch();
    $stmt->close();
    
    return $idAdmin;
}

// Función para insertar una nota en la tabla de notas
function insertarNota($numeroSesion, $fecha, $contenido, $idAlumno, $idAdmin) {
    global $conn;
    
    $sql = "INSERT INTO notas (numero_sesion, fecha, contenido, id_administrador, id_alumno) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("isssi", $numeroSesion, $fecha, $contenido, $idAdmin, $idAlumno);
    $stmt->execute();
    $stmt->close();
}

// Obtener los ID de los alumnos de la tabla registro
$alumnos = [];
$sqlAlumnos = "SELECT ID_ALUMNO FROM registro";
$resultAlumnos = $conn->query($sqlAlumnos);

if ($resultAlumnos->num_rows > 0) {
    while ($row = $resultAlumnos->fetch_assoc()) {
        $alumnos[] = $row["ID_ALUMNO"];
    }
}

// Insertar notas para cada alumno
foreach ($alumnos as $idAlumno) {
    // Obtener el ID del administrador asociado al alumno
    $idAdmin = obtenerIdAdministrador($idAlumno);
    
    // Insertar notas para el alumno
    for ($i = 1; $i <= 4; $i++) {
        // Generar fecha para la nota (todas del año 2024)
        $fecha = "2024-04-" . str_pad($i, 2, "0", STR_PAD_LEFT);
        
        // Contenido de la nota
        $contenido = "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.";
        
        // Insertar la nota en la tabla de notas
        insertarNota($i, $fecha, $contenido, $idAlumno, $idAdmin);
    }
}

// Cerrar la conexión
$conn->close();

// Mensaje de éxito
echo "Los datos se han insertado exitosamente.";
?>
