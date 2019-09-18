public class PO_P2PAtt_CRMHandler {

    public PO_P2PAtt_CRMHandler () {}
    
    
    /*
    
    public static case caseKit;
    public static boolean checkKIT=false; 
    public static Map<String,Order> MapIdCaseOrder;
    public static List<Order> orderList;
    public static string kitName;
    
    public static List<Order> aggiornaOrdine(Case c){
        //oltre ad aggiornare l'ordine dobbiamo verificare se ci sono kit associati nel qual caso dobbiamo assettizzare anche quelli
        //Intanto estraiamo l'ordine relativo al collegamento per chiuderlo
        PO_P2PAtt_CRMHandler.orderList = new List<Order>();
        PO_P2PAtt_CRMHandler.MapIdCaseOrder = new Map<String,Order>();
        Order o = [Select Id, OwnerId, ContractId, AccountId, Pricebook2Id, OriginalOrderId, OpportunityId, QuoteId, RecordTypeId,recordtype.developername, 
                   EffectiveDate, EndDate, IsReductionOrder, Status, Description, Type, Name, PoDate, PoNumber, OrderReferenceNumber, BillToContactId, 
                   ShipToContactId, ActivatedDate, ActivatedById, StatusCode, OrderNumber, TotalAmount, CreatedDate, CreatedById, LastModifiedDate, 
                   LastModifiedById, IsDeleted, SystemModstamp, LastViewedDate, LastReferencedDate, OF_Esito__c, OF_Apparato__c, OF_AreaGeografica__c, 
                   OF_Asset__c, OF_CaseID__c, OF_CaseNome__c, OF_Case__c, OF_Civico__c, OF_CodiceKO__c, OF_Comune__c, OF_Contratto__c, OF_DataEsito__c, 
                   OF_Datarichiesta__c, OF_DescrizioneKO__c, OF_EsitoConsegnaApparato__c, OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDContratto__c, 
                   OF_IDOrdineEOF__c, OF_IDOrdineOLO__c, OF_IDRisorsa__c, OF_IDSegnalazione__c, OF_IDSplitterSecondario__c, OF_IdNetworkInventory__c, 
                   OF_IdentificativoDelPOP__c, OF_Indirizzo__c, OF_IsFromAsset__c, OF_MotivazioneEsito__c, OF_POP__c, OF_ParticellaToponomastica__c, 
                   OF_PosizioneSplitterSecondario__c, OF_Provincia__c, OF_Regione__c, OF_ScalaPalazzina__c, OF_SlaPremiumAssurance__c, OF_TipologiaDiServizio__c, 
                   OF_Type__c, OF_Data_Cessazione__c, OF_TipologiaDiSegnalazione__c, OF_ClusterPromozione__c, OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, 
                   OF_IDServizio__c, OF_PasswordApparato__c, OF_Profilo__c, OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, 
                   OF_ProfiloOpenStream__c, PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_DataEspletamentoOrdine__c, PO_IsFromOpportunity__c, 
                   PO_LunghezzaOttica__c, PO_Opportunity__c, PO_PosizioneRilascioCircuitoOSU__c, isFiberLease__c, isFiberLink__c,
                   NS_Rif__c
                   FROM Order Where Id = :c.OF_Order__c];
        o.status = 'Chiuso';
        if(c.status=='Espletato'){
            o.OF_Esito__c='OK';
        }
        else{
            o.OF_Esito__c='KO';
        }
        o.OF_DataEsito__c = system.Today();
        o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
        o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
        o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
        o.OF_Apparato__c = c.EOF_Apparato__c;
        o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
        o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
        o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
        if(c.OF_SA_Profilo__c != null){
            Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
            if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
                o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
        }
        o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
        o.OF_Promozione__c = c.OF_SA_Promozione__c ;
        o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
        o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
        o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
        o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
        o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
        o.OF_IDBuilding__c = c.EOF_ID_Building_WS__c;
        o.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
        o.OF_Comune__c = c.EOF_Comune_WS__c;
        o.OF_Provincia__c = c.EOF_Provincia_WS__c;
        o.OF_ParticellaToponomastica__c = c.EOF_Particella_Toponomastica_WS__c;
        o.OF_Indirizzo__c = c.EOF_Indirizzo_WS__c;
        o.OF_Civico__c = c.EOF_Numero_Civico_WS__c;
        o.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c;
        o.PO_Attenuazione__c = c.PO_Attenuazione__c ;
        o.PO_LunghezzaOttica__c = c.PO_Lunghezza_Ottica__c;
        o.PO_PosizioneRilascioCircuitoOSU__c = c.PO_Posizione_Rilascio_Circuito_OSU__c;
        if(c.PO_Data_Attivazione_Ordine__c != null){
            string str = c.PO_Data_Attivazione_Ordine__c + ' 00:00:00';
            o.PO_DataAttivazioneOrdine__c = datetime.valueOf(str);
        }
        PO_P2PAtt_CRMHandler.orderList.add(o);
        //ora verifichiamo se ci sono kit associati e se non sono stati gia assettizzati
        if(c.PO_KIT_Consegna_VLAN__c!=null && String.isBlank(c.PO_KIT_Consegna_VLAN__r.assetId)){
            system.debug('@@@@ dentro il KIT');
            PO_P2PAtt_CRMHandler.checkKIT=true;
            PO_P2PAtt_CRMHandler.caseKit=[select Id,EOF_Identificativo_del_POP__c,PO_P2PAttiva_Kit_Indirizzo_Consegna__c,
                                          PO_PP_NomeKit__c,PO_P2PAttiva_KIT_OpticalRateLimiting__c 
                                          from Case where id =:c.PO_KIT_Consegna_VLAN__c];
            PO_P2PAtt_CRMHandler.KITName=PO_P2PAtt_CRMHandler.caseKit.PO_PP_NomeKit__c;
            Order orderKit = new Order();
            orderKit.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('OF_INORDER');
            orderKit.OF_IdentificativoDelPOP__c=PO_P2PAtt_CRMHandler.caseKit.EOF_Identificativo_del_POP__c;
            orderKit.OF_Esito__c='OK';
            orderKit.status = 'Chiuso';
            orderKit.OF_DataEsito__c = system.Today();
            orderKit.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
            orderKit.accountId=o.accountId;
            orderKit.contractId=o.contractId;
            orderKit.effectiveDate=o.effectiveDate;
            if(o.PO_DataAttivazioneOrdine__c != null){
                orderKit.PO_DataAttivazioneOrdine__c = o.PO_DataAttivazioneOrdine__c;
            }
            if(!String.isBlank(o.OF_Profilo__c)){
                orderKit.OF_Profilo__c=o.OF_Profilo__c;
            }
            PO_P2PAtt_CRMHandler.orderList.add(orderKit); 
            PO_P2PAtt_CRMHandler.MapIdCaseOrder.put(PO_P2PAtt_CRMHandler.caseKit.Id,orderKit);
        }
        boolean inserito=false;
        boolean templog=false;
        Account a = new Account();  
        Templog__c t = new Templog__c();
        for(integer x=0; x<2; x++){
            try{
                if(x==0){
                    upsert PO_P2PAtt_CRMHandler.orderList;
                    inserito=true; 
                }
                if(x==1){
                    a.name=o.OF_IDOrdineOLO__c;
                    a.type='Temp';
                    insert a;
                    for(order ord:PO_P2PAtt_CRMHandler.orderList){
                        ord.OF_AccountTemporaneo__c=ord.AccountId;
                        ord.OF_ContractTemporaneo__c=ord.ContractId;
                        ord.AccountId=a.Id;
                        ord.contractId=null;
                    }
                    upsert PO_P2PAtt_CRMHandler.orderList;
                    inserito=true; 
                }
            }
            catch(exception e){
                if(!templog){
                    t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','PO_P2PAtt_CRMHandler','aggiornaOrdine',(x+1), e);
                    templog=true;
                }
                else{
                    t.OF_tentativi__c=(x+1);
                }
            }
            if(inserito==true){
                if(PO_P2PAtt_CRMHandler.checkKIT){
                    PO_P2PAtt_CRMHandler.caseKit.OF_Order__c=PO_P2PAtt_CRMHandler.MapIdCaseOrder.get(PO_P2PAtt_CRMHandler.caseKit.Id).Id;
                }
                break;
            }
        }
        if(templog){
            insert t;
        }
        
        return PO_P2PAtt_CRMHandler.orderList;
    }
    
    public static List<Asset> createAsset(){
        Integer nr=0;
        List<Asset> assetList = new List<Asset>();
        Map<String,Asset> MapOrderIdAsset = new Map<String,Asset>();
        for(Order o : PO_P2PAtt_CRMHandler.orderList){
            nr++;
            Asset a = new Asset();
            if(nr==1){
                a.recordTypeId=OF_Utility.getRT_DevNameId_Map().get('PO_Asset_P2P_Attiva_Collegamento');
                if(!String.isBlank(o.OF_IDRisorsa__c)){
                    a.name=o.OF_IDRisorsa__c;
                }
                else{
                    a.name=o.OF_IDOrdineEOF__c;
                }
            }
            else{
                a.recordTypeId=OF_Utility.getRT_DevNameId_Map().get('PO_Asset_P2P_Attiva_KIT');
                a.name=PO_P2PAtt_CRMHandler.KITName;
            }
            a.EOF_ID_Risorsa__c=a.name;
            String SlaPremium;
            if(String.isNotBlank(o.OF_SlaPremiumAssurance__c)){
                SlaPremium=o.OF_SlaPremiumAssurance__c;
            }
            else{
                SlaPremium='N';
            }
            
            a.AccountId = o.AccountID;                    
            a.OF_Contract__c=o.ContractId;
            a.OF_OrdineID__c=o.Id;
            a.Status = 'Attivo';
            a.OF_ID_Building__c=o.OF_IDBuilding__c;
            a.OF_Identificativo_del_POP__c=o.OF_IdentificativoDelPOP__c;
            a.OF_GPON_Attestazione__c=o.OF_GPONAttestazione__c;
            a.OF_Comune__c=o.OF_Comune__c;
            a.OF_DataAttivazione2__c=system.now();
            a.OF_Provincia__c=o.OF_Provincia__c;
            a.OF_Particella_Toponomastica__c=o.OF_ParticellaToponomastica__c;
            a.OF_Indirizzo__c=o.OF_Indirizzo__c;
            a.OF_Civico__c=o.OF_Civico__c;
            a.OF_Scala_Palazzina__c=o.OF_ScalaPalazzina__c;
            a.OF_ServizioRichiesto__c='P2P Attiva';
            a.EOF_ID_Risorsa__c=o.OF_IDRisorsa__c;
            a.EOF_ID_Splitter_Secondario__c=o.OF_IDSplitterSecondario__c;
            a.EOF_Posizione_Splitter_Secondario__c=o.OF_PosizioneSplitterSecondario__c;
            a.OF_ProgettoSpeciale__c=o.OF_ProgettoSpeciale__c;
            a.OF_IDCaseAttivazione__c=o.OF_IDCaso__c;
            a.OF_ProfiloOpenStream__c=o.OF_ProfiloOpenStream__c;
            a.OF_Promozione__c=o.OF_Promozione__c;
            a.OF_ClusterPromozione__c=o.OF_ClusterPromozione__c;
            a.OF_TipologiaApparato__c=o.OF_TipologiaApparato__c;
            a.OF_CodiceProgettoSpeciale__c=o.OF_CodiceProgettoSpeciale__c;
            a.OF_IDServizio__c=o.OF_IDServizio__c;
            a.EOF_SLA_Premium_Assurance__c=SlaPremium; 
            a.OF_DataScadenza__c = system.now().date().addYears( 15 );  
            a.PO_Attenuazione__c=o.PO_Attenuazione__c;
            a.PO_LunghezzaOttica__c=Integer.valueOf(o.PO_LunghezzaOttica__c);
            a.PO_PosizioneRilascioCircuitoOSU__c=o.PO_PosizioneRilascioCircuitoOSU__c;
            if(String.isNotBlank(o.ContractId)){
                Contract c =[select id, OF_Rinnovabile__c from contract where id =: o.ContractId]; 
                a.OF_Rinnovabile__c=c.OF_Rinnovabile__c;
                //FD 2019-02-08 - START
                a.NS_Rif__c = o.NS_Rif__c; 
                a.OF_Civico__c = o.OF_Civico__c;
                a.OF_Comune__c = o.OF_Comune__c;
                a.OF_Indirizzo__c = o.OF_Indirizzo__c;
                //ass.OF_Particella_Toponomastica__c = o.OF_ParticellaToponomastica__c;
                a.OF_Particella_Toponomastica__c = 'VIA';
                //FD 2019-02-08 - END
            }
            MapOrderIdAsset.put(o.Id,a);
            assetList.add(a);
        }                
        boolean inserito=false;
        boolean templog=false;
        Templog__c t = new Templog__c();
        for(integer x=0; x<50; x++){
            try{
                insert assetList;
                inserito=true;
            }
            catch(exception e){
                if(!templog){
                    t=OF_Utility.logMessageNew2(assetList[0].name,'E','PO_P2PAtt_CRMHandler','createAsset',(x+1), e);
                    templog=true;
                }
                else{
                    t.OF_tentativi__c=(x+1);
                }
            }
            if(inserito==true){
                if(PO_P2PAtt_CRMHandler.checkKIT){
                    PO_P2PAtt_CRMHandler.caseKit.AssetId=MapOrderIdAsset.get(PO_P2PAtt_CRMHandler.MapIdCaseOrder.get(PO_P2PAtt_CRMHandler.caseKit.Id).Id).Id;
                }
                break;
            }
        }
        if(templog){
            insert t;
        }
        //aggancio l'asset all'ordine
        for(order o:PO_P2PAtt_CRMHandler.orderList){
            o.OF_Asset__c=MapOrderIdAsset.get(o.Id).Id;
        }
        inserito=false;
        templog=false;
        Account a = new Account();  
        t = new Templog__c();
        for(integer x=0; x<2; x++){
            try{
                if(x==0){
                    update PO_P2PAtt_CRMHandler.orderList;
                    inserito=true; 
                }
                if(x==1){
                    a.name=PO_P2PAtt_CRMHandler.orderList[0].OF_IDOrdineOLO__c;
                    a.type='Temp';
                    insert a;
                    for(order ord:PO_P2PAtt_CRMHandler.orderList){
                        ord.OF_AccountTemporaneo__c=ord.AccountId;
                        ord.OF_ContractTemporaneo__c=ord.ContractId;
                        ord.AccountId=a.Id;
                        ord.contractId=null;
                    }
                    update PO_P2PAtt_CRMHandler.orderList;
                    inserito=true; 
                }
            }
            catch(exception e){ 
                if(!templog){
                    t=OF_Utility.logMessageNew2(PO_P2PAtt_CRMHandler.orderList[0].OF_IDOrdineOLO__c,'E','PO_P2PAtt_CRMHandler','aggiornaOrdine',(x+1), e);
                    templog=true;
                }
                else{
                    t.OF_tentativi__c=(x+1);
                }
            }
            if(inserito==true){ 
                if(PO_P2PAtt_CRMHandler.checkKIT){
                    PO_P2PAtt_CRMHandler.caseKit.OF_Order__c=PO_P2PAtt_CRMHandler.MapIdCaseOrder.get(PO_P2PAtt_CRMHandler.caseKit.Id).Id;
                }
                break;
            }
        }
        if(templog){
            insert t;
        }
        return assetList;
    }
    
    public static list<OF_CommercialElementIstanziato__c> createCEI(Case c,List<Asset> aList){
        List<OF_CommercialElementIstanziato__c > ceiList=[select id,OF_CaseTratta__c,OF_SA_Vlan__c from OF_CommercialElementIstanziato__c
                                                          where OF_CaseTratta__c=:c.Id or PO_Case_ordine__c=:c.Id];
        for(OF_CommercialElementIstanziato__c cei : ceiList){ 
            if(!String.isBlank(cei.OF_CaseTratta__c)){
                cei.OF_AssetTratta__c=aList[0].Id;
            }
            else{
                cei.OF_VLAN__c=aList[0].Id;
            }
        }
        OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
        String tipoCE;
        if(c.PO_Tipo_percorso__c == 'Singola Via' ){
            if(c.PO_Numero_fibre_richieste__c=='1'){
                tipoCE='SINGOLA VIA MONOFIBRA';
            }
            else{
                tipoCE='SINGOLA VIA BIFIBRA';
            }
        }
        else if(c.PO_Tipo_percorso__c == 'Doppia Via'){
            if(c.PO_Numero_fibre_richieste__c=='1'){
                tipoCE='DOPPIA VIA MONOFIBRA';
            }
            else{
                tipoCE='DOPPIA VIA BIFIBRA';
            }
        }
        Map<String,ID> mapNameIdCE = new Map<String,ID>();
        for(OF_CommercialElement__c CE :[select Id,name from OF_CommercialElement__c where OF_Servizio__r.name='P2P Attiva']){
            mapNameIdCE.put(CE.Name,CE.Id);
        }
        cei.OF_CommercialElement__c=mapNameIdCE.get(tipoCE);
        cei.OF_Asset__c = c.assetID;
        cei.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Portalino');
        ceiList.add(cei);
        if(PO_P2PAtt_CRMHandler.checkKIT){
            OF_CommercialElementIstanziato__c ceiKIT = new OF_CommercialElementIstanziato__c(); 
            ceiKIT.OF_CommercialElement__c=mapNameIdCE.get(tipoCE);
            ceiKIT.OF_Asset__c = aList[1].Id;
            ceiKIT.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('PO_Portalino');
            ceiList.add(ceiKIT);
        }
        upsert ceiList;
        return ceiList;
    }
    
    public static list<PricebookEntry> createPBE(Case c,List<Asset> aList){
        list<PricebookEntry> listPBE = new list<PricebookEntry>();
        for(opportunityLineItem oppLinItem : [select id,PricebookEntryID from OpportunityLineItem  
                                              where Opportunity.PO_Collegamento__c=:c.PO_Case_Collegamento__c]){
                                                  PriceBookEntry PBE= new PriceBookEntry();
                                                  PBE.id=oppLinItem.PricebookEntryID;
                                                  PBE.OF_Asset__c=aList[0].Id;
                                                  PBE.IsActive=true;
                                                  PBE.OF_DataAttivazione2__c=system.now();
                                                  listPBE.add(PBE);                                     
                                              }
        if(PO_P2PAtt_CRMHandler.checkKIT){
            Pricebook2 pbKitMaster = [select Id, Name,  IsActive,  OF_Listino__c, Commercial_element__c, PO_Commercial_element__c, 
                                      PO_Contratto__c, PO_Commercial_element__r.name from Pricebook2 
                                      where PO_Commercial_element__r.name='KIT DI CONSEGNA'
                                      AND OF_Master__c=true];
            Pricebook2 pbKit = pbKitMaster.clone(false,true,false,false);
            Insert pbKit;
            PriceBookEntry PBEKITMaster= [select Id, Name,  Product2Id, UnitPrice, IsActive,
                                          pricebook2.PO_Commercial_element__r.name from PricebookEntry 
                                          where pricebook2.PO_Commercial_element__r.name='KIT DI CONSEGNA'
                                          AND OF_Master__c=true];
            PriceBookEntry PBEKIT=PBEKITMaster.clone(false,true,false,false);
            PBEKIT.Pricebook2Id=pbKit.Id;
            PBEKIT.OF_Asset__c=aList[1].Id;
            PBEKIT.OF_DataAttivazione2__c=system.now();
            listPBE.add(PBEKIT);
        }
        upsert listPBE;
        return listPBE;
    }

    */
}