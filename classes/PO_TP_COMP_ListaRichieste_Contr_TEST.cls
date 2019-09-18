@isTest
public class PO_TP_COMP_ListaRichieste_Contr_TEST
{
    public static OF_Tibco_userID__c UserTibcoCreation(){
     
        OF_Tibco_userID__c tibco_user = new OF_Tibco_userID__c();
        tibco_user.Name = 'Tibco UserID';
        tibco_user.OF_Tibco_ID__c = '00558000001f743AAA';   
        insert tibco_user;
        return tibco_user;
    }    

    static testmethod void test_method1()
    {  
        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
       
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        Case c = new Case();
        c.Subject = 'Segnalazione Provisioning';
        c.Status = 'Acquisito';
        c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c.PO_TP_Escalation__c = false;
        c.PO_TP_Descrizione_Causale__c = 'Sollecito';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.Origin = 'Portal';
        insert c;
        
        Case c1 = new Case();
        c1.Subject = 'Segnalazione Provisioning';
        c1.Status = 'Acquisito';
        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c1.PO_TP_Escalation__c = false;
        c1.PO_TP_Descrizione_Causale__c = 'Sollecito1';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.Origin = 'Portal';
        insert c1;

        test.startTest();
        PageReference pageRef1 = page.PO_TP_DisplayRequest;               
        pageRef1.getParameters().put('azione','Provisioning');
        pageRef1.getParameters().put('mess','escalated');
        
        Test.setCurrentPageReference(pageRef1);
      
        PO_TP_COMP_ListaRichieste_Controller.optionApex opt = new PO_TP_COMP_ListaRichieste_Controller.optionApex('A','B');
        PO_TP_COMP_ListaRichieste_Controller.optionApex opt1 = new PO_TP_COMP_ListaRichieste_Controller.optionApex(true,false);
        PO_TP_COMP_ListaRichieste_Controller lista_ric_cont_1 = new PO_TP_COMP_ListaRichieste_Controller();
        Double x = lista_ric_cont_1.offset;
        //lista_ric_cont_1.descrizioneCasualeJSON = 'Testing';
        //lista_ric_cont_1.escalationJSON = 'Testing';
        //lista_ric_cont_1.statusJSON = 'SUCCESS';
        lista_ric_cont_1.runSearch();
        lista_ric_cont_1.runQuery();
        lista_ric_cont_1.vaiInEscalation();

        PageReference pageD = lista_ric_cont_1.ViewCaseDettail();
        lista_ric_cont_1.listRichiesteTP.add(c);
        lista_ric_cont_1.listRichiesteTP.add(c1);
        lista_ric_cont_1.offset_page = 10;
        lista_ric_cont_1.setPagination(true);
		PageReference pageRefUp = lista_ric_cont_1.pageUp();
        PageReference pageRefDown = lista_ric_cont_1.pageDown();
        lista_ric_cont_1.preparePage();
        
        PageReference pageRef2 = page.PO_TP_DisplayRequest;               
        Test.setCurrentPageReference(pageRef2);
      
        PO_TP_COMP_ListaRichieste_Controller lista_ric_cont_2 = new PO_TP_COMP_ListaRichieste_Controller();

        test.stopTest();        
    }  
    
