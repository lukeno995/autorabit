@isTest
public class PO_P2PAttiva_OrderDetails_CtrlTest {
    @testSetup
    public static void testSetUpData() {
        
        //Recupero tutti i recordType
        List<RecordType> rtList = [SELECT developername, Id 
                                         FROM RecordType
                                         WHERE isActive = true];
        //Popolo una map con tutti i recordType avente come key il developername e come Value l'id
        Map<String,String> rtMap = new Map<String,String>();
        for(RecordType rt : rtList){
            rtMap.put(rt.developername, rt.Id);
        }
        
        account acc = new account();
            acc.EOF_Codice_Operatore__c= 'VF';
            acc.name = 'test';        
        insert acc; 
        
        OLO_ID__c olo = new OLO_ID__c();
            olo.name = 'VF';
            olo.OF_Olo_Id__c = acc.Id;
        insert olo;         
        
        OF_ElencoComuniItaliani__c comune = new OF_ElencoComuniItaliani__c();
            comune.OF_CodiceIstat__c = 'Test';
            comune.OF_Provincia__c = 'Test';
        	comune.OF_Comune__c = 'Test';
        insert comune;
        
        //ParentLog
        EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();	
            parentLog.RecordTypeId = rtMap.get('PO_P2PAttiva_Request');
            parentLog.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
            parentLog.EOF_Data_Notifica__c = datetime.now();
            parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
            parentLog.EOF_Stato_Richiesta__c= 'Bozza Portale';
            parentLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
            parentLog.EOF_Codice_Operatore__c = acc.EOF_Codice_Operatore__c;
            parentLog.PO_Nome_Progetto__c = 'TEST_AA';
            parentLog.PO_Offerta__c = 'P2P Attiva';
        //Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
        insert parentLog;
        
        Attachment a = new Attachment();
        a.Body = Blob.valueOf('ciao');
        a.Name = 'test';
        a.ParentId = parentLog.Id;
        insert a;
       
        Case c = new Case();
        insert c;
    }
    
    static testMethod void testMethod1(){
        EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        Case c = [SELECT Id FROM Case LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_EditLogInfo);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('orderLogId', parentLog.Id);
        ApexPages.currentPage().getParameters().put('id', c.Id);
        
        PO_P2PAttiva_OrderDetails_Ctrl ctrl = new PO_P2PAttiva_OrderDetails_Ctrl();           
    	ctrl.orderLogsList = new List<EOF_EAI_Service_Log__c>();
        ctrl.recordOfferta = 'ciao';
        ctrl.childCaseObj = new Case();
        ctrl.CaseDetail = 'test';
    	ctrl.offertEvento = 'test';
    	ctrl.cliente = 'test';
        ctrl.cliente1 = 'test';
        ctrl.cliente2 = 'test';
        ctrl.ordercasedisplayordinedate = 'test';
        ctrl.childDate = 'test';
        ctrl.DetailPage();
        ctrl.GoBack();
        //Fine scope del test
        Test.stopTest();
    }
}