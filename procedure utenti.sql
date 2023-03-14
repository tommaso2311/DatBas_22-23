DELIMITER $$
## • Autenticazione sulla piattaforma
CREATE PROCEDURE Login(IN email varchar(30), OUT isRegistered int)
BEGIN
      SELECT count(*) INTO isRegistered FROM UTENTE u WHERE u.eMail = email;         
END $$

## • registrazione sulla piattaforma 
CREATE PROCEDURE RegistrazioneUtente(IN email varchar(30), nome varchar(30), cognome varchar(30), Anno_di_nascita varchar(30), Luogo_di_Nascita varchar(30))
BEGIN
	INSERT INTO UTENTE(eMail, Nome, Cognome, `Anno di nascita`, `Luogo di nascita`) 
                VALUES (email, nome, cognome, Anno_di_nascita, Luogo_di_Nascita);
END $$

## • Collegamento ad un dominio di interesse 
CREATE PROCEDURE InserisciInteresse(IN utenteAttuale varchar(30), nomeDominio varchar(30))
BEGIN
	INSERT INTO INTERESSI VALUES (utenteAttuale, nomeDominio);
END $$

##• Visualizzazione degli inviti a partecipare ad un sondaggio
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
CREATE PROCEDURE InserireRisposta(IN email varchar(30), codiceSondaggio varchar(30), codiceDomanda varchar(30), testo varchar(120))
BEGIN
    IF EXISTS (SELECT * FROM DOMANDA_APERTA WHERE codiceDomanda= ID) THEN
		INSERT INTO RISPOSTA (codiceDomanda, testoRisposta, tipo, emailUtente) 
				VALUES (codiceDomanda, testo, 'ACCETTATO', email);
	ELSE
		INSERT INTO RISPOSTA (codiceDomanda, testoRisposta, tipo, emailUtente) 
				VALUES (codiceDomanda, testo, 'RIFIUTATO', email);
	END IF;
END $$

##• Visualizzazione dei sondaggi cui si è partecipato 
CREATE PROCEDURE VisualizzaSondaggi(IN utenteAttuale varchar(30))
BEGIN
	SELECT Titolo, stato FROM SONDAGGIO, ASSOCIAZIONE_LISTA
    WHERE Codice=codiceSondaggio AND numeroLista IN (SELECT Numero FROM LISTA_UTENTE WHERE emailUtente=utenteAttuale);
END $$

#e delle risposte relative
CREATE PROCEDURE VisualizzaRisposteDate(IN utenteAttuale varchar(30), codiceSondaggio varchar(30))
BEGIN
	SELECT RISPOSTA.testoRisposta, DOMANDA.Testo FROM RISPOSTA, DOMANDA
    WHERE RISPOSTA.codiceDomanda = DOMANDA.ID AND
    RISPOSTA.emailUtente = utenteAttuale AND 
    DOMANDA.ID IN (SELECT idDomanda FROM COMPOSIZIONE WHERE COMPOSIZIONE.codiceSondaggio = codiceSondaggio);
END $$

##• Visualizzazione dei premi conseguiti
CREATE PROCEDURE VisualizzaPremi(IN utenteAttuale varchar(30))
BEGIN
	SELECT Nome, Descrizione FROM PREMIO 
    WHERE Nome in (SELECT nomePremio FROM PREMI_VINTI WHERE emailUtente=utenteAttuale);
END $$

##• Inserimento di una nuova domanda
CREATE PROCEDURE InserisciDomanda(IN ID varchar(30), Testo varchar(120), Punteggio int)
BEGIN
	INSERT INTO UTENTE_PREMIUM (ID, Testo, numSondaggi, Punteggio)
	VALUES (ID, Testo, numSondaggi, Punteggio)

##• Creazione di un nuovo sondaggio
CREATE PROCEDURE InserisciSondaggio(IN Codice varchar(30), Titolo varchar(30), maxUtenti int, dataCreazione datetime, dataChiusura datetime, stato)
BEGIN
	INSERT INTO SONDAGGIO (Codice, Titolo, maxUtenti, dataCreazione, maxUtenti int, dataChiusura, stato)
	VALUES (Codice, Titolo, maxUtenti, dataCreazione, dataChiusura, stato)
END $$

##• Creazione di un invito ad un sondaggio verso un utente della piattaforma
CREATE PROCEDURE CreaInvito(IN Codice varchar(30), Esito ENUM('ACCETTATO', 'RIFIUTATO'), Autore varchar(30), Autore varchar(30), Destinatario varchar(30), codiceSondaggio varchar(30))
BEGIN
	INSERT INTO SONDAGGIO (Codice, Esito, Autore, Destinatario, codiceSondaggio)
	VALUES (Codice, Esito, Autore, Destinatario, codiceSondaggio)
END $$

##• Visualizzazione delle risposte di un sondaggio
CREATE PROCEDURE VisualizzaRisposte(IN codiceSondaggio varchar(30))
BEGIN
	SELECT testoRisposta FROM RISPOSTA, COMPOSIZIONE, SONDAGGIO WHERE codiceDomanda = COMPOSIZIONE.idDomanda AND COMPOSIZIONE.codiceSondaggio = SONDAGGIO.Codice
END


