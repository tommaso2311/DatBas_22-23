DROP DATABASE IF EXISTS DATABASE_PROJ;
CREATE DATABASE DATABASE_PROJ;

USE DATABASE_PROJ;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `UTENTI` (
  `eMail` varchar(30) NOT NULL PRIMARY KEY,
  `Nome` varchar(30) NOT NULL,
  `Cognome` varchar(30) NOT NULL,
  `Anno di nascita` year(4) NOT NULL,
  `Luogo di nascita` varchar(30) NOT NULL,
  `totale bonus` int(11) NOT NULL DEFAULT '0'
) ENGINE="InnoDB"
