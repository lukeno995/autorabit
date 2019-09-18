public class OF_ManageOrderFromCase_CD {
    
    //Attributi
    //Mappa per il customSetting CodificaProfiloListini
    public Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();
    private static Order o;
    public ID idAsset{set;get;}
    public Map<String, Id> rtMap;
    public Boolean checkrtMap = false;
    public Boolean esito = false;
    
    public OF_ManageOrderFromCase_CD(){
        if(!checkrtMap){
            List<RecordType> rtList = [SELECT Id, DeveloperName FROM RecordType];
            rtMap = new Map<String, Id>(); 
            for(RecordType rt : rtList){
                rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            checkrtMap = true;
        }  
    }

    public Id ManageOrder(Case c)
    {
        System.debug('*****Sono dentro ManageOrder*****');
        System.debug('*****c.status***** : '+c.status);
        //Attivazione
        if( c.RecordtypeId == rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD')
            || c.RecordtypeId == rtMap.get('EOF_SP_Caso_Attivazione_CeD')){             
             //Creazione Ordine
            if( (c.Status == 'Acquisito' || c.Status == 'Acquisito KO') && c.OF_Order__c == null ){
                System.debug(']]]]Prima della chiamata di creazioneOrdine @@@@');
                return creazioneOrdine( c , 'OF_INORDER'); 
            }
            if( c.Status == 'Espletato' || c.Status == 'Espletato KO' || c.Status == 'Annullato'
               || c.Status == 'Accettato KO' ){
                System.debug(']]]]Prima della chiamata di AggiornoOrdine @@@@');
                return AggiornoOrdine( c );
             }
        }
        //Cessazione
        if( c.RecordtypeId == rtMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD')    
            || c.RecordtypeId == rtMap.get('EOF_SP_Caso_Cessazione_CeD')){ 
            //Creazione Ordine 
            if( ( c.Status == 'Cessato KO' || c.Status == 'Acquisito' ) && c.OF_Order__c == null ){
                return creazioneOrdine( c , 'OF_OUTORDER');
            }
            //Aggiornamento Ordine
            if( c.Status == 'Cessato' ){
                return AggiornoOrdine( c );
            }
        }
        return null;
    }
    
    public string getTipologiaServizioByCaseRType(case c)
    {
        if((c.recordtypeId == rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD')) 
            || (c.recordtypeId == rtMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD'))){                
            c.OF_Servizio__c = 'Open Stream CD'; 
            return 'Attivo_CD';
        }
        else if( (c.recordtypeId == rtMap.get('EOF_SP_Caso_Attivazione_CeD')) 
            || (c.recordtypeId == rtMap.get('EOF_SP_Caso_Cessazione_CeD'))){
            c.OF_Servizio__c = 'GPON Passiva CD'; 
            return 'Passivo_CD';
        }
        else{
            return '';
        }
    }

    public Id creazioneOrdine( Case c , String recordTypeName ){
        
        System.debug('*****DENTRO creazioneOrdine******');
    
        Order o = new Order();
        o.RecordTypeId = rtMap.get( recordTypeName );
        o.AccountId = c.EOF_Account_OLO__c;
        o.EffectiveDate = system.Today();
        o.OF_CaseID__c = c.id;
        o.OF_TipologiaDiServizio__c = getTipologiaServizioByCaseRType(c);
        
        if( recordTypeName.equalsIgnoreCase('OF_INORDER') ){
            if( c.Status == 'Acquisito'){
                o.Status = 'Aperto';
                //DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }
            else if( c.Status.equalsIgnoreCase('Acquisito KO') ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_DataEsito__c = system.Today();
                o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
                o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;                 
            }
        }
        if( recordTypeName.equalsIgnoreCase('OF_OUTORDER') ){
            if( c.Status.equalsIgnoreCase('Cessato KO') ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_DataEsito__c = system.Today();
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }
            else if( c.Status == 'Acquisito'){
                o.Status = 'Aperto';
            }
            o.OF_Asset__c = c.assetId;
            o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
            o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
            o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
            o.OF_Apparato__c = c.EOF_Apparato__c;
            o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
            o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
            o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
            o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
        }
        if(c.OF_IDContratto__c != null){
            o.ContractId = c.OF_IDContratto__c;
        }
        o.OF_CaseID__c = c.Id;
        o.OF_CaseNome__c = c.CaseNumber;
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
        o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
        
        if(c.OF_SA_Profilo__c != null){   
            if(mapCodifica.get(c.OF_SA_Profilo__c) != null){
                o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).CD_ListinoCanoneName__c;
            }
        }
        //OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
        o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
        o.OF_Promozione__c = c.OF_SA_Promozione__c ;
        o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
        o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
        
        insert o;
    
        if( c.Status.equalsIgnoreCase('Acquisito') && recordTypeName.equalsIgnoreCase('OF_OUTORDER') ){
            System.debug('***c.OF_IDContratto__c*** '+c.OF_IDContratto__c);
            //INSERIMENTO ORDINE DI CESSAZIONE (OPERAZIONE = INSERIMENTO).
            //1.Cessazione di tutti i BE sotto l'asset legato all'ordine di Cessazione
            //2.Creazione BE di Cessazione
            
            //TODO - Da sostituire
            //richiamo il metodo che della classe OF_CD_CRMHandler
            //OF_CD_CRMHandler.inactivateBE(c, o);
            //Richiamo il metodo della classe OF_Espletamento_Generico_AP
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(c);
            esplManager.cessazioneBeiGPONP_OpenStream();
        }
        return o.Id;
    }

    public Id AggiornoOrdine(case c){
                                   
        Set<String> statusCaseToChiusoOK = new Set<String>{'Espletato', 'Cessato', 'Cessato OK'};
        Set<String> statusCaseToChiusoKO = new Set<String>{'Espletato KO', 'Annullato', 'Accettato KO', 'Cessato KO'};
        
        Order o1 = [SELECT Id, RecordType.Name, RecordType.Id, OF_Type__c, OF_TipologiaDiServizio__c,EffectiveDate,Status,
                    OF_DataEsito__c, OF_CodiceKO__c, OF_Esito__c, OF_DescrizioneKO__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,
                    OF_IDRisorsa__c, AccountId, OF_IDBuilding__c, OF_Asset__c, OF_SlaPremiumAssurance__c,OF_Apparato__c,
                    OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c, OF_PasswordApparato__c,
                    ContractId, OF_CaseID__c, OF_CaseNome__c, OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c, 
                    OF_Promozione__c, OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,
                    OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,OF_AccountTemporaneo__c
                    FROM Order 
                    WHERE Id =: c.OF_Order__c];
        
        //Il case è in uno stato di chiusura positiva
        if(statusCaseToChiusoOK.contains(c.Status) ){
            o1.Status = 'Chiuso';
            o1.OF_Esito__c = 'OK';
            o1.OF_DataEsito__c = system.Today();
        }
        else if(statusCaseToChiusoKO.contains(c.Status) ){//Il case è in uno stato di chiusura KO
            o1.Status = 'Chiuso';
            o1.OF_Esito__c = 'KO';
            o1.OF_DataEsito__c = system.Today();
        }
        if(c.Status != 'Cessato' && c.Status != 'Cessato OK'){
        
            //DG aggiunti campi sull'ordine per poterli gestire a livello di asset (non saranno visibili sull'ordine)
            o1.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
            o1.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
            o1.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
            o1.OF_Apparato__c = c.EOF_Apparato__c;
            o1.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
            o1.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
            o1.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;  

            //14/07/2017 modificata logica OF_profilo__c --> viene fatta una codifica presente nel custom setting OF_CodificaProfiloListini__c            
            if(c.OF_SA_Profilo__c != null){
                //27/09/2017 Modifica CRM - nel custom setting OF_CodificaProfiloListini__c viene scritto tutto il profilo e non solo le prime due lettere
                if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
                    o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).CD_ListinoCanoneName__c;
            }
            //OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
            o1.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
            o1.OF_Promozione__c = c.OF_SA_Promozione__c ;
            o1.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
            o1.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
            //END DG 31/05/2017
            
            //DG 25/05/2017 modificato il campo da cui prendere OF_EsitoConsegnaApparato__c
            //  non più da EOF_Tipo_di_intervento_aggiuntivo__c ma da OF_Esito_Consegna_Apparato__c
            o1.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
            //END DG 25/05/2017
            
            //DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
            o1.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
            o1.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            //END DG 01/06/2017
                
            //DG 23/03/2017 - Come emerso da riunione odierna i campi vanno presi dal case e non dalla network inventory
            o1.OF_IDBuilding__c = c.EOF_ID_Building_WS__c;
            o1.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
            o1.OF_Comune__c = c.EOF_Comune_WS__c;
            o1.OF_Provincia__c = c.EOF_Provincia_WS__c;
            o1.OF_ParticellaToponomastica__c = c.EOF_Particella_Toponomastica_WS__c;
            o1.OF_Indirizzo__c = c.EOF_Indirizzo_WS__c;
            o1.OF_Civico__c = c.EOF_Numero_Civico_WS__c;
            o1.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c; 
        }
        if(c.Status.equalsIgnoreCase('Espletato') ){
            //idAsset = OF_CD_CRMHandler.CreateAsset(c, o1); 
            //Vado a richiamare la nuova classe di espletamento
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(c);  
            idAsset = esplManager.espletamentoGPONP_OpenStream(o1);
            if(idAsset!=null)
            {
                //Aggiorno l'ordine
                o1.OF_Asset__c = idAsset;
                //Aggiorno il Log del Portale
                aggiornaSLogPortale(c);
            }
        }
        else if(c.Status.equalsIgnoreCase('Cessato') ){
            //ESPLETAMENTO ORDINE DI CESSAZIONE (OPERAZIONE = ESPLETAMENTO).
            //All'espletamento di un Ordine di Cessazione si devono eseguire le seguenti operazioni:
            //1.Cessazione Asset
            //2.Cessazione CE
            //TODO - Sostituire metodo disattivazione
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(c);
            esito = true;
            esplManager.cessazioneCeiGPONP_OpenStream(esito);
            //OF_CD_CRMHandler.inactivateAssetCe(c, o1);
        }
        update o1;
        return idAsset;       
    }    
    
    //Metodo richiamato dalla classe OF_SA_CD_OLO_SendToOM
    public static void manageOrderSyncChOrd(Case c){ 
        
        System.debug('<<<< Sono dentro manageOrderSyncChOrd >>>>');
        
     	//caso in cui il case è acquisito o Modificato KO (dopo controlli asincroni)
     	//in ogni caso va creato il nuovo ordine
        if(!OF_SA_CD_GE_Utils.checkRtMap){
            OF_SA_CD_GE_Utils.RtMap = new Map<String,String>();
            for( Recordtype rt : [SELECT Id,DeveloperName FROM Recordtype]){
                OF_SA_CD_GE_Utils.RtMap.put( rt.DeveloperName , rt.Id );
            }
            OF_SA_CD_GE_Utils.checkRtMap=true;
        }
        Map <string, OF_CodificaProfiloListini__c> mapCodificaProfili = OF_CodificaProfiloListini__c.getAll();

        o = new order();
        o.RecordTypeId = OF_SA_CD_GE_Utils.RtMap.get('OF_CHANGEORDER');
        
        System.debug('@@@@ EOF_Account_OLO__c: '+c.EOF_Account_OLO__c);
        
        o.AccountId = c.EOF_Account_OLO__c;
        String profiloCommerciale;
        
        System.debug('**c.OF_SA_Profilo__c ** : '+c.OF_SA_Profilo__c);
        
        if(c.OF_SA_Profilo__c != null){   
            if(mapCodificaProfili.get(c.OF_SA_Profilo__c) != null){
                o.OF_Profilo__c = mapCodificaProfili.get(c.OF_SA_Profilo__c).CD_ListinoCanoneName__c;
            }
        }
        o.EffectiveDate = System.Today();
        
        Id contractId = [SELECT OF_Contract__c 
                         FROM OF_ContrattoServizio__c  
                         WHERE OF_Contract__r.accountid=:o.AccountId 
                         AND OF_Servizio__r.name='Open Stream CD'
                         AND OF_Contract__r.Status = 'Attivo' 
                         LIMIT 1].OF_Contract__c;
        
        c.OF_IDContratto__c = contractId;
        o.ContractId = contractId;
        o.OF_CaseID__c = c.id;
        o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c; 
        o.OF_CaseNome__c = c.caseNumber;
        o.OF_TipologiaDiServizio__c = 'Change Order CD';
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.codice_ordine_EOF__c;
        o.OF_Asset__c = c.assetId;
        
        System.debug('<<<< Ordine di Change Order CD creato >>>');
        
        if(c.status.equalsIgnoreCase('Modificato KO') ){
            o.OF_Esito__c = 'KO';
            o.OF_DataEsito__c = system.Today();
	        o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
	        o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;
	        o.Status = 'Chiuso';
        } 
        else if(c.status.equalsIgnoreCase('Modificato OK') ){
            o.Status = 'Aperto';
        }
        insert o;
        c.OF_Order__c = o.Id;
        
        /*
        boolean inserito=false;
        boolean templog=false;
        Account a = new Account();	
        Templog__c t = new Templog__c();
        
        for(integer x=0; x<50; x++)
        {
            try{
            	if(x==0){
	        		insert o;
	        		c.OF_Order__c = o.id;
	        		inserito=true; 
            	}
            	//provo l'inserimento togliendo account e contract 
            	if(x==1){
	            	a.name=c.EOF_Codice_Ordine_OLO__c;
	            	a.type='Temp';
	            	insert a;
	            	o.AccountId=a.Id;
	            	o.contractId=null;
	            	o.OF_AccountTemporaneo__c=c.EOF_Account_OLO__c;
	            	o.OF_ContractTemporaneo__c=c.OF_IDContratto__c;
	            	insert o;
	            	System.debug('<<< Ordine di Change Order CD inserito >>>');
	            	c.OF_Order__c = o.Id;
	            	inserito=true;
            	}
            	//non ha funzionato quindi riprovo normalmente
            	if(x>1){
            		o.AccountId=o.OF_AccountTemporaneo__c;
            		o.contractId=o.OF_ContractTemporaneo__c;
            		o.OF_AccountTemporaneo__c=null;
            		o.OF_ContractTemporaneo__c=null;
            		insert o;
	        		c.OF_Order__c = o.id;
	        		inserito=true; 
            	}
            }  
            catch(exception e){
            	if(!templog){
            		t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','OF_ManageOrderFromCase_CD','manageOrderSyncChOrd',(x+1), e);
            		templog=true;
            	}
            	else{
            		t.OF_tentativi__c=(x+1);
            	}
            }
            if(inserito==true){
            	break;
            }
        }
        if(templog){
        	insert t;
        }
        */
     }
     
     @future 
     public static void manageOrderAsyncChOrd(String caseId){
     	
     	System.debug('<<<< Sono dentro manageOrderAsyncChOrd >>>>');
     	
     	//caso in cui vado ad aggiornare l'ordine dopo il flusso da OM
        Case c = [select id,EOF_Id_Risorsa__c,caseNumber,assetId,EOF_Account_OLO__c,status,EOF_Codice_Ordine_OLO__c,
                  codice_ordine_EOF__c,EOF_Codice_Errore__c, EOF_Causale_Errore__c, OF_SA_Profilo__c,OF_Order__c,
                  OF_Order__r.OF_Profilo__c,OF_IDContratto__c, 
                  (select id from Commercial_element_istanziati__r) 
                  from case 
                  where id=:caseId];
        
        System.debug('<<<< Change Order Case >>>> : '+c);
        
        o = new order();
        o.OF_Profilo__c = c.OF_Order__r.OF_Profilo__c;
        o.id = c.OF_Order__c;
        o.OF_DataEsito__c = System.Today();
        o.Status = 'Chiuso';
        
        if(c.status=='Modificato KO'){
            o.OF_Esito__c = 'KO';
	        o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
	        o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;
        }
        else if(c.status=='Modificato OK'){
            o.OF_Asset__c = c.assetId;
            o.OF_Esito__c = 'OK';
        }
        insert o;
        
        if(c.assetId != null){ 
            if(!test.isrunningtest()){
                OF_CD_CRMHandler.manageAssetBillingElement(c.assetId, o);
                OF_CD_CRMHandler.manageAssetVlan(c.assetId, c.Commercial_element_istanziati__r);
            }
        }
        /*
        boolean inserito = false;
        boolean templog = false;
        Account a = new Account();	
        Templog__c t = new Templog__c();
        
	   	for(integer x=0; x<50; x++){
	        try{
	        	if(x==0){
	        		update o;
	    			inserito=true;
	        	}
	        	//provo l'aggiornamento togliendo account e contract 
    			if(x==1){
	            	a.name=c.EOF_Codice_Ordine_OLO__c;
	            	a.type='Temp';
	            	insert a;
	            	o.AccountId=a.Id;
	            	o.contractId=null;
	            	o.OF_AccountTemporaneo__c=c.EOF_Account_OLO__c;
	            	o.OF_ContractTemporaneo__c=c.OF_IDContratto__c;
	            	update o;
	            	inserito=true;
            	}
            	//non ha funzionato quindi riprovo normalmente
            	if(x>1){
            		o.AccountId=o.OF_AccountTemporaneo__c;
            		o.contractId=o.OF_ContractTemporaneo__c;
            		o.OF_AccountTemporaneo__c=null;
            		o.OF_ContractTemporaneo__c=null;
	        		update o;
	    			inserito=true;
	        	}
            }
            catch(exception e){
            	if(!templog){
            		t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','OF_ManageOrderFromCase_CD','manageOrderAsync',(x+1), e);
            		templog=true;
            	}
            	else{
            		t.OF_tentativi__c=(x+1);
            	}
            }
            if(inserito==true){
            	break;
            }
        }
        if(templog){
        	insert t;
        }
        update c;
        if(c.assetId != null){ 
            if(!test.isrunningtest()){
                OF_CD_CRMHandler.manageAssetBillingElement(c.assetId, o);
                OF_CD_CRMHandler.manageAssetVlan(c.assetId, c.Commercial_element_istanziati__r);
            }
        }
        */
    }
    
    //Metodo che aggiorna il SLog del Portale post Espletamento OK
    public void aggiornaSLogPortale(Case caso_richiesta)
    {
        System.debug('<<<< Dentro aggiornaSLogPortale >>>');
        System.debug('<<<< Case >>> : '+caso_richiesta);
        
        String rTypeDevName = '';
        String tipoService = getTipologiaServizioByCaseRType(caso_richiesta);
        
        if(tipoService=='Attivo_CD') {
            rTypeDevName = 'PO_SA_CD_Log_OpenStreamRequest';
        }
        else if(tipoService=='Passivo_CD') {
            rTypeDevName = 'PO_SA_CD_Log_GPONPRequest';
        }
        System.debug('<<<< rTypeDevName >>> : '+rTypeDevName);
            
        EOF_EAI_Service_Log__c sLogPortale = [Select id, EOF_Codice_Ordine_OLO__c, RecordType.developerName, EOF_Tipo_Comunicazione__c, 
                                              EOF_Motivazione__c, EOF_ID_RISORSA__c, EOF_Data_Espletamento_Ordine__c, 
                                              EOF_NOTE__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c
                                              from EOF_EAI_Service_Log__c 
                                              where EOF_Codice_Ordine_OLO__c =: caso_richiesta.EOF_Codice_Ordine_OLO__c
                                              and EOF_Stato_Richiesta__c = 'Inserita Portale'
                                              and RecordType.DeveloperName =: rTypeDevName
                                             ];

        System.debug('<<<< Aggiornamento sLogPortale in corso... >>>');
        
        if(caso_richiesta.closedDate!=null){
            Datetime dT = caso_richiesta.closedDate;
            Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
            System.debug('<<<< Data Espletamento Ordine : >>> '+myDate);
            slogPortale.EOF_Data_Espletamento_Ordine__c = myDate;
        }
        sLogPortale.EOF_ID_RISORSA__c = caso_richiesta.EOF_Id_Risorsa__c;
        slogPortale.EOF_STATO_ORDINE__c = 'Espletato';
        slogPortale.EOF_Motivazione__c = caso_richiesta.OF_SA_Codice_Motivazione__c+' - '+caso_richiesta.OF_SA_Motivazione__c;
        slogPortale.EOF_NOTE__c = caso_richiesta.EOF_Note__c;
        
        update slogPortale;
    }
    
    //metodo per bonificare le locked row che non hanno fatto creare l'ordine
    @future(callout=true)
	public static void CreaOrdineInAsincrono(String caseId){  
		Case c = [Select Id, PO_SA_Portale__c, CaseNumber, Status, EOF_ID_Risorsa__c,Codice_ordine_Eof__c, EOF_Account_OLO__c,
                  EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,
                  EOF_Data_Notifica__c, EOF_Id_Notifica__c,recordtype.developername, 
                  EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,EOF_FASE__c,
                  EOF_GPON_Vincolante__c,OF_SA_Motivazione__c,OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, 
                  OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c ,OF_Bonifica_Locked_Row__c,assetId
                  from Case 
                  where id=:caseId];

		OF_ManageOrderFromCase_CD.manageOrderSyncChOrd(c);
		update c;
	} 
    
    /*
    //Metodo che crea il Cliente Retail
    public OF_AssetCases__c CreateClienteRetail( ID CaseId , ID AssetId ){
        try{
            OF_AssetCases__c obj = new OF_AssetCases__c();
            obj.OF_Asset__c = AssetId;
            obj.OF_Caso__c = CaseId;
            return obj;
        }
        catch(Exception e)
        {
        	OF_Utility.logMessage(true,'E','Classe: OF_ManageOrderFromCase_CD','Method:CreateClienteRetail','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());         
        	return null;
        }
    }
    */
}