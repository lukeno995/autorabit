//01-03-2017 Davide Gagliardi
//Trigger per impedire di associare due volte lo stesso billing element ad un commercial element

trigger OF_UnivocitaBillingElement on OF_BillingElement__c (before insert, before update) {
    
    set<id> ids = new set<id>();
    for(OF_BillingElement__c be : trigger.new){
        ids.add(be.OF_CommercialElement__c);
    }
    
    list<OF_BillingElement__c> BEList = new list<OF_BillingElement__c> ([select id, name, OF_CommercialElement__c, OF_CommercialElement__r.name from OF_BillingElement__c where OF_CommercialElement__c =: ids]);
    
    for(OF_BillingElement__c be : trigger.new){
        for(OF_BillingElement__c be1 : BEList){
            if((be.name == be1.name) && (be.OF_CommercialElement__c == be1.OF_CommercialElement__c)){
                if(trigger.isInsert){
                    be.adderror('<span></br>Il billing element ' + be1.name + ' è già associato al commercial element ' + be1.OF_CommercialElement__r.name +'</br></span>',false);
                    break;
                }
                if((trigger.isUpdate) && (trigger.oldMap.get(be.Id).id != be1.Id)){
                    be.adderror('<span></br>Il billing element ' + be1.name + ' è già associato al commercial element ' + be1.OF_CommercialElement__r.name +'</br></span>',false);
                    break;
                }
            }
        }
    }
}