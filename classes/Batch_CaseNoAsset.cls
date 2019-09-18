global class Batch_CaseNoAsset implements Database.Batchable<sObject>,Database.Stateful 
{
   
    global String query;
     
     /*
     Database.executeBatch(new Batch_CaseNoAsset());
    }*/
    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
    
        Datetime dt=system.now().addMinutes(-50);
        query = ' select id,OF_Order__r.ContractId,OF_Order__c,eof_codice_Operatore_WS__c,RecordType.developername from case '
    	+' where status = \'Espletato\' and AssetId = null	and EOF_ID_risorsa__c!=null AND OF_Order__c!=null '
    	+' and OF_Order__r.OF_AccountTemporaneo__c=null '
    	+' and RecordType.developername in (\'EOF_Caso_Attivazione\',\'OF_SA_Attivazione\' ) ';
    	
    	if (!Test.isRunningTest()) {
        	query = query +' and ClosedDate<:dt order by createddate asc';
    	}else{
    	   query = query +'  order by createddate asc'; 
    	}
    	
        system.debug('>>>>>>>>>>>> query: ' + query);                 
        return Database.getQueryLocator(query);
    }
    

    global void execute(Database.BatchableContext BC, List<Case> scope){
              
        system.debug('####ScopeSize: ' +  scope.size());
        if (scope != null  && !scope.isEmpty()) {
            system.debug('####ScopeSize: ' +  scope.size());
            
            Map<String,String> contractMap = new Map<String,String>();
            
            for (OF_ContrattoServizio__c con : [select id,OF_Contract__r.Account.EOF_Codice_Operatore__c,OF_Servizio__r.Name,OF_Contract__c from OF_ContrattoServizio__c 
									            where OF_Servizio__r.name in ('Open Stream','GPON Passiva')]){
	                                            contractMap.put(con.OF_Contract__r.Account.EOF_Codice_Operatore__c+con.OF_Servizio__r.Name,con.OF_Contract__c);
            }
            boolean contrattoVuoto=false;
            List<Order> listOrderToUpdate = new List<Order>();
            for (case c: scope){
            	if(String.isBlank(c.OF_Order__r.ContractId)){
            		Order o = new Order();
            		o.Id=c.OF_Order__c;
            		
            		String process;
            		if(c.RecordType.developername == 'EOF_Caso_Attivazione'){
            			process='GPON Passiva';
            		}
            		else{
            			process='Open Stream';
            		}
            		o.ContractId=contractMap.get(c.eof_codice_Operatore_WS__c+process);
            		listOrderToUpdate.add(o);
            		contrattoVuoto=true;
            	}
            }
            if(contrattoVuoto){
            	update listOrderToUpdate;
            }
            
            List<EOF_EAI_Service_Log__c> slList = [select id, EOF_SL_Riferimento__c,recordtype.developername,caso__r.RecordType.developername,caso__c,caso__r.caseNumber,caso__r.EOF_ID_risorsa__c,
            										caso__r.createddate,caso__r.lastModifiedDate ,caso__r.Status,caso__r.EOF_Codice_Ordine_OLO__c,caso__r.OF_Order__c,caso__r.RecordType.name,
            										caso__r.OF_Order__r.Status  ,caso__r.OF_Order__r.OF_Esito__c ,caso__r.AssetId 
            										from EOF_EAI_Service_Log__c 
            										where caso__c in :scope
            										and (EOF_Tipo_Comunicazione_String__c = 'SF->OLO - ACK - CompletionOrder' or  EOF_Tipo_Comunicazione_String__c = 'SF->OLO - ACK - Fibernotify - Espletamento')];
            	
            system.debug('I SA case sono '+slList.size());
            
            Map <Id,Case> mapIdCase = new Map <Id,Case> ( [SELECT id ,EOF_Codice_Ordine_OLO__c, OF_IDContratto__c,EOF_Id_Risorsa__c, OF_Bonifica_Locked_Row__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, EOF_Apparato__c,
                				  EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
                				  OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
                				  OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
                				  EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c,
                				  PO_Attenuazione__c, PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, RecordTypeId, RecordType.DeveloperName,
                				  Status, OF_Order__c, EOF_ID_Splitter_Secondario__c, EOF_Posizione_Splitter_Secondario__c, PO_Comune__c, EOF_Istat_Comune__c,
                				  EOF_Istat_Provincia__c, PO_Indirizzo_collegamento__c, PO_Civico__c
                				  FROM Case
                				  WHERE id in :scope]);
            
            Map <Id,EOF_EAI_Service_Log__c> mapIdLog = new Map <Id,EOF_EAI_Service_Log__c> ( 
                                                                [select Id,EOF_Tipo_comunicazione__c,EOF_Data_espletamento_ordine__c,EOF_Data_Notifica__c 
                                                                    from EOF_EAI_Service_Log__c where  caso__c in :scope ]
                                                                    );
            

            for(EOF_EAI_Service_Log__c sl : slList){
            	if(sl.caso__r.RecordType.developername=='EOF_Caso_Attivazione'){
            		//OM_GW_GE_Utils.aggiornamentoDatiCRM(sl.caso__c,sl.EOF_SL_Riferimento__c,sl.Id);
            		
            		OF_SA_GE_Utils.slSFOLO=mapIdLog.get(sl.EOF_SL_Riferimento__c);
            		OF_SA_GE_Utils.slSFOLOResp= sl ;
                    
                    OF_ManageOrderFromCase mofc = new OF_ManageOrderFromCase();
                    Case c = mapIdCase.get(sl.caso__c);
                    c.AssetId = mofc.ManageOrder(c); 
            	}
            	if(sl.caso__r.RecordType.developername=='OF_SA_Attivazione'){
            	
    	        	// chiamata future OF_SA_GE_Utils.aggiornamentoDatiEspletamento(sl.caso__c,sl.EOF_SL_Riferimento__c,sl.Id);

            		OF_SA_GE_Utils.slSFOLO=mapIdLog.get(sl.EOF_SL_Riferimento__c);
            		OF_SA_GE_Utils.slSFOLOResp= sl ;
                    
                    OF_ManageOrderFromCase_GPONP mofc = new OF_ManageOrderFromCase_GPONP();
                    Case c = mapIdCase.get(sl.caso__c);
                    c.AssetId = mofc.ManageOrder(c); 
            	}
           }

           update mapIdCase.values();

        }
    }  
	
    global void finish(Database.BatchableContext BC){
       
   
    }
    

}