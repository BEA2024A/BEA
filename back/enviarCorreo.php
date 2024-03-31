<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'path/to/PHPMailer/src/Exception.php';
require 'path/to/PHPMailer/src/PHPMailer.php';
require 'path/to/PHPMailer/src/SMTP.php';

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
    $mail->addAddress('antoniogc984@gmail.com'); // Aquí va el correo del usuario logueado

    $mail->isHTML(true);
    $mail->Subject = 'Recordatorio de Evento';
    $mail->Body = 'Este es un recordatorio para tu evento: ' ;

    $mail->send();
    echo 'El mensaje ha sido enviado';
} catch (Exception $e) {
    echo "El mensaje no pudo ser enviado. Mailer Error: {$mail->ErrorInfo}";
}
?>
