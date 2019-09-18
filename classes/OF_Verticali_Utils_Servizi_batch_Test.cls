@isTest
public class OF_Verticali_Utils_Servizi_batch_Test{
    @testSetup 
    public static void testSetUpData() {
    Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
    Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
    Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    
    }
    public static testMethod void batchMethod(){
        Account acc = new account();
        acc.name = 'Test';
        insert acc;
        
        List<Case> cseList = new List<Case>();
        Case cse = new Case();
        cse.Status = 'Acquisito';
        //cse.OF_Order__c = ord.id;
        cse.ID_GIS_SCALA_PALAZZINA__c = 'Test';
        cse.EOF_Account_OLO__c = acc.Id;
        cseList.add(cse);
        insert cseList;
        
        Order ord = new Order();         
        ord.accountId=acc.Id;
        ord.status='Aperto';
        ord.EffectiveDate=system.today();
        ord.OF_Comune__c='Test';
        ord.OF_CaseID__c = cseList[0].id;
        insert ord;
        
        
        
        OF_Asset_Verticale__c ver = new OF_Asset_Verticale__c();
        ver.Name = 'Test';
        ver.ID_GIS_Scala_Palazzina__c = 'Test';
        insert ver;
        
        OF_Billing_Element_Verticale__c billver = new OF_Billing_Element_Verticale__c();
        billver.Name = 'Test';
        billver.Asset_Verticale__c = ver.Id;
        billver.OLO__c = acc.Id;
        insert billver;
       
        Test.startTest();
        OF_Verticali_Utils_Servizi_batch  verutil = new OF_Verticali_Utils_Servizi_batch(cseList[0].id);
        verutil.createAssetVerticale(cseList);
        verutil.createBEVerticale(cseList,ver,ord);
        DataBase.executeBatch(verutil); 
        Test.stopTest();
    
    }
    public static testMethod void batchMethod1(){
        Account acc = new account();
        acc.name = 'Test';
        insert acc;
        
        List<Case> cseList = new List<Case>();
        Case cse = new Case();
        cse.Status = 'Acquisito';
        //cse.OF_Order__c = ord.id;
        cse.ID_GIS_SCALA_PALAZZINA__c = 'Test';
        cse.EOF_Account_OLO__c = acc.Id;
        cseList.add(cse);
        insert cseList;
        
        Order ord = new Order();         
        ord.accountId=acc.Id;
        ord.status='Aperto';
        ord.EffectiveDate=system.today();
        ord.OF_Comune__c='Test';
        ord.OF_CaseID__c = cseList[0].id;
        insert ord;
        
        
        Test.startTest();
        OF_Verticali_Utils_Servizi_batch  verutil = new OF_Verticali_Utils_Servizi_batch(cseList[0].id);
        verutil.createAssetVerticale(cseList);
        Test.stopTest();
    
    }
}