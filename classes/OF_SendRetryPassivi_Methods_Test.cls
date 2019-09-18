@isTest
public class OF_SendRetryPassivi_Methods_Test{

     
        
    static testmethod Map<String,String> RecordType(){ 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'OF_commercialElementIstanziato__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
    
    for(RecordType rt: rtypes)
        RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
    public static testmethod void retryCalloutOLOOMMethod(){
    
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_Puntamento_Callout__c pc = new OF_Puntamento_Callout__c();
        pc.OF_OGW__c='OFS-WS-SVIL';
        pc.name='test';
        insert pc;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c enp = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        enp.Name= 'Status';
        enp.OF_Enable_Trigger__c = false;
        insert enp; 

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
        
      String recname = [SELECT ID,developerName from recordtype WHERE developerName =: 'FiberNotify' LIMIT 1].developername;
         String recid = [SELECT ID,developerName from recordtype WHERE developerName =: 'FiberNotify' LIMIT 1].id;
        //String recname1 = [SELECT ID,developerName from recordtype WHERE developerName =: 'EOF_Caso_Attivazione' LIMIT 1].developername;
      
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        insert accOloWIND;
        
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Ordine_Olo__c = 'Test';
        c.EOF_Order_Manager__c = true;
        //c.OF_Bonifica_Locked_Row__c = true;
         
        //c.EOF_Contact__c = null;
        //c.status = 'Accettato';
        
        c.EOF_FASE__C = 'NA';
        insert c;
        
        
    
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.EOF_Codice_Operatore__c = 'Test';
        eof.EOF_Tipo_comunicazione_string__c ='test';
        eof.EOF_Tipo_Comunicazione__c = 'Test';
        eof.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_Olo__c;
        eof.EOF_Codice_Ordine_EOF__c = 'Test';
        eof.EOF_ID_Notifica__c = 'Test';
        eof.EOF_Stato_Richiesta__c = 'Test';
        eof.EOF_Cod_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof.EOF_Mot_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof.EOF_Data_Notifica__c = System.today();
        eof.Caso__c = c.id;
        eof.recordtypeId = recid;
        insert eof;
        
        EOF_EAI_Service_Log__c eof2 = new EOF_EAI_Service_Log__c();
        eof2.EOF_Codice_Operatore__c = 'Test';
        eof2.EOF_Tipo_Comunicazione__c = '1';
        eof2.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_Olo__c;
        eof2.EOF_Codice_Ordine_EOF__c = 'Test';
        eof2.EOF_ID_Notifica__c = 'Test';
        eof2.EOF_Stato_Richiesta__c = 'Test';
        eof2.EOF_Cod_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof2.EOF_Mot_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof2.EOF_Data_Notifica__c = System.today();
        eof2.Caso__c = c.id;
        eof2.recordtypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        insert eof2;
        
       OM_GW_GE_Utils.caseOriginale = c;
       
       test.startTest();
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       OF_SendRetryPassivi_Methods.retryCalloutOLOOM(c.Id,recname,'test');
      test.stopTest();
        
    }
    
    public static testmethod void retryCalloutOLOOMMethod1(){
    
        Map<String,String> RecordTypeMap = RecordType();
        
        OF_Puntamento_Callout__c pc = new OF_Puntamento_Callout__c();
        pc.OF_OGW__c='OFS-WS-SVIL';
        pc.name='test';
        insert pc;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c enp = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        enp.Name= 'Status';
        enp.OF_Enable_Trigger__c = false;
        insert enp; 

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        

        
        
      String recname = [SELECT ID,developerName from recordtype WHERE developerName =: 'FiberNotify' LIMIT 1].developername;
         String recid = [SELECT ID,developerName from recordtype WHERE developerName =: 'FiberNotify' LIMIT 1].id;
        //String recname1 = [SELECT ID,developerName from recordtype WHERE developerName =: 'EOF_Caso_Attivazione' LIMIT 1].developername;
      
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        insert accOloWIND;
        
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Ordine_Olo__c = 'Test';
        c.EOF_Order_Manager__c = true;
        //c.OF_Bonifica_Locked_Row__c = true;
         
        //c.EOF_Contact__c = null;
        //c.status = 'Accettato';
        
        c.EOF_FASE__C = 'NA';
        
        insert c;
    
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.EOF_Codice_Operatore__c = 'Test';
        eof.EOF_Tipo_Comunicazione__c = 'Test';
        eof.EOF_Tipo_comunicazione_string__c ='test';        
        eof.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_Olo__c;
        eof.EOF_Codice_Ordine_EOF__c = 'Test';
        eof.EOF_ID_Notifica__c = 'Test';
        eof.EOF_Stato_Richiesta__c = 'Test';
        eof.EOF_Cod_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof.EOF_Mot_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof.EOF_Data_Notifica__c = System.today();
        eof.Caso__c = c.id;
        eof.recordtypeId = recid;
        insert eof;
        
        EOF_EAI_Service_Log__c eof2 = new EOF_EAI_Service_Log__c();
        eof2.EOF_Codice_Operatore__c = 'Test';
        eof2.EOF_Tipo_Comunicazione__c = '1';
        eof2.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_Olo__c;
        eof2.EOF_Codice_Ordine_EOF__c = 'Test';
        eof2.EOF_ID_Notifica__c = 'Test';
        eof2.EOF_Stato_Richiesta__c = 'Test';
        eof2.EOF_Cod_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof2.EOF_Mot_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof2.EOF_Data_Notifica__c = System.today();
        eof2.Caso__c = c.id;
        eof2.recordtypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eof2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - Test';
        insert eof2;
        
       OM_GW_GE_Utils.caseOriginale = c;
      
		test.startTest();
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       OF_SendRetryPassivi_Methods.retryCalloutOLOOM(c.Id,'EOF_Caso_Attivazione','test');
       test.stopTest(); 
    }
    
    public static testmethod void retryCalloutOLOOMMethod2(){
    
        Map<String,String> RecordTypeMap = RecordType();
        
        
        OF_Puntamento_Callout__c pc = new OF_Puntamento_Callout__c();
        pc.OF_OGW__c='OFS-WS-SVIL';
        pc.name='test';
        insert pc;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c enp = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        enp.Name= 'Status';
        enp.OF_Enable_Trigger__c = false;
        insert enp; 

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        

            
        OM_GW_GE_Utils.testNackTecnicoOM=true;
        OM_GW_GE_Utils.testNackTecnicoOLO=true;
        
      String recname = [SELECT ID,developerName from recordtype WHERE developerName =: 'FiberRequest' LIMIT 1].developername;
         String recid = [SELECT ID,developerName from recordtype WHERE developerName =: 'FiberRequest' LIMIT 1].id;
        //String recname1 = [SELECT ID,developerName from recordtype WHERE developerName =: 'EOF_Caso_Attivazione' LIMIT 1].developername;
      
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Tiscali';
        accOloWIND.EOF_Codice_Operatore__c = 'TIS';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');
        insert accOloWIND;
        
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Codice_Ordine_Olo__c = 'Test';
        c.EOF_Order_Manager__c = true;
        //c.OF_Bonifica_Locked_Row__c = true;
         
        //c.EOF_Contact__c = null;
        //c.status = 'Accettato';
        c.OF_Response_Da_OM__c ='NACK TECNICO';
        c.EOF_FASE__C = 'NA';
        insert c;
    
        EOF_EAI_Service_Log__c eof = new EOF_EAI_Service_Log__c();
        eof.EOF_Codice_Operatore__c = 'Test';
        eof.EOF_Tipo_Comunicazione__c = 'Test';
        eof.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_Olo__c;
        eof.EOF_Codice_Ordine_EOF__c = 'Test';
        eof.EOF_ID_Notifica__c = 'Test';
        eof.EOF_Stato_Richiesta__c = 'Test';
        eof.EOF_Cod_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof.EOF_Mot_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof.EOF_Data_Notifica__c = System.today();
        eof.Caso__c = c.id;
        eof.recordtypeId = recid;
        insert eof;
        
        EOF_EAI_Service_Log__c eof2 = new EOF_EAI_Service_Log__c();
        eof2.EOF_Codice_Operatore__c = 'Test';
        eof2.EOF_Tipo_Comunicazione__c = '1';
        eof2.EOF_Codice_Ordine_OLO__c = c.EOF_Codice_Ordine_Olo__c;
        eof2.EOF_Codice_Ordine_EOF__c = 'Test';
        eof2.EOF_ID_Notifica__c = 'Test';
        eof2.EOF_Stato_Richiesta__c = 'Test';
        eof2.EOF_Cod_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof2.EOF_Mot_Rifiuto_Sospensione_Annullamento__c = 'Test';
        eof2.EOF_Data_Notifica__c = System.today();
        eof2.Caso__c = c.id;
        eof2.recordtypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        eof2.EOF_Tipo_Comunicazione_String__c = 'SF->OM - Test';
        insert eof2;
        
       OM_GW_GE_Utils.caseOriginale = c;
       
       test.startTest();
		Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
       OF_SendRetryPassivi_Methods.retryCalloutOLOOM(c.Id,recname,'test');
      // OF_SendRetryPassivi_Methods.retryCalloutOLOOM(c.Id,'EOF_Caso_Attivazione','test');
       test.stopTest();
    }

    
}