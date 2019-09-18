global class AsyncOF_SA_WS_OLO_CompletionOrderMockCls implements WebServiceMock { 
    
    
    
    global void doInvoke(
        Object stub,
        Object request,
        Map<String,Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
         
            /*
            system.debug('OSCRM 11_06');
            if( request instanceof OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element )
            {
                system.debug('OSCRM ????');
                OF_SA_WS_OLO_Response.Esito_element responseElement = new OF_SA_WS_OLO_Response.Esito_element();
                responseElement.ESITO = '0';
                response.put('response__x',responseElement);
                system.debug('oscrm responseElement:'+responseElement);
                system.debug('oscrm responde.get(\'response__x\') :'+response.get('response__x'));
            }*/
            if( request instanceof OF_SA_WS_OLO_Classi.NotificaAggiornamentoStato_element)
            {
                OF_SA_WS_OLO_Response.Esito_element responseElement = new OF_SA_WS_OLO_Response.Esito_element();
                responseElement.ESITO = '0';
                response.put('response__x',responseElement);
                
            }
        
        }
}