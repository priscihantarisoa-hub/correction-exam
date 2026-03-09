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


CREATE TABLE correcteur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE matiere (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE candidat (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE resolution (
    id SERIAL PRIMARY KEY,
    type VARCHAR(20) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE operateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL, 
    valeur INT NOT NULL 
);

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


INSERT INTO note (note, id_candidat, id_matiere, id_correcteur) VALUES 

(15, 1, 1, 1),
(14, 1, 1, 2),

(12, 1, 2, 1),
(18, 1, 2, 2),

(11, 2, 1, 1),
(11, 2, 1, 2),

(10, 2, 2, 1),
(14, 2, 2, 2);


