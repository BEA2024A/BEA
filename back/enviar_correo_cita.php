<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=UTF-8');

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$servername = "localhost";
$username = "antonio";
$password = "g[TR_J@)tHtL]xGu";
$dbname = "bea";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$idUsuario = $_GET['idUsuario'];

// Obtener datos del alumno 
$alumnoQuery = "SELECT * FROM registro WHERE ID_ALUMNO = '$idUsuario'";
$alumnoResult = $conn->query($alumnoQuery);
$alumnoData = $alumnoResult->fetch_assoc();

// Obtener datos de la cita del alumno
$citaQuery = "SELECT * FROM citas WHERE ID_ALUMNO = '$idUsuario'";
$citaResult = $conn->query($citaQuery);
$citaData = $citaResult->fetch_assoc();

// Obtener datos del administrador asignado al alumno 
$adminId = $citaData['ID_ADMIN'];
$adminQuery = "SELECT CORREO FROM administradores WHERE ID_ALUMNO = '$adminId'";
$adminResult = $conn->query($adminQuery);
$adminCorreo = $adminResult->fetch_assoc()['CORREO'];

// correo
$mensaje = "
    <h2>Se te ha asignado un nuevo paciente:</h2>
    <ul>
        <li><strong>Nombre completo:</strong> {$alumnoData['NOMBRE']} {$alumnoData['APELLIDO_PATERNO']} {$alumnoData['APELLIDO_MATERNO']}</li>
        <li><strong>ID:</strong> {$idUsuario}</li>
        <li><strong>Carrera:</strong> {$citaData['CARRERA']}</li>
        <li><strong>Semestre:</strong> {$citaData['SEMESTRE']}</li>
        <li><strong>Correo:</strong> {$alumnoData['CORREO']}</li>
    </ul>
    <br>
    <button style='padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; text-decoration: none; cursor: pointer;'>
        <a href='http://localhost:5173/perfil/{$idUsuario}' style='text-decoration: none; color: white;'>Ver perfil del alumno</a>
    </button>
";


// Enviar correo al administrador
$mail = new PHPMailer(true);
try {
    $mail->isSMTP();
    $mail->Host = 'smtp.office365.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'bienestar_emocional_uao@outlook.com';
    $mail->Password = 'BienestarEmocionalAnahuac4602';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    $mail->setFrom('bienestar_emocional_uao@outlook.com', 'Bienestar Emocional UAO');
    $mail->addAddress($adminCorreo); 

    $mail->isHTML(true);
    $mail->Subject = 'Nuevo paciente asignado';
    $mail->Body = $mensaje;

    $mail->send();
    echo 'El mensaje ha sido enviado';
} catch (Exception $e) {
    echo "El mensaje no pudo ser enviado. Mailer Error: {$mail->ErrorInfo}";
}

$conn->close();
?>
