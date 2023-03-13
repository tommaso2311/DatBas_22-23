DROP DATABASE IF EXISTS DATABASE_PROJ;
CREATE DATABASE DATABASE_PROJ;

USE DATABASE_PROJ;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

#tabelle UTENTE
CREATE TABLE UTENTE (
  `eMail` varchar(30) NOT NULL PRIMARY KEY,
  `Nome` varchar(30) DEFAULT 'pippo' NOT NULL,
  `Cognome` varchar(30) NOT NULL, 
  `Anno di nascita` varchar(30) NOT NULL,
  `Luogo di nascita` varchar(30) NOT NULL, 
  `totale bonus` int(11) NOT NULL DEFAULT '0' 
) ENGINE="InnoDB";

CREATE TABLE UTENTE_PREMIUM (
	email varchar(30) PRIMARY KEY,
    costoAbbonamento varchar(30),
    numSondaggi int DEFAULT 0,
    inizioAbbonamento datetime DEFAULT NOW(),
    fineAbbonamento datetime DEFAULT (NOW() + INTERVAL 1 YEAR),
    FOREIGN KEY (email) REFERENCES UTENTE(eMail)
) ENGINE= 'INNODB';

CREATE TABLE UTENTE_AMMINISTRATORI (
	emailAdmin varchar(30) PRIMARY KEY REFERENCES UTENTE(eMail)
) ENGINE= 'INNODB';

CREATE TABLE AZIENDE (
	codiceFiscale varchar(30) PRIMARY KEY,
    email varchar(30),
    Nome varchar(30),
    Sede varchar(30)
) ENGINE= 'INNODB';

#tabelle domini
CREATE TABLE DOMINIO (
 parolaChiave varchar(30) PRIMARY KEY,
 Descrizione varchar(120)
) ENGINE = 'INNODB';

CREATE TABLE INTERESSAMENTO (
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    nomeDominio varchar(30) REFERENCES DOMINIO(parolaChiave),
    PRIMARY KEY (emailUtente, nomeDominio)
)ENGINE = 'INNODB';

#tabelle sondaggi
CREATE TABLE SONDAGGIO (
	Codice varchar(30) PRIMARY KEY,
    Titolo varchar(30) NOT NULL,
    maxUtenti int DEFAULT 100,
    dataCreazione datetime DEFAULT NOW(),
    dataChiusura datetime DEFAULT (NOW() + INTERVAL 1 MONTH), 
    stato ENUM('APERTO', 'CHIUSO'),
    CHECK (dataChiusura > dataCreazione)
) ENGINE = 'INNODB';

CREATE TABLE CREAZIONE_SONDAGGIO_UTENTE(
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    codiceNuovoSondaggio varchar(30) PRIMARY KEY REFERENCES SONDAGGIO(Codice)
) ENGINE = 'INNODB';

CREATE TABLE CREAZIONE_SONDAGGIO_PREMIUM(
	codiceAzienda varchar(30) REFERENCES AZIENDE(codiceFiscale),
    codiceNuovoSondaggio varchar(30) PRIMARY KEY REFERENCES SONDAGGIO(Codice)
) ENGINE = 'INNODB';

CREATE TABLE PROPRIETA (
	codiceSondaggio varchar(30) PRIMARY KEY REFERENCES SONDAGGIO(Codice),
    nomeDominio varchar(30) REFERENCES DOMINIO(parolaChiave)
) ENGINE = 'INNODB';

#tabelle domande 
CREATE TABLE COMPOSIZIONE (
	codiceSondaggio varchar(30) REFERENCES SONDAGGIO(Codice),
    idDomanda varchar(30) REFERENCES DOMANDA(ID), 
    PRIMARY KEY (codiceSondaggio, idDomanda)
) ENGINE = 'INNODB';

CREATE TABLE DOMANDA (
	ID varchar(30) PRIMARY KEY,
    Testo varchar(120) NOT NULL,
    Punteggio int DEFAULT 0,
    Foto BLOB DEFAULT NULL
) ENGINE ='INNODB';

