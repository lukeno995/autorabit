public class PO_COMP_CeD_InserimentoVLAN_Controller {
    
    public EOF_EAI_Service_Log__c slVlan{get;set;}  
    public EOF_EAI_Service_Log__c slOrig{get;set;}
    public Map<String,Id> rtMap{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public String idVlan{get;set;}
    public List<SelectOption> listaKIT{get;set;} 
    public List<SelectOption> listaSVLAN{get;set;}
    public OF_CommercialElementIstanziato__c VLANValues{get;set;}
    public Map<String,OF_CommercialElementIstanziato__c> VLANMap;
    public string serviceVLan{get;set;}
    
    public List<SelectOption> getProfiloVLAN(){
        
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult = EOF_EAI_Service_Log__c.OF_SA_PROFILO_VLAN_PL__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       
       for(Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
       }     
       return options;
    } 
    
    public PO_COMP_CeD_InserimentoVLAN_Controller(){
        
        modifyMode=false;
        insertMode=false;
        if(ApexPages.currentPage().getParameters().get('origId')==null){
        	return;
        }
        slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
				EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
				EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
				EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
				EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
				EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c
				from EOF_EAI_Service_Log__c 
				where ID=:ApexPages.currentPage().getParameters().get('origId')];
				
        if(ApexPages.currentPage().getParameters().get('idVlan')!=null)
        {
        	idVlan=ApexPages.currentPage().getParameters().get('idVlan');
        	
            slVlan=[select Id, OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,OF_SA_CUSTOMER_VLAN__c,
                    OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c
                    from EOF_EAI_Service_Log__c 
                    where id=:idVlan];
                    
            modifyPicklist();
            modifyMode=true;
            if(String.isNotBlank(slVlan.OF_SA_SERVICE_VLAN__c)){
            	listaSVLAN=new List<SelectOption>();
            	listaSVLAN.add(new SelectOption(slVlan.OF_SA_SERVICE_VLAN__c,slVlan.OF_SA_SERVICE_VLAN__c));
            }
        }
        else
        {
            insertMode=true;
            slVlan= new EOF_EAI_Service_Log__c();
            slVlan.OF_SA_VLan_Log__c=slOrig.Id;
            List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
            rtMap = new Map<String,Id>(); 
            
            for(recordtype rt :rtList){
                rtMap.put(rt.developerName, rt.Id); 
            }  
            
            slVlan.recordtypeId=rtMap.get('OF_SA_Vlan');
            slVlan.EOF_Stato_Richiesta__c = 'Bozza Portale';
            slVlan.EOF_Codice_Ordine_OLO__c = ApexPages.currentPage().getParameters().get('codOrdOlo');
        }
        
        /*Add by PG - 10-12 - Sezione commentata 
        
        Set<Id> AssetList = new Set<Id>();
        for(OF_CommercialElementIstanziato__c assetId:[select OF_Asset__c 
                                                        from OF_CommercialElementIstanziato__c 
                                						where RecordType.DeveloperName='SVLAN'
                                						and OF_Asset__r.RecordType.DeveloperName ='PreProvisioning' 
                                						and PO_PP_POP_SVLAN__c=:slOrig.EOF_ID_Pop__c
                                						AND OF_Asset__r.Account.EOF_Codice_Operatore__c=:slOrig.EOF_Codice_Operatore__c]){
        	AssetList.add(assetId.OF_Asset__c);						
		}
        
		Set<String> tuttiIKIT = new Set<String>();
		for(OF_CommercialElementIstanziato__c CEI : [select PO_PP_Nome_KIT__c 
		                                            from OF_CommercialElementIstanziato__c 
        										    where RecordType.DeveloperName='KIT' 
        										    and OF_Asset__c in:AssetList]){
        	tuttiIKIT.add(CEI.PO_PP_Nome_KIT__c);											
		}
		if(!tuttiIKIT.isEmpty()){
			ListaKIT = new List<SelectOption>();
			ListaKIT.add(new SelectOption('',''));
			for(String KIT : tuttiIKIT){
				ListaKIT.add(new SelectOption(KIT,KIT));
			}
		}
		*/
    }
    
    //Add by PG - 10-12 - Metodi commentati da utilizzare in futuro
    /*
    public PageReference showSVLAN()
    {
    	//system.debug('@@@@ slVlan.OF_SA_KIT_CONSEGNA_VLAN__c: '+slVlan.OF_SA_KIT_CONSEGNA_VLAN__c);
    	Set<String> TutteLeSVLAN = new Set<String>();
    	VLANMap= new Map<String,OF_CommercialElementIstanziato__c>();
    	for(OF_CommercialElementIstanziato__c vlan:[select OF_ServiceVLAN__c,OF_UserVLAN__c,OF_ProfiloVLAN__c 
    	                                            from OF_CommercialElementIstanziato__c 
                    								where RecordType.DeveloperName='SVLAN' 
                    								and OF_Asset__r.RecordType.DeveloperName ='PreProvisioning' 
                    								and OF_Asset__r.Account.EOF_Codice_Operatore__c=:slOrig.EOF_Codice_Operatore__c
                    								and PO_PP_POP_SVLAN__c=:slOrig.EOF_ID_Pop__c]){
			
			if(string.isNotBlank(vlan.OF_ServiceVLAN__c)){
				TutteLeSVLAN.add(vlan.OF_ServiceVLAN__c);	
				VLANMap.put(vlan.OF_ServiceVLAN__c,vlan);
			}
		}
		listaSVLAN = new List<SelectOption>();
		listaSVLAN.add(new SelectOption('',''));
		
		if(!TutteLeSVLAN.isEMpty()){
			for(String VLAN:TutteLeSVLAN){
				listaSVLAN.add(new SelectOption(VLAN,VLAN));
			}
			system.debug('@@@@ listaSVLAN: '+listaSVLAN);
		}
		slVlan.OF_SA_SERVICE_VLAN__c=null;
		slVlan.OF_SA_USER_VLAN__c=null;
		slVlan.OF_SA_PROFILO_VLAN__c=null;
    	return null;
    }
    
    public PageReference fillFields()
    {
    	if(VLANMap!=null && String.isNotBlank(slVlan.OF_SA_SERVICE_VLAN__c))
    	{
    		VLANValues=VLANMap.get(slVlan.OF_SA_SERVICE_VLAN__c);
    		system.debug('@@@@ VLANValues: '+VLANValues);
    		system.debug('@@@@ VLANMap: '+VLANMap);
    		system.debug('@@@@ slVlan.OF_SA_SERVICE_VLAN__c: '+slVlan.OF_SA_SERVICE_VLAN__c);
    		slVlan.OF_SA_USER_VLAN__c=VLANValues.OF_UserVLAN__c;
    		slVlan.OF_SA_PROFILO_VLAN__c=VLANValues.OF_ProfiloVLAN__c;
    	}
    	else
    	{
    		slVlan.OF_SA_USER_VLAN__c=null;
    		slVlan.OF_SA_PROFILO_VLAN__c=null;
    	}
    	return null;
    }
    */
    
    public PageReference annullaVLAN()
    {
        PageReference pageRef = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
        if(ApexPages.currentPage().getParameters().get('orig') =='ATT'){
            pageRef.getParameters().put('proc','attivazioneInserita');
            pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
        }
        if(ApexPages.currentPage().getParameters().get('orig') =='CESS'){
            pageRef.getParameters().put('proc','cessazioneInserita');
            pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
        }
        pageRef.setRedirect(true);
        return pageref;
    }
    
    //GB - 06.02.2018 Start
    public void mappingPicklist()
    {
        System.debug('****slVlan.OF_SA_PROFILO_VLAN__c***:'+slVlan.OF_SA_PROFILO_VLAN__c);
        
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 0')
            slVlan.OF_SA_PROFILO_VLAN__c='0';
            
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 1')
            slVlan.OF_SA_PROFILO_VLAN__c='1';
            
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 5')
            slVlan.OF_SA_PROFILO_VLAN__c='5';
    }
    
    public void modifyPicklist()
    {
        if(slVlan.OF_SA_PROFILO_VLAN__c=='0')
            slVlan.OF_SA_PROFILO_VLAN__c='COS 0';
            
        if(slVlan.OF_SA_PROFILO_VLAN__c=='1')
            slVlan.OF_SA_PROFILO_VLAN__c='COS 1';
            
        if(slVlan.OF_SA_PROFILO_VLAN__c=='5')
            slVlan.OF_SA_PROFILO_VLAN__c='COS 5';
    }
    
    //GB - 06.02.2018 Start
    public PageReference InserisciVLAN()
    {
        mappingPicklist();
        insert slVlan;
        
        PageReference pageRef = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
        
        if(ApexPages.currentPage().getParameters().get('orig') =='ATT')
        {
            pageRef.getParameters().put('proc','attivazioneInserita');
            pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
        }
        if(ApexPages.currentPage().getParameters().get('orig') =='CESS')
        {
            pageRef.getParameters().put('proc','cessazioneInserita');
            pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
        }
        pageRef.setRedirect(true);
        return pageref; 
    }
    
    public PageReference updateVLAN()
    {
        mappingPicklist();
        update slVlan;
        
        PageReference pageRef = new PageReference('/PO_OpenStreamCeD_InsertNewReq');
        
        if(ApexPages.currentPage().getParameters().get('orig') =='ATT')
        {
            pageRef.getParameters().put('proc','attivazioneInserita');
            pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
        }
        if(ApexPages.currentPage().getParameters().get('orig') =='CESS')
        {
            pageRef.getParameters().put('proc','cessazioneInserita');
            pageRef.getParameters().put('origId',ApexPages.currentPage().getParameters().get('origId'));
        }
        pageRef.setRedirect(true);
        return pageref;
    }
}