public class OF_PP_OLO_AsyncChecks {	
	
	/*
    @future(callout=true)         
    public static void KIT_AsyncActivation(String caseId, String SLOloSfId){
    	 
    	system.debug('%%%%%%%%%%%%%%%%%%%%%%% KIT_AsyncActivation: caseId: ' + caseId + ' SLOloSfId: ' + SLOloSfId  ); 
        
        OF_PP_GE_Utils.caseOriginale = Database.query(OF_PP_GE_Utils.getQuery('case','AsyncActivation')+
        										' where id=:caseId'); 
        										system.debug('Alessandro: query: '+OF_PP_GE_Utils.getQuery('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' order by EOF_Ordine_Invio_OLO__c');
        OF_PP_GE_Utils.ListSlActivationOLOSF=Database.query(OF_PP_GE_Utils.getQuery('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' order by EOF_Ordine_Invio_OLO__c');

		for(EOF_EAI_Service_Log__c sl : OF_PP_GE_Utils.ListSlActivationOLOSF){
			if(sl.recordtype.developername=='OF_InserimentoKIT_LOG'){
				OF_PP_GE_Utils.slOLOSF=sl;	
			}
		}
        
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% KIT_AsyncActivation: DOPO IL FOR'  );
      
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_PP_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_PP_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
        }               
        OF_PP_GE_Utils.checkrtMap=true;
        
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% KIT_AsyncActivation: DOPO MAPPA'  );
        
        OLO_ID__c oloId=OLO_ID__c.getInstance(OF_PP_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_PP_GE_Utils.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
        
        OF_PP_GE_Utils.caseOriginale.OF_SA_Profilo__c=OF_PP_GE_Utils.slOLOSF.EOF_Profilo__c;
        
        OF_PP_GE_Utils.caseOriginale.status='Acquisito';
        OF_PP_GE_Utils.caseOriginale.EOF_Fase__C='Da Lavorare';
		
		//genero l'id servizio andando a inserire un record dell'oggetto OF_Generatore_ID_Servizio__c
		OF_PP_GE_Utils.gen =[select OF_ID_Servizio__c from OF_Generatore_ID_Servizio__c where OF_Case_Id__c=:OF_PP_GE_Utils.caseOriginale.Id];
		OF_PP_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c=OF_PP_GE_Utils.gen.OF_ID_Servizio__c;
        
        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
        //Commento PG 31-08
        //OF_PP_GE_Utils.slSFOLO = OF_PP_GE_Utils.CreateAcquisition_Log(OF_PP_GE_Utils.caseOriginale);
        //chiamo il metodo che gestisce le callout e aggiorna il DB
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% KIT_AsyncActivation: makeCalloutOLOOM'  );
        //Commento PG 31-08
        //OF_PP_GE_Utils.makeCalloutOLOOM(OF_PP_GE_Utils.slSFOLO);
        return;
    } 
    */
    
    //OK
    //PG - DEV - Metodo SVLAN_AsyncActivation chiamato nella classe OF_PP_OLO_EntryChecksKIT
    @future(callout=true)         
    public static void SVLAN_AsyncActivation(String caseId, String SLOloSfId)
    {
    	system.debug('%%%%%%%%%%%%%%%%%%%%%%% SVLAN_AsyncActivation: caseId: '+caseId+' SLOloSfId: '+SLOloSfId); 
        
        //Qui fa le query per recuperare i service log
        /*
        OF_PP_GE_Utils.caseOriginale = Database.query(OF_PP_GE_Utils.getQuery('case','AsyncActivation')+
        										' where id=:caseId'); 
        										system.debug('Alessandro: query: '+OF_PP_GE_Utils.getQuery('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' order by EOF_Ordine_Invio_OLO__c');
		*/
		//Richiamo un metodo della classe OF_PP_GE_Utils che fa una query sul case utilizzando l'id passato come parametro
		OF_PP_GE_Utils.caseOriginale = Database.query(OF_PP_GE_Utils.getQuery('case','VLAN_Activation')+
        										' where id=:caseId'); 
        System.debug('***Query CASE***'+Database.query(OF_PP_GE_Utils.getQuery('case','VLAN_Activation')+
        										' where id=:caseId') );
        										
        system.debug('Alessandro: query: '+OF_PP_GE_Utils.getQuery('sl','VLAN_Activation')+ ' where id =:SLOloSfId' );
							
        /*
        OF_PP_GE_Utils.ListSlActivationOLOSF=Database.query(OF_PP_GE_Utils.getQuery('sl','AsyncActivation')+
    											' where id =:SLOloSfId' 
		        								+' order by EOF_Ordine_Invio_OLO__c');
		*/
		//OF_PP_GE_Utils.ListSlActivationOLOSF è la lista che contiene tutti i service log del portale (VLAN e COS)
        //Richiamo un metodo della classe OF_PP_GE_Utils che fa una query sul service log della VLAN utilizzando l'id passato come parametro
        OF_PP_GE_Utils.ListSlActivationOLOSF = Database.query(OF_PP_GE_Utils.getQuery('sl','VLAN_Activation')+
    										       ' where id =:SLOloSfId');
    	
    	System.debug('***Query S_Log***'+Database.query(OF_PP_GE_Utils.getQuery('sl','VLAN_Activation')+
        										' where id=:SLOloSfId') );
    	
    	//Richiamo un metodo della classe OF_PP_GE_Utils che fa una query sul service log del COS utilizzando l'id del log della VLAN
    	OF_PP_GE_Utils.ListSlActivationCosOLOSF = Database.query(OF_PP_GE_Utils.getQuery('sl','COS_Activation')+
    										      ' where PO_PP_ID_VLAN__c =:SLOloSfId');
    										      
    	//Ciclo sulla lista dei COS (log) ed aggiungo i log alla lista unica ListSlActivationOLOSF
    	for(EOF_EAI_Service_Log__c cos_log : OF_PP_GE_Utils.ListSlActivationCosOLOSF)
    	{
    	    OF_PP_GE_Utils.ListSlActivationOLOSF.add(cos_log);
    	}
    	
    	//Aggiungo alla lista anche i service LOG dei COS
        /*
        OF_PP_GE_Utils.ListSlActivationOLOSF.add(Database.query(OF_PP_GE_Utils.getQuery('sl','COS_Activation')+
    										      ' where PO_PP_ID_VLAN__c =:SLOloSfId'));
    	*/
        
		for(EOF_EAI_Service_Log__c sl : OF_PP_GE_Utils.ListSlActivationOLOSF){
			if(sl.recordtype.developername=='OF_PP_VLAN_ActivationRequest'){
				OF_PP_GE_Utils.slOLOSF=sl;	
			}
		}
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% SVLAN_AsyncActivation: DOPO IL FOR' );
        system.debug('%%%_OF_PP_GE_Utils.slOLOSF_%%%: '+OF_PP_GE_Utils.slOLOSF);
      
        List<recordtype> rtList=[select Id,developerName 
                                from recordtype];
                                
        OF_PP_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_PP_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
        }               
        OF_PP_GE_Utils.checkrtMap=true;
        
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% SVLAN_AsyncActivation: DOPO MAPPA');
        
