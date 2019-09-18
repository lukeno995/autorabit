public class PO_Servizi_Fattibilita_Routing_Ctrl {
    
    public PageReference routeRequest(){
        String caseId = ApexPages.currentPage().getParameters().get('parentId');
        String flowName = ApexPages.currentPage().getParameters().get('off');
        String method = ApexPages.currentPage().getParameters().get('method');
        String Nome = ApexPages.currentPage().getParameters().get('Nome');
		
		System.debug('@@@@EC siamo nella classe PO_Servizi_Fattibilita_Routing_Ctrl, caseId è ' + caseId + ', Nome è '+ Nome + ', flowName,cioè offerta è ' + flowName + ', method è ' + method);
	
		system.debug('@@@@EC siamo nella classe PO_Servizi_Fattibilita_Routing_Ctrl ed abbiamo richiamato il metodo pgRef routeRequest ');
		
		
	
        //Vado a controllare se è una richiesta inserita
        if(String.isNotBlank(method) && method == 'save'){//Caso di richiesta inserita
            PageReference pg = new PageReference('/Po_FeasibilityServicesRequest2');
            pg.getParameters().put('off',flowName);
            pg.getParameters().put('parentId', caseId);
            pg.getParameters().put('Nome', Nome);
            system.debug('@@@@@@@@@@EC nella classe PO_Servizi_Fattibilita_Routing_Ctrl alla fine la pagina a cui si sarà dirottati è ' + pg);
        	pg.setRedirect(true);//EC 2018 - 11 - 10 	
            return pg;
        }

        //P2PBase
        if( String.isNotBlank(caseId) && String.isNotBlank(flowName) && method != 'save'){
          //  if(flowName == 'P2PBase'){
                PageReference pg = new PageReference('/PO_FeasibilityService1');
                pg.getParameters().put('off',flowName);
                pg.getParameters().put('parentId', caseId);
                pg.getParameters().put('Nome', Nome);
                system.debug('@@@@@@@@@@EC nella classe PO_Servizi_Fattibilita_Routing_Ctrl alla fine la pagina a cui si sarà dirottati è ' + pg);
       			pg.setRedirect(true);//EC 2018 - 11 - 10 
       			return pg;
         //   }
        }
        
        return null;
        /*
        //FiberLink
        if( String.isNotBlank(caseId) && String.isNotBlank(flowName) ){
            if(flowName == 'FiberLink'){
                PageReference pg = new PageReference('/PO_FeasibilityService1');
                pg.getParameters().put('off',flowName);
                pg.getParameters().put('parentId', caseId);
                return pg;
            }
        }
        //FiberLease
        if( String.isNotBlank(caseId) && String.isNotBlank(flowName) ){
            if(flowName == 'FiberLease'){
                PageReference pg = new PageReference('/PO_FeasibilityService1');
                pg.getParameters().put('off',flowName);
                pg.getParameters().put('parentId', caseId);
                return pg;
            }
        }
        //IRU
        if( String.isNotBlank(caseId) && String.isNotBlank(flowName) ){
            if(flowName == 'IRU'){
                PageReference pg = new PageReference('/PO_FeasibilityService1');
                pg.getParameters().put('off',flowName);
                pg.getParameters().put('parentId', caseId);
                return pg;
            }
        }//MistoFiber(EventoTemporaneo)
        if( String.isNotBlank(caseId) && String.isNotBlank(flowName) ){
            if(flowName == 'MistoFiber'){
                PageReference pg = new PageReference('/PO_FeasibilityService1');
                pg.getParameters().put('off',flowName);
                pg.getParameters().put('parentId', caseId);
                return pg;
            }
        }
        */
      //  return null; //EC 2018 - 11 - 09 proviamo a commentare.
    }
}