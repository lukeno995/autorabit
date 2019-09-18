@isTest
public class PO_TP_COMP_InserimentoTP_Controller_TEST{
    
    public static OF_Tibco_userID__c UserTibcoCreation(){
     
        OF_Tibco_userID__c tibco_user = new OF_Tibco_userID__c();
        tibco_user.Name = 'Tibco UserID';
        tibco_user.OF_Tibco_ID__c = '00558000001f743AAA';   
        insert tibco_user;
        return tibco_user;
    }  
    
    static testmethod void test_method1()
    {       
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
        
        Case c1 = new Case();
        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c1.Subject = 'Segnalazione Provisioning';
        c1.Status = 'Accettato';
        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_01';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.Origin = 'Portal';
        insert c1;

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
        
        case casoAttivazione2 = new case();

        casoAttivazione2.Subject = 'Richiesta di attivazione';
        casoAttivazione2.EOF_Codice_Ordine_OLO__c = 'TEST_01';
        casoAttivazione2.EOF_Data_Prevista_Attivazione__c = system.today();
        casoAttivazione2.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        casoAttivazione2.Status = 'Acquisito';
        casoAttivazione2.EOF_Fase__c = 'In Verifica BO';
        casoAttivazione2.Type = '1';
        casoAttivazione2.EOF_Tipologia_Servizio__c = 'test';
        casoAttivazione2.EOF_Codice_Operatore_WS__c = 'VF';
        casoAttivazione2.EOF_SLA_Premium_Assurance__c ='Y';
        casoAttivazione2.Account = TestDataFactory.acc;
        casoAttivazione2.EOF_Comune_WS__c = 'Milano';
        casoAttivazione2.EOF_Identificativo_del_POP__c = 'MI_01';
        casoAttivazione2.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        casoAttivazione2.EOF_Numero_Civico_WS__c = '7';
        casoAttivazione2.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        casoAttivazione2.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        casoAttivazione2.EOF_Recapito_Test_Linea__c = '111';
        casoAttivazione2.EOF_Tipologia_Apparato__c = 'test';
        casoAttivazione2.OwnerId = userInfo.getUserId();
        casoAttivazione2.RecordTypeId = rt.id;
        casoAttivazione2.EOF_Id_Notifica__c = 'test_01';
        casoAttivazione2.Origin = 'Web';
        casoAttivazione2.Priority = 'Medium';
        casoAttivazione2.EOF_GPON_Vincolante__c = 'Y';        
        insert casoAttivazione2;

        Test.StartTest();            
        PO_TP_COMP_InserimentoTP_Controller ins_cont = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        ins_cont.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont.salvaC();
        
        c.status = 'Annullato';
        update c;
        ins_cont.salvaC();

        PageReference annulla = ins_cont.AnnullaS();
        PageReference escalation = ins_cont.vaiInEscalation();
        ins_cont.calcDescCaus();
        ins_cont.salvaC();

        Test.StopTest();
    }
    //EC 2018 - 10 - 30 start
    
