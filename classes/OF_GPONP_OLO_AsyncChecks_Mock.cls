@isTest
global class OF_GPONP_OLO_AsyncChecks_Mock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            if(request instanceOf WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType){
                WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType req = (WS_OF_ControlloVendibilita.ControlloVendibilitaRequestType)request;
                if('VF1'.equalsIgnoreCase(req.ID_BUILDING)){
                    WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType resp = new WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType();
                    response.put('response_x', resp ); 
                }else if('VF2'.equalsIgnoreCase(req.ID_BUILDING)){
                    //OF_WS_OM_Schema_Res_SUpdateNew.Esito_element resp = new OF_WS_OM_Schema_Res_SUpdateNew.Esito_element();
                    WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType resp = new WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType();
                    resp.LISTA_SCALE = new WS_OF_ControlloVendibilita.LISTA_SCALE_element();
                    resp.LISTA_SCALE.SCALA = new List<WS_OF_ControlloVendibilita.SCALAType>();
                    WS_OF_ControlloVendibilita.SCALAType scala1 = new WS_OF_ControlloVendibilita.SCALAType();
                    
                    scala1.SCALA_PALAZZINA = 'test';
                    scala1.STATO_SCALA_PALAZZINA = '110';
                    
                    scala1.STATO_BUILDING = '101';
                    //scala1.ID_BUILDING_OM = '101'; 
                    resp.LISTA_SCALE.SCALA.add(scala1);
                    response.put('response_x', resp ); 
                }else{
                    //OF_WS_OM_Schema_Res_SUpdateNew.Esito_element resp = new OF_WS_OM_Schema_Res_SUpdateNew.Esito_element();
                    WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType resp = new WS_OF_ControlloVendibilita.ControlloVendibilitaResponseType();
                    resp.LISTA_SCALE = new WS_OF_ControlloVendibilita.LISTA_SCALE_element();
                    resp.LISTA_SCALE.SCALA = new List<WS_OF_ControlloVendibilita.SCALAType>();
                    WS_OF_ControlloVendibilita.SCALAType scala1 = new WS_OF_ControlloVendibilita.SCALAType();
                    
                    scala1.SCALA_PALAZZINA = 'test';
                    scala1.STATO_SCALA_PALAZZINA = 'test';
                    
                    scala1.STATO_BUILDING = '110';
                    //scala1.ID_BUILDING_OM = '101';
                    resp.LISTA_SCALE.SCALA.add(scala1);
                    response.put('response_x', resp ); 
                }
                   
            }
            if(request instanceOf OF_WS_OM_Schema_Req_SUpdateNew.StatusUpdate_Req_element){
                OF_WS_OM_Schema_Res_SUpdateNew.Esito_element responseElement = new OF_WS_OM_Schema_Res_SUpdateNew.Esito_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                responseElement.Esito = '0';
                response.put('response_x', responseElement);  
            }
            if(request instanceOf OF_WS_OM_Schema_Req_RescheduleNew.Reschedule_Req_element){
                OF_WS_OM_Schema_Res_RescheduleNew.Esito_element responseElement = new  OF_WS_OM_Schema_Res_RescheduleNew.Esito_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                responseElement.Esito = '0';
                response.put('response_x', responseElement);  
            }
            if(request instanceOf OF_WS_OM_Schema_Req_DeactivationNew.DeactivationOrder_Req_element){
                OF_WS_OM_Schema_Res_DeactivationNew.Esito_element responseElement = new OF_WS_OM_Schema_Res_DeactivationNew.Esito_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                responseElement.Esito = '0';
                response.put('response_x', responseElement);
            }
            if(request instanceOf OF_GPONP_Schema_Req_StatusUpdateNew.OF_StatusUpdate_GPONP_element){
                OF_GPONP_Schema_Res_StatusUpdateNew.Response_element responseElement = new OF_GPONP_Schema_Res_StatusUpdateNew.Response_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                responseElement.Esito = '0';
                response.put('response_x', responseElement);
            }
            if(request instanceOf OF_WS_OM_Schema_Req_ActivationNew.ActivationSetup_Req_element){
                OF_WS_OM_Schema_Res_ActivationNew.Esito_element responseElement = new   OF_WS_OM_Schema_Res_ActivationNew.Esito_element();
                responseElement.CODICE_MOTIVAZIONE = 'A00';
                responseElement.Esito = '0';
                response.put('response_x', responseElement);
            }           
        }
}