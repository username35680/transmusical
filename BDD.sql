drop schema if exists transmusicales cascade;
create schema transmusicales;
set schema 'transmusicales';

create table _annee (
  an numeric(4) not null primary key
);

create table _pays (
  nom_p char not null primary key
);

create table _type_musique (
  type_m char not null primary key
);

CREATE TABLE transmusicales._formation
(
   libelle_formation  char(1)   NOT NULL
);

ALTER TABLE transmusicales._formation
   ADD CONSTRAINT _formation_pkey
   PRIMARY KEY (libelle_formation);

create table _groupe_artiste(
  Id_Groupe_Artiste int not null primary key,
  nom_groupe_artiste char not null,
  site_web char not null,
  debut numeric(4) not null,
  sortie_discographie numeric(4) not null,
  origine char not null,
  constraint groupe_fk_debut foreign key (debut) references _annee(an),
  constraint groupe_fk_sortie_disco foreign key (sortie_discographie) references _annee(an),
  constraint groupe_fk_origine foreign key (origine) references _pays(nom_p)
  
 );

create table _ville (
  nom_v char not null primary key,
  se_situe char not null,
  constraint ville_fk_pays foreign key (se_situe) references _pays(nom_p)
);

create table _edition (
  nom_edition char not null primary key,
  annee_edition numeric(4) not null,
  constraint edition_fk_annee foreign key (annee_edition) references _annee(an)
);

create table _a_pour (
  id_groupe_artiste int,
  libelle_formation char,
  constraint groupe_fk_formation foreign key (id_groupe_artiste) references _groupe_artiste(Id_Groupe_Artiste),
  constraint formation_fk_groupe foreign key (libelle_formation) references _formation(libelle_formation)
);

create table _type_ponctuel (
  id_groupe_artiste int,
  type_m char,
  constraint groupe_fk_type_m foreign key (id_groupe_artiste) references _groupe_artiste(Id_Groupe_Artiste),
  constraint type_m_fk_groupe foreign key (type_m) references _type_musique(type_m)
);

create table _type_principal (
  id_groupe_artiste int,
  type_m char,
  constraint groupe_fk_type_m_p foreign key (id_groupe_artiste) references _groupe_artiste(Id_Groupe_Artiste),
  constraint type_m_fk_groupe_p foreign key (type_m) references _type_musique(type_m)
);
  
CREATE TABLE transmusicales._lieu
(
   id_lieu       char(1)   NOT NULL,
   nom_lieu      char(1)   NOT NULL,
   accespmr      boolean   NOT NULL,
   capacite_max  integer   NOT NULL,
   type_lieu     char(1)   NOT NULL,
   nom_v         char(1)   NOT NULL
);

ALTER TABLE transmusicales._lieu
   ADD CONSTRAINT _lieu_pkey
   PRIMARY KEY (id_lieu);

ALTER TABLE _lieu
  ADD CONSTRAINT lieu_fk_ville FOREIGN KEY (nom_v)
  REFERENCES transmusicales._ville (nom_v) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;
  
CREATE TABLE transmusicales._concert
(
   no_concert  char(1)   NOT NULL,
   titre       char(1)   NOT NULL,
   resume      char(1)   NOT NULL,
   duree       integer   NOT NULL,
   tarif       float8    NOT NULL,
   type_m      char(1)   NOT NULL
);

ALTER TABLE transmusicales._concert
   ADD CONSTRAINT _concert_pkey
   PRIMARY KEY (no_concert);

ALTER TABLE _concert
  ADD CONSTRAINT concert_fk_type FOREIGN KEY (type_m)
  REFERENCES transmusicales._type_musique (type_m) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;
  
CREATE TABLE transmusicales._representation
(
   numero_representation  char(1)   NOT NULL,
   heure                  char(1)   NOT NULL,
   date_representation    date      NOT NULL,
   no_concert             char(1)   NOT NULL,
   id_lieu                char(1)   NOT NULL,
   id_groupe_artiste int not null,
   constraint repre_fk_groupe foreign key (id_groupe_artiste) references _groupe_artiste(Id_Groupe_Artiste)
);

ALTER TABLE transmusicales._representation
   ADD CONSTRAINT _representation_pkey
   PRIMARY KEY (numero_representation);

ALTER TABLE _representation
  ADD CONSTRAINT representation_fk_concert FOREIGN KEY (no_concert)
  REFERENCES transmusicales._concert (no_concert) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE _representation
  ADD CONSTRAINT representation_fk_lieu FOREIGN KEY (id_lieu)
  REFERENCES transmusicales._lieu (id_lieu) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;
   

CREATE TABLE transmusicales._representation
(
   numero_representation  char(1)   NOT NULL primary key,
   heure                  char(1)   NOT NULL,
   date_representation    date      NOT NULL,
   no_concert             char(1)   NOT NULL,
   id_lieu                char(1)   NOT NULL,
   id_groupe_artiste      integer   NOT NULL
);

ALTER TABLE _representation
  ADD CONSTRAINT representation_fk_concert FOREIGN KEY (no_concert)
  REFERENCES transmusicales._concert (no_concert) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE _representation
  ADD CONSTRAINT repre_fk_groupe FOREIGN KEY (id_groupe_artiste)
  REFERENCES transmusicales._groupe_artiste (id_groupe_artiste) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;

ALTER TABLE _representation
  ADD CONSTRAINT representation_fk_lieu FOREIGN KEY (id_lieu)
  REFERENCES transmusicales._lieu (id_lieu) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION;