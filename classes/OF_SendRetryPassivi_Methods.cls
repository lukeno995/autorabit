public class OF_SendRetryPassivi_Methods {
    @future(callout=true)  
    public static void retryCalloutOLOOM(String caseId,String rtypeDevName, string codiceOrdineOLO){
        
        system.debug('Alessandro: '+caseId+', '+rtypeDevName+', '+codiceOrdineOLO);
        //vado a creare la mappa dei recordtype per poi utilizzarla
        OM_GW_GE_Utils.RTMap = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype where sobjectType='EOF_EAI_Service_Log__c']){
            OM_GW_GE_Utils.RTMap.put(rt.developername,rt.id);
        }
        OM_GW_GE_Utils.checkRTMap=true;   
        
        //setto la variabile retry che andrò a mettere sui sl
        OM_GW_GE_Utils.retry=true;
        
        //faccio il check sul processo in quanto sono diversi i campi da estrarre
        if(rtypeDevName=='EOF_Caso_Attivazione'){
            OM_GW_GE_Utils.caseOriginale = Database.query(OM_GW_GE_Utils.getQuery('case','Attivazione')+
                                                                                            ' where id=:caseId');
        } 
        else{
            OM_GW_GE_Utils.caseOriginale = Database.query(OM_GW_GE_Utils.getQuery('case','Cessazione')+
                                                                                            ' where id=:caseId');
        }
        OM_GW_GE_Utils.caseOriginale.OF_Retry_Automatico__c=false;
        
        //caso in cui il nack è sull'acquisizione verso OLO
        if(String.isBlank(OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OM__c)){
        	//setto la variabile retryToOLO
        	OM_GW_GE_Utils.retryToOLO=true;
        	
            OM_GW_GE_Utils.slSFOLO = [select Id,EOF_Codice_Operatore__c,EOF_Tipo_Comunicazione__c,EOF_Codice_Ordine_OLO__c,EOF_Codice_Ordine_EOF__c,                                                                        
			EOF_ID_Notifica__c,EOF_Stato_Richiesta__c,EOF_Cod_Rifiuto_Sospensione_Annullamento__c,EOF_Mot_Rifiuto_Sospensione_Annullamento__c,
			EOF_Data_Notifica__c,Caso__c, EOF_Tipo_Comunicazione_string__c
            from EOF_EAI_Service_Log__c 
            where EOF_Codice_Ordine_Olo__c=:OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_Olo__c
            AND Caso__c=:OM_GW_GE_Utils.caseOriginale.Id
            AND recordtypeId=:OM_GW_GE_Utils.RTMap.get('FiberNotify')
            order by createdDate ASC limit 1];  
            system.debug('OM_GW_GE_Utils.slSFOLO======='+OM_GW_GE_Utils.slSFOLO);
            OM_GW_Utils.createAckNackNotifyServiceLog(OM_GW_GE_Utils.slSFOLO);
        }
        else if(OM_GW_GE_Utils.caseOriginale.OF_Response_Da_OM__c=='NACK TECNICO'){
        	//setto la variabile retryToOLO
        	OM_GW_GE_Utils.retryToOM=true;
        	
        	OM_GW_GE_Utils.slSFOM = [select RecordTypeId ,eof_codice_operatore__c,EOF_Tipo_Comunicazione__c ,EOF_Tipo_COmunicazione_String__c,
        	EOF_Codice_Ordine_OLO__c ,EOF_Data_Notifica__c ,EOF_ID_Notifica__c ,EOF_ID_Pop__c,EOF_GPON_Attestazione__c,EOF_GPON_Vincolante__c,
        	EOF_ID_Risorsa__c,EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
        	EOF_PRovincia__c,EOF_PARTICELLA_TOPONOMASTICA__c,EOF_INDIRIZZO__C,EOF_NUMERO_CIVICO__c,EOF_ID_BUILDING__c,
        	EOF_SCALA_PALAZZINA__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
        	EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_RECAPITO_TEST_LINEA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,EOF_PASSWORD_APPARATO__c,
        	EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c,EOF_OPZIONE_SYSTEM_UNICO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,
        	EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__C,EOF_CODICE_RICHIESTA_ANNULLAMENTO__c,EOF_APPARATO__c,EOF_TIPOLOGIA_APPARATO__c,
        	EOF_PROGETTO_SPECIALE__c,EOF_COLLEGAMENTO_P2P__c,EOF_NOTE__c,EOF_TIPOLOGIA_SERVIZIO__c,EOF_SLA_PREMIUM_ASSURANCE__c,
        	EOF_ORARIO_APPUNTAMENTO__c,caso__c,EOF_COdice_ordine_EOF__C,EOF_COMUNE__c,EOF_Richiesta_Notifica__c
            from EOF_EAI_Service_Log__c 
            where EOF_Codice_Ordine_Olo__c=:OM_GW_GE_Utils.caseOriginale.EOF_Codice_Ordine_Olo__c
            AND Caso__c=:OM_GW_GE_Utils.caseOriginale.Id
            AND recordtypeId=:OM_GW_GE_Utils.RTMap.get('FiberRequest')
            AND EOF_Tipo_COmunicazione_String__c like 'SF->OM%'
            order by createdDate ASC limit 1];   
        	
        	OM_GW_Utils.createAckNackNotifyServiceLog_CM_SOA(OM_GW_GE_Utils.caseOriginale);
        }
    }
}