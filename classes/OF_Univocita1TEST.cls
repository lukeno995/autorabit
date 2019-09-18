@isTest
public class OF_Univocita1TEST {
    
    /**Questo metodo crea i Dati da utilizzare nella Classe di Test**/
    @testSetup
    static void createData()
    {
        List<OF_Servizio__c> servList = new List<OF_Servizio__c>();
        servList = OF_AreaGeograficaUtilityTest.CreateServizi();
		
        List<OF_CommercialElement__c> CommElem = new List<OF_CommercialElement__c>();
        CommElem = OF_AreaGeograficaUtilityTest.createCommercialElement(servList);
        
        List<OF_BillingElement__c> BillElem = new List<OF_BillingElement__c>();
        BillElem = OF_AreaGeograficaUtilityTest.createBillingElement(CommElem);
    }
    
    /**Questo metodo testa il Trigger OF_UnivocitaBillingElement**/
    static testmethod void testOF_UnivocitaBillingElement()
    {   
        List<OF_CommercialElement__c> listCommElem = [select Name,OF_Attivo__c, OF_DataInizioValidita__c,OF_DataFineValidita__c from OF_CommercialElement__c];
                
        OF_BillingElement__c billElem = new OF_BillingElement__c();
        billElem.name = 'BillingElement';
        billElem.OF_Attivo__c = true;
        billElem.OF_CommercialElement__c = listCommElem[0].id;
        billElem.OF_DataInizioValidita__c =  Date.newInstance(2016,1,1);
        billElem.OF_DataFineValidita__c = Date.newInstance(2016,12,31);        
        insert billElem;
        
        OF_BillingElement__c billElem1 = new OF_BillingElement__c();
        billElem1.name = 'BillingElement';
        billElem1.OF_Attivo__c = true;
        billElem1.OF_CommercialElement__c = listCommElem[0].id;
        billElem1.OF_DataInizioValidita__c =  Date.newInstance(2016,1,1);
        billElem1.OF_DataFineValidita__c = Date.newInstance(2016,12,31);
        try{
        	insert billElem1;
        }catch(Exception ex)
        {
            String err2 = 'Il billing element ' + billElem1.name + ' è già associato al commercial element'+ billElem1.OF_CommercialElement__r.name;
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
        
        OF_BillingElement__c billElem2 = new OF_BillingElement__c();
        billElem2.name = 'BillingElement1';
        billElem2.OF_Attivo__c = true;
        billElem2.OF_CommercialElement__c = listCommElem[0].id;
        billElem2.OF_DataInizioValidita__c =  Date.newInstance(2016,1,1);
        billElem2.OF_DataFineValidita__c = Date.newInstance(2016,12,31);
        insert billElem2;
        
        billElem2.name = 'BillingElement';
        
        try{
        	update billElem2;
        }catch(Exception ex)
        {
            String err2 = 'Il billing element ' + billElem1.name + ' è già associato al commercial element'+ billElem1.OF_CommercialElement__r.name;
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
    	
    }
    
    /**Questo metodo testa il Trigger OF_UnivocitaCommercialElement**/
    static testmethod void testOF_UnivocitaCommercialElement()
    {   
        List<OF_Servizio__c> listServ = [select Name,OF_Attivo__c, OF_DataInizioValidita__c,OF_DataFineValidita__c from OF_servizio__c];
                
        OF_CommercialElement__c CommElem = new OF_CommercialElement__c();
        CommElem.name = 'CommercialElement';
        CommElem.OF_Attivo__c = true;
        CommElem.OF_Servizio__c = listServ[0].id;
        CommElem.OF_DataInizioValidita__c =  Date.newInstance(2016,1,1);
        CommElem.OF_DataFineValidita__c = Date.newInstance(2016,12,31);        
        insert CommElem;
        
        OF_CommercialElement__c CommElem1 = new OF_CommercialElement__c();
        CommElem1.name = 'CommercialElement';
        CommElem1.OF_Attivo__c = true;
        CommElem1.OF_Servizio__c = listServ[0].id;
        CommElem1.OF_DataInizioValidita__c =  Date.newInstance(2016,1,1);
        CommElem1.OF_DataFineValidita__c = Date.newInstance(2016,12,31);

        try{
        	insert CommElem1;
        }catch(Exception ex)
        {
            String err2 = 'Il commercial element ' + CommElem1.name + ' è già associato al servizio'+ CommElem1.OF_Servizio__r.name;
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
        
        OF_CommercialElement__c commElem2 = new OF_CommercialElement__c();
        commElem2.name = 'CommercialElement1';
        commElem2.OF_Attivo__c = true;
        commElem2.OF_Servizio__c = listServ[0].id;
        commElem2.OF_DataInizioValidita__c =  Date.newInstance(2016,1,1);
        commElem2.OF_DataFineValidita__c = Date.newInstance(2016,12,31);
        insert commElem2;
        
        commElem2.name = 'CommercialElement';
        
        try{
        	update commElem2;
        }catch(Exception ex)
        {
            String err2 = 'Il commercial element ' + commElem1.name + ' è già associato al servizio'+ commElem1.OF_servizio__r.name;
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
    	
    }
	
	/**Questo metodo testa il Trigger OF_UnivocitaCatalogoCommerciale**/
    static testmethod void testOF_UnivocitaCatalogoCommerciale()
    {   
		OF_CatalogoCommerciale__c catalogo1 = new OF_CatalogoCommerciale__c();
		catalogo1.Name = 'Catalogo 1';
		catalogo1.OF_Attivo__c = true;
		catalogo1.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
		catalogo1.OF_DataFineValidita__c = Date.newInstance(2016,12,31);
		try{
        	insert catalogo1;
        }catch(Exception ex)
        {
            String err2 = 'Il catalogo commerciale è già esistente';
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
		
		OF_CatalogoCommerciale__c catalogo2 = new OF_CatalogoCommerciale__c();		
		catalogo2.Name = 'Catalogo 2';
		catalogo2.OF_Attivo__c = true;
		catalogo2.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
		catalogo2.OF_DataFineValidita__c = Date.newInstance(2016,12,31);
		insert catalogo2;
		
		catalogo2.name = 'Catalogo 1';
		
		try{
        	update catalogo2;
        }catch(Exception ex)
        {
            String err2 = 'Il catalogo commerciale è già esistente';
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
    	
    }
}