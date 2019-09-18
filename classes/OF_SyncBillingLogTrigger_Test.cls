@isTest
public class OF_SyncBillingLogTrigger_Test {
    
    public static testMethod void testOne(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> RecordTypes = new Map<String,String>{};
            for(RecordType rt: rtypes)
            RecordTypes.put(rt.Name,rt.Id);
        
        test.starttest();
        
        EOF_Notify__c notifica = new EOF_Notify__c();
        insert notifica;
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.RecordTypeId = RecordTypes.get('BILL To SF');
        slFiberReq.Notify__c = notifica.Id;
        slFiberReq.EOF_CODICE_MOTIVAZIONE__c = 'A02';
        insert slFiberReq;
        
        test.stopTest();
        
    }
    
    public static testMethod void testTwo(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> RecordTypes = new Map<String,String>{};
            for(RecordType rt: rtypes)
            RecordTypes.put(rt.Name,rt.Id);
        
        test.starttest();
        
        //CronTrigger ctr = new CronTrigger();
        //ctr.CronJobDetailId
        
        EOF_Notify__c notifica = new EOF_Notify__c();
        insert notifica;
        
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.RecordTypeId = RecordTypes.get('Nack Billing');
        slFiberReq.Notify__c = notifica.Id;
        slFiberReq.EOF_CODICE_MOTIVAZIONE__c = 'A02';
        insert slFiberReq;
        
        test.stopTest();
        
    }
    
    
    public static testMethod void testThree(){
        
        List<RecordType> rtypes = [Select Name, Id From RecordType 
                                   where sObjectType='EOF_EAI_Service_Log__c' and isActive=true];
        
        Map<String,String> RecordTypes = new Map<String,String>{};
            for(RecordType rt: rtypes)
            RecordTypes.put(rt.Name,rt.Id);
        
        test.starttest();
        
        //CronTrigger ctr = new CronTrigger();
        //ctr.CronJobDetailId
        
                
        EOF_Notify__c notifica = new EOF_Notify__c();
        notifica.EOF_ID_Notifica__c='_Test';
        insert notifica;
        

        List<EOF_EAI_Service_Log__c> logs = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.RecordTypeId = RecordTypes.get('BILL To SF');
        slFiberReq.Notify__c = notifica.Id;
        slFiberReq.EOF_CODICE_MOTIVAZIONE__c = 'A02';
        logs.add(slFiberReq);
        
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.RecordTypeId = RecordTypes.get('BILL To SF');
        slFiberReq2.Notify__c = notifica.Id;
        slFiberReq2.EOF_CODICE_MOTIVAZIONE__c = 'A03';
        logs.add(slFiberReq2);
        
        insert logs;
        
        test.stopTest();
        
    }
    
    
}