public with sharing class PO_PP_SVLan_Controller {

    public String recordOfferta {get;set;}
    public boolean secB{get;set;}
    public boolean secC{get;set;}
    public boolean secD{get;set;}
    public boolean showServizia {get;set;}
    public boolean showServizia2 {get;set;}
    public boolean showServizia3 {get;set;}//AS
    public boolean showServizia4 {get;set;}//AM
    public boolean showIncidentManagement {get;set;} //Add by PG - 09-05
    public boolean show1 {get;set;}
    public boolean show2 {get;set;}
    public boolean show3 {get;set;}
    public boolean show4 {get;set;}
    public boolean show5 {get;set;}
    public boolean show6 {get;set;}
    public boolean show7 {get;set;} //rerender per sezione kit
    
    //PP --------------------------PREPROV
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public EOF_EAI_Service_Log__c sl{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public Map<String,Id> rtMap;
    public boolean viewError{get;set;}
    public string nomeAzienda {get;set;}
    //PP fine--------------------------PREPROV

    public List<User> contactUserList {get;set;}
    //PREPROV 09-07 - KIT
    public String POP{get;set;}
    public String BandaInterfaccia {get;set;}
    //PREPROV 09-07 - VLAN
    public String svlan{get;set;}
    public String cos_type{get;set;}
    public String cos_class{get;set;}
    public String cos_remarking{get;set;}
    public String dhcp_Option82{get;set;}
    public String nomeKit {get;set;}
    public String note {get;set;}
    public String id_kit_log {get;set;}
    public EOF_EAI_Service_Log__c sl_kit{get;set;}
    public EOF_EAI_Service_Log__c sl_richiestaVLAN{get;set;}
    public String isRichiesta {get;set;}
    public String id_log_richiesta {get;set;}
    public String id_richiestaVLAN {get;set;}
    public OF_CommercialElementIstanziato__c kit_selected {get;set;}
    public String sceltaMono {get;set;}
    public String sceltaMulti {get;set;}
    public EOF_EAI_Service_Log__c log_kit{get;set;}
    
    //costruttore    
    public PO_PP_SVLan_Controller(){
     	
        modifyMode=false;
     	insertMode=false;
     	viewError=false;
     	isRichiesta = '';
        sceltaMono = '';
        sceltaMulti = '';
     	
     	nomeKit = ApexPages.currentPage().getParameters().get('nameKit');
     	isRichiesta = ApexPages.currentPage().getParameters().get('richVLan');
     	
     	System.debug(']]]]NomeKIT]]]]: '+nomeKit);
        
     	//Query sul service Log del KIT (agganciato al Case)
     	 List<EOF_EAI_Service_Log__c> listaLogKit= [Select id
                     from EOF_EAI_Service_Log__c
                     where Nome_del_KIT__c=:nomeKit
                     and recordtype.DeveloperName = 'OF_PP_KIT_ActivationRequest'
     	             limit 1];
     	if(!listaLogKit.isEmpty()){
     		id_kit_log=listaLogKit[0].Id;
     	}
     	
      	//Query sull'object OF_CommercialElementIstanziato__c
     	kit_selected = [Select id, name, PO_PP_Nome_KIT__c, RecordType.name, of_asset__c, of_asset__r.name, OF_Case__c, OF_Case__r.CaseNumber
                        from OF_CommercialElementIstanziato__c
                        where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                        and PO_PP_Nome_KIT__c =:nomeKit
                        limit 1];
     	
     	if(slOrig!=null)
     	{
     		sl=slOrig;
     		modifyMode=true;
     	}
     	else
     	{
     		insertMode=true;
     		User attuale=[select Id,Account.EOF_Codice_Operatore__c, Account.name 
     		              from user 
     		              where Id=:userinfo.getUserId()];
     		              
            nomeAzienda = attuale.Account.name;
            sl_richiestaVLAN = new EOF_EAI_Service_Log__c();
	     	sl = new EOF_EAI_Service_Log__c();
	    	List<recordtype> rtList=[select Id,developerName from recordtype];                                                                               
	        rtMap = new Map<String,Id>();
	        
	        for(recordtype rt :rtList){
	            rtMap.put(rt.developerName, rt.Id); 
	        }
	    	sl.recordtypeId=rtMap.get('PO_PP_VLAN');
	    	sl.EOF_Stato_Richiesta__c='Bozza Portale';
	    	sl.EOF_CODICE_OPERATORE__c=attuale.Account.EOF_Codice_Operatore__c;
	    	sl.EOF_Tipo_Comunicazione_String__c='VLAN';
	    	
	    	//Se il parametro è SI -->nessuna richiesta VLAN presente
	    	// Creo il log richiesta VLAN
	    	if(isRichiesta.equals('SI'))
	    	{
                //Log Richiesta VLAN
                sl_richiestaVLAN.recordtypeId=rtMap.get('OF_RichiestaVLAN_LOG');
                sl_richiestaVLAN.EOF_Stato_Richiesta__c = 'Bozza Portale';
                sl_richiestaVLAN.EOF_CODICE_OPERATORE__c = attuale.Account.EOF_Codice_Operatore__c;
                sl_richiestaVLAN.EOF_Tipo_Comunicazione_String__c = 'Richiesta VLAN';
                //aggancio l'id del kit al log della Richiesta VLAN
                if(!String.IsBlank(id_kit_log)){
                sl_richiestaVLAN.OF_PP_KIT_Log__c = id_kit_log;
                }
	    	}
     	}
    }

    public List<SelectOption> getItemsMonoCos() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0','0'));
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('5','5'));
        return options;
    }
    
    public List<SelectOption> getItemsMultiCos() 
    {
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('0 - 1','0 - 1'));
        options.add(new SelectOption('0 - 5','0 - 5'));
        //options.add(new SelectOption('1 - 5','1 - 5'));
        options.add(new SelectOption('0 - 1 - 5','0 - 1 - 5'));
        return options;
    }

    public pageReference savesl()
    {
        try
        {  
            //Se non è presente una richiesta di VLAN la inserisco
            if(isRichiesta.equals('SI'))
            {
                insert sl_richiestaVLAN;
                id_richiestaVLAN = sl_richiestaVLAN.id;
                System.debug('****SI___Ho inserito il log Richiesta VLAN****');
            }
            //Se la richiesta è presente mi prendo l'id passato come parametro
            else if(isRichiesta.equals('NO'))
            {
                id_log_richiesta = ApexPages.currentPage().getParameters().get('id_richVLAN');
     	        System.debug('****id_log_richiesta:****'+id_log_richiesta);
     	        id_richiestaVLAN = id_log_richiesta;
            }
            //Popolo il log della VLAN
            sl.PO_PP_POP_raccolta__c = POP;
            sl.SVLAN__c = svlan;
            sl.PO_PP_cos_type__c = cos_type;
            
            /* List<EOF_EAI_Service_Log__c> listaLogKit2= [Select id, Nome_del_KIT__c, POP__c, Traffico__c, 
             												Banda_Interfaccia__c, PO_PP_Interfaccia__c, Caso__c
                        									from EOF_EAI_Service_Log__c
                        									where Nome_del_KIT__c=:nomeKit
                        									and recordtype.DeveloperName = 'OF_PP_KIT_ActivationRequest'
                       										 limit 1];
                       										 */
              
             List<OF_CommercialElementIstanziato__c> listaCeiKit= [Select id, name, PO_PP_Nome_KIT__c, RecordType.name, 
             															  of_asset__c, of_asset__r.name, OF_Case__c, OF_Case__r.CaseNumber,
             															  PO_PP_Pop__c/*POP DI CONSEGNA*/,PO_PP_POP_SVLAN__c/*POP DI RACCOLTA*/,
             															  PO_PP_Servizio_Commerciale__c/*TRAFFICO*/,PO_PP_Banda_Interfaccia__c,PO_PP_InterfacciaKit__c
                        												  from OF_CommercialElementIstanziato__c
                        												  where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                        												  and PO_PP_Nome_KIT__c =:nomeKit
                        												  limit 1];
                        												  
             kit_selected = listaCeiKit[0];           												             
            /*            
     		if(!listaLogKit2.isEmpty()){
     			
     			 log_kit = listaLogKit[0];
     			 sl.Nome_del_KIT__c = log_kit.Nome_del_KIT__c;
           		 sl.POP__c = log_kit.POP__c;
            	 sl.Traffico__c = log_kit.Traffico__c;
           		 sl.Banda_Interfaccia__c = log_kit.Banda_Interfaccia__c;
          		 sl.PO_PP_Interfaccia__c = log_kit.PO_PP_Interfaccia__c;
     		}	
            else{
          */ 	
           /* kit_selected = [Select id, name, PO_PP_Nome_KIT__c, RecordType.name, 
           					of_asset__c, of_asset__r.name, OF_Case__c, OF_Case__r.CaseNumber
                        from OF_CommercialElementIstanziato__c
                        where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                        and PO_PP_Nome_KIT__c =:nomeKit
                        limit 1];*/
            
            //Info del KIT
            sl.Nome_del_KIT__c = kit_selected.PO_PP_Nome_KIT__c;
            sl.POP__c = kit_selected.PO_PP_Pop__c;
            sl.Traffico__c = kit_selected.PO_PP_Servizio_Commerciale__c;
            sl.Banda_Interfaccia__c = kit_selected.PO_PP_Banda_Interfaccia__c;
            sl.PO_PP_Interfaccia__c = kit_selected.PO_PP_InterfacciaKit__c;
            //}
            
            if(cos_type.equalsIgnoreCase('MonoCOS'))
            {
                sl.PO_PP_cos_class__c = sceltaMono;
            }
            else if(cos_type.equalsIgnoreCase('MultiCOS'))
            {
                //sl.PO_PP_cos_class__c = sceltaMulti;
                sl.PO_PP_MultiCos_Class__c = sceltaMulti;
            }
            //sl.PO_PP_cos_class__c = cos_class;
            System.debug('***sl.PO_PP_cos_type__c***:'+sl.PO_PP_cos_type__c);
            System.debug('***sl.PO_PP_cos_class__c***:'+sl.PO_PP_cos_class__c);
            System.debug('***sl.PO_PP_MultiCos_Class__c***:'+sl.PO_PP_MultiCos_Class__c);
            
            //Creo il log del COS
            /*
            sl_cos = new EOF_EAI_Service_Log__c();
            sl_cos.recordtypeId = rtMap.get('PO_PP_COS');
            
            if(cos_type.equalsIgnoreCase('MonoCOS'))
            {
                sl.PO_PP_cos_class__c = sceltaMono;
            }
            else if(cos_type.equalsIgnoreCase('MultiCOS'))
            {
                sl.PO_PP_cos_class__c = sceltaMulti;
                
                sl.PO_PP_cos_class__c = sl.PO_PP_cos_class__c.replaceAll( '\\s+', '');
                System.debug('*********' + sl.PO_PP_cos_class__c);
                //Inserisco i COS inseriti da portale in una lista di stringhe
                arr_cos = sl.PO_PP_cos_class__c.split('\\-');
                System.debug('***Array COS***:'+arr_cos);
                
            }
            */
           
            sl.PO_PP_cos_remarking__c = cos_remarking;
            sl.PO_PP_dhcp_Option82__c = dhcp_Option82;
            
            sl.EOF_NOTE__c = note;
            sl.PO_PP_ID_RichiestaVLAN__c = id_richiestaVLAN;
            insert sl; 
            System.debug('****Ho inserito il log della VLAN****: '+sl);
            
            //creo il legame tra il log del COS e della VLAN
            /*
            if(sl.PO_PP_cos_type__c=='MonoCOS')
            {
                sl_cos.PO_PP_ID_VLAN__c = sl.id;
                sl_cos.PO_PP_cos_type__c = 'MonoCOS';
                sl_cos.PO_PP_cos_class__c = sceltaMono;
                insert sl_cos;
            }
            else if(sl.PO_PP_cos_type__c=='MultiCOS')
            {
                System.debug('****Sono nel ciclo IF MultiCOS****arr_size: '+arr_cos.size());
                list_sl_Mcos = new List<EOF_EAI_Service_Log__c>();
                for(Integer i=0; i<arr_cos.size(); i++)
                {
                    System.debug('***Sono nel ciclo FOR MultiCOS***');
                    sl_Mcos = new EOF_EAI_Service_Log__c();
                    sl_Mcos.recordtypeId = rtMap.get('PO_PP_COS');
                    sl_Mcos.PO_PP_ID_VLAN__c = sl.id;
                    sl_Mcos.PO_PP_cos_class__c = arr_cos[i];
                    sl_Mcos.PO_PP_cos_type__c = 'MultiCOS';
                    list_sl_Mcos.add(sl_Mcos);
                }
                insert list_sl_Mcos;
            }
            //System.debug('****Ho inserito il log del COS****');
            */
		}
		catch(DMLexception e){
			ApexPages.addMessages(e); 
			return null;
		}
		PageReference pg = new PageReference('/PO_PP_RiepilogoSVLAN');
		//pg.getParameters().put('proc','attivazioneInserita');
		//if(!String.isBlank(sl.Id)){
        pg.getParameters().put('origId',sl.Id); //sl.Id qui dovrebbe essere il log della vlan appena inserita.
	//	}
        //pg.getParameters().put('id_kit',id_kit);
        pg.getParameters().put('nameKit',nomeKit);
        pg.getParameters().put('id_richVLAN',id_richiestaVLAN);

        return pg;        
    }
    
    public pageReference annulla()
    {
        PageReference pg = new PageReference('/PO_PP_InserimentoKit');
        return pg;        
    }
}