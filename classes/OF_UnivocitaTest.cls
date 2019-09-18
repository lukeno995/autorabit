@isTest
public class OF_UnivocitaTest {
    
    /**Questo metodo crea i Dati da utilizzare nella Classe di Test**/
    @testSetup
    static void createData()
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
        
        listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = OF_AreaGeograficaUtilityTest.createBillingElement(listCommercial);
        listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
        //OF_AreaGeograficaUtilityTest.createListini(listServiziBillingElement);
    }
    /**Questo metodo testa il Trigger OF_UnivocitaServizioContratto**/
    static testmethod void testOF_UnivocitaServizioContratto()
    {
        List<Contract> listContract = [select Id,AccountId,OF_IdContratto__c,StartDate,status,ContractTerm
                                       from Contract];
        List<OF_Servizio__c> listServizi = [select Name,OF_Attivo__c,OF_CatalogoCommerciale__c,
                                                   OF_DataInizioValidita__c,OF_DataFineValidita__c
                                            from OF_Servizio__c];
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = listContract[0].Id;
        cs.OF_Servizio__c = listServizi[0].Id;
       
        OF_ContrattoServizio__c cs1 = new OF_ContrattoServizio__c();
        cs1 = [select id,OF_Contract__c,OF_Servizio__c from OF_ContrattoServizio__c limit 1];
        cs1.OF_Servizio__c = listServizi[2].Id;
        cs1.OF_Contract__c = listContract[2].Id;
        try{
        update cs1;
        }catch(Exception exp)
        {
            String err = 'Il Servizio Fibra punto-punto è già associato al contratto.';
            boolean expected = exp.getMessage().contains(err) ? true : false;
        }
        /**test addError in Insert**/
        try{
        insert cs;
        }catch(Exception exp)
        {
            String err = 'Il Servizio GPON Attiva è già associato al contratto.';
            boolean expectedExceptionThrown = exp.getMessage().contains(err) ? true : false;
            system.debug('expectedExceptionThrown : ' + expectedExceptionThrown);
        }
        
    }
    /**Questo metodo testa il Trigger OF_UnivocitaServizio**/
    static testmethod void testOF_UnivocitaServizio()
    {
        List<OF_Servizio__c> listServizi = [select Id,Name,OF_Attivo__c,OF_CatalogoCommerciale__c,
                                                   OF_DataInizioValidita__c,OF_DataFineValidita__c
                                            from OF_Servizio__c];
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'GPON Attiva';
        serv.OF_CatalogoCommerciale__c = [select id from OF_CatalogoCommerciale__c limit 1].Id;
        
        try{
        insert serv;
        }catch(Exception ex)
        {
            String err1 = 'Il Servizio GPON Attiva è già associato al contratto';
            boolean expectedExceptionThrown = ex.getMessage().contains(err1) ? true : false;
        }
        OF_Servizio__c serv1 = listServizi[2];
        serv1.Id = listServizi[1].Id;
        try{
        update serv1;
        }catch(Exception ex)
         {
            String err2 = 'Il Servizio Fibra punto-punto è già associato al contratto';
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
         }
   }
    
    
    
}