    static testmethod void test_method2()
    {       
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
		
		string statoASistema;
		User userPoloMilano	=[Select id,Alias,Email,EmailEncodingKey,LastName,ProfileId,UserName,UserRoleId 
								from User where name = 'Segnalazioni Provisioning Polo Milano'];
		List<Case> ListaTicketProv = new List<Case>();								
     
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        

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
        
        case casoAttivazione2 = new case();

        casoAttivazione2.Subject = 'Richiesta di attivazione';
        casoAttivazione2.EOF_Codice_Ordine_OLO__c = 'TEST_01';
        casoAttivazione2.EOF_Data_Prevista_Attivazione__c = system.today();
        casoAttivazione2.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        casoAttivazione2.Status = 'Acquisito';
        casoAttivazione2.EOF_Fase__c = 'In Verifica BO';
        casoAttivazione2.Type = '1';
        casoAttivazione2.EOF_Tipologia_Servizio__c = 'test';
        casoAttivazione2.EOF_Codice_Operatore_WS__c = 'VF';
        casoAttivazione2.EOF_SLA_Premium_Assurance__c ='Y';
        casoAttivazione2.Account = TestDataFactory.acc;
        casoAttivazione2.EOF_Comune_WS__c = 'Milano';
        casoAttivazione2.EOF_Identificativo_del_POP__c = 'MI_01';
        casoAttivazione2.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        casoAttivazione2.EOF_Numero_Civico_WS__c = '7';
        casoAttivazione2.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        casoAttivazione2.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        casoAttivazione2.EOF_Recapito_Test_Linea__c = '111';
        casoAttivazione2.EOF_Tipologia_Apparato__c = 'test';
        casoAttivazione2.OwnerId = userInfo.getUserId();
        casoAttivazione2.RecordTypeId = rt.id;
        casoAttivazione2.EOF_Id_Notifica__c = 'test_01';
        casoAttivazione2.Origin = 'Web';
        casoAttivazione2.Priority = 'Medium';
        casoAttivazione2.EOF_GPON_Vincolante__c = 'Y';        
        insert casoAttivazione2;
		
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
		
		Case cbis = new Case();
        cbis.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        cbis.Subject = 'Segnalazione Provisioning';
        cbis.Status = 'Acquisito';
        cbis.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        cbis.EOF_Codice_Operatore_WS__c = 'VF';
        cbis.OwnerId = userInfo.getUserId();
        cbis.RecordTypeId = CaseRecordTypeId;
        cbis.Origin = 'Portal';
		try{
        insert cbis;
        }
		Catch(Exception e){
			System.debug('giustamente non inseriamo cbis perché già esiste un ticket provisioning uguale.');
		}
		
        Case c1 = new Case();
        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c1.Subject = 'Segnalazione Provisioning';
        c1.Status = 'Accettato';
        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_01';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.Origin = 'Portal';
        insert c1;
		
		Case c2 = new Case();
        c2.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c2.Subject = 'Segnalazione Provisioning';
        c2.Status = 'Acquisito';
        c2.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c2.EOF_Codice_Operatore_WS__c = 'TIS';
        c2.OwnerId = userInfo.getUserId();
        c2.RecordTypeId = CaseRecordTypeId;
        c2.Origin = 'Portal';
		try{
        insert c2;
		}
		Catch(Exception e){
			System.debug('giustamente non inserisce il ticket perché il codice operatore è diverso da quello presente a sistema');
			
		}
		
		Case c3 = new Case();
        c3.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c3.Subject = 'Segnalazione Provisioning';
        c3.Status = 'Acquisito';
        c3.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        c3.EOF_Codice_Operatore_WS__c = 'VF';
        c3.OwnerId = userInfo.getUserId();
        c3.RecordTypeId = CaseRecordTypeId;
        c3.Origin = 'Portal';
		insert c3;

        Test.StartTest();            
        PO_TP_COMP_InserimentoTP_Controller ins_cont = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        ins_cont.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont.salvaC();
        
        c.status = 'Annullato';
        update c;
        ins_cont.salvaC();

        PageReference annulla = ins_cont.AnnullaS();
        PageReference escalation = ins_cont.vaiInEscalation();
        ins_cont.calcDescCaus();
        ins_cont.salvaC();

        Test.StopTest();
    }
    
