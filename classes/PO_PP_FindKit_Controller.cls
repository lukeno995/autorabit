public class PO_PP_FindKit_Controller {

	public String nameKit{get;set;}
	public String selectednameKit{get;set;}
	public boolean idNonValido{get;set;}
	public boolean noKit{get;set;}
	public String codOp{get;set;}
	public List<EOF_EAI_Service_Log__c> log_richieste {get;set;}
	public String id_log_richiestaVLAN{get;set;}
	public boolean hideElements {get;set;}
	public boolean showMsgError {get;set;}
	
	public SelectOption[] elencoKit {
	    public get;
	    private set;
    }

	public PO_PP_FindKit_Controller() 
	{
	    noKit = false;
	    showMsgError = false;
	    hideElements = true;
	    
	    codOp = [SELECT Contact.account.name 
		        FROM User 
		        WHERE id = :userinfo.getuserid() 
		        LIMIT 1].Contact.account.name;
		
		elencoKit = new SelectOption[]{};
		elencoKit.add(new SelectOption('blank','------SELECT VALUE------'));
		
		//System.debug('nameKit: '+nameKit);
		System.debug('***CodOP****:'+codOp);
		
		log_richieste = new list<EOF_EAI_Service_Log__c>();
		
		If(test.isRunningTest())
		{
		    List<Asset> assetList = [Select id, account.name, status
		                            from Asset
		                            ];
		                            
		    System.debug('****assetList****:'+assetList.size());
		}
        
        //Query su object OF_CommercialElementIstanziato__c
        List<OF_CommercialElementIstanziato__c> lista_kit = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Servizio_Commerciale__c, RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c
                                                            from OF_CommercialElementIstanziato__c
                                                            where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                                                            and OF_Asset__r.account.name =:codOp
                                                            and OF_Asset__r.status='Attivo'
                                                            ];
        System.debug('***lista_kit***: '+lista_kit.size());
        
        if(lista_kit.size()>0)
        {
            for(OF_CommercialElementIstanziato__c k : lista_kit){
                elencoKit.add(new SelectOption(k.PO_PP_Nome_KIT__c,k.PO_PP_Nome_KIT__c));
            }
        }
        else{
            noKit = true;
            hideElements = false;
        }
        System.debug('***elencoOptKit****:'+elencoKit);
	}
	
    public void passSelectValueToController()
	{
        selectednameKit = nameKit;
	    System.debug('selectednameKit'+selectednameKit);
	}

	public PageReference runSearchKit() 
	{
	    /*
        codOp = [SELECT Contact.account.name 
		        FROM User 
		        WHERE id = :userinfo.getuserid() 
		        LIMIT 1].Contact.account.name;
        */
        
		System.debug('selectednameKit: '+selectednameKit);
		System.debug('***CodOP****:'+codOp);
		
		log_richieste = new list<EOF_EAI_Service_Log__c>();

        //Query su object OF_CommercialElementIstanziato__c
        OF_CommercialElementIstanziato__c kit_selezionato = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Servizio_Commerciale__c, RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c
                                                             from OF_CommercialElementIstanziato__c
                                                             where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                                                             and OF_Asset__r.account.name =:codOp
                                                             and OF_Asset__r.status='Attivo'
                                                             and PO_PP_Nome_KIT__c=:selectednameKit
                                                             limit 1];
        if(kit_selezionato!=null)
        {
            System.debug('***KIT SELEZIONATO***: '+kit_selezionato.PO_PP_Nome_KIT__c);

         	log_richieste = [Select id,OF_PP_KIT_Log__c
                            from EOF_EAI_Service_Log__c
                            where OF_PP_KIT_Log__r.Nome_del_KIT__c =:selectednameKit
                            and recordtype.developerName = 'OF_RichiestaVLAN_LOG'
                            and EOF_stato_richiesta__c ='Bozza Portale'
                            limit 1];
            
            System.debug('***log_richieste***:'+log_richieste.size());
    
    		Pagereference pg = new PageReference('/PO_PP_InserimentoSVLAN');
    		
    		//Se la lista contiene già una richiesta VLAN allora passo l'ID come parametro
    		if(log_richieste.size()>0){
    		    pg.getParameters().put('richVLan','NO');
    		    id_log_richiestaVLAN = log_richieste.get(0).id;
    		    pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
    		    System.debug('***ID LOG Richiesta VLAN***: '+id_log_richiestaVLAN);
    		    System.debug('***Richiesta VLAN presente!!***');
    		}
    		else{
    		    pg.getParameters().put('richVLan','SI');
    		    System.debug('***Nessuna Richiesta VLAN presente!!***');
    		}
    	    pg.getParameters().put('nameKit',selectednameKit);
	    
    		if (kit_selezionato==null){
    			idNonValido=true;
    		}
    		else{
    			idNonValido=false;
    			return pg;
    		}
        }
	    return null;
	}
}