public class OF_AttivazManualeCEController {
    
    //Riempimento ListBox
    public List<selectoption> listCE = new List<selectoption>();
    
    //Dati per il costruttore
    public Asset ass{public get;public set;}
    public OF_CommercialElementIstanziato__c CEToInsert {public get;public set;}
    public list<OF_CommercialElementIstanziato__c> CEPresenti = new list<OF_CommercialElementIstanziato__c>();
    public map<id, OF_CommercialElementIstanziato__c> CEPresentiMap = new map<id, OF_CommercialElementIstanziato__c>();
    public OF_CommercialElement__c ce1 {public get;public set;}
    
    //Valore selezionato nella listBox
    public String CEIst{public get;public set;}
    
    //Nomi dei recordtype dell'asset
    public static string servattivi = 'Open Stream';
    public static string servpassivi = 'GPON Passiva';
    public static string servintavuoto = 'Intervento a vuoto';
    public static string servverticale = 'Verticale';
    
    //Id dell'asset di partenza
    public id idAsset;
    
    //Booleano che serve per disabilitare il bottone del salvataggio se non ci sono BE da istanziare
    public boolean savecheck{get;set;}
    
    //Costruttore
   	public OF_AttivazManualeCEController(){
   		 idAsset = ApexPages.currentPage().getParameters().get('id');
   		 system.debug('DG_OF_AttivazManualeCEController - idAsset: ' + idAsset);
   		 
         savecheck = false;
        
   		 ass = [select id, name, OF_ServizioRichiesto__c, recordtype.name, EOF_ID_Risorsa__c, OF_IDCaseAttivazione__c from asset where id =: idAsset];
   		 system.debug('DG_OF_AttivazManualeCEController - ass: ' + ass);
   		 
   		 CEPresenti = [SELECT Id,Name, OF_CommercialElement__c, OF_Asset__c FROM OF_CommercialElementIstanziato__c WHERE OF_Asset__c =: idAsset];
   		 system.debug('DG_OF_AttivazManualeCEController - CEPresenti: ' + CEPresenti);
   		 
		 //Commercial Element che verrà istanziato
   		 CEToInsert = new OF_CommercialElementIstanziato__c();
   		 
   		 for(OF_CommercialElementIstanziato__c cex : CEPresenti){
   		 	CEPresentiMap.put(cex.OF_CommercialElement__c, cex);
   		 }
   	}
    
    //Popolamento della listbox
    public List<selectoption> getCE()
    {
        listCE.clear();
       	//Gestione servizi attivi e passivi
        if((ass.RecordType.name == servattivi) || (ass.RecordType.name == servpassivi)) {
        
	        List<OF_CommercialElement__c> agrRes = [select id, name from OF_CommercialElement__c where OF_Servizio__r.name =: ass.RecordType.name ORDER BY name desc];
	      	system.debug('DG_OF_AttivazManualeCEController - agrRes: ' + agrRes);
	        
	        listCE.add(new selectoption('--Seleziona Commercial Element--','--Seleziona Commercial Element--'));
	        
	        if( agrRes != null && agrRes.size()>0)
	        {
	            for( OF_CommercialElement__c a : agrRes )
	            {
	        		if(CEPresentiMap.get(a.id) == null){
	        			String x = (String)a.get('Name');
	        			//Inserito l'id perchè in fase di salvataggio viene preso questo ID e viene popolata la lookup al commercial element a catologo
				   		listCE.add(new selectoption(a.id,x));
	            	}
	            }
	            system.debug('DG_OF_AttivazManualeCEController - listCE: ' + listCE);
	            if(listCE.size() > 1){
	            	return listCE;
	            }else{
	            	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Commercial Element da istanziare!');
		        	ApexPages.addMessage(myMsg);
                    savecheck = true;
	            	return listCE;
	            }
	        }
        }//Gestione servizi extra
		else if((ass.RecordType.name == servintavuoto) || (ass.RecordType.name == servverticale)) {
            
            List<OF_CommercialElement__c> agrRes = [select id, name from OF_CommercialElement__c where name =: ass.RecordType.name ORDER BY name desc];
	      	system.debug('DG_OF_AttivazManualeCEController - agrRes: ' + agrRes);
	                  
            if( agrRes != null && agrRes.size()>0)
            {
                for( OF_CommercialElement__c a : agrRes )
	            {
	        		if(CEPresentiMap.get(a.id) == null){
	        			String x = (String)a.get('Name');
	        			//Inserito l'id perchè in fase di salvataggio viene preso questo ID e viene popolata la lookup al commercial element a catologo
				   		listCE.add(new selectoption(a.id,x));
	            	}
	            }
                system.debug('DG_OF_AttivazManualeCEController - listCE: ' + listCE);
	            if(listCE.size() > 0){
	            	return listCE;
	            }else{
	            	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Commercial Element da istanziare!');
		        	ApexPages.addMessage(myMsg);
                    savecheck = true;
	            	return listCE;
	            }
            }
    	}
        system.debug('DG_OF_AttivazManualeCEController - listCE: ' + listCE);
      	return listCE;
    } 
      
