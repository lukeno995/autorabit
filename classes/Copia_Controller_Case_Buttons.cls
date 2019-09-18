public class Copia_Controller_Case_Buttons{
    private Case originalCase;
    public Integer notifyType{get;set;}    
    public String notifyStatus{get;set;}
    public String CaseId{get;set;}
    public String contactStatus{get;set;}
    public String browserSource{get;set;}
    public String idNotify{get;set;}
    public String recordTypeNotify{get;set;}    
    
    public static xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType  res_notify; 

    @AuraEnabled
    public static List<Case> getCodaOperatoriBO (){
        List<Case> COBO = [SELECT Id,CaseNumber,recordtype.name, status, EOF_Fase__C from case where owner.name ='Coda Operatori BO'];
        return COBO;
    }

    public Copia_Controller_Case_Buttons(ApexPages.StandardController stdController){
        originalCase = (Case)stdController.getRecord();  
        res_notify = new  xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType();        
        res_notify.CodiceErrore = '';                                                                     
    }

    public void create_notify(){  
        
        originalCase = [SELECT Id, Status, EOF_Fase__c, AccountId, owner.Name, EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,EOF_ID_Risorsa__c, EOF_Codice_Ordine_OLO__c,
                        EOF_GPON_Attestazione__c FROM Case WHERE Id =: CaseId];
        
        /*
        RecordType rtNotify = [SELECT Id FROM RecordType WHERE Name = 'FiberNotify' limit 1];
        RecordType rt_Ack = [SELECT Id FROM RecordType WHERE Name = 'ACK' LIMIT 1];
        RecordType rt_Nack = [SELECT Id FROM RecordType WHERE Name = 'NACK' LIMIT 1];        
   		*/
        idNotify = Copia_EOF_GW_Utils.create_notify(originalCase, notifyType, notifyStatus, null, null);
        recordTypeNotify='Notifica di '+EOF_GW_GE_Utils.retSpec(String.valueOf(notifyType));
        /*
        EOF_Notify__c ntf = [select id,recordType.Name,Tipo_Comunicazione__c,EOF_ID_Notifica__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,EOF_Data_Notifica__c,EOF_Codice_Ordine_OLO__c,
                            EOF_Codice_Ordine_EOF__c,EOF_GPON_Attestazione__c,Codice_Rifiuto_Sospensione_Annullamento__c,Motivo_Rifiuto_Sospensione_Annullamento__c,
                            EOF_Data_Espletamento_Ordine__c,EOF_ID_Risorsa__c,EOF_ID_Apparato_Consegnato__c,EOF_Esito_Consegna_Apparato__c,EOF_Parametri_Trasmissivi_Ottici__c,
                            EOF_ID_Splitter_Secondario__c,EOF_Posizione_Splitter_Secondario__c,EOF_Nuova_DAC__c,EOF_Codice_Motivazione_Rimodulazione__c, EOF_Orario_DAC__c,
                            EOF_Reason_Rimodulazione_DAC__c,EOF_Note__c,Flag_Pagamento__c,EOF_Stato_Richiesta_ctrl__c,EOF_Esito_Consegna_Apparato_ctrl__c,Numero_Operatore__c,EOF_Codice_Operatore__c from EOF_Notify__c where id=: idNotify];
            
        recordTypeNotify = ntf.recordType.Name;       
        EOF_Notify__c ntfcopy = new EOF_Notify__c();
        //ntf = EOF_GW_GE_Utils.updateFiberNotify(ntf);
        String reqString = EOF_GW_GE_Utils.copy_notify(ntf);
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
        						EOF_Tipo_comunicazione_String__c='SF->OLO - FiberNotify - '+EOF_GW_GE_Utils.retSpec(ntf.EOF_Tipo_Comunicazione_ctrl__c),
        						EOF_Tipo_comunicazione__c=ntf.EOF_Tipo_Comunicazione_ctrl__c,
                                Caso__c = originalCase.Id,
                                EOF_Codice_Operatore__c = originalCase.EOF_Codice_Operatore_WS__c,
                                RecordTypeId = rtNotify.id,
                                Notify__c = ntf.id,
                                EOF_Richiesta_Notifica__c = reqString,     
                                EOF_ID_Notifica__c = ntf.EOF_ID_Notifica__c,
                                EOF_Codice_Ordine_OLO__c = ntf.EOF_Codice_Ordine_OLO__c,
                                EOF_Data_Notifica__c = ntf.EOF_Data_Notifica__c       
                                );
        try{
        insert sl;
        
        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----
        //if(ntf.EOF_Codice_Operatore__c == 'VF'){
            //EOF_GW_Utils.createAckNackNotifyServiceLog(ntf.Id);
        //}
        }catch(Exception e){
            res_notify.CodiceErrore = e.getmessage();
        }
        */
        
        }
        
    public void contact_result(){
    system.debug('inside contact result---');
        originalCase = [SELECT Id, Status, EOF_Fase__c, AccountId, owner.Name, EOF_Codice_Operatore_WS__c, canModify__c FROM Case WHERE Id =: CaseId];
        
        system.debug('contactStatus ---'+contactStatus );
        system.debug('contactStatus11 ---'+originalCase.Status);
        system.debug('contactStatus123 ---'+originalCase.EOF_Fase__c);
        
        if (String.isNotBlank(caseId) && contactStatus == 'OK'){
            originalcase.canModify__c = true;
            originalCase.EOF_Fase__c='Appuntamento Fissato';
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule = true;
            originalCase.setOptions(dmo);
            update originalCase;
           
        }
        else if (String.isNotBlank(caseId) && contactStatus == 'KO'){
        originalCase = [SELECT Id, Status, EOF_Fase__c, AccountId, owner.Name,canModify__c, EOF_Codice_Operatore_WS__c FROM Case WHERE Id =: CaseId];
        originalcase.canModify__c = true;
        originalCase.Status='Sospeso';
        originalCase.EOF_Fase__c='Sospeso BO';
        update originalCase;       
        }
        else {
           apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'errore');
            ApexPages.addMessage(msg);
           }       
    }
}