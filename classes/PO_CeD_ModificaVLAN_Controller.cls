public with sharing class PO_CeD_ModificaVLAN_Controller {
	
	public boolean modifyMode {get;set;}
    public boolean insertMode {get;set;}
	public static String idVlan {get;set;}
	public static String mode {get;set;}
	public EOF_EAI_Service_Log__c slVlan {get;set;}
	public Map<String,Id> rtMap {get;set;}
	
	
	public PO_CeD_ModificaVLAN_Controller() {		
		modifyMode=false;
                insertMode=false;
		idVlan=ApexPages.currentPage().getParameters().get('IdVLAN');
		mode=ApexPages.currentPage().getParameters().get('Mode');
        

		if(mode =='mod'){
            slVlan=[select Id, OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c
                    from EOF_EAI_Service_Log__c where id=:idVlan];
            modifyPicklist();
            modifyMode=true;
        }
		else{
            insertMode=true;
            slVlan= new EOF_EAI_Service_Log__c();
            //slVlan.OF_SA_VLan_Log__c=slOrig.Id; DAPRENDERE DA QUERY STRING
            List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
            rtMap = new Map<String,Id>(); 
            for(recordtype rt :rtList){
                rtMap.put(rt.developerName, rt.Id); 
            }  
            
            slVlan.recordtypeId=rtMap.get('OF_SA_Vlan');
            slVlan.EOF_Stato_Richiesta__c='Bozza Portale';
            slVlan.OF_SA_VLan_Log__c=ApexPages.currentPage().getParameters().get('idRisorsa');
        }
	}

    public List<SelectOption> getProfiloVLAN()  {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult = EOF_EAI_Service_Log__c.OF_SA_PROFILO_VLAN_PL__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       options.add(new SelectOption('',''));
       for( Schema.PicklistEntry f : ple)
       {
               options.add(new SelectOption(f.getLabel(), f.getValue()));
       }     
       return options;
    } 

    public void modifyPicklist(){
        if(slVlan.OF_SA_PROFILO_VLAN__c=='0'){
            slVlan.OF_SA_PROFILO_VLAN__c='COS 0';
            slVlan.OF_SA_USER_VLAN__c='835';
        }
        else if(slVlan.OF_SA_PROFILO_VLAN__c=='1'){
            slVlan.OF_SA_PROFILO_VLAN__c='COS 1';
            slVlan.OF_SA_USER_VLAN__c='935';
        }
        else if(slVlan.OF_SA_PROFILO_VLAN__c=='5'){
        	slVlan.OF_SA_PROFILO_VLAN__c='COS 5';
            slVlan.OF_SA_USER_VLAN__c='837';
        }
        else{
        	slVlan.OF_SA_PROFILO_VLAN__c='';
            slVlan.OF_SA_USER_VLAN__c='';
        }        
    }
	//@testvisible added by sasya to cover the method in test class	
	@testvisible private void mappingPicklist(){
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 0'){
                slVlan.OF_SA_PROFILO_VLAN__c='0';
                slVlan.OF_SA_USER_VLAN__c='835';
        }
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 1'){
                slVlan.OF_SA_PROFILO_VLAN__c='1';
                slVlan.OF_SA_USER_VLAN__c='935';
        }
        if(slVlan.OF_SA_PROFILO_VLAN__c=='COS 5'){
                slVlan.OF_SA_PROFILO_VLAN__c='5';
                slVlan.OF_SA_USER_VLAN__c='837';
        }
    }

	public PageReference annullaVLAN(){
        
		PageReference pageRef = new PageReference('/PO_CeD_DettaglioBozze');
        pageRef.getParameters().put('IdRisorsa',ApexPages.currentPage().getParameters().get('idRisorsa'));
		return pageRef;
	}

	public PageReference InserisciVLAN(){
       
        mappingPicklist();
        insert slVlan;
        system.debug('***** vlan Inserimento'+slVlan);
        PageReference pageRef = new PageReference('/PO_CeD_DettaglioBozze');
        pageRef.getParameters().put('IdRisorsa',ApexPages.currentPage().getParameters().get('idRisorsa'));
		return pageRef;    
        
    }

	public PageReference updateVLAN(){
        mappingPicklist();
        update slVlan;
        PageReference pageRef = new PageReference('/PO_CeD_DettaglioBozze');
        pageRef.getParameters().put('IdRisorsa',ApexPages.currentPage().getParameters().get('idRisorsa'));
		return pageRef; 
    }
}