    public boolean getrenderizzVLAN(){
    	system.debug('DG_OF_AttivazManualeCEController - renderizzVLAN --- CEIst: ' + CEIst);
    	
    	if(CEIst != null && CEIst != '--Seleziona Commercial Element--'){
	    	OF_CommercialElement__c CommElemSelez = new OF_CommercialElement__c();
			CommElemSelez = [select id, name from OF_CommercialElement__c where id =: CEIst];
	    	
			if(CommElemSelez.name == 'VLAN'){
				return true;
			}
			else
				return false;
    	}
    	return false;
    }
    
    public boolean getrenderizzCPE(){
    	system.debug('DG_OF_AttivazManualeCEController - renderizzCPE --- CEIst: ' + CEIst);
    	if(CEIst != null && CEIst != '--Seleziona Commercial Element--'){
	    	OF_CommercialElement__c CommElemSelez = new OF_CommercialElement__c();
			CommElemSelez = [select id, name from OF_CommercialElement__c where id =: CEIst];
			
			if(CommElemSelez.name == 'CPE'){
				return true;
			}
			else
				return false;
    	}
    	return false;
    }
    
	//Popolamento dei record type del Commercial Element Istanziato
    public static id RecordTypeCE(string name){
    	
    	String CPERecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
    	String VLANRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
    	String ServiziAggiuntiviRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
    	String StandardRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Standard').getRecordTypeId();
    	
    	system.debug('DG_OF_AttivazManualeCEController name: ' + name);
    	
    	if(name == 'CPE'){return CPERecordTypeId;
    	}else if(name == 'VLAN'){return VLANRecordTypeId;
    	}else if((name == 'Servizi Aggiuntivi') || (name == 'RIBALTAMENTO IMPIANTO') || (name == 'ESTENSIONE IMPIANTO CLIENTE') || (name == 'SLA PREMIUM ASSURANCE')){return ServiziAggiuntiviRecordTypeId;
    	}else{
    		return StandardRecordTypeId;
    	}
    }
    
    //Salvataggio dei dati nel database
    public PageReference save() {
    	
		if(CEIst != '--Seleziona Commercial Element--' && CEIst != null){
			
			CEToInsert.OF_CommercialElement__c = CEIst;
			CEToInsert.OF_Asset__c = idAsset;
			CEToInsert.OF_Case__c = ass.OF_IDCaseAttivazione__c;
			
	    	ce1 = [Select name from OF_CommercialElement__c where id =: CEIst];
			CEToInsert.recordtypeId = RecordTypeCE(ce1.name);
			
	    	insert CEToInsert;
	 		PageReference pg = new PageReference('/' + idAsset);
	        pg.setRedirect(true);
	        return pg;
		}else if(CEIst == '--Seleziona Commercial Element--'){       	
           	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Commercial Element: You must enter a value');
        	ApexPages.addMessage(myMsg);
           	return null;
        }else
        	return null;
	}

    public PageReference toReturn() {
    	system.debug('DG_OF_AttivazManualeCEController - toReturn');
    	PageReference pg = new PageReference('/'+idAsset);
      	pg.setRedirect(true);
        return pg;
	}
}