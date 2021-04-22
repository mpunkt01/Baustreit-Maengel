-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Erstellungszeit: 22. Apr 2021 um 07:39
-- Server-Version: 5.7.32
-- PHP-Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Datenbank: `DB_LackTracking`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `aenderungen`
--

CREATE TABLE `aenderungen` (
  `id_aenderung` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `Kurztitel` varchar(255) NOT NULL,
  `Beschreibung` text NOT NULL,
  `Kostenauswirkung` decimal(19,4) NOT NULL COMMENT 'pauschal Euro in netto',
  `Terminauswirkung` varchar(255) NOT NULL COMMENT 'Beschreibung der Terminauswirkung in Prosa',
  `Freigabe` tinyint(1) NOT NULL,
  `externe Nummer` varchar(50) NOT NULL,
  `Verursacher` varchar(255) NOT NULL,
  `Risiko` text NOT NULL,
  `Empfehlung` text NOT NULL,
  `Finanzierung` text NOT NULL,
  `Anlagen` varchar(255) NOT NULL,
  `Projekt Verfasser Zuordnung` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Tabellenstruktur für Tabelle `aufgaben`
--

CREATE TABLE `aufgaben` (
  `id_aufgabe` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `bis` date NOT NULL,
  `Aufgabe` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Erledigungsvermerk` text COLLATE utf8_unicode_ci NOT NULL,
  `von` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Wer soll erledigen?',
  `erledigt` tinyint(1) NOT NULL COMMENT 'ist die Aufgabe erledigt?',
  `zu Projekt Verfasser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='eigene Aufgabenverwaltung';

--
-- Daten für Tabelle `aufgaben`
--

INSERT INTO `aufgaben` (`id_aufgabe`, `Datum`, `bis`, `Aufgabe`, `Erledigungsvermerk`, `von`, `erledigt`, `zu Projekt Verfasser`) VALUES
(1, '2021-04-21', '2021-04-28', 'Daten in Datenbank schreiben', '21.4.21: bisher wurde nichts erledigt', 'Jupp', 0, 1),
(2, '2021-04-21', '2021-04-28', 'Daten löschen', '20.4.21: keine Reaktion', 'Jupp', 0, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `beseitigungen`
--

CREATE TABLE `beseitigungen` (
  `id_beseitigung` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `zu id_anzeige` int(11) NOT NULL,
  `beseitigt` tinyint(1) NOT NULL,
  `Erledigungsvermerk` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `chronik`
--

CREATE TABLE `chronik` (
  `id_chronik` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `Vorgang` varchar(255) NOT NULL,
  `Beschreibung` text NOT NULL,
  `zu Projekt Verfasser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Projekthistorie';

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dokumente`
--

CREATE TABLE `dokumente` (
  `id_doku` int(11) NOT NULL,
  `vom` date NOT NULL,
  `von` varchar(255) NOT NULL,
  `an` varchar(255) NOT NULL,
  `Betreff` varchar(255) NOT NULL,
  `Anmerkung` text NOT NULL,
  `Kategorie` varchar(80) NOT NULL COMMENT 'z.B. Schriftverkehr, Aktenvermerk, Genehmigung',
  `Schlagworte` varchar(255) NOT NULL,
  `Lebensdauer` tinyint(4) NOT NULL COMMENT 'von 1 - 99 Jahre',
  `Anlage` blob NOT NULL,
  `Projekt Verfasser Zuordnung` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kommentare`
--

CREATE TABLE `kommentare` (
  `id_kommentar` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `Kommentar` text NOT NULL,
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
  `Mangelbeschreibung` text COLLATE utf8_unicode_ci NOT NULL,
  `Status` varchar(25) COLLATE utf8_unicode_ci NOT NULL COMMENT 'feste Werte (vor-, bei-, nach Abnahme)',
  `Gruppierung` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'eigene Gruppe, wie Bauteile oder FQ',
  `zu_id_projekt_nutzer` int(11) NOT NULL,
  `Anhang` int(11) NOT NULL COMMENT 'Verweis auf id_dokument'
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
(1, 'Testprojekt', 'Das Testprojekt dient zum ausprobieren. '),
(2, '2. Projekt', 'zu Testzwecken wurde ein zweites Projekt zur Datenbank eingefügt');

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
(1, 36, 1),
(2, 33, 2),
(3, 36, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `verfasser`
--

CREATE TABLE `verfasser` (
  `id_verfasser` int(11) NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Vor- Nachname',
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Passwort` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Rolle` tinyint(4) NOT NULL COMMENT 'Rechtevergabe',
  `registered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci COMMENT='Tabelle der Nutzer';

--
-- Daten für Tabelle `verfasser`
--

INSERT INTO `verfasser` (`id_verfasser`, `Name`, `Email`, `Passwort`, `Rolle`, `registered`) VALUES
(33, 'Tom Morello', '\0t\0o\0m\0@\0e\0m\0a\0i\0l\0.\0d\0e', '$2y$10$GwU1oI4prb58K1atFiiSGexiMrwwRiS1N51BttYI5yWwvpa6a/eem', 2, '2021-04-12 11:40:04'),
(36, 'Michael Weitz', 'weitz@baustreit.de', '$2y$10$KONBIbq.HHT9GdtVsA3z4uOEPBwip92PDDqO.sCsloXQ6FVwuUzMq', 2, '2021-04-14 16:18:17');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `verursacher`
--

CREATE TABLE `verursacher` (
  `id_verursacher` int(11) NOT NULL,
  `Name AN` varchar(80) NOT NULL,
  `Email AN` varchar(80) NOT NULL,
  `Gewerkeart` varchar(50) NOT NULL,
  `Anmerkung` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `aenderungen`
--
ALTER TABLE `aenderungen`
  ADD PRIMARY KEY (`id_aenderung`),
  ADD KEY `zu Projekt Verfasser` (`Projekt Verfasser Zuordnung`);

--
-- Indizes für die Tabelle `anzeigen`
--
ALTER TABLE `anzeigen`
  ADD PRIMARY KEY (`id_anzeige`),
  ADD KEY `zu id_mangel` (`zu id_mangel`),
  ADD KEY `zu id_verursacher` (`zu id_verursacher`);

--
-- Indizes für die Tabelle `aufgaben`
--
ALTER TABLE `aufgaben`
  ADD PRIMARY KEY (`id_aufgabe`),
  ADD KEY `Projekt Verfasser Zuordnung` (`zu Projekt Verfasser`);

--
-- Indizes für die Tabelle `beseitigungen`
--
ALTER TABLE `beseitigungen`
  ADD PRIMARY KEY (`id_beseitigung`),
  ADD KEY `zu id_anzeige` (`zu id_anzeige`);

--
-- Indizes für die Tabelle `chronik`
--
ALTER TABLE `chronik`
  ADD PRIMARY KEY (`id_chronik`),
  ADD KEY `Zuordnung Projekt Verfasser` (`zu Projekt Verfasser`) USING BTREE;

--
-- Indizes für die Tabelle `dokumente`
--
ALTER TABLE `dokumente`
  ADD PRIMARY KEY (`id_doku`),
  ADD KEY `Projekt Verfasser zu` (`Projekt Verfasser Zuordnung`);

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
  ADD KEY `zu_id_projekt_nutzer` (`zu_id_projekt_nutzer`),
  ADD KEY `Anhang` (`Anhang`);

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
  ADD PRIMARY KEY (`id_verursacher`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `aenderungen`
--
ALTER TABLE `aenderungen`
  MODIFY `id_aenderung` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `anzeigen`
--
ALTER TABLE `anzeigen`
  MODIFY `id_anzeige` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `aufgaben`
--
ALTER TABLE `aufgaben`
  MODIFY `id_aufgabe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `beseitigungen`
--
ALTER TABLE `beseitigungen`
  MODIFY `id_beseitigung` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `chronik`
--
ALTER TABLE `chronik`
  MODIFY `id_chronik` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `dokumente`
--
ALTER TABLE `dokumente`
  MODIFY `id_doku` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_projekt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `projekt_nutzer_zuordnung`
--
ALTER TABLE `projekt_nutzer_zuordnung`
  MODIFY `id_proj_zuordnung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `verfasser`
--
ALTER TABLE `verfasser`
  MODIFY `id_verfasser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT für Tabelle `verursacher`
--
ALTER TABLE `verursacher`
  MODIFY `id_verursacher` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `aenderungen`
--
ALTER TABLE `aenderungen`
  ADD CONSTRAINT `zu Projekt Verfasser` FOREIGN KEY (`Projekt Verfasser Zuordnung`) REFERENCES `projekt_nutzer_zuordnung` (`id_proj_zuordnung`);

--
-- Constraints der Tabelle `anzeigen`
--
ALTER TABLE `anzeigen`
  ADD CONSTRAINT `anzeigen_ibfk_1` FOREIGN KEY (`zu id_mangel`) REFERENCES `mangelliste` (`id_mangel`),
  ADD CONSTRAINT `anzeigen_ibfk_2` FOREIGN KEY (`zu id_verursacher`) REFERENCES `verursacher` (`id_verursacher`);

--
-- Constraints der Tabelle `aufgaben`
--
ALTER TABLE `aufgaben`
  ADD CONSTRAINT `Projekt Verfasser Zuordnung` FOREIGN KEY (`zu Projekt Verfasser`) REFERENCES `projekt_nutzer_zuordnung` (`id_proj_zuordnung`);

--
-- Constraints der Tabelle `beseitigungen`
--
ALTER TABLE `beseitigungen`
  ADD CONSTRAINT `beseitigungen_ibfk_1` FOREIGN KEY (`zu id_anzeige`) REFERENCES `anzeigen` (`id_anzeige`);

--
-- Constraints der Tabelle `chronik`
--
ALTER TABLE `chronik`
  ADD CONSTRAINT `Zuordnung Verfasser Projekt` FOREIGN KEY (`zu Projekt Verfasser`) REFERENCES `projekt_nutzer_zuordnung` (`id_proj_zuordnung`);

--
-- Constraints der Tabelle `dokumente`
--
ALTER TABLE `dokumente`
  ADD CONSTRAINT `Projekt Verfasser zu` FOREIGN KEY (`Projekt Verfasser Zuordnung`) REFERENCES `projekt_nutzer_zuordnung` (`id_proj_zuordnung`);

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
  ADD CONSTRAINT `mangelliste_ibfk_2` FOREIGN KEY (`zu_id_projekt_nutzer`) REFERENCES `projekt_nutzer_zuordnung` (`id_proj_zuordnung`),
  ADD CONSTRAINT `mangelliste_ibfk_3` FOREIGN KEY (`Anhang`) REFERENCES `dokumente` (`id_doku`);

--
-- Constraints der Tabelle `projekt_nutzer_zuordnung`
--
ALTER TABLE `projekt_nutzer_zuordnung`
  ADD CONSTRAINT `projekt_nutzer_zuordnung_ibfk_1` FOREIGN KEY (`id_verfasser`) REFERENCES `verfasser` (`id_verfasser`),
  ADD CONSTRAINT `projekt_nutzer_zuordnung_ibfk_2` FOREIGN KEY (`id_projekte`) REFERENCES `projekte` (`id_projekt`);
