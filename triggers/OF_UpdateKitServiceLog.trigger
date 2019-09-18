trigger OF_UpdateKitServiceLog on Case (after update) {
    /*  La modifica al nome del kit è un'operazione manuale fatta dagli
        utenti di Ingegneria. Non deve essere fatta su un insieme di kit,
        ma solo su singoli oggetti. Per tale motivo in questo 
        trigger lavoro solo su singoli record.
    */

    System.debug('##### Trigger OF_UpdateKitServiceLog - START ');

    Map<Id,Case> map_caseIdCaseKit = new Map<Id,Case>();
    Map<String,String> map_recType = new Map<String,String>();
    Map<String,String> map_OldNameKitNewNameKit = new Map<String,String>();

    Id rTypeKit = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SObjectType, 
        RTypeServFattibilita.CASE_P2P_ATTIVA_KIT);

    Id rTypeLogKit = RTypeServFattibilita.getRecordTypeIdByDevName(EOF_EAI_Service_Log__c.SObjectType, 
        RTypeServFattibilita.LOG_P2P_ATTIVA_KIT);

    Id rTypeLogVlanEAccess = RTypeServFattibilita.getRecordTypeIdByDevName(EOF_EAI_Service_Log__c.SObjectType, 
        RTypeServFattibilita.LOG_VLAN);

    // useless
	for(Recordtype rt : [SELECT Id, developername FROM recordtype 
                        WHERE developerName IN ('PO_Case_P2P_Attiva_KIT', 'PO_Log_P2P_Attiva_KIT','OF_SA_Vlan', 'OF_VLAN')]){
	    map_recType.put(rt.developername, rt.id);
	}

    for(Case cNew : Trigger.New){
    	if(cNew.recordtypeid == rTypeKit) {
            // prendo solo i kit a cui è stato cambiato il nome, e ne prendo esattamente uno
            if(!Trigger.oldMap.get(cNew.Id).PO_PP_NomeKit__c.equals(cNew.PO_PP_NomeKit__c)) {
                map_OldNameKitNewNameKit.put(Trigger.oldMap.get(cNew.Id).PO_PP_NomeKit__c, cNew.PO_PP_NomeKit__c);
                System.debug('##### OF_UpdateKitServiceLog map_OldNameKitNewNameKit: ' + map_OldNameKitNewNameKit);
                map_caseIdCaseKit.put(cNew.Id, cNew); 
                break;
            }          
    	}
    }

    System.debug('@@@@@FF: map_caseIdCaseKit.keySet(): '+ map_caseIdCaseKit.keySet()); 

    if(!map_caseIdCaseKit.isEmpty()) {
        // service Log associato al case kit
        List<EOF_EAI_Service_Log__c> list_kitLog = [SELECT id, Caso__c, PO_P2PAttiva_Nome_del_KIT__c
            FROM EOF_EAI_Service_Log__c  
            WHERE Caso__c in: map_caseIdCaseKit.keySet() AND recordtypeid =: rTypeLogKit LIMIT 1];
        System.debug('@@@@OF_UpdateKitServiceLog -- list_kitLog: ' + list_kitLog);
        
        for(Id i : map_caseIdCaseKit.keySet()){
            if(!list_kitLog.isEmpty()) {                
                list_kitLog[0].PO_P2PAttiva_Nome_del_KIT__c = map_caseIdCaseKit.get(i).PO_PP_NomeKit__c;
            }
        }
        
        // service Log di tipo OF - SA - Vlan con 
        Id rTypeLogVlan = map_recType.get('OF_SA_Vlan');
        List<EOF_EAI_Service_Log__c> list_LogVlan = [SELECT Caso__c, OF_SA_KIT_CONSEGNA_VLAN__c
            FROM EOF_EAI_Service_Log__c 
            WHERE OF_SA_KIT_CONSEGNA_VLAN__c in: map_OldNameKitNewNameKit.keySet() AND RecordTypeId =: rTypeLogVlan 
            LIMIT 1];
        System.debug('@@@@OF_UpdateKitServiceLog -- list_LogVlan: ' + list_LogVlan);

        for(String key : map_OldNameKitNewNameKit.keySet()) {    

            for(EOF_EAI_Service_Log__c l_vlan : list_LogVlan) {
                // identifico il service log corrispondente confrontando il campo che lega il service log
                // ad un collegamento con il campo che le lega un kit allo stesso collegamento 
                if(l_vlan.OF_SA_KIT_CONSEGNA_VLAN__c == key) {
                    l_vlan.OF_SA_KIT_CONSEGNA_VLAN__c = map_OldNameKitNewNameKit.get(key);
                }
            }
        }   
        List<EOF_EAI_Service_Log__c> toUpdate = new List<EOF_EAI_Service_Log__c>();
        toUpdate.addAll(list_kitLog);   
        toUpdate.addAll(list_LogVlan);

        if(!toUpdate.isEmpty()) {
            update toUpdate;  
            System.debug('##### Trigger OF_UpdateKitServiceLog -- updated list_kitLog.');   
            System.debug('##### Trigger OF_UpdateKitServiceLog -- updated list_LogVlan.');
        }    

    }
    System.debug('##### Trigger OF_UpdateKitServiceLog - END');

}