require('dotenv').config();
const express = require('express');
const nodemailer = require('nodemailer');

const app = express();
app.use(express.json());

// Configuración de nodemailer
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.GMAIL_USER,
    pass: process.env.GMAIL_PASS
  }
});

// Función para enviar correos electrónicos
function enviarCorreo(destinatario, asunto, mensaje) {
  const mailOptions = {
    from: process.env.GMAIL_USER,
    to: destinatario,
    subject: asunto,
    text: mensaje
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log('Error al enviar correo:', error);
    } else {
      console.log('Correo enviado: ' + info.response);
    }
  });
}

// Ruta para la solicitud de envío de correo
app.post('/enviar-correo', (req, res) => {
  const { destinatario, asunto, mensaje } = req.body;
  enviarCorreo(destinatario, asunto, mensaje);
  res.send('Intento de enviar correo iniciado.');
});

// Iniciar el servidor
const PORT = process.env.PORT || 5173;
app.listen(PORT, () => {
  console.log(`Servidor iniciado en http://localhost:${PORT}`);
});
