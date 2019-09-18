public class PO_CeD_OperationChoiceController {

    public Case originalCase{get;set;}
    public boolean mostraDesospeso{get;set;} 
    public boolean mostraEspletatoOK{get;set;}
    public boolean mostraEspletatoKO{get;set;} 
    public boolean mostraAccettazione{get;set;} 
    public boolean mostraRDAC{get;set;}
    public boolean mostraSospeso{get;set;}
    public boolean mostraErrore{get;set;} 
    public String tipoOp{get;set;}
    public String cod_motivazione{get;set;}
    public String motivazione{get;set;}
    public String id_risorsa{get;set;}
    
    public boolean showCodMotivazioniEspKO{get;set;}
    public boolean showCodMotivazioniEspOK{get;set;}
    public boolean showCodMotivazioniRDac{get;set;}
    public boolean showCodMotivazioniSosp{get;set;}
    
    public boolean showInputIdRisorsa{get;set;}
    public boolean showInputCodMotivazione{get;set;}
    public boolean showInputMotivazione{get;set;}
    public boolean showInputNoteInterne{get;set;}
    public boolean showInputDataPrev{get;set;}

    public String idc{get;set;}
    
    public String oraApp{get;set;}
    public Integer minutiApp{get;set;}
  
    public Time orario {get;set;}
    
    public SelectOption[] elencoCodMotivazioneEspKO {
    	public get;
    	private set;
    }
    
    public SelectOption[] elencoCodMotivazioneEspOK {
    	public get;
    	private set;
    }
    
    public SelectOption[] elencoCodMotivazioneRDAC {
    	public get;
    	private set;
    }
    
    public SelectOption[] elencoCodMotivazioneSosp {
    	public get;
    	private set;
    }
    
    public PO_CeD_OperationChoiceController(ApexPages.StandardController stdController){ 
        
        originalCase = (Case)stdController.getRecord();
        idc = ApexPages.currentPage().getParameters().get('Id');
        tipoOp = ApexPages.currentPage().getParameters().get('Oper'); 
        System.debug('<<< Operazione selezionata >>> : '+tipoOp);
        
        system.debug('<<< PO_CeD_OperationChoiceController originalCase: >>> '+originalCase);
        
        originalCase = [select Id, casenumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Ordine_OLO__c, Account.FirstName, Account.LastName,
                        Contact.name, recordtypeid, EOF_Note_Operatore__c, Status, EOF_GPON_Attestazione__c, EOF_Orario_Appuntamento__c,
                        EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name, EOF_Note__c, recordType.DeveloperName, 
                        EOF_Fase__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c, PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c,  
                        PO_Note_Supporto_Vendite__c, PO_Owner_Originario__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, 
                        EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Recapito_Telefonico_Cliente_1__c,
                        EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c, OF_Esito_Consegna_Apparato__c, Previous_Status__c,
                        OF_SA_Codice_Motivazione__c, OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, 
                        EOF_Comune_WS__c, EOF_Provincia_WS__c, EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, 
                        EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, OF_Order__c, Contact.Email, EOF_Data_Prevista_Attivazione__c
                        from Case 
                        where Id=:idc]; 
        
        //Codici Motivazione Espletamento KO
        String[] codici_motivazione_EspKO = new String[]{'None','B08','C01','C02','C03','C04','C06','C15'};
		elencoCodMotivazioneEspKO = new SelectOption[]{};
		
		for (String cod : codici_motivazione_EspKO) {
			elencoCodMotivazioneEspKO.add(new SelectOption(cod, cod));
		}
		
		//Codici Motivazione Espletamento OK
		String[] codici_motivazione_EspOK = new String[]{'None','C07'};
		elencoCodMotivazioneEspOK = new SelectOption[]{};
		
		for (String cod : codici_motivazione_EspOK) {
			elencoCodMotivazioneEspOK.add(new SelectOption(cod, cod));
		}
		
		//Codici Motivazione RDAC
		String[] codici_motivazione_RDAC = new String[]{'None','R00','R01','R02','R03','R04'};
		elencoCodMotivazioneRDAC = new SelectOption[]{};
		
	    for (String cod : codici_motivazione_RDAC) {
			elencoCodMotivazioneRDAC.add(new SelectOption(cod, cod));
		}
		
		//Codici Motivazione Sospensione
		String[] codici_motivazione_Sosp = new String[]{'None','D11','B06','C05','C09','C10','C11','C12','C13','D00','D02','D03','D04','D05','D06','D07','D08','D09','D10'};
		elencoCodMotivazioneSosp = new SelectOption[]{};
		
	    for (String cod : codici_motivazione_Sosp) {
			elencoCodMotivazioneSosp.add(new SelectOption(cod, cod));
		}
        if(originalCase.OF_SA_Motivazione__c!=null)
            motivazione = originalCase.OF_SA_Motivazione__c;
            
        showButtonRules();
    }
    
    public PageReference runSearchMotivazione() {
        
        cod_motivazione = Apexpages.currentPage().getParameters().get('codice');  
		Causali_Operazioni__c causale_selezionata = Causali_Operazioni__c.getValues(cod_motivazione);
    	
    	If(causale_selezionata!=null){
    		motivazione = causale_selezionata.Motivazione__c; 
    	    System.debug('*** motivazione *** : '+motivazione);
    	}
	    return null;
	}

    public void showButtonRules(){
    
        //inizializzo la visibilità
        
        mostraSospeso = false; 
        mostraDesospeso = false; 
        mostraEspletatoOK = false;
        mostraRDAC = false;
        mostraEspletatoKO = false; 
        mostraAccettazione = false;

        showInputIdRisorsa = true;
        showInputCodMotivazione = true;
        showInputMotivazione = true;
        showInputNoteInterne = false;
        showInputDataPrev = true;
        
        showCodMotivazioniEspKO = false;
		showCodMotivazioniEspOK = false;
        showCodMotivazioniRDac = false;
        showCodMotivazioniSosp = false;

        System.debug('>>> visibilita originalCase.Owner.Type : '+originalCase.Owner.Type+' - originalCase.status: '+originalCase.status);
        
        //CRITERI DI VISUALIZZAZIONE PULSANTI E CAMPI
        
        //Visualizzo i pulsanti se il recordType è quello dei Case di ATTIVAZIONE per OpenStreamCD e GPON Passiva CD
        if(originalCase.recordType.developerName.equalsIgnoreCase('EOF_Caso_Attivazione_OPENSTREAM_CeD') 
        ||  originalCase.recordType.developerName.equalsIgnoreCase('EOF_SP_Caso_Attivazione_CeD'))
        {   
            if(originalCase.Status=='Annullato')
            {
                mostraEspletatoOK = false; 
                mostraEspletatoKO = false; 
                mostraSospeso = false;
                mostraDesospeso = false; 
            }
            //SOSPESO
            if( (originalCase.Status=='Acquisito' || originalCase.Status=='Accettato') && tipoOp.equalsIgnoreCase('SOSP'))
            {
                //mostraRDAC = true;
                mostraSospeso = true;
                showCodMotivazioniEspKO = false;
                showCodMotivazioniEspOK = false;
                showCodMotivazioniSosp = true;
                showInputIdRisorsa = false;
                showInputNoteInterne = true;
                showInputDataPrev = false;
            }
            //RDAC
            if( (originalCase.Status=='Acquisito' || originalCase.Status=='Accettato' || originalCase.Status=='Sospeso') 
            && tipoOp.equalsIgnoreCase('R_DAC') )
            {
                showCodMotivazioniEspKO = false;
                showCodMotivazioniEspOK = false;
                showInputIdRisorsa = false;
                showCodMotivazioniRDac = true;
                mostraRDAC = true;
                showInputIdRisorsa = false;
            }
            //ACCETTATO
            if(originalCase.Status=='Acquisito' && tipoOp.equalsIgnoreCase('ACC') )
            {
                mostraAccettazione = true; 
                showInputCodMotivazione = false;
                showInputMotivazione = false;
                showInputIdRisorsa = false;
                //showCodMotivazioniRDac = true;
                //mostraRDAC = true;
            }
            //ESPLETAMENTO OK
            if(originalCase.Status=='Accettato' && tipoOp.equalsIgnoreCase('ESP_OK') )
            {
                mostraEspletatoOK = true; 
                showCodMotivazioniEspOK = true;
                showCodMotivazioniEspKO = false;
                showCodMotivazioniRDac = false;
                showCodMotivazioniSosp = false;
                showInputDataPrev = false;
            }
            //ESPLETAMENTO KO
            if(originalCase.Status=='Accettato' && tipoOp.equalsIgnoreCase('ESP_KO') )
            {
                mostraEspletatoKO = true; 
                showCodMotivazioniEspKO = true;
                showCodMotivazioniEspOK = false;
                showCodMotivazioniRDac = false;
                showCodMotivazioniSosp = false;
                showInputIdRisorsa = false;
                showInputDataPrev = false;
            }
            //DESOSPESO
            if(originalCase.Status=='Sospeso' && tipoOp.equalsIgnoreCase('DESOSP'))
            {
                mostraDesospeso = true;
                showInputNoteInterne = true;
                showInputCodMotivazione = false;
                showInputMotivazione = false;
                showInputIdRisorsa = false;
                showInputDataPrev = false;
            }
        }
    }   

    public pageReference rimodulazioneDAC()
    {
        system.debug('@@@@@EC appena chiamato RDAC. orario vale: ' + orario);
        System.debug('<<< rimodulazioneDAC >>>');
        if(orario!=null)
        {      
            String oTot = originalCase.EOF_Orario_Appuntamento__c;
        
            String h = oTot.left(2);
            integer h1 = integer.valueOf(h);
            String mm1 = oTot.substring(3, 5);
            integer mm = integer.valueOf(mm1);
            String ss1= oTot.right(2);
            integer ss = integer.valueOf(ss1);
         	system.debug('@@@@orario era Null, ora è ' + orario + ', h ora è ' + h + ', h1 è ' + h1);
            system.debug('@@@@orario era Null, mm1 è ' + mm1 + ', h ora è ' + h + ', h1 è ' + h1);
            system.debug('@@@@@EC proviamo se sono numeri: h.isNumeric() : ' + h.isNumeric() + ', mm1.isNumeric(): ' + mm1.isNumeric() + ', ss1.isNumeric() ' + ss1.isNumeric());
            //integer m = integer.valueOf(i); 
            if((h1<0 || h1>23) || (mm<0 || mm > 59 || (ss<0 || ss>59)) || (!h.isNumeric() || !mm1.isNumeric() || !ss1.isNumeric()) ){
               system.debug('@@@@orario era Null. h1 < di 0 o > 23 è ' + h1);
               String sO ='Orario non valido';
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,sO)); 
              return null;  
        }
            oraApp = String.valueOf(orario);
            originalCase.EOF_Orario_Appuntamento__c = oraApp.substring(0,8);
        }
        else{
            String oTot = originalCase.EOF_Orario_Appuntamento__c;
        
            String h = oTot.left(2);
            String mm1 = oTot.substring(3, 5);
            String ss1= oTot.right(2);
            if(!h.isNumeric() || !mm1.isNumeric() || !ss1.isNumeric()){
               system.debug('@@@@orario qualcuno dei valori non è numerico: h ' + h +', mm1 ' + mm1 + ', ss1 ' + ss1);
               String sO ='Formato orario non valido';
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,sO)); 
              return null;    
            }
            integer h1 = integer.valueOf(h);
            integer mm = integer.valueOf(mm1);
            integer ss = integer.valueOf(ss1);
         	system.debug('@@@@orario era Null, ora è ' + orario + ', h ora è ' + h + ', h1 è ' + h1);
            
            if( (h1<0 || h1>23) || (mm<0 || mm > 59 || (ss<0 || ss>59))) {
               system.debug('@@@@orario era Null. h1 < di 0 o > 23 è ' + h1);
               String sO ='Orario non valido';
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,sO)); 
              return null;  
        	}
        }
        try{
        update originalCase;
        }
        catch(Exception e){
          for (Integer i = 0; i < e.getNumDml(); i++) {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
              system.debug(e);
              return null;
              }
        }
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule Notify = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.NOME_CLIENTE = originalCase.Account.FirstName;
        Notify.COGNOME_CLIENTE = originalCase.Account.LastName;
        Notify.RECAPITO_TELEFONICO_CLIENTE_1 = originalCase.EOF_Recapito_Telefonico_Cliente_1__c;
        Notify.DATA_PREVISTA_ATTIVAZIONE = String.valueOfGmt(originalCase.EOF_Data_Prevista_Attivazione__c);
        Notify.ORARIO_APPUNTAMENTO = originalCase.EOF_Orario_Appuntamento__c;
        Notify.NOTE = originalCase.EOF_Note__c;
        Notify.CODICE_MOTIVAZIONE = 'R00';
        Notify.MOTIVAZIONE = 'Ripianificazione appuntamento causa OF'; 
        
        OF_SA_CD_WS_IN_OM.OM_Reschedule(Notify);

        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;   
    }
    
    //Torna indietro al dettaglio Case
    public pageReference goBack()
    {
        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;   
    }

    public pageReference accettazione(){
        
        System.debug('<<< Accettato >>>');
        if(orario!=null)
        {
            oraApp = String.valueOf(orario);
            originalCase.EOF_Orario_Appuntamento__c = oraApp.substring(0,8);
        }
        update originalCase;

        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime()); 
        Notify.STATO_ORDINE = '2'; //ACCETTATO
        Notify.NOME_CLIENTE = originalCase.Account.FirstName;
        Notify.COGNOME_CLIENTE = originalCase.Account.LastName;
        Notify.GPON_DI_ATTESTAZIONE = originalCase.EOF_GPON_Attestazione__c;
        Notify.RECAPITO_TELEFONICO_CLIENTE = originalCase.EOF_Recapito_Telefonico_Cliente_1__c;
        Notify.DATA_PREVISTA_ATTIVAZIONE = String.valueOfGmt(originalCase.EOF_Data_Prevista_Attivazione__c);
        Notify.ORARIO_APPUNTAMENTO = originalCase.EOF_Orario_Appuntamento__c;
        //Notify.PIN_INTERVENTO_A_VUOTO='Y';
        Notify.NOTE = originalCase.EOF_Note__c;

        OF_SA_CD_WS_IN_OM.CD_OM_Notify_StatusUpdate(Notify);
     
        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;
    }
    
    public PageReference espletamento_OK(){
        
        System.debug('<<< Espletamento OK >>>');
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder();
        
        //Check su campi obbligatori
        if( (id_risorsa==null) || String.isBlank(id_risorsa) ){
            return null;
        }
        else{
            originalCase.EOF_Id_Risorsa__c = id_risorsa;
        }
        if( (cod_motivazione==null) || String.isBlank(cod_motivazione)
            || (originalCase.OF_SA_Codice_Motivazione__c=='None') ){
            return null;
        }
        else{
            originalCase.OF_SA_Codice_Motivazione__c = cod_motivazione;
        }
        if( (motivazione==null) || String.isBlank(motivazione) ){
            return null;
        }
        else{
            originalCase.OF_SA_Motivazione__c = motivazione;
        }
        
        update originalCase;
        
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.STATO_ORDINE = '0';
        
        Notify.ID_RISORSA = originalCase.EOF_Id_Risorsa__c;
        Notify.CODICE_MOTIVAZIONE = originalCase.OF_SA_Codice_Motivazione__c;
        Notify.MOTIVAZIONE = originalCase.OF_SA_Motivazione__c;
        
        //Notify.ID_RISORSA = 'ATT_'+String.valueOf(system.now()).left(10)+'_'+String.valueOf(system.now()).right(8);
        Notify.DATA_ESPLETAMENTO_ORDINE = String.valueOf(System.today());
        Notify.SCALA_PALAZZINA = originalCase.EOF_Scala_Palazzina_WS__c;
        //Notify.DDT ='';
        Notify.NOTE = originalCase.EOF_Note__c;
        
        List<OF_CommercialElementIstanziato__c> listaCei_inseriti = new List<OF_CommercialElementIstanziato__c>();
        
        listaCei_inseriti = [Select id, name, RecordType.name, OF_CommercialElementName__c, OF_Nome_Servizio__c, 
        					 OF_ESITOSERVIZIO__c, OF_MOTIVAZIONESERVIZIO__c, OF_Informazioni_Servizio__c, OF_SA_CPE__c, 
        					 OF_SA_Servizio_Aggiuntivo__c, OF_SA_VLAN__c, OF_ProfiloVLAN__c, OF_ServiceVLAN__c, OF_UserVLAN__c, 
        					 OF_InformazioniVLAN__c, OF_TipologiaApparato__c, OF_AzioneApparato__c, OF_Password_Apparato__c,
        					 OF_ID_Apparato__c, OF_EsitoConsegnaApparato__c, OF_CODICEMOTIVAZIONE_SERVIZIO__c
        					 from OF_CommercialElementIstanziato__c 
        					 where OF_Case__c =: originalCase.id];
        
        Notify.APPARATO = new List<OF_SA_WS_IN_OM_CompletionOrder.APPARATO>();
        Notify.SERVIZIO_AGGIUNTIVO = new List<OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO>();
        
        for(OF_CommercialElementIstanziato__c cei : listaCei_inseriti)
        {
        	if(cei.recordType.name=='Servizi Aggiuntivi')
        	{
        		OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO servAgg = new OF_SA_WS_IN_OM_CompletionOrder.SERVIZIO_AGGIUNTIVO();
        		servAgg.NOME_SERVIZIO = cei.OF_Nome_Servizio__c;
        		servAgg.ESITO_SERVIZIO = '0';
        		servAgg.MOTIVAZIONE_SERVIZIO = cei.OF_MOTIVAZIONESERVIZIO__c;
        		servAgg.CODICE_MOTIVAZIONE_SERVIZIO = 'OK';
                Notify.SERVIZIO_AGGIUNTIVO.add(servAgg);
        	}
        	if(cei.recordType.name=='CPE')
        	{			
        		OF_SA_WS_IN_OM_CompletionOrder.APPARATO app = new OF_SA_WS_IN_OM_CompletionOrder.APPARATO();
        		app.TIPOLOGIA_APPARATO = cei.OF_TipologiaApparato__c;
        		app.ESITO_CONSEGNA_APPARATO = cei.OF_EsitoConsegnaApparato__c; 
        		app.ID_APPARATO_CONSEGNATO = 'OK';
        		app.CODICE_MOTIVAZIONE_CONSEGNA = '1';
        		app.MOTIVAZIONE_CONSEGNA = 'OK';			
                Notify.APPARATO.add(app);
        	}			
        }		
        OF_SA_CD_WS_IN_OM.CD_OM_Notify_CompletionOrder(Notify);
        
        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;
    }
    
    public PageReference espletamento_KO(){
        
        System.debug('<<< Espletamento KO >>>');
        
        originalCase.OF_SA_Codice_Motivazione__c = cod_motivazione;
    	originalCase.OF_SA_Motivazione__c = motivazione;
    	update originalCase;
        
        OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder Notify = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder ();
        
        /*
        //Check su campi obbligatori
        if( (originalCase.OF_SA_Motivazione__c==null) || String.isBlank(originalCase.OF_SA_Motivazione__c) ){
            return null;
        }
        else{
            Notify.MOTIVAZIONE = originalCase.OF_SA_Motivazione__c;
        }
        if( (originalCase.OF_SA_Codice_Motivazione__c==null) || String.isBlank(originalCase.OF_SA_Codice_Motivazione__c) ){
            return null;
        }
        else{
            Notify.CODICE_MOTIVAZIONE = originalCase.OF_SA_Codice_Motivazione__c;
        }
        */
        
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.STATO_ORDINE = '1';
        Notify.DATA_ESPLETAMENTO_ORDINE = String.valueOf(System.today());
        Notify.SCALA_PALAZZINA = originalCase.EOF_Scala_Palazzina_WS__c;
        //Notify.DDT ='';
        Notify.NOTE = originalCase.EOF_Note__c;
        Notify.CODICE_MOTIVAZIONE = originalCase.OF_SA_Codice_Motivazione__c;
        Notify.MOTIVAZIONE = originalCase.OF_SA_Motivazione__c;
        
        OF_SA_CD_WS_IN_OM.CD_OM_Notify_CompletionOrder(Notify);
        
        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;
    }
    
    public pageReference desospensione(){
        
        System.debug('<<< Desospeso >>>');
        //Sbianco codice motivazione e motivazione
        originalCase.OF_SA_Codice_Motivazione__c = '';
    	originalCase.OF_SA_Motivazione__c = '';
        update originalCase;

        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime()); 
        
        if(originalCase.Previous_Status__c == 'Accettato'){
            Notify.STATO_ORDINE = '2'; //ACCETTATO
        }
        else if(originalCase.Previous_Status__c == 'Acquisito'){
            Notify.STATO_ORDINE = '0'; //ACQUISITO
        }
        
        Notify.NOME_CLIENTE = originalCase.Account.FirstName;
        Notify.COGNOME_CLIENTE = originalCase.Account.LastName;
        Notify.GPON_DI_ATTESTAZIONE = originalCase.EOF_GPON_Attestazione__c;
        Notify.RECAPITO_TELEFONICO_CLIENTE = originalCase.EOF_Recapito_Telefonico_Cliente_1__c;
        Notify.DATA_PREVISTA_ATTIVAZIONE = String.valueOfGmt(originalCase.EOF_Data_Prevista_Attivazione__c);
        Notify.ORARIO_APPUNTAMENTO = originalCase.EOF_Orario_Appuntamento__c;
        Notify.NOTE = originalCase.EOF_Note__c;

        OF_SA_CD_WS_IN_OM.CD_OM_Notify_StatusUpdate(Notify);
     
        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;
    }
    
    public PageReference sospensione()
    {
        System.debug('<<< Sospensione >>>');
        originalCase.OF_SA_Codice_Motivazione__c = cod_motivazione;
    	originalCase.OF_SA_Motivazione__c = motivazione;
    	originalCase.Previous_Status__c = originalCase.status;
    	//originalCase.EOF_Note__c = OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - SOSPENSIONE OF - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
        update originalCase;

        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.STATO_ORDINE = '4'; //SOSPESO

        Notify.CODICE_MOTIVAZIONE = originalCase.OF_SA_Codice_Motivazione__c;
        Notify.MOTIVAZIONE = originalCase.OF_SA_Motivazione__c;
        Notify.NOTE = originalCase.EOF_Note__c;

        OF_SA_CD_WS_IN_OM.CD_OM_Notify_StatusUpdate(Notify);

        PageReference pg = new PageReference('/'+originalCase.id);
        return pg;
    }
}