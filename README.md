# DatBas_22-23

(da modificare)

Progetto del corso di Basi di Dati A/A 2022/2023

A cura di Arianna Arruzzoli, Ilaria Golluscio, Tommaso Quintavalli.

Docenti: Marco di Felice, Luca Sciullo.

Per eseguire l'applicazione, è necessario installare PHP ed attivare il server. Questa operazione
viene fatta aprendo un terminale nella cartella del progetto e digitando:

'php -S localhost:8889'

il quale aprirù un server alla porta 8889. Si può modificare la porta a paicimento, cambiandola quando si fa partire il server con la linea di comando.

A questo punto, per selezionare il database, bisogna specificare nella configurazione di MySQL
la Base Directory, mettendoci la cartella del progetto.
Bisogna quindi aprire un nuovo terminale e digitare:

'/user/local/mysql/bin/mysql -u root -p'

per poi inserire la password di MySQL.

Bisogna poi creare un database nuovo, selezionrarlo ed importarvi il file 'database.sql' tramite 

'mysql source databse.sql;'

Questi ultimi passi vanno fatti solo la prima volta.

Per intergaire con il DB da terminale, per le volte successive basta
mandare il comando

'/usr/local/mysql/bin/mysql -u root -p'

e poi selezionare il DB con

use DATABASE_PROJ;

A questo punto basta recarsi all'indirizzo

http://localhost:8889/

per accere al primo Index dell'applicazione.

Quando si modifica l'app, basta fare un refresh della pagina per vedere i cambiamenti.

