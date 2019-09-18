@isTest
public class PO_TP_COMP_VisualizzaTP_Controller_TEST{
    
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

        /*
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = p.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser;
        */ 

        case casoAttivazione = new case();
        RecordType rt = [Select id from RecordType where recordtype.developername = 'EOF_Caso_Attivazione'];
        casoAttivazione.Subject = 'Richiesta di attivazione';
        casoAttivazione.EOF_Codice_Ordine_OLO__c = 'TEST_76';
        casoAttivazione.EOF_Data_Prevista_Attivazione__c = system.today();
        casoAttivazione.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        casoAttivazione.Status = 'In Lavorazione';
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
        Case c = new Case();
        c.Subject = 'Segnalazione Provisioning';
        c.Status = 'Acquisito';
        c.PO_TP_Codice_Ordine_Ticket_Provisioning__c = 'TEST_76';
        c.PO_TP_Ordine_Di_Riferimento__c = casoAttivazione.id;
        c.PO_TP_Causale_Apertura_Segnalazione__c = 'Segnalazione Provisioning';
        c.PO_TP_Escalation__c = true;
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.Origin = 'Portal';
        c.EOF_Comunicazioni_con_OLO__c = 'comunicazioni con olo';
        insert c;        

        Test.StartTest();
        Test.setCurrentPageReference(new PageReference('PO_TP_InsertNewRequest')); 
        System.currentPageReference().getParameters().put('origId', c.id);
        System.currentPageReference().getParameters().put('escalated', 'true');
        //System.currentPageReference().getParameters().put('proc', 'TPVisualizza');
        
        PO_TP_COMP_VisualizzaTP_Controller visualizza_cont = new PO_TP_COMP_VisualizzaTP_Controller();
        PageReference annullaTicket = visualizza_cont.annullaTicketPro();
        PageReference vsAnnullamento = visualizza_cont.vsAnnullamento();
        PageReference showPopup = visualizza_cont.showPopup();
        PageReference closePopup = visualizza_cont.closePopup();   
        PageReference vsNote = visualizza_cont.vsNote();
        PageReference salvaNota = visualizza_cont.SalvaNota();  
        PageReference vsAnnullaNota = visualizza_cont.vsAnnullaNota();
        visualizza_cont.caseAttTicketMap = new Map<Id,Id>();
        visualizza_cont.cA = c;
        //visualizza_cont.showAnnButton();
        Test.StopTest();
    }   
}