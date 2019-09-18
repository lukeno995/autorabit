/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to PSM/Remedy
* SI:           doc. "Specifiche di Interfaccia SalesForce – PSM/Remedy" 
*/

public class PO_FATT_WS_IN_Espletamento {

    public static ID createAssetId{get;set;}
    public Case originalCase {get;set;}    
    
    public PO_FATT_WS_IN_Espletamento(Case oC){ 
        originalCase=oC;
    }

    public void espletamento_OK(){
  
        originalCase.Status = 'Espletato';
        originalCase.EOF_Fase__c = 'Espletato';
        originalCase.OF_AggiornoOrdine__c = true;
  
        Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
        system.debug('#####'+mapCaseOrder);
        OF_CaseOrderStateModelCS__c CustSett;
        
        for(String CaseOrderCS : mapCaseOrder.Keyset()){
            if( (originalCase.status == mapCaseOrder.get(CaseOrderCS).OF_StatoCase__c) && 
                ((String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineIRU__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLease__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLink__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2P__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineEventoTemporaneo__c).left(15)))){
                 CustSett = mapCaseOrder.get(CaseOrderCS);
                 break; 
            }
        }
        Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();

        List<Order> o1List=[Select Id, OwnerId, ContractId, AccountId, Pricebook2Id, OriginalOrderId, OpportunityId, QuoteId, RecordTypeId, 
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
                            PO_LunghezzaOttica__c, PO_Opportunity__c, PO_PosizioneRilascioCircuitoOSU__c, isFiberLease__c, isFiberLink__c 
                            FROM Order 
                            //FIX 22.05.2018 Where Id = :originalCase.OF_Order__c];
                            // fix 04.05.2018 Where Id = :originalCase.PO_Case_collegamento__r.OF_Order__c];
                            Where Id = :originalCase.OF_Order__c];
        
                            System.debug('PO_FATT_WS_IN_Espletamento - originalCase:'+originalCase);
                            System.debug('PO_FATT_WS_IN_Espletamento - o1List[0]:'+o1List[0]);
                            System.debug('PO_FATT_WS_IN_Espletamento - CustSett:'+CustSett);
                            System.debug('PO_FATT_WS_IN_Espletamento - mapCodifica'+mapCodifica);
                            

        AggiornoOrdine(originalCase, o1List[0], CustSett, mapCodifica);
        
        PO_FATT_WS_IN_UtilitiesPortalino costruttore = new PO_FATT_WS_IN_UtilitiesPortalino();

        String proc = 'Portalino';
        if( o1List[0].isFiberLink__c == true){
            proc = 'FiberLink';
        }
        else if( o1List[0].isFiberLease__c == true ){
            proc = 'FiberLease';
        }
        costruttore.PO_CreatePBE_Portalino( o1List , proc);

        if(PO_FATT_WS_IN_ESPLETAMENTO.createAssetId!=null){
            originalCase.assetId = PO_FATT_WS_IN_ESPLETAMENTO.createAssetId;
            o1List[0].OF_Asset__c = PO_FATT_WS_IN_ESPLETAMENTO.createAssetId;
        }
        update o1List[0];
        update originalCase;
    }
    
    public void espletamento_KO(){

        originalCase.Status = 'Espletato KO';
        originalCase.EOF_Fase__c = 'Espletato KO';
        originalCase.OF_AggiornoOrdine__c = true;

        Map <string, OF_CaseOrderStateModelCS__c> mapCaseOrder = OF_CaseOrderStateModelCS__c.getAll();
        OF_CaseOrderStateModelCS__c CustSett;

        for(String CaseOrderCS : mapCaseOrder.Keyset()){
            if( (originalCase.status == mapCaseOrder.get(CaseOrderCS).OF_StatoCase__c) && 
                ((String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineIRU__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLease__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineFiberLink__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineP2P__c).left(15)) || 
                 (String.valueOf(originalCase.recordtypeid).left(15) == String.valueOf(mapCaseOrder.get(CaseOrderCS).PO_RecordTypeCaseOrdineEventoTemporaneo__c).left(15)))){
                 CustSett = mapCaseOrder.get(CaseOrderCS);
                 break; 
            }
        }
        
        Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
        
        List<Order> o1List=[Select Id, OwnerId, ContractId, AccountId, Pricebook2Id, OriginalOrderId, OpportunityId, QuoteId, RecordTypeId, 
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
                            PO_LunghezzaOttica__c, PO_Opportunity__c, PO_PosizioneRilascioCircuitoOSU__c, isFiberLease__c, isFiberLink__c 
                            FROM Order 
                            Where Id = :originalCase.OF_Order__c];
                            
                            System.debug('@@@originalCase'+originalCase);
                            System.debug('@@@o1List[0]'+o1List[0]);
                            System.debug('@@@CustSett'+CustSett);
                            System.debug('@@@mapCodifica'+mapCodifica);

        AggiornoOrdine(originalCase, o1List[0], CustSett, mapCodifica);
        
        
        update o1List[0];
        update originalCase;
    }
    
    //Metodo copiato dalla classe OF_UtilitiesManageOrderFromCase

    public static void AggiornoOrdine(case c, order o1, OF_CaseOrderStateModelCS__c CSCaseOrder, Map <string, OF_CodificaProfiloListini__c> mapCodifica){
            o1.status = CSCaseOrder.OF_StatoOrder__c;
            o1.OF_Esito__c = CSCaseOrder.OF_EsitoOrder__c;
            
            if( CSCaseOrder.OF_EsitoOrder__c != null)
                o1.OF_DataEsito__c = system.Today();
            
            //DG aggiunti campi sull'ordine per poterli gestire a livello di asset (non saranno visibili sull'ordine)
            o1.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
            o1.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
            o1.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
            o1.OF_Apparato__c = c.EOF_Apparato__c;
            o1.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
            o1.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
            o1.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
            //31/05/2017 aggiunti campi da passare all'asset
            //14/07/2017 modificata logica OF_profilo__c --> viene fatta una codifica presente nel custom setting OF_CodificaProfiloListini__c
            if(c.OF_SA_Profilo__c != null)
            {
                //27/09/2017 Modifica CRM - nel custom setting OF_CodificaProfiloListini__c viene scritto tutto il profilo e non solo le prime due lettere
                //o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c.substring(0,2)).OF_Profilolistino__c;
                if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
                    o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
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
            
            /* 12/07/2017 PO */
            o1.PO_Attenuazione__c = c.PO_Attenuazione__c ;
            o1.PO_LunghezzaOttica__c = c.PO_Lunghezza_Ottica__c;
            o1.PO_PosizioneRilascioCircuitoOSU__c = c.PO_Posizione_Rilascio_Circuito_OSU__c;
            if(c.PO_Data_Attivazione_Ordine__c != null) {
                string str = c.PO_Data_Attivazione_Ordine__c + ' 00:00:00';
                o1.PO_DataAttivazioneOrdine__c = datetime.valueOf(str);
            }
     }
}