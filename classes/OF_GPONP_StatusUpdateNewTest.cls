@isTest
public class OF_GPONP_StatusUpdateNewTest {
    
     @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }
    
   public static testMethod void OF_GPONP_StatusUpdateMethod(){
        
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
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
       
        EOF_EAI_Service_Log__C sl = new EOF_EAI_Service_Log__C();
            sl.EOF_Codice_Operatore__c='TIS';
            sl.EOF_Codice_Ordine_OLO__c='TEST_ANI_23';
            sl.EOF_Codice_Ordine_EOF__c='5008E00000An3OLQAZ';
            sl.EOF_Data_Notifica__c=system.today();
            sl.EOF_ID_Notifica__c='ID_123456';
            sl.EOF_STATO_ORDINE__c='test';
            sl.EOF_CODICE_MOTIVAZIONE__c='test';
            sl.EOF_MOTIVAZIONE__c='test';
            sl.EOF_GPON_Attestazione__c='test';
            sl.EOF_Nome_Cliente__c='test';
            sl.EOF_COgnome_CLiente__c='test';
            sl.EOF_RECAPITO_TELEFONICO_CLIENTE__c='test';
            sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=system.today();
            sl.EOF_ORARIO_APPUNTAMENTO__c='test';
            sl.EOF_PIN_INTERVENTO_A_VUOTO__c='test';
            sl.EOF_NOTE__c='TEST WS OF_CO_WS_IN_OLO_ChangeSetup_OpenStream';
            sl.OF_Flag_Desospensione__c='test';
            sl.OF_SA_VLan_Log__c=sl.ID;
           
            sl.OF_SA_NOME_SERVIZIO__c='';
            sl.OF_SA_INFORMAZIONI_SERVIZIO__c='';
            sl.EOF_TIPOLOGIA_APPARATO__c='';
            sl.OF_SA_PASSWORD_APPARATO__c='';
            sl.OF_SA_AZIONE_APPARATO__c='';
            sl.OF_SA_KIT_CONSEGNA_VLAN__c='TIS_MI_1';
            sl.OF_SA_USER_VLAN__c='89';
            sl.OF_SA_SERVICE_VLAN__c='210';
            sl.OF_SA_PROFILO_VLAN__c='5';
            sl.OF_SA_INFORMAZIONI_VLAN__c='Testinformazione';
            sl.OF_SA_CUSTOMER_VLAN__c='123';
            sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='0.0423611111111111';
            sl.OF_SA_ESITO_RITIRO_APPARATO__c='';
            sl.OF_SA_CODICE_MOTIVAZIONE_RITIRO__c='';
            sl.OF_SA_MOTIVAZIONE_RITIRO__c='';
            sl.EOF_Tipo_Comunicazione_String__c='SF->OM - ChangeOrderRequest';
              insert sl;
       
       EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_011';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_371';
        eaiLog1.OF_SA_VLan_Log__c = sl.ID;
        eaiLog1.EOF_DATA_PREVISTA_ATTIVAZIONE__c = system.today();
        eaiLog1.EOF_ORARIO_APPUNTAMENTO__c = 'Test1';
        eaiLog1.OF_Remote_ID__c = 'Test1';
        insert eaiLog1;
        Test.startTest();
        {
            system.debug('sls: '+sl.Id);
            OF_GPONP_StatusUpdateNew sun = new OF_GPONP_StatusUpdateNew();
            OF_GPONP_StatusUpdateNew.StatusUpdate_GPONPEndpoint4 edp = new OF_GPONP_StatusUpdateNew.StatusUpdate_GPONPEndpoint4();
            Test.setMock(WebServiceMock.class, new OF_GPONP_StatusUpdateNewMock());
            edp.StatusUpdate_GPONP(sl);
            
        }
        }
}