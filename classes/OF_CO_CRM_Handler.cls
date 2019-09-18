public class OF_CO_CRM_Handler {
    public static void manageAssetBillingElement(String assetId, Order o){
    	list<PriceBookEntry> pbeToUpsert = new list<PriceBookEntry>();
    	
        //Recupero il PricebookEntry relativo al canone attuale
        PriceBookEntry pbe = [SELECT Id, OF_Asset__c, OF_Contratto__c, isActive, OF_DataCessazione2__c, Product2Id, PriceBook2.OF_Listino__r.OF_IDContract__c  
                              FROM PriceBookEntry 
                              WHERE OF_Asset__c = :assetId
                              AND isActive = true 
                              AND Name = 'Canone' LIMIT 1];
        
        //Vado a disattivare il canone
        pbe.isActive = false;
        //Setto la data di cessazione
        pbe.OF_DataCessazione2__c = DateTime.now();
        //Aggiorno il pbe
        pbeToUpsert.add(pbe);
        
        //system.debug('***** vecchio canone ' + pbe);
        OF_CommercialElementIstanziato__c ceiBase =[select id from OF_CommercialElementIstanziato__c 
                                                    where OF_CEStandard__c=:assetId AND 
                                                    OF_CommercialElementName__c='SERVIZIO OPEN STREAM BASE' limit 1];
        system.debug('****CEI BASE RECUPERATO ' + ceiBase);
        /*OLD!//Recupero il pricebook dal profilo dell'ordine
        //Id pbNewCanone = [SELECT Id FROM PriceBook2 WHERE Name = :o.OF_Profilo__c AND PO_Contratto__c = :pbe.PriceBook2.OF_Listino__r.OF_IDContract__c LIMIT 1].Id;
        FINE OLD*/
        //system.debug('pbe.PriceBook2.OF_Listino__r.OF_IDContract__c: '+pbe.PriceBook2.OF_Listino__r.OF_IDContract__c+' @@@@ o.OF_Profilo__c: '+o.OF_Profilo__c);
        //Vado a creare il pricebook
        List<OF_Listino__c> listini = [SELECT Id,Name,OF_ServizioBillingElement__r.Name
                         FROM OF_Listino__c 
                         WHERE OF_IDContract__c = :pbe.PriceBook2.OF_Listino__r.OF_IDContract__c 
                         AND OF_Attivo__c = true
                         AND (Name = :o.OF_Profilo__c OR OF_ServizioBillingElement__r.Name = 'Contributo Cambio Profilo')];
        system.debug('@@@@ Listini: '+listini);
        OF_Listino__c listinoCanone; 
        OF_Listino__c listinoChangeOrder;
        For(OF_Listino__c listino:listini){
            if(listino.Name == o.OF_Profilo__c){
                listinoCanone=listino;
            }
            else if(listino.OF_ServizioBillingElement__r.Name == 'Contributo Cambio Profilo'){
                listinoChangeOrder=listino;
            }
        }
        system.debug('******* LISTINO NUOVO PROFILO ' + listinoCanone);
        system.debug('******* LISTINO CHANGE ORDER ' + listinoChangeOrder);
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_CO_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_CO_GE_Utils.rtMap.put(rt.developerName, rt.Id); 
        }
        OF_CO_GE_Utils.checkrtMap=true;

        PriceBook2 pbNewCanone = new PriceBook2();
            pbNewCanone.IsActive = true;
            pbNewCanone.Name = o.OF_Profilo__c;
            pbNewCanone.OF_Listino__c = listinoCanone.Id;
            //TODO : pbNewCanone.PO_Commercial_element__c = ?????
            pbNewCanone.PO_Contratto__c = pbe.PriceBook2.OF_Listino__r.OF_IDContract__c;
            pbNewCanone.RecordTypeId = OF_CO_GE_Utils.rtMap.get('OF_Pricebook');

        insert pbNewCanone;
        system.debug('**** LISTINO PREZZO NUOVO CANONE ' + pbNewCanone);
        //Vado a creare il nuovo canone
        PriceBookEntry newPBECanone = new PriceBookEntry();
        newPBECanone.OF_Asset__c = assetId;
        newPBECanone.OF_Order__c = o.Id;
        //Done AA: Pricebook id??
        newPBECanone.OF_CommercialElementIstanziato__c = ceiBase.id;
        newPBECanone.Pricebook2Id = pbNewCanone.Id;
        newPBECanone.Product2Id = pbe.Product2Id;
        newPBECanone.OF_DataAttivazione2__c = DateTime.now();
        newPBECanone.isActive = true; 
        newPBECanone.UnitPrice=-9999;
        newPBECanone.OF_CO_Change_Order__c=true;
        //Inserisco il nuovo canone
        system.debug('***** INSERIMENTO PBE NUOVO CANONE ' + newPBECanone);
        pbeToUpsert.add(newPBECanone);
            
        //Recuper id del Product cambio profilo
        Id prodCPId = [SELECT Id 
                       FROM Product2 
                       WHERE Name = 'Contributo Cambio Profilo' 
                       AND OF_ListinoCustom__c = :listinoChangeOrder.id LIMIT 1].Id;
        system.debug('********* ID PORODOTTTO CAMBIO PROFILO ' + prodCPId);
        
      /*OLD  //Recupero id del Pricebook del cambio profilo
        Id pbCPId = [SELECT Id,OF_Listino__c 
                     FROM Pricebook2 
                     WHERE OF_Listino__c = :listinoCustomId LIMIT 1].Id;*/
        PriceBook2 pbNewQuota = new PriceBook2();
            pbNewQuota.IsActive = true;
            pbNewQuota.Name = listinoChangeOrder.name;
            pbNewQuota.OF_Listino__c = listinoChangeOrder.Id;
            //TODO : pbNewCanone.PO_Commercial_element__c = ?????
            pbNewQuota.PO_Contratto__c = pbe.PriceBook2.OF_Listino__r.OF_IDContract__c;
            pbNewCanone.RecordTypeId = OF_CO_GE_Utils.rtMap.get('OF_Pricebook');

        insert pbNewQuota;
        system.debug('***** PRICEBOOK QUOTA CAMBIO PROFILO!!! ' + pbNewQuota);
        
        PriceBookEntry newPBEProfilo = new PriceBookEntry();
        newPBEProfilo.OF_Asset__c = assetId;
        newPBEProfilo.OF_Order__c = o.Id;
        newPBEProfilo.Pricebook2Id = pbNewQuota.Id;
        newPBEProfilo.OF_CommercialElementIstanziato__c = ceiBase.id;
        newPBEProfilo.Product2Id = prodCPId;
        newPBEProfilo.OF_DataAttivazione2__c = DateTime.now();
        newPBEProfilo.isActive = true; 
        newPBEProfilo.UnitPrice=-9999;
        //Inserisco il nuovo canone
        pbeToUpsert.add(newPBEProfilo);
        
    	boolean inserito=false;
        boolean templog=false;
        Templog__c t = new Templog__c();
        for(integer x=0; x<50; x++){
            try{
            	upsert pbeToUpsert;
            	inserito=true;
            }
            catch(exception e){
            	if(!templog){
            		t=OF_Utility.logMessageNew2(assetId,'E','OF_CO_CRM_Handler','manageAssetBillingElement',(x+1), e);
            		templog=true;
            	}
            	else{
            		t.OF_tentativi__c=(x+1);
            	}
            }
            if(inserito==true){
            	break;
            }
        }
       	 if(templog){
        	insert t;
        }            
    } 
    public static void manageAssetVlan(String assetId,list<OF_CommercialElementIstanziato__c> vlanListNew){
        list<OF_CommercialElementIstanziato__c> vlanListOld = [SELECT Id,OF_Stato__c 
                                                               FROM OF_CommercialElementIstanziato__c 
                                                               WHERE RecordType.DeveloperName = 'OF_VLAN'
                                                               AND (OF_Asset__c=:assetId OR OF_VLAN__c=:assetId)];
                                                               
        list<OF_CommercialElementIstanziato__c> vlanListToUpdate = new list<OF_CommercialElementIstanziato__c>();
        if(!vlanListOld.isEMpty()){
            for(OF_CommercialElementIstanziato__c vlan : vlanListOld){
            	if(vlan.OF_Stato__c == 'Attivo'){
	                vlan.OF_Stato__c = 'Cessato';
	                vlan.OF_DataCessazione__c=system.now();
	                vlanListToUpdate.add(vlan);
            	}
            }
        }
        if(vlanListNew!=null && !vlanListNew.isEMpty()){
            for(OF_CommercialElementIstanziato__c vlan : vlanListNew){
                vlan.OF_Asset__c=assetId;
                vlan.OF_VLAN__c=assetId;
                vlan.OF_Stato__c = 'Attivo';
                vlan.OF_DataAttivazione__c=system.now();
                vlanListToUpdate.add(vlan);
            }
        } 
        if(!vlanListToUpdate.isEmpty()){ 
            if(!test.isRunningTest())
            update vlanListToUpdate;
        }
    }
}