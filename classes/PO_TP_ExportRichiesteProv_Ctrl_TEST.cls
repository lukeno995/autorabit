@isTest
public class PO_TP_ExportRichiesteProv_Ctrl_TEST{

    static testmethod void test_exportProv()
    {
    	Profile prf = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = prf.Id,UserRoleID = Usr.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser;
        
        System.RunAs(thisUser)
        {
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
	       
            String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();

	        Case c1 = new Case();
	        c1.Subject = 'Segnalazione Provisioning';
	        c1.Status = 'Acquisito';
	        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
	        c1.PO_TP_Ordine_Di_Riferimento__c = casoAttivazione.id;
	        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
	        c1.PO_TP_Escalation__c = false;
	        c1.PO_TP_Descrizione_Causale__c = 'Sollecito';
	        c1.EOF_Codice_Operatore_WS__c = 'VF';
	        c1.OwnerId = thisUser.id;
	        c1.RecordTypeId = CaseRecordTypeId;
	        c1.Origin = 'Portal';
	        insert c1;
           
            Test.startTest();
			PO_TP_ExportRichiesteProvisioning_Ctrl contr = new PO_TP_ExportRichiesteProvisioning_Ctrl();
		    PageReference pageRef1 = page.PO_TP_ExportRichiesteProvisioning;               
	        pageRef1.getParameters().put('DataInizio','2018-06-01T00:00:00 02:00');
	        pageRef1.getParameters().put('DataFine','2018-06-08T00:00:00 02:00');
	        pageRef1.getParameters().put('descrizioneCasualeJSON','["Sollecito"]');
	        pageRef1.getParameters().put('statusJSON','["Acquisito"]');
	        pageRef1.getParameters().put('escalationJSON','["false"]');
	        Test.setCurrentPageReference(pageRef1); 
    		contr.fetchList();
            Test.stopTest();        
        }
    }
}