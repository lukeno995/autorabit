@isTest
public class PO_P2PAttiva_viewKIT_CntrlTest {
    static testMethod void testMethod1(){
        EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();	
            parentLog.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
            parentLog.EOF_Data_Notifica__c = datetime.now();
            parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
            parentLog.EOF_Stato_Richiesta__c= 'Bozza Portale';
            parentLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
            parentLog.PO_Nome_Progetto__c = 'TEST_AA';
            parentLog.PO_Offerta__c = 'P2P Attiva';
        //Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
        insert parentLog;
        
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_viewKIT);
        ApexPages.currentPage().getParameters().put('kitId', parentLog.Id);
        ApexPages.currentPage().getParameters().put('parentId', parentLog.Id);
        
        PO_P2PAttiva_viewKIT_Cntrl ctrl = new PO_P2PAttiva_viewKIT_Cntrl();
        ctrl.TornaAlRiepilogo();
        ctrl.recordOfferta = '';
        ctrl.kitLogList = new List<EOF_EAI_Service_Log__c>();
        
        //Fine scope del test
        Test.stopTest();
    }
}