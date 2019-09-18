global class OF_WS_GIS_ResponseStaging {
    
    global class GIS_Obsoleto{
        webservice String CODICE_ORDINE_OLO;
		webservice String COMUNE;
		webservice DateTime DATA_ESPLETAMENTO;
		webservice String ID_BUILDING;
		webservice String ID_BUILDING_SCALA_PALAZZINA;
        webservice String ID_RISORSA;
        webservice String ID_SCALA;
        webservice String IDR_SCALA; //ID_GIS_ScalaPalazzina
        webservice String INDIRIZZO;
        webservice String NOME_SCALA;
        webservice String NUMERO_CIVICO;
        webservice String NUMERO_UI_TOT; //UI_SCALA_PALAZZINA
        webservice String OLO;
        webservice String PARTICELLA_TOPONOMASTICA;
        webservice String POP_TMW;
    }

    global class GIS_Obsoleto_response {
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }

    webservice static GIS_Obsoleto_response OF_GetVerticali (List<GIS_Obsoleto> list_obs){
        
        OF_WS_GIS_ResponseStaging.GIS_Obsoleto_response resp = OF_PNI_GIS_Obsoleti_Check.createStagingGIS(list_obs);

        //resp.ESITO=respUp.Esito;
        //resp.codice_motivazione=respUp.codice_motivazione;
        //resp.motivazione=respUp.motivazione;
        //resp.Id_Notifica=sur.id_Notifica;
        //system.debug('>>>>>>>>>>>>> RESP: ' + resp);
    	return resp;
    }
}