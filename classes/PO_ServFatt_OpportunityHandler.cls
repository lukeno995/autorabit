public class PO_ServFatt_OpportunityHandler {
    
    public static final String OFFERTA_TOTALE_FLEASE_MISTA_RT = 'PO_Oppty_Richiesta_fattibilit_Misto_Lease_Link_per_FW';
    public static final String OFFERTA_COLLEGAMENTO_FLEASE_MISTA_RT = 'PO_Oppty_Misto_Lease_Link_per_FW';
    // commercial element name
    public static final String SEDE_E_ACCESS = 'Sede E-Access';
    public static final String KIT_E_ACCESS = 'KIT E-Access';
    public static final String SATELLITE_E_LINE = 'Sede Satellite E-Line';
    public static final String MASTER_E_LINE = 'Sede Master E-Line';
    public static final String P2P_ATTIVA = 'P2P Attiva';
    public static Boolean checkParentRecalculation = false;
    public static Case billingCity;
    /**
* Mappa per recuperare l'Id del RecordType tramite il suo DeveloperName
*/
    private static Map<String, Id> rtDevNameIdMap = null;
    
    /**
* Mappa per recuperare il DeveloperName del RecordType tramite il suo Id
*/
    private static Map<Id, String> rtIdDevNameMap = null;
    
    
    private static void initializeRecordTypeMap() {
        PO_ServFatt_OpportunityHandler.rtDevNameIdMap = new Map<String, Id>();
        PO_ServFatt_OpportunityHandler.rtIdDevNameMap = new Map<Id, String>();
        for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType]) {
            PO_ServFatt_OpportunityHandler.rtDevNameIdMap.put(rt.DeveloperName, rt.Id);
            PO_ServFatt_OpportunityHandler.rtIdDevNameMap.put(rt.Id, rt.DeveloperName);
        }
    }
    
    public static Map<String, Id> getRtDevNameIdMap() {
        if (PO_ServFatt_OpportunityHandler.rtDevNameIdMap == null) {
            PO_ServFatt_OpportunityHandler.initializeRecordTypeMap();
        }
        return PO_ServFatt_OpportunityHandler.rtDevNameIdMap;
    }
    
    public static Map<Id, String> getRtIdDevNameMap() {
        if (PO_ServFatt_OpportunityHandler.rtIdDevNameMap == null) {
            PO_ServFatt_OpportunityHandler.initializeRecordTypeMap();
        }
        return PO_ServFatt_OpportunityHandler.rtIdDevNameMap;
    }
    
    public static void setProfile(Case c, String srvName) {
        if ('P2P Base'.equalsIgnoreCase(srvName)) {
            PO_ServFatt_OpportunityHandler.setProfileP2PBase(c, srvName);
        }
    }
    
    @TestVisible
    private static void setProfileP2PBase(Case caseCollegamento, String srvName) {
        if (!'P2P Base'.equalsIgnoreCase(srvName)) {
            return;
        }
        System.debug('P2P Base - num fibre richieste: ' + caseCollegamento.PO_Numero_fibre_richieste__c);
        
        Decimal fibreRichieste = 1;
        try {
            fibreRichieste = Decimal.valueOf(caseCollegamento.PO_Numero_fibre_richieste__c);
        } catch (Exception e) {
            System.debug('setProfileP2PBase Error: fibre richieste non è un valore numerico');
        }
        
        if (fibreRichieste == 1) {
            caseCollegamento.OF_SA_Profilo__c = 'P2PBase_Mono';
        } else if (fibreRichieste == 2) {
            caseCollegamento.OF_SA_Profilo__c = 'P2PBase_Bi';
        }
    }
    
    
    //FF Circuiti Diretti
    
    
    public static List<Opportunity> createOppChild(List<Case> caseColl) {
        List<OF_Listino__c> listini = PO_ServFatt_OpportunityHandler.getListinoForCase(caseColl[0]);
        String srvName = '';
        Set<Id> listiniIds = new Set<Id>();
        Decimal contributoAttivazioneCollegamento = 0.0;
        Decimal corrispettivo_IRU = 0.0;
        for (OF_Listino__c l : listini) {
            listiniIds.add(l.Id);
            srvName = l.Servizio__r.Name;
        }
        System.debug('PO_ServFatt_OpportunityHandler.createOppChild - srvName: ' + srvName);
        ServFattList__c cs = ServFattList__c.getAll().get(srvName);
        Map<String, Id> devNameIdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
        List<Opportunity> oppToAdd = new List<Opportunity>();
        
        //recupero le informazioni necessarie dai case
        List<Case> caseColl2 = [select accountId,id,Billing_Competence__c,PO_Richiesta_a_fattibilit__r.PO_Offerta__c,PO_Lunghezza_tratta_prima_via__c,PO_Costi_aggiuntivi_collegamento__c,PO_Costo_lavori_civili__c,PO_Costo_lavori_ottici__c from Case where id in :caseColl];
		
		Set<String> beNames = new Set<String>(cs.attBeList__c.split(','));
        
        //Modifica Billing_Competence__c limitata momentaneamente al solo Servizio FIber Link
        if ('Fiber Link'.equalsIgnoreCase(caseColl2[0].PO_Richiesta_a_fattibilit__r.PO_Offerta__c)) {
            //Valorizzo billingCToEsclude con il valore da escludere in pbList nella query seguente
            String billingCToEsclude = caseColl2[0].Billing_Competence__c == 'Anticipato' || caseColl2[0].Billing_Competence__c == null ? 'Canone Posticipato' : 'Canone';
            beNames.remove(billingCToEsclude);
        }

        List<Pricebook2> pbList = [SELECT Id, Name, Unit_Price__c, PO_Commercial_element__r.Name, OF_Listino__r.Name FROM Pricebook2
                                   WHERE IsActive = true 
                                   AND Unit_Price__c != null 
                                   AND PO_Commercial_element__c != null 
                                   AND OF_Listino__c IN :listiniIds AND Name IN :beNames];
        
        for (Case c : caseColl2) {
            Opportunity o = new Opportunity();
            o.CloseDate = System.today().addDays(150);
            o.name = cs.oppChildName__c;
            o.StageName='Prospecting';
            o.recordtypeId = devNameIdMap.get(cs.oppChildDevName__c);
            o.AccountId = c.accountId;
            o.PO_Collegamento__c = c.Id;
            PO_ServFatt_OpportunityHandler.setCurrencyFieldsToZero(o, false);
            
            // TODO: da modificare per adeguarlo ai BE corretti
            for (Pricebook2 pb : pbList) {
                if (pb.Name.equals('Corrispettivo IRU')) {
                    corrispettivo_IRU = pb.Unit_Price__c;
                } else if (pb.Name.equals('Contributo Attivazione')) {
                    contributoAttivazioneCollegamento = pb.Unit_Price__c;
                }
            }
            
            Decimal lunghezzaTrattaPrimaVia = (c.PO_Lunghezza_tratta_prima_via__c == null) ? 0 : c.PO_Lunghezza_tratta_prima_via__c;
            o.PO_Canone_manutenzione_collegamento__c = lunghezzaTrattaPrimaVia * corrispettivo_IRU * 0.03; //3% del corrispettivo IRUo.PO_Corrispettivo_IRU__c = c.PO_Lunghezza_tratta_prima_via__c * corrispettivo_IRU;  //prezzo da listino * PO_Lunghezza_tratta_prima_via__c
            o.PO_Corrispettivo_IRU__c = lunghezzaTrattaPrimaVia * corrispettivo_IRU;  //prezzo da listino * PO_Lunghezza_tratta_prima_via__c
            o.PO_CostiAggiuntiviCollegamento__c = c.PO_Costi_aggiuntivi_collegamento__c; //da collegamento
            o.PO_Contributo_attivazione_collegamento__c = contributoAttivazioneCollegamento; //prezzo da listino
            
            Decimal costiAggiuntivi = (c.PO_Costi_aggiuntivi_collegamento__c > c.PO_Costo_lavori_civili__c) ? c.PO_Costi_aggiuntivi_collegamento__c : c.PO_Costo_lavori_civili__c + c.PO_Costo_lavori_ottici__c;
            if (costiAggiuntivi > 0) {
                o.PO_CostiAggiuntiviCollegamento__c = costiAggiuntivi;
                o.PO_Costi_Aggiuntivi_Anno1__c = costiAggiuntivi;
                o.PO_Costi_Aggiuntivi_Anno2__c = costiAggiuntivi;
                o.PO_Costi_Aggiuntivi_Anno3__c = costiAggiuntivi;
                o.PO_CostiCollegamento__c = costiAggiuntivi;
            }
            
            oppToAdd.add(o);
        }
        
        insert oppToAdd;
        
        PO_ServFatt_OpportunityHandler.createOppLineItems(oppToAdd, pbList);
        
        return oppToAdd;
    }
    
    private static List<OpportunityLineItem> createOppLineItems(List<Opportunity> offerteCollamento, List<Pricebook2> pbs) {
        System.debug('createOppLineItems START - offerteCollamento.size: ' + offerteCollamento.size());
        List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>();
        Id pbeDefId = [SELECT Id FROM PriceBookEntry WHERE PriceBook2.Name = 'SERV_FATT_APPOGGIO' AND Product2.Name = 'SERV_FATT_APPOGGIO' LIMIT 1].Id;
        for (Opportunity o : offerteCollamento) {
            for (Pricebook2 pb: pbs) {
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = o.Id;
                oli.Quantity = 1;
                oli.Price_Book__c = pb.Id;
                oli.PriceBookEntryId = pbeDefId;
                oli.PO_SalesPrice__c = pb.Unit_Price__c;
                oli.Description = pb.OF_Listino__r.Name;
                //FD 2019-02-22 Logiche Pricing - start
                if ('Contributo Aggiuntivo'.equals(pb.Name)) {
                    oli.UnitPrice = o.PO_CostiAggiuntiviCollegamento__c;
                } else if ('Corrispettivo IRU'.equals(pb.Name)) {
                    oli.UnitPrice = o.PO_Corrispettivo_IRU__c;
                } else if ('Contributo Attivazione'.equals(pb.Name)) {
                    oli.UnitPrice = o.PO_Contributo_attivazione_collegamento__c;
                } else if ('Canone Manutenzione'.equals(pb.Name)) {
                    oli.UnitPrice = o.PO_Canone_manutenzione_collegamento__c;
                }else {
                    oli.UnitPrice = pb.Unit_Price__c;
                }
                //FD 2019-02-22 Logiche Pricing - end
                oppLineItemList.add(oli);
            }
        }
        if (!oppLineItemList.isEmpty()) {
            insert oppLineItemList;
        }
        System.debug('CreateOppLineItems END');
        return oppLineItemList;
    }
    
    public static Opportunity createOppParent(Case padre, List<Case> figli) {
        System.debug('PO_ServFatt_OpportunityHandler.createOppParent - CaseP: ' + padre.Id + ' - ChildSize: ' + figli.size());
        ServFattList__c cs = ServFattList__c.getAll().get(padre.PO_Offerta__c);
        Opportunity o = new Opportunity();
        o.CloseDate = System.today().addDays(150);
        o.name = cs.oppParentName__c;
        o.StageName = cs.oppParentStageName__c;
        o.AccountId = padre.AccountId;
        o.PO_Richiesta_fattibilit__c = padre.Id;
        
        Map<String, Id> devNameIdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
        o.recordtypeId = devNameIdMap.get(cs.oppParentDevName__c);
        
        
        List<opportunity> oppChildList = [SELECT Id, PO_Canone_collegamento__c, PO_CostiCollegamento__c, PO_Contributo_attivazione_collegamento__c, PO_Canone_manutenzione_collegamento__c, PO_Corrispettivo_IRU__c,
                                          PO_CostiAggiuntiviCollegamento__c, PO_Canone_annuo_1anno__c, PO_Contributo_attivazione_1anno__c, PO_Costi_Aggiuntivi_Anno1__c,
                                          PO_Canone_annuo_2anni__c, PO_Contributo_attivazione_2anni__c, PO_Costi_Aggiuntivi_Anno2__c,
                                          PO_Canone_annuo_3anni__c, PO_Contributo_attivazione_3anni__c, PO_Costi_Aggiuntivi_Anno3__c,
                                          PO_Valore_medio_annuo_altre_coppie__c, PO_Valore_medio_annuo_totale__c, PO_Valore_totale_prima_coppia_fino_2030__c,
                                          PO_Canone_annuo_AltriAnni__c, PO_Contributo_attivazione_altri_anni__c, PO_Costi_Aggiuntivi_Altri_Anni__c
                                          FROM Opportunity WHERE PO_Incluso_nell_offerta__c = TRUE AND PO_Collegamento__c IN :figli];
        
        calculateParentOpp(o, oppChildList);
        
        o.StageName ='Offerta accettata';
        
        insert o;
        
        for (Opportunity opp : oppChildList) {
            opp.PO_Offerta_totale__c = o.Id;
        }
        
        update oppChildList;
        return o;
    }
    
    
    public static List<OF_Listino__c> getListinoFromContractEline(String idContr, String profilo, String srvName, String opticalRateLimit ) {
          if (String.isBlank(idContr)) {
            return null;
        }
        System.debug('@@opticalRateLimit'+opticalRateLimit);
        Id idSrv = [SELECT OF_Servizio__c FROM OF_ContrattoServizio__c WHERE OF_Servizio__r.Name = :srvName AND OF_Contract__c = :idContr LIMIT 1].OF_Servizio__c;
        System.debug('Servizio [' + idSrv + '] - Contratto: ' + idContr);
        System.debug('Profilo [' + profilo + ']');
        String listinoName = '';
        if (String.isNotBlank(profilo)) {
            Map<String, OF_CodificaProfiloListini__c> mapProfili = OF_CodificaProfiloListini__c.getAll();
            OF_CodificaProfiloListini__c p = mapProfili.get(profilo);
            listinoName = p.OF_ListinoCanoneName__c;
        }
        
        System.debug('@@@@listinoName: ' + listinoName);
        List<String> nomiListini = listinoName.split(',');
        
        List<OF_Listino__c> listini = new List<OF_Listino__c>();
        
        
        if (String.isNotBlank(listinoName)) {
            //LM 
            if(srvName =='P2P Attiva'){
                if(String.isNotBlank(opticalRateLimit)){
                    System.debug('@@opticalRateLimit'+opticalRateLimit);
                    if(opticalRateLimit =='1 GB'){
                        listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND Servizio__r.Name = :srvName AND Name  = 'P2PAttiva_1G' ];
                        System.debug('@@listini'+listini);
                    }else if(opticalRateLimit =='10 GB'){
                        listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND Servizio__r.Name = :srvName AND Name  = 'P2PAttiva_10G' ];
                    }
                }
                else{
                    System.debug('@@else p');
                    listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND Servizio__c = :idSrv AND Name IN :nomiListini];
                }
            }
            else{
                System.debug('@@else nop2pattiva');
                listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND Servizio__c = :idSrv AND Name IN :nomiListini];
            }
        } 
        else {
            listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND OF_ListinoDefault__c = true AND Servizio__c = :idSrv LIMIT 1];
        }
        System.debug('@@listiniMethod'+listini);
        return listini;
    }

    
    
    //FF FINE Circuiti Diretti
    
    public static List<OF_Listino__c> getListinoFromContract(String idContr, String profilo, String srvName ) {
       if (String.isBlank(idContr)) {
			return null;
		}

		Id idSrv = [SELECT OF_Servizio__c FROM OF_ContrattoServizio__c WHERE OF_Servizio__r.Name = :srvName AND OF_Contract__c = :idContr LIMIT 1].OF_Servizio__c;
		System.debug('Servizio [' + idSrv + '] - Contratto: ' + idContr);
		System.debug('Profilo [' + profilo + ']');
		String listinoName = '';
		if (String.isNotBlank(profilo)) {
			Map<String, OF_CodificaProfiloListini__c> mapProfili = OF_CodificaProfiloListini__c.getAll();
			OF_CodificaProfiloListini__c p = mapProfili.get(profilo);
			listinoName = p.OF_ListinoCanoneName__c;
		}

		System.debug('listinoName: ' + listinoName);
		List<String> nomiListini = listinoName.split(',');

		List<OF_Listino__c> listini = null;
		if (String.isNotBlank(listinoName)) {
			listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND Servizio__c = :idSrv AND Name IN :nomiListini];
		} else {
			listini = [SELECT Id, Servizio__r.Name FROM OF_Listino__c WHERE OF_Attivo__c = true AND OF_ListinoDefault__c = true AND Servizio__c = :idSrv LIMIT 1];
		}
		return listini;
    }
    
    public static List<OF_Listino__c> getListinoForCase(Case c) {
        System.debug('getListinoForCase START - Case: ' + c.Id);
        List<OF_Listino__c> listini = new List<OF_Listino__c>();
        String opticalRateLimit='' ; 
        Case parent =null;
        String idContr = String.isNotBlank(c.OF_IDContratto__c) ? c.OF_IDContratto__c : c.PO_Accordo_Quadro__c;
        System.debug('@@idContr'+idContr);
        System.debug('@@c.ParentId'+c.ParentId);
        if (String.isBlank(idContr) && String.isNotBlank(c.ParentId)) {
            parent = [SELECT Id,PO_P2PAttiva_KIT_OpticalRateLimiting__c, OF_IDContratto__c, PO_Accordo_Quadro__c, OF_Order__c, OF_Order__r.ContractId,Tipologia_Sede__c FROM Case WHERE Id = :c.ParentId LIMIT 1];
            idContr = String.isNotBlank(parent.PO_Accordo_Quadro__c) ? parent.PO_Accordo_Quadro__c : parent.OF_IDContratto__c;
            if (String.isBlank(idContr) && String.isNotBlank(parent.OF_Order__c)) {
                idContr = parent.OF_Order__r.ContractId;
            }
        }
        if (String.isBlank(idContr)) {
            System.debug('Nessun contratto per il Case: ' + c.Id);
            return listini; 
        }
        RecordType  rt = [select id,DeveloperName from RecordType where id = :c.RecordTypeId];
        if (String.isNotBlank(idContr) && String.isNotBlank(c.ParentId)) {
            if(rt.DeveloperName=='PO_Collegamento_P2P_Attiva_ELine'){
                System.debug('@@parent.Tipologia_Sede__c else ');
                parent = [SELECT Id,PO_P2PAttiva_KIT_OpticalRateLimiting__c, OF_IDContratto__c, PO_Accordo_Quadro__c, OF_Order__c, OF_Order__r.ContractId,Tipologia_Sede__c FROM Case WHERE Id = :c.id LIMIT 1];
                System.debug('@@parent.Tipologia_Sede__c'+parent.Tipologia_Sede__c);
                if(parent.Tipologia_Sede__c == 'Master'){
                    System.debug('@@Master');
                    opticalRateLimit = String.isNotBlank(parent.PO_P2PAttiva_KIT_OpticalRateLimiting__c) ? parent.PO_P2PAttiva_KIT_OpticalRateLimiting__c : '';
                    System.debug('@@opticalRateLimit'+opticalRateLimit);
                }
            }
        }
        String srvName = String.isNotBlank(c.PO_Offerta__c) ? c.PO_Offerta__c : c.PO_Tipologia_Offerta__c;
        System.debug('getListinoForCase - srvName: ' + srvName);
        PO_ServFatt_OpportunityHandler.setProfile(c, srvName);
        if(rt.DeveloperName=='PO_Collegamento_P2P_Attiva_ELine'){
            listini = PO_ServFatt_OpportunityHandler.getListinoFromContractEline(idContr, c.OF_SA_Profilo__c, srvName,opticalRateLimit);
        }else{
            listini = PO_ServFatt_OpportunityHandler.getListinoFromContract(idContr, c.OF_SA_Profilo__c, srvName);
        }
        System.debug('Listini size [' + listini.size() + '] - Case: ' + c.Id);
        return listini;
    }
    
    @TestVisible
    private static Pricebook2 removePBKit(List<Pricebook2> pbList, String srvName) {
        Pricebook2 pbKit = null;
        if (!'P2P Attiva'.equalsIgnoreCase(srvName) || (pbList == null) || pbList.isEmpty()) {
            return pbKit;
        }
        
        Integer len = pbList.size();
        for (Integer i = 0; i < len; i++) {
            Pricebook2 pb = pbList.get(i);
            if ('KIT di consegna'.equals(pb.PO_Commercial_element__r.Name) || KIT_E_ACCESS.equals(pb.PO_Commercial_element__r.Name) ) {
                pbKit = pb;
                pbList.remove(i);
                break;
            }
        }
        
        return pbKit;
    }
    
    /**
* Calcola il listino del terzo anno per Fiber Link e recupera
* i suoi PriceBook associati ai BE Canone e Contributo Attivazione.
*/
    private static List<Pricebook2> getFiberLinkMistoPB(Case caseCollegamento) {
        // Recupera il servizio Fiber Link associato all'account (che in teoria dovrebbe appartenere allo stesso catalogo)
        List<OF_ContrattoServizio__c> listIdServ = [SELECT OF_Servizio__c FROM OF_ContrattoServizio__c WHERE OF_Servizio__r.Name = 'Fiber Link' AND OF_Contract__r.AccountId = :caseCollegamento.AccountId LIMIT 1];
        if (listIdServ.isEmpty()) {
            String msg = 'ERRORE: nessun servizio Fiber Link per l\'account [' + caseCollegamento.AccountId + '] - Case: ' + caseCollegamento.Id;
            System.debug(LoggingLevel.ERROR, 'PO_ServFatt_OpportunityHandler.getFiberLinkMistoPB - ' + msg);
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage(msg);
            throw e;
        }
        
        // Calcola il listino giusto del TERZO anno di Fiber Link
        String listinoName = PO_Serv_FiberLink_Riepilogo_Controller.calcolaListiniFL(caseCollegamento.PO_Tipo_percorso__c, String.valueOf(caseCollegamento.PO_Numero_fibre_richieste__c), caseCollegamento.PO_Lunghezza_tratta_prima_via__c, '3');
        if (PO_Serv_FiberLink_Riepilogo_Controller.LISTINO_KO.equals(listinoName)) {
            String msg = 'ERRORE: nessun listino Fiber Link valido per il Case: ' + caseCollegamento.Id;
            System.debug(LoggingLevel.ERROR, 'PO_ServFatt_OpportunityHandler.getFiberLinkMistoPB - ' + msg);
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage(msg);
            throw e;
        }
        
        // Recupera i PB per Canone e Contributo Attivazione
        List<Pricebook2> pbList = [SELECT Id, Name, Unit_Price__c, PO_Commercial_element__r.Name, OF_Listino__r.Name FROM Pricebook2
                                   WHERE IsActive = true AND Unit_Price__c != null AND PO_Commercial_element__c != null AND OF_Listino__r.Servizio__c = :listIdServ.get(0).OF_Servizio__c AND OF_Listino__r.Name = :listinoName AND Name IN ('Canone', 'Contributo Attivazione')];
        
        System.debug(logginglevel.INFO, 'PO_ServFatt_OpportunityHandler.getFiberLinkMistoPB - pbList.size = ' + pbList.size());
        return pbList;
    }
    
    public static Opportunity createOppChild(Case caseColl) {
        System.debug('PO_ServFatt_OpportunityHandler.createOppChild - Case: ' + caseColl.Id);
        List<OF_Listino__c> listini = PO_ServFatt_OpportunityHandler.getListinoForCase(caseColl);
        String srvName = '';
        Set<Id> listiniIds = new Set<Id>();
        for (OF_Listino__c l : listini) {
            listiniIds.add(l.Id);
            srvName = l.Servizio__r.Name;
        }
        System.debug('PO_ServFatt_OpportunityHandler.createOppChild - srvName: ' + srvName);
        Boolean misto = 'Fiber Lease'.equalsIgnoreCase(caseColl.PO_Offerta__c) && caseColl.PO_Drop_FL_1__c;
        ServFattList__c cs = ServFattList__c.getAll().get(srvName);
        Map<String, Id> devNameIdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
        
        Opportunity o = new Opportunity();
        o.CloseDate = System.today().addDays(150);
        o.name = cs.oppChildName__c;
        o.StageName = cs.oppChildStageName__c;
        o.recordtypeId = !misto ? devNameIdMap.get(cs.oppChildDevName__c) : devNameIdMap.get(OFFERTA_COLLEGAMENTO_FLEASE_MISTA_RT);
        o.AccountId = caseColl.accountId;
        o.PO_Collegamento__c = caseColl.Id;
        PO_ServFatt_OpportunityHandler.setCurrencyFieldsToZero(o, false);
        //o.PO_CostiCollegamento__c = 0.0;
        
        Set<String> beNames = new Set<String>(cs.attBeList__c.split(','));
        
        //Modifica Billing_Competence__c limitata momentaneamente al solo Servizio FIber Link
        if ('Fiber Link'.equalsIgnoreCase(caseColl.PO_Richiesta_a_fattibilit__r.PO_Offerta__c)) {
            //Valorizzo billingCToEsclude con il valore da escludere in pbList nella query seguente
            String billingCToEsclude = caseColl.Billing_Competence__c == 'Anticipato' || caseColl.Billing_Competence__c == null ? 'Canone Posticipato' : 'Canone';
            beNames.remove(billingCToEsclude);
        }
        // DN - fix - OpportunityLineItem per p2pattiva creati senza criterio
		List<Pricebook2> pbList = new List<Pricebook2>();
        if(P2P_ATTIVA.equalsIgnoreCase(caseColl.PO_Richiesta_a_fattibilit__r.PO_Offerta__c)) {
            pbList = getPricebooksP2PAttiva(caseColl, listiniIds, beNames);
        } else {
                pbList = [SELECT Id, Name, Unit_Price__c, PO_Commercial_element__r.Name, OF_Listino__r.Name FROM Pricebook2
                WHERE IsActive = true 
                AND Unit_Price__c != null 
                AND PO_Commercial_element__c != null 
                AND OF_Listino__c IN :listiniIds AND Name IN :beNames];
        }

        System.debug('Pricing - query: SELECT Id, Name, Unit_Price__c, PO_Commercial_element__r.Name, OF_Listino__r.Name FROM Pricebook2 WHERE IsActive = true AND Unit_Price__c != null AND PO_Commercial_element__c != null AND OF_Listino__c IN :listiniIds AND Name IN :beNames');
        System.debug('Pricing - listiniIds: ' + listiniIds);
        System.debug('Pricing - beNames: ' + beNames);
        
        if (misto) { // Aggiunge i due PB di Fiber Link per Canone e Contributo Attivo
            pbList.addAll(PO_ServFatt_OpportunityHandler.getFiberLinkMistoPB(caseColl));
        }
        
        Pricebook2 pbKit = PO_ServFatt_OpportunityHandler.removePBKit(pbList, srvName);
        PO_ServFatt_OpportunityHandler.setOppFieldsForService(srvName, o, pbList, caseColl);
        
        Decimal costiAggiuntivi = (caseColl.PO_Costi_aggiuntivi_collegamento__c > caseColl.PO_Costo_lavori_civili__c) ? caseColl.PO_Costi_aggiuntivi_collegamento__c : caseColl.PO_Costo_lavori_civili__c + caseColl.PO_Costo_lavori_ottici__c;
        if (costiAggiuntivi > 0) {
            o.PO_CostiAggiuntiviCollegamento__c = costiAggiuntivi;
            o.PO_Costi_Aggiuntivi_Anno1__c = costiAggiuntivi;
            o.PO_Costi_Aggiuntivi_Anno2__c = costiAggiuntivi;
            o.PO_Costi_Aggiuntivi_Anno3__c = costiAggiuntivi;
            o.PO_CostiCollegamento__c = costiAggiuntivi;
        }
        if ('Fiber Lease'.equalsIgnoreCase(srvName)) {
            PO_CollegamentoFiberLease_Controller.setPrezziFiberLease(o, caseColl);
            o.PO_Contributo_attivazione_collegamento__c = o.PO_ContributoDiAttivazione__c;
        }
        
        if (misto || 'Fiber Link'.equalsIgnoreCase(srvName)) {
            setPrezzoAnniFields(o, pbList);
        }
        
        insert o;
        
        if ('P2P Attiva'.equalsIgnoreCase(srvName) && String.isNotBlank(caseColl.PO_KIT_Consegna_VLAN__c) && String.isBlank(caseColl.PO_KIT_Consegna_VLAN__r.assetId)) {
            pbList.add(pbKit);
        }
        PO_ServFatt_OpportunityHandler.createOppLineItems(o, caseColl, pbList);
        
        return o;
    }

    @testVisible
    private static List<Pricebook2> getPricebooksP2PAttiva(Case caseColl, Set<Id> listiniIds, Set<String> beNames) {
        System.debug('##### getPricebooksP2PAttiva - start');
        Set<String> commercialName = new Set<String>();
        if(RTypeServFattibilita.CASE_P2P_ATTIVA_COLLEGAMENTO.equalsIgnoreCase(caseColl.recordType.DeveloperName)) {
            commercialName.add(SEDE_E_ACCESS);
            commercialName.add(KIT_E_ACCESS);
        } else if ('Master'.equalsIgnoreCase(caseColl.tipologia_sede__c)) {
            commercialName.add(MASTER_E_LINE);
        } else {
            commercialName.add(SATELLITE_E_LINE); 
        }

        List<Pricebook2> pbList = [SELECT Id, Name, Unit_Price__c, PO_Commercial_element__r.Name, OF_Listino__r.Name FROM Pricebook2
                WHERE IsActive = true 
                AND Unit_Price__c != null 
                AND PO_Commercial_element__c != null 
                AND OF_Listino__c IN :listiniIds AND Name IN :beNames
                AND PO_Commercial_element__r.Name IN : commercialName];

        return pbList;
    }
    
    private static void setPrezzoAnniFields(Opportunity o, List<Pricebook2> pbList) {
        for (Pricebook2 pb : pbList) {
            String anno = pb.OF_Listino__r.Name.right(4).left(2);
            if ('C1'.equalsIgnoreCase(anno)) {
                if ('Canone'.equalsIgnoreCase(pb.Name)) {
                    o.PO_Canone_annuo_1anno__c = pb.Unit_Price__c;
                    //o.PO_Totale_Canone_Anno1__c = pb.Unit_Price__c;
                } else if ('Contributo Attivazione'.equalsIgnoreCase(pb.Name)) {
                    o.PO_Contributo_attivazione_1anno__c = pb.Unit_Price__c;
                    //o.PO_Totale_Contributi_Attiva_Anno1__c = pb.Unit_Price__c;
                } //else if ('Contributo Aggiuntivo'.equalsIgnoreCase(pb.Name)) {
                //o.PO_Costi_Aggiuntivi_Anno1__c = pb.Unit_Price__c;
                //o.PO_Totale_Costi_Aggiuntivi_Anno1__c = pb.Unit_Price__c;
                //}
            } else if ('C2'.equalsIgnoreCase(anno)) {
                if ('Canone'.equalsIgnoreCase(pb.Name)) {
                    o.PO_Canone_annuo_2anni__c = pb.Unit_Price__c;
                    //o.PO_Totale_Canone_Anno2__c = pb.Unit_Price__c;
                } else if ('Contributo Attivazione'.equalsIgnoreCase(pb.Name)) {
                    o.PO_Contributo_attivazione_2anni__c = pb.Unit_Price__c;
                    //o.PO_Totale_Contributi_Attiva_Anno2__c = pb.Unit_Price__c;
                } //else if ('Contributo Aggiuntivo'.equalsIgnoreCase(pb.Name)) {
                //o.PO_Costi_Aggiuntivi_Anno2__c = pb.Unit_Price__c;
                //o.PO_Totale_Costi_Aggiuntivi_Anno2__c = pb.Unit_Price__c;
                //}
            } else if ('C3'.equalsIgnoreCase(anno)) {
                if ('Canone'.equalsIgnoreCase(pb.Name)) {
                    o.PO_Canone_annuo_3anni__c = pb.Unit_Price__c;
                    //o.PO_Totale_Canone_Anno3__c = pb.Unit_Price__c;
                } else if ('Contributo Attivazione'.equalsIgnoreCase(pb.Name)) {
                    o.PO_Contributo_attivazione_3anni__c = pb.Unit_Price__c;
                    //o.PO_Totale_Contributi_Attiva_Anno3__c = pb.Unit_Price__c;
                } //else if ('Contributo Aggiuntivo'.equalsIgnoreCase(pb.Name)) {
                //o.PO_Costi_Aggiuntivi_Anno3__c = pb.Unit_Price__c;
                //o.PO_Totale_Costi_Aggiuntivi_Anno3__c = pb.Unit_Price__c;
                //}
            }
        }
    }
    
    private static Boolean isFiberLeaseMisto(List<Case> caseCollList) {
        Boolean misto = false;
        for (Case c : caseCollList) {
            if (c.PO_Drop_FL_1__c) {
                misto = true;
                break;
            }
        }
        return misto;
    }
    
    public static Opportunity createOppParent(Case padre, List<Case> figli, Opportunity oppChild) {
        System.debug('PO_ServFatt_OpportunityHandler.createOppParent - CaseP: ' + padre.Id + ' - ChildSize: ' + figli.size());
        ServFattList__c cs = ServFattList__c.getAll().get(padre.PO_Offerta__c);
        Opportunity o = new Opportunity();
        o.CloseDate = System.today().addDays(150);
        o.name = cs.oppParentName__c;
        o.StageName = cs.oppParentStageName__c;
        o.AccountId = padre.AccountId;
        o.PO_Richiesta_fattibilit__c = padre.Id;
        
        Boolean misto = 'Fiber Lease'.equalsIgnoreCase(padre.PO_Offerta__c) && isFiberLeaseMisto(figli);
        Map<String, Id> devNameIdMap = PO_ServFatt_OpportunityHandler.getRtDevNameIdMap();
        o.recordtypeId = !misto ? devNameIdMap.get(cs.oppParentDevName__c) : devNameIdMap.get(OFFERTA_TOTALE_FLEASE_MISTA_RT);
        
        // if (oppChild != null) {
        //  o.PO_Canone_collegamento__c = oppChild.PO_Canone_collegamento__c;
        //  o.PO_Contributo_attivazione_collegamento__c = oppChild.PO_Contributo_attivazione_collegamento__c;
        //  o.PO_CostiAggiuntiviCollegamento__c = oppChild.PO_CostiAggiuntiviCollegamento__c;
        //  o.PO_Canone_manutenzione_collegamento__c = oppChild.PO_Canone_manutenzione_collegamento__c;
        //  o.PO_Corrispettivo_IRU__c = oppChild.PO_Corrispettivo_IRU__c;
        // }
        
        List<opportunity> oppChildList = [SELECT Id, PO_Canone_collegamento__c, PO_CostiCollegamento__c, PO_Contributo_attivazione_collegamento__c, PO_Canone_manutenzione_collegamento__c, PO_Corrispettivo_IRU__c,
                                          PO_CostiAggiuntiviCollegamento__c, PO_Canone_annuo_1anno__c, PO_Contributo_attivazione_1anno__c, PO_Costi_Aggiuntivi_Anno1__c,
                                          PO_Canone_annuo_2anni__c, PO_Contributo_attivazione_2anni__c, PO_Costi_Aggiuntivi_Anno2__c,
                                          PO_Canone_annuo_3anni__c, PO_Contributo_attivazione_3anni__c, PO_Costi_Aggiuntivi_Anno3__c,
                                          PO_Valore_medio_annuo_altre_coppie__c, PO_Valore_medio_annuo_totale__c, PO_Valore_totale_prima_coppia_fino_2030__c,
                                          PO_Canone_annuo_AltriAnni__c, PO_Contributo_attivazione_altri_anni__c, PO_Costi_Aggiuntivi_Altri_Anni__c
                                          FROM Opportunity WHERE PO_Incluso_nell_offerta__c = TRUE AND PO_Collegamento__c IN :figli];
        
        calculateParentOpp(o, oppChildList);
        insert o;
        
        for (Opportunity opp : oppChildList) {
            opp.PO_Offerta_totale__c = o.Id;
        }
        
        update oppChildList;
        return o;
    }
    
    public static void calculateParentOpp(Opportunity o, List<Opportunity> oppChildList) {
        Decimal contribAttivTot = 0.0;
        Decimal costiAggiuntTot = 0.0;
        Decimal canoneCollTot = 0.0;
        Decimal canoneManutTot = 0.0;
        Decimal corrispIRUTot = 0.0;
        
        Decimal canoneAnno1Tot = 0.0;
        Decimal contributoAttivazioneAnno1Tot = 0.0;
        Decimal canoneAnno2Tot = 0.0;
        Decimal contributoAttivazioneAnno2Tot = 0.0;
        Decimal canoneAnno3Tot = 0.0;
        Decimal contributoAttivazioneAnno3Tot = 0.0;
        Decimal costiAggiuntiviAnno1Tot = 0.0;
        Decimal costiAggiuntiviAnno2Tot = 0.0;
        Decimal costiAggiuntiviAnno3Tot = 0.0;
        Decimal costiCollegamentoTotale = 0.0;
        Decimal valoreMedioAltreCoppieTot = 0.0;
        Decimal valoreMedioAnnuoTot = 0.0;
        Decimal valoreCoppie2030Tot = 0.0;
        Decimal canoneAltriAnniTot = 0.0;
        Decimal contributoAttivazioneAltriAnniTot = 0.0;
        Decimal costiAggiuntiviAltriAnniTot = 0.0;
        
        PO_ServFatt_OpportunityHandler.setCurrencyFieldsToZero(o, true);
        System.debug('#### calculateParentOpp : ' );
        for (Opportunity opp : oppChildList) {
            PO_ServFatt_OpportunityHandler.setCurrencyFieldsToZero(opp, false);
            contribAttivTot += opp.PO_Contributo_attivazione_collegamento__c;
            costiAggiuntTot += opp.PO_CostiAggiuntiviCollegamento__c;
            canoneCollTot += opp.PO_Canone_collegamento__c;
            canoneManutTot += opp.PO_Canone_manutenzione_collegamento__c;
            corrispIRUTot += opp.PO_Corrispettivo_IRU__c;
            costiCollegamentoTotale += opp.PO_CostiCollegamento__c;
            
            canoneAnno1Tot += opp.PO_Canone_annuo_1anno__c;
            contributoAttivazioneAnno1Tot += opp.PO_Contributo_attivazione_1anno__c;
            canoneAnno2Tot += opp.PO_Canone_annuo_2anni__c;
            contributoAttivazioneAnno2Tot += opp.PO_Contributo_attivazione_2anni__c;
            canoneAnno3Tot += opp.PO_Canone_annuo_3anni__c;
            contributoAttivazioneAnno3Tot += opp.PO_Contributo_attivazione_3anni__c;
            costiAggiuntiviAnno1Tot += opp.PO_Costi_Aggiuntivi_Anno1__c;
            costiAggiuntiviAnno2Tot += opp.PO_Costi_Aggiuntivi_Anno2__c;
            costiAggiuntiviAnno3Tot += opp.PO_Costi_Aggiuntivi_Anno3__c;
            canoneAltriAnniTot += opp.PO_Canone_annuo_AltriAnni__c;
            contributoAttivazioneAltriAnniTot += opp.PO_Contributo_attivazione_altri_anni__c;
            costiAggiuntiviAltriAnniTot += opp.PO_Costi_Aggiuntivi_Altri_Anni__c;
            
            valoreMedioAltreCoppieTot += opp.PO_Valore_medio_annuo_altre_coppie__c;
            valoreMedioAnnuoTot += opp.PO_Valore_medio_annuo_totale__c;
            valoreCoppie2030Tot += opp.PO_Valore_totale_prima_coppia_fino_2030__c;
        }
        
        ServFattList__c cs = ServFattList__c.getAll().get('Fiber Lease');
        ServFattList__c csmisto = ServFattList__c.getAll().get('Fiber Lease Misto');
        if ((o.RecordTypeId == PO_ServFatt_OpportunityHandler.getRtDevNameIdMap().get(cs.oppParentDevName__c)) ||
            ( o.RecordTypeId == PO_ServFatt_OpportunityHandler.getRtDevNameIdMap().get(csmisto.oppParentDevName__c)) ) {
                costiAggiuntTot = costiCollegamentoTotale;
            }
        
        system.debug('##### Costi Coll: ' + costiCollegamentoTotale );
        o.PO_Totale_contributi_attivazione__c = contribAttivTot;
        o.PO_Totale_costi_aggiuntivi__c = costiAggiuntTot;
        o.PO_Totale_canoni__c = canoneCollTot;
        o.PO_Totale_canoni_manutenzione__c = canoneManutTot;
        o.PO_Totale_corrispettivi_IRU__c = corrispIRUTot;
        
        o.PO_Totale_Canone_Anno1__c = canoneAnno1Tot;
        o.PO_Totale_Contributi_Attiva_Anno1__c = contributoAttivazioneAnno1Tot;
        o.PO_Totale_Canone_Anno2__c = canoneAnno2Tot;
        o.PO_Totale_Contributi_Attiva_Anno2__c = contributoAttivazioneAnno2Tot;
        o.PO_Totale_Canone_Anno3__c = canoneAnno3Tot;
        o.PO_Totale_Contributi_Attiva_Anno3__c = contributoAttivazioneAnno3Tot;
        o.PO_Totale_Costi_Aggiuntivi_Anno1__c = costiAggiuntiviAnno1Tot;
        o.PO_Totale_Costi_Aggiuntivi_Anno2__c = costiAggiuntiviAnno2Tot;
        o.PO_Totale_Costi_Aggiuntivi_Anno3__c = costiAggiuntiviAnno3Tot;
        o.PO_Totale_Canone_Altri_Anni__c = canoneAltriAnniTot;
        o.PO_Totale_Contributi_Attiva_Altri_Anni__c = contributoAttivazioneAltriAnniTot;
        o.PO_Totale_Costi_Aggiuntivi_Altri_Anni__c = costiAggiuntiviAltriAnniTot;
        
        o.PO_Totale_valori_medi_annui_altre_copp__c = valoreMedioAltreCoppieTot;
        o.PO_Totale_valori_medi_annui__c = valoreMedioAnnuoTot;
        
        if (o.RecordTypeId == PO_ServFatt_OpportunityHandler.getRtDevNameIdMap().get(csmisto.oppParentDevName__c)) {
            valoreCoppie2030Tot = 0;
        }
        
        o.PO_Totale_valori_prime_coppie_fino_2030__c = valoreCoppie2030Tot;
    }
    
    private static void setOppFieldsForService(String serviceName, Opportunity o, List<Pricebook2> pbList, Case collegamento) {
        if ('P2P Base'.equals(serviceName) || 'P2P Attiva'.equals(serviceName) || 'Fiber Link'.equals(serviceName) || 'Fiber Lease'.equals(serviceName)) {
            PO_ServFatt_OpportunityHandler.setOppFieldsForP2PField(o, pbList);
        } else if ('BTS'.equals(serviceName) || 'Backhauling'.equals(serviceName) || 'Dark Fiber'.equals(serviceName)) {
            PO_ServFatt_OpportunityHandler.setOppFieldsForExIRU(o, pbList, collegamento);
        } else {
            System.debug('Servizio [' + serviceName + '] non gestito');
        }
    }
    
    private static void setOppFieldsForP2PField(Opportunity o, List<Pricebook2> pbList) {
        for (Pricebook2 pb : pbList) {
            if (pb.Name.equals('Canone')) {
                o.PO_Canone_collegamento__c = pb.Unit_Price__c;
            } else if (pb.Name.equals('Contributo Attivazione')) {
                o.PO_Contributo_attivazione_collegamento__c = pb.Unit_Price__c;
            } else if (pb.Name.equals('Contributo Aggiuntivo')) {
                o.PO_CostiAggiuntiviCollegamento__c = pb.Unit_Price__c;
            }
        }
    }
    
    private static void setOppFieldsForExIRU(Opportunity o, List<Pricebook2> pbList, Case collegamento) {
        //FD 2019-02-21 Logiche pricing - start
        System.debug('Pricing - pbList: ' + pbList);
        Case c = [SELECT PO_Costi_aggiuntivi_collegamento__c, PO_Lunghezza_tratta_prima_via__c, PO_Offerta__c FROM Case WHERE Id =: collegamento.Id ];
        Decimal contributoAttivazioneCollegamento = 0.0;
        Decimal corrispettivo_IRU = 0.0;
        for (Pricebook2 pb : pbList) {
            if (pb.Name.equals('Corrispettivo IRU')) {
                corrispettivo_IRU = pb.Unit_Price__c;
            } else if (pb.Name.equals('Contributo Attivazione')) {
                contributoAttivazioneCollegamento = pb.Unit_Price__c;
            }
        }
        
        o.PO_Canone_manutenzione_collegamento__c =  (c.PO_Offerta__c == 'BTS') ? corrispettivo_IRU * 0.03 : c.PO_Lunghezza_tratta_prima_via__c * corrispettivo_IRU * 0.03; //3% del corrispettivo IRU
        o.PO_CostiAggiuntiviCollegamento__c = c.PO_Costi_aggiuntivi_collegamento__c; //da collegamento
        o.PO_Corrispettivo_IRU__c = (c.PO_Offerta__c == 'BTS') ? corrispettivo_IRU : c.PO_Lunghezza_tratta_prima_via__c * corrispettivo_IRU;  //prezzo da listino * PO_Lunghezza_tratta_prima_via__c
        o.PO_Contributo_attivazione_collegamento__c = contributoAttivazioneCollegamento; //prezzo da listino
        //FD 2019-02-21 Logiche pricing - end
    }
    public static Boolean checkOpzionePrice(Case c){
        Boolean prezzoMagg = false;
        System.debug(' - Case: ' + c.Id);
        Case cas = [Select CreatedDate from Case where id = : c.id];
        System.debug(' - Case:Date ' + cas);
        /*User ContactUser = [Select contactId from User where id=:UserInfo.getUserId()];
Id accId = [Select AccountId from Contact where id =: c.ContactId limit 1].AccountId;*/
        billingCity = [select Account.BillingCity from Case where id =:c.Id ] ;
        EOF_VLAN__c objVLAN=[select Id,PO_Opzione__c, Name from EOF_VLAN__c where Caso__c =: c.Id limit 1];
        System.debug(' .CreatedDate.date()' + cas.CreatedDate.date());
        System.debug('@@@Comune'+billingCity);
        List<P2PAttivaOpp__c> oppList = P2PAttivaOpp__c.getAll().values();
        for(P2PAttivaOpp__c opp : oppList){
            System.debug('dentro for');
            System.debug('sf.DataConfigEAccess__c'+opp.DataConfigEAccess__c);
            if(cas.CreatedDate.date()> opp.DataConfigEAccess__c){
                System.debug('primo if date');
                if( objVLAN.PO_Opzione__c=='Flexible'){
                    prezzoMagg = true;
                    System.debug('dentro if prezzo magg');
                }
            }
        }
        System.debug('prezzoMagg'+prezzoMagg);
        return prezzoMagg; 
    }
    
    public static List<OpportunityLineItem> createOppLineItemsMaster(Opportunity o, Case c, List<Pricebook2> pbs) {
        Boolean isFlex =false;
        Boolean isMaster = 'Master'.equalsIgnoreCase(c.Tipologia_Sede__c);
        if ( !isMaster &&
            (c.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva' || 
             c.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva_ELine')){
                isFlex=checkOpzionePrice(c);
        } 
        List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>();
        Id pbeDefId = [SELECT Id FROM PriceBookEntry WHERE PriceBook2.Name = 'SERV_FATT_APPOGGIO' AND Product2.Name = 'SERV_FATT_APPOGGIO' LIMIT 1].Id;
        system.debug ('@@@@@@@@@@@@@ pbs : ' + pbs);
        for (Pricebook2 pb: pbs) { 
            if (pb != null ){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = o.Id;
                oli.Quantity = 1;
                system.debug('@@@@ controllo' );
                system.debug('@@@@ pb.Id  :' + pb.OF_Listino__r.Name);
                oli.Price_Book__c = pb.Id;
                oli.PriceBookEntryId = pbeDefId;
                oli.PO_SalesPrice__c = pb.Unit_Price__c;
                oli.Description = pb.OF_Listino__r.Name;
                //FD 2019-02-22 Logiche Pricing - start
                if (pb.Name.equals('Contributo Aggiuntivo')) {
                    oli.UnitPrice = o.PO_CostiAggiuntiviCollegamento__c;
                } else if (pb.Name.equals('Contributo Attivazione')) {
                    oli.UnitPrice = o.PO_Contributo_attivazione_collegamento__c;
                }
                else if (pb.Name.equals('Canone')) {
                    System.debug('@@pb.NAAAAAME'+pb.Name);
                    System.debug('isFlex'+isFlex);
                    if(isFlex){
                        Decimal aumentoPrezzo = (o.PO_Canone_collegamento__c*10)/100;
                        System.debug('@@@aumentoPrezzo'+aumentoPrezzo);
                        System.debug('@@@o.PO_Canone_collegamento__c'+o.PO_Canone_collegamento__c);
                        oli.UnitPrice =o.PO_Canone_collegamento__c+ aumentoPrezzo;
                    } else {
                        oli.UnitPrice = pb.Unit_Price__c;
                    }
                    
                }
                // TEST LM
                else {
                    oli.UnitPrice = pb.Unit_Price__c;
                }
                //FD 2019-02-22 Logiche Pricing - end
                oppLineItemList.add(oli);
            }
        }
        if (!oppLineItemList.isEmpty()) {
            
            insert oppLineItemList;
        }
        System.debug('CreateOppLineItems END - Case: ' + c.Id);
        return oppLineItemList;
    }
    
    
    public static List<OpportunityLineItem> createOppLineItems(Opportunity o, Case c, List<Pricebook2> pbs) {
        System.debug('createOppLineItems START - Case: ' + c.Id + ' - Opp: ' + o.Id);
        Boolean isFlex =false;
        Boolean isMaster = 'Master'.equalsIgnoreCase(c.Tipologia_Sede__c);
        System.debug('##### createOppLineItems - tipologia_sede / isMaster: ' + c.Tipologia_Sede__c + ' / ' + isMaster);
        if ( !isMaster &&
            (c.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva' || 
             c.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva_ELine')) {
                isFlex=checkOpzionePrice(c);
        }
        List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>();
        Id pbeDefId = [SELECT Id FROM PriceBookEntry WHERE PriceBook2.Name = 'SERV_FATT_APPOGGIO' AND Product2.Name = 'SERV_FATT_APPOGGIO' LIMIT 1].Id;
        system.debug ('@@@@@@@@@@@@@ pbs : ' + pbs);
        for (Pricebook2 pb: pbs) {
            if (pb != null ){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = o.Id;
                oli.Quantity = 1;
                system.debug('@@@@ controllo' );
                system.debug('@@@@ pb.Id  :' + pb.OF_Listino__r.Name);
                oli.Price_Book__c = pb.Id;
                oli.PriceBookEntryId = pbeDefId;
                oli.PO_SalesPrice__c = pb.Unit_Price__c;
                oli.Description = pb.OF_Listino__r.Name;
                //FD 2019-02-22 Logiche Pricing - start
                if (pb.Name.equals('Contributo Aggiuntivo')) {
                    oli.UnitPrice = o.PO_CostiAggiuntiviCollegamento__c;
                } else if (pb.Name.equals('Corrispettivo IRU')) {
                    oli.UnitPrice = o.PO_Corrispettivo_IRU__c;
                } else if (pb.Name.equals('Contributo Attivazione')) {
                    oli.UnitPrice = o.PO_Contributo_attivazione_collegamento__c;
                } else if (pb.Name.equals('Canone Manutenzione')) {
                    oli.UnitPrice = o.PO_Canone_manutenzione_collegamento__c;
                }// TEST LM
                else if (pb.Name.equals('Canone')) {
                    System.debug('@@pb.NAAAAAME'+pb.Name);
                    System.debug('isFlex'+isFlex);
                    if(isFlex){
                        Decimal aumentoPrezzo = (o.PO_Canone_collegamento__c*10)/100;
                        System.debug('@@@aumentoPrezzo'+aumentoPrezzo);
                        System.debug('@@@o.PO_Canone_collegamento__c'+o.PO_Canone_collegamento__c);
                        oli.UnitPrice =o.PO_Canone_collegamento__c+ aumentoPrezzo;
                    } else {
                        oli.UnitPrice = pb.Unit_Price__c;
                    }
                    
                }
                // TEST LM
                else {
                    oli.UnitPrice = pb.Unit_Price__c;
                }
                //FD 2019-02-22 Logiche Pricing - end
                oppLineItemList.add(oli);
                if (c.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva' || c.RecordType.DeveloperName == 'PO_Collegamento_P2P_Attiva_ELine')		
                {
                    List<Case> listCaseColl =  new List<Case>  ();
                    listCaseColl = [SELECT id,PO_Tipo_di_collegamento__c,Tipologia_Sede__c from Case where ParentId =: c.Id ];
                    //LM 
                    if(listCaseColl.size() == 2){
                        for(Integer i = 0; i < listCaseColl.size();i++){
                            if(listCaseColl[i].Tipologia_Sede__c =='Master'){
                                oli.clone();
                                oppLineItemList.add(oli);
                            }
                        } 
                    }
                    else if(listCaseColl.size() > 2 ){
                        oppLineItemList=PO_ServFatt_OpportunityHandler.createOppLineItemsMaster(o, c, pbs);
                    } 
                }
            }
        }
        if (!oppLineItemList.isEmpty()) {
            
            insert oppLineItemList;
        }
        System.debug('CreateOppLineItems END - Case: ' + c.Id);
        return oppLineItemList;
    }
    
    private static void ricalculateFiberLeasePrice(Opportunity oppCollegamento) {
        if (String.isBlank(oppCollegamento.PO_Collegamento__c)) {
            return;
        }
        
        Case c = new Case();
        c.PO_BB_2_interessato__c = oppCollegamento.PO_Collegamento__r.PO_BB_2_interessato__c;
        c.PO_Posa_2_nuovo_Drop__c = oppCollegamento.PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c;
        c.PO_Posa_1_nuovo_Drop__c = oppCollegamento.PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c;
        c.PO_BB_1_interessato__c = oppCollegamento.PO_Collegamento__r.PO_BB_1_interessato__c;
        
        PO_CollegamentoFiberLease_Controller.setPrezziFiberLease(oppCollegamento, c);
        oppCollegamento.PO_Contributo_attivazione_collegamento__c = oppCollegamento.PO_ContributoDiAttivazione__c;
    }
    
    public static void updateOppLineItems(Map<Opportunity, List<Opportunity>> childOppList) {
        System.debug('PO_ServFatt_OpportunityHandler.updateOppLineItems - childOppList.size: ' + childOppList.size());
        if (childOppList.isEmpty()) {
            return;
        }
        
        ServFattList__c cs = ServFattList__c.getAll().get('Fiber Lease');
        Set<Id> ids = new Set<Id>();
        Map<Id, Opportunity> mapChildIdParentOpp = new Map<Id, Opportunity>();
        Map<Id, Opportunity> mapCollIdCollegamentoOpp = new Map<Id, Opportunity>();
        for (Opportunity parentOpp : childOppList.keySet()) {
            for (Opportunity o : childOppList.get(parentOpp)) {
                if (cs.oppChildDevName__c.equalsIgnoreCase(o.RecordType.DeveloperName)) {
                    PO_ServFatt_OpportunityHandler.ricalculateFiberLeasePrice(o);
                }
                mapChildIdParentOpp.put(o.Id, parentOpp);
                mapCollIdCollegamentoOpp.put(o.Id, o);
                ids.add(o.Id);
            }
        }
        
        List<OpportunityLineItem> oliList = [SELECT id, OpportunityId, PricebookEntryId, Price_Book__c, Price_Book__r.PO_Commercial_element__c, Price_Book__r.Billing_element__r.Name, Price_Book__r.Billing_element__c, Discount, UnitPrice
                                             FROM OpportunityLineItem WHERE OpportunityId IN :ids AND Price_Book__r.OF_Listino__r.Servizio__r.Name != 'Fiber Link'];
        
        
        for (OpportunityLineItem oli : oliList) {
            Opportunity oppTotale = mapChildIdParentOpp.get(oli.OpportunityId);
            Opportunity oppCollegamento = mapCollIdCollegamentoOpp.get(oli.OpportunityId);
            switch on oli.Price_Book__r.Billing_element__r.Name {
                when 'Canone' {
                    oli.UnitPrice = oppCollegamento.PO_Canone_collegamento__c - ((oppCollegamento.PO_Canone_collegamento__c * oppTotale.PO_Sconto_canone__c) / 100); // o.PO_Canone_collegamento__c;
                    //oli.UnitPrice = oppTotale.PO_Totale_canoni__c - (oppTotale.PO_Totale_canoni__c * oppTotale.PO_Sconto_canone__c) / 100; // o.PO_Canone_collegamento__c;
                }
                when 'Contributo Aggiuntivo' {
                    oli.UnitPrice = oppCollegamento.PO_CostiAggiuntiviCollegamento__c - ((oppCollegamento.PO_CostiAggiuntiviCollegamento__c * oppTotale.PO_Sconto_costi_aggiuntivi__c) / 100); // o.PO_CostiAggiuntiviCollegamento__c;
                    //oli.UnitPrice = oppTotale.PO_Totale_costi_aggiuntivi__c - (oppTotale.PO_Totale_costi_aggiuntivi__c * oppTotale.PO_Sconto_costi_aggiuntivi__c) / 100; // o.PO_CostiAggiuntiviCollegamento__c;
                }
                when 'Contributo Attivazione' {
                    oli.UnitPrice = oppCollegamento.PO_Contributo_attivazione_collegamento__c - ((oppCollegamento.PO_Contributo_attivazione_collegamento__c * oppTotale.PO_Sconto_contributi_attivazione__c) / 100); // o.PO_Contributo_attivazione_collegamento__c;
                    //oli.UnitPrice = oppTotale.PO_Totale_contributi_attivazione__c - (oppTotale.PO_Totale_contributi_attivazione__c * oppTotale.PO_Sconto_contributi_attivazione__c) / 100; // o.PO_Contributo_attivazione_collegamento__c;
                }
                when 'Canone Manutenzione' {
                    oli.UnitPrice = oppCollegamento.PO_Canone_manutenzione_collegamento__c - ((oppCollegamento.PO_Canone_manutenzione_collegamento__c * oppTotale.PO_Sconto_canone_manutenzione__c) / 100); // o.PO_Canone_manutenzione_collegamento__c;
                    //oli.UnitPrice = oppTotale.PO_Totale_canoni_manutenzione__c - (oppTotale.PO_Totale_canoni_manutenzione__c * oppTotale.PO_Sconto_canone_manutenzione__c) / 100; // o.PO_Canone_manutenzione_collegamento__c;
                }
                when 'Corrispettivo IRU' {
                    oli.UnitPrice = oppCollegamento.PO_Corrispettivo_IRU__c - ((oppCollegamento.PO_Corrispettivo_IRU__c * oppTotale.PO_Sconto_corrispettivo_IRU__c) / 100); // o.PO_Corrispettivo_IRU__c;
                    //oli.UnitPrice = oppTotale.PO_Totale_corrispettivi_IRU__c - (oppTotale.PO_Totale_corrispettivi_IRU__c * oppTotale.PO_Sconto_corrispettivo_IRU__c) / 100; // o.PO_Corrispettivo_IRU__c;
                }
                when else {
                    System.debug('BE [' + oli.Price_Book__r.Billing_element__r.Name + '] non gestito per l\'opportunity totale: ' + oppTotale.Id);
                }
            }
        }
        
        update oliList;
    }
    
    private static void updateOppLineItemsFiberLink(Map<Opportunity, List<Opportunity>> childOppList) {
        System.debug('PO_ServFatt_OpportunityHandler.updateOppLineItemsFiberLink - childOppList.size: ' + childOppList.size());
        if (childOppList.isEmpty()) {
            return;
        }
        
        Set<Id> ids = new Set<Id>();
        Map<Id, Opportunity> mapChildIdParentOpp = new Map<Id, Opportunity>();
        Map<Id, Opportunity> mapCollIdCollegamentoOpp = new Map<Id, Opportunity>();
        for (Opportunity parentOpp : childOppList.keySet()) {
            for (Opportunity o : childOppList.get(parentOpp)) {
                mapChildIdParentOpp.put(o.Id, parentOpp);
                mapCollIdCollegamentoOpp.put(o.Id, o);
                ids.add(o.Id);
            }
        }
        
        List<OpportunityLineItem> oliList = [SELECT Id, OpportunityId, PricebookEntryId, Price_Book__c, Price_Book__r.OF_Listino__r.Name, Price_Book__r.PO_Commercial_element__c, Price_Book__r.Billing_element__r.Name, Price_Book__r.Billing_element__c, Discount, UnitPrice
                                             FROM OpportunityLineItem WHERE OpportunityId IN :ids AND Price_Book__r.OF_Listino__r.Servizio__r.Name = 'Fiber Link'];
        
        List<OpportunityLineItem> oliListAnno1 = new List<OpportunityLineItem>();
        List<OpportunityLineItem> oliListAnno2 = new List<OpportunityLineItem>();
        List<OpportunityLineItem> oliListAnno3 = new List<OpportunityLineItem>();
        for (OpportunityLineItem oli : oliList) {
            String anno = oli.Price_Book__r.OF_Listino__r.Name.right(4).left(2);
            if ('C1'.equalsIgnoreCase(anno)) {
                oliListAnno1.add(oli);
            } else if ('C2'.equalsIgnoreCase(anno)) {
                oliListAnno2.add(oli);
            } else if ('C3'.equalsIgnoreCase(anno)) {
                oliListAnno3.add(oli);
            }
        }
        updateOppLineItemAnno1Price(oliListAnno1, mapChildIdParentOpp, mapCollIdCollegamentoOpp);
        updateOppLineItemAnno2Price(oliListAnno2, mapChildIdParentOpp, mapCollIdCollegamentoOpp);
        updateOppLineItemAnno3Price(oliListAnno3, mapChildIdParentOpp, mapCollIdCollegamentoOpp);
        
        update oliList;
    }
    
    private static void updateOppLineItemAnno1Price(List<OpportunityLineItem> oliList, Map<Id, Opportunity> mapChildIdParentOpp, Map<Id, Opportunity> mapCollIdCollegamentoOpp) {
        for (OpportunityLineItem oli : oliList) {
            Opportunity oppTotale = mapChildIdParentOpp.get(oli.OpportunityId);
            Opportunity oppCollegamento = mapCollIdCollegamentoOpp.get(oli.OpportunityId);
            if ('Canone'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Canone_annuo_1anno__c - ((oppCollegamento.PO_Canone_annuo_1anno__c * oppTotale.PO_ScontoCanone_annuo_Collegameno_1anno__c) / 100);
                //oli.UnitPrice = oppTotale.PO_Totale_Canone_Anno1__c - (oppTotale.PO_Totale_Canone_Anno1__c * oppTotale.PO_ScontoCanone_annuo_Collegameno_1anno__c) / 100;
            } else if ('Contributo Attivazione'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Contributo_attivazione_1anno__c - ((oppCollegamento.PO_Contributo_attivazione_1anno__c * oppTotale.PO_Sconto_ContributoAttivaz_Colleg1anno__c) / 100);
                //oli.UnitPrice = oppTotale.PO_Totale_Contributi_Attiva_Anno1__c - (oppTotale.PO_Totale_Contributi_Attiva_Anno1__c * oppTotale.PO_Sconto_ContributoAttivaz_Colleg1anno__c) / 100;
            } else if ('Contributo Aggiuntivo'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Costi_Aggiuntivi_Anno1__c - ((oppCollegamento.PO_Costi_Aggiuntivi_Anno1__c * oppTotale.PO_Sconto_Costi_Aggiuntivi_Anno1_1__c) / 100);
                //oli.UnitPrice = oppTotale.PO_Totale_Costi_Aggiuntivi_Anno1__c - (oppTotale.PO_Totale_Costi_Aggiuntivi_Anno1__c * oppTotale.PO_Sconto_Costi_Aggiuntivi_Anno1_1__c) / 100;
            }
        }
    }
    
    private static void updateOppLineItemAnno2Price(List<OpportunityLineItem> oliList, Map<Id, Opportunity> mapChildIdParentOpp, Map<Id, Opportunity> mapCollIdCollegamentoOpp) {
        for (OpportunityLineItem oli : oliList) {
            Opportunity oppTotale = mapChildIdParentOpp.get(oli.OpportunityId);
            Opportunity oppCollegamento = mapCollIdCollegamentoOpp.get(oli.OpportunityId);
            if ('Canone'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Canone_annuo_2anni__c - ((oppCollegamento.PO_Canone_annuo_2anni__c * oppTotale.PO_ScontoCanone_annuo_Collegameno_2anno__c) / 100);
            } else if ('Contributo Attivazione'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Contributo_attivazione_2anni__c - ((oppCollegamento.PO_Contributo_attivazione_2anni__c * oppTotale.PO_Sconto_ContributoAttivaz_Colleg2anno__c) / 100);
            } else if ('Contributo Aggiuntivo'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Costi_Aggiuntivi_Anno2__c - ((oppCollegamento.PO_Costi_Aggiuntivi_Anno2__c * oppTotale.PO_Sconto_Costi_Aggiuntivi_Anno2_1__c) / 100);
            }
        }
    }
    
    private static void updateOppLineItemAnno3Price(List<OpportunityLineItem> oliList, Map<Id, Opportunity> mapChildIdParentOpp, Map<Id, Opportunity> mapCollIdCollegamentoOpp) {
        for (OpportunityLineItem oli : oliList) {
            Opportunity oppTotale = mapChildIdParentOpp.get(oli.OpportunityId);
            Opportunity oppCollegamento = mapCollIdCollegamentoOpp.get(oli.OpportunityId);
            if ('Canone'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Canone_annuo_3anni__c - ((oppCollegamento.PO_Canone_annuo_3anni__c * oppTotale.PO_ScontoCanone_annuo_Collegameno_3anno__c) / 100);
            } else if ('Contributo Attivazione'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Contributo_attivazione_3anni__c - ((oppCollegamento.PO_Contributo_attivazione_3anni__c * oppTotale.PO_Sconto_ContributoAttivaz_Colleg3anno__c) / 100);
            } else if ('Contributo Aggiuntivo'.equalsIgnoreCase(oli.Price_Book__r.Billing_element__r.Name)) {
                oli.UnitPrice = oppCollegamento.PO_Costi_Aggiuntivi_Anno3__c - ((oppCollegamento.PO_Costi_Aggiuntivi_Anno3__c * oppTotale.PO_Sconto_Costi_Aggiuntivi_Anno3_1__c) / 100);
            }
        }
    }
    
    public static void ricalculateOppParent(Set<Id> parentOppIdSet) {
        System.debug('PO_ServFatt_OpportunityHandler.ricalculateOppParent - ids.size: ' + parentOppIdSet.size());
        PO_ServFatt_OpportunityHandler.checkParentRecalculation = true;
        List<Opportunity> parentOppList=[SELECT Id, RecordType.DeveloperName, PO_Sconto_canone__c, PO_Sconto_costi_aggiuntivi__c, PO_Sconto_contributi_attivazione__c, PO_Sconto_canone_manutenzione__c, PO_Sconto_corrispettivo_IRU__c,
                                         PO_Totale_contributi_attivazione__c, PO_Totale_costi_aggiuntivi__c, PO_Totale_canoni__c, PO_Totale_canoni_manutenzione__c, PO_Totale_corrispettivi_IRU__c,
                                         PO_Totale_Canone_Anno1__c, PO_Totale_Contributi_Attiva_Anno1__c, PO_Totale_Costi_Aggiuntivi_Anno1__c, PO_ScontoCanone_annuo_Collegameno_1anno__c, PO_Sconto_ContributoAttivaz_Colleg1anno__c, PO_Sconto_Costi_Aggiuntivi_Anno1_1__c,
                                         PO_Totale_Canone_Anno2__c, PO_Totale_Contributi_Attiva_Anno2__c, PO_Totale_Costi_Aggiuntivi_Anno2__c, PO_ScontoCanone_annuo_Collegameno_2anno__c, PO_Sconto_ContributoAttivaz_Colleg2anno__c, PO_Sconto_Costi_Aggiuntivi_Anno2_1__c,
                                         PO_Totale_Canone_Anno3__c, PO_Totale_Contributi_Attiva_Anno3__c, PO_Totale_Costi_Aggiuntivi_Anno3__c, PO_ScontoCanone_annuo_Collegameno_3anno__c, PO_Sconto_ContributoAttivaz_Colleg3anno__c, PO_Sconto_Costi_Aggiuntivi_Anno3_1__c,
                                         PO_Totale_valori_medi_annui_altre_copp__c, PO_Totale_valori_medi_annui__c, PO_Totale_valori_prime_coppie_fino_2030__c,
                                         PO_Totale_Canone_Altri_Anni__c, PO_Totale_Contributi_Attiva_Altri_Anni__c, PO_Totale_Costi_Aggiuntivi_Altri_Anni__c,
                                         PO_Sconto_Canone_annuo_altriAnni__c, PO_Sconto_ContributoAttivazione_altriAnn__c, PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c,
                                         (SELECT Id, PO_Canone_collegamento__c, PO_Contributo_attivazione_collegamento__c, PO_CostiAggiuntiviCollegamento__c, PO_CostiCollegamento__c, PO_Canone_manutenzione_collegamento__c, PO_Corrispettivo_IRU__c,
                                          PO_Canone_annuo_1anno__c, PO_Contributo_attivazione_1anno__c, PO_Costi_Aggiuntivi_Anno1__c, PO_ContributoDiAttivazione__c,
                                          PO_Canone_annuo_2anni__c, PO_Contributo_attivazione_2anni__c, PO_Costi_Aggiuntivi_Anno2__c, PO_CostoStruttura__c,
                                          PO_Canone_annuo_3anni__c, PO_Contributo_attivazione_3anni__c, PO_Costi_Aggiuntivi_Anno3__c, PO_CostoDiAttivazione__c,
                                          PO_Valore_medio_annuo_altre_coppie__c, PO_Valore_medio_annuo_totale__c, PO_Valore_totale_prima_coppia_fino_2030__c,
                                          PO_Canone_annuo_AltriAnni__c, PO_Contributo_attivazione_altri_anni__c, PO_Costi_Aggiuntivi_Altri_Anni__c,
                                          PO_Collegamento__c, PO_Collegamento__r.PO_Offerta__c, PO_Collegamento__r.PO_BB_2_interessato__c, PO_Collegamento__r.PO_Posa_2_nuovo_Drop__c, PO_Collegamento__r.PO_Posa_1_nuovo_Drop__c, PO_Collegamento__r.PO_BB_1_interessato__c, RecordType.DeveloperName
                                          FROM Opportunities__r WHERE PO_Incluso_nell_offerta__c=TRUE)
                                         FROM opportunity WHERE Id IN :parentOppIdSet];
        
        Map<Opportunity, List<Opportunity>> mapParentOppChildren = new Map<Opportunity, List<Opportunity>>();
        Map<Opportunity, List<Opportunity>> mapParentOppChildrenFiberLink = new Map<Opportunity, List<Opportunity>>();
        
        ServFattList__c csFiberLink = ServFattList__c.getAll().get('Fiber Link');
        
        for (Opportunity o: parentOppList) {
            PO_ServFatt_OpportunityHandler.calculateParentOpp(o, o.Opportunities__r);
            if (o.RecordType.DeveloperName.equalsIgnoreCase(csFiberLink.oppChildDevName__c) || o.RecordType.DeveloperName.equalsIgnoreCase(csFiberLink.oppParentDevName__c)) {
                mapParentOppChildrenFiberLink.put(o, o.Opportunities__r);
            } else {
                mapParentOppChildren.put(o, o.Opportunities__r);
                if (OFFERTA_TOTALE_FLEASE_MISTA_RT.equals(o.RecordType.DeveloperName)) {
                    mapParentOppChildrenFiberLink.put(o, o.Opportunities__r);
                }
            }
        }
        
        PO_ServFatt_OpportunityHandler.updateOppLineItems(mapParentOppChildren);
        PO_ServFatt_OpportunityHandler.updateOppLineItemsFiberLink(mapParentOppChildrenFiberLink);
        
        update parentOppList;
        
        PO_ServFatt_OpportunityHandler.checkParentRecalculation = false;
    }
    
    public static Boolean haveDifferentPrice(Opportunity o1, Opportunity o2) {
        return o1.PO_Contributo_attivazione_collegamento__c != o2.PO_Contributo_attivazione_collegamento__c ||
            o1.PO_CostiAggiuntiviCollegamento__c != o2.PO_CostiAggiuntiviCollegamento__c ||
            o1.PO_Canone_collegamento__c != o2.PO_Canone_collegamento__c ||
            o1.PO_Canone_manutenzione_collegamento__c != o2.PO_Canone_manutenzione_collegamento__c ||
            o1.PO_Corrispettivo_IRU__c != o2.PO_Corrispettivo_IRU__c ||
            o1.PO_Sconto_contributi_attivazione__c != o2.PO_Sconto_contributi_attivazione__c ||
            o1.PO_Sconto_costi_aggiuntivi__c != o2.PO_Sconto_costi_aggiuntivi__c ||
            o1.PO_Sconto_canone__c != o2.PO_Sconto_canone__c ||
            o1.PO_Sconto_canone_manutenzione__c != o2.PO_Sconto_canone_manutenzione__c ||
            o1.PO_Sconto_corrispettivo_IRU__c != o2.PO_Sconto_corrispettivo_IRU__c ||
            o1.PO_Canone_annuo_1anno__c != o2.PO_Canone_annuo_1anno__c ||
            o1.PO_ScontoCanone_annuo_Collegameno_1anno__c != o2.PO_ScontoCanone_annuo_Collegameno_1anno__c ||
            o1.PO_Contributo_attivazione_1anno__c != o2.PO_Contributo_attivazione_1anno__c ||
            o1.PO_Sconto_ContributoAttivaz_Colleg1anno__c != o2.PO_Sconto_ContributoAttivaz_Colleg1anno__c ||
            o1.PO_Costi_Aggiuntivi_Anno1__c != o2.PO_Costi_Aggiuntivi_Anno1__c ||
            o1.PO_Sconto_Costi_Aggiuntivi_Anno1_1__c != o2.PO_Sconto_Costi_Aggiuntivi_Anno1_1__c ||
            o1.PO_Canone_annuo_2anni__c != o2.PO_Canone_annuo_2anni__c ||
            o1.PO_ScontoCanone_annuo_Collegameno_2anno__c != o2.PO_ScontoCanone_annuo_Collegameno_2anno__c ||
            o1.PO_Contributo_attivazione_2anni__c != o2.PO_Contributo_attivazione_2anni__c ||
            o1.PO_Sconto_ContributoAttivaz_Colleg2anno__c != o2.PO_Sconto_ContributoAttivaz_Colleg2anno__c ||
            o1.PO_Costi_Aggiuntivi_Anno2__c != o2.PO_Costi_Aggiuntivi_Anno2__c ||
            o1.PO_Sconto_Costi_Aggiuntivi_Anno2_1__c != o2.PO_Sconto_Costi_Aggiuntivi_Anno2_1__c ||
            o1.PO_Canone_annuo_3anni__c != o2.PO_Canone_annuo_3anni__c ||
            o1.PO_ScontoCanone_annuo_Collegameno_3anno__c != o2.PO_ScontoCanone_annuo_Collegameno_3anno__c ||
            o1.PO_Contributo_attivazione_3anni__c != o2.PO_Contributo_attivazione_3anni__c ||
            o1.PO_Sconto_ContributoAttivaz_Colleg3anno__c != o2.PO_Sconto_ContributoAttivaz_Colleg3anno__c ||
            o1.PO_Costi_Aggiuntivi_Anno3__c != o2.PO_Costi_Aggiuntivi_Anno3__c ||
            o1.PO_Sconto_Costi_Aggiuntivi_Anno3_1__c != o2.PO_Sconto_Costi_Aggiuntivi_Anno3_1__c ||
            o1.PO_Totale_Canone_Anno1__c != o2.PO_Totale_Canone_Anno1__c ||
            o1.PO_Totale_Contributi_Attiva_Anno1__c != o2.PO_Totale_Contributi_Attiva_Anno1__c ||
            o1.PO_Totale_Canone_Anno2__c != o2.PO_Totale_Canone_Anno2__c ||
            o1.PO_Totale_Contributi_Attiva_Anno2__c != o2.PO_Totale_Contributi_Attiva_Anno2__c ||
            o1.PO_Totale_Canone_Anno3__c != o2.PO_Totale_Canone_Anno3__c ||
            o1.PO_Totale_Contributi_Attiva_Anno3__c != o2.PO_Totale_Contributi_Attiva_Anno3__c ||
            o1.PO_CostiCollegamento__c != o2.PO_CostiCollegamento__c ||
            o1.PO_ContributoDiAttivazione__c != o2.PO_ContributoDiAttivazione__c ||
            o1.PO_Valore_totale_prima_coppia_fino_2030__c != o2.PO_Valore_totale_prima_coppia_fino_2030__c ||
            o1.PO_Valore_medio_annuo_totale__c != o2.PO_Valore_medio_annuo_totale__c ||
            o1.PO_Valore_medio_annuo_altre_coppie__c != o2.PO_Valore_medio_annuo_altre_coppie__c ||
            o1.PO_Costi_Aggiuntivi_Altri_Anni__c != o2.PO_Costi_Aggiuntivi_Altri_Anni__c ||
            o1.PO_Canone_annuo_AltriAnni__c != o2.PO_Canone_annuo_AltriAnni__c ||
            o1.PO_Contributo_attivazione_altri_anni__c != o2.PO_Contributo_attivazione_altri_anni__c;
    }
    
    // Public solo perché utile alle bonifiche, ma usato solo da questa classe 2019-03-19
    // Settando a 0 tutti i campi currency null, si evitano i null pointer quando vengono usati
    public static void setCurrencyFieldsToZero(Opportunity o, Boolean offertaTotale) {
        if (offertaTotale) {
            // Sconti
            if (o.PO_Sconto_canone__c == null) {
                o.PO_Sconto_canone__c = 0;
            }
            if (o.PO_Sconto_costi_aggiuntivi__c == null) {
                o.PO_Sconto_costi_aggiuntivi__c = 0;
            }
            if (o.PO_Sconto_contributi_attivazione__c == null) {
                o.PO_Sconto_contributi_attivazione__c = 0;
            }
            if (o.PO_Sconto_canone_manutenzione__c == null) {
                o.PO_Sconto_canone_manutenzione__c = 0;
            }
            if (o.PO_Sconto_corrispettivo_IRU__c == null) {
                o.PO_Sconto_corrispettivo_IRU__c = 0;
            }
            if (o.PO_ScontoCanone_annuo_Collegameno_1anno__c == null) {
                o.PO_ScontoCanone_annuo_Collegameno_1anno__c = 0;
            }
            if (o.PO_Sconto_ContributoAttivaz_Colleg1anno__c == null) {
                o.PO_Sconto_ContributoAttivaz_Colleg1anno__c = 0;
            }
            if (o.PO_Sconto_Costi_Aggiuntivi_Anno1_1__c == null) {
                o.PO_Sconto_Costi_Aggiuntivi_Anno1_1__c = 0;
            }
            if (o.PO_ScontoCanone_annuo_Collegameno_2anno__c == null) {
                o.PO_ScontoCanone_annuo_Collegameno_2anno__c = 0;
            }
            if (o.PO_Sconto_ContributoAttivaz_Colleg2anno__c == null) {
                o.PO_Sconto_ContributoAttivaz_Colleg2anno__c = 0;
            }
            if (o.PO_Sconto_Costi_Aggiuntivi_Anno2_1__c == null) {
                o.PO_Sconto_Costi_Aggiuntivi_Anno2_1__c = 0;
            }
            if (o.PO_ScontoCanone_annuo_Collegameno_3anno__c == null) {
                o.PO_ScontoCanone_annuo_Collegameno_3anno__c = 0;
            }
            if (o.PO_Sconto_ContributoAttivaz_Colleg3anno__c == null) {
                o.PO_Sconto_ContributoAttivaz_Colleg3anno__c = 0;
            }
            if (o.PO_Sconto_Costi_Aggiuntivi_Anno3_1__c == null) {
                o.PO_Sconto_Costi_Aggiuntivi_Anno3_1__c = 0;
            }
            if (o.PO_Sconto_Canone_annuo_altriAnni__c == null) {
                o.PO_Sconto_Canone_annuo_altriAnni__c = 0;
            }
            if (o.PO_Sconto_ContributoAttivazione_altriAnn__c == null) {
                o.PO_Sconto_ContributoAttivazione_altriAnn__c = 0;
            }
            if (o.PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c == null) {
                o.PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c = 0;
            }
            // Totali
            if (o.PO_Totale_contributi_attivazione__c == null) {
                o.PO_Totale_contributi_attivazione__c = 0;
            }
            if (o.PO_Totale_costi_aggiuntivi__c == null) {
                o.PO_Totale_costi_aggiuntivi__c = 0;
            }
            if (o.PO_Totale_canoni__c == null) {
                o.PO_Totale_canoni__c = 0;
            }
            if (o.PO_Totale_canoni_manutenzione__c == null) {
                o.PO_Totale_canoni_manutenzione__c = 0;
            }
            if (o.PO_Totale_corrispettivi_IRU__c == null) {
                o.PO_Totale_corrispettivi_IRU__c = 0;
            }
            if (o.PO_Totale_Canone_Anno1__c == null) {
                o.PO_Totale_Canone_Anno1__c = 0;
            }
            if (o.PO_Totale_Contributi_Attiva_Anno1__c == null) {
                o.PO_Totale_Contributi_Attiva_Anno1__c = 0;
            }
            if (o.PO_Totale_Costi_Aggiuntivi_Anno1__c == null) {
                o.PO_Totale_Costi_Aggiuntivi_Anno1__c = 0;
            }
            if (o.PO_Totale_Canone_Anno2__c == null) {
                o.PO_Totale_Canone_Anno2__c = 0;
            }
            if (o.PO_Totale_Contributi_Attiva_Anno2__c == null) {
                o.PO_Totale_Contributi_Attiva_Anno2__c = 0;
            }
            if (o.PO_Totale_Costi_Aggiuntivi_Anno2__c == null) {
                o.PO_Totale_Costi_Aggiuntivi_Anno2__c = 0;
            }
            if (o.PO_Totale_Canone_Anno3__c == null) {
                o.PO_Totale_Canone_Anno3__c = 0;
            }
            if (o.PO_Totale_Contributi_Attiva_Anno3__c == null) {
                o.PO_Totale_Contributi_Attiva_Anno3__c = 0;
            }
            if (o.PO_Totale_Costi_Aggiuntivi_Anno3__c == null) {
                o.PO_Totale_Costi_Aggiuntivi_Anno3__c = 0;
            }
            if (o.PO_Totale_valori_medi_annui_altre_copp__c == null) {
                o.PO_Totale_valori_medi_annui_altre_copp__c = 0;
            }
            if (o.PO_Totale_valori_medi_annui__c == null) {
                o.PO_Totale_valori_medi_annui__c = 0;
            }
            if (o.PO_Totale_valori_prime_coppie_fino_2030__c == null) {
                o.PO_Totale_valori_prime_coppie_fino_2030__c = 0;
            }
            if (o.PO_Totale_Canone_Altri_Anni__c == null) {
                o.PO_Totale_Canone_Altri_Anni__c = 0;
            }
            if (o.PO_Totale_Contributi_Attiva_Altri_Anni__c == null) {
                o.PO_Totale_Contributi_Attiva_Altri_Anni__c = 0;
            }
            if (o.PO_Totale_Costi_Aggiuntivi_Altri_Anni__c == null) {
                o.PO_Totale_Costi_Aggiuntivi_Altri_Anni__c = 0;
            }
        } else { // Offerta Collegamento
            if (o.PO_Canone_collegamento__c == null) {
                o.PO_Canone_collegamento__c = 0;
            }
            if (o.PO_Contributo_attivazione_collegamento__c == null) {
                o.PO_Contributo_attivazione_collegamento__c = 0;
            }
            if (o.PO_CostiAggiuntiviCollegamento__c == null) {
                o.PO_CostiAggiuntiviCollegamento__c = 0;
            }
            if (o.PO_CostiCollegamento__c == null) {
                o.PO_CostiCollegamento__c = 0;
            }
            if (o.PO_Canone_manutenzione_collegamento__c == null) {
                o.PO_Canone_manutenzione_collegamento__c = 0;
            }
            if (o.PO_Corrispettivo_IRU__c == null) {
                o.PO_Corrispettivo_IRU__c = 0;
            }
            if (o.PO_Canone_annuo_1anno__c == null) {
                o.PO_Canone_annuo_1anno__c = 0;
            }
            if (o.PO_Contributo_attivazione_1anno__c == null) {
                o.PO_Contributo_attivazione_1anno__c = 0;
            }
            if (o.PO_Costi_Aggiuntivi_Anno1__c == null) {
                o.PO_Costi_Aggiuntivi_Anno1__c = 0;
            }
            if (o.PO_Canone_annuo_2anni__c == null) {
                o.PO_Canone_annuo_2anni__c = 0;
            }
            if (o.PO_Contributo_attivazione_2anni__c == null) {
                o.PO_Contributo_attivazione_2anni__c = 0;
            }
            if (o.PO_Costi_Aggiuntivi_Anno2__c == null) {
                o.PO_Costi_Aggiuntivi_Anno2__c = 0;
            }
            if (o.PO_Canone_annuo_3anni__c == null) {
                o.PO_Canone_annuo_3anni__c = 0;
            }
            if (o.PO_Contributo_attivazione_3anni__c == null) {
                o.PO_Contributo_attivazione_3anni__c = 0;
            }
            if (o.PO_Costi_Aggiuntivi_Anno3__c == null) {
                o.PO_Costi_Aggiuntivi_Anno3__c = 0;
            }
            if (o.PO_Valore_medio_annuo_altre_coppie__c == null) {
                o.PO_Valore_medio_annuo_altre_coppie__c = 0;
            }
            if (o.PO_Valore_medio_annuo_totale__c == null) {
                o.PO_Valore_medio_annuo_totale__c = 0;
            }
            if (o.PO_Valore_totale_prima_coppia_fino_2030__c == null) {
                o.PO_Valore_totale_prima_coppia_fino_2030__c = 0;
            }
            if (o.PO_Costi_Aggiuntivi_Altri_Anni__c == null) {
                o.PO_Costi_Aggiuntivi_Altri_Anni__c = 0;
            }
            if (o.PO_Canone_annuo_AltriAnni__c == null) {
                o.PO_Canone_annuo_AltriAnni__c = 0;
            }
            if (o.PO_Contributo_attivazione_altri_anni__c == null) {
                o.PO_Contributo_attivazione_altri_anni__c = 0;
            }
        }
    }
}