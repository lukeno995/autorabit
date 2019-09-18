@isTest
public class OF_AreaGeograficaCSVTest {
    @testSetup
    static void createData()
    {
        /**Creazione due AccountOLO  Vodafone e Wind**/
        List<Account> listaAccount = OF_AreaGeograficaUtilityTest.createAccountOLO();
        system.debug('listaAcc-->'+listaAccount);
        Map<ID,String> mapAccount = OF_AreaGeograficaUtilityTest.getMappa(listaAccount);
        system.debug('mappaAcc-->'+mapAccount);
        
        List<Contract> listaContract = OF_AreaGeograficaUtilityTest.createContract(listaAccount);
        
        List<OF_Servizio__c> listaServizi = OF_AreaGeograficaUtilityTest.createServizi();
        system.debug('listaAcc-->'+listaServizi);
        OF_AreaGeograficaUtilityTest.createContractService(listaContract,listaServizi,mapAccount);
        OF_AreaGeograficaUtilityTest.getElencoComuniData();
    }
    static testmethod void myUnitTest1()
    {
        
        List<Contract> listaContratti = new List<Contract>();
        List<OF_ElencoComuniItaliani__c> listaComuni = new List<OF_ElencoComuniItaliani__c>();
        List<OF_Servizio__c> listaServizi = new List<OF_Servizio__c>();
        List<OF_AreaGeograficaCustom__c> listaAreaCustom = new List<OF_AreaGeograficaCustom__c>();
        
        listaContratti = [SELECT Id,Status,ContractTerm,StartDate,OF_IdContratto__c,AccountId FROM Contract];
        listaComuni = [SELECT OF_CodiceIstat__c,OF_Regione__c,OF_Provincia__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c];
        listaServizi = [SELECT Id,Name FROM OF_Servizio__c];  
        
         /**Step1**/
        ApexPages.currentPage().getParameters().put('id',listaContratti[0].Id);
        OF_AreaGeograficaCSV costruttore = new OF_AreaGeograficaCSV();
        costruttore.getServiziContr1();
        costruttore.BackToContract();
        costruttore.importCSVFile();
        costruttore.SaveData();
        /**Step2**/
        String parse1 = 'ISTAT\n0028899\n0012345\n';
        costruttore.csvFileBody=Blob.valueOf(parse1);
        costruttore.importCSVFile();
        costruttore.Servizio1 = '--Select Servizio--';
        costruttore.SaveData();
        
        
        /**Step3**/
        String pars2 = 'ISTAT\n001008\n001010\n';
        costruttore.csvFileBody = Blob.valueOf(pars2);
                costruttore.Servizio1 = 'GPON Attiva';

        costruttore.importCSVFile();
        costruttore.SaveData();
        
      
      
    }
}