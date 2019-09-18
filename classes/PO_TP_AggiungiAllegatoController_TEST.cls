@isTest
private class PO_TP_AggiungiAllegatoController_TEST {
    
    public static OF_Tibco_userID__c UserTibcoCreation(){
     
        OF_Tibco_userID__c tibco_user = new OF_Tibco_userID__c();
        tibco_user.Name = 'Tibco UserID';
        tibco_user.OF_Tibco_ID__c = '00558000001f743AAA';   
        insert tibco_user;
        return tibco_user;
    }    

	private static testMethod void test_uploadAttach() {
	    
	    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();   
     
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        Case c = new Case();
        c.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c.Subject = 'Segnalazione Provisioning';
        c.Status = 'Acquisito';
        c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.Origin = 'Portal';
        insert c;

        case casoAttivazione = new case();
        RecordType rt = [Select id from RecordType where recordtype.developername = 'EOF_Caso_Attivazione'];
        casoAttivazione.Subject = 'Richiesta di attivazione';
        casoAttivazione.EOF_Codice_Ordine_OLO__c = 'TEST_76';
        casoAttivazione.EOF_Data_Prevista_Attivazione__c = system.today();
        casoAttivazione.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        casoAttivazione.Status = 'Acquisito';
        casoAttivazione.EOF_Fase__c = 'In Verifica BO';
        casoAttivazione.Type = '1';
        casoAttivazione.EOF_Tipologia_Servizio__c = 'test';
        casoAttivazione.EOF_Codice_Operatore_WS__c = 'VF';
        casoAttivazione.EOF_SLA_Premium_Assurance__c ='Y';
        casoAttivazione.Account = TestDataFactory.acc;
        casoAttivazione.EOF_Identificativo_del_POP__c = 'PG_01';
        casoAttivazione.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        casoAttivazione.EOF_Numero_Civico_WS__c = '7';
        casoAttivazione.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        casoAttivazione.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        casoAttivazione.EOF_Recapito_Test_Linea__c = '111';
        casoAttivazione.EOF_Tipologia_Apparato__c = 'test';
        casoAttivazione.OwnerId = userInfo.getUserId();
        casoAttivazione.RecordTypeId = rt.id;
        casoAttivazione.EOF_Id_Notifica__c = 'test_01';
        casoAttivazione.Origin = 'Web';
        casoAttivazione.Priority = 'Medium';
        casoAttivazione.EOF_GPON_Vincolante__c = 'Y';        
        insert casoAttivazione;
        
        Test.startTest();
	    PO_TP_AggiungiAllegatoController contr = new PO_TP_AggiungiAllegatoController();
	    PageReference pgRef = new PageReference('/apex/PO_TP_AggiungiAllegato');
	    pgRef.getParameters().put('origId',c.id);
	    contr.fileName = 'nome_file';
	    contr.fileBody = blob.valueOf('my attachment text');
	    contr.case_id = c.id;
	    contr.uploadAttach();
	    contr.goToRiepilogoRichiesta();
	    contr.annulla();
	    
	    Test.stopTest();
	}

}