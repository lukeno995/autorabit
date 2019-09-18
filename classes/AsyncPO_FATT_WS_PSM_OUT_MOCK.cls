@isTest
global class AsyncPO_FATT_WS_PSM_OUT_MOCK implements WebServiceMock { 
    
    
    
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
            if( request instanceof PO_FATT_WS_PSM_OUT_Notify.InputMapping1)
            {
                AsyncPO_FATT_WS_PSM_OUT_Notify.OutputMapping1Future responseElement = new AsyncPO_FATT_WS_PSM_OUT_Notify.OutputMapping1Future();
                
                response.put('response__x',responseElement);
                
            }
        
        }
}