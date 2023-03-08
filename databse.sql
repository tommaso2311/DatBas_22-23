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
    fineAbbonamento datetime NOT NULL,
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

CREATE TABLE INTERESSI (
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    nomeDominio varchar(30) REFERENCES DOMINIO(parolaChiave),
    PRIMARY KEY (emailUtente, nomeDominio)
)ENGINE = 'INNODB';

#tabelle sondaggi
CREATE TABLE SONDAGGIO (
	Codice varchar(30) PRIMARY KEY,
    Titolo varchar(30) NOT NULL,
    maxUTENTE int DEFAULT 100,
    dataCreazione datetime DEFAULT NOW(),
    dataChiusura date, #CAPIRE COME METTERE IL DEFAULT A OGGI  
    stato ENUM('APERTO', 'CHIUSO')
) ENGINE = 'INNODB';

CREATE TABLE CREAZIONE_SONDAGGI(
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    codiceNuovoSondaggio varchar(30) PRIMARY KEY REFERENCES SONDAGGIO(Codice)
) ENGINE = 'INNODB';

### CONTROLLA CHE DATACHIUSURA > DATACREAZIONE --> forse conviene timestamp

CREATE TABLE PROPRIETA ( #ila l'ha chiamata disponsizione
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
	idOpzione int AUTO_INCREMENT,
    idDomanda varchar(30) REFERENCES DOMANDA(ID),
    Testo varchar(120),
    PRIMARY KEY (idOpzione, idDomanda)
)ENGINE='INNODB';

CREATE TABLE INSERIMENTO_DOMANDE(
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    idDomanda varchar(30) REFERENCES DOMANDA(ID),
    PRIMARY KEY (emailUtente, idDomanda)
) ENGINE ='INNODB';

#tabelle risposte 
CREATE TABLE RISPOSTA(
	id INT PRIMARY KEY,
    codiceSondaggio varchar(30) REFERENCES SONDAGGIO(Codice),
    testoRisposta varchar(120) NOT NULL,
    tipo ENUM('APERTA', 'CHIUSA')
) ENGINE ='INNODB';

CREATE TABLE INSERIMENTO_RISPOSTE(
	emailUtente varchar(30) REFERENCES UTENTE(eMail),
    idRisposta int REFERENCES RISPOSTA(id),
    PRIMARY KEY (emailUtente, idRisposta)
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
CREATE TABLE LISTA_UTENTE (
	Numero int,
    emailUtente varchar(30) REFERENCES UTENTE(eMail),
    PRIMARY KEY (Numero, emailUtente)
)ENGINE='INNODB';

CREATE TABLE ASSOCIAZIONE_LISTA (
	codiceSondaggio varchar(30) REFERENCES SONDAGGIO(Codice),
    numeroLista int REFERENCES LISTA_UTENTE(Numero),
    PRIMARY KEY ( codiceSondaggio, numeroLista),
    UNIQUE KEY (codiceSondaggio)
)ENGINE='INNODB';

DELIMITER $$
## • AUTENTEcazione/registrazione sulla piattaforma -> insert on UTENTE

## • Collegamento ad un dominio di interesse -> insert on interessi
CREATE PROCEDURE InserisciInteresse(IN utenteAttuale varchar(30), nomeDominio varchar(30))
BEGIN
	INSERT INTO INTERESSI VALUES (utenteAttuale, nomeDominio);
END $$
##• Visualizzazione degli inviti a partecipare ad un sondaggio -> select 
CREATE PROCEDURE VisualizzaInviti(IN utenteAttuale varchar(30))
BEGIN
	SELECT Autore, codiceSondaggio FROM INVITO 
	WHERE Destinatario = utenteAttuale;
END $$
##• Accettazione/rifiuto di un invito
CREATE PROCEDURE RiscontroInvito(IN codiceInvito varchar(30), riscontro varchar(30))
BEGIN
	IF riscontro = 'ACCETTATO' THEN
		UPDATE INVITO SET Esito = 'ACCETTATO' WHERE Codice = codiceInvito;
	ELSE
		UPDATE INVITO SET Esito = 'RIFIUTATO' WHERE Codice = codiceInvito;
	END IF;
END $$
##• Inserimento delle risposte per un sondaggio
##• Visualizzazione dei sondaggi cui si è partecipato e delle risposte relative
##• Visualizzazione dei premi conseguiti


