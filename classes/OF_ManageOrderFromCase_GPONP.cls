public class OF_ManageOrderFromCase_GPONP {
    
    //Attributi
    //Mappa per il customSetting CodificaProfiloListini
    public Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();
    //@TestVisible private static Order o;
    public ID idAsset{set;get;}
    public Map<String, Id> rtMap;
    public Boolean checkrtMap = falsE;
    public static final String STATO_ESPLETATO = 'Espletato';
	public static final String STATO_ESPLETATO_KO = 'Espletato KO';
	public static final String FASE_ESPLETATO_OK = 'Espletato OK';
	public static final String FASE_ESPLETATO_KO = 'Espletato KO';
    
     
    public OF_ManageOrderFromCase_GPONP(){
        if(!checkrtMap){
            List<RecordType> rtList = [SELECT Id, DeveloperName FROM RecordType];
            rtMap = new Map<String, Id>(); 
            for(RecordType rt : rtList){
                rtMap.put(rt.DeveloperName, rt.Id); 
            }               
            checkrtMap = true;
        }  
    }
    //Creazione Ordine
    public Id ManageOrder(Case c){
        try{
            //Attivazione
            if( c.RecordtypeId == rtMap.get('EOF_Caso_Attivazione') || c.RecordtypeId == rtMap.get('OF_SA_Attivazione') ){             
                //Creazione Ordine
                if( (c.Status == 'Acquisito' || c.Status == 'Acquisito KO') && c.OF_Order__c == null ){
                    return creazioneOrdine( c , 'OF_INORDER'); 
                }
                if( c.Status == 'Espletato' || c.Status == 'Espletato KO' || c.Status == 'Annullato' || c.Status == 'Accettato KO' ){                
                    return AggiornoOrdine( c );
                }
            }
            //Cessazione
            if( c.RecordtypeId == rtMap.get('EOF_Caso_Cessazione') || c.RecordtypeId == rtMap.get('OF_SA_Cessazione')  ){ 
                //Creazione Ordine 
                if( ( c.Status == 'Cessato KO' || c.Status == 'Acquisito' ) && c.OF_Order__c == null ){
                    return creazioneOrdine( c , 'OF_OUTORDER');
                }
                //Aggiornamento Ordine
                if( c.Status == 'Cessato' ){
                    return AggiornoOrdine( c );
                }
            } 
        }catch(DMLException e){
            EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();
            	sLog.EOF_Tec_Eof__c = 'UNABLE_TO_LOCK';
            	sLog.EOF_Descrizione_Problema__c = 'Case Id => ' + c.Id +'\n' + e.getStackTraceString().abbreviate(3800);
            insert sLog;
        }
        
        return null;
    }
    
    public Id creazioneOrdine( Case c , String recordTypeName ){
        System.debug('*****DENTRO creazioneOrdine******');
    
        Order o = new Order();
        o.RecordTypeId = rtMap.get( recordTypeName );
        o.AccountId = c.EOF_Account_OLO__c;
        o.EffectiveDate = system.Today();
        o.OF_CaseID__c = c.id;
        o.OF_TipologiaDiServizio__c = getTipologiaServizioByCaseRType(c);
        
        if( recordTypeName == 'OF_INORDER' ){
            if( c.Status == 'Acquisito'){
                o.PO_Accordo_Operativo__c = c.Accordo_Operativo__c;
                o.Status = 'Aperto';
                //DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }else if( c.Status == 'Acquisito KO' ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_DataEsito__c = system.Today();
                o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
                o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;                 
            }
        }
        if( recordTypeName == 'OF_OUTORDER' ){
            if( c.Status == 'Cessato KO' ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_DataEsito__c = system.Today();
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }else if( c.Status == 'Acquisito'){
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
                o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
            }
        }
        //OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
        o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
        o.OF_Promozione__c = c.OF_SA_Promozione__c ;
        o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
        o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
        
        insert o;
        c.OF_Order__c = o.Id;
        if( c.Status == 'Acquisito' && recordTypeName == 'OF_OUTORDER' ){
            System.debug('***c.OF_IDContratto__c*** '+c.OF_IDContratto__c);
            //INSERIMENTO ORDINE DI CESSAZIONE (OPERAZIONE = INSERIMENTO).
            //1.Cessazione di tutti i BE sotto l'asset legato all'ordine di Cessazione
            //2.Creazione BE di Cessazione
            
            //Vado a richiamare la classe di Ruben per cessare i BEI e creare i BEI di Cessazione
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(c);            
            esplManager.cessazioneBeiGPONP_OpenStream();
        }
        return o.Id;
    }
    
    //Add by PG - 30-11 - C&D - Aggiunto RecordtypeId per OpenStream C&D
    public string getTipologiaServizioByCaseRType(case c){
        if((c.recordtypeId == rtMap.get('OF_SA_Attivazione')) || (c.recordtypeId == rtMap.get('OF_SA_Cessazione'))){                
            c.OF_Servizio__c = 'Open Stream'; 
            return 'Attivo';
        }else if( (c.recordtypeId == rtMap.get('EOF_Caso_Attivazione')) || (c.recordtypeId == rtMap.get('EOF_Caso_Cessazione'))){
            c.OF_Servizio__c = 'GPON Passiva'; 
            return 'Passivo';
        }else{
            return '';
        }
    }
    
    public Id AggiornoOrdine(case caseOrdine){
        Set<String> statusLeadToChiusoOK = new Set<String>{'Espletato', 'Cessato', 'Cessato OK'};
        Set<String> statusLeadToChiusoKO = new Set<String>{'Espletato KO', 'Annullato', 'Accettato KO', 'Cessato KO'};
        
        Order o1 = [SELECT Id, ContractId, Contract.Servizio__r.OF_Servizio_Code__c, Contract.OF_Rinnovabile__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate,
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c,
				   RecordType.Name, OF_Type__c, OF_TipologiaDiServizio__c, OF_CaseID__c, OF_CaseNome__c, PO_Accordo_Operativo__c
				   FROM Order WHERE Id = :caseOrdine.OF_Order__c LIMIT 1];

        //Il case è in uno stato di chiusura positiva
        if( statusLeadToChiusoOK.contains(caseOrdine.Status) ){
            o1.Status = 'Chiuso';
            o1.OF_Esito__c = 'OK';
            o1.OF_DataEsito__c = system.Today();
        }else if( statusLeadToChiusoKO.contains(caseOrdine.Status) ){//Il case è in uno stato di chiusura KO
            o1.Status = 'Chiuso';
            o1.OF_Esito__c = 'KO';
            o1.OF_DataEsito__c = system.Today();
        }
        if(caseOrdine.Status != 'Cessato' && caseOrdine.Status != 'Cessato OK'){           
            o1.OF_IDOrdineOLO__c = caseOrdine.EOF_Codice_Ordine_OLO__c; // billing
            o1.OF_IDRisorsa__c = caseOrdine.EOF_Id_Risorsa__c;
            o1.OF_GPONAttestazione__c = caseOrdine.EOF_GPON_Attestazione__c;
            o1.OF_SlaPremiumAssurance__c = caseOrdine.EOF_SLA_Premium_Assurance__c;
            o1.OF_Apparato__c = caseOrdine.EOF_Apparato__c;
            o1.OF_ProgettoSpeciale__c = caseOrdine.EOF_Progetto_Speciale__c;
            o1.OF_TipologiaApparato__c = caseOrdine.EOF_Tipologia_Apparato__c;
            o1.OF_PasswordApparato__c = caseOrdine.EOF_Password_Apparato__c;
            o1.OF_EsitoConsegnaApparato__c = caseOrdine.OF_Esito_Consegna_Apparato__c;
            o1.OF_IDBuilding__c = caseOrdine.EOF_ID_Building_WS__c;
            o1.OF_IdentificativoDelPOP__c = caseOrdine.EOF_Identificativo_del_POP__c;
            o1.OF_Comune__c = String.isNotBlank(caseOrdine.PO_Comune__c) ? caseOrdine.PO_Comune__c : String.isNotBlank(caseOrdine.EOF_Comune_WS__c) ? caseOrdine.EOF_Comune_WS__c : caseOrdine.EOF_Istat_Comune__c;
            o1.OF_Provincia__c = String.isNotBlank(caseOrdine.EOF_Provincia_WS__c) ? caseOrdine.EOF_Provincia_WS__c : caseOrdine.EOF_Istat_Provincia__c;
            o1.OF_ParticellaToponomastica__c = caseOrdine.EOF_Particella_Toponomastica_WS__c;
            o1.OF_Indirizzo__c = String.isNotBlank(caseOrdine.PO_Indirizzo_collegamento__c) ? caseOrdine.PO_Indirizzo_collegamento__c : caseOrdine.EOF_Indirizzo_WS__c;
            o1.OF_Civico__c = String.isNotBlank(caseOrdine.PO_Civico__c) ? caseOrdine.PO_Civico__c : caseOrdine.EOF_Numero_Civico_WS__c;
            o1.OF_ScalaPalazzina__c = caseOrdine.EOF_Scala_Palazzina_WS__c;
            if (caseOrdine.OF_SA_Profilo__c != null) {
                Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
                OF_CodificaProfiloListini__c cpl = mapCodifica.get(caseOrdine.OF_SA_Profilo__c);
                if (cpl != null) {
                    o1.OF_Profilo__c = cpl.OF_ListinoCanoneName__c;
                }
            }
            o1.OF_ProfiloOpenStream__c = caseOrdine.OF_SA_Profilo__c;
            o1.OF_Promozione__c = caseOrdine.OF_SA_Promozione__c;
            o1.OF_CodiceProgettoSpeciale__c = caseOrdine.OF_SA_CODICE_PROGETTO_SPECIALE__c;
            o1.OF_ClusterPromozione__c = caseOrdine.OF_SA_Cluster_Promozione__c;
            o1.OF_CodiceKO__c = caseOrdine.OF_SA_Codice_Motivazione__c;
            o1.OF_DescrizioneKO__c = caseOrdine.OF_SA_Motivazione__c;
        }
        /**Gestione Servizi **/
        if(caseOrdine.Status == 'Cessato' || caseOrdine.Status == 'Cessato KO' ||  caseOrdine.Status == 'Cessato OK'){
            Boolean esito = (caseOrdine.Status == 'Cessato' ||  caseOrdine.Status == 'Cessato OK') ? true : false;
            //Vado a richiamare la nuova classe di espletamento
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(caseOrdine);        
            //Il booleano andrà a filtrare l'espletamento positivo da quello KO    
            esplManager.cessazioneCeiGPONP_OpenStream(esito);
        }else if(caseOrdine.Status == 'Espletato'){
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(caseOrdine);
            //Aggiorno il case
            caseOrdine.Status = STATO_ESPLETATO; 
            caseOrdine.EOF_Fase__c = FASE_ESPLETATO_OK;
            //Espletato ok
            idAsset=esplManager.espletamentoGPONP_OpenStream(o1);
        }else if('Espletato KO'.equalsIgnoreCase(caseOrdine.Status)){
            //OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(caseOrdine);
            //Aggiorno il case
            caseOrdine.Status = STATO_ESPLETATO_KO;
            caseOrdine.EOF_Fase__c = FASE_ESPLETATO_KO;
            //Espletato KO
            //esplManager.espletamentoGPONP_OpenStream(o1);
        }
        update o1;    
        return idAsset;       
    }    
}