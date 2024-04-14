-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-04-2024 a las 09:49:13
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
(7, 446027, 'Consulta Psicológica', '2024-04-08', '10:00:00', '#FFD700'),
(8, 446027, 'Consulta Psicológica', '2024-04-09', '10:00:00', '#FFD700'),
(9, 446027, 'Consulta Psicológica', '2024-04-10', '10:00:00', '#FFD700'),
(11, 446028, 'Consulta Psicológica', '2024-04-08', '13:00:00', '#FFD700');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psicologos`
--

DROP TABLE IF EXISTS `psicologos`;
CREATE TABLE `psicologos` (
  `id_psicologo` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `telefono` int(10) DEFAULT NULL,
  `especialidad` text DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `poblacion` text DEFAULT NULL,
  `formacion` text DEFAULT NULL,
  `modalidad` varchar(20) DEFAULT NULL,
  `imagenes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indices de la tabla `psicologos`
--
ALTER TABLE `psicologos`
  ADD PRIMARY KEY (`id_psicologo`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`ID_ALUMNO`),
  ADD UNIQUE KEY `CORREO` (`CORREO`);

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
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `psicologos`
--
ALTER TABLE `psicologos`
  MODIFY `id_psicologo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
