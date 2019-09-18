public class OF_CO_OLO_AsyncChecks {     
    
    //PG - 21-05 - Controlli asincroni Change Order
    @future(callout=true)  
    public static void OLO_AsyncChangeOrder(String caseId, String idserviceLog){   
        EOF_EAI_Service_Log__C sl_log;
        OF_CO_GE_Utils.slSFOLO = sl_log;
        System.debug('START - CHECK ASINCRONI');
        Case c = [Select Id, PO_SA_Portale__c, CaseNumber, Status, EOF_ID_Risorsa__c,Codice_ordine_Eof__c, EOF_Account_OLO__c,
                EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,
                EOF_Data_Notifica__c, EOF_Id_Notifica__c,recordtype.developername, 
                EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,EOF_FASE__c,
                EOF_GPON_Vincolante__c,OF_SA_Motivazione__c,OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, 
                OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c ,OF_Bonifica_Locked_Row__c
                from Case 
                where id=:caseId];

        OF_CO_GE_Utils.caseOriginale = c;
        OLO_ID__c oloId = OLO_ID__c.getInstance(OF_CO_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_CO_GE_Utils.caseOriginale.EOF_Account_OLO__c = oloId.OF_Olo_Id__c;              
        System.debug('***Eccomi***');
        //Verificare l'asset
        List<Asset> assetList = [select Id, name, status, Account.EOF_Codice_Operatore__c, 
                                OF_ProfiloOpenStream__c,EOF_Id_Risorsa__c
                                from Asset                               
                                where recordtype.name = 'Open Stream'
                                and Account.EOF_Codice_Operatore__c=:c.EOF_Codice_Operatore_WS__c
                                and Name=:c.EOF_ID_Risorsa__c];
        System.debug('çççç__Vediamo__çççç');
        //Verificare se sia presente una richiesta di cessazione in corso
        /*List<Case> listCaseCessazione = [Select id, recordtypeId, recordtype.name, status, asset.name
                                         from Case
                                         where recordtype.name = 'EOF_Caso_Cessazione_OPENSTREAM'
                                         and asset.name =:c.EOF_Id_Risorsa__c];
        */

        List<Case> listCase = [Select id, recordtypeId, recordtype.name, status, asset.name, OF_SA_ID_Servizio__c
                                         from Case
                                         where ( (recordtype.name = 'EOF_Caso_Cessazione_OPENSTREAM' and status = 'Acquisito') OR (recordtype.name = 'EOF_Caso_Attivazione_OPENSTREAM' and status='Espletato'))
                                         and asset.name =:c.EOF_Id_Risorsa__c];

        /*List<OF_CommercialElementIstanziato__c> listVLAN = [Select id, name, OF_Case__c, OF_KITCONSEGNAVLAN__C,
                                                            OF_USERVLAN__C, OF_SERVICEVLAN__C, 
                                                            OF_PROFILOVLAN__C, OF_CUSTOMERVLAN__C, OF_MODELLODISERVIZIOVLAN__C,
                                                            OF_INFORMAZIONIVLAN__C  
                                                            from OF_CommercialElementIstanziato__c                                                           
                                                            where RecordType.DeveloperName = 'OF_VLAN'
                                                            and OF_Case__c =: c.id];*/
        //AA: Recupero la lista di sLog rappresentativi delle VLAN
        System.debug('---Prima di sLogList---');
        List<EOF_EAI_Service_Log__c> sLogList = [SELECT OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_USER_VLAN__C, OF_SA_SERVICE_VLAN__C, OF_SA_PROFILO_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c
                                                 FROM EOF_EAI_Service_Log__c
                                                 WHERE OF_SA_VLan_Log__c = :idserviceLog];
        System.debug('°°°Prima della chiamata di generateVLAN°°°: '+slogList.size());
        //Done AA: POPOLARE LISTA VLAN con il metodo creato
        
        List<OF_CommercialElementIstanziato__c> listVLAN = OF_CO_OLO_AsyncChecks.generateVLANbysLog(sLogList, caseId);
        System.debug('°°°Dopo la chiamata di generateVLAN°°°');
        List<EOF_EAI_Service_Log__c> list_serviceLogs = [Select id, EOF_PROFILO__c, EOF_ID_Notifica__c
                                                         from EOF_EAI_Service_Log__c
                                                         where id =: idserviceLog];

        System.debug(']]]]list_serviceLogs: '+list_serviceLogs.size());

        // CONTROLLI ASINCRONI CON ESITO KO
        //se la lista è vuota (asset non presente)
        if(assetList.isEmpty())
        {
            c.OF_SA_Motivazione__c = 'ID Risorsa da modificare inesistente/errato';
            c.EOF_Causale_Errore__c = 'ID Risorsa da modificare inesistente/errato';
            c.OF_SA_Codice_Motivazione__c = 'D13';
            c.EOF_Codice_Errore__c = 'D13'; 
            System.debug(c.OF_SA_Motivazione__c);
            c.status = 'Modificato KO';
            System.debug('ASSET_LIST VUOTA');
            sl_log = OF_CO_GE_Utils.CreateAcquisition_Log(c);
            System.debug('**** AA Service log ASSET LIST VUOTA!! ' + sl_log);
            OF_CO_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut  
            System.debug('**** RESPONSE DA OLO!! ' + c.OF_Response_Da_OLO__c + '\n*****OGGETTO CASE ' + c);
            
        }
        else{ 
        	c.AssetId = assetList.get(0).Id;
        	if(assetList.get(0).status.equalsIgnoreCase('In Modifica')){ //verifico se sia presente una richiesta   
	            c.OF_SA_Motivazione__c = 'Richiesta di modifica già aperta';    
	            c.EOF_Causale_Errore__c = 'Richiesta di modifica già aperta';
	            c.OF_SA_Codice_Motivazione__c = 'D16';
	            c.EOF_Codice_Errore__c = 'D16'; 
	            c.status = 'Modificato KO';                       
	            System.debug('--IN MODIFICA--');                              
	            sl_log = OF_CO_GE_Utils.CreateAcquisition_Log(c);
	            OF_CO_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut  
	            
	        }
	        else if(assetList.get(0).status.equalsIgnoreCase('Cessato')){//verifico se sia un asset cessato
	            c.OF_SA_Motivazione__c = 'Servizio cessato';   
	            c.EOF_Causale_Errore__c = 'Servizio cessato';
	            c.OF_SA_Codice_Motivazione__c = 'D15';
	            c.EOF_Codice_Errore__c = 'D15'; 
	            c.status = 'Modificato KO';                       
	            System.debug('--IN MODIFICA--');                              
	            sl_log = OF_CO_GE_Utils.CreateAcquisition_Log(c);
	            OF_CO_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut  
	            
	        }
	    }
        if (!c.status.equalsIgnoreCase('Modificato KO')){
            //Popolo la lista di cessazioni
            System.debug('@@@Test');
            List<Case> listCaseCessazione = new List<Case>();
            for (Case cas : [Select id, recordtypeId, recordtype.name, status, asset.name, OF_SA_ID_Servizio__c
                                                from Case
                                                where ( (recordtype.name = 'EOF_Caso_Cessazione_OPENSTREAM' and status = 'Acquisito') OR (recordtype.name = 'EOF_Caso_Attivazione_OPENSTREAM' and status='Espletato'))
                                                and asset.name =:c.EOF_Id_Risorsa__c] ){
                                                 System.debug('@@@cas'+cas.recordtype.name);
                                                    System.debug('@@@cas'+asset.name);
                if (cas.recordtype.name.equalsIgnoreCase('EOF_Caso_Cessazione_OPENSTREAM')){
                    listCaseCessazione.add(cas);
                }else if(cas.recordtype.name.equalsIgnoreCase('EOF_Caso_Attivazione_OPENSTREAM')) {
                    OF_CO_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c = cas.OF_SA_ID_Servizio__c;
                }
            }
            // si verifica se è presente un case di Cessazione
            if( !listCaseCessazione.isEmpty() )
            {
                c.OF_SA_Motivazione__c = 'Presenza di una richiesta di Cessazione';
                c.EOF_Causale_Errore__c = 'Presenza di una richiesta di Cessazione';
                c.OF_SA_Codice_Motivazione__c = 'D16';
                c.EOF_Codice_Errore__c = 'D16';
                c.status = 'Modificato KO';
                System.debug('####Presenza di una richiesta di Cessazione###');
                sl_log = OF_CO_GE_Utils.CreateAcquisition_Log(c);
                OF_CO_GE_Utils.makeCalloutOLOOM(sl_log); //effettua la callOut 
                
            }
            
        }
        System.debug('--------Prima dell\'if della chiamata ad OM----');
        //Controlli asincroni superati
        if (!c.status.equalsIgnoreCase('Modificato KO')){
            //Se i controlli Asincroni vengono superati viene richiamato OM
            System.debug('--------Prima della chiamata ad OM----');
            
            c.status = 'Acquisito'; 
            
            //chiamare webService SF->OM e dopo procedere alla creazione dell'ordine
            String OM_Resp = OF_CO_OLO_SendToOM.OM_CreateAckNackRequestActivation(c, listVLAN);
            
            update c;
            assetList.get(0).status = 'In Modifica'; 
            update assetList.get(0);
            //Done AA : INSERT LISTA VLAN
            insert listVLAN;
        }else{//Se è stato trovato un errore vengono inseriti i log di statusupdate verso OLO e viene aggiornato lo stato del case
            //Done AA : SPOSTARE TUTTE LE INSERT/UPDATE DI MODIFICATO KO E INSERIRE LISTA VLAN
            insert sl_log; //Log che viene inviato da SF-->OLO
            System.debug('**** ASYNC CHECKS REQUEST LOG ' + sl_log);
            OF_CO_GE_Utils.slSFOLOResp.EOF_SL_Riferimento__c = sl_log.Id;
            insert OF_CO_GE_Utils.slSFOLOResp;
            System.debug('**** ASYNC CHECKS RESPONSE LOG ' + OF_CO_GE_Utils.slSFOLOResp);
            
            update c;
            //Done AA : INSERT LISTA VLAN
            insert listVLAN;
        }
    }
    //Done AA : Creare un metodo che dati i sLog, creino la lista di vlan 
    public static List<OF_CommercialElementIstanziato__c> generateVLANbysLog(List<EOF_EAI_Service_Log__c> sLogList, String caseId){
        
        //Lista di VLAN da restituire 
        List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();
        //RECUPERO L'Id del Commercial Element relativo alle VLAN
        Id vlanCEId = [SELECT Id 
                        FROM OF_CommercialElement__c 
                        WHERE OF_Servizio__r.Name='Open Stream' 
                        AND Name='VLAN' LIMIT 1].Id;
        System.debug('Sono qui:'+vlanCEid);
        //('OSCRM OK');
        if(!OF_CO_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_CO_GE_Utils.RTMap = new  map<String,String>();

            for(recordtype rt : [select id,developername from recordtype]){
                OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_CO_GE_Utils.checkRTMap=true;
        } 
        System.debug('***Size sLogList***:' +sLogList);
        for (EOF_EAI_Service_Log__C sLog : sLogList){
            //CEI che aggiungerò alla lista da restituire
            OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();   
                cei.recordtypeid=OF_CO_GE_Utils.rtMap.get('OF_VLAN');
                cei.OF_KITCONSEGNAVLAN__C = sLog.OF_SA_KIT_CONSEGNA_VLAN__c;
                cei.OF_USERVLAN__C = sLog.OF_SA_USER_VLAN__C;
                cei.OF_SERVICEVLAN__C = sLog.OF_SA_SERVICE_VLAN__C;
                cei.OF_PROFILOVLAN__C = sLog.OF_SA_PROFILO_VLAN__c;
                cei.OF_CUSTOMERVLAN__C = sLog.OF_SA_CUSTOMER_VLAN__c;
                cei.OF_MODELLODISERVIZIOVLAN__C = sLog.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
                cei.OF_INFORMAZIONIVLAN__C = sLog.OF_SA_INFORMAZIONI_VLAN__c;
                //Lego le VLAN al Case
                cei.OF_Case__c = caseId;
                cei.OF_SA_VLAN__c = caseId;
                //Imposto il CEI di tipologia VLAN
                cei.OF_CommercialElement__c = vlanCEId;
            
            ceiList.add(cei);
        }
        return ceiList;
    }
}