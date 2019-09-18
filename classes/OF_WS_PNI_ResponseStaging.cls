global class OF_WS_PNI_ResponseStaging {
    
    global class PNI_Obsoleto{
		webservice String OF_CIVICO;
		webservice String OF_COMUNE;
		webservice String OF_ID_BUILDING;
		webservice String OF_ID_DB_SCALA_PALAZZINA;
        webservice String OF_ID_GIS_SCALAPALAZZINA;
        webservice String OF_ID_PALAZZINA;
        webservice String OF_ID_RISORSA;
        webservice String OF_INDIRIZZO;
        webservice String OF_PALAZZINA;
        webservice String OF_PARTICELLA_TOPONOMASTICA;
        webservice String OF_SCALA;
        webservice String OF_SCALA_PALAZZINA;
        webservice String OF_UI_SCALA_PALAZZINA;
    }

    global class PNI_Obsoleto_response {
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }

    webservice static PNI_Obsoleto_response OF_GetVerticali (List<PNI_Obsoleto> list_obs){
        
        OF_WS_PNI_ResponseStaging.PNI_Obsoleto_response resp = OF_PNI_GIS_Obsoleti_Check.createStagingPNI(list_obs);

        //resp.ESITO=respUp.Esito;
        //resp.codice_motivazione=respUp.codice_motivazione;
        //resp.motivazione=respUp.motivazione;
        //resp.Id_Notifica=sur.id_Notifica;
        //system.debug('>>>>>>>>>>>>> RESP: ' + resp);
    	return resp;
    }
}