@isTest
public class PO_CeD_DettaglioBozze_Contr_TEST{
    
    public static testMethod void PO_CeD_DettaglioBozze_Method(){
    
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller  detail = new PO_CeD_DettaglioBozze_Controller();
        detail.idVLAN = service1.Id;
        detail.Kit='Test';
      
        detail.cessaVLAN();
        detail.modificaVLAN();
        detail.aggiungiVLAN();
        detail.changeOrder();
      
        detail.inoltraChangeOrder();
        detail.redirectRichiesteInserite();
      
        String TextProfilo='Test1';
        detail.verifyProfiloNew(TextProfilo);
        
        detail.verifyFields();
    }
        
    public static testMethod void PO_CeD_DettaglioBozze_Method1()  
    {
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        service.OF_SA_KIT_CONSEGNA_VLAN__c='t1';
        service.OF_SA_USER_VLAN__c='t1235';
          
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller detail = new PO_CeD_DettaglioBozze_Controller();
          
        detail.verifyFields();
    }
    
    public static testMethod void PO_CeD_DettaglioBozze_Method2()  
    {
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        service.OF_SA_KIT_CONSEGNA_VLAN__c='t1';
        service.OF_SA_USER_VLAN__c='t1';
        service.OF_SA_SERVICE_VLAN__c='t1234'; 
          
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller detail = new PO_CeD_DettaglioBozze_Controller();
          
        detail.verifyFields();
    }
    
    public static testMethod void PO_CeD_DettaglioBozze_Method3()  
    {
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        service.OF_SA_KIT_CONSEGNA_VLAN__c='t1';
        service.OF_SA_USER_VLAN__c='t1';
        service.OF_SA_SERVICE_VLAN__c='t1'; 
        service.OF_SA_PROFILO_VLAN__c='t12345';
          
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller detail = new PO_CeD_DettaglioBozze_Controller();
          
        detail.verifyFields();
    }
     
    public static testMethod void PO_CeD_DettaglioBozze_Method4()  
    {
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        service.OF_SA_KIT_CONSEGNA_VLAN__c='t1';
        service.OF_SA_USER_VLAN__c='t1';
        service.OF_SA_SERVICE_VLAN__c='t1'; 
        service.OF_SA_PROFILO_VLAN__c='t1';
        service.OF_SA_CUSTOMER_VLAN__c='t123456'; 
          
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller detail = new PO_CeD_DettaglioBozze_Controller();
          
        detail.verifyFields();
    }
    
    public static testMethod void PO_CeD_DettaglioBozze_Method5()  
    {
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        service.OF_SA_KIT_CONSEGNA_VLAN__c='t1';
        service.OF_SA_USER_VLAN__c='t1';
        service.OF_SA_SERVICE_VLAN__c='t1'; 
        service.OF_SA_PROFILO_VLAN__c='t1';
        service.OF_SA_CUSTOMER_VLAN__c='t1'; 
        service.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='t12345';
          
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller  detail = new PO_CeD_DettaglioBozze_Controller();
          
        detail.verifyFields();
    }
    
    public static testMethod void PO_CeD_DettaglioBozze_Method6()  
    {
        Id RecordTypeIdlis = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
            
        EOF_EAI_Service_Log__c service1 = new EOF_EAI_Service_Log__c();
        service1.OF_SA_ACK__c = True;       
        insert service1;
        
        EOF_EAI_Service_Log__c service = new EOF_EAI_Service_Log__c();
        service.OF_SA_ACK__c = True;
        service.RecordTypeId = RecordTypeIdlis;
        service.OF_SA_VLan_Log__c = service1.Id;
        service.EOF_Stato_Richiesta__c = 'Bozza Portale';
        service.OF_SA_KIT_CONSEGNA_VLAN__c='t1';
        service.OF_SA_USER_VLAN__c='t1';
        service.OF_SA_SERVICE_VLAN__c='t1'; 
        service.OF_SA_PROFILO_VLAN__c='t1';
        service.OF_SA_CUSTOMER_VLAN__c='t1'; 
        service.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='t1';
        service.OF_SA_INFORMAZIONI_VLAN__c='t12345';
          
        insert service;
        System.debug('@@@service'+service);
            
        ApexPages.currentPage().getParameters().put('idRisorsa',service1.Id);
        PO_CeD_DettaglioBozze_Controller detail = new PO_CeD_DettaglioBozze_Controller();
          
        detail.verifyFields();
    }
}