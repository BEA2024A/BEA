const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
const port = 5432;

// Configurar el middleware para analizar cuerpos de solicitudes JSON
app.use(bodyParser.json());

// Configurar la conexión a la base de datos MySQL
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'antonio',
  password: 'g[TR_J@)tHtL]xGu',
  database: 'bea'
});

// Establecer la conexión a la base de datos
connection.connect(err => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    return;
  }
  console.log('Conexión a la base de datos MySQL establecida correctamente');
});

// Endpoint para registrar usuarios
app.post('/registro', (req, res) => {
  const { ID_ALUMNO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, CORREO, CONTRASEÑA } = req.body;

  // Verificar si el ID ya existe en la base de datos
  connection.query('SELECT * FROM registro WHERE ID_ALUMNO = ?', [ID_ALUMNO], (err, results) => {
    if (err) {
      console.error('Error al consultar la base de datos:', err);
      res.status(500).json({ error: 'Error interno del servidor' });
      return;
    }

    if (results.length > 0) {
      res.status(400).json({ error: 'El ID ya está registrado. Por favor, inicia sesión con tu cuenta.' });
      return;
    }

    // Verificar si el correo ya existe en la base de datos
    connection.query('SELECT * FROM registro WHERE CORREO = ?', [CORREO], (err, results) => {
      if (err) {
        console.error('Error al consultar la base de datos:', err);
        res.status(500).json({ error: 'Error interno del servidor' });
        return;
      }

      if (results.length > 0) {
        res.status(400).json({ error: 'El correo ya está en uso con otra cuenta.' });
        return;
      }

      // Si no hay duplicados, proceder con el registro
      const hashedPassword = crypto.createHash('sha256').update(CONTRASEÑA).digest('hex');
      connection.query('INSERT INTO registro (ID_ALUMNO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, CORREO, CONTRASEÑA) VALUES (?, ?, ?, ?, ?, ?)',
        [ID_ALUMNO, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, CORREO, hashedPassword], (err, results) => {
          if (err) {
            console.error('Error al insertar en la base de datos:', err);
            res.status(500).json({ error: 'Error interno del servidor' });
            return;
          }
          res.status(200).json({ message: 'Registro exitoso' });
        });
    });
  });
});

// Endpoint para iniciar sesión
app.post('/iniciar-sesion', (req, res) => {
  const { CORREO, CONTRASEÑA } = req.body;
  const hashedPassword = crypto.createHash('sha256').update(CONTRASEÑA).digest('hex');

  // Intenta encontrar al usuario en la tabla de registros
  connection.query('SELECT * FROM registro WHERE CORREO = ? AND CONTRASEÑA = ?', [CORREO, hashedPassword], (err, results) => {
    if (err) {
      console.error('Error al consultar la base de datos:', err);
      res.status(500).json({ error: 'Error interno del servidor' });
      return;
    }

    if (results.length > 0) {
      const user = results[0];
      res.status(200).json({
        exito: true,
        nombreUsuario: user.NOMBRE,
        correoUsuario: user.CORREO,
        idUsuario: user.ID_ALUMNO,
        a_paternoUsuario: user.APELLIDO_PATERNO,
        a_maternoUsuario: user.APELLIDO_MATERNO,
        tipoUsuario: 'usuario'
      });
      return;
    }

    // Intenta encontrar al usuario en la tabla de administradores
    connection.query('SELECT * FROM administradores WHERE CORREO = ? AND CONTRASEÑA = ?', [CORREO, hashedPassword], (err, results) => {
      if (err) {
        console.error('Error al consultar la base de datos:', err);
        res.status(500).json({ error: 'Error interno del servidor' });
        return;
      }

      if (results.length > 0) {
        const admin = results[0];
        res.status(200).json({
          exito: true,
          nombreUsuario: admin.NOMBRE,
          correoUsuario: admin.CORREO,
          idUsuario: admin.ID_ALUMNO,
          a_paternoUsuario: admin.APELLIDO_PATERNO,
          a_maternoUsuario: admin.APELLIDO_MATERNO,
          tipoUsuario: 'administrador'
        });
        return;
      }

      res.status(400).json({ exito: false });
    });
  });
});

// Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});
