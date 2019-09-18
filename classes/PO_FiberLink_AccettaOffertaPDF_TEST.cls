@isTest
private class PO_FiberLink_AccettaOffertaPDF_TEST {

    public static testMethod void getOpportunity_test(){
         
        OF_Tibco_userID__c  oft = new OF_Tibco_userID__c();
        oft.Name = 'Tibco UserID';
        oft.OF_Tibco_ID__c = 'Test';
        insert oft; 
        
        OF_Enable_PO_UpdateOppCase_Trigger__c ofe = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        ofe.name = 'Status';
        ofe.OF_Enable_Trigger__c = false;
        insert ofe;
         
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
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Risorsa').getRecordTypeId();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine Fiber Link').getRecordTypeId();
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
       
        c.PO_Offerta__c = 'Fiber Link';
        
        insert c;
        
        Case c2 = new Case();
        String Case2RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Collegamento Fiber link').getRecordTypeId();
        c2.AccountId = acc.id;
        c2.EOF_Codice_Ordine_OLO__c = 'Test2';
        c2.EOF_Contact__c = null;
        c2.EOF_Id_Risorsa__c='test2';
        c2.status = 'Accettato';
        c2.EOF_FASE__C = 'NA';
        c2.PO_Offerta__c = 'Fiber Link';
        c2.OF_SA_Profilo__c='1';
        c2.RecordTypeId=Case2RecordTypeId;
        c2.AssetId=asset_1.id;
        c2.EOF_Identificativo_del_POP__c='test';
        c2.OF_Esito_Consegna_Apparato__c='2';
        c2.PO_Incluso_nell_offerta__c=true;
        c2.ParentId = c.id;
        insert c2;
         
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = 'Test';
        ser.EOF_ID_Notifica__c = 'Test';
        ser.caso__c= c.id;
        insert ser; 
         
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today() + 5;
        opp.PO_Richiesta_fattibilit__c = c.Id;
        insert opp;
        
                 
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Test';
        opp2.StageName = 'Prospecting';
        opp2.CloseDate = System.today() + 5;
        opp2.PO_Collegamento__c = c2.Id;
        opp2.PO_Offerta_totale__c=opp.id;
        insert opp2;
        
        list<Opportunity> opplst = new list<Opportunity>();
        opplst.add(opp);
        
        Quote qt = new Quote();
        qt.Name = 'Test';
        qt.OpportunityId = opp.Id;
        insert qt;
         
        decimal Duratta = 5;
         
        test.starttest();
        
        
        ApexPages.currentPage().getParameters().put('id',qt.id);
        ApexPages.currentPage().getParameters().put('durata','3');
        
        PO_FiberLink_AccettaOffertaPDF contr = new PO_FiberLink_AccettaOffertaPDF();
        contr.getOpportunity();
        
        test.stoptest();   
    }

}