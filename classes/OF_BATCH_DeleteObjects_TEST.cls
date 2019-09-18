@isTest
private class OF_BATCH_DeleteObjects_TEST {

    static testMethod void myUnitTest() {
        Objects_Delete__c myCustomValues = new Objects_Delete__c();
        myCustomValues.name='001';
        myCustomValues.Nome_Oggetto__c='EOF_EAI_Service_Log__c';
        myCustomValues.DateTime_Check_Field__c='EOF_Data_Notifica__c';
        myCustomValues.OF_Delete_Records_Before__c='2018-01-01T02:00:00.000z';
        myCustomValues.OF_Record_Limit__c='50000';
        insert myCustomValues;
        EOF_EAI_Service_Log__c slog = new EOF_EAI_Service_Log__c();
        slog.EOF_Data_Notifica__c=Datetime.newInstance(2000,01,01,00,00,00);
        insert slog;
        test.startTest();
        OF_BATCH_SCHEDULE_DeleteObjects sr = new OF_BATCH_SCHEDULE_DeleteObjects();       
        DateTime next_run = system.now().addMinutes(1);        
        String sch = '0 ' + next_run.minute() + ' * * * ?';
        String jobID = system.schedule('Merge Job Test', sch, sr);
        test.stopTest();
    }
}