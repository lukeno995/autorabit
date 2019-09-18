public without sharing class PO_FATT_WS_PSM_Notify_Utils {
	//DEBUG MODE
	public static Boolean DEBUG_MODE =true;

	//VARIABILI
	public static String CODICE_NOTIFICA_0 ='0';
	public static String CODICE_NOTIFICA_1 ='1';
	public static String CODICE_NOTIFICA_2 ='2';
	public static String CODICE_NOTIFICA_3 ='3';
    
    
    //ESTENSIONI AMMESSE FILE
    public static String KMZ ='.kmz';
    public static String ZIP ='.zip';
    public static String JPG ='.jpg';
    public static String PNG ='.png';
    public static String DWG ='.dwg';
    public static String SHP ='.shp';

	public static String STATO_ORDINE_0 ='0';
	public static String STATO_ORDINE_1 ='1';
	public static String STATO_ORDINE_2 ='2';
	public static String STATO_ORDINE_3 ='3';


	public static String ESITO_1 = '1';
	public static String ESITO_0 = '0';

	public static String ESITO_C_N_ERRATO='ESITO_C_N_ERRATO';
	public static String CODICE_MOTIVAZIONE_C_N_ERRATO='CODICE_MOTIVAZIONE_C_N_ERRATO';
	public static String MOTIVAZIONE_C_N_ERRATO='MOTIVAZIONE_C_N_ERRATO';

	public static String CODICE_MOTIVAZIONE_A04 = 'A04'; //KO di interfaccia
	public static String CODICE_MOTIVAZIONE_A05 = 'A05'; //KO campo obbligatorio
	public static String CODICE_MOTIVAZIONE_A06 = 'A06'; //KO valore campo non ammesso
	public static String CODICE_MOTIVAZIONE_A07 = 'A07'; //KO stato ordine non compatibile con la richiesta
	public static String CODICE_MOTIVAZIONE_A08 = 'A08';

	public static String MOTIVAZIONE_A04 = 'Errore Tecnico di Interfaccia';
	public static String MOTIVAZIONE_A05 = 'Campo obbligatorio xxxx non valorizzato';
	public static String MOTIVAZIONE_A06 = 'Valore campo xxxx non ammesso';
	public static String MOTIVAZIONE_A07 = 'Messaggio non ammesso';
	public static String MOTIVAZIONE_A08 = 'I valori dei campi non sono coerenti';

	public static String EOF_FASE_RIMODULAZIONE_DAC = 'Rimodulazione DAC';
	public static String EOF_FASE_IN_LAVORAZIONE_SUPPORTO_VENDITE = 'In Lavorazione Supporto Vendite';
	public static String EOF_FASE_IN_LAVORAZIONE_NETWORK_CREATION = 'In Lavorazione Network Creation';

	public static String CASE_STATUS_IN_LAVORAZIONE = 'In Lavorazione';
	public static String CASE_STATUS_ACCETTATO = 'Accettato';
	public static String CASE_STATUS_CESSATO = 'Cessato';
	public static String CASE_STATUS_ESPLETATO = 'Espletato';
	public static String CASE_STATUS_ANNULLATO = 'Annullato';
	public static String ASSET_STATUS_ATTIVO='Attivo';
	public static String ASSET_STATUS_CESSATO='Cessato';
	public static String COM_ELEM_IST_STATUS_ATTIVO='Attivo';
	public static String COM_ELEM_IST_STATUS_CESSATO='Cessato';

	public static String VUOTA = '';
	public static DOUBLE VUOTAdb = null;
	public static integer VUOTAint = null;

	//EC - 2018 - 04 - 16
	public static String AZIONE_ATTIVAZIONE = 'Attivazione';
	public static String AZIONE_CESSAZIONE = 'Cessazione';
	public static String AZIONE_ANNULLAMENTO = 'Annullamento';

	public static String RT_PSM_NotificaAttivazione ='PSM_Notifica_di_Attivazione';
	public static String RT_PSM_NotificaCessazione ='PSM_Notifica_di_Cessazione';
	public static String RT_PSM_NotificaAnnullamento = 'PSM_Notifica_di_Annullamento';
	//end EC - 2018 - 04 - 16

	//18/04/2018 MM : aggiunte variabili statiche per metodo estrazione datetime dal casehistory

	public static string FaseB ='Bozza';
	public static string FaseL ='In Lavorazione Supporto Vendite';
	// 18/04/2018 MM : fine aggiunta

	public static boolean errorFile {get; set;}
	// da portare in sviluppo
	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse syncErrorDataPrevistaAttivazione(PO_FATT_WS_IN_PSM_Notify.PSM_Notify o) {

		PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
		tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		tmp.ESITO = ESITO_1;
		tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
		tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_PREVISTA_ATTIVAZIONE');

		if (DEBUG_MODE) {
			tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncErrorDataPrevistaAttivazione';
		}
		return tmp;
	}

	//METODI
	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse syncErrorCodiceOrdine(PO_FATT_WS_IN_PSM_Notify.PSM_Notify o) {

		PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
		tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		tmp.ESITO = ESITO_1;
		tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
		tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'CODICE_ORDINE');

		if (DEBUG_MODE) {
			tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncErrorCodiceOrdine';
		}
		return tmp;
	}

	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse responseACK(PO_FATT_WS_IN_PSM_Notify.PSM_Notify o) {

		PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
		tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		tmp.ESITO = ESITO_0;

		return tmp;
	}

	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse responseException(PO_FATT_WS_IN_PSM_Notify.PSM_Notify o,Exception e) {

		PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
		tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		tmp.ESITO = ESITO_1;
		tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
		tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

		if (DEBUG_MODE) {
			tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: responseException' + e.getMessage();
		}

		return tmp;
	}

	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse responseWrongStatus(PO_FATT_WS_IN_PSM_Notify.PSM_Notify o) {

		PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
		tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		tmp.ESITO = ESITO_1;
		tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A08;
		tmp.MOTIVAZIONE = MOTIVAZIONE_A08;

		if (DEBUG_MODE) {
			tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: responseWrongStatus';
		}

		return tmp;
	}

	public static PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse syncError(PO_FATT_WS_IN_PSM_Notify.PSM_Notify o) {
		PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse tmp = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();

		//Controllo i campi required.
		if (String.isBlank(o.DATA_NOTIFICA)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'DATA_NOTIFICA');
			return tmp;
		}
		if (String.isblank(o.ID_NOTIFICA)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'ID_NOTIFICA');
			return tmp;
		}
		if (String.isblank(o.CODICE_ORDINE)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'CODICE_ORDINE');
			return tmp;
		}
		if (string.isblank(o.CODICE_NOTIFICA)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'CODICE_NOTIFICA');
			return tmp;
		}


		//Controllo la Lunghezza Massima
		if (o.DATA_NOTIFICA.length() != 25) { //lunghezza deve essere 25
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_NOTIFICA');

			return tmp;
		}
		if (o.ID_NOTIFICA.length() > 15) { //lunghezza max 15
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'ID_NOTIFICA');
			return tmp;
		}
		if (o.CODICE_ORDINE.length() > 18) {//lunghezza max 18
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'CODICE_ORDINE');
			return tmp;
		}
		if (!String.isblank(o.CODICE_NOTIFICA) && ( o.CODICE_NOTIFICA.length() != 1) ) {//lunghezza deve essere 1
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'CODICE_NOTIFICA');
			return tmp;
		}
		if (!String.isblank(o.DATA_PREVISTA_ATTIVAZIONE) && ( o.DATA_PREVISTA_ATTIVAZIONE.length() != 10) ) { //lunghezza deve essere 10
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_PREVISTA_ATTIVAZIONE');
			return tmp;
		}
		if (!String.isblank(o.MOTIVAZIONE_RIMODULAZIONE_DAC) && ( o.MOTIVAZIONE_RIMODULAZIONE_DAC.length() > 255) ) { //lunghezza max 255
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'MOTIVAZIONE_RIMODULAZIONE_DAC');
			return tmp;
		}
		if (!String.isBlank(o.STATO_ORDINE) && ( o.STATO_ORDINE.length() > 1) ) {//lunghezza max 1
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'STATO_ORDINE');
			return tmp;
		}
		if (!String.isBlank(o.ID_RISORSA) && ( o.ID_RISORSA.length() > 50) ) { //lunghezza max 50
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'ID_RISORSA');
			return tmp;
		}
		if (!String.isBlank(o.DATA_ESPLETAMENTO_ORDINE) && ( o.DATA_ESPLETAMENTO_ORDINE.length() != 10) ) { //lunghezza deve essere 10
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_ESPLETAMENTO_ORDINE');
			return tmp;
		}
		if (!String.isBlank(o.NOTE) && ( o.NOTE.length() > 255) ) {//lunghezza max 255
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = 'CODICE_MOTIVAZIONE_A06';
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'NOTE');
			return tmp;
		}


		//Controlli di dominio e di formato
		if (!test.isrunningtest()) {
			if (!String.isblank(o.DATA_NOTIFICA) && !verificaDateTime(o.DATA_NOTIFICA)) {//formato atteso: YYYY-MM-DDThh:mm:ssTZD)
				tmp.ID_NOTIFICA = o.ID_NOTIFICA;
				tmp.ESITO = ESITO_1;
				tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
				tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_NOTIFICA');
				return tmp;
			}
		}

		if (!String.isblank(o.CODICE_NOTIFICA) && !CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && !CODICE_NOTIFICA_1.equals(o.CODICE_NOTIFICA) && !CODICE_NOTIFICA_2.equals(o.CODICE_NOTIFICA) && !CODICE_NOTIFICA_3.equals(o.CODICE_NOTIFICA)) {//Valori ammissibili 0,1,2,3
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'CODICE_NOTIFICA');
			return tmp;
		}

		if (!String.isblank(o.DATA_PREVISTA_ATTIVAZIONE) && !verificaData(o.DATA_PREVISTA_ATTIVAZIONE) ) { //formato atteso: YYYY-MM-DD
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_PREVISTA_ATTIVAZIONE');
			return tmp;
		}
		if (!String.isblank(o.STATO_ORDINE) && !STATO_ORDINE_0.equals(o.STATO_ORDINE) && !STATO_ORDINE_1.equals(o.STATO_ORDINE) && !STATO_ORDINE_2.equals(o.STATO_ORDINE) && !STATO_ORDINE_3.equals(o.STATO_ORDINE)) {//Valori ammissibili 0,1,2,3
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'CODICE_NOTIFICA');
			return tmp;
		}
		if (!String.isblank(o.DATA_ESPLETAMENTO_ORDINE) && !(verificaData(o.DATA_ESPLETAMENTO_ORDINE)) ) { //formato atteso: YYYY-MM-DD
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A06;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A06.replace('xxxx', 'DATA_ESPLETAMENTO_ORDINE');
			return tmp;
		}


		//Controlli logici
		if (CODICE_NOTIFICA_1.equals(o.CODICE_NOTIFICA) && String.isBlank(o.DATA_PREVISTA_ATTIVAZIONE)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'DATA_PREVISTA_ATTIVAZIONE');
			return tmp;
		}

		// FIX GB 21.05.2018  CODICE_NOTIFICA=0 E DATA_PREVISTA_ATTIVAZIONE=2018-05-21
		//if(!CODICE_NOTIFICA_1.equals(o.CODICE_NOTIFICA) && !String.isBlank(o.DATA_PREVISTA_ATTIVAZIONE)){
		/*if(!CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && !String.isBlank(o.DATA_PREVISTA_ATTIVAZIONE)){
		        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		        tmp.ESITO = ESITO_1;
		        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
		        tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

		        if(DEBUG_MODE){
		         tmp.MOTIVAZIONE=tmp.MOTIVAZIONE+' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.DATA_PREVISTA_ATTIVAZIONE='+o.DATA_PREVISTA_ATTIVAZIONE;
		        }

		        return tmp;
		   }*/
		if (CODICE_NOTIFICA_1.equals(o.CODICE_NOTIFICA) && String.isBlank(o.MOTIVAZIONE_RIMODULAZIONE_DAC)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'MOTIVAZIONE_RIMODULAZIONE_DAC');
			return tmp;
		}
		if (!CODICE_NOTIFICA_1.equals(o.CODICE_NOTIFICA) && !String.isBlank(o.MOTIVAZIONE_RIMODULAZIONE_DAC)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.MOTIVAZIONE_RIMODULAZIONE_DAC=' + o.MOTIVAZIONE_RIMODULAZIONE_DAC;
			}

			return tmp;
		}
		if ((CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) || CODICE_NOTIFICA_3.equals(o.CODICE_NOTIFICA)) && String.isBlank(o.STATO_ORDINE)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'STATO_ORDINE');
			return tmp;
		}
		if (!(CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) || CODICE_NOTIFICA_3.equals(o.CODICE_NOTIFICA)) && !String.isBlank(o.STATO_ORDINE)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.STATO_ORDINE=' + o.STATO_ORDINE;
			}

			return tmp;
		}
		if (((CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && STATO_ORDINE_0.equals(o.STATO_ORDINE)) || CODICE_NOTIFICA_2.equals(o.CODICE_NOTIFICA)) && String.isBlank(o.ID_RISORSA)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'ID_RISORSA');
			return tmp;
		}
		if (!((CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && STATO_ORDINE_0.equals(o.STATO_ORDINE)) || CODICE_NOTIFICA_2.equals(o.CODICE_NOTIFICA)) && !String.isBlank(o.ID_RISORSA)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.ID_RISORSA=' + o.ID_RISORSA;
			}

			return tmp;
		}
		if (CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && String.isBlank(o.ID_CIRCUITO_1)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'ID_CIRCUITO_1');
			return tmp;
		}
		if (!CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && !String.isBlank(o.ID_CIRCUITO_1)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.ID_CIRCUITO_1=' + o.ID_CIRCUITO_1;
			}

			return tmp;
		}
		//FIX GB 21.05.2018 ID_CIRCUITO_2 start
		/*
		   Dalla call del 21.05.2018 è emersa una modifiche delle specifiche,
		   in breve bisogna rilassere questo controllo e quindi tale ID_CIRCUITO_2 è required solo se TIPO_PERCORSO è Doppia via.
		   if(CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && String.isBlank(o.ID_CIRCUITO_2) && ){
		        tmp.ID_NOTIFICA = o.ID_NOTIFICA;
		        tmp.ESITO = ESITO_1;
		        tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
		        tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'ID_CIRCUITO_2');
		        return tmp;
		   }*/
		//FIX GB end
		if (!CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && !String.isBlank(o.ID_CIRCUITO_2)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.ID_CIRCUITO_2=' + o.ID_CIRCUITO_2;
			}

			return tmp;
		}
		if ((((CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && STATO_ORDINE_0.equals(o.STATO_ORDINE))) || CODICE_NOTIFICA_2.equals(o.CODICE_NOTIFICA)) && String.isBlank(o.DATA_ESPLETAMENTO_ORDINE)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'DATA_ESPLETAMENTO_ORDINE');
			return tmp;
		}
		if (!((CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && STATO_ORDINE_0.equals(o.STATO_ORDINE)) || CODICE_NOTIFICA_2.equals(o.CODICE_NOTIFICA)) && !String.isBlank(o.DATA_ESPLETAMENTO_ORDINE)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.DATA_ESPLETAMENTO_ORDINE=' + o.DATA_ESPLETAMENTO_ORDINE;
			}

			return tmp;
		}

		if (CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && STATO_ORDINE_0.equals(o.STATO_ORDINE) && (o.ATTACHMENT != null) && (o.ATTACHMENT.size() == 0)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'ATTACHMENT');
			return tmp;
		}
		if ((!CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) || !STATO_ORDINE_0.equals(o.STATO_ORDINE)) && (o.ATTACHMENT != null) && (o.ATTACHMENT.size() != 0)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.ATTACHMENT=' + o.ATTACHMENT;
			}

			return tmp;
		}
		// 25/05/2018 MM : aggiunto controllo su obbligatorietà campo ATTACHMENT_NAME
		if (CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) && STATO_ORDINE_0.equals(o.STATO_ORDINE) && (o.ATTACHMENT_NAME == null)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A05;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A05.replace('xxxx', 'ATTACHMENT_NAME');
			return tmp;
		}
		if ((!CODICE_NOTIFICA_0.equals(o.CODICE_NOTIFICA) || !STATO_ORDINE_0.equals(o.STATO_ORDINE)) && (o.ATTACHMENT_NAME != null) && (o.ATTACHMENT_NAME.length() != 0)) {
			tmp.ID_NOTIFICA = o.ID_NOTIFICA;
			tmp.ESITO = ESITO_1;
			tmp.CODICE_MOTIVAZIONE = CODICE_MOTIVAZIONE_A04;
			tmp.MOTIVAZIONE = MOTIVAZIONE_A04;

			if (DEBUG_MODE) {
				tmp.MOTIVAZIONE=tmp.MOTIVAZIONE + ' Class::PO_FATT_WS_PSM_Notify_Utils Method:: syncError  Error:o.ATTACHMENT_NAME=' + o.ATTACHMENT_NAME;
			}

			return tmp;
		}
		// 25/05/2018 MM : fine aggiunta


		return null;
	}

	public static List<Attachment> attachingFile(list<Blob> blob_list,Id ParentId,String est) {

		list<Attachment> lista_allegati = new list<Attachment>();

		for (Integer i=0; i < blob_list.size(); i++) {

			Attachment allegato = new Attachment();
			allegato.ParentId = ParentId;
			allegato.Name = 'Attach' + i + '.' + est;
			allegato.Body = blob_list.get(i);
			if ((est == 'docx') || (est == 'doc')) {
				allegato.ContentType ='application/vnd.openxmlformats-officedocument.wordprocessingml.document';
			}
			if (est == 'pdf') {
				allegato.ContentType ='application/pdf';
			}
			lista_allegati.add(allegato);
		}
		system.debug('lista_allegati' + lista_allegati);
		return lista_allegati;
	}

