@isTest
public class PO_COMP_DetailsCh_Test{
    public static testMethod void DetailsMethod(){
        Id RecordTypeIdcas = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId(); 
        Id RecordTypeIdcom1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_CO_FiberRequest').getRecordTypeId();        

        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'Canone';
        a.AccountID = acc.Id;
        a.OF_DataAttivazione2__c = system.today();
        a.OF_DataCessazione2__c = system.today();
        a.OF_ProfiloOpenStream__c = 'test';
        insert a;
        Apexpages.currentPage().getParameters().put('origId',a.Id);
        
        case cse = new case();
        cse.status = 'Espletato';
        cse.OF_Bonifica_Locked_Row__c  = true;
        cse.RecordTypeId = RecordTypeIdcas;
        //cse.status = 'Acquisito';
        cse.EOF_Id_Risorsa__c = a.Name;
        //cse.EOF_Id_Risorsa__c = 'Test';
        cse.AssetId = a.Id;
        cse.OF_SA_ID_Building_OM__c = 'Test';
        insert cse;
        
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        insert com;
        
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_Asset__c  = a.id;
        istan.OF_CommercialElement__c = com.Id;
        istan.OF_Stato__c='Attivo';
        istan.RecordTypeId = RecordTypeIdcom;
        insert istan;
        
        EOF_EAI_Service_Log__c  service = new EOF_EAI_Service_Log__c ();
        service.OF_SA_ACK__c = True;
        service.EOF_Stato_Richiesta__c='Bozza Portale';
        service.EOF_ID_Risorsa__c = a.name;
        service.RecordTypeId = RecordTypeIdser;
        insert service;
        
        EOF_EAI_Service_Log__c  service2 = new EOF_EAI_Service_Log__c ();
        service2.OF_SA_ACK__c = True;
        service2.EOF_Stato_Richiesta__c='Bozza Portale';
        service2.EOF_ID_Risorsa__c = a.name;
        service2.RecordTypeId = RecordTypeIdcom1;
        insert service2;
        
        PO_COMP_DetailsCh comp = new PO_COMP_DetailsCh();
        //pagereference pg;
        comp.cas=cse;
        comp.IdOrder = cse.Id;
        comp.ChangeOrder();
        comp.Cessazione();
        comp.openBozza();
        
        comp.desospendi = true;
        comp.annulla = true;
        comp.rimodula = true;
        comp.IdOrder = 'Test';
        comp.ServiziAggiuntivi = true;
        comp.title = 'Test';
        
        EOF_EAI_Service_Log__c  service1 = new EOF_EAI_Service_Log__c ();
        service1.OF_SA_ACK__c = True;
        service1.EOF_ID_Risorsa__c = a.name;
        service1.RecordTypeId = RecordTypeIdser1;
        service1.OF_SA_VLan_Log__c = service.Id;
        service1.EOF_Stato_Richiesta__c='Bozza Portale';
        
        insert service1;
        comp.newBozza();
        
        
        
    }
    
}