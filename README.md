# DatBas_22-23

(da modificare)

Progetto del corso di Basi di Dati A/A 2022/2023

A cura di Arianna Arruzzoli, Ilaria Golluscio, Tommaso Quintavalli.

Docenti: Marco di Felice, Luca Sciullo.

### Pre-requisiti:
- avere PHP installato nel proprio computer
- avere mysql server installato nel proprio computer

## Come far partire l'applicazione:
***PHP:***
Per eseguire l'applicazione, è necessario installare PHP ed attivare il server. Questa operazione
viene fatta aprendo un terminale *nella cartella del progetto* e digitando:

``` php -S localhost:8889 ```

il quale aprirà un server alla porta 8889. Si può modificare la porta a piacimento, cambiandola quando si fa partire il server con la linea di comando.

***MySQL:***
A questo punto, per selezionare il database, è necessario far partire il server MySQL.
<sub>bisogna specificare nella configurazione di MySQL la Base Directory, mettendoci la cartella del progetto.</sub>
Bisogna quindi aprire un nuovo terminale e digitare:

```/user/local/mysql/bin/mysql -u root -p```
oppure
```mysql -u root -p```

per poi inserire la password di MySQL.

_ Passaggi complementari se è la prima volta che viene fatta partire l'applicazione _
Bisogna definire come source lo script sql che definisce il database, è necessario quindi inserie il comando:


``` source DatBas_22-23/databse.sql```


Per intergaire con il DB da terminale, per le volte successive basta mandare il comando

```/usr/local/mysql/bin/mysql -u root -p```

e poi selezionare il DB con

```use DATABASE_PROJ;```

A questo punto basta recarsi all'indirizzo

[http://localhost:8889/](http://localhost:8889/)

per accere al primo Index dell'applicazione.

Quando si modifica l'app, basta fare un refresh della pagina per vedere i cambiamenti.