     static testmethod void test_method3()
    {       
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
		
		string statoASistema;
		User userPoloMilano	=[Select id,Alias,Email,EmailEncodingKey,LastName,ProfileId,UserName,UserRoleId 
								from User where name = 'Segnalazioni Provisioning Polo Milano'];
		List<Case> ListaTicketProv = new List<Case>();								
     
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        
		
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
        
        case casoAttivazione2 = new case();

        casoAttivazione2.Subject = 'Richiesta di attivazione';
        casoAttivazione2.EOF_Codice_Ordine_OLO__c = 'TEST_01';
        casoAttivazione2.EOF_Data_Prevista_Attivazione__c = system.today();
        casoAttivazione2.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        casoAttivazione2.Status = 'Acquisito';
        casoAttivazione2.EOF_Fase__c = 'In Verifica BO';
        casoAttivazione2.Type = '1';
        casoAttivazione2.EOF_Tipologia_Servizio__c = 'test';
        casoAttivazione2.EOF_Codice_Operatore_WS__c = 'VF';
        casoAttivazione2.EOF_SLA_Premium_Assurance__c ='Y';
        casoAttivazione2.Account = TestDataFactory.acc;
        casoAttivazione2.EOF_Comune_WS__c = 'Milano';
        casoAttivazione2.EOF_Identificativo_del_POP__c = 'MI_01';
        casoAttivazione2.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        casoAttivazione2.EOF_Numero_Civico_WS__c = '7';
        casoAttivazione2.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        casoAttivazione2.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        casoAttivazione2.EOF_Recapito_Test_Linea__c = '111';
        casoAttivazione2.EOF_Tipologia_Apparato__c = 'test';
        casoAttivazione2.OwnerId = userInfo.getUserId();
        casoAttivazione2.RecordTypeId = rt.id;
        casoAttivazione2.EOF_Id_Notifica__c = 'test_01';
        casoAttivazione2.Origin = 'Web';
        casoAttivazione2.Priority = 'Medium';
        casoAttivazione2.EOF_GPON_Vincolante__c = 'Y';        
        insert casoAttivazione2;
		
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
		
		Case cbis = new Case();
        cbis.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        cbis.Subject = 'Segnalazione Provisioning';
        cbis.Status = 'Acquisito';
        cbis.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        cbis.EOF_Codice_Operatore_WS__c = 'VF';
        cbis.OwnerId = userInfo.getUserId();
        cbis.RecordTypeId = CaseRecordTypeId;
        cbis.Origin = 'Portal';
		try{
        insert cbis;
        }
		Catch(Exception e){
			System.debug('giustamente non inseriamo cbis perché già esiste un ticket provisioning uguale.');
		}
		
        Case c1 = new Case();
        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c1.Subject = 'Segnalazione Provisioning';
        c1.Status = 'Accettato';
        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_01';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
		c1.EOF_Comune_WS__c = 'Milano';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.Origin = 'Portal';
        insert c1;
		
		Case c2 = new Case();
        c2.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c2.Subject = 'Segnalazione Provisioning';
		c2.EOF_Comune_WS__c = 'Milano';
        c2.Status = 'Acquisito';
        c2.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c2.EOF_Codice_Operatore_WS__c = 'TIS';
        c2.OwnerId = userInfo.getUserId();
        c2.RecordTypeId = CaseRecordTypeId;
        c2.Origin = 'Portal';
		try{
        insert c2;
		}
		Catch(Exception e){
			System.debug('giustamente non inserisce il ticket perché il codice operatore è diverso da quello presente a sistema');
			
		}
       /* 
        Case c3 = new Case();
        c3.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c3.Subject = 'Segnalazione Provisioning';
        c3.Status = 'Acquisito';
        c3.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        c3.EOF_Codice_Operatore_WS__c = 'VF';
        c3.OwnerId = userInfo.getUserId();
        c3.EOF_Comune_WS__c = 'Milano';
		c3.RecordTypeId = CaseRecordTypeId;
        c3.Origin = 'Portal';
		insert c3;
        */
		
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
        Datetime dataDaSettare = Datetime.now().addDays(-8);
		Test.setCreatedDate(c34.Id, dataDaSettare);
       
		Test.StartTest(); 
                 
        PO_TP_COMP_InserimentoTP_Controller ins_cont = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        ins_cont.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont2 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont2.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        ins_cont2.slToInsert.EOF_Codice_Operatore__c = 'TIS';
        ins_cont2.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont2.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont2.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont3 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont3.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'CIAONE_20181030';
        ins_cont3.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont3.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont3.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
		
        ins_cont3.salvaC();
        
        Test.StopTest();
    }
    
