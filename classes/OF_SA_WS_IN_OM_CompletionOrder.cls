global class OF_SA_WS_IN_OM_CompletionOrder {
    
    global class OM_Notify_CompletionOrder{
    	webservice String CODICE_OPERATORE;
        webservice String CODICE_ORDINE_OLO;
        webservice String CODICE_ORDINE_OF;
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String STATO_ORDINE;
        webservice String CODICE_MOTIVAZIONE;
        webservice String MOTIVAZIONE;
        webservice String ID_RISORSA;
        webservice String DATA_ESPLETAMENTO_ORDINE;
        webservice String SCALA_PALAZZINA;
        webservice String DDT;
        webservice String NOTE;
        //2018/08/24 MM : aggiunta nuovi campi per verticali
        webservice String ID_GIS_SCALA_PALAZZINA;
        webservice String SCALA;
        webservice String PALAZZINA; 
        // 2018/08/24 MM : fine.
        webservice List<SERVIZIO_AGGIUNTIVO> SERVIZIO_AGGIUNTIVO;
        webservice List<APPARATO> APPARATO;
    }
    
    global class APPARATO{
    	webservice String TIPOLOGIA_APPARATO;
        webservice String ESITO_CONSEGNA_APPARATO;
        webservice String ID_APPARATO_CONSEGNATO;
        webservice String CODICE_MOTIVAZIONE_CONSEGNA;
        webservice String MOTIVAZIONE_CONSEGNA;
    }
    
    global class SERVIZIO_AGGIUNTIVO{
    	webservice String NOME_SERVIZIO;
        webservice String ESITO_SERVIZIO;
        webservice String CODICE_MOTIVAZIONE_SERVIZIO;
        webservice String MOTIVAZIONE_SERVIZIO;
        // 2018/08/24 MM : aggiunta nuovi campi per verticali
        webservice String ESTENSIONE_IMPIANTO;
        webservice String METRI_TOT;
        //2018/08/24 MM : fine.
    }
    
    global class OM_Notify_CompletionOrderResponse{
    	webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
    webservice static OM_Notify_CompletionOrderResponse OM_Notify_CompletionOrder (OM_Notify_CompletionOrder co){
        
        // 12/06/2018 MM : Aggiunta creazione Templog per cattura timestamp espletamento
		OF_SA_GE_Utils.CreateTemlogOM(co);
        OF_SA_GE_Utils.AttrTime = datetime.now().getTime();

        // finisce qui
        
    	OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse respUp =  OF_SA_OM_EntryChecks.SyncChecksNotifyCompletionOrder(co);
		OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrderResponse resp = new OF_SA_WS_IN_OM_CompletionOrder.OM_Notify_CompletionOrderResponse();
		resp.ESITO=respUp.Esito;
    	resp.codice_motivazione=respup.codice_motivazione;
    	resp.motivazione=respup.motivazione;
    	resp.Id_Notifica=co.id_Notifica;
    	return resp;
    	
    } 
    
}