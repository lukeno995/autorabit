public class OF_CO_OM_EntryChecks {
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksNotifyStatusUpdate(OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){
        
        //Mapping request
        OF_CO_GE_Utils.create_EAI_Log(su);

        if(su.STATO_ORDINE =='8'){
            OF_CO_GE_Utils.OPName ='Modificato';
        }
        if(su.STATO_ORDINE =='9'){
            OF_CO_GE_Utils.OPName ='Modificato KO';
        }
        OF_CO_GE_Utils.tmpl = new TEMPLOG__c();
        OF_CO_GE_Utils.tmpl.Name= su.CODICE_ORDINE_OLO +' - '+OF_CO_GE_Utils.OPName+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
        OF_CO_GE_Utils.tmpl.Timestamp__c= '0: ' +Datetime.now().format('HH:mm:ss','Europe/Rome');
        OF_CO_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ su.codice_ordine_olo;
        
        if(string.isblank(su.CODICE_OPERATORE)){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A05','CODICE_OPERATORE');
        }
        
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
        
            if(su.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        } 
        if(!olo_found){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A06','CODICE_OPERATORE');
        }
        if(string.isblank(su.CODICE_ORDINE_OLO)){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A05','CODICE_ORDINE_OLO');
        }
          
        if(string.isblank(su.CODICE_ORDINE_OF)){
       
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A05','CODICE_ORDINE_OF');
        }
        
        if(string.isblank(su.DATA_NOTIFICA)){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A05','DATA_NOTIFICA');
        }
        if(!test.isRunningTest()){
        if(!OF_CO_GE_Utils.checkDateTime(su.DATA_NOTIFICA)){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A06','DATA_NOTIFICA');
        }
        }
        if(string.isblank(su.ID_NOTIFICA)){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A05','ID_NOTIFICA');
        }
        if(su.ID_NOTIFICA.length()>100){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A06','ID_NOTIFICA');
        }    
        List<Case> cList;
        cList = [select id,status,PO_SA_Portale__C,OF_SA_Profilo__c,RecordType.DeveloperName,OF_Order__c,Previous_Status__c,EOF_ID_Risorsa__c from Case where EOF_codice_Ordine_OLO__c=:su.CODICE_ORDINE_OLO AND Codice_Ordine_Eof__C=:su.codice_ordine_of AND EOF_Codice_Operatore_WS__c=:su.CODICE_OPERATORE AND RecordType.DeveloperName ='EOF_Caso_ChangeOrder_OPENSTREAM'];
       system.debug('cList==========='+cList);
        OF_CO_GE_Utils.tmpl.Timestamp__c = OF_CO_GE_Utils.tmpl.Timestamp__c + ', QSU: '+Datetime.now().format('HH:mm:ss','Europe/Rome');
        if(cList.isEmpty()){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A06','CODICE_ORDINE_OLO/CODICE_ORDINE_OF');
        }
        else{
            OF_CO_GE_Utils.caseOriginale=cList[0];
            OF_CO_GE_Utils.checkCaseOriginale=true;
        }
        //verifico che lo status sia congruente
        
        if(cList[0].status!='Acquisito'){
            insert OF_CO_GE_Utils.slOMSF;
            return OF_CO_GE_Utils.syncError (su,'A07','STATUS: ' + OF_CO_GE_Utils.caseOriginale.status);
        }
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>(); 
        //Chiamata a OLO per inviare Status update
      
        Map<String,EOF_EAI_Service_Log__c> responseFromOLO =OF_CO_OM_SendToOLO.OM_CreateAckNackStatusUpdateDaOM(cList[0], su);
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOM = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
       
        if(responseFromOLO.containsKey('0')) {
            OF_CO_GE_Utils.slOMSF.EOF_Response__c = 'ACK';
            insert OF_CO_GE_Utils.slOMSF;
            // Recupero dell'asset 
            List<Asset> assetList = [select Id, name, status, Account.EOF_Codice_Operatore__c, 
                                    OF_ProfiloOpenStream__c,EOF_Id_Risorsa__c
                                    from Asset                               
                                    where recordtype.name = 'Open Stream'
                                    and Account.EOF_Codice_Operatore__c=:su.CODICE_OPERATORE
                                    and EOF_Id_Risorsa__c=:OF_CO_GE_Utils.caseOriginale.EOF_ID_Risorsa__c];
            if(su.STATO_ORDINE =='8'){
                //Lego l'asset al case
                OF_CO_GE_Utils.caseOriginale.assetId = assetList.get(0).Id;
                //Setto lo stato del case in "Modificato"
                OF_CO_GE_Utils.caseOriginale.status='Modificato OK';
                //Creo l'ordine e aggiorno i billing element
                OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderAsync(OF_CO_GE_Utils.caseOriginale.Id);
            }
            if(su.STATO_ORDINE =='9'){
                // case modificato ko
                OF_CO_GE_Utils.caseOriginale.status='Modificato KO';
                //Creo l'ordine KO
                OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderAsync(OF_CO_GE_Utils.caseOriginale.Id);
            }
            //Aggiorno il case
            update OF_CO_GE_Utils.caseOriginale;
            //Indipendentemente dall'esito del changeorder, riporto l'asset in attivo
            Asset ass =  assetList.get(0);
            ass.status='Attivo';
            if(su.STATO_ORDINE == '8'){
                ass.OF_ProfiloOpenStream__c = OF_CO_GE_Utils.caseOriginale.OF_SA_Profilo__c;
            }
            update ass;
            slList.add(responseFromOLO.get('0'));
            // todo aggiornamenti sul caso promozione classe promozione vlan modifiche ordine e creazione billing element 
            // assett modifica case chiuso ordine ok
            slList.add(OF_CO_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                'Codice_operatore' => su.CODICE_OPERATORE,
                'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
                'Flusso' => 'OM-SF',
                'Metodo' => 'OF_StatusUpdate',
                'ID_notifica' => su.ID_NOTIFICA,
                'Tipo Comunicazione' => 'OM->SF - ACK - OM_Notify_StatusUpdate',
                'Caso' => OF_CO_GE_Utils.caseOriginale.Id,
                'SL Riferimento' => OF_CO_GE_Utils.slOMSF.Id}));
            Insert slList;
            responseToOM.esito='0';
        }else{
            OF_CO_GE_Utils.slOMSF.EOF_Response__c = 'NACK';
            insert OF_CO_GE_Utils.slOMSF;
            slList.add(responseFromOLO.get('1'));
            // ordine chiuso
            responseToOM.esito='1';
            EOF_EAI_Service_Log__c sl= responseFromOLO.get('1');
            responseToOM.codice_motivazione=sl.EOF_CODICE_MOTIVAZIONE__C;
            responseToOM.motivazione=sl.EOF_MOTIVAZIONE__C;
            responseToOM.id_notifica=sl.EOF_Id_Notifica__c;
            
            slList.add(OF_CO_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK',
                'Codice_errore' => responseToOM.codice_motivazione,
                'Causale_errore' => responseToOM.motivazione,
                'Codice_operatore' => su.CODICE_OPERATORE,
                'Codice_ordine_OLO' => su.CODICE_ORDINE_OLO,
                'Flusso' => 'OM-SF',
                'Metodo' => 'OF_StatusUpdate',
                'ID_notifica' => su.ID_NOTIFICA,
                'Tipo Comunicazione' => 'OM->SF - NACK - OM_Notify_StatusUpdate',
                'Caso' => OF_CO_GE_Utils.caseOriginale.Id,
                'SL Riferimento' => OF_CO_GE_Utils.slOMSF.Id}));
            Insert slList;
        }
        return responseToOM;
    }
}