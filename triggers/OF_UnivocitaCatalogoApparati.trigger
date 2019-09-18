trigger OF_UnivocitaCatalogoApparati on OF_CatalogoApparati__c (before insert, before update) {

    set<id> ids = new set<id>();
    set<string> stringSet = new set<string>();
    
    for(OF_CatalogoApparati__c cat : trigger.new){
        ids.add(cat.OF_OLO__c);
    }
    
    list<OF_CatalogoApparati__c> CAList = new list<OF_CatalogoApparati__c> ([select id, OF_TipologiaApparato__c, OF_OLO__r.name from OF_CatalogoApparati__c where OF_OLO__c =: ids]);
    system.debug('DG_UnivocitaCatalogoApparati - CAList: ' + CAList);
    
    for(OF_CatalogoApparati__c cat : CAList){
        stringSet.add(cat.OF_TipologiaApparato__c);
    }
    system.debug('DG_UnivocitaCatalogoApparati - stringSet: ' + stringSet);
    
    for(OF_CatalogoApparati__c CatApp : trigger.new){
        if(stringSet.contains(CatApp.OF_TipologiaApparato__c)){
            system.debug('DG_UnivocitaCatalogoApparati - dentro if');
            CatApp.adderror('<span></br>Esiste già un catalogo prodotti per questo OLO con Tipologia Apparato = ' + CatApp.OF_TipologiaApparato__c + '</br></span>',false);
        }else{
            system.debug('DG_UnivocitaCatalogoApparati - dentro else');
        }
    }
}