@isTest
public class OF_CO_OLO_SendToOM_Test{
    
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
    
    public static testMethod void OF_CO_OLO_SendToOMMethod1()
    {              
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';       
        insert contra;        
        
        OF_ContrattoServizio__c contratto_servizio = new OF_ContrattoServizio__c();
        contratto_servizio.OF_Contract__c = contra.id;
        contratto_servizio.OF_Servizio__c = servizio.id;
        insert contratto_servizio;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
        
        order ord = new order();
        ord.OF_Profilo__c = 'Test';
        ord.AccountId = acc.Id;
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        case C1=new case();
        C1.OF_Response_Da_OLO__c='RDO1';
        C1.OF_Response_Da_OM__c='RDOM1';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.OF_SA_Profilo__c='OSP1';
        C1.EOF_Note__c='ENC1';
        C1.Status='Modificato KO'; 
        C1.AssetId=a.Id;
        c1.EOF_Codice_Errore__c='ERRORCo';  
        c1.EOF_Causale_Errore__c='ERRORSo';
        c1.EOF_Account_OLO__c=acc.id;
        c1.OF_Order__c=ord.id;
        c1.status = 'Acquisito';
        c1.OF_Bonifica_Locked_Row__c = true;
        //C1.PO_SA_Portale__c=TRUE;
        insert C1;
        
        boolean retry=false;
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = C1.EOF_Codice_Ordine_OLO__c;
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.EOF_Stato_Ordine__c = c1.status;
        insert eaiLog;
        
        List<OF_CommercialElementIstanziato__c> comList = new List<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =a.Id;
        comList.add(istan);
        insert comList;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_GE_Utils.caseOriginale = c1;
        OF_CO_OLO_SendToOM.OM_CreateAckNackRequestActivation(c1,comList);
        Test.StopTest();
    }
    
    public static testMethod void OF_CO_OLO_SendToOMMethod2()
    {
       
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.name = 'Catalogo_001';
        catalogo.OF_DataInizioValidita__c = System.today() - 150;
        catalogo.OF_DataFineValidita__c = System.today() + 100;
        catalogo.OF_Attivo__c = true;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.Name = 'Open Stream';
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_DataInizioValidita__c = System.today() - 150;
        servizio.OF_DataFineValidita__c = System.today() + 100;
        servizio.OF_Attivo__c = true;
        insert servizio;
        
        contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';       
        insert contra;        
        
        OF_ContrattoServizio__c contratto_servizio = new OF_ContrattoServizio__c();
        contratto_servizio.OF_Contract__c = contra.id;
        contratto_servizio.OF_Servizio__c = servizio.id;
        insert contratto_servizio;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
        
        order ord = new order();
        ord.OF_Profilo__c = 'Test';
        ord.AccountId = acc.Id;
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        case C1=new case();
        C1.OF_Response_Da_OLO__c='RDO1';
        C1.OF_Response_Da_OM__c='RDOM1';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.OF_SA_Profilo__c='OSP1';
        C1.EOF_Note__c='ENC1';
        C1.Status='Modificato KO'; 
        C1.AssetId=a.Id;
        c1.EOF_Codice_Errore__c='ERRORCo';  
        c1.EOF_Causale_Errore__c='ERRORSo';
        c1.EOF_Account_OLO__c=acc.id;
        c1.OF_Order__c=ord.id;
        c1.status = 'Acquisito';
        c1.OF_Bonifica_Locked_Row__c = false;
        //C1.PO_SA_Portale__c=TRUE;
        insert C1;
        
        boolean retry=false;
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c1.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = C1.EOF_Codice_Ordine_OLO__c;
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        eaiLog.EOF_Stato_Richiesta__c='Inserita Portale';
        eaiLog.EOF_Stato_Ordine__c = c1.status;
        insert eaiLog;
        
        List<OF_CommercialElementIstanziato__c> comList = new List<OF_CommercialElementIstanziato__c>();
        OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_Asset__c =a.Id;
        comList.add(istan);
        insert comList;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        OF_CO_GE_Utils.caseOriginale = c1;
        OF_CO_OLO_SendToOM.OM_CreateAckNackRequestActivation(c1,comList);
        Test.StopTest();
    }
}