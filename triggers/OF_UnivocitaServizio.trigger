//01-03-2017 Davide Gagliardi
//Trigger per impedire di associare due volte lo stesso servizio ad un catalogo

trigger OF_UnivocitaServizio on OF_Servizio__c (before insert, before update) {
    
    set<id> ids = new set<id>();
    for(OF_Servizio__c ser : trigger.new){
        ids.add(ser.OF_CatalogoCommerciale__c);
    }
    
    list<OF_Servizio__c> ServizioList = new list<OF_Servizio__c> ([select id, name, OF_CatalogoCommerciale__c, OF_CatalogoCommerciale__r.name from OF_Servizio__c where OF_CatalogoCommerciale__c =: ids]);
    
    for(OF_Servizio__c ser : trigger.new){
        for(OF_Servizio__c ser1 : ServizioList){
            if((ser.name == ser1.name) && (ser.OF_CatalogoCommerciale__c == ser1.OF_CatalogoCommerciale__c)){
                if(trigger.isInsert){
                    ser.adderror('<span></br>Il servizio ' + ser1.name + ' è già associato al catalogo ' + ser1.OF_CatalogoCommerciale__r.name +'</br></span>',false);
                    break;
                }
                if((trigger.isUpdate) && (trigger.oldMap.get(ser.Id).id != ser1.Id)){
                    ser.adderror('<span></br>Il servizio ' + ser1.name + ' è già associato al catalogo ' + ser1.OF_CatalogoCommerciale__r.name +'</br></span>',false);
                    break;
                }
            }
        }
    }
}