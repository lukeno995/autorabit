@isTest
public class OF_FilterBillingElementTEST {
/*	@testSetup
    static void createData()
    {
        
        List<Account> listAccount = new List<Account>();
        listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO(); 
        
       
        List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();
        
        listServizi = OF_AreaGeograficaUtilityTest.createServizi();
        listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = OF_AreaGeograficaUtilityTest.createBillingElement(listCommercial);
        
       
        Map<ID,String> mapAcc = new Map<ID,String>();
        List<Contract> listContract = new List<Contract>();
        OF_AreaGeograficaUtilityTest.getMappa(listAccount);
        listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
        
        
        List<OF_ContrattoServizio__c> listContrServ = new List<OF_ContrattoServizio__c>();
        listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract,listServizi,mapAcc);
        
        
        List<OF_ServizioBillingElement__c> listServiziBillingElement = new List<OF_ServizioBillingElement__c>();
        listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
    }
    
    */
    static testmethod void testOF_FilterBillingElement()
    {
        // List<OF_ContrattoServizio__c> listContrServ = [select id, Name, OF_Servizio__c, OF_Contract__c from OF_ContrattoServizio__c];
        // OF_ContrattoServizio__c ContrServ = new OF_ContrattoServizio__c();
        // ContrServ = listContrServ[0];
        // if(ContrServ != null)
        //     delete ContrServ;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
		Account acc = new Account();
		acc.Name = 'TIS';
		acc.Type = 'OLO';
		acc.EOF_Codice_Operatore__c = 'TIS';
		acc.RecordTYpeId = AccountRecordTypeId;
		insert acc;
		
		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'test';
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio;
		servizio.OF_DataFineValidita__c = fine;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c = 'code';

		insert servizio;
        
        Contract contratto = new Contract();
		contratto.Name = 'TEST_TIS_001';
		contratto.OF_IdContratto__c = 'TEST_TIS_001';
		contratto.AccountId = acc.Id;
		contratto.ContractTerm = 24;
		contratto.StartDate = System.today();
		insert contratto;

		OF_ContrattoServizio__c contrattoServizio = new OF_ContrattoServizio__c();
		contrattoServizio.OF_Servizio__c = servizio.Id;
		contrattoServizio.OF_Contract__c = contratto.Id;
		insert contrattoServizio;
        
    }
}