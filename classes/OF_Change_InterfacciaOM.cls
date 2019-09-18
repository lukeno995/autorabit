public without sharing class OF_Change_InterfacciaOM {
    
    private final Semaforo_Proxy_Portale__c sp;
    private final CONFIGURAZIONE_PROXY_PORTALE__c cp;
    public static Boolean nuovaIf=false;
    public static List<EOF_EAI_Service_Log__c> slToUpS;
    public static List<OF_SA_Network_Inventory_Attivi__c> niList;
	public static String reqNot;

	 public static boolean OF_Interfaccia_OM(EOF_EAI_Service_Log__c slP, String tipoRichiesta) {//EC start 2019 - 03 - 27 OK
	  
	 	Boolean myCCInst;
    	system.debug('@@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM myCCInst di default è: ' + myCCInst);
    	Map <string, Semaforo_Proxy_Portale__c> mapSemaforoProxyPortale = Semaforo_Proxy_Portale__c.getAll();
    	system.debug('@@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM la mappa appena popolata con il custom settings è: ' + mapSemaforoProxyPortale);
    	
    	if(tipoRichiesta.equals('Attivazione')){
    	
    		 myCCInst = mapSemaforoProxyPortale.get('Semaforo Proxy Portale Attivazione').Semaforo_Proxy_Portale_Attivazione__c;
    		 system.debug('@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM in caso di attivazione myCCInst è ' + myCCInst);
    	
    	}
    	else if(tipoRichiesta.equals('Cessazione')){
    		 myCCInst = mapSemaforoProxyPortale.get('Semaforo Proxy Portale Cessazione').Semaforo_Proxy_Portale_Cessazione__c;
    		 system.debug('@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM in caso di Cessazione myCCInst è ' + myCCInst);
    	}
    	
    	system.debug('@@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM myCCInst dopo i controlli è: ' + myCCInst);
    	
    	if(myCCInst){
            nuovaIf=true;
            system.debug('@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM myCCInst è true quindi nuovaIf è uguale: ' + nuovaIf);
        }
        else{
        	system.debug('@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM myCCInst è false quindi ora chiamiamo il metodo checkConfigurazione per assegnare il corretto valore di nuovaIf');
            nuovaIf=checkConfigurazione(slP,tipoRichiesta);
            system.debug('@@@@EC metodo OF_Interfaccia_OM della classe OF_Change_InterfacciaOM myCCInst era false e nuovaIf è uguale: ' + nuovaIf);
        }
        return nuovaIf;
    }
    
    
     public static boolean checkConfigurazione(EOF_EAI_Service_Log__c slP2, String tipoRichiesta){
         
         if(!Test.isRunningTest()){
           niList = OF_SA_GE_UtilsNew.controlloVendibilita(slP2.EOF_Codice_Operatore__c, slP2.EOF_ID_BUILDING__c); 
        }else{
            niList = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                                            OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                                             OF_SA_ID_Building_OM__c
                                             FROM OF_SA_Network_Inventory_Attivi__c WHERE OF_SA_ID_Building__c =:OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c];  
        }
         
     
        
        string pop = slP2.EOF_ID_Pop__c;
        system.debug('@@@@EC pop: ' + pop);
        //string comune=OF_SA_GE_Utils.caseOriginale.EOF_Comune_WS__c;
        string comune ='';
      //  ni = OF_SA_GE_UtilsNew.controlloVendibilita(OF_SA_GE_UtilsNew.caseOriginale.EOF_codice_operatore_WS__c, OF_SA_GE_UtilsNew.caseOriginale.EOF_ID_Building_WS__c);
      
       Set<String> setComuniVendibili = new Set<String>();
      
       For(OF_SA_Network_Inventory_Attivi__c niA: niList){
      	 setComuniVendibili.add(niA.OF_SA_Comune__c);
       }
    //  if(setComuniVendibili.contains(cp.comune__c))
       
     /*  String comune2 = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                                        OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                                         OF_SA_ID_Building_OM__c
                                         FROM OF_SA_Network_Inventory_Attivi__c WHERE OF_SA_ID_Building__c =:slP2.EOF_ID_BUILDING__c].OF_SA_Comune__c;*/
        system.debug('@@@@EC setComuniVendibili: ' + setComuniVendibili.size());
        
        Date data= slP2.EOF_DATA_PREVISTA_ATTIVAZIONE__c; // OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c;
        system.debug('@@@@EC data: ' + data);
        string subject = tipoRichiesta; //OF_SA_GE_Utils.caseOriginale.Subject;
        subject = subject.remove('Richiesta').trim();
        system.debug('@@@@@EC OF_SA_GE_Utils.caseOriginale.Subject già in stringa epurata: ' + subject);
        
        List<CONFIGURAZIONE_PROXY_PORTALE__c> cpp = CONFIGURAZIONE_PROXY_PORTALE__c.getall().values();
        for (CONFIGURAZIONE_PROXY_PORTALE__c cp: cpp){
            if (subject.equalsIgnoreCase(cp.Tipo_Lavorazione__c)){
                if(pop.equalsIgnoreCase(cp.pop__c)){
                    if (data>=cp.data__c){
                        if(!String.IsBlank(cp.comune__c) && setComuniVendibili.contains(cp.comune__c)){
                            nuovaIf=true;
                            break;
                        }
                        else if(String.IsBlank(cp.comune__c)) {
                            nuovaIf=true;
                            break;
                        }
                    } 
                }
            }
        }
         return nuovaIf;
    }
  //EC end 2019 - 03 - 27 OK
  
  
}