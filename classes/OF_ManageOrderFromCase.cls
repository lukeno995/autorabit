public class OF_ManageOrderFromCase{
    
    //Mappa per il customSetting CodificaProfiloListini
    public Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();
    //Mappa di Recordtype per Case e Order
    public static final String STATO_ESPLETATO = 'Espletato';
	public static final String STATO_ESPLETATO_KO = 'Espletato KO';
	public static final String FASE_ESPLETATO_OK = 'Espletato OK';
	public static final String FASE_ESPLETATO_KO = 'Espletato KO';
    public ID idAsset{set;get;}
    
    //Costruttore
    public OF_ManageOrderFromCase(){
        mapCodifica = OF_CodificaProfiloListini__c.getAll();
        
        if(!OM_GW_GE_Utils.checkRtMap){
        	OM_GW_GE_Utils.RtMap = new Map<String,String>();
	        for( Recordtype rt : [SELECT Id, DeveloperName FROM Recordtype]){
	            OM_GW_GE_Utils.RtMap.put( rt.DeveloperName , rt.Id );
	        }
	        OM_GW_GE_Utils.checkRtMap=true;
        }
    }
    //Creazione Ordine
    public Id ManageOrder( Case c ){
        try{
        	//Attivazione
            if( c.RecordtypeId == OM_GW_GE_Utils.RtMap.get('EOF_Caso_Attivazione' ) ){         
                //Creazione Ordine
                if( (c.Status == 'Acquisito' || c.Status == 'Acquisito KO') && c.OF_Order__c == null ){
                    return creazioneOrdine( c , 'OF_INORDER'); 
                }            
                //Aggiornamento Ordine
                if( c.Status == 'Espletato' || c.Status == 'Espletato KO' || c.Status == 'Annullato' || c.Status == 'Accettato KO' ){
                    return AggiornoOrdine( c );
                }
            }
            if( c.RecordTypeId == OM_GW_GE_Utils.RtMap.get( 'EOF_Caso_Cessazione' )){
                //Creazione Ordine 
                if( ( c.Status == 'Cessato KO' || c.Status == 'Acquisito' ) && c.OF_Order__c == null ){
                    return creazioneOrdine( c , 'OF_OUTORDER');
                }
                //Aggiornamento Ordine
                if( c.Status == 'Cessato OK' ||  c.Status == 'Cessato' ||  c.Status == 'Annullato' ){
                    return AggiornoOrdine( c );
                }        
            }   
        }catch(DMLException e){
            EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();
            	sLog.EOF_Tec_Eof__c = 'UNABLE_TO_LOCK';
            	sLog.EOF_Descrizione_Problema__c = 'Case Id => ' + c.Id +'\n' + e.getStackTraceString().abbreviate(4000);
            insert sLog;
        }
        
        return null;
    }
    public Id creazioneOrdine( Case c , String recordTypeName ){
        Order o = new Order();
        o.RecordTypeId = OM_GW_GE_Utils.RtMap.get( recordTypeName );
        o.AccountId = c.EOF_Account_OLO__c;
        o.EffectiveDate = system.Today();
        o.OF_CaseID__c = c.id;
        o.OF_TipologiaDiServizio__c = getTipologiaServizioByCaseRType(c);
         
        //ORDINI DI ATTIVAZIONE
        if( recordTypeName == 'OF_INORDER' ){
            if( c.Status == 'Acquisito'){
                o.Status = 'Aperto';
                //DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }else if( c.Status == 'Acquisito KO' ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
                o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c; 
                o.OF_DataEsito__c=system.today();
            }
        }
        //ORDINE DI CESSAZIONE
        if( recordTypeName == 'OF_OUTORDER' ){
            if( c.Status == 'Cessato KO' ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
                o.OF_DataEsito__c=system.today();
            }else if( c.Status == 'Acquisito'){
                o.Status = 'Aperto';
                o.OF_Esito__c = 'OK';                    
            }
            o.OF_Asset__c = c.assetId;
            //o.AccountId = c.EOF_Account_OLO__c;
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
            if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
                o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
        }         
        o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
        o.OF_Promozione__c = c.OF_SA_Promozione__c ;
        o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
        o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;                    
        
        insert o;
        c.OF_Order__c = o.Id;
        
        //Apertura di un Case di Cessazione in Acquisito
        if( c.Status == 'Acquisito' && recordTypeName == 'OF_OUTORDER' ){
            //Il seguente metodo si occupa di:
            // 1. Creare i BE di Cessazione ( con le rispettive Date di Attivazione )
            // 2. Cessare tutti i BE che sono attivi ( Mettendo il flag isActive = false , popolando la Data di Cessazione )

            //DONE AA - SOSTITUIRE CON NUOVO METODO CESSAZIONE!!!            
            //GestioneServiziPassiviCessazione( c , o , 1 );
            //Vado a richiamare la nuova classe di espletamento per cessare i BEI e creare i BEI di Cessazione
            OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(c);            
            esplManager.cessazioneBeiGPONP_OpenStream();
        }
        return o.Id;
    }
    public string getTipologiaServizioByCaseRType(case c){
        if( (c.recordtypeId == OM_GW_GE_Utils.RtMap.get('EOF_Caso_Attivazione')) || (c.recordtypeId == OM_GW_GE_Utils.RtMap.get('EOF_Caso_Cessazione')) ){
            c.OF_Servizio__c = 'GPON Passiva';
            return 'Passivo';
        }
        return null;         
    }
    public Id AggiornoOrdine(Case caseOrdine){
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
				   FROM Order 
                   WHERE Id = :caseOrdine.OF_Order__c LIMIT 1];
            
        if( statusLeadToChiusoOK.contains(caseOrdine.Status) ){
            o1.Status = 'Chiuso';
            o1.OF_Esito__c = 'OK';
            o1.OF_DataEsito__c = system.Today();
        }else if( statusLeadToChiusoKO.contains(caseOrdine.Status) ){//Il case è in uno stato di chiusura KO
            o1.Status = 'Chiuso';
            o1.OF_Esito__c = 'KO';
        }      
        o1.OF_DataEsito__c = System.Today();
        // 03/10/2018 MM : aggiunta salvataggio campi ID SPLITTER SECONDARIO e POSIZIONE SPLITTER SECONDARIO sull'oggetto Ordine
        o1.OF_IDSplitterSecondario__c= caseOrdine.EOF_ID_Splitter_Secondario__c;
        o1.OF_PosizioneSplitterSecondario__c = caseOrdine.EOF_Posizione_Splitter_Secondario__c;
        // 03/10/2018 MM : fine aggiunta
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

        if(caseOrdine.Status == 'Cessato' || caseOrdine.Status == 'Cessato KO' ||  caseOrdine.Status == 'Cessato OK'){
            Boolean esito = (caseOrdine.Status == 'Cessato' ||  caseOrdine.Status == 'Cessato OK') ? true : false;
            //Vado a richiamare la nuova classe di espletamento
            /* Done OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(caseOrdine);        
            //Il booleano andrà a filtrare l'espletamento positivo da quello KO    
            esplManager.cessazioneCeiGPONP_OpenStream(esito);*/
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
            idAsset=esplManager.espletamentoGPONP_OLD(o1);
        }else if('Espletato KO'.equalsIgnoreCase(caseOrdine.Status)){
            //OF_Espletamento_Generico_AP esplManager = new OF_Espletamento_Generico_AP(caseOrdine);
            //Aggiorno il case
            caseOrdine.Status = STATO_ESPLETATO_KO;
            caseOrdine.EOF_Fase__c = FASE_ESPLETATO_KO;
            //Espletato KO
            //esplManager.espletamentoGPONP_OLD(o1);
        }
        update o1;    
        return idAsset;    
    }    
}