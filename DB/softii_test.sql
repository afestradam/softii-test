-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-02-2024 a las 02:47:44
-- Versión del servidor: 8.2.0
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `softii_test`
--
CREATE DATABASE IF NOT EXISTS `softii_test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `softii_test`;

DELIMITER $$
--
-- Procedimientos
--
CREATE PROCEDURE `payedtips_insert` (IN `TOTALTIPS` DOUBLE, IN `TIPSPLIT` INT, IN `TIPVALUE` DOUBLE, IN `PAYMENTMETHOD` INT)   BEGIN

INSERT INTO payed_tips
(total_tips,
tip_split,
tip_value,
payment_method,
payment_date,
created_at,
updated_at)
VALUES
(TOTALTIPS,
TIPSPLIT,
TIPVALUE,
PAYMENTMETHOD,
NOW(),
NOW(),
NOW());

END$$

CREATE PROCEDURE `payedtips_select` ()   BEGIN

SELECT payed_tips.payment_id,
    payed_tips.total_tips,
    payed_tips.tip_split,
    payed_tips.tip_value,
    payed_tips.payment_method,
    payment_methods.method_name,
    DATE(payed_tips.payment_date) AS payment_date
FROM payed_tips
INNER JOIN payment_methods ON payment_methods.method_id = payed_tips.payment_method;

END$$

CREATE PROCEDURE `paymentmethods_select` ()   BEGIN

SELECT payment_methods.method_id,
    payment_methods.method_name
FROM payment_methods;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payed_tips`
--

