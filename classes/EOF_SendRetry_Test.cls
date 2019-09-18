@isTest
public class EOF_SendRetry_Test
{
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
    
    static testmethod Map<String,String> RecordType(){       
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'OF_CommercialElementIstanziato__c')  and isActive=true];
        Map<String,String> RecordType = new Map<String,String>{};
        for(RecordType rt: rtypes){
            RecordType.put(rt.Name,rt.Id);  
        }      
        return RecordType;
    }
  
    static testmethod void Method1()
    {
        Map<String,String> RecordTypeMap = RecordType();

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='test';
        tibco.name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        String ConRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
        
        con.RecordTypeId = ConRecordTypeId; //RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        List<Case> caseListNACK1 = new List<Case>();
        Map<String,Id> recordTypeMap1 = new Map<String,Id>();
        List<RecordType> allCaseTypes = [select Id, DeveloperName from RecordType where SObjectType = 'Case' ];
        for (RecordType r : allCaseTypes) 
        {
            recordTypeMap1.put(r.DeveloperName,r.Id);
        }
    
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Contact__c = con.id;
        c.status = 'Ricevuto';
        c.EOF_FASE__C = 'NA';
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c ='VF';  
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_Da_OLO__c='NACK TECNICO';
        // c.RecordTypeId = recordTypeMap1.get('OF_SA_FIberRequest');
        //caseListNACK1.add(c);
        //insert caseListNACK1;
        c.OF_OM_Nuovo_Flusso__c = True;
        insert c;
        
     
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername 
                                  from Case 
                                  where OF_Response_Da_OLO__c='NACK TECNICO' 
                                  OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2a', sch, sh1);
        
        Test.stopTest();
    }
    
    static testmethod void Method1A()
    {
        Map<String,String> RecordTypeMap = RecordType();

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='test';
        tibco.name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        String ConRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Referente Tecnico OLO').getRecordTypeId();
        
        con.RecordTypeId = ConRecordTypeId; //RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        List<Case> caseListNACK1 = new List<Case>();
        Map<String,Id> recordTypeMap1 = new Map<String,Id>();
        List<RecordType> allCaseTypes = [select Id, DeveloperName from RecordType where SObjectType = 'Case' ];
        for (RecordType r : allCaseTypes) 
        {
            recordTypeMap1.put(r.DeveloperName,r.Id);
        }
    
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Contact__c = con.id;
        c.status = 'Ricevuto';
        c.EOF_FASE__C = 'NA';
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c ='VF';  
        c.OF_Bonifica_Locked_Row__c = true;
        c.OF_Response_Da_OLO__c='NACK TECNICO';
        // c.RecordTypeId = recordTypeMap1.get('OF_SA_FIberRequest');
        //caseListNACK1.add(c);
        //insert caseListNACK1;
        c.OF_OM_Nuovo_Flusso__c = False;
        insert c;
        
     
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername 
                                  from Case 
                                  where OF_Response_Da_OLO__c='NACK TECNICO' 
                                  OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2b', sch, sh1);
        
        Test.stopTest();
    }
   
    static testmethod void Method2()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        Case c2 = new Case();
        c2.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c2.eof_account_OLO__c=accOloWIND.Id;
        c2.EOF_Contact__c = con.id;
        c2.status = 'Ricevuto';
        c2.EOF_FASE__C = 'NA';
        c2.EOF_Codice_Ordine_OLO__c='Test';
        c2.EOF_Codice_Operatore_WS__c ='VF';  
        c2.OF_Bonifica_Locked_Row__c = true;
        c2.OF_Response_Da_OLO__c='NACK TECNICO';
        insert c2;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        slFiberReq1.Caso__c = c2.id; 
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c2.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c2;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername from Case where OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2c', sch, sh1);
        Test.stopTest();
    }
    
    static testmethod void Method2A()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        Case c2 = new Case();
        c2.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c2.eof_account_OLO__c=accOloWIND.Id;
        c2.EOF_Contact__c = con.id;
        c2.status = 'Ricevuto';
        c2.EOF_FASE__C = 'NA';
        c2.EOF_Codice_Ordine_OLO__c='Test';
        c2.EOF_Codice_Operatore_WS__c ='VF';  
        c2.OF_Bonifica_Locked_Row__c = true;
        c2.OF_Response_Da_OLO__c='NACK TECNICO';
        c2.OF_OM_Nuovo_Flusso__c = True;
        insert c2;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        slFiberReq1.Caso__c = c2.id; 
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c2.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c2;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername from Case where OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2d', sch, sh1);
        Test.stopTest();
    }
    
     static testmethod void Method3A()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        Case c2 = new Case();
        c2.RecordTypeId = RecordTypeMap.get('EOF_Caso_ChangeOrder_OPENSTREAM');
        c2.eof_account_OLO__c=accOloWIND.Id;
        c2.EOF_Contact__c = con.id;
        c2.status = 'Ricevuto';
        c2.EOF_FASE__C = 'NA';
        c2.EOF_Codice_Ordine_OLO__c='Test';
        c2.EOF_Codice_Operatore_WS__c ='VF';  
        c2.OF_Bonifica_Locked_Row__c = true;
        c2.OF_Response_Da_OLO__c='NACK TECNICO';
        c2.OF_OM_Nuovo_Flusso__c = True;
        insert c2;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        slFiberReq1.Caso__c = c2.id; 
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c2.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c2;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername from Case where OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2e', sch, sh1);
        Test.stopTest();
    }
    
     static testmethod void Method4A()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        Case c2 = new Case();
        c2.RecordTypeId = RecordTypeMap.get('Trouble Ticket');
        c2.eof_account_OLO__c=accOloWIND.Id;
        c2.EOF_Contact__c = con.id;
        c2.status = 'Ricevuto';
        c2.EOF_FASE__C = 'NA';
        c2.EOF_Codice_Ordine_OLO__c='Test';
        c2.EOF_Codice_Operatore_WS__c ='VF';  
        c2.OF_Bonifica_Locked_Row__c = true;
        c2.OF_Response_Da_OLO__c='NACK TECNICO';
        c2.OF_OM_Nuovo_Flusso__c = True;
        insert c2;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        slFiberReq1.Caso__c = c2.id; 
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c2.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c2;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername from Case where OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2f', sch, sh1);
        Test.stopTest();
    }
    
    static testmethod void Method5A()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        Case c2 = new Case();
        c2.RecordTypeId = RecordTypeMap.get('PO PreProvisioning VLAN');
        c2.eof_account_OLO__c=accOloWIND.Id;
        c2.EOF_Contact__c = con.id;
        c2.status = 'Ricevuto';
        c2.EOF_FASE__C = 'NA';
        c2.EOF_Codice_Ordine_OLO__c='Test';
        c2.EOF_Codice_Operatore_WS__c ='VF';  
        c2.OF_Bonifica_Locked_Row__c = true;
        c2.OF_Response_Da_OLO__c='NACK TECNICO';
        c2.OF_OM_Nuovo_Flusso__c = True;
        insert c2;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        slFiberReq1.Caso__c = c2.id; 
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c2.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c2;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername from Case where OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2g', sch, sh1);
        Test.stopTest();
    }
    
    /*
    static testmethod void Method3()
    {
        Map<String,String> RecordTypeMap = RecordType();
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = 'Gianni';
        con.LastName = 'Bugno';
        con.Phone = '333';
        con.Email = 'test@test.it'; 
        insert con;
        
        List<Case> caseToInsert = new List<Case>();
        for(integer i=0;i<27;i++){
            Case c = new Case();
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
            c.EOF_Account_OLO__c = accOloWIND.id;
            c.EOF_Contact__c = con.id;
            c.status = 'Ricevuto';
            c.EOF_FASE__C = 'NA';
            c.EOF_Codice_Ordine_OLO__c='Test';
            c.EOF_Codice_Operatore_WS__c ='VF';  
            c.OF_Bonifica_Locked_Row__c = true;
            c.OF_Response_Da_OLO__c='NACK TECNICO';
            caseToInsert.add(c);
        }
        for(integer i=0;i<27;i++){
            Case c2 = new Case();
            c2.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
            c2.eof_account_OLO__c=accOloWIND.Id;
            c2.EOF_Contact__c = con.id;
            c2.status = 'Ricevuto';
            c2.EOF_FASE__C = 'NA';
            c2.EOF_Codice_Ordine_OLO__c='Test';
            c2.EOF_Codice_Operatore_WS__c ='VF';  
            c2.OF_Bonifica_Locked_Row__c = true;
            c2.OF_Response_Da_OLO__c='NACK TECNICO';
            caseToInsert.add(c2);
        }
        insert caseToInsert;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.Caso__c = caseToInsert[0].id;
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq1.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberNotify').getRecordTypeId();
        slFiberReq1.Caso__c = caseToInsert[0].id; 
        insert slFiberReq1;
        
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        slFiberReq2.Caso__c = caseToInsert[0].id; 
        slFiberReq2.eof_tipo_comunicazione__c='1';
        insert slFiberReq2;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq3.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq3.Caso__c = caseToInsert[0].id;        
        insert slFiberReq3;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq4 = new EOF_EAI_Service_Log__c();
        slFiberReq4.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq4.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq4.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq4.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq4;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = caseToInsert[0];
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        Test.starttest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
       
        List<Case> caseListNACK =[select Id,EOF_Codice_Ordine_OLO__C,recordtype.developername from Case where OF_Response_Da_OLO__c='NACK TECNICO' OR OF_Response_Da_OM__c='NACK TECNICO' limit 3];
        EOF_SendRetry sh1 = new EOF_SendRetry();      
        String sch = '0  00 1 3 * ?';
        system.schedule('Retry Job 2', sch, sh1);
        Test.stopTest();

    } 
    */
     
}