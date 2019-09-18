@isTest
public class OF_GestioneServiziAttiviPassiviTEST {

    @testSetup
    static void CreateDataTest()
    {
        /**Creazione Account**/
        List<Account> listAccount = new List<Account>();
        listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO(); 
        /**Creazione Servizi**/
        List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
        listServizi = OF_AreaGeograficaUtilityTest.createServizi();
        /****Creazione Contratti****/
        Map<ID,String> mapAcc = new Map<ID,String>();
        List<Contract> listContract = new List<Contract>();
        OF_AreaGeograficaUtilityTest.getMappa(listAccount);//getMappa
        listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
        /**Creazione Associazione Contratti-Servizi**/
        List<OF_ContrattoServizio__c> listContrServ = new List<OF_ContrattoServizio__c>();
        listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract,listServizi,mapAcc);
        
        /**Creazione Listini**/
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();
        List<OF_ServizioBillingElement__c> listServiziBillingElement = new List<OF_ServizioBillingElement__c>();
        
        listCommercial = OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = OF_GestioneServiziAttiviNEW_TEST.createBillingElement(listCommercial);
        listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
        OF_GestioneServiziAttiviNEW_TEST.createListini(listServiziBillingElement);
   		
      	//Creazione custom setting configurazione
        OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting1();
    }
    
    static testmethod Map<String,String> RecordType()
    { 
        //Record Type
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Asset' OR sObjectType='Order' OR sObjectType = 'OF_CommercialElementIstanziato__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
		
		for(RecordType rt: rtypes)
    		RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
    static testmethod void trycatch()
    {
    	OF_GestioneServiziAttiviPassivi.CreazioneAsset(null, null, null);
        OF_GestioneServiziAttiviPassivi.CessazioneAsset(null, null);
        OF_GestioneServiziAttiviPassivi.CessazioneBE(null, null);
        OF_GestioneServiziAttiviPassivi.CessazioneCE(null, null);
        OF_GestioneServiziAttiviPassivi.getControlli1(null, null);
        OF_GestioneServiziAttiviPassivi.getControlli2(null);
    }
    
    //Testa il metodo CessazioneCE
    static testmethod void metodo1()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account acc = [select id from account limit 1 ];
        
        order o = new order();
        o.recordtypeID = RecordTypeMap.get( 'INORDER' );
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.Name ='test1';
        insert o;
    	
        list<asset> assetlist = new list<asset>();
        asset ass = new asset();
        ass.name = 'test';
        ass.AccountId = acc.id;
        ass.RecordTypeId = RecordTypeMap.get('GPON Passiva');
        ass.OF_OrdineId__c = o.id;
        ass.EOF_ID_Risorsa__c = 'test';
        insert ass;
        assetlist.add(ass);
        
        Map<String,Order> mapp = new Map<String,Order>();
        mapp.put(ass.EOF_ID_Risorsa__c, o);
        
        //creo CE sotto l'asset
        OF_AreaGeograficaUtilityTest.createCEistanziatiSottoAsset(ass, 'Open Stream');
        
        OF_GestioneServiziAttiviPassivi.CessazioneCE(assetlist, mapp);
        
    }
    
    //Testa il metodo CessazioneBE
    static testmethod void metodo2()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account acc = [select id from account limit 1 ];
        
        order o = new order();
        o.recordtypeID = RecordTypeMap.get( 'INORDER' );
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.Name ='test1';
        insert o;
    	
        list<asset> assetlist = new list<asset>();
        asset ass = new asset();
        ass.name = 'test';
        ass.AccountId = acc.id;
        ass.RecordTypeId = RecordTypeMap.get('GPON Passiva');
        ass.OF_OrdineId__c = o.id;
        ass.EOF_ID_Risorsa__c = 'test';
        ass.Status = 'Attivo';
        insert ass;
        assetlist.add(ass);
        
        Map<String,Order> mapp = new Map<String,Order>();
        mapp.put(ass.EOF_ID_Risorsa__c, o);
        
        list<product2> prodlist = [select id, name, OF_ListinoCustom__c from product2];
        list<pricebook2> pricblist = [select id, name, OF_Listino__c from pricebook2];
        
        //pricebookentry standard
        OF_AreaGeograficaUtilityTest.createPriceBookStandard(prodlist);
        OF_AreaGeograficaUtilityTest.createPriceBookEntry(prodlist, pricblist, ass.Id);
        
        OF_GestioneServiziAttiviPassivi.CessazioneBE(assetlist, mapp);
        
        OF_GestioneServiziAttiviPassivi.getControlli1('1', 'Y');
        
        OF_GestioneServiziAttiviPassivi.CessazioneAsset(assetlist, mapp);
    }
    
    static testmethod void metodo3()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account acc = [select id from account limit 1 ];
        
        order o = new order();
        o.recordtypeID = RecordTypeMap.get( 'INORDER' );
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = acc.id;
        o.Name ='test1';
        insert o;
    	
        list<asset> assetlist = new list<asset>();
        asset ass = new asset();
        ass.name = 'test';
        ass.AccountId = acc.id;
        ass.RecordTypeId = RecordTypeMap.get('P2P');
        ass.OF_OrdineId__c = o.id;
        ass.EOF_ID_Risorsa__c = 'test';
        ass.Status = 'Attivo';
        insert ass;
        assetlist.add(ass);
        
        Map<String,Order> mapp = new Map<String,Order>();
        mapp.put(ass.EOF_ID_Risorsa__c, o);
        
        list<product2> prodlist = [select id, name, OF_ListinoCustom__c from product2];
        list<pricebook2> pricblist = [select id, name, OF_Listino__c from pricebook2];
        
        //pricebookentry standard
        OF_AreaGeograficaUtilityTest.createPriceBookStandard(prodlist);
        OF_AreaGeograficaUtilityTest.createPriceBookEntry(prodlist, pricblist, ass.Id);
        
        OF_GestioneServiziAttiviPassivi.CessazioneBE(assetlist, mapp);
        
        OF_GestioneServiziAttiviPassivi.getControlli1('1', 'Y');
        
        OF_GestioneServiziAttiviPassivi.CessazioneAsset(assetlist, mapp);
    }

    static testmethod void metodo4(){
        
        test.startTest();

    	OF_GestioneServiziAttiviPassivi.CreazioneAsset(null, null, 0);
        
        test.stopTest();
        
    }    
    
}