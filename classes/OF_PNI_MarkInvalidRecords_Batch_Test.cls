@isTest
private class OF_PNI_MarkInvalidRecords_Batch_Test {

  public static OF_Staging_PNI__c createStaging(){
      
        OF_Staging_PNI__c staging = new OF_Staging_PNI__c();
        staging.OF_Source_System__c = 'PNI';
        staging.OF_Civico__c = '12';
        staging.OF_Comune__c = 'Napoli';
        staging.OF_ID_GIS_ScalaPalazzina__c = 'IDR1234';
        staging.OF_UI_Scala_Palazzina__c='12345';
        staging.OF_Id_Risorsa__c = 'IDR1234';
        staging.OF_Indirizzo__c = 'Malta';
        staging.isValid__c=true;
        staging.isElaborato__c=false;
      
        insert staging;
        
        return staging;
  }
      private static testMethod void test_batch() {
         
          Test.startTest();
            OF_Staging_PNI__c stg2 = createStaging();
    
            DataBase.executeBatch(new OF_PNI_MarkInvalidRecords_Batch());
            Test.stopTest();
            
        }

}