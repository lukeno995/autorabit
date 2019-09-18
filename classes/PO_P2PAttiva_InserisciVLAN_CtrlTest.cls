@isTest
public class PO_P2PAttiva_InserisciVLAN_CtrlTest {
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
        
        //ChildLog
        EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();	
        childLog.RecordTypeId = rtMap.get('P2P_Attiva_Collegamento');
        childLog.PO_Offerta__c = 'P2P Attiva';
        childLog.PO_Tipo_di_collegamento__c = 'Point-to-Point';
        childLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        childLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
        childLog.EOF_Codice_Operatore__c = acc.EOF_Codice_Operatore__c;
        childLog.EOF_Comune__c =  [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :comune.Id].OF_Comune__c;
        childLog.OF_Id_Comune__c = comune.Id;
        childLog.EOF_SL_Riferimento__c = parentLog.Id;
        childLog.PO_Nome_Progetto__c = 'TEST_AA_child';
        insert childLog;
    }
    
    static testMethod void testMethod1(){
        EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_InserisciVLAN);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        PO_P2PAttiva_InserisciVLAN_Controller ctrl = new PO_P2PAttiva_InserisciVLAN_Controller();
        ctrl.slVlan.OF_SA_PROFILO_VLAN__c = '';
        ctrl.modifyPicklist();
        ctrl.mappingPicklist();
        ctrl.slVlan.OF_SA_PROFILO_VLAN__c = '0';
        ctrl.modifyPicklist();
        ctrl.mappingPicklist();
        ctrl.slVlan.OF_SA_PROFILO_VLAN__c = '3';
        ctrl.modifyPicklist();
        ctrl.mappingPicklist();
        ctrl.slVlan.OF_SA_PROFILO_VLAN__c = '5';
        ctrl.modifyPicklist();
        ctrl.mappingPicklist();
        //
        ctrl.InserisciVLAN();
        ctrl.updateVLAN();
        ctrl.inserisciNuovoKit();
        ctrl.annullaVLAN();
        //Fine scope del test
        Test.stopTest();
    }
}