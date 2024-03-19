-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-03-2024 a las 06:52:37
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
-- Estructura de tabla para la tabla `registro`
--

DROP TABLE IF EXISTS `registro`;
CREATE TABLE `registro` (
  `ID_ALUMNO` int(8) NOT NULL,
  `NOMBRE` varchar(60) NOT NULL,
  `APELLIDO_PATERNO` varchar(60) NOT NULL,
  `APELLIDO_MATERNO` varchar(60) NOT NULL,
  `CORREO` varchar(60) NOT NULL,
  `CONTRASEÑA` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`ID_ALUMNO`, `NOMBRE`, `APELLIDO_PATERNO`, `APELLIDO_MATERNO`, `CORREO`, `CONTRASEÑA`) VALUES
(0, '', '', '', '', ''),
(446027, 'Antonio', 'Garcia', 'Cruz', 'antonio_arcia@anahuac.mx', 'g6027L04'),
(503445, 'Antonio', 'Garcia', 'Cruz', 'evasconcelos@anahuac.mx', 'Contraseña123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`ID_ALUMNO`),
  ADD UNIQUE KEY `CORREO` (`CORREO`),
  ADD UNIQUE KEY `CONTRASEÑA` (`CONTRASEÑA`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