        OLO_ID__c oloId = OLO_ID__c.getInstance(OF_PP_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        System.debug('***oloID***:'+oloId);
        OF_PP_GE_Utils.caseOriginale.EOF_Account_OLO__c = oloId.OF_Olo_Id__c;
        
        //OF_PP_GE_Utils.caseOriginale.OF_SA_Profilo__c=OF_PP_GE_Utils.slOLOSF.EOF_Profilo__c;
        //OF_PP_GE_Utils.caseOriginale.status='Acquisito';
        //OF_PP_GE_Utils.caseOriginale.EOF_Fase__C='Da Lavorare';
		
		//genero l'id servizio andando a inserire un record dell'oggetto OF_Generatore_ID_Servizio__c
		/*
		OF_PP_GE_Utils.gen =[select OF_ID_Servizio__c 
                    		from OF_Generatore_ID_Servizio__c 
                    		where OF_Case_Id__c=:OF_PP_GE_Utils.caseOriginale.Id];
                    		
		OF_PP_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c=OF_PP_GE_Utils.gen.OF_ID_Servizio__c;
		*/
        
        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate) Non serve per la VLAN
        //OF_PP_GE_Utils.slSFOLO = OF_PP_GE_Utils.CreateAcquisition_Log(OF_PP_GE_Utils.caseOriginale);
        
        //chiamo il metodo che gestisce le callout e aggiorna il DB
        
        //OF_PP_GE_Utils.ListSlActivationOLOSF è la lista dei log del portale (VLAN e COS)
        system.debug('%%%%%%%%%%%%%%%%%%%%%%% SVLAN_AsyncActivation: Prima di create_ActivationToOM_Log');
            
        //creazione nuovi service LOG per OM (VLAN e COS)
        OF_PP_GE_Utils.ListSlActivationSFOM = OF_PP_GE_Utils.create_ActivationToOM_Log(OF_PP_GE_Utils.caseOriginale,OF_PP_GE_Utils.ListSlActivationOLOSF);
        system.debug(']]]__Prima di OM_CreateAckNackRequestActivation__]]]');
        //Chiamata ad OM
        OF_PP_OLO_SendToOM.OM_CreateAckNackRequestActivation(OF_PP_GE_Utils.ListSlActivationSFOM);
        //OF_PP_GE_Utils.makeCalloutOLOOM(OF_PP_GE_Utils.slSFOLO);
        return;
    }
    
    /*
    public static Map<String,List<EOF_EAI_Service_Log__c>> OLO_AsyncStatusUpdate(Case c, OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur){
        Map<String,List<EOF_EAI_Service_Log__c>> responseToOlo = new Map<String,List<EOF_EAI_Service_Log__c>>();
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
       
        EOF_EAI_Service_Log__c slToOM = OF_PP_GE_Utils.OLO_CreateStatusUpdate_Log(c, sur);
        system.debug('OSCRM OF_SA_OLO_AsyncChecks.OLO_AsyncStatus slToOM:'+slToOM);
        
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(slToOM);
        system.debug('OSCRM OF_SA_OLO_AsyncChecks.OLO_AsyncStatus responseFromOM:'+responseFromOM );
        
        //aggiungo il log originario
        slList.add(OF_PP_GE_Utils.Create_EAI_Log(sur));
        
        //aggiungo il log dell'invio ad OM
        slList.add(slToOM);
        
        if(responseFromOM.containsKey('0')) {
            slList.add(responseFromOM.get('0'));
            responseToOlo.put('0',slList);
            
            return  responseToOlo;
        }
        else{
            slList.add(responseFromOM.get('1'));
            responseToOlo.put('1',slList);
            
            return  responseToOlo;
        }
    }
    */
}