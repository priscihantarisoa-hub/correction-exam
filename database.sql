-- Script de création des tables pour le système de correction d'examens

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
    type VARCHAR(20) NOT NULL, -- 'petit', 'moyen', 'grand'
    description VARCHAR(255)
);

-- Table Operateur (sup et difference)
CREATE TABLE operateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL, -- 'sup' (supérieur) ou 'difference'
    valeur INT NOT NULL -- la valeur de référence
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
    diff INT NOT NULL, -- la différence
    id_operateur INT NOT NULL,
    id_resolution INT NOT NULL,
    FOREIGN KEY (id_matiere) REFERENCES matiere(id),
    FOREIGN KEY (id_operateur) REFERENCES operateur(id),
    FOREIGN KEY (id_resolution) REFERENCES resolution(id)
);

-- Insertion des données de base pour Resolution
INSERT INTO resolution (type, description) VALUES 
('petit', 'Différence petite - moyenne simple'),
('moyen', 'Différence moyenne'),
('grand', 'Différence grande - moyenne pondérée');

-- Insertion des données de base pour Operateur
INSERT INTO operateur (nom, valeur) VALUES 
('sup', 2),
('difference', 3);

-- Insertion des données de base pour Matiere
INSERT INTO matiere (nom) VALUES 
('Mathématiques'),
('Physique'),
('Informatique'),
('Français'),
('Anglais');

-- Insertion des données de base pour Correcteur
INSERT INTO correcteur (nom) VALUES 
('Prof Aina'),
('Prof Ratsara'),
('Prof Randria'),
('Prof Rasoa');

-- Insertion des données de base pour Candidat
INSERT INTO candidat (nom) VALUES 
('Rakoto'),
('Rasoa'),
('Mamy'),
('Tiana'),
('Fitia');

-- Insertion des paramètres par matière
INSERT INTO parametre (id_matiere, diff, id_operateur, id_resolution) VALUES 
(1, 2, 2, 1), -- Maths: diff<=2 = petit
(1, 5, 2, 2),  -- Maths: diff<=5 = moyen
(1, 10, 2, 3), -- Maths: diff>5 = grand
(2, 2, 2, 1),  -- Physique: diff<=2 = petit
(2, 5, 2, 2),  -- Physique: diff<=5 = moyen
(2, 10, 2, 3), -- Physique: diff>5 = grand
(3, 2, 2, 1),  -- Info: diff<=2 = petit
(3, 5, 2, 2),  -- Info: diff<=5 = moyen
(3, 10, 2, 3); -- Info: diff>5 = grand

-- Notes d'exemple (à modifier par le prof)
INSERT INTO note (note, id_candidat, id_matiere, id_correcteur) VALUES 
-- Rakoto - Maths
(15, 1, 1, 1),
(14, 1, 1, 2),
-- Rakoto - Physique
(12, 1, 2, 1),
(18, 1, 2, 2),
-- Rasoa - Maths
(11, 2, 1, 1),
(11, 2, 1, 2),
-- Rasoa - Physique
(10, 2, 2, 1),
(14, 2, 2, 2);