     static testmethod void test_method2()
    {  
        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
       
		User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
		List<Case> listRichiesteTP = new List<Case>();
		
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        
		//Creazione Case di attivazione a cui poi legare le segnalazioni di provisioning.
		
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
		casoAttivazione.EOF_Comune_WS__c='Milano';
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
        
		
		//Creazione 1° case di provisioning su casoAttivazione
		Case c = new Case();
        c.Subject = 'Segnalazione Provisioning';
        c.Status = 'Acquisito';
        c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c.PO_TP_Escalation__c = false;
        c.PO_TP_Descrizione_Causale__c = 'Sollecito';
        c.EOF_Codice_Operatore_WS__c = attuale.Account.EOF_Codice_Operatore__c;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
		c.PO_TP_Dettaglio_Richiesta__c='Dettaglio Richiesta Test';
		c.PO_TP_Sottocausale__c='';
        c.Origin = 'Portal';
        insert c;
		Datetime dataDaSettare = Datetime.now().addDays(-8);
		Test.setCreatedDate(c.Id, dataDaSettare);
		//c.CreatedDate
		listRichiesteTP.add(c);
		
		//Creazione 2° case di provisioning su casoAttivazione
        Case c1 = new Case();
        c1.Subject = 'Segnalazione Provisioning';
        c1.Status = 'Acquisito';
        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c1.PO_TP_Escalation__c = true;
        c1.PO_TP_Descrizione_Causale__c = 'Sollecito1';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.Origin = 'Portal';
        insert c1;
		listRichiesteTP.add(c1);
		
		//Creazione 3° case di provisioning non legato a niente
		Case c34 = new Case();
        c34.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c34.Subject = 'Segnalazione Provisioning';
        c34.Status = 'Acquisito';
        c34.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        c34.EOF_Codice_Operatore_WS__c = 'VF';
        c34.OwnerId = userInfo.getUserId();
        c34.EOF_Comune_WS__c = 'Milano';
		c34.RecordTypeId = CaseRecordTypeId;
        c34.Origin = 'Portal';
		insert c34;
		listRichiesteTP.add(c34);
		
		//creiamo 25 cloni di c34 
		for(Integer i=0; i<26; i++){
			/*se caseCloneCopy = c34.clone(false, false, false, false);
			insert caseCloneCopy;*/
			Case c5 = new Case();
			c5.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
			c5.Subject = 'Segnalazione Provisioning';
			c5.Status = 'Acquisito';
			c5.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'Test_20181030'+i;
			c5.EOF_Codice_Operatore_WS__c = 'VF';
			c5.OwnerId = userInfo.getUserId();
			c5.EOF_Comune_WS__c = 'Milano';
			c5.RecordTypeId = CaseRecordTypeId;
			c5.Origin = 'Portal';
			insert c5;
			listRichiesteTP.add(c5);
		}
		system.debug('@@@@@@@@EC nel secondo TestMethod listRichiesteTP conta ' + listRichiesteTP.size() + ' record.');
		system.debug('@@@@@@@@EC nel secondo TestMethod listRichiesteTP è ' + listRichiesteTP);
		
        test.startTest();
		
        PageReference pageRef1 = page.PO_TP_DisplayRequest;               
        pageRef1.getParameters().put('azione','Provisioning');
        pageRef1.getParameters().put('mess','escalated');
        String listRichiesteTPstring;
        
        Test.setCurrentPageReference(pageRef1);
      
        PO_TP_COMP_ListaRichieste_Controller.optionApex opt = new PO_TP_COMP_ListaRichieste_Controller.optionApex('A','B');
        PO_TP_COMP_ListaRichieste_Controller.optionApex opt1 = new PO_TP_COMP_ListaRichieste_Controller.optionApex(true,false);
        PO_TP_COMP_ListaRichieste_Controller lista_ric_cont_1 = new PO_TP_COMP_ListaRichieste_Controller();
        Double x = lista_ric_cont_1.offset;
        //lista_ric_cont_1.descrizioneCasualeJSON = 'Testing';
        //lista_ric_cont_1.escalationJSON = 'Testing';
        //lista_ric_cont_1.statusJSON = 'SUCCESS';
        lista_ric_cont_1.runSearch();
        lista_ric_cont_1.runQuery();
        lista_ric_cont_1.vaiInEscalation();
		listRichiesteTPstring=JSON.serialize(listRichiesteTP);
        PageReference pageD = lista_ric_cont_1.ViewCaseDettail();
		lista_ric_cont_1.listRichiesteTP.addAll(listRichiesteTP);
        //lista_ric_cont_1.listRichiesteTP.add(c);
        //lista_ric_cont_1.listRichiesteTP.add(c1);
        lista_ric_cont_1.offset_page = 10;
        lista_ric_cont_1.setPagination(true);
		PageReference pageRefUp = lista_ric_cont_1.pageUp();
        PageReference pageRefDown = lista_ric_cont_1.pageDown();
        lista_ric_cont_1.preparePage();
        
        PageReference pageRef2 = page.PO_TP_DisplayRequest;               
        Test.setCurrentPageReference(pageRef2);
      
        PO_TP_COMP_ListaRichieste_Controller lista_ric_cont_2 = new PO_TP_COMP_ListaRichieste_Controller();

        test.stopTest();        
    }  
    
}