public class OF_SendRetryChangeOrder_Methods {
    @future(callout=true)  
    public static void retryCalloutSFOM(String caseId,String rtypeDevName, string codiceOrdineOLO){
        
        //vado a creare la mappa dei recordtype per poi utilizzarla
        OF_CO_GE_Utils.RTMap = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
        }
        OF_CO_GE_Utils.checkRTMap=true;   
        
        //setto la variabile retry che andrò a mettere sui sl
        OF_CO_GE_Utils.retry=true;
        
        //faccio il check sul processo in quanto sono diversi i campi da estrarre
        OF_CO_GE_Utils.caseOriginale = [SELECT Id,OF_Response_Da_OLO__c,OF_Response_Da_OM__c,Codice_Ordine_EOF__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Ordine_OLO__c,
        								EOF_Data_Notifica__c, EOF_Id_Notifica__c, EOF_Id_Risorsa__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, 
        								OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c,EOF_Account_OLO__c,caseNumber,assetId,EOF_Codice_Errore__c,
        								EOF_Causale_Errore__c,status
                                        FROM Case
                                        WHERE Id = :caseId 
                                        LIMIT 1];
        
        
        
        OF_CO_GE_Utils.caseOriginale.OF_Retry_Automatico__c=false;
        //Controllo se fare la retry verso OLO o verso OM
        if( OF_CO_GE_Utils.caseOriginale.OF_Response_Da_OLO__c=='NACK TECNICO' ){//NACK DA OLO
            //Creo il log della request
            OF_CO_GE_Utils.slSFOLO=[select EOF_CODICE_OPERATORE__c,EOF_CODICE_ORDINE_OLO__c,EOF_CODICE_ORDINE_EOF__c,EOF_DATA_NOTIFICA__c,
						            EOF_ID_NOTIFICA__c,EOF_STATO_ORDINE__c,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c,
						            EOF_GPON_Attestazione__c,EOF_NOME_CLIENTE__c,EOF_COGNOME_CLIENTE__c,
						            EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
						            EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c 
						            from EOF_EAI_Service_Log__c
						            where caso__c=:OF_CO_GE_Utils.caseOriginale.id
						            AND OF_SA_Direzione_Flusso__c='SF - OLO'
						            AND OF_SA_Metodo__c='OF_StatusUpdate'];
            OF_CO_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(OF_CO_GE_Utils.slSFOLO); //effettua la callOut 
            
            insert OF_CO_GE_Utils.slSFOLOResp;
            update OF_CO_GE_Utils.caseOriginale;
        }
        else if ( OF_CO_GE_Utils.caseOriginale.OF_Response_Da_OM__c=='NACK TECNICO' ) {//NACK DA OM
            List<OF_CommercialElementIstanziato__c> listVLAN = [Select Id, OF_KITCONSEGNAVLAN__C, OF_USERVLAN__C, OF_SERVICEVLAN__C, OF_PROFILOVLAN__C, OF_CUSTOMERVLAN__C, OF_MODELLODISERVIZIOVLAN__C, OF_INFORMAZIONIVLAN__C
                                                            from OF_CommercialElementIstanziato__c 
                                                            where RecordType.DeveloperName = 'OF_VLAN'
                                                            and OF_Case__c =: OF_CO_GE_Utils.caseOriginale.Id];
            OF_CO_OLO_SendToOM.OM_CreateAckNackRequestActivation(OF_CO_GE_Utils.caseOriginale, listVLAN);
            //setto il parametro OF_Retry_Automatico__c a false per in caso essere ripescato al successivo retry
            update OF_CO_GE_Utils.caseOriginale; 
        }
    }
}