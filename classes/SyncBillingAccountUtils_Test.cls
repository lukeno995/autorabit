@isTest
public class SyncBillingAccountUtils_Test{
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select developerName, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'EOF_Notify__c')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.developerName,rt.Id);
                
       return RecordType;
    }

     public static testMethod void test_checkField1(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('Cliente Business');
        // insert acc;
         
         //Account acc1= [select Name,DeveloperName from account];
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         SyncBillingAccountUtils.checkFields(wrp);
    }
    
    public static testMethod void test_checkField2(){
         
        
        Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'TEST';
         SyncBillingAccountUtils.checkFields(wrp);
       
         

    }
    
     public static testMethod void test_checkField3(){
         
          Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='passivo';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    }
    
    public static testMethod void test_checkField4(){
         
          Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    }
    
   public static testMethod void test_checkField5(){
         
         
          Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    }
   
    
    public static testMethod void test_checkField6(){
         
        
          Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    }
   
     public static testMethod void test_checkField7(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
         acc.TaxationCode__c=12345678;
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
    
    public static testMethod void test_checkField8(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
     public static testMethod void test_checkField9(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='';
         acc.PEC__c='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
    
    public static testMethod void test_checkField10(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 

public static testMethod void test_checkField11(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='';
         acc.BillingState='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
public static testMethod void test_checkField12(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
        
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='t';
         acc.BillingState='t';
         acc.BillingStreet='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    }
    public static testMethod void test_checkField13(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='t';
         acc.BillingState='t';
         acc.BillingStreet='t';
         acc.BillingCountry='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
    
    public static testMethod void test_checkField14(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
        
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='t';
         acc.BillingState='t';
         acc.BillingStreet='t';
        acc.BillingCountry='t';
        
         acc.Industry='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
    
    public static testMethod void test_checkField15(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='t';
         acc.BillingState='t';
         acc.BillingStreet='t';
         acc.BillingCountry='t';
         acc.Industry='t';
         acc.BillingPostalCode='12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
     public static testMethod void test_checkField16(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
        
         
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='t';
         acc.BillingState='t';
         acc.BillingStreet='t';
         acc.BillingCountry='t';
         acc.Industry='t';
         acc.BillingPostalCode='t';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         
         SyncBillingAccountUtils.checkFields(wrp);
    } 
     public static testMethod void test_createListLogA(){
         
         Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         notifica.RecordTypeId = RecordTypeMap.get('EOF_BILL_Contract');
         insert notifica;
         
         List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
         notifiche.add(notifica);
         
         List<string> errors = new List<string>();
         errors.add('Test1');
         errors.add('Test2');
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         
         SyncBillingAccountUtils.createListLog(notifiche,errors,'request','response','codice','esito','descrizione','message');
    }
   
    public static testMethod void test_createListLogB(){
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
         
         List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
         notifiche.add(notifica);
         
         List<string> errors = new List<string>();
         errors.add('Test1');
         errors.add('Test2');
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         
         SyncBillingAccountUtils.createListLog(notifiche,errors,'','response','codice','esito','descrizione','message');
    }
  /**  
    public static testMethod void test_callWSContractA(){
    
        Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         notifica.RecordTypeId = RecordTypeMap.get('EOF_BILL_Contract');
         insert notifica;
       
         Test.startTest();
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         wrp.con = contratto;
         Test.setMock(WebServiceMock.class, new OF_Billing_Outbound_Service2_mock());
         SyncBillingContractUtils.callWSContract(wrp,'');
         Test.stopTest();
    }
  
   
   public static testMethod void test_callWSContract(){
         
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         contratto.SuspendedDate__c = system.today();
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
       
         Test.startTest();
         SyncBillingContractUtils.Wrapper wrp = new SyncBillingContractUtils.Wrapper();
         Test.setMock(WebServiceMock.class, new OF_Billing_Outbound_Service2_mock());
         SyncBillingContractUtils.callWSContract(wrp,notifica.Id);
         Test.stopTest();
    } **/
   
    
    
     public static testMethod void test_createResponse(){
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         OF_Billing_Outbound_Schema.BillingAccountManagerResponsetType  res = new OF_Billing_Outbound_Schema.BillingAccountManagerResponsetType();
         SyncBillingAccountUtils.createResponse(res);
    }
    
    public static testMethod void test_createLogA(){
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica1 = new EOF_Notify__c();
         notifica1.Contract__c = contratto.Id;
         insert notifica1;
        
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         string notifica  = notifica1.id;
         SyncBillingAccountUtils.createLog(notifica,'request','response','codice','esito','descrizione','message');
    }
    
    public static testMethod void test_createLogB(){
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica1 = new EOF_Notify__c();
         notifica1.Contract__c = contratto.Id;
         insert notifica1;
        
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         string notifica  = notifica1.id;
         SyncBillingAccountUtils.createLog(notifica,'','response','codice','esito','descrizione','message');
    }
    
     public static testMethod void test_createLogC(){
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica1 = new EOF_Notify__c();
         notifica1.Contract__c = contratto.Id;
         insert notifica1;
        
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         string notifica  = notifica1.id;
         SyncBillingAccountUtils.createLog(notifica,'','','codice','esito','descrizione','message');
    }
    
   public static testMethod void test_createNotify(){
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         acc.AccountNumber='123456';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         //wrp.con = contratto;
         wrp.acc=acc;
         wrp.action='modify';
         SyncBillingAccountUtils.createNotify(wrp);
    }
    
     public static testMethod void test_createRequest(){
        
         Account acc = new Account();
         acc.Name = 'OpenFiber';
         insert acc;
        
         Contract contratto = new Contract();
         contratto.OF_IdContratto__c = 'TEST_TIS_001';
         contratto.AccountId = acc.id;
         insert contratto;
        
         EOF_Notify__c notifica = new EOF_Notify__c();
         notifica.Contract__c = contratto.Id;
         insert notifica;
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         //SyncBillingAccountUtils.Wrapper 
         SyncBillingAccountUtils.createRequest(wrp,'test','TimeStamp','Test','Test','Test','Test','Test');
    }
    
  /*   public static testMethod void test_callBatch(){
         
           Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         //acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
         SyncBillingAccountUtils.callBatch(wrp);
         
     }*/
    
    public static testMethod void test_createListNotify(){
         
           Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         //acc.RecordTypeId=RecordTypeMap.get('OLO');
        // insert acc;
         
         
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc;
         wrp.action = 'modify';
        
        List<SyncBillingAccountUtils.Wrapper> wrpsli= new List<SyncBillingAccountUtils.Wrapper>();
        wrpsli.add(wrp );
         SyncBillingAccountUtils.createListNotify(wrpsli);
         
     }
    public static testMethod void test_GetCRONExpression()
    {
         datetime dt=datetime.now();
         SyncBillingAccountUtils.GetCRONExpression(dt);
    }
    
    public static testMethod void test_callWSAccount(){
         
          Map<String,String> RecordTypeMap = RecordType();
         
         Account acc = new Account();
         acc.Name = 'OpenFiberNew';
         acc.Status__c='Attivo';
         acc.AccountNumber='test';
         acc.StartDate__c=datetime.now();
         acc.VATNumber__c='12345';
         acc.Class__c='Premium';
         
         acc.BillingEmail__c='';
         acc.PEC__c='';
         acc.BillingCity='t';
         acc.BillingState='t';
         acc.BillingStreet='t';
         acc.BillingCountry='t';
         acc.Industry='t';
         acc.BillingPostalCode='t';
         acc.EOF_Codice_Operatore__c='te';
         acc.SyncBilling__c=true;
         //String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
         acc.RecordTypeId=RecordTypeMap.get('OLO');
         
        insert acc;
        
        account acc1=[select Name,Class__c,SyncBilling__c,Status__c,AccountNumber,StartDate__c,VATNumber__c,TaxationCode__c,BillingEmail__c,PEC__c, BillingCity, BillingState,BillingStreet,BillingCountry,Industry,BillingPostalCode, EOF_Codice_Operatore__c from account];

        
         EOF_Notify__c ENF=new EOF_Notify__c();
         ENF.EOF_ID_Notifica__c='test';
         ENF.Account__c=acc1.ID;
         insert ENF;
        
         Test.startTest();
         SyncBillingAccountUtils.Wrapper wrp = new SyncBillingAccountUtils.Wrapper();
         wrp.acc=acc1;
         wrp.acc.id=acc1.id;
         wrp.action = 'modify';
         String notificaid='';
         Test.setMock(WebServiceMock.class, new SyncBillingAccountUtils_Mock());
         SyncBillingAccountUtils.callWSAccount(wrp, notificaid);
         Test.stopTest();
         
     }
}