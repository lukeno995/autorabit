//03-03-2017 Davide Gagliardi
//Trigger per impedire di creare due cataloghi commerciali con lo stesso nome

trigger OF_UnivocitaCatalogoCommerciale on OF_CatalogoCommerciale__c (before insert, before update) {
    
    set<string> ids = new set<string>();
    for(OF_CatalogoCommerciale__c cat : trigger.new){
        ids.add(cat.name);
    }
    
    list<OF_CatalogoCommerciale__c> CCList = new list<OF_CatalogoCommerciale__c> ([select id, name from OF_CatalogoCommerciale__c where name =: ids]);
    
    for(OF_CatalogoCommerciale__c cc : trigger.new){
        for(OF_CatalogoCommerciale__c cc1 : CCList){
            if(cc.name == cc1.name){
                if(trigger.isInsert){
                    cc.adderror('<span></br>Il catalogo commerciale è già esistente </br></span>',false);
                    break;
                }
                if((trigger.isUpdate) && (trigger.oldMap.get(cc.Id).id != cc1.Id)){
                    cc.adderror('<span></br>Il catalogo commerciale è già esistente</br></span>',false);
                    break;
                }
            }
        }
    }

}