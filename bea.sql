-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-04-2024 a las 00:05:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bea`
--
CREATE DATABASE IF NOT EXISTS `bea` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bea`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

DROP TABLE IF EXISTS `administradores`;
CREATE TABLE `administradores` (
  `ID_ALUMNO` int(8) NOT NULL,
  `NOMBRE` varchar(60) NOT NULL,
  `APELLIDO_PATERNO` varchar(60) NOT NULL,
  `APELLIDO_MATERNO` varchar(60) NOT NULL,
  `CORREO` varchar(60) NOT NULL,
  `CONTRASEÑA` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`ID_ALUMNO`, `NOMBRE`, `APELLIDO_PATERNO`, `APELLIDO_MATERNO`, `CORREO`, `CONTRASEÑA`) VALUES
(123456, 'administrador', 'de', 'psicologia', 'antoniogc984@gmail.com', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(567890, 'psicologo', 'numero', 'uno', 'tadeo_martinez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

DROP TABLE IF EXISTS `citas`;
CREATE TABLE `citas` (
  `ID_CITA` int(11) NOT NULL,
  `ID_ALUMNO` int(8) NOT NULL,
  `ID_ADMIN` int(8) NOT NULL,
  `CARRERA` varchar(255) NOT NULL,
  `SEMESTRE` int(2) NOT NULL,
  `MOTIVO` text NOT NULL,
  `EXPECTATIVA` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`ID_CITA`, `ID_ALUMNO`, `ID_ADMIN`, `CARRERA`, `SEMESTRE`, `MOTIVO`, `EXPECTATIVA`) VALUES
(16, 446027, 567890, 'ingenieria en tecnologias de la informacion y negocios digitales', 6, 'estoy muy triste', 'que se me quite lo triste'),
(17, 33082835, 123456, 'licenciatura en mercadotectnia estrategica', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(18, 71780038, 123456, 'licenciatura en ingenieria para la direccion', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(19, 89017496, 567890, 'licenciatura en ingenieria mecatronica', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(20, 71010124, 123456, 'licenciatura en ingenieria biomedica', 5, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(21, 18908128, 123456, 'licenciatura en diseño grafico', 1, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(22, 15881471, 123456, 'licenciatura en diseño multimedia', 4, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(23, 91420765, 123456, 'licenciatura en ingenieria para la direccion', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(24, 42251960, 567890, 'ingenieria en tecnologias de la informacion y negocios digitales', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(25, 83737984, 123456, 'licenciatura en diseño grafico', 6, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(26, 81158743, 123456, 'ingenieria en tecnologias de la informacion y negocios digitales', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(27, 31261162, 123456, 'licenciatura en comunicacion', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(28, 98963139, 123456, 'licenciatura en ingenieria para la direccion', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(29, 62188186, 567890, 'ingenieria en tecnologias de la informacion y negocios digitales', 5, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(30, 30594108, 123456, 'ingenieria en tecnologias de la informacion y negocios digitales', 6, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(31, 75609963, 123456, 'licenciatura en ingenieria para la direccion', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(32, 17198290, 567890, 'licenciatura en diseño de moda e innovacion', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(33, 446028, 567890, 'licenciatura en ingenieria biomedica', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(34, 81980172, 123456, 'licenciatura en comunicacion', 10, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(35, 73521944, 567890, 'licenciatura en comunicacion', 2, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(36, 73532307, 567890, 'licenciatura en derecho', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(37, 41960762, 567890, 'licenciatura en derecho', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(38, 83779604, 567890, 'licenciatura en finanzas y contaduria publica', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(39, 48770299, 567890, 'licenciatura en ingenieria para la direccion', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(40, 25053298, 123456, 'licenciatura en administracion y direccion de empresas', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(41, 87575091, 123456, 'licenciatura en negocios internacionales', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(42, 75492812, 567890, 'licenciatura en negocios internacionales', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(43, 25211906, 567890, 'licenciatura en mercadotectnia estrategica', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(44, 83197251, 567890, 'licenciatura en diseño grafico', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(45, 63645330, 123456, 'licenciatura en diseño grafico', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(46, 57393766, 123456, 'licenciatura en ingenieria mecatronica', 6, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(47, 20756263, 567890, 'licenciatura en mercadotectnia estrategica', 4, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(48, 68900242, 123456, 'licenciatura en diseño industrial', 10, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(49, 59821764, 123456, 'licenciatura en ingenieria civil', 6, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(50, 19904891, 567890, 'licenciatura en diseño industrial', 5, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(51, 85004659, 123456, 'licenciatura en ingenieria civil', 10, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(52, 46402301, 123456, 'licenciatura en ingenieria mecatronica', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(53, 43199275, 123456, 'licenciatura en ingenieria para la direccion', 4, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(54, 69472034, 123456, 'licenciatura en comunicacion', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(55, 97040397, 567890, 'licenciatura en ingenieria para la direccion', 5, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(56, 13816710, 567890, 'licenciatura en psicologia', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(57, 95699582, 123456, 'licenciatura en mercadotectnia estrategica', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(58, 48441550, 123456, 'licenciatura en administracion y direccion de empresas', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(59, 64064070, 567890, 'licenciatura en ingenieria civil', 1, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(60, 74925253, 123456, 'licenciatura en negocios internacionales', 10, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(61, 80737865, 567890, 'licenciatura en psicologia', 10, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(62, 91135195, 567890, 'licenciatura en finanzas y contaduria publica', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(63, 22390874, 123456, 'licenciatura en psicologia', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(64, 37726103, 123456, 'licenciatura en diseño industrial', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(65, 47876830, 123456, 'licenciatura en diseño de moda e innovacion', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(66, 22010798, 123456, 'licenciatura en diseño multimedia', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(67, 58010092, 567890, 'licenciatura en negocios internacionales', 9, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(68, 74078864, 123456, 'licenciatura en mercadotectnia estrategica', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(69, 60841510, 123456, 'licenciatura en ingenieria mecatronica', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(70, 35265829, 123456, 'licenciatura en ingenieria civil', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(71, 15583911, 123456, 'licenciatura en mercadotectnia estrategica', 5, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(72, 60147348, 123456, 'licenciatura en derecho', 1, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(73, 47678461, 123456, 'licenciatura en psicologia', 3, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(74, 98942800, 123456, 'licenciatura en ingenieria para la direccion', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(75, 93327111, 567890, 'licenciatura en finanzas y contaduria publica', 7, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(76, 54968941, 567890, 'licenciatura en administracion y direccion de empresas', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(77, 76288219, 567890, 'ingenieria en tecnologias de la informacion y negocios digitales', 8, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(78, 30659032, 567890, 'licenciatura en diseño multimedia', 12, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(79, 66141036, 567890, 'licenciatura en administracion y direccion de empresas', 2, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(80, 24241445, 567890, 'licenciatura en diseño industrial', 6, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(81, 19265822, 123456, 'licenciatura en diseño grafico', 1, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.'),
(82, 85336854, 567890, 'licenciatura en derecho', 11, 'Motivo de la cita generado automáticamente.', 'Expectativa generada automáticamente.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

DROP TABLE IF EXISTS `eventos`;
CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`id_evento`, `id_usuario`, `titulo`, `fecha`, `hora`, `color`) VALUES
(7, 446027, 'Consulta Psicológica', '0000-00-00', '13:00:00', '#FFD700'),
(8, 446027, 'Consulta Psicológica', '2024-04-09', '10:00:00', '#FFD700'),
(9, 446027, 'Consulta Psicológica', '2024-04-10', '10:00:00', '#FFD700'),
(11, 446028, 'Consulta Psicológica', '2024-04-08', '13:00:00', '#FFD700'),
(16, 33082835, 'recordatorio de prueba', '2024-04-29', '02:22:00', '#e84f4f');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

DROP TABLE IF EXISTS `notas`;
CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL,
  `numero_sesion` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `contenido` text DEFAULT NULL,
  `id_administrador` int(11) DEFAULT NULL,
  `id_alumno` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`id_nota`, `numero_sesion`, `fecha`, `contenido`, `id_administrador`, `id_alumno`) VALUES
(2343, 1, '2024-04-17', 'erbtyrjmyehatrehtr', 123456, 33082835),
(2344, 2, '2024-04-17', 'rbentrehtnehtraehra', 123456, 33082835),
(2345, 3, '2024-04-17', 'rbrtn,uyitkyrjwrhgytrkmutkeehtr', 123456, 33082835),
(2347, 4, '2024-04-17', 'hrejmyyrjhet4tyjjyt', 123456, 33082835),
(2348, 1, '2024-04-17', 'hola mundo xd', 123456, 83737984),
(2349, 1, '2024-04-17', 'vghgmutyrttnbt', 123456, 33082835),
(2350, 3, '2024-04-17', 'drbtumiulouytb4', 123456, 71780038),
(2351, 0, '2024-04-17', '', 123456, 71780038),
(2352, 1, '2024-04-17', 'erehyj565', 123456, 33082835),
(2353, 3, '2024-04-17', 'vefhgklñj htgbrbgrh tnntnyrnyrn5ytyr', 123456, 33082835);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psicologos`
--

DROP TABLE IF EXISTS `psicologos`;
CREATE TABLE `psicologos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `especialidad` text NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `poblacion` varchar(255) NOT NULL,
  `formacion` text NOT NULL,
  `modalidad` varchar(50) NOT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `psicologos`
--

INSERT INTO `psicologos` (`id`, `nombre`, `tipo`, `telefono`, `especialidad`, `direccion`, `poblacion`, `formacion`, `modalidad`, `imagen`) VALUES
(1, 'DRA. ELVIRA GOPAR CANSECO', 'TERAPIA HUMANISTA', '9511096372', 'Orientación Psicopedagógica, psicoterapia, docente, intervención tanatológica, tallerista y conferencista.', 'Independencia 305, interior 105', 'Niños, adolescentes, adultos y pareja.', 'Licenciada en Psicología. Cédula Profesional: 6092318 Maestría en Psicoterapia Humanista. Cédula Profesional: 9475952 Maestría en Sexualidad Humana. Cédula Profesional: 12274318 Doctorado en Psicología, por el Instituto Universitario Carl Rogers, Puebla.', 'Presencial / Virtual', 'https://i.postimg.cc/NFNY2Krd/DRA-ELVIRA-GOPAR-CANSECO.png'),
(2, 'MTRA. KENIA GARCÍA GUTIÉRREZ', 'TERAPIA GESTALT', '9515792158', 'Atención psicoterapéutica y seguimiento psicológico a pacientes psiquiátricos, evaluación neuropsicológica, evaluaciones psicológicas y de la personalidad, talleres y pláticas de neuroeducación emocional.', 'Prolongación Eucaliptos 102, San Felipe del Agua', 'Adolescentes y adultos', 'Licenciada en Psicología por la Universidad Regional del Sureste. Cédula profesional: 4594859 Maestría en Educación Emocional por la Universidad Anáhuac Mx Sur. Cédula profesional: En trámite Especialidad en Psicoterapia Gestalt, Centro Gestalt Oaxaca. Cédula Profesional: 7730994', 'Presencial / Virtual', 'https://i.postimg.cc/BZNJVVw2/MTRA-KENIA-GARC-A-GUTI-RREZ.png'),
(3, 'MTRA. SYLVIA GUTIÉRREZ CANDIANI', 'TERAPIA COGNITIVO CONDUCTUAL', '9512165928', 'Evaluación y diagnóstico en adolescentes y psicoterapia', 'Privada de Rafael Osuna 448, Colonia Olímpica', 'Adolescentes y adultos', 'Licenciada en Psicología por la Universidad Anáhuac de Oaxaca Cédula Profesional: 10503063 Maestría en psicología adolescente por el Instituto Miguel de Cervantes Cédula Profesional: 12948167', 'Presencial / Virtual', 'https://i.postimg.cc/SRQkK6jX/MTRA-SYLVIA-GUTI-RREZ-CANDIANI.png'),
(4, 'LIC. MARÍA GODARD ZAPATA', 'TERAPIA HUMANISTA', '9511885535 (pre', 'Especialidad en Psicoterapia Gestalt, en Tanatología y en Constelaciones Familiares de la Terapia Sistémica, problemas personales y familiares así como laborales, alcoholismo y drogadicción, pérdidas de diferente tipo, orientación sexual, aborto, divorcio, entre otros.', 'Calzada del Panteón 511 San Felipe del Agua C.P. 68020', 'Adolescentes, adultos, adultos mayores, personas en cualquier tipo de duelo y parejas', 'Lic. en Pedagogía por el Instituto de Estudios Superiores de Oaxaca. Cédula Profesional: 3172500 Especialidad en Psicoterapia Gestalt y tanatología por el Centro de Desarrollo Humano y Psicoterapia Gestalt. Cédula Profesional: 4110728', 'Presencial / Virtual', 'https://i.postimg.cc/Hx9THZWD/LIC-MAR-A-GODARD-ZAPATA.png'),
(5, 'DR. JORGE G. JIMÉNEZ SÁNCHEZ', 'PSIQUIATRA DE ENLACE', '9515144801', 'Médico Psiquiatra', 'Calle Jazmines 509, Oaxaca de Juarez, Oaxaca', 'Niños, adolescentes y adultos', 'Psiquiatra por la Universidad Lasalle de México. Cédula profesional: 1733398', 'Presencial / Virtual', 'https://i.postimg.cc/YCTrxLDV/DR-JORGE-G-JIM-NEZ-S-NCHEZ.png'),
(6, 'DR. JORGE LUIS CORTÉS LÓPEZ', 'TERAPIA COGNITIVO CONDUCTUAL', '9512257283', 'Médico Psiquiatra, posgraduado en el Instituto Nacional de Psiquiatría \'Ramón de la Fuente\'', 'Colón 421, Centro Oaxaca', 'Adolescentes y adultos', 'Médico Cirujano egresado de la Universidad Autónoma Benito Juárez de Oaxaca. Cédula Profesional: 4968848 Especialidad en Psiquiatría por la Universidad Nacional Autónoma de México Cédula Profesional: 6982040.', 'Presencial / Virtual', 'https://i.postimg.cc/Kz2m6S2D/DR-JORGE-LUIS-CORT-S-L-PEZ.png'),
(7, 'DR. VIRGILIO SANTIAGO LÓPEZ', 'TERAPIA COGNITIVO CONDUCTUAL', '9515178666', 'Médico Cirujano especialista en Psiquiatría', 'Emilio Carranza No. 1112 Clínica Neurociencias del Sureste, Col. Reforma', 'Adolescentes y adultos', 'Médico Cirujano egresado de la Universidad Autónoma Benito Juárez de Oaxaca. Cédula Profesional: 2809422 Especialidad en Psiquiatría, Universidad Nacional Autónoma de Mexico. Cédula Profesional: 5777340', 'Presencial / Virtual', 'https://i.postimg.cc/k58nYMk5/DR-VIRGILIO-SANTIAGO-L-PEZ.png'),
(9, 'MTRA. LAURA LORENA HERNÁNDEZ VELASCO', 'TERAPIA HUMANISTA', '9515701076', 'Práctica privada en atención a niños, adolescentes y adultos en psicodiagnóstico y psicoterapia, psicoterapia individual y de pareja, cursos y talleres.', 'Manuel Sabino Crespo No.524 Interior E.', 'Niños, adolescentes y adultos', 'Lic. en Psicología. Instituto de Estudios Superiores de Oaxaca. Cédula Profesional: 2910361 Maestra en Educación y desarrollo cognitivo. Instituto Tecnológico de Estudios Superiores de Monterrey. Cédula Profesional: 10444914 Posgrado en Psicopatología Clínica. Universidad de Barcelona. Diplomado en Neuropsicología. Universidad Complutense de Madrid.', 'Presencial / Virtual', 'https://i.postimg.cc/653BJfDg/MTRA-LAURA-LORENA-HERN-NDEZ-VELASCO.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

DROP TABLE IF EXISTS `registro`;
CREATE TABLE `registro` (
  `ID_ALUMNO` int(8) NOT NULL,
  `NOMBRE` varchar(60) NOT NULL,
  `APELLIDO_PATERNO` varchar(60) NOT NULL,
  `APELLIDO_MATERNO` varchar(60) NOT NULL,
  `CORREO` varchar(60) NOT NULL,
  `CONTRASEÑA` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`ID_ALUMNO`, `NOMBRE`, `APELLIDO_PATERNO`, `APELLIDO_MATERNO`, `CORREO`, `CONTRASEÑA`) VALUES
(446027, 'Antonio', 'Garcia', 'Cruz', 'antonio_garcia@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(446028, 'juan', 'perez', 'mendez', 'evasconcelos@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(13816710, 'María', 'Cruz', 'Ramírez', 'maría.cruz@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(15583911, 'Patricia', 'Martínez', 'Ramírez', 'patricia.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(15881471, 'Ana', 'Rodríguez', 'López', 'ana.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(17198290, 'Elena', 'Rodríguez', 'López', 'elena.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(18908128, 'Ana', 'Ramírez', 'González', 'ana.ramírez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(19265822, 'Sergio', 'Rodríguez', 'García', 'sergio.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(19904891, 'Luis', 'Hernández', 'Martínez', 'luis.hernández@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(20756263, 'Luis', 'Cruz', 'López', 'luis.cruz@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(22010798, 'Miguel', 'Pérez', 'González', 'miguel.pérez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(22390874, 'Miguel', 'González', 'Sánchez', 'miguel.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(24241445, 'Sergio', 'Martínez', 'García', 'sergio.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(25053298, 'Laura', 'González', 'García', 'laura.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(25211906, 'Laura', 'Pérez', 'González', 'laura.pérez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(30594108, 'Elena', 'López', 'González', 'elena.lópez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(30659032, 'Sergio', 'Hernández', 'Ramírez', 'sergio.hernández@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(31261162, 'Elena', 'García', 'Rodríguez', 'elena.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(33082835, 'Ana', 'García', 'Ramírez', 'ana.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(35265829, 'Patricia', 'López', 'González', 'patricia.lópez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(37726103, 'Miguel', 'López', 'Cruz', 'miguel.lópez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(41960762, 'Jorge', 'Pérez', 'Ramírez', 'jorge.pérez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(42251960, 'Carlos', 'García', 'Pérez', 'carlos.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(43199275, 'Luis', 'Ramírez', 'Ramírez', 'luis.ramírez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(46402301, 'Luis', 'Martínez', 'Cruz', 'luis.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(47678461, 'Patricia', 'Rodríguez', 'Ramírez', 'patricia.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(47876830, 'Miguel', 'Martínez', 'Pérez', 'miguel.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(48441550, 'María', 'González', 'Pérez', 'maría.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(48770299, 'Laura', 'García', 'Cruz', 'laura.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(54968941, 'Sergio', 'García', 'Cruz', 'sergio.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(57393766, 'Laura', 'Sánchez', 'Hernández', 'laura.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(58010092, 'Miguel', 'Rodríguez', 'Cruz', 'miguel.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(59821764, 'Luis', 'González', 'Martínez', 'luis.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(60147348, 'Patricia', 'Pérez', 'Sánchez', 'patricia.pérez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(60841510, 'Patricia', 'González', 'López', 'patricia.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(62188186, 'Elena', 'Hernández', 'Ramírez', 'elena.hernández@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(63645330, 'Laura', 'Rodríguez', 'López', 'laura.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(64064070, 'María', 'Pérez', 'Pérez', 'maría.pérez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(66141036, 'Sergio', 'López', 'García', 'sergio.lópez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(68900242, 'Luis', 'García', 'Ramírez', 'luis.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(69472034, 'Luis', 'Rodríguez', 'Hernández', 'luis.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(71010124, 'Ana', 'Martínez', 'Sánchez', 'ana.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(71780038, 'Ana', 'González', 'Hernández', 'ana.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(73521944, 'Jorge', 'González', 'Hernández', 'jorge.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(73532307, 'Jorge', 'Martínez', 'Sánchez', 'jorge.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(74078864, 'Miguel', 'Sánchez', 'López', 'miguel.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(74925253, 'María', 'Ramírez', 'García', 'maría.ramírez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(75492812, 'Laura', 'Martínez', 'Hernández', 'laura.martínez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(75609963, 'Elena', 'Pérez', 'García', 'elena.pérez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(76288219, 'Sergio', 'González', 'Ramírez', 'sergio.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(80737865, 'María', 'Sánchez', 'Pérez', 'maría.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(81158743, 'Carlos', 'Rodríguez', 'Ramírez', 'carlos.rodríguez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(81980172, 'Jorge', 'García', 'Cruz', 'jorge.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(83197251, 'Laura', 'Ramírez', 'Martínez', 'laura.ramírez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(83737984, 'Carlos', 'González', 'Pérez', 'carlos.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(83779604, 'Jorge', 'Sánchez', 'Cruz', 'jorge.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(85004659, 'Luis', 'López', 'Rodríguez', 'luis.lópez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(85336854, 'Sergio', 'Sánchez', 'Cruz', 'sergio.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(87575091, 'Laura', 'Hernández', 'Hernández', 'laura.hernández@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(89017496, 'Ana', 'López', 'García', 'ana.lópez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(91135195, 'Miguel', 'García', 'García', 'miguel.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(91420765, 'Ana', 'Sánchez', 'Sánchez', 'ana.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(93327111, 'Sergio', 'Cruz', 'Hernández', 'sergio.cruz@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(95699582, 'María', 'García', 'Ramírez', 'maría.garcía@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(97040397, 'Luis', 'Sánchez', 'Cruz', 'luis.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(98942800, 'Patricia', 'Sánchez', 'González', 'patricia.sánchez@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(98963139, 'Elena', 'González', 'Cruz', 'elena.gonzález@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

DROP TABLE IF EXISTS `seguimiento`;
CREATE TABLE `seguimiento` (
  `id_seguimiento` int(11) NOT NULL,
  `ID_ALUMNO` int(11) NOT NULL,
  `EXPECTATIVA` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seguimiento`
--

INSERT INTO `seguimiento` (`id_seguimiento`, `ID_ALUMNO`, `EXPECTATIVA`) VALUES
(1, 446027, 'ngrio´gnqevo´betnpirwñnfbmet+ñjlhmoerldvms+oñl fjm´prohnbmeriokbnemi{kewnbrim'),
(2, 33082835, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(3, 71780038, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(4, 89017496, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(5, 71010124, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(6, 18908128, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(7, 15881471, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(8, 91420765, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(9, 446027, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(10, 42251960, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(11, 83737984, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(12, 81158743, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(13, 31261162, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(14, 98963139, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(15, 62188186, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(16, 30594108, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(17, 75609963, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(18, 17198290, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(19, 446028, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(20, 81980172, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(21, 73521944, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(22, 73532307, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(23, 41960762, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(24, 83779604, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(25, 48770299, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(26, 25053298, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(27, 87575091, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(28, 75492812, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(29, 25211906, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(30, 83197251, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(31, 63645330, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(32, 57393766, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(33, 20756263, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(34, 68900242, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(35, 59821764, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(36, 19904891, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(37, 85004659, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(38, 46402301, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(39, 43199275, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(40, 69472034, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(41, 97040397, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(42, 13816710, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(43, 95699582, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(44, 48441550, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(45, 64064070, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(46, 74925253, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(47, 80737865, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(48, 91135195, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(49, 22390874, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(50, 37726103, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(51, 47876830, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(52, 22010798, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(53, 58010092, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(54, 74078864, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(55, 60841510, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(56, 35265829, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(57, 15583911, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(58, 60147348, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(59, 47678461, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(60, 98942800, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(61, 93327111, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(62, 54968941, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(63, 76288219, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años'),
(64, 30659032, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(65, 66141036, 'Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem'),
(66, 24241445, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(67, 19265822, 'por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum,'),
(68, 85336854, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`ID_ALUMNO`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`ID_CITA`),
  ADD UNIQUE KEY `UNK_ALUMNO` (`ID_ALUMNO`),
  ADD KEY `ID_ADMIN` (`ID_ADMIN`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_nota`),
  ADD KEY `id_administrador` (`id_administrador`),
  ADD KEY `id_alumno` (`id_alumno`);

--
-- Indices de la tabla `psicologos`
--
ALTER TABLE `psicologos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`ID_ALUMNO`),
  ADD UNIQUE KEY `CORREO` (`CORREO`);

--
-- Indices de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD PRIMARY KEY (`id_seguimiento`),
  ADD KEY `ID_ALUMNO` (`ID_ALUMNO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `ID_CITA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2354;

--
-- AUTO_INCREMENT de la tabla `psicologos`
--
ALTER TABLE `psicologos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  MODIFY `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`ID_ALUMNO`) REFERENCES `registro` (`ID_ALUMNO`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`ID_ADMIN`) REFERENCES `administradores` (`ID_ALUMNO`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `registro` (`ID_ALUMNO`);

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_administrador`) REFERENCES `administradores` (`ID_ALUMNO`),
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_alumno`) REFERENCES `registro` (`ID_ALUMNO`);

--
-- Filtros para la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD CONSTRAINT `seguimiento_ibfk_1` FOREIGN KEY (`ID_ALUMNO`) REFERENCES `registro` (`ID_ALUMNO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
