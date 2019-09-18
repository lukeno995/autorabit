@isTest
public class OF_ContrattoServizioTriggerHandler_Test {
	@isTest
    public static void OF_ContrattoServizioTriggerHandler_Test_method1(){
        //nuovo Catalogo
        OF_CatalogoCommerciale__c cat = new OF_CatalogoCommerciale__c(OF_DataInizioValidita__c = date.today(),
                                                                     OF_DataFineValidita__c= date.today().AddDays(1));
		insert cat;
        //nuovo Account
        Account OLO = new Account(Name = 'OF_ContrattoServizioTriggerHandler_Test_OLO');
		insert OLO;
        //nuovo Contratto
       	Contract contr = new Contract(AccountId = OLO.Id);
        insert contr;
        //nuovo Servizio
        OF_Servizio__c serv = new OF_Servizio__c(OF_CatalogoCommerciale__c = cat.Id,
                                                OF_DataInizioValidita__c = date.today(),
                                                OF_DataFineValidita__c = date.today().AddDays(1)) ;
        insert serv;
        //nuovo OF_ContrattoServizio
        OF_ContrattoServizio__c cs1 = new OF_ContrattoServizio__c(OF_Servizio__c = serv.Id,
                                                                OF_Contract__c = contr.Id);
        insert cs1;
        //inserendo un OF_ContrattoServizio uguale a cs viene triggerata la duplicazione come previsto.
    }
}