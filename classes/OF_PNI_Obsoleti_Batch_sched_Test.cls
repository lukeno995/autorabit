@isTest
public class OF_PNI_Obsoleti_Batch_sched_Test {
    
    
    
    
    
    public static testMethod void Obsoleti_Batch_schedTestMethod() {
        
        
        Verticali__c cs = new Verticali__c();
        cs.Name = 'test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Delivery Services Openfiber';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';

        insert cs;
        
        
        DateTime jobAlgoritmo = System.now().addMinutes(1);
        String hour = String.valueOf(jobAlgoritmo.hour());
        String min = String.valueOf(jobAlgoritmo.minute()); 
        String ss = String.valueOf(jobAlgoritmo.second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        Test.startTest();
        OF_PNI_Obsoleti_Batch_sched t1 = new OF_PNI_Obsoleti_Batch_sched();
        system.schedule('test 01', nextFireTime, t1);
        Test.stopTest();
        
    }
    
    public static testMethod void BonificaAssetVerticali_schedTestMethod() {
        
        Verticali__c cs = new Verticali__c();
        cs.Name = 'test';
        cs.delayAlgoritmo__c = 1;
        cs.delayBonifica__c = 240;
        cs.Email__c = 'test@test.org';
        cs.Email_CC__c = 'test@test.org';
        cs.Email_from__c = 'Delivery Services Openfiber';
        cs.emailSubject__c = 'subj';
        cs.giorniTolleranza__c = -2;
        cs.limitBatch__c = 10;
        cs.TextBody__c = 'text';

        insert cs;
        
        DateTime jobAlgoritmo = System.now().addMinutes(1);
        String hour = String.valueOf(jobAlgoritmo.hour());
        String min = String.valueOf(jobAlgoritmo.minute()); 
        String ss = String.valueOf(jobAlgoritmo.second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        Test.startTest();
        OF_PNI_BonificaAssetVerticali_sched t2 = new OF_PNI_BonificaAssetVerticali_sched();
        system.schedule('test 02', nextFireTime, t2);
        Test.stopTest();
        
    }
}