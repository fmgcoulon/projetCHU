-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 17 jan. 2020 à 16:13
-- Version du serveur :  8.0.18
-- Version de PHP : 7.3.11-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `TEST`
--

-- --------------------------------------------------------

--
-- Structure de la table `COMPTE_RENDU`
--

CREATE TABLE `COMPTE_RENDU` (
  `id` int(11) NOT NULL,
  `date_elaboration` timestamp NOT NULL,
  `struct_bio` blob,
  `struct_diag` blob,
  `struct_acte` blob,
  `text_bio` text,
  `text_diag` text,
  `text_acte` text,
  `exam_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `MOUVEMENT`
--

CREATE TABLE `MOUVEMENT` (
  `id` int(11) NOT NULL,
  `date in` timestamp NOT NULL,
  `date out` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `NOMENCLATURE`
--

CREATE TABLE `NOMENCLATURE` (
  `id` int(11) NOT NULL,
  `code` varchar(7) NOT NULL,
  `libelle` varchar(50) NOT NULL,
  `acte` varchar(7) NOT NULL,
  `unite_mesure` varchar(10) NOT NULL,
  `norme_min` decimal(10,0) NOT NULL,
  `norme_max` decimal(10,0) NOT NULL,
  `exam_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `PATIENT`
--

CREATE TABLE `PATIENT` (
  `ipp` varchar(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `sexe` enum('Masculin','Féminin') NOT NULL,
  `date_naissance` date NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `code_postal` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `commune` varchar(30) NOT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `telephone` varchar(10) DEFAULT NULL,
  `sejour_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `PATIENT`
--

INSERT INTO `PATIENT` (`ipp`, `nom`, `prenom`, `sexe`, `date_naissance`, `adresse`, `code_postal`, `commune`, `mail`, `telephone`, `sejour_id`) VALUES
('1205', 'dupond', 'jean', 'Masculin', '2019-12-10', 'rue marlot', '37850', 'pouzioux', 'dupond@sfr.fr', '0247475856', '0'),
('1210', 'dupont', 'jacques', 'Masculin', '2019-12-10', 'rue ducon', '37000', 'tours', 'dupont@free.fr', '0247586366', '0'),
('1305', 'durant', 'sophie', 'Féminin', '2018-05-02', 'bd jaures', '37170', 'chambray', 'soso@tutu.fr', '0247989895', '0'),
('1555', 'ducon', 'thierry', 'Masculin', '2019-02-01', 'rue cholet', '37320', 'cormery', 'fff@fff.fr', '0247523635', '0');

-- --------------------------------------------------------

--
-- Structure de la table `SEJOUR`
--

CREATE TABLE `SEJOUR` (
  `iep` varchar(10) NOT NULL,
  `date_in` timestamp NOT NULL,
  `date_out` timestamp NULL DEFAULT NULL,
  `mouv_id` int(11) NOT NULL,
  `cr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `TYPE_EXAMEN`
--

CREATE TABLE `TYPE_EXAMEN` (
  `id` int(11) NOT NULL,
  `type_acte` varchar(7) NOT NULL,
  `valeur_releve` decimal(10,0) NOT NULL,
  `date_elaboration` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `COMPTE_RENDU`
--
ALTER TABLE `COMPTE_RENDU`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Index pour la table `MOUVEMENT`
--
ALTER TABLE `MOUVEMENT`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `NOMENCLATURE`
--
ALTER TABLE `NOMENCLATURE`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`) USING BTREE;

--
-- Index pour la table `PATIENT`
--
ALTER TABLE `PATIENT`
  ADD PRIMARY KEY (`ipp`),
  ADD KEY `sejour_id` (`sejour_id`);

--
-- Index pour la table `SEJOUR`
--
ALTER TABLE `SEJOUR`
  ADD PRIMARY KEY (`iep`),
  ADD KEY `mouv_id` (`mouv_id`),
  ADD KEY `cr_id` (`cr_id`);

--
-- Index pour la table `TYPE_EXAMEN`
--
ALTER TABLE `TYPE_EXAMEN`
  ADD PRIMARY KEY (`id`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `COMPTE_RENDU`
--
ALTER TABLE `COMPTE_RENDU`
  ADD CONSTRAINT `COMPTE_RENDU_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `TYPE_EXAMEN` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `NOMENCLATURE`
--
ALTER TABLE `NOMENCLATURE`
  ADD CONSTRAINT `NOMENCLATURE_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `TYPE_EXAMEN` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `SEJOUR`
--
ALTER TABLE `SEJOUR`
  ADD CONSTRAINT `SEJOUR_ibfk_1` FOREIGN KEY (`mouv_id`) REFERENCES `MOUVEMENT` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `SEJOUR_ibfk_2` FOREIGN KEY (`cr_id`) REFERENCES `COMPTE_RENDU` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
