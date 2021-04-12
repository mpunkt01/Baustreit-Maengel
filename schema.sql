-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Erstellungszeit: 12. Apr 2021 um 16:04
-- Server-Version: 5.7.32
-- PHP-Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Datenbank: `DB_LackTracking`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `anzeigen`
--

CREATE TABLE `anzeigen` (
  `id_anzeige` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `zu id_mangel` int(11) NOT NULL,
  `zu id_verursacher` int(11) NOT NULL,
  `Frist` date NOT NULL,
  `Nachfrist` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `beseitigungen`
--

CREATE TABLE `beseitigungen` (
  `id_beseitigung` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `zu id_anzeige` int(11) NOT NULL,
  `beseitigt` tinyint(1) NOT NULL,
  `Erledigungsvermerk` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gewerke`
--

CREATE TABLE `gewerke` (
  `id_gewerk` int(11) NOT NULL,
  `Gewerkename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gruppierung`
--

CREATE TABLE `gruppierung` (
  `id_gruppe` int(11) NOT NULL,
  `Gruppenname` varchar(255) NOT NULL COMMENT 'eigene Gruppierung, z.B. Bauteile'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kommentare`
--

CREATE TABLE `kommentare` (
  `id_kommentar` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `Kommentar` varchar(255) NOT NULL,
  `zu id_verfasser` int(11) NOT NULL,
  `zu id_mangel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mangelliste`
--

CREATE TABLE `mangelliste` (
  `id_mangel` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `Lage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Mangelbeschreibung` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `Status` varchar(25) COLLATE utf8_unicode_ci NOT NULL COMMENT 'feste Werte (vor-, bei-, nach Abnahme)',
  `zu_id_gruppe` int(11) NOT NULL,
  `zu_id_projekt_nutzer` int(11) NOT NULL,
  `Anhang` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `projekte`
--

CREATE TABLE `projekte` (
  `id_projekt` int(11) NOT NULL,
  `Kurzbezeichnung` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Beschreibung` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabelle der Projekte';

--
-- Daten für Tabelle `projekte`
--

INSERT INTO `projekte` (`id_projekt`, `Kurzbezeichnung`, `Beschreibung`) VALUES
(1, 'Testprojekt', 'Das Testprojekt dient zum ausprobieren. ');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `projekt_nutzer_zuordnung`
--

CREATE TABLE `projekt_nutzer_zuordnung` (
  `id_proj_zuordnung` int(11) NOT NULL,
  `id_verfasser` int(11) NOT NULL COMMENT 'ID aus Tabelle der Nutzer',
  `id_projekte` int(11) NOT NULL COMMENT 'ID aus  Tabelle der Projekte'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabelle der Zuordnung von Projekten und Nutzern ';

--
-- Daten für Tabelle `projekt_nutzer_zuordnung`
--

INSERT INTO `projekt_nutzer_zuordnung` (`id_proj_zuordnung`, `id_verfasser`, `id_projekte`) VALUES
(1, 1, 1);

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
(1, '\0W\0e\0i\0t\0z\0,\0 \0M\0i\0c\0h\0a\0e\0l', 'weitz@baustreit.de', '\0t\0e\0s\0t', 1, NULL, NULL),
(33, 'tom', 'tom@email.de', '$2y$10$GwU1oI4prb58K1atFiiSGexiMrwwRiS1N51BttYI5yWwvpa6a/eem', 2, '2021-04-12 11:40:04', NULL),
(34, 'test', 'test@email.de', '$2y$10$wMs.vCuxormAN6eKVzjTnuia0uGxMqmkOshiBbfSsoqB5RDSI2FPy', 2, '2021-04-12 11:49:28', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `verursacher`
--

CREATE TABLE `verursacher` (
  `id_verursacher` int(11) NOT NULL,
  `Name AN` varchar(255) NOT NULL,
  `Email AN` varchar(255) NOT NULL,
  `zu id_gewerk` int(11) NOT NULL,
  `Anmerkung` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `anzeigen`
--
ALTER TABLE `anzeigen`
  ADD PRIMARY KEY (`id_anzeige`),
  ADD KEY `zu id_mangel` (`zu id_mangel`),
  ADD KEY `zu id_verursacher` (`zu id_verursacher`);

--
-- Indizes für die Tabelle `beseitigungen`
--
ALTER TABLE `beseitigungen`
  ADD PRIMARY KEY (`id_beseitigung`),
  ADD KEY `zu id_anzeige` (`zu id_anzeige`);

--
-- Indizes für die Tabelle `gewerke`
--
ALTER TABLE `gewerke`
  ADD PRIMARY KEY (`id_gewerk`);

--
-- Indizes für die Tabelle `gruppierung`
--
ALTER TABLE `gruppierung`
  ADD PRIMARY KEY (`id_gruppe`);

--
-- Indizes für die Tabelle `kommentare`
--
ALTER TABLE `kommentare`
  ADD PRIMARY KEY (`id_kommentar`),
  ADD KEY `zu id_mangel` (`zu id_mangel`),
  ADD KEY `zu id_verfasser` (`zu id_verfasser`);

--
-- Indizes für die Tabelle `mangelliste`
--
ALTER TABLE `mangelliste`
  ADD PRIMARY KEY (`id_mangel`),
  ADD KEY `zu_id_gruppe` (`zu_id_gruppe`),
  ADD KEY `zu_id_projekt_nutzer` (`zu_id_projekt_nutzer`);

--
-- Indizes für die Tabelle `projekte`
--
ALTER TABLE `projekte`
  ADD PRIMARY KEY (`id_projekt`);

--
-- Indizes für die Tabelle `projekt_nutzer_zuordnung`
--
ALTER TABLE `projekt_nutzer_zuordnung`
  ADD PRIMARY KEY (`id_proj_zuordnung`),
  ADD KEY `id_verfasser` (`id_verfasser`),
  ADD KEY `projekt_zuordnung` (`id_projekte`) USING BTREE;

--
-- Indizes für die Tabelle `verfasser`
--
ALTER TABLE `verfasser`
  ADD PRIMARY KEY (`id_verfasser`);

--
-- Indizes für die Tabelle `verursacher`
--
ALTER TABLE `verursacher`
  ADD PRIMARY KEY (`id_verursacher`),
  ADD KEY `zu id_gewerk` (`zu id_gewerk`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `anzeigen`
--
ALTER TABLE `anzeigen`
  MODIFY `id_anzeige` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `beseitigungen`
--
ALTER TABLE `beseitigungen`
  MODIFY `id_beseitigung` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `gewerke`
--
ALTER TABLE `gewerke`
  MODIFY `id_gewerk` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `gruppierung`
--
ALTER TABLE `gruppierung`
  MODIFY `id_gruppe` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `kommentare`
--
ALTER TABLE `kommentare`
  MODIFY `id_kommentar` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `mangelliste`
--
ALTER TABLE `mangelliste`
  MODIFY `id_mangel` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `projekte`
--
ALTER TABLE `projekte`
  MODIFY `id_projekt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `projekt_nutzer_zuordnung`
--
ALTER TABLE `projekt_nutzer_zuordnung`
  MODIFY `id_proj_zuordnung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `verfasser`
--
ALTER TABLE `verfasser`
  MODIFY `id_verfasser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT für Tabelle `verursacher`
--
ALTER TABLE `verursacher`
  MODIFY `id_verursacher` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `anzeigen`
--
ALTER TABLE `anzeigen`
  ADD CONSTRAINT `anzeigen_ibfk_1` FOREIGN KEY (`zu id_mangel`) REFERENCES `mangelliste` (`id_mangel`),
  ADD CONSTRAINT `anzeigen_ibfk_2` FOREIGN KEY (`zu id_verursacher`) REFERENCES `verursacher` (`id_verursacher`);

--
-- Constraints der Tabelle `beseitigungen`
--
ALTER TABLE `beseitigungen`
  ADD CONSTRAINT `beseitigungen_ibfk_1` FOREIGN KEY (`zu id_anzeige`) REFERENCES `anzeigen` (`id_anzeige`);

--
-- Constraints der Tabelle `kommentare`
--
ALTER TABLE `kommentare`
  ADD CONSTRAINT `kommentare_ibfk_1` FOREIGN KEY (`zu id_mangel`) REFERENCES `mangelliste` (`id_mangel`),
  ADD CONSTRAINT `kommentare_ibfk_2` FOREIGN KEY (`zu id_verfasser`) REFERENCES `verfasser` (`id_verfasser`);

--
-- Constraints der Tabelle `mangelliste`
--
ALTER TABLE `mangelliste`
  ADD CONSTRAINT `mangelliste_ibfk_1` FOREIGN KEY (`zu_id_gruppe`) REFERENCES `gruppierung` (`id_gruppe`),
  ADD CONSTRAINT `mangelliste_ibfk_2` FOREIGN KEY (`zu_id_projekt_nutzer`) REFERENCES `projekt_nutzer_zuordnung` (`id_proj_zuordnung`);

--
-- Constraints der Tabelle `projekt_nutzer_zuordnung`
--
ALTER TABLE `projekt_nutzer_zuordnung`
  ADD CONSTRAINT `projekt_nutzer_zuordnung_ibfk_1` FOREIGN KEY (`id_verfasser`) REFERENCES `verfasser` (`id_verfasser`),
  ADD CONSTRAINT `projekt_nutzer_zuordnung_ibfk_2` FOREIGN KEY (`id_projekte`) REFERENCES `projekte` (`id_projekt`);

--
-- Constraints der Tabelle `verursacher`
--
ALTER TABLE `verursacher`
  ADD CONSTRAINT `verursacher_ibfk_1` FOREIGN KEY (`zu id_gewerk`) REFERENCES `gewerke` (`id_gewerk`);