//fix 23.05.2018
	public static List<Attachment> attachingFile(list<Blob> blob_list,Id ParentId,list<String> name) {

		list<Attachment> lista_allegati = new list<Attachment>();

		for (Integer i=0; i < blob_list.size(); i++) {

			Attachment allegato = new Attachment();
			allegato.ParentId = ParentId;
			allegato.Name = name.get(i);
			allegato.Body = blob_list.get(i);
			if (name.get(i).contains('docx') || name.get(i).contains('doc') ) {
				allegato.ContentType ='application/vnd.openxmlformats-officedocument.wordprocessingml.document';
			}
			if (name.get(i).contains('pdf')) {
				allegato.ContentType ='application/pdf';
			}
			lista_allegati.add(allegato);
		}
		system.debug('lista_allegati' + lista_allegati);
		return lista_allegati;
	}
// fine

    public static List<Attachment> attachingFileOutbound(List<Attachment> listAttach,Id ParentId) {
        list<Attachment> lista_allegati = new list<Attachment>();
        Double d=0;
        String attName ='';
        if(!Test.isRunningTest()){
            if(listAttach.size() > 0){
                for (Integer i = 0 ; i < listAttach.size();i++){
                    d=d + listAttach[i].BodyLength;
                    attName = listAttach[i].Name.substring(listAttach[i].Name.lastIndexOf('.'));
                    System.debug('@@@here extension'+attName);
                    if(attName != KMZ && attName != ZIP && attName != JPG && attName != PNG && attName != DWG && attName != SHP){
                        listAttach.remove(i);
                        Attachment allegato = new Attachment();
                        allegato.ParentId = ParentId;
                        allegato.Name ='fileNotAllowed.txt';
                        allegato.Body = Blob.valueof('I file allegati non sono stati inviati.L\'estensione dei file non e\' consentita.');
                        allegato.ContentType ='text/plain';
                        lista_allegati.add(allegato);
                    }
                
                }
            }
        }

		if (d > 6280000) { //controllo se i file da allegare sono più di 6MB
			Attachment allegato = new Attachment();
			allegato.ParentId = ParentId;
			allegato.Name ='missingFile.txt';
			allegato.Body = Blob.valueof('I file allegati non sono stati inviati. La dimensione dei file supera i limiti consentiti (6MB).');
			allegato.ContentType ='text/plain';
			lista_allegati.add(allegato);

		}
		else{
			for (Attachment att:listAttach) {
				Attachment allegato = new Attachment();
				allegato.ParentId = ParentId;
				allegato.Name = att.Name;
				allegato.Body = att.Body;
				allegato.ContentType =att.ContentType;
				lista_allegati.add(allegato);
			}
		}
		system.debug('lista_allegati' + lista_allegati);
		return lista_allegati;
	}

	public static boolean verificaData(String data) {
		String dateRegex = '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$';
		Pattern p = Pattern.compile(dateRegex);
		Matcher m = p.matcher(data);
		Boolean result = m.matches();
		if (result) {
			return true;
		}
		else{
			return false;
		}
	}
	public static boolean verificaDateTime(String dataTime) {
		String dateTimeRegex = '(^\\d{4}(-\\d{2}){0,2})?((^|T)\\d{2}(:\\d{2}(:\\d{2}(\\.\\d+)?)?)?(Z|[\\+|-]\\d{2}:\\d{2})?)?$';
		Pattern p = Pattern.compile(dateTimeRegex);
		Matcher m = p.matcher(dataTime);
		Boolean result = m.matches();
		if (result) {
			return true;
		}
		else{
			return false;
		}
	}
	public static void writeLog(PO_FATT_WS_IN_PSM_Notify.PSM_Notify request,String statoRichiesta,String CodiceErrore,String CausaleErrore) {
		EOF_EAI_Service_Log__c sol= new EOF_EAI_Service_Log__c();
		sol.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_FATT_WS_ACK_NACK').getRecordTypeId();
		sol.EOF_TIpo_comunicazione_String__c='???';
		sol.EOF_Stato_Richiesta__c = statoRichiesta;
		sol.EOF_ID_Notifica__c = request.ID_NOTIFICA;
		sol.EOF_Codice_Ordine_OLO__c = request.CODICE_ORDINE;
		sol.EOF_Richiesta_Notifica__c = String.valueOf(request);
		sol.EOF_Codice_Errore__c=CodiceErrore;
		sol.EOF_Causale_Errore__c=CausaleErrore;


		List<Case> listCase = new List<Case>();
		listCase = [SELECT Id,Status,OwnerId,EOF_Fase__c,CaseNumber,DAC_Prevista_OF__c,EOF_Note_Appuntamento__c,PO_FATT_History_Owner__c FROM Case WHERE CaseNumber =:request.CODICE_ORDINE];
		if (!listCase.isEmpty()) {
			sol.Caso__c=listCase.get(0).Id;
		}

		if (String.isBlank(CausaleErrore)) {
			sol.EOF_Data_Notifica__c = stringToDate(request.DATA_NOTIFICA);
		}else{
			if (!CausaleErrore.contains('DATA_NOTIFICA')) {
				sol.EOF_Data_Notifica__c = stringToDate(request.DATA_NOTIFICA);
			}
		}

		insert sol;

		//Allego il file al Log
		if ((request.Attachment != null) && (request.Attachment.size() > 0)) {
			//GB 30.05.2018 insert PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob>{request.Attachment},sol.id, 'pdf');
			insert PO_FATT_WS_PSM_Notify_Utils.attachingFile(new list<Blob> {request.Attachment},sol.id,new list<String> {request.ATTACHMENT_NAME});
		}
	}

	public static Datetime stringToDate(String s) {
		if (String.isBlank(s)) {
			return null;
		}
		Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
		return dt;
	}

	public static String dateToString(datetime dt) {
		if (String.isBlank(String.valueOf(dt))) {
			return null;
		}
		Integer offset = UserInfo.getTimeZone().getOffset(System.now()) / 3600000;
		String prefix = (offset >= 0) ? '+'  : '-';
		String a = prefix + ((Math.abs(offset) < 10) ? ('0' + Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
		String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\'' + a + '\'');
		return s;
	}

	/*
	 *  Autore: Eleonora Caravello
	 *   Descrizione: Metodo per ottenere un formato  YYYYMM a partire da un datetime
	 *
	 *   Parametri: dateTime
	 *
	 */
	public static String dateYMToString(datetime dt) {
		if (String.isBlank(String.valueOf(dt))) {
			return null;
		}
		Integer offset = UserInfo.getTimeZone().getOffset(System.now()) / 3600000;
		String prefix = (offset >= 0) ? '+'  : '-';
		String a = prefix + ((Math.abs(offset) < 10) ? ('0' + Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
		String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\'' + a + '\'');
		String yM = s.left(7).remove('-');
		return yM;
	}

	public static Date stringToDateNoTime(String s) {
		if (String.isBlank(s)) {
			return null;
		}
		/* date dt;

		   if(s.left(3) == '/' || s.left(3) =='-'){
		     // 2018-09-18 MM : in caso passino un formato tipo 18/09/2018 o 18-09-2018 o 02-01-2018
		      dt = Date.newInstance(integer.valueof(s.left(10).right(4)),integer.valueof(s.left(5).right(2)),integer.valueof(s.left(2)));
		      system.debug('entrato nell\' if:'+dt);
		   }
		   else{
		       dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
		   }
		   return dt;*/

		date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));

		return dt;
	}
	// 17/04/2018 MM : aggiunta metodo che calcoli e quindi restituisca la datetime letta dall’history di un qualsiasi case, quando la fase varia da “Bozza” a “In Lavorazione Supporto Vendite”
	// 17/04/2018 MM : inizio aggiunta metodo
	public static Datetime CaseHistoryTime(String caseid, String Vecchio, String Nuovo) {
		datetime dt;
		List<CaseHistory> ch = [select Oldvalue,Newvalue,createddate from CaseHistory where CaseId=:caseid and Field='EOF_Fase__c'];
		for (casehistory ch2 : ch) {
			if (Vecchio.equals(String.valueof(ch2.oldValue)) && Nuovo.equals(String.valueof(ch2.NewValue))) {
				dt = ch2.createddate;
				system.debug('DENTRO GB');
			}
		}
		return dt;
	}
	// 17/04/2018 MM : fine aggiunta metodo

	//GB 12.05 Start
	public static String getDataOrdineCompletato(String caseId) {
		String DATA_ORDINE_COMPLETATO= PO_FATT_WS_PSM_Notify_Utils.dateToString(PO_FATT_WS_PSM_Notify_Utils.CaseHistoryTime(caseId,FaseB,FaseL));
		if (DATA_ORDINE_COMPLETATO == null) {
			DATA_ORDINE_COMPLETATO= PO_FATT_WS_PSM_Notify_Utils.dateToString(datetime.now());
		}
		return DATA_ORDINE_COMPLETATO;
	}

	//01.06
	public static String getAccount(EOF_Notify__c notifyPSM) {
		String ACCOUNT=notifyPSM.Caso__r.EOF_Account_OLO__r.Name;
		if (ACCOUNT == null) {
			ACCOUNT=notifyPSM.Caso__r.Account.Name;
		}
		return ACCOUNT;
	}

	public static String getTipoDiContratto(EOF_Notify__c notifyPSM) {
		String TIPO_DI_CONTRATTO= 'Fiber Link';
		if (('IRU'.equals(notifyPSM.Caso__r.PO_Tipologia_Offerta_ordine__c) || 'IRU'.equals(notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c)) ||
			('BTS'.equals(notifyPSM.Caso__r.PO_Tipologia_Offerta_ordine__c) || 'BTS'.equals(notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c)) ||        //FD 30-11-2018 - CR BTS
			('Backhauling'.equals(notifyPSM.Caso__r.PO_Tipologia_Offerta_ordine__c) || 'Backhauling'.equals(notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c))) {       //FD 30-11-2018 - CR Backhauling
			TIPO_DI_CONTRATTO= 'IRU';
		}
		if ('Fiber Lease'.equals(notifyPSM.Caso__r.PO_Tipologia_Offerta_ordine__c) || 'Fiber Lease'.equals(notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c)) {
			TIPO_DI_CONTRATTO= 'Fiber Lease';
		}
		if ('Dismissione'.equals(notifyPSM.Caso__r.PO_Tipologia_Offerta_ordine__c) || 'Dismissione'.equals(notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c)) {
			TIPO_DI_CONTRATTO= 'Dismissione';
		}
		return TIPO_DI_CONTRATTO;
	}
	//GB 12.05 Start

	//EC - 2018 - 05 - 14 start - review GB
	public static String getTipoCollegamento(EOF_Notify__c notifyPSM) {

		String TipoCollegamento=notifyPSM.Caso__r.PO_Tipo_di_collegamento__c;
		if ('BACKBONE'.equals(TipoCollegamento)) {
			TipoCollegamento='BACKBONE IP';
		}
		if ('Point-to-Point'.equals(TipoCollegamento)) {
			TipoCollegamento='p2p';
		}
		if ('P2P - Cliente'.equals(TipoCollegamento)) {        //fix 04.06.2018
			TipoCollegamento='p2p';
		}
		return TipoCollegamento;
	}

	// 30/05/2018 MM : aggiunta metodo mapping per TIPO_DI_Percorso
	public static String getTipoDiPercorso(EOF_Notify__c notifyPSM) {

		//String TipoDiPercorso= notifyPSM.Caso__r.PO_Tipo_percorso__c;
		String TipoDiPercorso=null;
		if (notifyPSM.Caso__r.PO_Tipo_percorso__c != null) {

			if ('Singola Via'.equals(notifyPSM.Caso__r.PO_Tipo_percorso__c)) {
				TipoDiPercorso='Singola Via';
			}else{
				TipoDiPercorso='Diversificato';
			}
		}
		return TipoDiPercorso;
	}
	// 30/05/2018 MM : fine aggiunta

	public static Double getLungDropFlLease(EOF_Notify__c notifyPSM) {

		Double LungDropFlLease = null;
		if ('Fiber Lease'.equals(getTipoDiContratto(notifyPSM))) {
			LungDropFlLease= (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_1_nuovo_Drop__c;
			if (LungDropFlLease == null) {
				LungDropFlLease=0;
			}
		}
		return LungDropFlLease;
	}

	public static Double getLungDropFlLease2(EOF_Notify__c notifyPSM) {
		Double LungDropFlLease2 = null;
		if ('Fiber Lease'.equals(getTipoDiContratto(notifyPSM))) {
			LungDropFlLease2= (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c;
			if (LungDropFlLease2 == null) {
				LungDropFlLease2=0;
			}
		}
		return LungDropFlLease2;
	}

	public static String getEsitoFattibilita(EOF_Notify__c notifyPSM) {  //da portare in sviluppo
		String EsitoFattibilita=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Esito_collegamento__c;
		if ('SI Inf. Esistente'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - Inf. Esist.';
		}
		if ('SI Inf. + Scavo'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - Inf. + Scavo';
		}
		if ('SI Inf. OP'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - TIM';
		}
		if ('SI TIM'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - TIM';
		}
		if ('SI in FTTH'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - in FTTH';
		}
		if ('SI On Net'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - ON Net';
		}
		if ('SI Scavo'.equals(EsitoFattibilita)) {
			EsitoFattibilita='SI - Scavo';
		}
		return EsitoFattibilita;
	}

	public static String getIdCircuitoTratta1(ID caseID) {
		List<OF_CommercialElementIstanziato__c> ceiList = [select id, OF_Case__c, OF_CaseTratta__c, OF_IDRisorsa__c from OF_CommercialElementIstanziato__c where OF_CaseTratta__c=:caseID];
		String idCircuitoTratta1 =null;
		if (( ceiList != null) && ( ceiList.size() > 0) ) {
			idCircuitoTratta1=ceiList[0].OF_IDRisorsa__c;
		}
		system.debug('L\'id circuito tratta 1 è :' + idCircuitoTratta1);
		system.debug('la lista CEI è :' + ceiList);
		return idCircuitoTratta1;
	}

	public static String getIdCircuitoTratta2(ID caseID) {
		List<OF_CommercialElementIstanziato__c> ceiList = [select id, OF_Case__c, OF_CaseTratta__c, OF_IDRisorsa__c from OF_CommercialElementIstanziato__c where OF_CaseTratta__c=:caseID];
		String idCircuitoTratta2 =null;

		if (( ceiList != null) && ( ceiList.size() > 1) ) {
			idCircuitoTratta2 =ceiList[1].OF_IDRisorsa__c;
		}
		system.debug('L\'id circuito tratta 2 è :' + idCircuitoTratta2);
		system.debug('la lista CEI è :' + ceiList);
		return idCircuitoTratta2;
	}
	//EC - 2018 - 05 - 14 end

	public static List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element> getListAttachment(ID caseID) {
		system.debug('caseID ' + caseID);
		List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element> listaAtt= new  List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element>();

		List<Attachment> attachList = [Select id, ParentId, Name, ContentType, BodyLength, Body, OwnerId, CreatedDate, CreatedById,
									   CreatedBy.Name, LastModifiedDate,LastModifiedById,LastModifiedBy.Name, Description
									   from Attachment where ParentId=:caseID];
		system.debug('La lista di Attachment è ' + attachList.size());

		Double d=0;
        String attName ='';
		/*for (Attachment atta:attachList) {
            d=d + atta.BodyLength;
            /*tName = atta.Name.substring(atta.Name.lastIndexOf('.'));
            System.debug('@@@here extension'+attName);
            if(attName != KMZ && attName != ZIP && attName != JPG && attName != PNG && attName != DWG && attName != SHP){
                PO_FATT_WS_PSM_OUT_Notify.Attachment_element att = new PO_FATT_WS_PSM_OUT_Notify.Attachment_element();
                Blob bx = blob.valueof('I file allegati non sono stati inviati.L\'estensione dei file non è consentita.');
                att.File_Attachment=EncodingUtil.base64Encode(bx);
                att.Attachment_Name = 'fileNotAllowed.txt';
                listaAtt.add(att);
                errorFile=true;
                System.debug('@@@here extension'+att.Attachment_Name);
}*/
        //}
        if(!Test.isRunningTest()){
            if(attachList.size() > 0 ){
                for (Integer i = 0 ; i < attachList.size();i++){
                    d=d + attachList[i].BodyLength;
                    attName = attachList[i].Name.substring(attachList[i].Name.lastIndexOf('.'));
                    System.debug('@@@here extension'+attName);
                    if(attName != KMZ && attName != ZIP && attName != JPG && attName != PNG && attName != DWG && attName != SHP){
                        attachList.remove(i);
                        PO_FATT_WS_PSM_OUT_Notify.Attachment_element att = new PO_FATT_WS_PSM_OUT_Notify.Attachment_element();
                        Blob bx = blob.valueof('I file allegati non sono stati inviati.L\'estensione dei file non è consentita.');
                        att.File_Attachment=EncodingUtil.base64Encode(bx);
                        att.Attachment_Name = 'fileNotAllowed.txt';
                        listaAtt.add(att);
                        errorFile=true;
                        System.debug('@@@here extension'+att.Attachment_Name);
                    }
                
                }
            }
        }
        if (d > 6280000) { //controllo se i file da allegare sono più di 6MB
			PO_FATT_WS_PSM_OUT_Notify.Attachment_element att = new PO_FATT_WS_PSM_OUT_Notify.Attachment_element();
			Blob bx = blob.valueof('I file allegati non sono stati inviati. La dimensione dei file supera i limiti consentiti (6MB).');
			att.File_Attachment=EncodingUtil.base64Encode(bx);
			att.Attachment_Name ='missingFile.txt';
			listaAtt.add(att);
			errorFile=true;
		}
        
       
		else{
			for (Attachment atta:attachList) {
				PO_FATT_WS_PSM_OUT_Notify.Attachment_element att = new PO_FATT_WS_PSM_OUT_Notify.Attachment_element();
				/*if (atta.ContentType == 'text/plain') {
					att.File_Attachment=(atta.Body).toString();
				}else{
					att.File_Attachment=EncodingUtil.base64Encode(atta.Body);
				}*/
                att.File_Attachment=EncodingUtil.base64Encode(atta.Body);
				//att.File_Attachment=atta.Body;
				att.Attachment_Name =atta.Name;
				listaAtt.add(att);
				System.debug('##### attachment:' + att);
			}
			errorFile=false;
		}
		return listaAtt;
	}

	/*  Autore: Eleonora Caravello
	 *   Descrizione: Metodo per Integrazione Outbound PSM -   todo
	 *
	 *   Parametri: idnotifyPSM - Indica l'id della notifica per la quale avviene l'integrazione.
	 *    verificare mapping anche delle righe 707 e 708 - Ripetizione della stessa riga: dateToString(notifyPSM.Caso__r.PO_Data_Attivazione_Richiesta__c)
	 */
	@Future(callout=true)
	public static void createAckNackNotify_Attivazione(String idnotifyPSM) {

		system.debug('PO_FATT_WS_PSM_Notify_Utils: inizio metodo inoltro Attivazione');
		RecordType rt_Ack_Nack = [SELECT Id FROM RecordType WHERE Name = 'PSM_WS_OUT_ACK_NACK' LIMIT 1];  //to creare recordtype su Notify per ack/nack psm outbound

		EOF_Notify__c notifyPSM = [select Id,Name,Caso__r.EOF_Note_Interne__c, Caso__r.PO_Nome_E_Cognome_PM__c,
								   Caso__r.PO_Case_Collegamento__c, Caso__r.PO_Case_Collegamento__r.PO_Esito_collegamento__c, Caso__r.EOF_Account_OLO__r.Name,
								   Caso__r.PO_Tipologia_Offerta_ordine__c, Caso__r.PO_Tipo_percorso__c,  Caso__r.PO_Tipo_di_collegamento__c,
								   Caso__r.PO_Prime_Contractor__c, Caso__r.PO_Numero_fibre_richieste__c, Caso__r.Contact.Name,
								   Caso__r.PO_Case_Collegamento__r.EOF_ID_Risorsa__c,  Caso__r.PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c,
								   Caso__r.PO_Case_Collegamento__r.PO_BB_2_via_interessato__c, EOF_Codice_Ordine_OLO__c, EOF_ID_Notifica__c,
								   EOF_Data_Notifica__c,  Caso__r.PO_Case_Collegamento__r.LastModifiedBy.Name,
								   Caso__r.PO_Data_Attivazione_Richiesta__c, Caso__r.PO_Case_Collegamento__r.OF_Order__r.CreatedDate,
								   Caso__r.PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c, Caso__r.PO_Case_Collegamento__r.PO_BB_1_interessato__c,
								   Caso__r.PO_Case_Collegamento__r.PO_BB_2_interessato__c, Caso__r.PO_Pop_1_di_riferimento2__c,Caso__r.PO_Case_Collegamento__r.PO_Pop_1_di_riferimento2__r.Name, Caso__r.PO_Pop_2_di_riferimento2__c,Caso__r.PO_Case_Collegamento__r.PO_Pop_2_di_riferimento2__r.Name,
								   Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_1__c, Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_2__c, Caso__r.PO_Case_Collegamento__r.PO_Posa_1_nuovo_Drop__c,
								   Caso__r.PO_Case_Collegamento__r.PO_Posa_1_via_nuovo_Drop__c, Caso__r.PO_Case_Collegamento__r.PO_Posa_2_via_nuovo_Drop__c,
								   Caso__r.PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c, Caso__r.PO_Case_Collegamento__r.PO_BB_1_via_interessato__c,
								   Caso__r.PO_Lunghezza_m__c, Caso__r.PO_Lunghezza_m2__c, Caso__r.PO_Case_Collegamento__r.PO_Note_fattibilit__c,
								   Caso__r.PO_Case_Collegamento__r.PO_Note_Network_Creation__c, Caso__r.PO_Case_Collegamento__r.CaseNumber,Caso__r.PO_Sito__c, Caso__r.PO_Indirizzo_collegamento__c,
								   Caso__r.PO_Nome_Comune__c, Caso__r.PO_Case_Collegamento__r.PO_Comune2__c,Caso__r.PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c,
								   Caso__r.PO_Civico__c, Caso__r.PO_Nome_Comune3__c, Caso__r.PO_Indirizzo_collegamento_partenza__c,
								   Caso__r.PO_Sito_partenza__c, Caso__r.PO_Civico_partenza__c, Caso__r.PO_Nome_Comune4__c,
								   Caso__r.PO_indirizzo_collegamento_3__c, Caso__r.PO_Sito_3__c, Caso__r.PO_Civico_3__c, Caso__r.Casenumber, Caso__c,
								   Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c,Caso__r.EOF_Note_Operatore__c,
								   Caso__r.Account.Name,Caso__r.CreatedDate,Caso__r.RecordType.DeveloperName
								   from EOF_Notify__c where RecordType.DeveloperName=:RT_PSM_NotificaAttivazione and id=: idnotifyPSM];

		system.debug('la notifica è:' + notifyPSM);
		String dropFL1=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_1__c ? 'Y' : 'N';
		String dropFL2=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_2__c ? 'Y' : 'N';


		List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element> listaAtt= new  List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element>();
		listaAtt=getListAttachment(notifyPSM.Caso__r.PO_Case_Collegamento__c);

		//INVOCAZIONE DEL SERVIZIO
		PO_FATT_WS_PSM_OUT_Sincronizzazione.PortTypeEndpoint1 stub = new PO_FATT_WS_PSM_OUT_Sincronizzazione.PortTypeEndpoint1();
		stub.timeout_x=30000;
		PO_FATT_WS_PSM_OUT_Notify.OutputMapping1 response = new PO_FATT_WS_PSM_OUT_Notify.OutputMapping1();

		PO_FATT_WS_PSM_OUT_Notify.SubInput subInput=new PO_FATT_WS_PSM_OUT_Notify.SubInput();
		subInput.NOTE_ORDINE=notifyPSM.Caso__r.EOF_Note_Operatore__c ;//LM 27/08/19 come da HLD
		subInput.PM_DI_RIFERIMENTO= notifyPSM.Caso__r.PO_Nome_E_Cognome_PM__c;
		subInput.ESITO_FATTIBILITA= getEsitoFattibilita(notifyPSM);
		subInput.ACCOUNT = getAccount(notifyPSM);     //notifyPSM.Caso__r.EOF_Account_OLO__r.Name==null?notifyPSM.Caso__r.Account.Name:notifyPSM.Caso__r.EOF_Account_OLO__r.Name;
		subInput.TIPO_DI_CONTRATTO= getTipoDiContratto(notifyPSM);
		subInput.TIPO_DI_PERCORSO = getTipoDiPercorso(notifyPSM);     // 30/05/2018 MM : remapping valori
		subInput.TIPO_DI_COLLEGAMENTO = getTipoCollegamento(notifyPSM);
		subInput.PRIME_CONTRACTOR = notifyPSM.Caso__r.PO_Prime_Contractor__c;
		subInput.FIBRE_RICHIESTE= notifyPSM.Caso__r.PO_Numero_fibre_richieste__c;
		subInput.RICHIEDENTE=  notifyPSM.Caso__r.Contact.Name;
		subInput.ID_RISORSA=null;
		subInput.Attachment= listaAtt;
		system.debug('il subinput è:' + subInput);

		List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element> listaSedi= new  List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element>();
		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede.NUMERO_SEDE= '1';
		sede.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito__c;
		sede.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_Indirizzo_collegamento__c;
		sede.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune__c;
		sede.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico__c;

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede2=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede2.NUMERO_SEDE= '2';
		//sede2.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede2.CODICE_ISTAT='N.A.';
		sede2.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito_partenza__c;
		sede2.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_Indirizzo_collegamento_partenza__c;
		sede2.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune3__c;
		sede2.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico_partenza__c;

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede3=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede3.NUMERO_SEDE= '3';
		//sede3.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede3.CODICE_ISTAT='N.A.';
		sede3.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito_3__c;
		sede3.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_indirizzo_collegamento_3__c;
		sede3.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune4__c;
		sede3.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico_3__c;

		listaSedi.add(sede);
		listaSedi.add(sede2);
		listaSedi.add(sede3);

		//Invoking the callout with corresponding parameters
		response = stub.SF_PSMOperation( getLungDropFlLease2(notifyPSM),    //(Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c,
										 (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_BB_2_via_interessato__c,
										 getIdCircuitoTratta1(notifyPSM.Caso__c),// = notifyPSM.ID_CIRCUITO_PRIMA_TRATTA,
										 notifyPSM.Caso__r.Casenumber,
										 notifyPSM.id,
										 getDataOrdineCompletato(notifyPSM.Caso__c),
										 dateToString(notifyPSM.EOF_Data_Notifica__c),
										 AZIONE_ATTIVAZIONE,
										 notifyPSM.Caso__r.PO_Case_Collegamento__r.LastModifiedBy.Name,
										 string.valueof(stringToDateNoTime(notifyPSM.Caso__r.PO_Data_Attivazione_Richiesta__c)),
		                                 //dateToString(notifyPSM.Caso__r.PO_Case_Collegamento__r.OF_Order__r.CreatedDate),//DATA_ORDINE 1.06
										 dateToString(notifyPSM.Caso__r.CreatedDate),
										 subInput,
										 dateYMToString(notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c),
										 null,
										 (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_BB_1_interessato__c,
										 (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_BB_2_interessato__c,
										 notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Pop_1_di_riferimento2__r.Name,
										 notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Pop_2_di_riferimento2__r.Name,
										 dropFL1,
										 dropFL2,
										 getLungDropFlLease(notifyPSM),
										 (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_1_via_nuovo_Drop__c,
										 (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Posa_2_via_nuovo_Drop__c,
										 (Integer)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c,
										 (Double)notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_BB_1_via_interessato__c,
										 (Double)notifyPSM.Caso__r.PO_Lunghezza_m__c,
										 (Double)notifyPSM.Caso__r.PO_Lunghezza_m2__c,
										 getIdCircuitoTratta2(notifyPSM.Caso__c),
										 ('Note Fattibilità: ' + notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Note_fattibilit__c + 'Note: ' + notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Note_Network_Creation__c),// = notifyPSM.NOTE_COLLEGAMENTO,
										 notifyPSM.Caso__r.PO_Case_Collegamento__r.CaseNumber,
										 listaSedi /*Manca Attachment*/);

		system.debug('Invoco la callout:' + response);
		if (( response != null) && '0'.equals(response.Esito)) {
			// MB update checkbox start
			List<Case> listTmp = [Select id, View_PopUp_PSM__c,view_error_file_PSM__c from Case where Id=:notifyPSM.Caso__c limit 1];
			if (listTmp != null) {
				listTmp.get(0).View_PopUp_PSM__c = false;
				listTmp.get(0).view_error_file_PSM__c=errorFile;
				update listTmp.get(0);
			}
			// MB update checkbox end
			EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
				Caso__c = notifyPSM.Caso__c,
				RecordTypeId = rt_Ack_Nack.id,
				Notify__c = notifyPSM.id,
				EOF_Data_Notifica__c=notifyPSM.EOF_Data_Notifica__c,
				EOF_Richiesta_Notifica__c =  'Esito:' + response.Esito,
				EOF_ID_Notifica__c = notifyPSM.Name,
				OF_SA_Azione__c= AZIONE_ATTIVAZIONE
			);

			insert ackLog;

		}
		else{
			// GB 30.05.2018 START
			//   In caso di NACK, ripristino la fase del case altrimenti non sarebbe più possibile avviare l'integrazione.
			List<Case> listTmp = [Select id, EOF_Fase__c,View_PopUp_PSM__c,view_error_file_PSM__c from Case where Id=:notifyPSM.Caso__c limit 1];
			if (listTmp != null) {
				listTmp.get(0).EOF_Fase__c=PO_FATT_WS_PSM_Notify_Utils.EOF_FASE_IN_LAVORAZIONE_SUPPORTO_VENDITE;
				listTmp.get(0).View_PopUp_PSM__c = true;              // MB update checkbox
				listTmp.get(0).view_error_file_PSM__c=errorFile;
				update listTmp.get(0);
			}
			// GB 30.05.2018 end
			EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
				Caso__c = notifyPSM.Caso__c,
				RecordTypeId = rt_Ack_Nack.id,
				Notify__c = notifyPSM.id,
				EOF_Richiesta_Notifica__c = 'Esito:' + response.ESITO + '\n' + 'Codice errore: ' +
					response.CODICE_MOTIVAZIONE + '\n' + 'Causale errore: ' +
					response.MOTIVAZIONE,
				EOF_Codice_errore__c=response.CODICE_MOTIVAZIONE,
				EOF_Causale_Errore__c=response.MOTIVAZIONE,
				EOF_ID_Notifica__c = notifyPSM.Name,
				EOF_Data_Notifica__c = notifyPSM.EOF_Data_Notifica__c,
				OF_SA_Azione__c= AZIONE_ATTIVAZIONE
			);
			insert nackLog;
		}
		system.debug('PO_FATT_WS_PSM_Notify_Utils: fine metodo inoltro Attivazione');
	}

	/*  Autore: Eleonora Caravello
	 *   Descrizione: Metodo per Integrazione Outbound PSM -   todo
	 *
	 *   Parametri: idnotifyPSM - Indica l'id della notifica per la quale avviene l'integrazione.
	 */
	@Future(callout=true)
	public static void createAckNackNotify_Cessazione(String idnotifyPSM) {

		system.debug('PO_FATT_WS_PSM_Notify_Utils: inizio metodo inoltro Cessazione');

		RecordType rt_Ack_Nack = [SELECT Id FROM RecordType WHERE Name = 'PSM_WS_OUT_ACK_NACK' LIMIT 1];
		EOF_Notify__c notifyPSM = [select Id,Name, Caso__r.EOF_Note_Interne__c, Caso__r.EOF_Account_OLO__r.Name,
								   Caso__r.PO_Case_Collegamento__c, Caso__r.PO_Case_Collegamento__r.EOF_ID_Risorsa__c, EOF_Codice_Ordine_OLO__c,
								   EOF_ID_Notifica__c, EOF_Data_Notifica__c, Caso__r.PO_Sito__c, Caso__r.PO_Indirizzo_collegamento__c,
								   Caso__r.PO_Nome_Comune__c, Caso__r.PO_Case_Collegamento__r.PO_Comune2__c,
								   Caso__r.PO_Civico__c, Caso__r.PO_Nome_Comune3__c, Caso__r.PO_Indirizzo_collegamento_partenza__c,
								   Caso__r.PO_Sito_partenza__c, Caso__r.PO_Civico_partenza__c, Caso__r.PO_Nome_Comune4__c, Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_2__c,
								   Caso__r.PO_indirizzo_collegamento_3__c, Caso__r.PO_Sito_3__c, Caso__r.PO_Civico_3__c, Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_1__c, Caso__r.PO_Drop_FL_2__c, Caso__r.Casenumber, Caso__c,
								   Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c,
								   Caso__r.Account.Name
								   from EOF_Notify__c where RecordType.DeveloperName=:RT_PSM_NotificaCessazione and id=: idnotifyPSM];

		String dropFL1=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_1__c ? 'Y' : 'N';
		String dropFL2=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_2__c ? 'Y' : 'N';

		List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element> listaAtt= new  List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element>();
		listaAtt=getListAttachment(notifyPSM.Caso__r.PO_Case_Collegamento__c);

		List<String> sediList = new List<String>();

		//INVOCAZIONE DEL SERVIZIO
		PO_FATT_WS_PSM_OUT_Sincronizzazione.PortTypeEndpoint1 stub = new PO_FATT_WS_PSM_OUT_Sincronizzazione.PortTypeEndpoint1();
		stub.timeout_x=30000;

		PO_FATT_WS_PSM_OUT_Notify.OutputMapping1 response = new PO_FATT_WS_PSM_OUT_Notify.OutputMapping1();

		PO_FATT_WS_PSM_OUT_Notify.SubInput subInput=new PO_FATT_WS_PSM_OUT_Notify.SubInput();
		subInput.NOTE_ORDINE= notifyPSM.Caso__r.EOF_Note_Interne__c;
		subInput.PM_DI_RIFERIMENTO= null;        //VUOTA;           //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.ESITO_FATTIBILITA= null;        //VUOTA;           //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		//subInput.ACCOUNT = notifyPSM.Caso__r.EOF_Account_OLO__r.Name;    //,
		subInput.ACCOUNT = notifyPSM.Caso__r.EOF_Account_OLO__r.Name == null ? notifyPSM.Caso__r.Account.Name : notifyPSM.Caso__r.EOF_Account_OLO__r.Name;   //fix 01.06

		subInput.TIPO_DI_CONTRATTO= null;        //VUOTA;           //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.TIPO_DI_PERCORSO = null;        //VUOTA;          //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.TIPO_DI_COLLEGAMENTO = null;        //VUOTA;      //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.PRIME_CONTRACTOR = null;        //VUOTA;           //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.FIBRE_RICHIESTE= null;        //VUOTA;             //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.RICHIEDENTE= null;        //VUOTA;                 //null,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.ID_RISORSA= notifyPSM.Caso__r.PO_Case_Collegamento__r.EOF_ID_Risorsa__c;
		subInput.Attachment = listaAtt;

		List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element> listaSedi= new  List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element>();

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede.NUMERO_SEDE= '1';
		sede.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito__c;
		sede.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_Indirizzo_collegamento__c;
		sede.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune__c;
		sede.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico__c;

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede2=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede2.NUMERO_SEDE= '2';
		sede2.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede2.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito_partenza__c;
		sede2.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_Indirizzo_collegamento_partenza__c;
		sede2.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune3__c;
		sede2.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico_partenza__c;

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede3=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede3.NUMERO_SEDE= '3';
		sede3.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede3.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito_3__c;
		sede3.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_indirizzo_collegamento_3__c;
		sede3.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune4__c;
		sede3.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico_3__c;

		listaSedi.add(sede);
		listaSedi.add(sede2);
		listaSedi.add(sede3);

		//Invoking the callout with corresponding parameters
		response = stub.SF_PSMOperation(null,          //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										getIdCircuitoTratta1(notifyPSM.Caso__c),        // = notifyPSM.ID_CIRCUITO_PRIMA_TRATTA,
										notifyPSM.Caso__r.Casenumber,
										notifyPSM.id,        //notifyPSM.EOF_ID_Notifica__c,
		                                //GB start: la consistenza è sbagliata poichè non vi è history, in ogni caso va garantito che non sia null.
										getDataOrdineCompletato(notifyPSM.Caso__c),
		                                //GB end
										dateToString(notifyPSM.EOF_Data_Notifica__c),
										AZIONE_CESSAZIONE,        // = notifyPSM.AZIONE,
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										SubInput,
										null,        //LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAint,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTAdb,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										getIdCircuitoTratta2(notifyPSM.Caso__c),        //  notifyPSM.ID_CIRCUITO_SECONDA_TRATTA;
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null,        //VUOTA,//LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										null);        //LA CESSAZIONE NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO  /*Manca Attachment*/

		//GESTIONE DELLA RESPONSE
		//Creating EAI_Service_Logs based on the response
		if (( response != null) && '0'.equals(response.Esito)) {
			EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
				Caso__c = notifyPSM.Caso__c,
				RecordTypeId = rt_Ack_Nack.id,
				Notify__c = notifyPSM.id,
				EOF_Data_Notifica__c=notifyPSM.EOF_Data_Notifica__c,
				//EOF_Data_Notifica_String__c = string.valueOf(notifyPSM.EOF_Data_Notifica__c),
				EOF_Richiesta_Notifica__c =  'Esito:' + response.Esito,
				EOF_ID_Notifica__c = notifyPSM.Name,
				OF_SA_Azione__c= AZIONE_CESSAZIONE
			);
			insert ackLog;
		}
		else{
			EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
				Caso__c = notifyPSM.Caso__c,
				RecordTypeId = rt_Ack_Nack.id,
				Notify__c = notifyPSM.id,
				EOF_Richiesta_Notifica__c = 'Esito:' + response.ESITO + '\n' + 'Codice errore: ' +
					response.CODICE_MOTIVAZIONE + '\n' + 'Causale errore: ' +
					response.MOTIVAZIONE,
				EOF_Codice_errore__c=response.CODICE_MOTIVAZIONE,
				EOF_Causale_Errore__c=response.MOTIVAZIONE,
				EOF_ID_Notifica__c = notifyPSM.Name,
				EOF_Data_Notifica__c = notifyPSM.EOF_Data_Notifica__c,
				OF_SA_Azione__c= AZIONE_CESSAZIONE
			);
			insert nackLog;
		}

		system.debug('PO_FATT_WS_PSM_Notify_Utils: fine metodo inoltro Cessazione');

	}

	/*  Autore: Eleonora Caravello
	 *   Descrizione: Metodo per Integrazione Outbound PSM -   todo
	 *
	 *   Parametri: idnotifyPSM - Indica l'id della notifica per la quale avviene l'integrazione.
	 */
	@Future(callout=true)
	public static void createAckNackNotify_Annullamento(String idnotifyPSM) {

		system.debug('PO_FATT_WS_PSM_Notify_Utils: inizio metodo inoltro Annullamento');

		RecordType rt_Ack_Nack = [SELECT Id FROM RecordType WHERE Name = 'PSM_WS_OUT_ACK_NACK' LIMIT 1];
		EOF_Notify__c notifyPSM = [select Id,Name, Caso__r.EOF_Note_Interne__c, Caso__r.EOF_Account_OLO__r.Name,
								   Caso__r.PO_Case_Collegamento__c, EOF_Codice_Ordine_OLO__c, EOF_ID_Notifica__c, EOF_Data_Notifica__c,
								   Motivo_Rifiuto_Sospensione_Annullamento__c,Caso__r.PO_Sito__c, Caso__r.PO_Indirizzo_collegamento__c,
								   Caso__r.PO_Nome_Comune__c, Caso__r.PO_Case_Collegamento__r.PO_Comune2__c,
								   Caso__r.PO_Civico__c, Caso__r.PO_Nome_Comune3__c, Caso__r.PO_Indirizzo_collegamento_partenza__c,
								   Caso__r.PO_Sito_partenza__c, Caso__r.PO_Civico_partenza__c, Caso__r.PO_Nome_Comune4__c, Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_2__c,
								   Caso__r.PO_indirizzo_collegamento_3__c, Caso__r.PO_Sito_3__c, Caso__r.PO_Civico_3__c, Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_1__c, Caso__r.PO_Drop_FL_2__c, Caso__r.Casenumber, Caso__c,
								   Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c,
								   Caso__r.Account.Name
								   from EOF_Notify__c
								   where RecordType.DeveloperName=:RT_PSM_NotificaAnnullamento and id=: idnotifyPSM];

		String dropFL1=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_1__c ? 'Y' : 'N';
		String dropFL2=notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Drop_FL_2__c ? 'Y' : 'N';

		List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element> listaAtt= new  List<PO_FATT_WS_PSM_OUT_Notify.Attachment_element>();
		listaAtt=getListAttachment(notifyPSM.Caso__r.PO_Case_Collegamento__c);

		List<String> sediList = new List<String>();

		//INVOCAZIONE DEL SERVIZIO
		PO_FATT_WS_PSM_OUT_Sincronizzazione.PortTypeEndpoint1 stub = new PO_FATT_WS_PSM_OUT_Sincronizzazione.PortTypeEndpoint1();
		stub.timeout_x=30000;

		PO_FATT_WS_PSM_OUT_Notify.OutputMapping1 response = new PO_FATT_WS_PSM_OUT_Notify.OutputMapping1();

		PO_FATT_WS_PSM_OUT_Notify.SubInput subInput=new PO_FATT_WS_PSM_OUT_Notify.SubInput();
		subInput.NOTE_ORDINE= notifyPSM.Caso__r.EOF_Note_Interne__c;
		subInput.PM_DI_RIFERIMENTO= null;    //VUOTA;                                           //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.ESITO_FATTIBILITA= null;    //VUOTA;                                           //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		//subInput.ACCOUNT = notifyPSM.Caso__r.EOF_Account_OLO__r.Name;
		subInput.ACCOUNT = notifyPSM.Caso__r.EOF_Account_OLO__r.Name == null ? notifyPSM.Caso__r.Account.Name : notifyPSM.Caso__r.EOF_Account_OLO__r.Name; //fix 01.06
		subInput.TIPO_DI_CONTRATTO= null;    //VUOTA;                                           //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.TIPO_DI_PERCORSO = null;    //VUOTA;                                          //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.TIPO_DI_COLLEGAMENTO = null;    //VUOTA;                                      //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.PRIME_CONTRACTOR = null;    //VUOTA;                                           //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.FIBRE_RICHIESTE= null;    //VUOTA;                                             //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.RICHIEDENTE= null;    //VUOTA;                                                 //null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.ID_RISORSA= null;    //VUOTA;                                                 //L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
		subInput.Attachment = listaAtt;

		List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element> listaSedi= new  List<PO_FATT_WS_PSM_OUT_Notify.Sedi_element>();

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede.NUMERO_SEDE= '1';
		sede.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito__c;
		sede.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_Indirizzo_collegamento__c;
		sede.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune__c;
		sede.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico__c;

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede2=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede2.NUMERO_SEDE= '2';
		sede2.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede2.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito_partenza__c;
		sede2.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_Indirizzo_collegamento_partenza__c;
		sede2.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune3__c;
		sede2.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico_partenza__c;

		PO_FATT_WS_PSM_OUT_Notify.Sedi_element sede3=new PO_FATT_WS_PSM_OUT_Notify.Sedi_element();
		sede3.NUMERO_SEDE= '3';
		sede3.CODICE_ISTAT= notifyPSM.Caso__r.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c;
		sede3.DENOMINAZIONE_SEDE= notifyPSM.Caso__r.PO_Sito_3__c;
		sede3.NOME_VIA_SEDE= notifyPSM.Caso__r.PO_indirizzo_collegamento_3__c;
		sede3.COMUNE_SEDE= notifyPSM.Caso__r.PO_Nome_Comune4__c;
		sede3.CIVICO_SEDE= notifyPSM.Caso__r.PO_Civico_3__c;

		listaSedi.add(sede);
		listaSedi.add(sede2);
		listaSedi.add(sede3);

		//Invoking the callout with corresponding parameters
		response = stub.SF_PSMOperation(  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  notifyPSM.Caso__r.Casenumber,
										  notifyPSM.id,//notifyPSM.EOF_ID_Notifica__c,
		                                  //GB start: la consistenza è sbagliata poichè non vi è history, in ogni caso va garantito che non sia null.
										  getDataOrdineCompletato(notifyPSM.Caso__c),
		                                  //GB end
										  dateToString(notifyPSM.EOF_Data_Notifica__c),
										  AZIONE_ANNULLAMENTO,// = notifyPSM.AZIONE,
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  subInput,
										  null,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  notifyPSM.Motivo_Rifiuto_Sospensione_Annullamento__c,//MOTIVAZIONE_ANNULLAMENTO = notifyPSM.Motivo_Rifiuto_Sospensione_Annullamento__c;
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAint,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTAdb,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null,//VUOTA,//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO
										  null);//L'ANNULLAMENTO NON CHIEDE LA VALORIZZAZIONE DI QUESTO CAMPO  //sedi /*Manca Attachment*/);

		//GESTIONE DELLA RESPONSE
		//Creating EAI_Service_Logs based on the response
		if (( response != null) && '0'.equals(response.Esito)) {
			EOF_EAI_Service_Log__c ackLog = new EOF_EAI_Service_Log__c(
				Caso__c = notifyPSM.Caso__c,
				RecordTypeId = rt_Ack_Nack.id,
				Notify__c = notifyPSM.id,
				EOF_Data_Notifica__c=notifyPSM.EOF_Data_Notifica__c,
				EOF_Richiesta_Notifica__c =  'Esito:' + response.Esito,
				EOF_ID_Notifica__c = notifyPSM.Name,
				OF_SA_Azione__c= AZIONE_ANNULLAMENTO
			);
			insert ackLog;
		}
		else{
			EOF_EAI_Service_Log__c nackLog = new EOF_EAI_Service_Log__c(
				Caso__c = notifyPSM.Caso__c,
				RecordTypeId = rt_Ack_Nack.id,
				Notify__c = notifyPSM.id,
				EOF_Richiesta_Notifica__c = 'Esito:' + response.ESITO + '\n' + 'Codice errore: ' +
					response.CODICE_MOTIVAZIONE + '\n' + 'Causale errore: ' +
					response.MOTIVAZIONE,
				EOF_Codice_errore__c=response.CODICE_MOTIVAZIONE,
				EOF_Causale_Errore__c=response.MOTIVAZIONE,
				EOF_ID_Notifica__c = notifyPSM.Name,
				EOF_Data_Notifica__c = notifyPSM.EOF_Data_Notifica__c,
				OF_SA_Azione__c= AZIONE_ANNULLAMENTO
			);
			insert nackLog;
		}
		system.debug('PO_FATT_WS_PSM_Notify_Utils: fine metodo inoltro Annullamento');
	}
}