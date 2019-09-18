@isTest
public with sharing class OF_AttivazManualeBEController_TEST {
	
    //Catalogo e servizi
    public static List<OF_Servizio__c> createServizi()
    {
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
    
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
    
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
    
        /**Creazione Servizi**/
        List<OF_Servizio__c> listaServizi = new List<OF_Servizio__c>();
        OF_Servizio__c GPONPassiva = new OF_Servizio__c();
        OF_Servizio__c Extra = new OF_Servizio__c();
        
        GPONPassiva.Name = 'GPON Passiva';
        GPONPassiva.OF_Attivo__c = true;
        GPONPassiva.OF_CatalogoCommerciale__c = catalogo.Id;
        GPONPassiva.OF_DataInizioValidita__c = myDate;
        GPONPassiva.OF_DataFineValidita__c = newDate;
        listaServizi.add(GPONPassiva);
        
        Extra.Name = 'Extra';
        Extra.OF_Attivo__c = true;
        Extra.OF_CatalogoCommerciale__c = catalogo.Id;
        Extra.OF_DataInizioValidita__c = myDate;
        Extra.OF_DataFineValidita__c = newDate;
        listaServizi.add(Extra);
    
        if(listaServizi != null && listaServizi.size() > 0) insert listaServizi;
              
        return listaServizi;  
    }
    
    public static List<OF_CommercialElement__c> createCommercialElement(List<OF_Servizio__c> listServizi)
    {
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        
        if( listServizi != null && listServizi.size()>0 )
        {
              for( OF_Servizio__c serv : listServizi )
              {
              
              OF_CommercialElement__c GPONPassiva2;
              OF_CommercialElement__c InterventoVuoto;
              OF_CommercialElement__c Extra;
              OF_CommercialElement__c Extra1;
               
              if( serv.Name == 'GPON Passiva')
              {
              GPONPassiva2 = new OF_CommercialElement__c();
              GPONPassiva2.OF_Servizio__c = serv.id;
              GPONPassiva2.OF_Attivo__c=true;
              GPONPassiva2.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              GPONPassiva2.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              GPONPassiva2.Name = 'SERVIZIO FIBRA BASE';
              
              
              InterventoVuoto = new OF_CommercialElement__c();
              InterventoVuoto.OF_Servizio__c = serv.id;
              InterventoVuoto.OF_Attivo__c=true;
              InterventoVuoto.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              InterventoVuoto.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              InterventoVuoto.Name = 'CPE';
              }
              
              if( serv.Name == 'Extra')
              {
                 
              Extra = new OF_CommercialElement__c();
              Extra.OF_Servizio__c = serv.id;
              Extra.OF_Attivo__c=true;
              Extra.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              Extra.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              Extra.Name = 'Intervento a vuoto';
              
              
              Extra1 = new OF_CommercialElement__c();
              Extra1.OF_Servizio__c = serv.id;
              Extra1.OF_Attivo__c=true;
              Extra1.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              Extra1.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              Extra1.Name = 'Verticale';
              }
              
          	  if( GPONPassiva2 != null )listCommercial.add(GPONPassiva2);
              if( InterventoVuoto != null)listCommercial.add( InterventoVuoto );
              if( Extra != null )listCommercial.add(Extra);
              if( Extra1 != null)listCommercial.add( Extra1 );
              }
        }
        if( listCommercial.size()>0) insert listCommercial;
        return listCommercial;
    }
    
    public static List<OF_BillingElement__c> createBillingElement(List<OF_CommercialElement__c> listaCommercial)
    {
        
        Set<ID> ids2 = new Set<ID>();
        for( OF_CommercialElement__c obj : listaCommercial)
            ids2.add( obj.Id );
         
        List<OF_CommercialElement__c> listSer = [SELECT id,Name,OF_Servizio__r.name
                                                       FROM OF_CommercialElement__c
                                                       WHERE Id IN : ids2];
        
        
        List<OF_BillingElement__c> listBilling =new List<OF_BillingElement__c>();
        Integer index = 0;
        Integer index1 = 0;
        Integer index2 = 0;
        for( OF_CommercialElement__c item : listSer)
        {
            if(item.OF_Servizio__r.name == 'GPON Passiva')
            {
                OF_BillingElement__c billElem = new OF_BillingElement__c();
                if( index == 0) billElem.Name = 'Canone';
                if( index == 1) billElem.Name = 'Canone Premium';
                if( index == 2) billElem.Name = 'Contributo Disattivazione';
                if( index == 3) billElem.Name = 'Contributo attivazione';
                if( index == 5) billElem.Name = 'Contributo istallazione';
                if( index == 6) billElem.Name = 'Contributo Consegna';
                else billElem.Name = 'Canone';
                
                billElem.OF_Attivo__c = true;
                billElem.OF_CommercialElement__c = item.Id;
                billElem.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
                billElem.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
                listBilling.add(billElem);
                index ++;
            }
            if(item.OF_Servizio__r.name == 'Extra')
            {
                OF_BillingElement__c billElem = new OF_BillingElement__c();
                if(item.Name == 'Intervento a vuoto'){
                    if( index == 0) billElem.Name = 'Contributo Intervento a vuoto Provisioning';
                    if( index == 1) billElem.Name = 'Contributo Intervento a vuoto Assurance';
                    index1 ++;
                }else if(item.Name == 'Verticale')
                {
                    if( index == 0) billElem.Name = 'Contributo attivazione';
                    if( index == 1) billElem.Name = 'Contributo istallazione';
                    index2 ++;
                }
                
                billElem.OF_Attivo__c = true;
                billElem.OF_CommercialElement__c = item.Id;
                billElem.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
                billElem.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
                listBilling.add(billElem);                  
            }
        }
        if(listBilling != null && listBilling.size() > 0) insert listBilling;
        return listBilling;
    }
    
    public static void listiniGPONPassiva(List<OF_ServizioBillingElement__c> listServizioBilling){
        List<OF_Listino__c> listListini = new List<OF_Listino__c>();
        String ListRecordTypePassId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
		Integer i = 0;
        for( OF_ServizioBillingElement__c item : listServizioBilling )
         {
             OF_Listino__c listinoItem = new OF_Listino__c();
             if ( item.OF_ServizioNome__c == 'GPON Passiva')
             {
                
               	 listinoItem.RecordTypeId = ListRecordTypePassId;
                 listinoItem.Name = item.Name;
                 listinoItem.OF_Attivo__c=true;
                 listinoItem.OF_DataInizioValidita__c = Date.newInstance(1990,04,24);
                 listinoItem.OF_DataFineValidita__c = Date.newInstance(2020,04,24);
                 listinoItem.OF_IDContract__c = item.OF_Contract__c;
                 listinoItem.OF_ServizioBillingElement__c = item.Id;
                 listinoItem.OF_ListinoDefault__c = true; 
                 listListini.add(listinoItem);
                 i++;
                 if( i == 7 )break;
             }
         }
         
         if( listListini != null && listListini.size()>0) insert listListini;
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listListini: ' + listListini);
    }
    
    public static void listiniVerticale(List<OF_ServizioBillingElement__c> listServizioBilling){
        
        List<OF_Listino__c> listListini = new List<OF_Listino__c>();
        String ListRecordTypePassId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Extra').getRecordTypeId();
		Integer i = 0;
        for( OF_ServizioBillingElement__c item : listServizioBilling )
         {
             OF_Listino__c listinoItem = new OF_Listino__c();
             if ( item.OF_ServizioNome__c == 'Extra')
             {
                
               	 listinoItem.RecordTypeId = ListRecordTypePassId;
                 listinoItem.Name = item.Name;
                 listinoItem.OF_Attivo__c=true;
                 listinoItem.OF_DataInizioValidita__c = Date.newInstance(1990,04,24);
                 listinoItem.OF_DataFineValidita__c = Date.newInstance(2020,04,24);
                 listinoItem.OF_IDContract__c = item.OF_Contract__c;
                 listinoItem.OF_ServizioBillingElement__c = item.Id;
                 listinoItem.OF_ListinoDefault__c = true; 
                 listListini.add(listinoItem);
                 i++;
                 if( i == 7 )break;
             }
         }
         
         if( listListini != null && listListini.size()>0) insert listListini;
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listListini: ' + listListini);
    }
	
    //GPON Passiva, Verticali, Intervento a vuoto
    public static testmethod void MyUnitTest1()
    {
    	/**Creazione due AccountOLO  Vodafone e Wind**/
        List<Account> listaAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();
        Map<ID,String> mapAccount = OF_AreaGeograficaUtilityTest.getMappa(listaAccount);
        List<Contract> listaContract = OF_AreaGeograficaUtilityTest.createContract(listaAccount);
        List<OF_Servizio__c> listaServizi = createServizi();
        
        List<OF_ContrattoServizio__c> ContractServiceList = OF_AreaGeograficaUtilityTest.createContractService(listaContract,listaServizi,mapAccount);
        
        //CustomSetting
        OF_Configurazioni__c customS = new OF_Configurazioni__c();
        customS.OF_ServizioExtraName__c = 0;
        customS.Name = 'Test';
        insert customS;

        List<OF_CommercialElement__c> listCE = createCommercialElement(listaServizi);
        List<OF_BillingElement__c>  listBE = createBillingElement( listCE );        
        List<OF_ServizioBillingElement__c> listServBE = OF_AreaGeograficaUtilityTest.createServiziBillingElement( listBE , ContractServiceList );
		
        /**Creazione Asset**/
        Asset ass = new Asset();
        String GPONPassiva = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
        String Verticale = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        String Intervento = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Intervento a vuoto').getRecordTypeId();
        
        ass.Name = 'Test1';
        ass.RecordTypeId = GPONPassiva;
        ass.OF_Contract__c = listaContract[0].Id;
        ass.EOF_ID_Risorsa__c = 'Test1';
        ass.AccountId = listaAccount[0].Id;
        insert ass;
        
        /**Creazione CE per l'asset**/
        OF_AreaGeograficaUtilityTest.createCEistanziatiSottoAsset(ass,'GPON Passiva');
        //Test Listini Mancanti
	     ApexPages.currentPage().getParameters().put('id',ass.Id);
	     OF_AttivazManualeBEController contr = new OF_AttivazManualeBEController();
	     contr.toReturn();
	    
         OF_AttivazManualeBEController.serviziorichiestoCE(ass);
        
         /**Test Listini esistenti e PriceBookEntry legate all'Asset Esistenti**/
         //OF_AreaGeograficaUtilityTest.createListini(listServBE);
         listiniGPONPassiva(listServBE);
         listiniVerticale(listServBE);
        
        List<OF_Listino__c> listini = [select id, name, RecordType.name, OF_ServizioBillingElement__r.OF_ServizioNome__c from OF_Listino__c];
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listini: ' + listini);
        set<id> ids = new set<id>();
		for(OF_Listino__c lis : listini)
            ids.add(lis.id);
        
        //system.debug('DG_OF_AttivazManualeBEController_TEST - ids: ' + ids);
        /**Creazione PriceBookEntry**/
         List<Product2> listProduct2 = [select id,OF_ListinoCustom__c,Name,OF_Servizio__c,OF_CommercialElement__c from product2 where OF_ListinoCustom__c IN : ids];
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listProduct2: ' + listProduct2);
         OF_AreaGeograficaUtilityTest.createPriceBookStandard( listProduct2 );
         
         List<PriceBook2> listPriceBook2 = [select id, name, OF_Listino__c, isStandard, Commercial_element__c from pricebook2 where isStandard = false and OF_Listino__c IN : ids];
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listPriceBook2: ' + listPriceBook2);
         OF_AreaGeograficaUtilityTest.createPriceBookEntry( listProduct2 , listPriceBook2 , ass.Id);
        
         /**1 Test**/
         ApexPages.currentPage().getParameters().put('id',ass.Id);
         OF_AttivazManualeBEController contr1 = new OF_AttivazManualeBEController();
         contr1.BEIst = '--Seleziona Billing Element--';
         contr1.save();
         
         /**2 Test**/
         ApexPages.currentPage().getParameters().put('id',ass.Id);
         OF_AttivazManualeBEController contr2 = new OF_AttivazManualeBEController();
         contr2.BEIst = String.valueOf( listProduct2[0].Id );
         contr2.save();
         contr2.getBE();
         
         //3 Test
         Asset ass1 = new Asset();
         ass1.Name = 'Test2';
         ass1.RecordTypeId = Verticale;
         ass1.OF_Contract__c = listaContract[0].Id;
         ass1.EOF_ID_Risorsa__c = 'Test2';
         ass1.AccountId = listaAccount[0].Id;
         insert ass1;
                  
         ApexPages.currentPage().getParameters().put('id',ass1.Id);
         OF_AttivazManualeBEController contr3 = new OF_AttivazManualeBEController();
         contr3.getBE();
        
        //Test Intervento a vuoto
        asset ass11 = new asset(
            Name = 'test',
            AccountId = listaAccount[0].Id,
            Status = 'Attivo',
            RecordTypeId = GPONPassiva
        );
        insert ass11;
        
        case cas = new case(
        	EOF_Account_OLO__c = listaAccount[0].Id,
            Status = 'Espletato',
            OF_Servizio__c = 'GPON Passiva',
            assetid = ass11.id,
            OF_IDContratto__c = listaContract[0].id
        );
        insert cas;
        
        asset ass2 = new asset(
            Name = 'test',
            AccountId = listaAccount[0].Id,
            Status = 'Attivo',
            RecordTypeId = Intervento,
            OF_Case__c = cas.id,
            OF_ServizioRichiesto__c = 'GPON Passiva',
            OF_TipoDiProcesso__c = 'Assurance',
            OF_Data__c = system.now()
        );
        insert ass2;
            
         ApexPages.currentPage().getParameters().put('id',ass2.Id);
         OF_AttivazManualeBEController contr4 = new OF_AttivazManualeBEController();
         contr4.getBE();
    }
    
    //GPON Passiva, Verticali, Intervento a vuoto product eliminati
    public static testmethod void MyUnitTest2()
    {
    	/**Creazione due AccountOLO  Vodafone e Wind**/
        List<Account> listaAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();
        Map<ID,String> mapAccount = OF_AreaGeograficaUtilityTest.getMappa(listaAccount);
        List<Contract> listaContract = OF_AreaGeograficaUtilityTest.createContract(listaAccount);
        List<OF_Servizio__c> listaServizi = createServizi();
        
        List<OF_ContrattoServizio__c> ContractServiceList = OF_AreaGeograficaUtilityTest.createContractService(listaContract,listaServizi,mapAccount);
        
        //CustomSetting
        OF_Configurazioni__c customS = new OF_Configurazioni__c();
        customS.OF_ServizioExtraName__c = 0;
        customS.Name = 'Test';
        insert customS;

        List<OF_CommercialElement__c> listCE = createCommercialElement(listaServizi);
        List<OF_BillingElement__c>  listBE = createBillingElement( listCE );        
        List<OF_ServizioBillingElement__c> listServBE = OF_AreaGeograficaUtilityTest.createServiziBillingElement( listBE , ContractServiceList );
		
        Set<ID> ids1 = new Set<ID>();
        for( OF_ServizioBillingElement__c obj : listServBE)
            ids1.add( obj.Id );
         
        List<OF_ServizioBillingElement__c> listSBE = [SELECT id,Name,OF_Contract__c,OF_Servizio__c,OF_ServizioNome__c
                                                       FROM OF_ServizioBillingElement__c
                                                       WHERE Id IN : ids1];
        
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listSBE: ' + listSBE);

        /**Creazione Asset**/
        Asset ass = new Asset();
        String GPONPassiva = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
        String Verticale = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        String Intervento = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Intervento a vuoto').getRecordTypeId();
        
        ass.Name = 'Test1';
        ass.RecordTypeId = GPONPassiva;
        ass.OF_Contract__c = listaContract[0].Id;
        ass.EOF_ID_Risorsa__c = 'Test1';
        ass.AccountId = listaAccount[0].Id;
        insert ass;
        
        /**Creazione CE per l'asset**/
        OF_AreaGeograficaUtilityTest.createCEistanziatiSottoAsset(ass,'GPON Passiva');
        //Test Listini Mancanti
	     ApexPages.currentPage().getParameters().put('id',ass.Id);
	     OF_AttivazManualeBEController contr = new OF_AttivazManualeBEController();
	     contr.toReturn();
	    
         OF_AttivazManualeBEController.serviziorichiestoCE(ass);
        
         /**Test Listini esistenti e PriceBookEntry legate all'Asset Esistenti**/
         //OF_AreaGeograficaUtilityTest.createListini(listServBE);
         listiniGPONPassiva(listServBE);
         listiniVerticale(listServBE);
        
        List<OF_Listino__c> listini = [select id, name, RecordType.name, OF_ServizioBillingElement__r.OF_ServizioNome__c from OF_Listino__c];
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listini: ' + listini);
        set<id> ids = new set<id>();
		for(OF_Listino__c lis : listini)
            ids.add(lis.id);
        
        //system.debug('DG_OF_AttivazManualeBEController_TEST - ids: ' + ids);
        /**Creazione PriceBookEntry**/
         List<Product2> listProduct2 = [select id,OF_ListinoCustom__c,Name,OF_Servizio__c,OF_CommercialElement__c from product2 where OF_ListinoCustom__c IN : ids];
    	OF_AreaGeograficaUtilityTest.createPriceBookStandard( listProduct2 );
         
         List<PriceBook2> listPriceBook2 = [select id, name, OF_Listino__c, isStandard, Commercial_element__c from pricebook2 where isStandard = false and OF_Listino__c IN : ids];
        //system.debug('DG_OF_AttivazManualeBEController_TEST - listPriceBook2: ' + listPriceBook2);
         OF_AreaGeograficaUtilityTest.createPriceBookEntry( listProduct2 , listPriceBook2 , ass.Id);
        
		

        
         /**1 Test**/
         ApexPages.currentPage().getParameters().put('id',ass.Id);
         OF_AttivazManualeBEController contr1 = new OF_AttivazManualeBEController();
         contr1.BEIst = '--Seleziona Billing Element--';
         contr1.save();
         
         /**2 Test**/
         ApexPages.currentPage().getParameters().put('id',ass.Id);
         OF_AttivazManualeBEController contr2 = new OF_AttivazManualeBEController();
         contr2.BEIst = String.valueOf( listProduct2[0].Id );
         contr2.save();
        delete listProduct2;
         contr2.getBE();
         
         //3 Test
         Asset ass1 = new Asset();
         ass1.Name = 'Test2';
         ass1.RecordTypeId = Verticale;
         ass1.OF_Contract__c = listaContract[0].Id;
         ass1.EOF_ID_Risorsa__c = 'Test2';
         ass1.AccountId = listaAccount[0].Id;
         insert ass1;
                  
         ApexPages.currentPage().getParameters().put('id',ass1.Id);
         OF_AttivazManualeBEController contr3 = new OF_AttivazManualeBEController();
         contr3.getBE();
        
        //Test Intervento a vuoto
        asset ass11 = new asset(
            Name = 'test',
            AccountId = listaAccount[0].Id,
            Status = 'Attivo',
            RecordTypeId = GPONPassiva
        );
        insert ass11;
        
        case cas = new case(
        	EOF_Account_OLO__c = listaAccount[0].Id,
            Status = 'Espletato',
            OF_Servizio__c = 'GPON Passiva',
            assetid = ass11.id,
            OF_IDContratto__c = listaContract[0].id
        );
        insert cas;
        
        asset ass2 = new asset(
            Name = 'test',
            AccountId = listaAccount[0].Id,
            Status = 'Attivo',
            RecordTypeId = Intervento,
            OF_Case__c = cas.id,
            OF_ServizioRichiesto__c = 'GPON Passiva',
            OF_TipoDiProcesso__c = 'Assurance',
            OF_Data__c = system.now()
        );
        insert ass2;
            
         ApexPages.currentPage().getParameters().put('id',ass2.Id);
         OF_AttivazManualeBEController contr4 = new OF_AttivazManualeBEController();
        contr4.getBE();
    }
    
    
}