trigger Create_Asset on EOF_Notify__c (after update,before insert,before update) {
    /*
//system.debug('DG29 Siamo dentro Trigger Create_Asset on EOF_Notify__c 1');
    if(!trigger.new.get(0).EOF_Inviata__c && !trigger.new.get(0).Tipo_Comunicazione__c.containsIgnoreCase('Trouble Ticket')){    
       // system.debug('DG29 Siamo dentro Trigger Create_Asset on EOF_Notify__c 2');
        if(trigger.isAfter){
            /**OS_24**/
           // system.debug('OS_isAfter');
           /*
            List<Asset> newAssetList = new List<Asset>();
            Set<Id> idNotifyRecs = new Set<Id>();
            Map<Id,String> mapNotIdRichestaVal = new Map<Id,String>();
            Map<String,Id> mapCordiceOLOVsNotifyId = new Map<String,Id>();
            List <EOF_Notify__c> lstNotifyRecs = new List<EOF_Notify__c>();
            List<EOF_EAI_Service_Log__c> lstEAIServLogToUpdate = new List<EOF_EAI_Service_Log__c>();
            for(EOF_Notify__c o: trigger.new){ 
                if(String.isNotBlank(o.EOF_ID_Risorsa__c) && o.Tipo_Comunicazione__c == 'Notifica di espletamento'){
                    system.debug('DG29 Siamo dentro Trigger Create_Asset on EOF_Notify__c 3');
                    String NotifyId = o.Id;
                    List <EOF_Notify__c> NotifyList = [select id, EOF_ID_Risorsa__c,Caso__c,Caso__r.EOF_ID_Building_WS__c,Caso__r.EOF_Impresa__c,Caso__r.EOF_Codice_Operatore_WS__c,
                                                       EOF_Codice_Motivazione_Rimodulazione__c, EOF_Codice_Operatore__c, RecordType.Name,EOF_GPON_Attestazione__c,
                                                       EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c 
                                                       from EOF_Notify__c 
                                                       where Id =: NotifyId];
                    
                    List <Case> CaseList = [select id, CaseNumber, AccountId,EOF_Id_Risorsa__c, AssetId,EOF_GPON_Attestazione__c,EOF_Codice_Operatore_WS__c,EOF_Impresa__c,
                                            EOF_Provincia_WS__c,EOF_Numero_Civico_WS__c,EOF_Comune_WS__c,EOF_Identificativo_del_POP__c, EOF_ID_Building_WS__c,EOF_Indirizzo_WS__c,
                                            EOF_Particella_Toponomastica_WS__c, EOF_Scala_Palazzina_WS__c,EOF_SLA_Premium_Assurance__c from Case where id =: NotifyList[0].Caso__c];  
                    Case c=caselist[0];
                    
                    /* DG 17/03/2017 Commentato per nuova gestione creazione asset
                    Asset a = new Asset();
                    if(c.AccountId!=null){
                        a.AccountId = c.AccountId;
                    }
                    a.Status = 'Attivo';
                    a.name=c.Id; 
                    a.EOF_ID_Risorsa__c = NotifyList[0].EOF_ID_Risorsa__c;
                    //a.Network_Inventory__c = ni[0].Id;
                    a.EOF_OLO__c = c.EOF_Codice_Operatore_WS__c;
                    a.EOF_Impresa__c = c.EOF_Impresa__c;
                    a.OF_Civico__c=c.EOF_Numero_Civico_WS__c;
                    a.OF_Comune__c=c.EOF_Comune_WS__c;
                    a.OF_GPON_Attestazione__c= NotifyList[0].EOF_GPON_Attestazione__c;
                    a.OF_ID_Building__c=c.EOF_ID_Building_WS__c;
                    a.OF_Identificativo_del_POP__c=c.EOF_Identificativo_del_POP__c;
                    a.OF_Indirizzo__c=c.EOF_Indirizzo_WS__c;
                    a.OF_Particella_Toponomastica__c=c.EOF_Particella_Toponomastica_WS__c;
                    a.OF_Provincia__c=c.EOF_Provincia_WS__c;
                    a.OF_Scala_Palazzina__c=c.EOF_Scala_Palazzina_WS__c;
                    //parte nuova ---------------------------------
                    a.EOF_SLA_Premium_Assurance__c=c.EOF_SLA_Premium_Assurance__c;
                    a.EOF_ID_Splitter_Secondario__c=notifyList[0].EOF_ID_Splitter_Secondario__c;
                    a.EOF_Posizione_Splitter_Secondario__c=notifyList[0].EOF_Posizione_Splitter_Secondario__c;
                    //--------------------------------------
                    insert a;
                    END DG */
                    /*
                    c.EOF_Id_Risorsa__c=NotifyList[0].EOF_ID_Risorsa__c;
                    //c.AssetId=a.id; //DG 17/03/2017 Commentato per nuova gestione creazione asset
                    c.canModify__c = true;
                    update CaseList;
                } 
                idNotifyRecs.add(o.Id); 
            }
            
            
       } 
        
        
    }
    */
}