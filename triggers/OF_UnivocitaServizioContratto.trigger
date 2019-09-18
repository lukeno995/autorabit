//27-02-2017 Davide Gagliardi
//Trigger per evitare di associare più volte lo stesso servizio allo stesso contratto

trigger OF_UnivocitaServizioContratto on OF_ContrattoServizio__c (before insert, before update) {

    If(trigger.isInsert || trigger.isUpdate){
        
        set<id> ids = new set<id>();
        for(OF_ContrattoServizio__c CS : trigger.new){
            ids.add(CS.OF_Contract__c);
        }
        
        list<OF_ContrattoServizio__c> ContrServList = new list<OF_ContrattoServizio__c> ([select id, OF_Contract__c, OF_Servizio__c, OF_Servizio__r.name from OF_ContrattoServizio__c where OF_Contract__c =: ids]);
        
        for(OF_ContrattoServizio__c CSLis : trigger.new){
            for(OF_ContrattoServizio__c CSLis1 : ContrServList){
                if(CSLis.OF_Contract__c == CSLis1.OF_Contract__c && CSLis.OF_Servizio__c == CSLis1.OF_Servizio__c){
                    if(trigger.isInsert){
                    	CSLis.adderror('<span></br>Il Servizio ' + CSLis1.OF_Servizio__r.name + ' è già associato al contratto.</br></span>',false);
                        break;
                    }
                    if((trigger.isUpdate) && (trigger.oldMap.get(CSLis.Id).id != CSLis1.Id)){
                    	CSLis.adderror('<span></br>Il Servizio ' + CSLis1.OF_Servizio__r.name + ' è già associato al contratto.</br></span>',false);
						break;
                    }
        		}
        	}
        }
    }
}