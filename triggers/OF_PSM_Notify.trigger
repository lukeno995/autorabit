trigger OF_PSM_Notify on EOF_Notify__c (after insert) {
  string IdNotify='';
    map<String,String> RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype where sObjectType = 'EOF_Notify__c' AND (developerName = 'PSM_Notifica_di_Attivazione' OR developerName = 'PSM_Notifica_di_Cessazione' OR developerName = 'PSM_Notifica_di_Annullamento')]){
                    RTMap.put(rt.developername,rt.id);
            }
    system.debug(RTMap);            
    system.debug('dentro trigger OF_PSM_Notify');
    
    for (eof_notify__c nPSM : Trigger.New){
        system.debug('OF_PSM_Notify : dentro for loop');
        
        if(nPSM.recordtypeId == RTMap.get('PSM_Notifica_di_Attivazione')){
            IdNotify=nPSM.id;
            system.debug(IdNotify);
            PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione(IdNotify);
            system.debug('trigger OF_PSM_Notify: dentro if Attivazione');           
            
        }
        if(nPSM.recordtypeId == RTMap.get('PSM_Notifica_di_Cessazione')){
            IdNotify=nPSM.id;
            system.debug(IdNotify);         
            PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione(IdNotify);
            system.debug('trigger OF_PSM_Notify: dentro if Cessazione');            
            
        }
        if(nPSM.recordtypeId == RTMap.get('PSM_Notifica_di_Annullamento')){
            IdNotify=nPSM.id;
            system.debug(IdNotify);         
            PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento(IdNotify);
            system.debug('trigger OF_PSM_Notify: dentro if Annullamento');          
            
        }
        
    }
    system.debug('OF_PSM_Notify : fuori for loop');
}