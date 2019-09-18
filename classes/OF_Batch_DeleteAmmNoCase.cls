global class OF_Batch_DeleteAmmNoCase implements Database.Batchable<sObject>, Database.Stateful{
   public String query;
   public List<String> email; 
   public Integer recordDeletedSize;  
 
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
      recordDeletedSize=scope.size();
      delete scope;
      DataBase.emptyRecycleBin(scope);
   }

   global void finish(Database.BatchableContext BC){
   		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(email);
		mail.setReplyTo('germano.capoccia@enel.com');
		mail.setSenderDisplayName('Batch Processing');
		mail.setSubject('Batch Process Completed');
		mail.setPlainTextBody('Batch Process has completed, the batch processed '+recordDeletedSize+' records.');
		Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

		if (results[0].success) {
			TEMPLOG__c t = new TEMPLOG__c();
			t.name='Send Email Success';
			insert t;
		} else {
			TEMPLOG__c t = new TEMPLOG__c();
			t.name='Send Email Error';
			t.Desc__c=results[0].errors[0].message;
			insert t;
		}
   }
}