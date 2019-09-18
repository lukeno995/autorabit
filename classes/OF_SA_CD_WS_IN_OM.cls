global class OF_SA_CD_WS_IN_OM {
    
    webservice static OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse CD_OM_Notify_StatusUpdate (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){

        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp status update
        
		OF_SA_CD_GE_Utils.CreateTemlogOM(su);
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
               
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdate(su);
    	
		OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse resp = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse();
		resp.ESITO=respUp.Esito;
    	resp.codice_motivazione=respup.codice_motivazione;
    	resp.motivazione=respup.motivazione;
    	resp.Id_Notifica=su.id_Notifica;
    	return resp;
    }
    
    /*
    //START - Add by PG - 07-01 
    webservice static OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse CD_OM_Notify_StatusUpdateChangeOrder (OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate su){

        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp status update
        
		OF_SA_CD_GE_Utils.CreateTemlogOM(su);
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
               
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_CD_OM_EntryChecks.SyncChecksNotifyStatusUpdateChOrd(su);
    	
		OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse resp = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdateResponse();
		resp.ESITO = respUp.Esito;
    	resp.codice_motivazione = respup.codice_motivazione;
    	resp.motivazione = respup.motivazione;
    	resp.Id_Notifica = su.id_Notifica;
    	return resp;
    }
    //END - Add by PG - 07-01 
    */
    
    webservice static OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrderResponse CD_OM_Notify_CompletionOrder (OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrder co){
        
        System.debug('*****CD_OM_Notify_CompletionOrder****');
        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp espletamento
		OF_SA_CD_GE_Utils.CreateTemlogOM(co);
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
        
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_CD_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
    	System.debug('*****respUp**** : '+respUp);
    	
		OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrderResponse resp = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrderResponse();
		resp.ESITO=respUp.Esito;
    	resp.codice_motivazione=respup.codice_motivazione;
    	resp.motivazione=respup.motivazione;
    	resp.Id_Notifica=co.id_Notifica;
    	return resp;
    } 
    
    webservice static OF_SA_WS_IN_OM_Reschedule.OM_Notify_RescheduleResponse OM_Reschedule (OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule r){
        
        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp rimodulazione da OM
		OF_SA_CD_GE_Utils.CreateTemlogOM(r);
        OF_SA_CD_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
                
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp = OF_SA_CD_OM_EntryChecks.SyncChecksNotifyReschedule(r);
		OF_SA_WS_IN_OM_Reschedule.OM_Notify_RescheduleResponse resp = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_RescheduleResponse();
		resp.ESITO=respUp.Esito;
    	resp.codice_motivazione=respup.codice_motivazione;
    	resp.motivazione=respup.motivazione;
    	resp.Id_Notifica=r.id_Notifica;
    	return resp;
    }
}