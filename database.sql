-- Script de réinitialisation complète
\c correction_exam;

DELETE FROM note;
DELETE FROM candidat;
DELETE FROM matiere;
DELETE FROM correcteur;
DELETE FROM parametre;
DELETE FROM resolution;
DELETE FROM operateur;

ALTER SEQUENCE note_id_seq RESTART WITH 1;
ALTER SEQUENCE candidat_id_seq RESTART WITH 1;
ALTER SEQUENCE matiere_id_seq RESTART WITH 1;
ALTER SEQUENCE correcteur_id_seq RESTART WITH 1;

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

-- Table Operateur
CREATE TABLE operateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(20) NOT NULL, -- 'sup', 'inf', 'supegal', 'infegal'
    description VARCHAR(100)
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
    valeur INT NOT NULL, -- la valeur de comparaison
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
INSERT INTO operateur (nom, description) VALUES 
('sup', '> (supérieur)'),
('inf', '< (inférieur)'),
('supegal', '>= (supérieur ou égal)'),
('infegal', '<= (inférieur ou égal)');

-- Insertion des données de base pour Matiere
INSERT INTO matiere (nom) VALUES 
('JAVA'),
('PHP');

-- Insertion des données de base pour Correcteur
INSERT INTO correcteur (nom) VALUES 
('Correcteur1'),
('Correcteur2');

-- Insertion des données de base pour Candidat
INSERT INTO candidat (nom) VALUES 
('Candidat1'),
('Candidat2');
