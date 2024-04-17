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

// Array de opciones de texto largo para EXPECTATIVA
$expectativas = array(
    "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años",
    "Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem",
    "por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,"
);

// Seleccionar los ID_ALUMNO de la tabla registro
$sql_select = "SELECT ID_ALUMNO FROM registro";
$result_select = $conn->query($sql_select);

if ($result_select->num_rows > 0) {
    // Insertar cada ID_ALUMNO en la tabla seguimiento con una expectativa aleatoria
    while ($row = $result_select->fetch_assoc()) {
        $id_alumno = $row["ID_ALUMNO"];
        $expectativa = $expectativas[array_rand($expectativas)]; // Seleccionar una expectativa aleatoria

        $sql_insert = "INSERT INTO seguimiento (ID_ALUMNO, EXPECTATIVA) VALUES ('$id_alumno', '$expectativa')";
        if ($conn->query($sql_insert) !== TRUE) {
            echo "Error al insertar en la tabla seguimiento: " . $conn->error;
        }
    }
    echo "Los datos se insertaron en la tabla seguimiento correctamente.";
} else {
    echo "No se encontraron registros en la tabla registro.";
}

$conn->close();
?>
