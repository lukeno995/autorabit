public class OF_CD_CRMHandler {
    
    public static order o;
	public Static Case c;
	public Static String assetId;
	public Static String rtName;
	public Static String nomeServizio;
	public static boolean cpeRibImpPBE = false;
	public static boolean cpeRibImpCEI = false;
    public static String cpeEsitoConsegnaApparato;
    public Static List<OF_CommercialElementIstanziato__c> cpeList;
    public Static Map<String,OF_CommercialElementIstanziato__c> ceiMap;
    public Static Map<String,Id> rtMap;
    public static Asset assetToInactivate;
    public static boolean contributoRitiro = false;

	public static String CreateAsset(Case c1, Order o1)
	{
		Asset a = new Asset();
		a.accountId = o1.AccountId;
		
		system.debug('@@@@@@@EC  a.accountId=c1.AccountId: ' + a.accountId);
		
        if(c1.RecordType.DeveloperName=='EOF_Caso_Attivazione_OPENSTREAM_CeD')
        {
        	system.debug('@@@@@@@EC  c1.rt OS CD');
        	a.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('OF_CD_Asset_OpenStream');  
        }
        else if(c1.RecordType.DeveloperName=='EOF_SP_Caso_Attivazione_CeD'){
        	system.debug('@@@@@@@EC  c1.rt SP CD');
        	a.recordtypeId = OF_Utility.getRT_DevNameId_Map().get('OF_CD_Asset_GPON_Passiva');   
        }
		
		a.EOF_ID_Risorsa__c = c1.EOF_Id_Risorsa__c; 
		system.debug('@@@@@@@EC  a.EOF_ID_Risorsa__c: ' + a.EOF_ID_Risorsa__c );
		a.OF_DataAttivazione2__c = system.now();
		a.OF_Identificativo_del_POP__c = c1.EOF_Identificativo_del_POP__c;
		a.status = 'Attivo';
		a.OF_Contract__c = o1.contractId;
		system.debug('@@@@@@@EC  a.OF_Contract__c: ' + a.OF_Contract__c );
		a.name=c1.EOF_Id_Risorsa__c;
		insert a;
		
		system.debug('@@@@@@@EC  appena inserito asset: ' + a);
		OF_CD_CRMHandler.assetId = a.Id;
        system.debug('@@@@@@@EC  appena  assetid Variabile statica: ' +OF_CD_CRMHandler.assetId);
		c1.AssetId = a.id;
		//c1.AssetId=OF_CD_CRMHandler.assetId;
		system.debug('@@@@@@@EC  appena associato asset a case: ' + c1.AssetId);
		update c1;
		
		system.debug('@@@@@@@EC  fatto updte case: ' + c1);
		linkCEIAndBEtoAsset(c1,o1);
		system.debug('@@@@@@@EC  dopo aver chiamato linkCEIAndBEtoAsset');
		return a.Id;
	}
	
	//Start PG - Add 17-12 
    public static void cessazioneAsset(Case c1, Order o1)
	{
	    system.debug('cessazioneAsset: '+o1.OF_Asset__c);
	    if(o1.OF_Asset__c!=null){
	        
            OF_CD_CRMHandler.assetToInactivate = [Select id, name, EOF_ID_Risorsa__c, status, OF_DataCessazione2__c, OF_Contract__c,
                                                  (select id,name,recordtype.developername from Commercial_element_istanziati__r)
                                                  from Asset
                                                  where id =: o1.OF_Asset__c];
	    }
        if(OF_SA_CD_GE_Utils.slSFOLO != null && OF_CD_CRMHandler.assetToInactivate!=null){
            System.debug('*** OF_SA_CD_GE_Utils valorizzata - Valore data notifica = ' + OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c);
            //OF_CD_CRMHandler.assetToInactivate.OF_DataCessazione2__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c;
            OF_CD_CRMHandler.assetToInactivate.OF_DataCessazione2__c = System.now();
        }

        OF_CD_CRMHandler.assetToInactivate.status = 'Cessato';
        OF_CD_CRMHandler.assetToInactivate.OF_OrdineId__c = o1.Id;
        update OF_CD_CRMHandler.assetToInactivate;
	}
    //End PG - Add 17-12

    
    //Creazione del Product/PricebookEntry Contributo Disattivazione 
    public static void createContributoDisattivazione(Order ord, Asset asset_x, String ceiBase)
    {
        if(ord.OF_Asset__c!=null){
	        
            OF_CD_CRMHandler.assetToInactivate = [Select id, name, EOF_ID_Risorsa__c, status, OF_DataCessazione2__c, OF_Contract__c, RecordType.name,
                                                  (select id,name,recordtype.developername, OF_EsitoRitiroApparato__c 
                                                  from Commercial_element_istanziati__r)
                                                  from Asset
                                                  where id =: ord.OF_Asset__c];
                                 
            OF_CD_CRMHandler.assetId = OF_CD_CRMHandler.assetToInactivate.id; 
            OF_CD_CRMHandler.rtName = OF_CD_CRMHandler.assetToInactivate.RecordType.name; 
	    }
	    
	    if(OF_CD_CRMHandler.rtName.equalsIgnoreCase('Open Stream CeD') ){
	        nomeServizio = 'Open Stream CD';
	    }
	    else if(OF_CD_CRMHandler.rtName.equalsIgnoreCase('GPON Passiva CD') ){
	        nomeServizio = 'GPON Passiva CD';
	    }
	        
        System.debug('***Creazione Contributo Disattivazione...***');
        System.debug('####Codice Contratto su Asset#### '+asset_x.OF_Contract__c);
        set<String> nomiPbeSet = new set<String>();
        nomiPbeSet.add('Contributo Disattivazione');
        
        OF_CD_CRMHandler.ceiMap = new Map<String,OF_CommercialElementIstanziato__c>();
        for(OF_CommercialElementIstanziato__c cei : OF_CD_CRMHandler.assetToInactivate.Commercial_element_istanziati__r){
        	if(cei.recordtype.developername=='OF_CPE' /*&& cei.OF_EsitoRitiroApparato__c=='0'*/){
        	    System.debug('***Creazione Contributo Ritiro in corso....***');
        		nomiPbeSet.add('Contributo Ritiro');
        	}
        	OF_CD_CRMHandler.ceiMap.put(cei.name,cei);
        }
        System.debug('<<<< nomiPbeSet >>> : '+nomiPbeSet);
        
		List<Pricebook2> PbToInsert = new List<Pricebook2>();
		List<PricebookEntry> PbeToInsert = new List<PricebookEntry>();
		Set<Id> PBIDs = new Set<Id>(); 
		map<String,Pricebook2> mapNomePBPricebook2 = new map<String,Pricebook2>();
		Map<String,PricebookEntry> mapNomeContrPricebookEntry = new Map<String,PricebookEntry>();
        
        for(PricebookEntry pbe : [select Id, Name, Product2Id, UnitPrice, IsActive,
                                  Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name,
								  Pricebook2Id,Pricebook2.PO_Commercial_element__c, Pricebook2.PO_Commercial_element__r.Name, Pricebook2.name
								  from PricebookEntry 
                                  where Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_Servizio__r.Name =: nomeServizio //'Open Stream CD' o 'GPON Passiva CD'
                                  and Name =: nomiPbeSet
								  and OF_Master__c = true]){
			System.debug('<<<<< pbeCurr >>>> :'+pbe);
			PricebookEntry pbeToClone = pbe.clone(false,true,false,false);
			mapNomeContrPricebookEntry.put(pbe.Name, pbe);
			pbeToInsert.add(pbeToClone);	
			PBIDs.add(pbe.Pricebook2Id);													
		}
        for(Pricebook2 pb : [Select id, RecordtypeId, isActive,Description, Name,PO_Commercial_element__c, 
                			 PO_Contratto__c, OF_Listino__c 
                			 from Pricebook2
                             where id in : PBIDs]){
			Pricebook2 pbToClone = pb.clone(false,true,false,false); 
			mapNomePBPricebook2.put(pb.Name,pbToClone);
			PbToInsert.add(pbToClone);															
		}
		Insert PbToInsert;
		
		for(pricebookentry pbe : pbeToInsert){
    		pbe.pricebook2Id = mapNomePBPricebook2.get(pbe.pricebook2.name).Id;
    		pbe.OF_DataAttivazione2__c = system.now();
    		pbe.OF_Asset__c = OF_CD_CRMHandler.assetId;
    		if(OF_CD_CRMHandler.ceiMap.get(pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name)!=null){
    			pbe.OF_CommercialElementIstanziato__c = OF_CD_CRMHandler.ceiMap.get(pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name).Id;
    		}
    	}
    	Insert pbeToInsert;
    }
    
    //Creazione CEI e PBE
    public static void linkCEIAndBEtoAsset(Case c1, Order o1)
    {
    	system.debug('@@@@@@@EC  appena chiamato linkCEIAndBEtoAsset siamo dentro'); 
    	set<Id> ceiIdSet = new set<Id>();
    	Set<String> ceiNameSet = new Set<String>();
    	List<OF_CommercialElementIstanziato__c> ceiToUpdate = new List<OF_CommercialElementIstanziato__c>();
    	List<PriceBookEntry> pbToUpdate = new List<PriceBookEntry>();
    	OF_CD_CRMHandler.ceiMap = new Map<String,OF_CommercialElementIstanziato__c>();
	    
	    for(OF_CommercialElementIstanziato__c cei: [Select id, Name, OF_Asset__c,RecordType.DeveloperName, 
	                                                OF_EsitoConsegnaApparato__c, OF_AzioneApparato__c,
	    											OF_CommercialElement__r.Name, OF_CommercialElementName__c
	    											from OF_CommercialElementIstanziato__c 
	    											where OF_Case__c=: c1.id]){
	    											//0 solo consegna	    	
	    	//CPE = APPARATO
	    	if(cei.RecordType.DeveloperName=='OF_CPE')
	    	{
	    		if(cei.OF_EsitoConsegnaApparato__c=='2'){
    	    		OF_CD_CRMHandler.cpeRibImpPBE = true;
	    		}
	    		OF_CD_CRMHandler.cpeEsitoConsegnaApparato = cei.OF_AzioneApparato__c;
	    		cei.OF_CPE__c = OF_CD_CRMHandler.assetId;
	    	}		 
	    	if(cei.RecordType.DeveloperName=='OF_VLAN')
	    	{
	    		cei.OF_VLAN__c = OF_CD_CRMHandler.assetId;
	    	}
	    	if(cei.RecordType.DeveloperName=='OF_ServiziAggiuntivi')
	    	{
	    		cei.OF_ServiziAggiuntivi__c = OF_CD_CRMHandler.assetId;
	    		if(cei.OF_CommercialElementName__c=='RIBALTAMENTO IMPIANTO'){
	    			OF_CD_CRMHandler.cpeRibImpCEI = true;
	    		}
	    	}								//1 
    		cei.OF_Asset__c = OF_CD_CRMHandler.assetId;
    		cei.OF_Stato__c = 'Attivo';
    		cei.OF_DataAttivazione__c = System.now();
    		ceiIdSet.add(cei.id);
    		ceiToUpdate.add(cei);
    		OF_CD_CRMHandler.ceiMap.put(cei.OF_CommercialElement__r.Name, cei);
    	    //ceiNameSet.add(cei.Name);
    	}
    	update ceiToUpdate;
    	system.debug('<<< ceiToUpdate >>> : '+ceiToUpdate);
    	system.debug('@@@@@@@EC  CEI - post update ');
    	createCeiAndPbe(c1, o1); 
		system.debug('@@@@@@@EC  dopo la chiamata del metodo createCeiAndPbe');
    }
   
    public Static void createCeiAndPbe(case c1, Order o1)
    {
        system.debug('@@@@@@@EC  appena chiamato il metodo createCeiAndPbe');
        //creiamo un pricebook per ogni pricebook entry
        //mi faccio una lista di commercial element legati al servizio (in caso di case attivo uno e in caso di case passivo un altra lista)
        //where OF_Servizio__c
        
        Map<String,OF_CommercialElement__c> mappaNomeServizioListaCEAssociati = new Map<String,OF_CommercialElement__c>();
        //mappaNomeServizioListaCEAssociati è la mappa che ha come chiave il nome del commercial element e tira fuori il commercial element stesso.
        
        if(c1.RecordType.DeveloperName=='EOF_Caso_Attivazione_OPENSTREAM_CeD')
        {
	        //la mappaNomeServizioListaCEAssociati ha come chiave il nome del commercial element e tira fuori l'intero commercial element 
	        
	        Set<String> oSCEname = new Set<String>();
	        Set<Id> ceSetFromcei = new Set<Id>();
	        List<OF_CommercialElementIstanziato__c> ceiToInsert = new List<OF_CommercialElementIstanziato__c>();
	        
	        for(OF_CommercialElement__c oSCE : [select id,Name,/*ID_Prod__c,*/OF_DataInizioValidita__c,OF_DataFineValidita__c,
	    										OF_Commercial_Element_Code__c,OF_CatalogoCommerciale__c,OF_Attivo__c
	    										from OF_CommercialElement__c 
	    										where OF_Servizio__r.Name = 'Open Stream CD' 
	    										AND OF_Attivo__c=true]){
	    		//la mappaNomeServizioListaCEAssociati ha come chiave il nome del commercial element e tira fuori l'intero commercial element
	            mappaNomeServizioListaCEAssociati.put(oSCE.Name, oSCE);
	        }
	        system.debug('@@@@@@@EC  mappaNomeServizioListaCEAssociati ' + mappaNomeServizioListaCEAssociati);
	    	
	    	OF_CommercialElementIstanziato__c SERVIZIOOPENSTREAMBASE = new OF_CommercialElementIstanziato__c();
		   	SERVIZIOOPENSTREAMBASE.OF_Asset__c = OF_CD_CRMHandler.assetId;
		    SERVIZIOOPENSTREAMBASE.OF_IDRisorsa__c = c1.EOF_Id_Risorsa__c;
		    SERVIZIOOPENSTREAMBASE.OF_Stato__c = 'Attivo';
		    SERVIZIOOPENSTREAMBASE.OF_CEStandard__c = OF_CD_CRMHandler.assetId;
		    SERVIZIOOPENSTREAMBASE.OF_DataAttivazione__c = System.Now();
            SERVIZIOOPENSTREAMBASE.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_Standard');
		    SERVIZIOOPENSTREAMBASE.OF_CommercialElement__c = mappaNomeServizioListaCEAssociati.get('SERVIZIO OPEN STREAM BASE').Id; 
		    system.debug('<<<<< SERVIZIOOPENSTREAMBASE >>>> '+SERVIZIOOPENSTREAMBASE);
		    system.debug('@@@@@@@@@@EC prova. SERVIZIOOPENSTREAMBASE.OF_CommercialElement__c: ' + SERVIZIOOPENSTREAMBASE.OF_CommercialElement__c);
		    ceiToInsert.add(SERVIZIOOPENSTREAMBASE);
		    
		    ceSetFromcei.add(SERVIZIOOPENSTREAMBASE.OF_CommercialElement__c);
	    	OF_CD_CRMHandler.ceiMap.put(mappaNomeServizioListaCEAssociati.get('SERVIZIO OPEN STREAM BASE').Name, SERVIZIOOPENSTREAMBASE);
	    	
	    	//caso in cui è stato ribaltato ma non c'è il relativo CEI sul case
	    	if(OF_CD_CRMHandler.cpeRibImpPBE && !OF_CD_CRMHandler.cpeRibImpCEI)
	    	{
	    	    System.debug('*****SONO QUI - 1*****');
	    		OF_CommercialElementIstanziato__c ribImp = new OF_CommercialElementIstanziato__c();
	            ribImp.OF_Asset__c = OF_CD_CRMHandler.assetId;
	            ribImp.OF_IDRisorsa__c = c1.EOF_Id_Risorsa__c;
	            ribImp.OF_Stato__c = 'Attivo';
	            ribImp.OF_DataAttivazione__c = System.Now();
                ribImp.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_ServiziAggiuntivi');
	            ribImp.OF_CommercialElement__c = mappaNomeServizioListaCEAssociati.get('RIBALTAMENTO IMPIANTO').id;
	            ceiToInsert.add(ribImp);
	            ceSetFromcei.add(ribImp.OF_CommercialElement__c);
	            OF_CD_CRMHandler.ceiMap.put(mappaNomeServizioListaCEAssociati.get('RIBALTAMENTO IMPIANTO').Name,ribImp);	
	    	}
	    	insert ceiToInsert;
	    	System.debug('°°°ceiToInsert°°° '+ceiToInsert);
	    	
	        List<PriceBook2> ListPBToInsert = new List<PriceBook2>();
	        // List<PriceBookEntry> ListPBEToInsert = new List<PriceBookEntry>();
	        
	        map<Pricebook2,List<PricebookEntry>> MapPBListPBEOld = new map<Pricebook2,List<PricebookEntry>>();
	        map<Pricebook2,Pricebook2> MapPBOldPBNew = new map<Pricebook2,Pricebook2>();

	        //prima creare un commercial element SERVIZIO OPEN STREAM BASE per open stream 
	        List<OF_CommercialElement__c> ceList = new List<OF_CommercialElement__c>();
        	set<String> nomiPbeSet = new Set<String>();
        	nomiPbeSet.add('Contributo Attivazione');
			nomiPbeSet.add('Canone');
			
			System.debug('<<<< OF_CD_CRMHandler.cpeEsitoConsegnaApparato >>>> '+OF_CD_CRMHandler.cpeEsitoConsegnaApparato);
			
			//cpeEsitoConsegnaApparato = ESITO CONSEGNA APPARATO del CEI (Esito consegna apparato equivale ad Azione Apparato ed assume valori 0,1,2)
			if(OF_CD_CRMHandler.cpeEsitoConsegnaApparato=='0'){
				nomiPbeSet.add('Contributo Consegna');
			}
			else if(OF_CD_CRMHandler.cpeEsitoConsegnaApparato=='1'){
			    nomiPbeSet.add('Contributo Consegna e Istallazione');
			}
			else if(OF_CD_CRMHandler.cpeEsitoConsegnaApparato=='2'){
				nomiPbeSet.add('Contributo Istallazione');
			}
			if(OF_CD_CRMHandler.cpeRibImpPBE){
				nomiPbeSet.add('Contributo Ribaltamento Impianto');	
			}
			System.debug('<<< nomiPbeSet >>> :'+nomiPbeSet);
			
			Map<String,PricebookEntry> mapNomeContrPricebookEntry = new Map<String,PricebookEntry>();
			Map<String,Pricebook2> mapNomePBPricebook2 = new Map<String,Pricebook2>();
			Set<Id> pbeId = new Set<Id>();
			List<PricebookEntry> pbeToInsert = new List<PricebookEntry>();
			
			for(PricebookEntry pbeCPEConsegnaApparatoMaster :[select Id, Name, Product2Id, UnitPrice, IsActive,
                                                       		  Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name,
															  Pricebook2Id,Pricebook2.PO_Commercial_element__c, Pricebook2.PO_Commercial_element__r.Name,
															  Pricebook2.name
															  from PricebookEntry 
                                                              where Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_Servizio__r.Name='Open Stream CD' 
                                                              and Name =: nomiPbeSet
															  and OF_Master__c = true ]){
																    
				if(pbeCPEConsegnaApparatoMaster.Name=='Canone'){
					if(OF_CD_CRMHandler.getPBNameFromProfile(c1.OF_SA_Profilo__c)==pbeCPEConsegnaApparatoMaster.Pricebook2.name){
						pricebookentry pbeToClone = pbeCPEConsegnaApparatoMaster.clone(false,true,false,false);
						System.debug('<<< Canone clonato >>> : '+pbeToClone);
						mapNomeContrPricebookEntry.put(pbeCPEConsegnaApparatoMaster.Name, pbeToClone);
						pbeId.add(pbeToClone.Pricebook2Id);
						pbeToInsert.add(pbeToClone);
					}
				}
				else{
					pricebookentry pbeToClone = pbeCPEConsegnaApparatoMaster.clone(false,true,false,false); //EC 2018 - 12 - 11
					mapNomeContrPricebookEntry.put(pbeCPEConsegnaApparatoMaster.Name, pbeCPEConsegnaApparatoMaster);
					pbeId.add(pbeCPEConsegnaApparatoMaster.Pricebook2Id);
					pbeToInsert.add(pbeToClone);//EC 2018 - 12 - 11
				}											
			} 
			System.debug('<<<< pbeID >>>> :'+pbeID);
			System.debug('<<<< pbeToInsert >>>> :'+pbeToInsert);

			List<Pricebook2> PbToInsert = new List<Pricebook2>();      	
        	for(Pricebook2 pbCPEConsegnaApparatoMaster : [Select id, RecordtypeId, isActive,Description, Name,PO_Commercial_element__c, 
                										  PO_Contratto__c, OF_Listino__c 
                										  from Pricebook2 
                										  where id IN : pbeId
                										  and OF_Master__c = true]){
                										      
				Pricebook2 pbToClone = pbCPEConsegnaApparatoMaster.clone(false,true,false,false); 
				mapNomePBPricebook2.put(pbCPEConsegnaApparatoMaster.Name, pbToClone);
				PbToInsert.add(pbToClone);									
			}
        	Insert PbToInsert;
        	
        	System.debug('<<<< PbToInsert >>>> :'+PbToInsert);
        	
        	System.debug('##### OF_CD_CRMHandler.ceiMap ##### : '+OF_CD_CRMHandler.ceiMap);
        	
        	for(pricebookentry pbe : pbeToInsert){
        		system.debug('@@@@@@@@@EC pbe: ' + pbe);
        		pbe.pricebook2Id = mapNomePBPricebook2.get(pbe.pricebook2.name).Id;
        		system.debug('@@@@@@@@@EC pbe.pricebook2Id: ' + pbe.pricebook2Id);
        		pbe.OF_DataAttivazione2__c = system.now();
        		pbe.OF_Asset__c = OF_CD_CRMHandler.assetId;
        		system.debug('@@@@@@@@@EC pbe.OF_Asset__c: ' + pbe.OF_Asset__c);
        		system.debug('@@@@@@@@@EC pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name: ' + pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name);
        		
        		if(OF_CD_CRMHandler.ceiMap.get(pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name)!=null){
        			pbe.OF_CommercialElementIstanziato__c = OF_CD_CRMHandler.ceiMap.get(pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name).Id;
        		}
        	}
        	Insert pbeToInsert;
	    }

	    else if(c1.RecordType.DeveloperName=='EOF_SP_Caso_Attivazione_CeD')
	    {
	        Set<String> oSCEname = new Set<String>();
	        Set<Id> ceSetFromcei = new Set<Id>();
	        List<OF_CommercialElementIstanziato__c> ceiToInsert = new List<OF_CommercialElementIstanziato__c>();
	        
	        for(OF_CommercialElement__c oSCE : [select id,Name,/*ID_Prod__c,*/OF_DataInizioValidita__c,OF_DataFineValidita__c,
	    										 OF_Commercial_Element_Code__c,OF_CatalogoCommerciale__c,OF_Attivo__c
	    										 from OF_CommercialElement__c 
	    										 where OF_Servizio__r.Name = 'GPON Passiva CD' 
	    										 AND OF_Attivo__c=true]){
	    		//la mappaNomeServizioListaCEAssociati ha come chiave il nome del commercial element e tira fuori l'intero commercial element
	            mappaNomeServizioListaCEAssociati.put(oSCE.Name,oSCE);
	        }
	        system.debug('@@@@@@@EC  mappaNomeServizioListaCEAssociati ' + mappaNomeServizioListaCEAssociati);
	    	
	    	OF_CommercialElementIstanziato__c SERVIZIOFIBRABASE = new OF_CommercialElementIstanziato__c();
		   	SERVIZIOFIBRABASE.OF_Asset__c = OF_CD_CRMHandler.assetId;
		    SERVIZIOFIBRABASE.OF_IDRisorsa__c = c1.EOF_Id_Risorsa__c;  
		    SERVIZIOFIBRABASE.OF_Stato__c = 'Attivo';
		    SERVIZIOFIBRABASE.OF_CEStandard__c = OF_CD_CRMHandler.assetId;
            SERVIZIOFIBRABASE.RecordTypeId = OF_Utility.getRT_DevNameId_Map().get('OF_Standard');
		    SERVIZIOFIBRABASE.OF_DataAttivazione__c = System.Now();
		    SERVIZIOFIBRABASE.OF_CommercialElement__c = mappaNomeServizioListaCEAssociati.get('SERVIZIO FIBRA BASE').Id; 
		    system.debug('@@@@@@@@@@EC prova. SERVIZIOFIBRABASE.OF_CommercialElement__c: ' + SERVIZIOFIBRABASE.OF_CommercialElement__c);
		    ceiToInsert.add(SERVIZIOFIBRABASE);
		    ceSetFromcei.add(SERVIZIOFIBRABASE.OF_CommercialElement__c);
	    	OF_CD_CRMHandler.ceiMap.put(mappaNomeServizioListaCEAssociati.get('SERVIZIO FIBRA BASE').Name,SERVIZIOFIBRABASE);
	    	
	    	if(OF_CD_CRMHandler.cpeRibImpPBE && !OF_CD_CRMHandler.cpeRibImpCEI)
	    	{
	    	    System.debug('*****SONO QUI - 2*****');
	    		OF_CommercialElementIstanziato__c ribImp = new OF_CommercialElementIstanziato__c();
	            ribImp.OF_Asset__c = OF_CD_CRMHandler.assetId;
	            ribImp.OF_IDRisorsa__c = c1.EOF_Id_Risorsa__c;
	            ribImp.OF_Stato__c = 'Attivo';
	            ribImp.OF_DataAttivazione__c = System.Now();
	            ribImp.OF_CommercialElement__c = mappaNomeServizioListaCEAssociati.get('RIBALTAMENTO IMPIANTO').id;
                ribImp.RecordTypeId=OF_Utility.getRT_DevNameId_Map().get('OF_ServiziAggiuntivi');
	            ceiToInsert.add(ribImp);
	            ceSetFromcei.add(ribImp.OF_CommercialElement__c);
	            OF_CD_CRMHandler.ceiMap.put(mappaNomeServizioListaCEAssociati.get('RIBALTAMENTO IMPIANTO').Name,ribImp);	
	    	}
	    	insert ceiToInsert;
	    	
	        List<PriceBook2> ListPBToInsert = new List<PriceBook2>();
	        // List<PriceBookEntry> ListPBEToInsert = new List<PriceBookEntry>();
	        
	        map<Pricebook2,List<PricebookEntry>> MapPBListPBEOld = new map<Pricebook2,List<PricebookEntry>>();
	        map<Pricebook2,Pricebook2> MapPBOldPBNew = new map<Pricebook2,Pricebook2>();
	        //
	        //la lista di commercial element relativi al  SERVIZIO FIBRA BASE per GPON Passiva CD 
	        // List<OF_CommercialElement__c> openStreamCEList = 
	        
	        //prima creare un commercial element SERVIZIO FIBRA BASE per GPON Passiva CD 
	        List<OF_CommercialElement__c> ceList = new List<OF_CommercialElement__c>();
        	set<String> nomiPbeSet = new Set<String>();
        	nomiPbeSet.add('Contributo Attivazione');
			nomiPbeSet.add('Canone');
			
			//System.debug('#### c1.OF_Esito_Consegna_Apparato__c : ####'+c1.OF_Esito_Consegna_Apparato__c);
			
			if(OF_CD_CRMHandler.cpeEsitoConsegnaApparato=='0'){
		        nomiPbeSet.add('Contributo Consegna');
        	}
        	else if(OF_CD_CRMHandler.cpeEsitoConsegnaApparato=='1'){
        		nomiPbeSet.add('Contributo Istallazione');
        	}
        	else if(OF_CD_CRMHandler.cpeEsitoConsegnaApparato=='2'){
        		nomiPbeSet.add('Contributo Consegna e Istallazione');
        	}
        	if(OF_CD_CRMHandler.cpeRibImpPBE){
        		nomiPbeSet.add('Contributo Ribaltamento Impianto');	
        	}
			System.debug('<<< nomiPbeSet >>> :'+nomiPbeSet);
	        
	        /*	
			if(c1.OF_Esito_Consegna_Apparato__c=='0'){
				nomiPbeSet.add('Contributo Consegna');
			}
			else if(c1.OF_Esito_Consegna_Apparato__c=='1'){
				//nomiPbeSet.add('Contributo Consegna e Istallazione');
				nomiPbeSet.add('Contributo Istallazione');
			}
			else if(c1.OF_Esito_Consegna_Apparato__c=='2'){
				nomiPbeSet.add('Contributo Consegna e Istallazione');
				nomiPbeSet.add('Contributo Ribaltamento Impianto');
			}
			*/

			Map<String,PricebookEntry> mapNomeContrPricebookEntry = new Map<String,PricebookEntry>();
			Map<String,Pricebook2> mapNomePBPricebook2 = new Map<String,Pricebook2>();
			Set<Id> pbeId = new Set<Id>();
			List<PricebookEntry> pbeToInsert = new List<PricebookEntry>();
			for (PricebookEntry pbeCPEConsegnaApparatoMaster : [select Id, Name, Product2Id, UnitPrice, IsActive, 
                                                       		    Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name,
															    Pricebook2Id,Pricebook2.PO_Commercial_element__c, Pricebook2.PO_Commercial_element__r.Name,
															    Pricebook2.name,OF_CommercialElementIstanziato__c,
															    OF_CommercialElementIstanziato__r.OF_CommercialElementName__c,
                                                       		    OF_CommercialElementIstanziato__r.OF_CommercialElement__r.OF_Servizio__c,
															    OF_CommercialElementIstanziato__r.OF_CommercialElement__r.OF_Servizio__r.Name
															    from PricebookEntry 
                                                                where Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_Servizio__r.Name='GPON Passiva CD'
                                                                and Name =: nomiPbeSet
															    and OF_Master__c = true]){
			/*
			if(pbeCPEConsegnaApparatoMaster.Name=='Canone'){
				if(OF_CD_CRMHandler.getPBNameFromProfile(c1.OF_SA_Profilo__c)==pbeCPEConsegnaApparatoMaster.Pricebook2.name){
					pricebookentry pbeToClone=pbeCPEConsegnaApparatoMaster.clone(false,true,false,false);
					mapNomeContrPricebookEntry.put(pbeCPEConsegnaApparatoMaster.Name, pbeToClone);
					pbeId.add(pbeToClone.Pricebook2Id);
					pbeToInsert.add(pbeToClone);
				}
			}
			*/
			//	else{
			pricebookentry pbeToClone = pbeCPEConsegnaApparatoMaster.clone(false,true,false,false); //EC 2018 - 12 - 11
			mapNomeContrPricebookEntry.put(pbeCPEConsegnaApparatoMaster.Name, pbeCPEConsegnaApparatoMaster);
			pbeId.add(pbeCPEConsegnaApparatoMaster.Pricebook2Id);
			pbeToInsert.add(pbeToClone);//EC 2018 - 12 - 11
			//	}											
			} 
			List<Pricebook2> PbToInsert = new List<Pricebook2>();      	
			System.debug('<<< pbeId >>> : '+pbeId);
        	for(Pricebook2 pbCPEConsegnaApparatoMaster : [Select id, RecordtypeId, isActive,Description, Name,PO_Commercial_element__c, 
                										  PO_Contratto__c, OF_Listino__c 
                										  from Pricebook2 
                										  where id IN : pbeId
                										  and OF_Master__c = true]){
				Pricebook2 pbToClone = pbCPEConsegnaApparatoMaster.clone(false,true,false,false); 
				mapNomePBPricebook2.put(pbCPEConsegnaApparatoMaster.Name, pbToClone);
				PbToInsert.add(pbToClone);									
			}
        	Insert PbToInsert;
        	
        	System.debug('##### OF_CD_CRMHandler.ceiMap ##### : '+OF_CD_CRMHandler.ceiMap);
        	System.debug('<<<< mapNomePBPricebook2 >>>> : '+mapNomePBPricebook2);
        	
        	for(pricebookentry pbe : pbeToInsert){
        		system.debug('@@@@@@@@@EC pbe: ' + pbe);
        		pbe.pricebook2Id = mapNomePBPricebook2.get(pbe.pricebook2.name).Id;
        		system.debug('@@@@@@@@@EC pbe.pricebook2Id: ' + pbe.pricebook2Id);
        		pbe.OF_DataAttivazione2__c = system.now();
        		pbe.OF_Asset__c = OF_CD_CRMHandler.assetId;
        		system.debug('@@@@@@@@@EC pbe.OF_Asset__c: ' + pbe.OF_Asset__c);
        		system.debug('@@@@@@@@@ECPG - - - pbe.OF_CommercialElementIstanziato__c: ' + pbe.OF_CommercialElementIstanziato__c);
				system.debug('@@@@@@@@@ECPG - - - pbe.OF_CommercialElementIstanziato__r.OF_CommercialElementName__c: ' + pbe.OF_CommercialElementIstanziato__r.OF_CommercialElementName__c);
        		//Pricebook2.PO_Commercial_element__c, Pricebook2.PO_Commercial_element__r.Name
        		//pbe.OF_CommercialElementIstanziato__c = OF_CD_CRMHandler.ceiMap.get(pbe.OF_CommercialElementIstanziato__r.OF_CommercialElementName__c).Id;
        		pbe.OF_CommercialElementIstanziato__c = OF_CD_CRMHandler.ceiMap.get(pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name).Id;
        		system.debug('@@@@@@@@@EC pbe.OF_CommercialElementIstanziato__c: ' + pbe.Pricebook2.OF_Listino__r.OF_ServizioBillingElement__r.OF_BillingElement__r.OF_CommercialElement__r.Name);
        	}
        	Insert pbeToInsert;
	    }
    }
    
    //Da verificare --> Start - PG - 17-12
    
    //INSERIMENTO ORDINE DI CESSAZIONE.
    //1.Cessazione di tutti i BE sotto l'asset legato all'ordine di Cessazione
    //2.Creazione BE di Cessazione
    //3.Agganciare il BE sotto al CE-->SERVIZIO OPEN STREAM BASE staccato in fase di Espletamento
    
    public static void inactivateBE(Case caseC, Order ordC)
    {
        Asset assetDaCessare;
        String IdServOpstrBase;

        System.debug('***inactivateBE***');
        
        assetDaCessare = [Select id, name, EOF_ID_Risorsa__c, status, OF_DataCessazione2__c, OF_Contract__c
                          from Asset
                          where id =: ordC.OF_Asset__c];
        
        List<PriceBookEntry> listPriceNonActive = new List<PriceBookEntry>();
    
        //Recupero tutti i pricebookEntry istanziati durante l'espletamento
        List<PriceBookEntry> listPriceBookEntry = [SELECT Id, IsActive, OF_DataDiCessazione__c, Pricebook2Id, OF_CommercialElementIstanziato__c,
                                                   OF_DataCessazione2__c, OF_Asset__c, OF_Asset__r.Recordtype.developername, Product2.name
                                                   FROM PriceBookEntry 
                                                   WHERE OF_Asset__c =: assetDaCessare.Id];
        
        System.debug('***listPriceBookEntry***: '+listPriceBookEntry);
              
        if( listPriceBookEntry != null && listPriceBookEntry.size() > 0 )
        {
            //Disattivo i PriceBookEntry Attivi e marco la data di Cessazione
            for(PriceBookEntry prE : listPriceBookEntry)
            {
                prE.isActive = false;
                //controllo se è si tratta di un Asset OpenStream CD

                if(OF_SA_CD_GE_Utils.slOLOSF != null){
                    prE.OF_DataCessazione2__c = OF_SA_CD_GE_Utils.slOLOSF.EOF_Data_Notifica__c;   
                }
                //}
                listPriceNonActive.add(prE);
                
                //Vado a recuperare l'id del cei SERVIZIO OPEN STREAM BASE
                if(prE.Product2.name.equalsIgnoreCase('Contributo Attivazione') ){
                    IdServOpstrBase = prE.OF_CommercialElementIstanziato__c;
                }
            }
        }
        if( listPriceNonActive != null && listPriceNonActive.size() > 0 ){
            update listPriceNonActive;
        }
        System.debug(']]]] Chiamo il metodo createContributoDisattivazione ]]]]');
        createContributoDisattivazione(ordC, assetDaCessare, IdServOpstrBase);
        //}
	}

    //ESPLETAMENTO ORDINE DI CESSAZIONE
    //All'espletamento di un Ordine di Cessazione si devono eseguire le seguenti operazioni:
    //1.Cessazione Asset
    //2.Cessazione CE
	
	public static void inactivateAssetCe(Case c1, Order o1)
	{
	    System.debug('***Chiamo il metodo che effettua la cessazione dell\'asset');
        cessazioneAsset(c1, o1);
	    
    	System.debug('***inactivateAssetCe***');
        
        List<OF_CommercialElementIstanziato__c> listCEINonActive = new List<OF_CommercialElementIstanziato__c>();
        
        //Recupero tutti i commercialElement stanziati durante l'espletamento
        List<OF_CommercialElementIstanziato__c> listCei = [SELECT Id, OF_Stato__c
                                                           FROM OF_CommercialElementIstanziato__c 
                                                           WHERE OF_Asset__c =: c1.AssetId];
                                                                                    
        system.debug('**** lista di CEI ' + listCei);
        
        if( listCei != null && listCei.size() > 0 )
        {
            for(OF_CommercialElementIstanziato__c cei : listCei)
            {
                cei.OF_Stato__c = 'Cessato';
                
                if( OF_SA_CD_GE_Utils.slSFOLO != null) {
                    cei.OF_DataCessazione__c = OF_SA_CD_GE_Utils.slSFOLO.EOF_Data_Notifica__c;
                } 
                listCEINonActive.add(cei);
            }
        }
        System.debug('***** list di CEI cessati ' + listCEINonActive);
        
        if( listCEINonActive != null && listCEINonActive.size() > 0 ){
            update listCEINonActive;
        }
	}
	
	
	//Add by PG - 04-01 - Metodo copiato dalla classe OF_CO_CRM_Handler (ChangeOrder)
	public static void manageAssetBillingElement(String assetId, Order o){
    	list<PriceBookEntry> pbeToUpsert = new list<PriceBookEntry>();
    	System.debug('***** assetId *****: '+assetId);
    	
        //Recupero il PricebookEntry relativo al canone attuale
        PriceBookEntry pbe = [SELECT Id, OF_Asset__c, OF_Contratto__c, isActive, OF_DataCessazione2__c, Product2Id, 
                              PriceBook2.OF_Listino__r.OF_IDContract__c  
                              FROM PriceBookEntry 
                              WHERE OF_Asset__c = :assetId
                              AND isActive = true 
                              AND Name = 'Canone' 
                              LIMIT 1];
        
        //Vado a disattivare il canone
        pbe.isActive = false;
        //Setto la data di cessazione
        pbe.OF_DataCessazione2__c = DateTime.now();
        //Aggiorno il pbe
        pbeToUpsert.add(pbe);
        
        //system.debug('***** vecchio canone ' + pbe);
        OF_CommercialElementIstanziato__c ceiBase = [select id 
                                                     from OF_CommercialElementIstanziato__c 
                                                     where OF_CEStandard__c=:assetId 
                                                     AND OF_CommercialElementName__c = 'SERVIZIO OPEN STREAM BASE' 
                                                     limit 1];
                                                    
        System.debug('****CEI BASE RECUPERATO ' + ceiBase);
        System.debug('§§§ ID Contratto §§§ : '+ pbe.PriceBook2.OF_Listino__r.OF_IDContract__c);
        System.debug('<<< o.OF_Profilo__c >>> : '+o.OF_Profilo__c);
        
        //Vado a creare il pricebook
        List<OF_Listino__c> listini = [SELECT Id, Name, OF_ServizioBillingElement__r.Name
                                       FROM OF_Listino__c 
                                       WHERE OF_IDContract__c = :pbe.PriceBook2.OF_Listino__r.OF_IDContract__c 
                                       AND OF_Attivo__c = true
                                       AND (Name = :o.OF_Profilo__c OR OF_ServizioBillingElement__r.Name = 'Contributo Cambio Profilo')];
        
        system.debug('@@@@ Listini Contributo Cambio Profilo: '+listini);
        OF_Listino__c listinoCanone; 
        OF_Listino__c listinoChangeOrder;
        
        for(OF_Listino__c listino : listini){
            if(listino.Name == o.OF_Profilo__c){
                listinoCanone = listino;
            }
            else if(listino.OF_ServizioBillingElement__r.Name == 'Contributo Cambio Profilo'){
                listinoChangeOrder = listino;
            }
        }
        system.debug('******* LISTINO NUOVO PROFILO ' + listinoCanone);
        system.debug('******* LISTINO CHANGE ORDER ' + listinoChangeOrder);
        List<recordtype> rtList = [select Id, developerName 
                                   from recordtype];
        
        OF_SA_CD_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_SA_CD_GE_Utils.rtMap.put(rt.developerName, rt.Id); 
        }
        OF_SA_CD_GE_Utils.checkrtMap=true;

        PriceBook2 pbNewCanone = new PriceBook2();
        pbNewCanone.IsActive = true;
        pbNewCanone.Name = o.OF_Profilo__c;
        pbNewCanone.OF_Listino__c = listinoCanone.Id;
        //TODO : pbNewCanone.PO_Commercial_element__c = ?????
        pbNewCanone.PO_Contratto__c = pbe.PriceBook2.OF_Listino__r.OF_IDContract__c;
        pbNewCanone.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('OF_Pricebook');
        insert pbNewCanone;
        
        system.debug('**** LISTINO PREZZO NUOVO CANONE ' + pbNewCanone);
        //Vado a creare il nuovo canone
        PriceBookEntry newPBECanone = new PriceBookEntry();
        newPBECanone.OF_Asset__c = assetId;
        newPBECanone.OF_Order__c = o.Id;
        //Done AA: Pricebook id??
        newPBECanone.OF_CommercialElementIstanziato__c = ceiBase.id;
        newPBECanone.Pricebook2Id = pbNewCanone.Id;
        newPBECanone.Product2Id = pbe.Product2Id;
        newPBECanone.OF_DataAttivazione2__c = DateTime.now();
        newPBECanone.isActive = true; 
        newPBECanone.UnitPrice = -9999;
        newPBECanone.OF_CO_Change_Order__c = true;
        //Inserisco il nuovo canone
        system.debug('***** INSERIMENTO PBE NUOVO CANONE ' + newPBECanone);
        pbeToUpsert.add(newPBECanone);
            
        //Recupero id del Product cambio profilo
        Id prodCPId = [SELECT Id 
                       FROM Product2 
                       WHERE Name = 'Contributo Cambio Profilo' 
                       AND OF_ListinoCustom__c = :listinoChangeOrder.id LIMIT 1].Id;
        
        system.debug('********* ID PRODOTTO CAMBIO PROFILO ' + prodCPId);
        
        PriceBook2 pbNewQuota = new PriceBook2();
        pbNewQuota.IsActive = true;
        pbNewQuota.Name = listinoChangeOrder.name;
        pbNewQuota.OF_Listino__c = listinoChangeOrder.Id;
        //TODO : pbNewCanone.PO_Commercial_element__c = ?????
        pbNewQuota.PO_Contratto__c = pbe.PriceBook2.OF_Listino__r.OF_IDContract__c;
        pbNewCanone.RecordTypeId = OF_SA_CD_GE_Utils.rtMap.get('OF_Pricebook');

        insert pbNewQuota;
        system.debug('***** PRICEBOOK QUOTA CAMBIO PROFILO!!! ' + pbNewQuota);
        
        PriceBookEntry newPBEProfilo = new PriceBookEntry();
        newPBEProfilo.OF_Asset__c = assetId;
        newPBEProfilo.OF_Order__c = o.Id;
        newPBEProfilo.Pricebook2Id = pbNewQuota.Id;
        newPBEProfilo.OF_CommercialElementIstanziato__c = ceiBase.id;
        newPBEProfilo.Product2Id = prodCPId;
        newPBEProfilo.OF_DataAttivazione2__c = DateTime.now();
        newPBEProfilo.isActive = true; 
        newPBEProfilo.UnitPrice = -9999;
        //Inserisco il nuovo canone
        pbeToUpsert.add(newPBEProfilo);
        
    	boolean inserito = false;
        boolean templog = false;
        Templog__c t = new Templog__c();
        
        for(integer x=0; x<50; x++){
            try{
            	upsert pbeToUpsert;
            	inserito=true;
            }
            catch(exception e){
            	if(!templog){
            		t=OF_Utility.logMessageNew2(assetId,'E','OF_CD_CRM_Handler','manageAssetBillingElement',(x+1), e);
            		templog=true;
            	}
            	else{
            		t.OF_tentativi__c=(x+1);
            	}
            }
            if(inserito==true){
            	break;
            }
        }
       	 if(templog){
        	insert t;
        }            
    } 
    //End by PG - 04-01 - Metodo copiato dalla classe OF_CO_CRM_Handler (ChangeOrder)
    
    //Add by PG - 04-01 - Metodo copiato dalla classe OF_CO_CRM_Handler (ChangeOrder)
    public static void manageAssetVlan(String assetId,list<OF_CommercialElementIstanziato__c> vlanListNew){
        
        list<OF_CommercialElementIstanziato__c> vlanListOld = [SELECT Id, OF_Stato__c 
                                                               FROM OF_CommercialElementIstanziato__c 
                                                               WHERE RecordType.DeveloperName = 'OF_VLAN'
                                                               AND (OF_Asset__c=:assetId OR OF_VLAN__c=:assetId)];
                                                               
        list<OF_CommercialElementIstanziato__c> vlanListToUpdate = new list<OF_CommercialElementIstanziato__c>();
        
        if(!vlanListOld.isEMpty()){
            for(OF_CommercialElementIstanziato__c vlan : vlanListOld){
            	if(vlan.OF_Stato__c == 'Attivo'){
	                vlan.OF_Stato__c = 'Cessato';
	                vlan.OF_DataCessazione__c=system.now();
	                vlanListToUpdate.add(vlan);
            	}
            }
        }
        if(vlanListNew!=null && !vlanListNew.isEMpty()){
            for(OF_CommercialElementIstanziato__c vlan : vlanListNew){
                vlan.OF_Asset__c=assetId;
                vlan.OF_VLAN__c=assetId;
                vlan.OF_Stato__c = 'Attivo';
                vlan.OF_DataAttivazione__c=system.now();
                vlanListToUpdate.add(vlan);
            }
        } 
        if(!vlanListToUpdate.isEmpty()){ 
            if(!test.isRunningTest())
                update vlanListToUpdate;
        }
    }
	//End by PG - 04-01 - Metodo copiato dalla classe OF_CO_CRM_Handler (ChangeOrder)

	public static string getPBNameFromProfile(String Profile){
	    System.debug('<<< Profilo Commerciale selezionato : >>>'+profile);
		String PricebookName;
		OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(Profile);
    	If(!String.isBlank(objListino.PO_CD_Profilo_Commerciale__c)){
    		PricebookName = objListino.PO_CD_Profilo_Commerciale__c.replace('OPENSTREAM','OPSTR_CD_001_CAN');
    		System.debug('<<<< Canone selezionato : >>>> '+PricebookName);
    		return PricebookName;
    	}
    	return null;
	}
}