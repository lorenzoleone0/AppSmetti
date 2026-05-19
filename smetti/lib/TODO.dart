//TODO: creare logo per l'applicazione

//spagnolo, francese, tedesco, russo, inglese, italiano, coreano, portoghese
 

//aggiungere privacy e policy

//aggiungere easter egg (se me và). mettere nella sezione dell'euro un impostazione hìche se ci clicchi
//due volte esce al posto della valuta ¥€£$, o che comunque ogni volta che clicchi è diverso 

//chiamare l'app Domani Smetto (Tomorrow I Quit), andare su android manifest android:label="nome", per iOS: Vai in ios/Runner/Info.plist.
//Cerca <key>CFBundleName</key> o <key>CFBundleDisplayName</key> e cambia la stringa subito sotto: 
//<string>Nuovo Nome</string> (nome sotto licona del telefono)
//Cambiare il Package Name (Application ID):Se non hai ancora pubblicato, il modo più veloce e sicuro per farlo è 
//usare il pacchetto change_app_package_name: Esegui questo comando nel terminale:
//flutter pub run change_app_package_name:main com.nuovonome.tuo

/* altra domanda, quando la pubblicherò il nome visibile su google 
play e apple store qualè sarà e sarà tradotto, 
oppure la traduzione la dovrò fare per ogni paese dove la pubblicherò?
-----------
Il nome che l'utente vedrà sugli store dipende da due livelli diversi: 
il nome della scheda prodotto (quello che si legge mentre si naviga nello store) 
e il nome dell'app installata (quello sotto l'icona sul telefono).
Ecco come gestire le traduzioni:
1. Nome sulla scheda (Google Play e App Store)
Questo è il nome che serve per il marketing e la ricerca (SEO). Non si traduce in automatico: 
devi farlo tu manualmente nelle console sviluppatore.
Cosa fare: All'interno di Google Play Console e App Store Connect, 
troverai una sezione chiamata "Localizzazione" o "Lingue". Dovrai aggiungere le lingue desiderate (es. Francese, Inglese) 
e inserire per ognuna il titolo tradotto.
Esempio:
Italia: Smetti di Fumare e Risparmia
Francia: Arrêter de Fumer et Économiser
Global: Stop Smoking & Save Money
2. Nome sotto l'icona (Sul telefono)
Per far sì che il nome sotto l'icona cambi in base alla lingua del telefono, devi configurare i file nativi, 
poiché il sistema operativo legge quel nome prima ancora di avviare Flutter.
Per Android:
Devi usare le cartelle dei valori (values) in android/app/src/main/res/:
In values/strings.xml, metti il nome italiano: <string name="app_name">Risparmia</string>.
Crea una cartella values-en/ con un file strings.xml: <string name="app_name">Save Money</string>.
Nel tuo AndroidManifest.xml, assicurati che ci sia: android:label="@string/app_name".
Per iOS:
Si usano i file InfoPlist.strings:
In Xcode, aggiungi le localizzazioni al progetto.
Crea un file chiamato InfoPlist.strings per ogni lingua.
Dentro scrivi: CFBundleDisplayName = "Save Money"; (per l'inglese) e così via.
💡 Un consiglio strategico
Dato che la tua app ha un messaggio forte ("spendi 1€ per risparmiarne centinaia"), 
ti suggerisco vivamente di tradurre il titolo dello store almeno per le lingue principali (Inglese, Francese, Spagnolo, Tedesco). 
Se un utente inglese cerca "Stop smoking", la tua app non apparirà mai se il titolo è solo in italiano. */

