//01-03-2017 Davide Gagliardi
//Trigger per impedire di associare due volte lo stesso commercial element ad un servizio

trigger OF_UnivocitaCommercialElement on OF_CommercialElement__c (before insert, before update) {
    
    set<id> ids = new set<id>();
    for(OF_CommercialElement__c ce : trigger.new){
        ids.add(ce.OF_Servizio__c);
    }
    
    list<OF_CommercialElement__c> CEList = new list<OF_CommercialElement__c> ([select id, name, OF_Servizio__c, OF_Servizio__r.name from OF_CommercialElement__c where OF_Servizio__c =: ids]);
    
    for(OF_CommercialElement__c ce : trigger.new){
        for(OF_CommercialElement__c ce1 : CEList){
            if((ce.name == ce1.name) && (ce.OF_Servizio__c == ce1.OF_Servizio__c)){
                if(trigger.isInsert){
                    ce.adderror('<span></br>Il commercial element ' + ce1.name + ' è già associato al servizio ' + ce1.OF_Servizio__r.name +'</br></span>',false);
                    break;
                }
                if((trigger.isUpdate) && (trigger.oldMap.get(ce.Id).id != ce1.Id)){
                    ce.adderror('<span></br>Il commercial element ' + ce1.name + ' è già associato al servizio ' + ce1.OF_Servizio__r.name +'</br></span>',false);
                    break;
                }
            }
        }
    }
}