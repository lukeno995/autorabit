@isTest
public class PO_P2PAttiva_DesospClg_ControllerTest {
    @testSetup
    public static void testSetUpData() {
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
    }
   
    static testMethod void testMethod1(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
      //  asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test222222222';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='new';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';    
        
        insert c;
        
        EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();
        sLog.Caso__c = c.Id;
        insert sLog;
        
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_DesospClg);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('ChildId', sLog.Id);
        Apexpages.currentPage().getParameters().put('proc', 'desospensione');
        
        PO_P2PAttiva_DesospClg_Controller ctrl = new PO_P2PAttiva_DesospClg_Controller();
        PO_P2PAttiva_DesospClg_Controller.dateToString(DateTime.newInstance(Date.newInstance(2018, 11, 11), Time.newInstance(11, 22, 11, 13)));
        PO_P2PAttiva_DesospClg_Controller.dateToString(null);
        ctrl.annullaFlusso();
        ctrl.InoltraFlusso();
        ctrl.recordOfferta = 'voglioil100%';
        //Fine scope del test
        Test.stopTest();
    }
    

}