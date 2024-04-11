-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-04-2024 a las 19:14:43
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
  `id_cita` int(8) NOT NULL,
  `id_alumno` int(8) NOT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `a_paterno` varchar(60) DEFAULT NULL,
  `a_materno` varchar(60) DEFAULT NULL,
  `carrera` text DEFAULT NULL,
  `semestre` int(2) DEFAULT NULL,
  `motivo` text DEFAULT NULL,
  `expectativas` text DEFAULT NULL,
  `id_psicologo` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `id_alumno`, `nombre`, `a_paterno`, `a_materno`, `carrera`, `semestre`, `motivo`, `expectativas`, `id_psicologo`) VALUES
(6, 446027, 'Antonio', 'Garcia', 'Cruz', '0', 4, 'fdbedffd', 'fbfdb', 567890);

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
(234563, 'ggggg', 'ggg', 'ggg', '@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(446027, 'Antonio', 'Garcia', 'Cruz', 'antonio_garcia@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da'),
(446028, 'juan', 'perez', 'mendez', 'evasconcelos@anahuac.mx', '42c03ec7ddc5e0501bb0027ad011ca8ebed302595df94ef5842d02ead224c0da');

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
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_alumno` (`id_alumno`),
  ADD KEY `id_psicologo` (`id_psicologo`);

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
  MODIFY `id_cita` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `registro` (`ID_ALUMNO`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_psicologo`) REFERENCES `administradores` (`ID_ALUMNO`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `registro` (`ID_ALUMNO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
