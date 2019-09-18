@isTest
public class OF_WS_SEMAFORO_VERTICALE_Test {
    
    
    
    
    
    public static testmethod void test(){
        
        Test.startTest();
        
        
                Verticali__c cs = new Verticali__c();
        cs.Name='test';
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
        
        
        //Test.setMock(WebServiceMock.class, new OF_WS_SEMAFORO_VERTICALE_Mock()); 
        OF_WS_SEMAFORO_VERTICALE.OF_WS_SEMAFORO_VERTICALE_Request req = new OF_WS_SEMAFORO_VERTICALE.OF_WS_SEMAFORO_VERTICALE_Request();
        req.DESCRIZIONE='descrizione';
        req.ESITO_CARICAMENTO='OK';
        OF_WS_SEMAFORO_VERTICALE.StatusChiamata(req);
        test.stopTest();
        
    }
    
}