trigger OF_Check_PSM on Case (before update) {
    system.debug('Trigger OF_Check_PSM');
    PSM_TAP_OUT_CS__c PCS = PSM_TAP_OUT_CS__c.getOrgDefaults();
    Id idEline = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SObjectType, 
                                                               RTypeServFattibilita.CASE_P2P_ORDINE_ELINE);
    Id idEaccess = RTypeServFattibilita.getRecordTypeIdByDevName(Case.SObjectType, 
                                                                 RTypeServFattibilita.CASE_P2P_ATTIVA_ORDINE);    
    
    for(case c : Trigger.New){        
        System.debug('@@@c.createddate: ' + c.createddate);
        System.debug('@@@c.PCS.Start_Date__c: ' + PCS.Start_Date__c);
        System.debug('@@@PCS.On_Off__c: ' + PCS.On_Off__c);
        
        if(c.recordtypeid != idELine && c.recordtypeid != idEaccess) {            
            if(!c.isPSM__c 
                && 'Accettato'.equals(c.Status) && 'In Lavorazione Supporto Vendite'.equals(c.EOF_Fase__c)
          		&& (PCS.On_Off__c || (c.PO_Nome_Comune__c!=null && PCS.Elenco_Citta__c.contains(c.PO_Nome_Comune__c)))
              	&& (c.createddate >= PCS.Start_Date__c )) {
               c.isPSM__c = true;
               system.debug('Dentro FOR trigger OF_Check_PSM');
           }
            
        }
        
    }
}