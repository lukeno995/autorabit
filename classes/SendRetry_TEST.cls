@isTest
public class SendRetry_TEST{
    
   public static String CRON_EXP = '0 0 0 15 3 ?';

   @isTest
   public static void testRetry(){
      insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS'); 

      Case c = new Case();
      c.EOF_Order_Manager__c=false;
      insert c;
      
      
      EOF_Notify__c n = new EOF_Notify__c();     
      n.Caso__c=c.Id;
      n.updated__C=true;
      n.EOF_Data_Notifica__c=datetime.now();
      insert n;
      
      recordtype rt = [select Id from recordtype where recordtype.name='NACK'];
      EOF_EAI_Service_log__c sl = new EOF_EAI_Service_log__c();
      sl.recordtypeId = rt.Id;
      sl.Notify__c=n.ID;
      sl.EOF_Codice_errore__c='A_K8';
      insert sl;
      
      
      Datetime dt= Datetime.now().addMinutes(-30);
      System.Test.setCreatedDate(n.Id, dt);
      
      System.Test.startTest();
      System.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
      // Schedule the test job
      String jobId = System.schedule('Retry Job', CRON_EXP, new SendRetry());
       
      System.Test.stopTest(); 
   }
    
}