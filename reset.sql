-- Script de réinitialisation de la base de données
-- Ce script supprime toutes les données et recrée les tables

-- Suppression des tables dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS parametre CASCADE;
DROP TABLE IF EXISTS note CASCADE;
DROP TABLE IF EXISTS operateur CASCADE;
DROP TABLE IF EXISTS resolution CASCADE;
DROP TABLE IF EXISTS candidat CASCADE;
DROP TABLE IF EXISTS matiere CASCADE;
DROP TABLE IF EXISTS correcteur CASCADE;

-- Recréation des tables
-- Table Correcteur
CREATE TABLE correcteur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table Matiere
CREATE TABLE matiere (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table Candidat
CREATE TABLE candidat (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table Resolution (petit, moyen, grand)
CREATE TABLE resolution (
    id SERIAL PRIMARY KEY,
    type VARCHAR(20) NOT NULL,
    description VARCHAR(255)
);

-- Table Operateur (sup et difference)
CREATE TABLE operateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    valeur INT NOT NULL
);

-- Table Note
CREATE TABLE note (
    id SERIAL PRIMARY KEY,
    note DECIMAL(5,2) NOT NULL,
    id_candidat INT NOT NULL,
    id_matiere INT NOT NULL,
    id_correcteur INT NOT NULL,
    FOREIGN KEY (id_candidat) REFERENCES candidat(id),
    FOREIGN KEY (id_matiere) REFERENCES matiere(id),
    FOREIGN KEY (id_correcteur) REFERENCES correcteur(id)
);

-- Table Parametre
CREATE TABLE parametre (
    id SERIAL PRIMARY KEY,
    id_matiere INT NOT NULL,
    diff INT NOT NULL,
    id_operateur INT NOT NULL,
    id_resolution INT NOT NULL,
    FOREIGN KEY (id_matiere) REFERENCES matiere(id),
    FOREIGN KEY (id_operateur) REFERENCES operateur(id),
    FOREIGN KEY (id_resolution) REFERENCES resolution(id)
);

-- Réinsertion des données de base
INSERT INTO resolution (type, description) VALUES 
('petit', 'Différence petite - moyenne simple'),
('moyen', 'Différence moyenne'),
('grand', 'Différence grande - moyenne pondérée');

INSERT INTO operateur (nom, valeur) VALUES 
('sup', 2),
('difference', 3);

INSERT INTO matiere (nom) VALUES 
('Mathématiques'),
('Physique'),
('Informatique'),
('Français'),
('Anglais');

INSERT INTO correcteur (nom) VALUES 
('Prof Aina'),
('Prof Ratsara'),
('Prof Randria'),
('Prof Rasoa');

INSERT INTO candidat (nom) VALUES 
('Rakoto'),
('Rasoa'),
('Mamy'),
('Tiana'),
('Fitia');

INSERT INTO parametre (id_matiere, diff, id_operateur, id_resolution) VALUES 
(1, 2, 2, 1),
(1, 5, 2, 2),
(1, 10, 2, 3),
(2, 2, 2, 1),
(2, 5, 2, 2),
(2, 10, 2, 3),
(3, 2, 2, 1),
(3, 5, 2, 2),
(3, 10, 2, 3);

-- Notes d'exemple
INSERT INTO note (note, id_candidat, id_matiere, id_correcteur) VALUES 
(15, 1, 1, 1),
(14, 1, 1, 2),
(12, 1, 2, 1),
(18, 1, 2, 2),
(11, 2, 1, 1),
(11, 2, 1, 2),
(10, 2, 2, 1),
(14, 2, 2, 2);