      static testmethod void test_method4()
    {       
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
		
		string statoASistema;
		User userPoloMilano	=[Select id,Alias,Email,EmailEncodingKey,LastName,ProfileId,UserName,UserRoleId 
								from User where name = 'Segnalazioni Provisioning Polo Milano'];
		List<Case> ListaTicketProv = new List<Case>();								
     
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        
		
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
        
        /*
        Case c1 = new Case();
        c1.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c1.Subject = 'Segnalazione Provisioning';
        c1.Status = 'Accettato';
        c1.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
		c1.EOF_Comune_WS__c = 'Milano';
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.Origin = 'Portal';
        */
		Test.StartTest(); 
                 
        PO_TP_COMP_InserimentoTP_Controller ins_cont = new PO_TP_COMP_InserimentoTP_Controller();
		
        ins_cont.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        ins_cont.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        
        ins_cont.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont2 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont2.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        ins_cont2.slToInsert.EOF_Codice_Operatore__c = 'TIS';
        ins_cont2.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont2.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont2.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont3 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont3.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        ins_cont3.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont3.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont3.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
		
        ins_cont3.salvaC();
        
        Test.StopTest();
    }
    
      static testmethod void test_method5()
    {       
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
		
		string statoASistema;
		User userPoloMilano	=[Select id,Alias,Email,EmailEncodingKey,LastName,ProfileId,UserName,UserRoleId 
								from User where name = 'Segnalazioni Provisioning Polo Milano'];
		List<Case> ListaTicketProv = new List<Case>();								
     
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        
		EOF_EAI_Service_Log__c slToInsert2 = new EOF_EAI_Service_Log__c();
		slToInsert2.PO_TP_Causale_Apertura_Segnalazione__c='Segnalazione Provisioning';
		slToInsert2.PO_TP_Codice_Ordine_Ticket_Provisioning__c='TEST_76';
		slToInsert2.EOF_STATO_ORDINE__c='Acquisito';
		slToInsert2.PO_TP_Descrizione_Causale__c='Sollecito';
		slToInsert2.PO_TP_Dettaglio_Richiesta__c='Descrizione Causale Test';
		slToInsert2.PO_TP_Sottocausale__c='Sollecito attivazione';
		insert slToInsert2;
		
		Test.StartTest(); 
                 
        PO_TP_COMP_InserimentoTP_Controller ins_cont = new PO_TP_COMP_InserimentoTP_Controller();
		
        ins_cont.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        ins_cont.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        
        ins_cont.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont2 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont2.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c='Segnalazione Provisioning';
		ins_cont2.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c='SP_TEST_001';
		ins_cont2.slToInsert.EOF_STATO_ORDINE__c='Acquisito';
		ins_cont2.slToInsert.PO_TP_Descrizione_Causale__c='Sollecito';
		ins_cont2.slToInsert.PO_TP_Dettaglio_Richiesta__c='Descrizione Causale Test';
		ins_cont2.slToInsert.PO_TP_Sottocausale__c='Sollecito attivazione';
		ins_cont2.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont3 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont3.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        ins_cont3.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont3.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont3.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
		
        ins_cont3.salvaC();
        
        Test.StopTest();
    }
    
