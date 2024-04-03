<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=UTF-8');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$_POST = json_decode(file_get_contents('php://input'), true);


require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

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
    $mail->addAddress($_POST['correoDestinatario']); 

    $mail->isHTML(true);
    $mail->Subject = 'Recordatorio de Evento';
    $mail->Body = 'Este es un recordatorio para tu evento: ' . $_POST['mensaje'];

    $mail->send();
    echo 'El mensaje ha sido enviado';
} catch (Exception $e) {
    echo "El mensaje no pudo ser enviado. Mailer Error: {$mail->ErrorInfo}";
}
?>