CREATE TABLE IF NOT EXISTS `payed_tips` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `total_tips` double NOT NULL,
  `tip_split` int NOT NULL,
  `tip_value` double NOT NULL,
  `payment_method` int NOT NULL,
  `payment_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Truncar tablas antes de insertar `payed_tips`
--

TRUNCATE TABLE `payed_tips`;
--
-- Volcado de datos para la tabla `payed_tips`
--

INSERT INTO `payed_tips` (`payment_id`, `total_tips`, `tip_split`, `tip_value`, `payment_method`, `payment_date`, `created_at`, `updated_at`) VALUES
(1, 9000, 3, 3000, 1, '2024-02-09 00:00:00', '2024-02-09 00:00:00', '2024-02-09 00:00:00'),
(2, 5000, 3, 1650, 2, '2024-02-09 15:33:44', '2024-02-09 15:33:44', '2024-02-09 15:33:44'),
(3, 1000, 1, 1000, 3, '2024-02-09 16:07:11', '2024-02-09 16:07:11', '2024-02-09 16:07:11'),
(4, 1, 1, 1, 1, '2024-02-09 17:57:31', '2024-02-09 17:57:31', '2024-02-09 17:57:31'),
(5, 1, 1, 1, 1, '2024-02-09 18:00:41', '2024-02-09 18:00:41', '2024-02-09 18:00:41'),
(6, 8000, 2, 4000, 1, '2024-02-09 18:47:35', '2024-02-09 18:47:35', '2024-02-09 18:47:35'),
(7, 6000, 5, 1200, 1, '2024-02-09 19:07:30', '2024-02-09 19:07:30', '2024-02-09 19:07:30'),
(8, 5600, 1, 5600, 2, '2024-02-09 19:12:08', '2024-02-09 19:12:08', '2024-02-09 19:12:08'),
(9, 7000, 3, 2333, 1, '2024-02-09 19:23:27', '2024-02-09 19:23:27', '2024-02-09 19:23:27'),
(10, 7000, 3, 2333, 2, '2024-02-09 19:23:39', '2024-02-09 19:23:39', '2024-02-09 19:23:39'),
(11, 7000, 3, 2333, 2, '2024-02-09 19:24:24', '2024-02-09 19:24:24', '2024-02-09 19:24:24'),
(12, 5500, 5, 1100, 2, '2024-02-09 19:28:03', '2024-02-09 19:28:03', '2024-02-09 19:28:03'),
(13, 6600, 2, 3300, 1, '2024-02-09 19:31:11', '2024-02-09 19:31:11', '2024-02-09 19:31:11'),
(14, 6600, 2, 3300, 3, '2024-02-09 19:31:11', '2024-02-09 19:31:11', '2024-02-09 19:31:11'),
(15, 6600, 2, 3300, 3, '2024-02-09 19:31:16', '2024-02-09 19:31:16', '2024-02-09 19:31:16'),
(16, 6500, 2, 3250, 1, '2024-02-09 19:34:30', '2024-02-09 19:34:30', '2024-02-09 19:34:30'),
(17, 6500, 2, 3250, 2, '2024-02-09 19:34:30', '2024-02-09 19:34:30', '2024-02-09 19:34:30'),
(18, 6500, 2, 3250, 2, '2024-02-09 19:34:53', '2024-02-09 19:34:53', '2024-02-09 19:34:53'),
(19, 3000, 3, 1000, 1, '2024-02-09 19:35:46', '2024-02-09 19:35:46', '2024-02-09 19:35:46'),
(20, 3000, 3, 1000, 3, '2024-02-09 19:35:46', '2024-02-09 19:35:46', '2024-02-09 19:35:46'),
(21, 3000, 3, 1000, 2, '2024-02-09 19:35:46', '2024-02-09 19:35:46', '2024-02-09 19:35:46'),
(22, 3000, 3, 1000, 2, '2024-02-09 19:37:22', '2024-02-09 19:37:22', '2024-02-09 19:37:22'),
(23, 5000, 2, 2500, 1, '2024-02-09 19:38:56', '2024-02-09 19:38:56', '2024-02-09 19:38:56'),
(24, 5000, 2, 2500, 2, '2024-02-09 19:38:56', '2024-02-09 19:38:56', '2024-02-09 19:38:56'),
(25, 3000, 2, 1500, 1, '2024-02-09 19:43:11', '2024-02-09 19:43:11', '2024-02-09 19:43:11'),
(26, 3000, 2, 1500, 2, '2024-02-09 19:43:11', '2024-02-09 19:43:11', '2024-02-09 19:43:11'),
(27, 3000, 2, 1500, 2, '2024-02-09 19:43:15', '2024-02-09 19:43:15', '2024-02-09 19:43:15'),
(28, 2500, 2, 1250, 1, '2024-02-09 19:48:22', '2024-02-09 19:48:22', '2024-02-09 19:48:22'),
(29, 2500, 2, 1250, 2, '2024-02-09 19:49:24', '2024-02-09 19:49:24', '2024-02-09 19:49:24'),
(30, 2500, 2, 1250, 2, '2024-02-09 19:49:26', '2024-02-09 19:49:26', '2024-02-09 19:49:26'),
(31, 2500, 2, 1250, 2, '2024-02-09 19:49:27', '2024-02-09 19:49:27', '2024-02-09 19:49:27'),
(32, 2500, 2, 1250, 2, '2024-02-09 19:49:30', '2024-02-09 19:49:30', '2024-02-09 19:49:30'),
(33, 2500, 2, 1250, 2, '2024-02-09 19:49:30', '2024-02-09 19:49:30', '2024-02-09 19:49:30'),
(34, 5000, 2, 2500, 2, '2024-02-09 19:52:09', '2024-02-09 19:52:09', '2024-02-09 19:52:09'),
(35, 5000, 2, 2500, 2, '2024-02-09 19:55:40', '2024-02-09 19:55:40', '2024-02-09 19:55:40'),
(36, 5000, 2, 2500, 1, '2024-02-09 19:55:40', '2024-02-09 19:55:40', '2024-02-09 19:55:40'),
(37, 5500, 1, 5500, 1, '2024-02-09 20:02:44', '2024-02-09 20:02:44', '2024-02-09 20:02:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment_methods`
--

CREATE TABLE IF NOT EXISTS `payment_methods` (
  `method_id` int NOT NULL AUTO_INCREMENT,
  `method_name` varchar(45) NOT NULL,
  PRIMARY KEY (`method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Truncar tablas antes de insertar `payment_methods`
--

TRUNCATE TABLE `payment_methods`;
--
-- Volcado de datos para la tabla `payment_methods`
--

INSERT INTO `payment_methods` (`method_id`, `method_name`) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta'),
(3, 'Otro');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
