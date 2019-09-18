global class PO_BatchAssetFattibil implements Database.Batchable<sObject>, Database.Stateful{
     
    @testvisible private Map<String,String> mapRT = getRecordTypeMap();
    @testvisible private List<Task> taskToInsert = new List<Task>();
    private String queryToDO='';
     @testvisible private String queryToDO1 = 'SELECT Id,Name,Status,OF_DataAttivazione2__c,OF_Rinnovabile__c,OF_DataScadenza__c,'+
                                    ' FROM ASSET'+
                                    ' WHERE Recordtype.DeveloperName = \'P2P\' OR ' +
                                    '      Recordtype.DeveloperName = \'Fiber_Link\' OR '+
                                    '      Recordtype.DeveloperName = \'Fiber_Lease\' ';
                                    
    
    @testvisible  private String queryToDOTest = 'SELECT Id,Name,Description,OF_Rinnovabile__c,OF_DataScadenza__c,OF_DataSospensione__c,Status,'+
                                   '(SELECT Id,IsActive FROM Price_Book_Entries__r ),'+
                                   '(SELECT Id,Status FROM Tasks),'+
                                   '(SELECT Id,OF_Stato__c,OF_DataSospensione__c FROM Commercial_element_istanziati__r)'+' FROM Asset '+
                                    ' WHERE Recordtype.DeveloperName = \'P2P\' OR '+
                                    '      Recordtype.DeveloperName = \'Fiber_Link\' OR '+
                                    '      Recordtype.DeveloperName = \'Fiber_Lease\' ';
                                    
                                    
                                    
    private Set<Id> IDTasks = new Set<Id>();
  
    //Costruttore
    global PO_BatchAssetFattibil(Integer param)
    {
        if( param == 0){
            queryToDO = queryToDO1;
        }
        if( param == 1){
            queryToDO = queryToDOTest;
            System.debug('@@@@'+queryToDO);
        }
    }
    
    
    //start Inizializzazione Record
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(queryToDO);
    }
    global void execute(Database.BatchableContext BC, List<Asset> scope)
    {
        try{
              AsyncApexJob job = [ SELECT Id,ApexClass.Name,CompletedDate,JobType,NumberOfErrors,
                                           JobItemsProcessed,TotalJobItems,CreatedBy.Email,
                                           CreatedBy.Name,createddate 
                                    FROM AsyncApexJob
                                    WHERE Id =: BC.getJobId() ];
               
              system.debug('OSCRM OF_BatchAssetFattibil scope: ' + scope);
               
              checkAssetToElaborate( scope );
               
              for( Task t : taskToInsert )
               {
                   IDTasks.add( t.Id );
               }
             
            }catch(Exception e){
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_BatchImportCSVServiziExtra',
                     'Method: execute',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                return;
           }
    }
    global void finish(Database.BatchableContext BC){
         AsyncApexJob job = [SELECT Id,ApexClass.Name,CompletedDate,JobType,NumberOfErrors,
                                           JobItemsProcessed,TotalJobItems,CreatedBy.Email,
                                           CreatedBy.Name,createddate 
                                    FROM AsyncApexJob
                                    WHERE Id =: BC.getJobId()];
        sendEmailScarti( job , '' , job.JobItemsProcessed );
        
        
    }
    
    @testvisible  private void sendEmailScarti( AsyncApexJob job,String NomeFile,Integer numeroRecordProcessati)
    {
        try{
            
            if( taskToInsert.size() > 0 )
            {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                 // String[] toAddresses = new String[]{'marianna.iacobucci@atos.net'};
                String[] toAddresses = new String[]{'orlando.sinademaj@outlook.it'};
                mail.setToAddresses(toAddresses);
                //mail.setSubject('Caricamento file: ' + NomeFile );
                mail.setSubject('Gestione Task:');
                /**
                String PlainTextBody = 'NomeFileCaricato : '+NomeFile+'\n'+
                                       'Totale Record Processati : ' +numeroRecordProcessati+'\n'+
                                       'Job ID : '+job.Id+'\n'+
                                       //'Classe : '+job.ApexClass.Name+'\n'+
                                       'Data Creazione Processo : '+job.createddate+'\n'+
                                       'Data Completamento Processo : '+job.CompletedDate+'\n'+
                                       'Processo lanciato da : ' +job.CreatedBy.Name+' email: '+job.CreatedBy.Email+'\n';
                **/
                String urls = ''; 
                for( ID taskIds : IDTasks )
                {
                      urls += 'cs84.salesforce.com/'+taskIds+'\n';     
                }
                String PlainTextBody = 'Di seguito i link dei task da gestire:'+'\n'+urls;
                mail.setPlainTextBody(PlainTextBody);
                Messaging.sendEmail( new Messaging.SingleEmailMessage[] { mail } );
             }
         }catch(Exception e){
                    
                     OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilityServiziImport',
                     'Method: sendEmailScarti',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );       
                return;
           }
    }
    private Map<String,String> getRecordTypeMap()
    {
      List<RecordType> rtypes = [Select DeveloperName, Id 
                                 From RecordType 
                                 where ( ( sObjectType='Asset' OR sObjectType = 'Task' ) and isActive=true )
                                 ];
    
      Map<String,String> RecordType = new Map<String,String>{};
      for(RecordType rt: rtypes)
      RecordType.put(rt.DeveloperName,rt.Id);
      
      return RecordType;
    } 
         
   @testvisible private void checkAssetToElaborate(List<Asset> listaAsset)
    {
         List<Asset> assetToUpdate = new List<Asset>();
         List<PriceBookEntry> listaPBE = new List<PriceBookEntry>();
         List<OF_CommercialElementIstanziato__c> listaCE = new List<OF_CommercialElementIstanziato__c>();
         Datetime dt;
         
         User u = [SELECT id,UserRole.DeveloperName,name 
                   FROM user 
                   WHERE UserRole.DeveloperName = 'PO_Supporto_Vendite_Fittizio' LIMIT 1];
         
         Integer index = 0;
         for( Asset ass : listaAsset )
             
            {
                system.debug('$$$$'+ass.Price_Book_Entries__r);
                if( ass.OF_Rinnovabile__c == false && ass.OF_DataScadenza__c != null)
                {
                     string str = string.valueof( system.today() );
                     string str1 = str + ' ' + '00:00:00';
                     dt = DateTime.valueof(str1);
                    
                     system.debug('Date.today()[index'+index+']:'+Date.today() );
                     system.debug('ass.OF_DataScadenza__c[index'+index+']:'+ass.OF_DataScadenza__c );

                     Integer numberDaysDue = Date.today().daysBetween( ass.OF_DataScadenza__c );
                     system.debug('numberDaysDue[index'+index+']:'+numberDaysDue );
                     //Giorno Attuale = Giorno di Scadenza
                     if( numberDaysDue == 0 )
                     {
                         List<PriceBookEntry> listPBE = ass.Price_Book_Entries__r;
                         system.debug('RAJi'+listPBE);
                         List<OF_CommercialElementIstanziato__c> listCE = ass.Commercial_element_istanziati__r;

                         ass.Description = 'test2';
                         ass.Status = 'Sospeso';
                         //ass.PO_DataSospensione__c = Date.today();
                         //ass.OF_DataSospensione__c = dt;
                         ass.OF_DataSospensione__c = System.Datetime.now();
                         assetToUpdate.add(ass);
                         
                         if( listPBE != null )
                         {
                            for( PriceBookEntry pb : listPBE )
                            {
                                pb.isActive = false;
                                //pb.OF_DataSospensione__c = System.Datetime.now();
                                //pb.OF_DataSospensione__c = dt;
                                pb.OF_DataSospensione__c = System.Datetime.now();
                                listaPBE.add(pb);
                            }
                         }
                         
                         if( listCe != null )
                         {
                           for( OF_CommercialElementIstanziato__c ceIst : listCE )
                           {
                             ceIst.OF_Stato__c = 'Sospeso';
                             //ceIst.OF_DataSospensione__c = System.Datetime.now();
                             ceIst.OF_DataSospensione__c = System.Datetime.now();
                             listaCE.add( ceIst );
                           }
                         }
                      } 
                     //Mancano 3 giorni dalla scandeza
                     System.debug('@@@'+numberDaysDue);
                     if( numberDaysDue == 3 )
                     {
                          List<Task> taskList = ass.Tasks;
                          boolean checkTaskNotStarted = false;
                             
                          if( taskList != null )
                          {
                              for( Task t : taskList )
                              {
                                 if( t.Status == 'Not Started' )
                                 {
                                      checkTaskNotStarted = true;
                                      break;
                                  }
                               }
                           }
                          system.debug('checkTaskNoTsTARTED:'+ checkTaskNotStarted );     
                          if( !checkTaskNotStarted )
                          {    
                                 Task taskObj = new Task();
                                 taskObj.OwnerId = u.Id;
                                 taskObj.WhatId = ass.Id;
                                 taskObj.Subject = 'Gestione Asset '+ass.Name; 
                                 taskObj.ReminderDateTime = system.now();
                                 taskObj.Data_Appuntamento__c = system.today();
                                 taskObj.RecordTypeId = mapRT.get('PO_Fattibilit');
                                 taskToInsert.add( taskObj ); 
                              System.debug('@@@'+taskToInsert[0].RecordTypeId);
                           }
                      }
                         
                     
                  }
                index++;
              }
          
               
               //system.debug('PO_BatchAssetFattibil method:checkAssetToElaborate taskToInsert:'+taskToInsert+'assetToUpdate:'+assetToUpdate+'listaPBE:'+listaPBE );
               system.debug('PO_BatchAssetFattibil method:checkAssetToElaborate taskToInsert:'+taskToInsert );
               if( taskToInsert.size() > 0 ) insert taskToInsert;
               if( assetToUpdate.size() > 0 ) update assetToUpdate;
               if( listaPBE.size() > 0 ) update listaPBE; 
               if( listaCE.size() > 0 ) update listaCE;
    }


}