       static testmethod void test_method7()
    {       
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();  
		
		string statoASistema;
		User userPoloMilano	=[Select id,Alias,Email,EmailEncodingKey,LastName,ProfileId,UserName,UserRoleId 
								from User where name = 'Segnalazioni Provisioning Polo Milano'];
		List<Case> ListaTicketProv = new List<Case>();								
     
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
        
		
        case casoAttivazione = new case();
        RecordType rt = [Select id from RecordType where recordtype.developername = 'EOF_Caso_Attivazione'];
        casoAttivazione.Subject = 'Richiesta di attivazione';
        casoAttivazione.EOF_Codice_Ordine_OLO__c = 'TEST_76';
        casoAttivazione.EOF_Data_Prevista_Attivazione__c = system.today();
        casoAttivazione.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        casoAttivazione.Status = 'Espletato';
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
        
		Test.StartTest(); 
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont2 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont2.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = casoAttivazione.EOF_Codice_Ordine_OLO__c;
        ins_cont2.slToInsert.EOF_Codice_Operatore__c = 'TIS';
        ins_cont2.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont2.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        ins_cont2.salvaC();
        
        PO_TP_COMP_InserimentoTP_Controller ins_cont3 = new PO_TP_COMP_InserimentoTP_Controller();
        ins_cont3.slToInsert.PO_TP_Codice_Ordine_Ticket_Provisioning__c = casoAttivazione.EOF_Codice_Ordine_OLO__c;
        ins_cont3.slToInsert.EOF_Codice_Operatore__c = 'VF';
        ins_cont3.slToInsert.PO_TP_Descrizione_Causale__c = 'Sollecito';
        ins_cont3.slToInsert.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
		
        ins_cont3.salvaC();
        
        Test.StopTest();
    }
    
    //EC 2018 - 10 - 30 end
    
    static testmethod void test_methodTrigger1()
    {       
        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();   

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User standard = new User(alias = 'standtZ',email='test_standarduser@testorg.com',emailencodingkey='UTF-8',
                                    lastname='Testing', languagelocalekey='en_US', localesidkey='en_US', ProfileId = p.Id, 
                                    timezonesidkey='America/Los_Angeles',username='test_standarduser@prova.com');
        insert standard;

        Test.StartTest(); 
        System.runAs(standard)
        {            
            String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
            Case c = new Case();
            c.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
            c.Subject = 'Segnalazione Provisioning';
            c.Status = 'Acquisito';
            c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
            c.EOF_Codice_Operatore_WS__c = 'VF';
            c.OwnerId = standard.id;
            c.RecordTypeId = CaseRecordTypeId;
            c.Origin = 'Portal';
            insert c;     
            
            try{
                c.Status = 'In Lavorazione';    
                update c;  
            } 
            catch(Exception e)
            {
                System.debug(e);
            }
        }
        Test.StopTest();
    }
    
    static testmethod void test_methodTrigger2()
    {       
        OF_Enable_PO_UpdateOppCase_Trigger__c trig_PO_Upd = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trig_PO_Upd.Name = 'Status';
        trig_PO_Upd.OF_Enable_Trigger__c = true;
        insert trig_PO_Upd; 

        OF_Tibco_userID__c utente_tibco = UserTibcoCreation();   
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User standard = new User(alias = 'standtZ',email='test_standarduser@testorg.com',emailencodingkey='UTF-8',
                                    lastname='Testing', languagelocalekey='en_US', localesidkey='en_US', ProfileId = p.Id, 
                                    timezonesidkey='America/Los_Angeles',username='test_standarduser@prova.com');
        insert standard;

        Test.StartTest(); 
        System.runAs(standard)
        {            
            String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO - TP - TicketProvisioning Case').getRecordTypeId();
            Case c = new Case();
            c.PO_TP_Causale_Apertura_Segnalazione__c = 'Problema tecnico/applicativo';
            c.Subject = 'Incident Management';
            c.Status = 'Acquisito';
            c.EOF_Codice_Operatore_WS__c = 'VF';
            c.OwnerId = standard.id;
            c.RecordTypeId = CaseRecordTypeId;
            c.Origin = 'Portal';
            insert c;     
            
            try{
                c.Status = 'In Lavorazione';    
                update c;  
            } 
            catch(Exception e)
            {
                System.debug(e);
            }
        }
        Test.StopTest();
    }  
    
    
}