@isTest
public with sharing class OF_AttivazManualeCEController_TEST {
    
    public static testmethod void MyUnitTest1()
    {
    	/**Creazione due AccountOLO  Vodafone e Wind**/
        List<Account> listaAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();
        Map<ID,String> mapAccount = OF_AreaGeograficaUtilityTest.getMappa(listaAccount);
        List<Contract> listaContract = OF_AreaGeograficaUtilityTest.createContract(listaAccount);
        List<OF_Servizio__c> listaServizi = OF_AreaGeograficaUtilityTest.createServizi();
        List<OF_ContrattoServizio__c> ContractServiceList = OF_AreaGeograficaUtilityTest.createContractService(listaContract,listaServizi,mapAccount);
        
        //CustomSetting
        OF_Configurazioni__c customS = new OF_Configurazioni__c();
        customS.OF_ServizioExtraName__c = 0;
        customS.Name = 'Test';
        insert customS;

        List<OF_CommercialElement__c> listCE = OF_AreaGeograficaUtilityTest.createCommercialElement(listaServizi);
        List<OF_BillingElement__c>  listBE = OF_AreaGeograficaUtilityTest.createBillingElement( listCE );
        List<OF_ServizioBillingElement__c> listServBE = OF_AreaGeograficaUtilityTest.createServiziBillingElement( listBE , ContractServiceList );
              
        /**Creazione Asset**/
        Asset ass = new Asset();
        String GPONPassiva = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
        String OpenStream = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        String Verticale = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Verticale').getRecordTypeId();
        String InVuoto = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Intervento a vuoto').getRecordTypeId();
        
        ass.Name = 'Test';
        ass.RecordTypeId = GPONPassiva;
        ass.OF_Contract__c = listaContract[0].Id;
        ass.EOF_ID_Risorsa__c = 'Test';
        ass.AccountId = listaAccount[0].Id;
        insert ass;
        
        /**Creazione CE per l'asset**/
        OF_AreaGeograficaUtilityTest.createCEistanziatiSottoAsset(ass,'GPON Passiva');
        List<OF_CommercialElement__c> listCECatalogo = [select id , name from OF_CommercialElement__c];

         /**Test1**/
	     ApexPages.currentPage().getParameters().put('id',ass.Id);
	     OF_AttivazManualeCEController contr = new OF_AttivazManualeCEController();
	     contr.toReturn();
         contr.CEIst='--Seleziona Commercial Element--';
         contr.save();
         contr.CEIst = listCECatalogo[0].Id;
         contr.save();
        
         contr.getrenderizzCPE();
         contr.getrenderizzVLAN();
         contr.getCE();
         //system.debug('OSCRM listCECatalogo:'+listCECatalogo);
         /**Test2**/
        Asset ass1 = new Asset();
        ass1.Name = 'Test1';
        ass1.RecordTypeId = Verticale;
        ass1.OF_Contract__c = listaContract[0].Id;
        ass1.EOF_ID_Risorsa__c = 'Test1';
        ass1.AccountId = listaAccount[0].Id;
        insert ass1;
        
        ApexPages.currentPage().getParameters().put('id',ass1.Id);
	    OF_AttivazManualeCEController contr1 = new OF_AttivazManualeCEController();
	    contr1.getCE();
         
        /**Test3**/
        asset assx = new asset(
            Name = 'test',
            AccountId = listaAccount[0].Id,
            Status = 'Attivo',
            RecordTypeId = GPONPassiva
        );
        insert assx;
        String CaseAttivazione = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();

        case cas = new case(
         EOF_Account_OLO__c = listaAccount[0].Id,
            RecordtypeId = CaseAttivazione,
            Status = 'Espletato',
            OF_IDContratto__c = listaContract[0].Id,
            OF_Servizio__c = 'GPON Passiva',
            assetid = assx.id
        );
        insert cas;
        
        Asset ass2 = new Asset();
        ass2.Name = 'Test2';
        ass2.RecordTypeId = InVuoto;
        ass2.OF_Contract__c = listaContract[0].Id;
        ass2.EOF_ID_Risorsa__c = 'Test2';
        ass2.AccountId = listaAccount[0].Id;
        ass2.OF_Case__c = cas.Id;
        ass2.OF_Contract__c = listaContract[0].Id;
        ass2.OF_ServizioRichiesto__c = 'GPON Passiva';
        insert ass2;
        
        ApexPages.currentPage().getParameters().put('id',ass2.Id);
	    OF_AttivazManualeCEController contr2 = new OF_AttivazManualeCEController();
	    contr2.getCE();
	    
    }
}