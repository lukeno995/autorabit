@isTest

public class PO_PP_SVLan_Controller_TEST {
    
    public static EOF_EAI_Service_Log__c kitLogCreation()
    {
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c ();
        String rtId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - PP - KIT - ActivationRequest').getRecordTypeId();
        kitlog.Nome_del_KIT__c = 'TEST_K';
        kitlog.recordTypeId = rtId;
        insert kitLog;
        return kitLog;
    }
    
    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
	    catalogo.OF_DataInizioValidita__c = inizio;
	    catalogo.OF_DataFineValidita__c = fine;
	    insert catalogo;
	    return catalogo;
    }
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'KIT';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
	    servizio.OF_DataInizioValidita__c = inizio;
	    servizio.OF_DataFineValidita__c = fine;
	    servizio.OF_CatalogoCommerciale__c = cat.id;
	    insert servizio;
	    return servizio;
    }
    
    public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
	    OF_CommercialElement__c ce = new OF_CommercialElement__c();
	    Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
	    ce.name = 'SERVIZIO KIT';
	    ce.OF_Attivo__c = true;
	    ce.OF_DataInizioValidita__c = inizio;
	    ce.OF_DataFineValidita__c = fine;
	    ce.OF_Servizio__c = serv.id;
	    insert ce;
	    return ce;
    }  
    
	public static Asset assetCreation(Account acc){

		String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Preprovisioning').getRecordTypeId();
		Asset asset_1 = new Asset();
		asset_1.Name = 'Test Asset PP';
		asset_1.Status = 'Attivo';
		asset_1.recordTypeId = assetRecordTypeId;
		asset_1.AccountId = acc.id;
		insert asset_1;
		return asset_1;
	}
    
	public static Account accountCreation()
	{
		String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'Mario Bianchi';
        acc.EOF_Codice_Operatore__c = 'TIS';
        acc.RecordTypeId = AccountRecordTypeId;
        insert acc;
        
        return acc;
	}
    
    public static Case caseCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }
    
    public static testmethod void test_method1()
    {       
        Test.startTest();
        EOF_EAI_Service_Log__c logK = kitLogCreation();
        
        Account acc = AccountCreation();
        Case caso = caseCreation(acc);
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Test';
        insert con;
        
        Asset asset_test = assetCreation(acc);
        
        asset_test.contactId = con.id;
        update asset_test;
        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c serv = Servizio_Creation(cat);
        OF_CommercialElement__c ce_test = CE_Creation(serv);
        
        OF_CommercialElementIstanziato__c kit = new OF_CommercialElementIstanziato__c();
        kit.PO_PP_Nome_KIT__c = 'TEST_K';
        kit.OF_CommercialElement__c = ce_test.id;
        kit.OF_Asset__c = asset_test.id;
        kit.OF_Case__c = caso.id;
        insert kit;
        
        ApexPages.currentPage().getParameters().put('nameKit','TEST_K');
        ApexPages.currentPage().getParameters().put('richVLan','SI');
        
        PO_PP_SVLan_Controller vlan_contr = new PO_PP_SVLan_Controller();
        vlan_contr.cos_type = 'MonoCOS';
        vlan_contr.cos_remarking = 'SI';
        vlan_contr.dhcp_Option82 = 'NO';
        PageReference p = vlan_contr.savesl();
        PageReference p2 = vlan_contr.annulla();
        
        List<SelectOption> listMonoCos = vlan_contr.getItemsMonoCos();
        List<SelectOption> listMultiCos = vlan_contr.getItemsMultiCos();
        
        PO_PP_SVLan_Controller vlan_contr2 = new PO_PP_SVLan_Controller();
        vlan_contr2.cos_type = 'MultiCOS';
        vlan_contr2.cos_remarking = 'None';
        vlan_contr2.dhcp_Option82 = 'None';
        PageReference p3 = vlan_contr.savesl();
        
        Test.stopTest();
    }
}