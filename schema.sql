-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Erstellungszeit: 07. Apr 2021 um 16:51
-- Server-Version: 5.7.32
-- PHP-Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Datenbank: `DB_LackTracking`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `verfasser`
--

CREATE TABLE `verfasser` (
  `id_verfasser` int(11) NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nach-, Vorname',
  `Email` varchar(255) COLLATE utf16_unicode_ci NOT NULL,
  `Passwort` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Rolle` tinyint(4) NOT NULL COMMENT 'Rechtevergabe',
  `registered` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci COMMENT='Tabelle der Nutzer';

--
-- Daten für Tabelle `verfasser`
--

INSERT INTO `verfasser` (`id_verfasser`, `Name`, `Email`, `Passwort`, `Rolle`, `registered`, `last_login`) VALUES
(1, '\0W\0e\0i\0t\0z\0,\0 \0M\0i\0c\0h\0a\0e\0l', 'weitz@baustreit.de', '\0t\0e\0s\0t', 1, NULL, NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `verfasser`
--
ALTER TABLE `verfasser`
  ADD PRIMARY KEY (`id_verfasser`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `verfasser`
--
ALTER TABLE `verfasser`
  MODIFY `id_verfasser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
