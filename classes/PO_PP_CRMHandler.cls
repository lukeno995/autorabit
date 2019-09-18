public class PO_PP_CRMHandler {
	public static order o;
	Public Static Case c;
	Public Static String assetId;
	Public static String contractId;
	
	@future
	public static void createCRMKIT(Id caseId){
		c = [select Id,PO_PP_SVLAN__c,PO_PP_UserVlan__c,accountId,OF_SA_Profilo__c,EOF_Identificativo_del_POP__c,EOF_Comune_WS__c,EOF_Provincia_WS__c,
			 EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c,EOF_Scala_Palazzina_WS__c,
			 recordtype.developername,assetId,PO_PP_NomeKit__c,PO_PP_Traffico__c,PO_PP_Banda__c,PO_PP_Interfaccia_Kit__c,
			 PO_PP_Servizi_Finali__c,PO_PP_Posizione_ODF__c,PO_PP_Modello_Servizio__c,PO_PP_POP__c,EOF_Codice_Operatore_WS__c,
			 status,EOF_Codice_Ordine_OLO__c
			 from Case 
			 where id=:caseId];
		//System.debug('****c****:'+c);
		
		contractId = [select OF_Contract__c 
    		          from OF_ContrattoServizio__c  
    				  where OF_Servizio__r.Name = 'PREPROVISIONING' 
    				  AND OF_Contract__r.Account.EOF_Codice_Operatore__c=:c.EOF_Codice_Operatore_WS__c].OF_Contract__c;
		
		//System.debug('****contractId****:'+contractId);
		PO_PP_CRMHandler.CreateOrder(c);
	}
	 
	@future
	public static void createCRMVLAN(Id caseId,id AssetId){
		c = [select Id,PO_PP_SVLAN__c,PO_PP_UserVlan__c,accountId,PO_PP_POP_SVLAN__c,PO_PP_Cos_remarking__c,PO_PP_DHCP_Option82__c,
		     PO_PP_Cos_Type__c, PO_PP_Cos_Class__c,status,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore_WS__c,PO_PP_NomeKit__c
			 from Case 
			 where id=:caseId];		
			
		PO_PP_CRMHandler.assetId = AssetId;
		
		contractId = [select OF_Contract__c 
		              from OF_ContrattoServizio__c  
    				  where OF_Servizio__r.Name = 'PREPROVISIONING' 
    				  AND OF_Contract__r.Account.EOF_Codice_Operatore__c=:c.EOF_Codice_Operatore_WS__c].OF_Contract__c;	
    				
		String id_CEI = PO_PP_CRMHandler.CreateVLANCE();		
		PO_PP_CRMHandler.createVLANBE(id_CEI);
	}
	
	public static void CreateOrder(Case c){
		
		PO_PP_CRMHandler.o = new Order();
		PO_PP_CRMHandler.o.contractId = contractId;
		PO_PP_CRMHandler.o.accountId = c.accountId;
		PO_PP_CRMHandler.o.status = 'Chiuso';
		PO_PP_CRMHandler.o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
		
    	if(c.status=='Espletato'){
    		PO_PP_CRMHandler.o.OF_Esito__c='OK';
    	}
    	else{
    		PO_PP_CRMHandler.o.OF_Esito__c='KO';
    	}
		PO_PP_CRMHandler.o.OF_DataEsito__c = system.Today();
        if(c.OF_SA_Profilo__c != null){
        	Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();
            if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
            	PO_PP_CRMHandler.o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
        }
        PO_PP_CRMHandler.o.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
        PO_PP_CRMHandler.o.OF_Comune__c = c.EOF_Comune_WS__c;
        PO_PP_CRMHandler.o.OF_Provincia__c = c.EOF_Provincia_WS__c;
        PO_PP_CRMHandler.o.OF_ParticellaToponomastica__c = c.EOF_Particella_Toponomastica_WS__c;
        PO_PP_CRMHandler.o.OF_Indirizzo__c = c.EOF_Indirizzo_WS__c;
        PO_PP_CRMHandler.o.OF_Civico__c = c.EOF_Numero_Civico_WS__c;
        PO_PP_CRMHandler.o.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c;
        PO_PP_CRMHandler.o.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('OF_INORDER');
        PO_PP_CRMHandler.o.effectiveDate = system.Today();
		PO_PP_CRMHandler.assetId = PO_PP_CRMHandler.CreateAsset();
		PO_PP_CRMHandler.o.OF_Asset__c = PO_PP_CRMHandler.assetId;
		boolean inserito=false;
        boolean templog=false;
        Account a = new Account();	
        Templog__c t = new Templog__c();
        for(integer x=0; x<2; x++){
            try{
            	if(x==0){
	        		insert PO_PP_CRMHandler.o;
	        		inserito=true; 
	        		break;
            	}
            	if(x==1){
	            	a.name=c.Id;
	            	a.type='Temp';
	            	insert a;
	            	PO_PP_CRMHandler.o.OF_AccountTemporaneo__c=PO_PP_CRMHandler.o.AccountId;
            		PO_PP_CRMHandler.o.OF_ContractTemporaneo__c=PO_PP_CRMHandler.o.ContractId;
            		PO_PP_CRMHandler.o.AccountId=a.Id;
            		PO_PP_CRMHandler.o.contractId=null;
	            	insert PO_PP_CRMHandler.o;
	            	inserito=true; 
	            	break;
            	}
            }
            catch(exception e){
            	system.debug('@@@@ exception è: '+e);
            	if(!templog){
            		t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','PO_P2PAtt_CRMHandler','aggiornaOrdine',(x+1), e);
            		templog=true;
            	}
            	else{
            		t.OF_tentativi__c=(x+1);
            	}
            }
        }
        if(templog){
        	insert t;
        }
		c.OF_Order__c=PO_PP_CRMHandler.o.Id;
		if(c.recordtype.developername=='OF_PP_PreProvisioning_KITConsegna' && PO_PP_CRMHandler.o.OF_Esito__c=='OK'){
			String id_CEI = PO_PP_CRMHandler.createKITCE();
			PO_PP_CRMHandler.createKITBE(id_CEI);
		}
		else{
			PO_PP_CRMHandler.assetId=c.assetId;
		}
	}
	
	public static String CreateAsset(){
		Asset a = new Asset();
		a.accountId=c.AccountId;
		a.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('Preprovisioning');
		a.EOF_ID_Risorsa__c = c.PO_PP_NomeKit__c;
		a.OF_DataAttivazione2__c = system.now();
		a.OF_Identificativo_del_POP__c = c.EOF_Identificativo_del_POP__c;
		a.status = 'Attivo';
		a.OF_Contract__c = contractId;
		a.name = c.PO_PP_NomeKit__c;
		insert a;
		c.AssetId = a.Id;
		update c;
		return a.Id;
	}
	public static String createKITCE(){
		OF_CommercialElementIstanziato__c CEIKIT = new OF_CommercialElementIstanziato__c();
		CEIKIT.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('KIT');
		
		CEIKIT.OF_CommercialElement__c = [select Id from OF_CommercialElement__c 
										  where OF_Servizio__r.name='PREPROVISIONING'
										  AND name='SERVIZIO KIT'].Id;
		
		CEIKIT.OF_DataAttivazione__c = System.now();
		CEIKIT.PO_PP_Nome_KIT__c = c.PO_PP_NomeKit__c;
		//Start - Add by PG - 31-10
		CEIKIT.OF_Stato__c = 'Attivo';
		CEIKIT.PO_PP_Servizio_Commerciale__c = c.PO_PP_Traffico__c;
		//End - Add by PG - 31-10
		//CEIKIT.PO_PP_Traffico__c=c.PO_PP_Traffico__c; creare campo CEI
		CEIKIT.PO_PP_Banda_Interfaccia__c = c.PO_PP_Banda__c;
		CEIKIT.PO_PP_InterfacciaKit__c = c.PO_PP_Interfaccia_Kit__c;
		CEIKIT.PO_PP_Servizi_Utenti_Finali__c = c.PO_PP_Servizi_Finali__c;
		CEIKIT.PO_PP_Posizione_ODF__c = c.PO_PP_Posizione_ODF__c;
		CEIKIT.PO_PP_Modello_Servizio__c = c.PO_PP_Modello_Servizio__c;
		CEIKIT.PO_PP_Pop__c = c.PO_PP_POP__c;
		CEIKIT.OF_Asset__c = PO_PP_CRMHandler.assetId;
		CEIKIT.OF_CEStandard__c = PO_PP_CRMHandler.assetId;
		insert CEIKIT;
		return CEIKIT.ID;
	}
	
	public static void createKITBE(String id_CEI){
		List<PriceBook2> ListPBToInsert = new List<PriceBook2>();
		List<PriceBookEntry> ListPBEToInsert = new List<PriceBookEntry>();
		map<Pricebook2,List<PricebookEntry>> MapPBListPBEOld = new map<Pricebook2,List<PricebookEntry>>();
		map<Pricebook2,Pricebook2> MapPBOldPBNew = new map<Pricebook2,Pricebook2>();
		for (PriceBook2 PBOld : [select Id, Name, RecordTypeId,  IsActive,   
    							 (select Id, Name, Product2Id, UnitPrice, IsActive from PricebookEntries) 
    							 from Pricebook2 
    							 where PO_Commercial_element__r.OF_Servizio__r.name = 'PREPROVISIONING' 
    							 and PO_Commercial_element__r.name = 'SERVIZIO KIT' 
    							 and OF_Master__c = true]){
			Pricebook2 PBNew = new Pricebook2();
			PBNew = PBOld.clone(false,true,false,false);
			ListPBToInsert.add(PBNew);
			MapPBOldPBNew.put(PBOld, PBNew);
			MapPBListPBEOld.put(PBOld, PBOld.PricebookEntries);			
		}
		Insert ListPBToInsert;
		system.debug('@@@@ ListPBToInsert: '+ListPBToInsert);
		for(Pricebook2 PBOld : MapPBOldPBNew.keyset()){
			Pricebook2 PBNew = MapPBOldPBNew.get(PBOld);
			for(PriceBookEntry PBEOld:MapPBListPBEOld.get(PBOld)){
				PriceBookEntry PBENew = PBEOld.clone(false,true,false,false);	
				PBENew.OF_DataAttivazione2__c = System.now();
				PBENew.OF_Asset__c = PO_PP_CRMHandler.assetId;
				PBENew.pricebook2Id = PBNew.Id;
				PBENew.OF_CommercialElementIstanziato__c = id_CEI;
				//Add By PG - 07-02 - Aggiunta relazione con Order
				PBENew.OF_Order__c = PO_PP_CRMHandler.o.Id;
				//End 
				system.debug('@@@@ PBNew: '+PBNew);
				ListPBEToInsert.add(PBENew); 
				system.debug('@@@@ PBENew: '+PBENew);
			}
		}
		insert ListPBEToInsert;
	}
	
	public static String createVLANCE(){
		OF_CommercialElementIstanziato__c CEIVLAN = new OF_CommercialElementIstanziato__c();
		CEIVLAN.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('SVLAN');
		CEIVLAN.OF_CommercialElement__c = [select Id from OF_CommercialElement__c 
    									   where OF_Servizio__r.name='PREPROVISIONING'
    									   AND name='SERVIZIO VLAN'].Id;
		CEIVLAN.OF_DataAttivazione__c = system.now();
		CEIVLAN.PO_PP_POP_SVLAN__c = c.PO_PP_POP_SVLAN__c;
		CEIVLAN.PO_PP_Cos_remarking__c = c.PO_PP_Cos_remarking__c;
		CEIVLAN.PO_PP_DHCP_Option82__c = c.PO_PP_DHCP_Option82__c;
		CEIVLAN.PO_PP_Cos_Type__c = c.PO_PP_Cos_Type__c;
		CEIVLAN.PO_PP_Cos_Class__c = c.PO_PP_Cos_Class__c;
		CEIVLAN.OF_Asset__c = PO_PP_CRMHandler.assetId;
		CEIVLAN.OF_CEStandard__c = PO_PP_CRMHandler.assetId;
		CEIVLAN.OF_KitConsegnaVLAN__c = c.PO_PP_NomeKit__c;
		CEIVLAN.OF_ProfiloVLAN__c = c.PO_PP_Cos_Class__c;
		CEIVLAN.OF_Case__c = c.Id;
		//gb start		
		CEIVLAN.OF_UserVLAN__c = c.PO_PP_UserVlan__c;
		CEIVLAN.OF_ServiceVLAN__c = c.PO_PP_SVLAN__c;
		//Start - Add by PG - 07-02
		CEIVLAN.OF_Stato__c = 'Attivo';
		//End 
		List<Asset> listAsset = [Select id,EOF_ID_Risorsa__c, Name 
		                        from Asset 
		                        Where Id=:PO_PP_CRMHandler.assetId 
		                        limit 1];
		if(!listAsset.isEmpty()){
		   CEIVLAN.OF_IDRisorsa__c = listAsset.get(0).EOF_ID_Risorsa__c;
		   CEIVLAN.OF_KitConsegnaVLAN__c = listAsset.get(0).Name; 
		}
		//gb end
		insert CEIVLAN;
		return CEIVLAN.ID;
	}
	
	public static void createVLANBE(String id_CEI){
		List<PriceBook2> ListPBToInsert = new List<PriceBook2>();
		List<PriceBookEntry> ListPBEToInsert = new List<PriceBookEntry>();
		map<Pricebook2,List<PricebookEntry>> MapPBListPBEOld  = new map<Pricebook2,List<PricebookEntry>>();
		map<Pricebook2,Pricebook2> MapPBOldPBNew  = new map<Pricebook2,Pricebook2>();
		for (PriceBook2 PBOld : [select Id, Name, RecordTypeId,  IsActive,   
    							(select Id, Name, Product2Id, UnitPrice, IsActive  from PricebookEntries) 
    							from Pricebook2 where PO_Commercial_element__r.OF_Servizio__r.name='PREPROVISIONING' 
    							and PO_Commercial_element__r.name='SERVIZIO VLAN' 
    							and OF_Master__c = true]){
			Pricebook2 PBNew = new Pricebook2();
			PBNew=PBOld.clone(false,true,false,false);
			ListPBToInsert.add(PBNew);
			MapPBOldPBNew.put(PBOld,PBNew);
			MapPBListPBEOld.put(PBOld,PBOld.PricebookEntries);			
		}
		Insert ListPBToInsert;
		system.debug('@@@@ ListPBToInsert: '+ListPBToInsert);
		for(Pricebook2 PBOld:MapPBOldPBNew.keyset()){
			Pricebook2 PBNew = MapPBOldPBNew.get(PBOld);
			for(PriceBookEntry PBEOld : MapPBListPBEOld.get(PBOld)){
				PriceBookEntry PBENew = PBEOld.clone(false,true,false,false);	
				PBENew.OF_DataAttivazione2__c = system.now();
				PBENew.OF_Asset__c = PO_PP_CRMHandler.assetId;
				PBENew.pricebook2Id = PBNew.Id;
				PBENew.OF_CommercialElementIstanziato__c = id_CEI;
				system.debug('@@@@ PBNew: '+PBNew);
				ListPBEToInsert.add(PBENew); 
				system.debug('@@@@ PBENew: '+PBENew);
			}
		}
		insert ListPBEToInsert;
	}
}