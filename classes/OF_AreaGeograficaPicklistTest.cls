@isTest
private class OF_AreaGeograficaPicklistTest{
    
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
        OF_AreaGeograficaUtilityTest.setAreaGeograficaCustom('001008','Piemonte','Alpignano','Torino');
    }
    static testMethod void myUnitTest1()
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
        OF_AreaGeograficaPicklist costruttore = new OF_AreaGeograficaPicklist();
        costruttore.toReturn();
        
        costruttore.getServiziContr();
        ApexPages.currentPage().getParameters().put('id',null);
        costruttore.toReturn();
        costruttore.getRegione();
        /**Step2**/
        costruttore.Reg = '--Seleziona Regione--';
        costruttore.checkEmptyRegionComuni();
        costruttore.getComune();
        costruttore.getProvincia();
        costruttore.Reg = 'Piemonte';
        costruttore.getProvincia();
        /**Step3**/
        costruttore.Reg=null;
        costruttore.getComune();
        costruttore.Reg='Piemonte';
        costruttore.Prov='--Seleziona Provincia--';
        costruttore.checkEmptyRegionComuni();
        
        /**Step4**/
        costruttore.Reg='test';
        costruttore.Com = new List<String>{'--Seleziona Comune--'};
        costruttore.checkEmptyRegionComuni();
        costruttore.Com = new List<String>();
        costruttore.checkEmptyRegionComuni();        
        costruttore.getComune();
        /**Step5**/
        costruttore.Prov='TEST';
        costruttore.setProvPrecedente();
        costruttore.Prov='Test1';
        costruttore.getComune();
        /**Step6**/
        costruttore.Reg='Piemonte';
        costruttore.Prov='Torino';
        costruttore.getComune();
        /**Step7---Copertura metodo principale Save()---**/
        costruttore.Com = new List<String>{'Alpignano','Andrate','Bardonecchia'};
        costruttore.Servizio = listaServizi.get(0).Id;
        costruttore.save();
        
        /**Step8**/
        costruttore.Com = new List<String>{'Alpignano','Andrate'};
        costruttore.Servizio = listaServizi.get(0).Id;
        costruttore.save();
        costruttore.Servizio = '--Seleziona Servizio--';
        costruttore.save();
        /**Step9**/
        costruttore.Reg='Piemonte';
        costruttore.Prov='Torino';
        costruttore.Com = new List<String>{'Alpignano'};
        costruttore.save();  
        /**Step10**/
        costruttore.contr=null;
        costruttore.toReturn();
       
        
         
    }
    static testMethod void myUnitTest2()
    {
        
    }
    static testMethod void myUnitTest3()
    {
        
    }
    static testMethod void MyUnitTest4()
    {
        
    }


}