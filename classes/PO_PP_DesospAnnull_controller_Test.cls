@isTest
private class PO_PP_DesospAnnull_controller_Test {
    
    public static Account tiscaliAccountCreation()
    {
        Account a = new Account();
        a.name = 'Tiscali';
        a.EOF_Codice_Operatore__c = 'TIS';
        insert a;
        return a;
    }

    public static EOF_EAI_Service_Log__c kitLogCreation()
    {
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - KIT - ActivationRequest').getRecordTypeId();
        kitlog.Nome_del_KIT__c = 'TEST_K';
        kitlog.EOF_Codice_Operatore__c = 'TIS';
        kitlog.recordTypeId = rtId;
        kitlog.POP__c = 'pop_01';
        kitlog.Traffico__c = 'VULA Openstream Direct';
        kitlog.Banda_Interfaccia__c = '400';
        kitlog.PO_PP_Interfaccia__c = '1 Giga';
        kitlog.EOF_Stato_Richiesta__c =	'Inserita Portale';
        kitlog.EOF_Tipo_Comunicazione_String__c = 'KIT Consegna';
        insert kitLog;
        return kitLog;
    }

	private static testMethod void test() 
	{
	    EOF_EAI_Service_Log__c sl = kitLogCreation();
	    EOF_EAI_Service_Log__c sl2 = kitLogCreation();
	    
	    Test.startTest();
	    
	    PageReference pageRef1 = new PageReference('PO_PP_AnnullaDesosp'); 
        pageRef1.getParameters().put('origId', sl.id);
        pageRef1.getParameters().put('proc','desospensione');
        Test.setCurrentPageReference(pageRef1);
        
        PO_PP_DesospAnnull_controller contr = new PO_PP_DesospAnnull_controller();
        contr.inoltraFlusso();
        contr.annullaFlusso();
        
        PageReference pageRef2 = new PageReference('PO_PP_AnnullaDesosp'); 
        pageRef2.getParameters().put('origId', sl2.id);
        pageRef2.getParameters().put('proc','annullamento');
        Test.setCurrentPageReference(pageRef2);
        PO_PP_DesospAnnull_controller contr2 = new PO_PP_DesospAnnull_controller();
        contr2.inoltraFlusso();
        contr2.annullaFlusso();

	    Test.stopTest();
	}
}