CREATE TABLE DOMANDA_APERTA (
	ID varchar(30) PRIMARY KEY REFERENCES DOMANDA(ID),
    numMaxCaratteri int DEFAULT 150
) ENGINE='INNODB';

CREATE TABLE OPZIONE(
	idOpzione int,
    idDomanda varchar(30) REFERENCES DOMANDA(ID),
    Testo varchar(120),
    PRIMARY KEY (idOpzione, idDomanda)
)ENGINE='INNODB';
DELIMITER //
CREATE TRIGGER DefinisciIdOpzione BEFORE INSERT ON OPZIONE
FOR EACH ROW
BEGIN
	SET @id= 0;
    SELECT COUNT(*) INTO @id FROM OPZIONE WHERE idDomanda=new.idDomanda;
    SET new.idOpzione= @id;
END//
DELIMITER ;

CREATE TABLE INSERIMENTO_DOMANDA_PREMIUM(
	emailPremium varchar(30) REFERENCES UTENTE(eMail),
    idDomanda varchar(30) REFERENCES DOMANDA(ID),
    PRIMARY KEY (emailPremium, idDomanda)
) ENGINE ='INNODB';

CREATE TABLE INSERIMENTO_DOMANDA_AZIENDA(
	codiceAzienda varchar(30) REFERENCES AZIENDE(codiceFiscale),
    idDomanda varchar(30) REFERENCES DOMANDA(ID),
    PRIMARY KEY (codiceAzienda, idDomanda)
) ENGINE ='INNODB';

#tabelle risposte 
CREATE TABLE RISPOSTA(
	id INT PRIMARY KEY,
    codiceDomanda varchar(30) REFERENCES DOMANDA(ID),
    testoRisposta varchar(120) NOT NULL,
    tipo ENUM('APERTA', 'CHIUSA'),
    emailUtente varchar(30) REFERENCES UTENTE(eMail),
    UNIQUE KEY (codiceDomanda, emailUtente)
) ENGINE ='INNODB';


#tabelle premi
CREATE TABLE PREMIO(
	Nome varchar(30) PRIMARY KEY,
	Descrizione varchar(50),
    minPunti int DEFAULT 0,
    Foto BLOB DEFAULT NULL,
    Autore varchar(30) REFERENCES UTENTE_AMMINISTRATORE(emailAdmin)
)ENGINE='INNODB';

CREATE TABLE PREMI_VINTI(
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    nomePremio varchar(30) REFERENCES PREMIO(Nome),
    PRIMARY KEY (emailUtente, nomePremio)
)ENGINE='INNODB';

#tabelle inviti
CREATE TABLE INVITO (
	Codice varchar(30) PRIMARY KEY,
    Esito ENUM('ACCETTATO', 'RIFIUTATO'),
    Autore varchar(30) REFERENCES UTENTE(eMail),
    Destinatario varchar(30) REFERENCES UTENTE(eMail),
    codiceSondaggio varchar(30) REFERENCES SONDAGGIO(Codice)
) ENGINE='INNODB'; 

#tabelle lista UTENTE
CREATE TABLE LISTA_UTENTI (
	Numero int,
    emailUtente varchar(30) REFERENCES UTENTE(eMail),
    PRIMARY KEY (Numero, emailUtente)
)ENGINE='INNODB';

CREATE TABLE ASSOCIAZIONE_LISTA (
	codiceSondaggio varchar(30) REFERENCES SONDAGGIO(Codice),
    numeroLista int REFERENCES LISTA_UTENTI(Numero),
    PRIMARY KEY ( codiceSondaggio, numeroLista),
    UNIQUE KEY (codiceSondaggio)
)ENGINE='INNODB';

DELIMITER $$
## • Autenticazione sulla piattaforma
CREATE PROCEDURE Login(IN email varchar(30), OUT isRegistered int)
BEGIN
      SELECT count(*) INTO isRegistered FROM UTENTE u WHERE u.eMail = email;         
END $$

