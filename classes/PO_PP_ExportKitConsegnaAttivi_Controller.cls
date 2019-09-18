public without sharing class PO_PP_ExportKitConsegnaAttivi_Controller {

	public String soql {get;set;}
	public String listRichiesteKitString {get;set;}
	public List<OF_CommercialElementIstanziato__c> listakitAttivi {get;set;}
    public String codOP {get;set;}
    public List<KitWrapper> listRichiesteKitWr {get;set;}
    public String nomeKit{get;set;}
    public String idRisorsa{get;set;}
    public String stato {get;set;}
    public String pop {get;set;}
    public String banda {get;set;}
    public String servizioCommerciale {get;set;}
    public String DataInizio {get;set;}
    //public String DataFine {get;set;}

	public PageReference fetchList()
	{
		system.debug('**Export_Kit_Consegna_Attivi**');
		
		nomeKit = System.currentPagereference().getParameters().get('nomeKit');
		idRisorsa = System.currentPagereference().getParameters().get('idRisorsa');
		stato = System.currentPagereference().getParameters().get('stato');
		pop = System.currentPagereference().getParameters().get('pop');
		banda = System.currentPagereference().getParameters().get('banda');
		servizioCommerciale = System.currentPagereference().getParameters().get('ServizioCommerciale');
		DataInizio = System.currentPagereference().getParameters().get('DataInizio');
		
		/*
		System.debug('***nomeKit***:'+nomeKit);
		System.debug('***idRisorsa***:'+idRisorsa);
		System.debug('***stato***:'+stato);
		System.debug('***pop***:'+pop);
		System.debug('***banda***:'+nomeKit);
		System.debug('***servizioCommerciale***:'+servizioCommerciale);
		System.debug('***DataInizio***:'+DataInizio);
		*/
		DataInizio = DataInizio.replace(' ','+');
		//DataFine = DataFine.replace(' ','+');

		//Id accId =  [SELECT AccountId FROM User where id=:userinfo.getuserid() LIMIT 1].AccountId;
		
        codOp = [SELECT Contact.account.name 
                FROM User 
                WHERE id = :userinfo.getuserid() 
                LIMIT 1].Contact.account.name;
        
        //System.debug('***codOp***:'+codOp);

        soql = 'Select id, name, PO_PP_Nome_KIT__c, PO_PP_Pop__c, PO_PP_Banda_Interfaccia__c, PO_PP_InterfacciaKit__c, PO_PP_Servizio_Commerciale__c, OF_Stato__c,'+
        		' RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c, OF_Asset__r.EOF_ID_Risorsa__c, OF_DataAttivazione__c '+
        		' from OF_CommercialElementIstanziato__c '+
        		' where OF_CommercialElement__r.name=\'SERVIZIO KIT\''+
        		' and OF_Asset__r.account.name='+'\''+codOp+'\''+
        		' and OF_Asset__r.status=\'Attivo\'';
        
        system.debug('***QUERY SOQL: '+soql);
        
        if (nomeKit!=null&& !nomeKit.equals('')){
            soql += ' and PO_PP_Nome_KIT__c =\''+String.escapeSingleQuotes(nomeKit)+'\'';     
        }
        if (DataInizio!=null && !DataInizio.equals(''))
        {
            soql += ' and OF_DataAttivazione__c >='+String.escapeSingleQuotes(DataInizio); 
            System.debug('@@@Soql'+soql);
        }
        /*
        if (DataFine!=null && !DataFine.equals('')){
            soql += ' and OF_DataCessazione2__c <='+String.escapeSingleQuotes(DataFine);
        }
        */
        if (idRisorsa!=null && !idRisorsa.equals('')){
            soql += ' and OF_Asset__r.EOF_ID_Risorsa__c =\''+String.escapeSingleQuotes(idRisorsa)+'\'';     
        }
        if (pop!=null && !pop.equals('')){                       
            soql += ' and PO_PP_Pop__c =\''+String.escapeSingleQuotes(pop)+'\'';
        }
        if (banda!=null && !banda.equals('')){                       
            soql += ' and PO_PP_Banda_Interfaccia__c =\''+String.escapeSingleQuotes(banda)+'\'';
        }
        if(String.isNotBlank(servizioCommerciale))
        {
            List<String> listServizi = (List<String>)System.JSON.deserialize(servizioCommerciale, List<String>.class);
            if(listServizi!=null && !listServizi.isEmpty())
            {
                soql += ' and PO_PP_Servizio_Commerciale__c in (';
                
                for (string mystring:listServizi)
                {
                    soql +='\'' + mystring + '\',';
                }
                soql = soql.removeEnd(',');
                soql += ')';  
            }
        }
        System.debug('QUERY FORMATTATA !!!! '+soql);
        
        listakitAttivi = Database.query(soql + ' order by CreatedDate DESC');
        System.debug('***Lista Kit Size: ***:'+listakitAttivi.size());
        System.debug('LISTA KIT DOPO QUERY: '+listakitAttivi);

        if(listakitAttivi.size()>0)
        {
            listRichiesteKitWr = populateKitWrapper(listakitAttivi);
            listRichiesteKitString = JSON.serialize(listRichiesteKitWr);
            System.debug('NEW :' + listRichiesteKitWr.size());
        }
		return null;
	}

    //KIT Wrapper
    public class KitWrapper{
        
        public string id{get;set;}
        public String nomeKit{get;set;}
        public string idRisorsa{get;set;}
        public String stato{get;set;}
        public String pop{get;set;}
        public String banda{get;set;}
        public String interfaccia{get;set;}
        public String servizioCommerciale{get;set;}
        public String DataCessazione{get;set;}
        public String DataAttivazione{get;set;}
        
        public KitWrapper(){}
    }
	
    public List<KitWrapper> populateKitWrapper(List<OF_CommercialElementIstanziato__c> lista)
    {
        List<KitWrapper> listKitWrp = new List<KitWrapper>();
        
        for(OF_CommercialElementIstanziato__c kit: lista)
        {
            KitWrapper elem = new KitWrapper();
            elem.nomeKit = kit.PO_PP_Nome_KIT__c;
            elem.idRisorsa = kit.OF_Asset__r.EOF_ID_Risorsa__c;
            elem.stato = kit.OF_Stato__c;
            elem.pop = kit.PO_PP_Pop__c;
            elem.banda = kit.PO_PP_Banda_Interfaccia__c;
            elem.interfaccia = kit.PO_PP_InterfacciaKit__c;
            elem.servizioCommerciale = kit.PO_PP_Servizio_Commerciale__c;
            elem.DataAttivazione = string.valueOfGmt(kit.OF_DataAttivazione__c);
            listKitWrp.add(elem);
        }
        return listKitWrp;
    }
}