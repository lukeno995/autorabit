@isTest
public class PO_P2PAtt_CompletaOrdine_Cntrl_Test {

      public static testMethod void Method1()
    {
         OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 
    
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
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
         Case c2 = new Case();
        String CaseRecordTypeId2 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c2.AccountId = acc.id;
        c2.EOF_Codice_Ordine_OLO__c = 'Test122';
        c2.EOF_Contact__c = null;
        c2.EOF_Id_Risorsa__c='test122';
        c2.status = 'Accettato';
        c2.EOF_FASE__C = 'NA122';
        c2.OF_SA_Profilo__c='1';
        c2.RecordTypeId=CaseRecordTypeId2;
        c2.AssetId=asset_1.id;
        c2.EOF_Identificativo_del_POP__c='test1122';
        c2.OF_Esito_Consegna_Apparato__c='2';   
       // c2.PO_Case_Collegamento__c=c.id;
        //c1.PO_Richiesta_a_fattibilit__c=c.id;
        c2.NS_Rif__c='TEST';
        insert c2;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test';
        c.OF_Esito_Consegna_Apparato__c='2';
        c.PO_Richiesta_a_fattibilit__c=c2.id;
        c.NS_Rif__c='TEST';
        insert c;
        
        Case c1 = new Case();
        String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c1.AccountId = acc.id;
        c1.EOF_Codice_Ordine_OLO__c = 'Test1';
        c1.EOF_Contact__c = null;
        c1.EOF_Id_Risorsa__c='test1';
        c1.status = 'Accettato';
        c1.EOF_FASE__C = 'NA1';
        c1.OF_SA_Profilo__c='1';
        c1.RecordTypeId=CaseRecordTypeId1;
        c1.AssetId=asset_1.id;
        c1.EOF_Identificativo_del_POP__c='test11';
        c1.OF_Esito_Consegna_Apparato__c='2';   
        c1.PO_Case_Collegamento__c=c.id;
        //c1.PO_Richiesta_a_fattibilit__c=c.id;
        c1.ParentId=c.id;
        //c1.NS_Rif__c='TEST';
        insert c1;
        
        
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.OF_SA_ACK__c = true;
        insert eaiLog; 
         
        EOF_EAI_Service_Log__c theLogOrder = new EOF_EAI_Service_Log__c(); 
        theLogOrder.Caso__c  = c1.Id; 
        insert theLogOrder;
  
        ApexPages.currentPage().getParameters().put('ordercaseditId',c1.id);
        PO_P2PAtt_CompletaOrdine_Cntrl PPC=new PO_P2PAtt_CompletaOrdine_Cntrl();
        string nsrif='test';
        PPC.aggiornaTuttiGliOrdini(c1.id, nsrif);
        PPC.orderAnnulla();
        PPC.date4 = '22/01/2019';
        PPC.SaveOrderCase();
        
        
        
    }
}