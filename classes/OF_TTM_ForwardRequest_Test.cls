@isTest
global class OF_TTM_ForwardRequest_Test {  
     global static testmethod void Metodo1(){
        
        OF_Puntamento_Callout__c pointC = new OF_Puntamento_Callout__c();
        pointC.name = 'OGW';
        pointC.OF_OGW__c ='OFS-SVIL-WS';
        insert pointC;
       
         Test.startTest();
         OF_TTM_ForwardRequest ob1 =new OF_TTM_ForwardRequest();
		 OF_TTM_ForwardRequest.SyncPortTypeEndpoint1 ob2= new  OF_TTM_ForwardRequest.SyncPortTypeEndpoint1();
        
         
         //insert listCustomSett;
        
         Test.setMock(WebServiceMock.class, new OF_TTM_AsyncChecks_Mock());
        
         EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
         //eaiLog.Caso__c  = c.Id;
         eaiLog.EOF_ID_Notifica__c = 'test_01';
         eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
         //eaiLog.recordTypeId = eaiRecordType;
         eaiLog.OF_SA_ACK__c = true;
         //insert eaiLog;
         ob2.ForwardTroubleTicket_TTM(eaiLog);
         Test.stopTest();      
       
    }
    
}