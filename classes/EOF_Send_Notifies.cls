global class EOF_Send_Notifies /*implements Schedulable*/{
  /*  
    //WARNING!!! Apex code recommended to be executed in a separate class (though in a staticmethod of GW_Utils won't work)
    global void execute(SchedulableContext sc){        
        
        List<EOF_Notify__c> notifies_list = [SELECT Id,
                                             Tipo_Comunicazione__c,
                                             EOF_Codice_Ordine_OLO__c,
                                             EOF_Codice_Ordine_EOF__c,
                                             EOF_ID_Notifica__c,
                                             EOF_Stato_Richiesta__c,                                            
                                             EOF_GPON_Attestazione__c,
                                             Codice_Rifiuto_Sospensione_Annullamento__c,
                                             Motivo_Rifiuto_Sospensione_Annullamento__c,
                                             EOF_Data_Espletamento_Ordine__c,
                                             EOF_ID_Risorsa__c,
                                             EOF_Data_Notifica__c,
                                             EOF_ID_Apparato_Consegnato__c,
                                             EOF_Esito_Consegna_Apparato__c,
                                             EOF_Parametri_Trasmissivi_Ottici__c,
                                             EOF_ID_Splitter_Secondario__c,
                                             EOF_Posizione_Splitter_Secondario__c,
                                             EOF_Nuova_DAC__c,
                                             EOF_Codice_Motivazione_Rimodulazione__c,
                                             EOF_Reason_Rimodulazione_DAC__c,
                                             EOF_Note__c,
                                             EOF_Inviata__c
                                             FROM EOF_Notify__c WHERE EOF_Inviata__c = false];
        
        List<EOF_EAI_Service_Log__c> new_service_logs = new List<EOF_EAI_Service_Log__c>();
        
        for(EOF_Notify__c n : notifies_list){
            //call to external WSDL OLO method
            new_service_logs.add(EOF_GW_Utils.create_EAI_Log(n));
            n.EOF_Inviata__c = true;             
        }
        update notifies_list;
        insert new_service_logs;
        
        //Job Resubmission with adjusted nextfiretime (optional, could make two scheduled jobs)
        String sch;
        CronTrigger c = [SELECT Id, NextFireTime FROM CronTrigger where CronJobDetailId IN: [SELECT Id FROM CronJobDetail WHERE Name = 'Send generated notifies'] LIMIT 1 ];
        
        if(c.NextFireTime.minute() == 30)
          sch  = '0 0 * * * ?';
        if(c.NextFireTime.minute() == 0)
          sch = '0 30 * * * ?';
        
        System.abortJob(sc.getTriggerId());
        system.schedule('Send generated notifies', sch, this);                
    }

  */
}