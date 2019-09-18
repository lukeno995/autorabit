@isTest
public class PO_TP_COMP_ListaBozze_Controller_Test {
     @testsetup
    static void createData()
    {
         Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true); 
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        insert acc;
        Asset a = new Asset();
        a.Name='test_01';
        a.AccountId = acc.id;
        a.Status='Attivo';
        insert a;
        list<case> caselist = new list<case>();
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
           Case c = new Case();
            c.EOF_Account_OLO__c = accOLO.Id;
            c.Subject = 'Richiesta di attivazione';
            c.EOF_Codice_Ordine_OLO__c = '02112016_37';
            c.EOF_Data_Prevista_Attivazione__c = system.today();
            c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c.Status = 'Acquisito';
            c.EOF_Fase__c = 'In Verifica BO';
            c.Type = '1';
            c.EOF_Tipologia_Servizio__c = 'test sasya1';
            c.EOF_Codice_Operatore_WS__c = 'VF';
            c.EOF_SLA_Premium_Assurance__c ='Y';
            c.Account = acc;
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c.EOF_Numero_Civico_WS__c = '7';
            c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c.EOF_Recapito_Test_Linea__c = '111';
            c.EOF_Tipologia_Apparato__c = 'test';
            c.OwnerId = userInfo.getUserId();
            c.RecordTypeId = CaseRecordTypeId;
            c.EOF_Id_Notifica__c = 'test_01';
            c.Origin = 'Web';
            c.OF_Retry_Automatico__c = false;
            c.OF_Response_Da_OLO__c='NACK TECNICO';
          //  c.OF_Response_Da_OM__c = 'NACK TECNICO';
            c.Priority = 'Medium';
            c.EOF_GPON_Vincolante__c = 'Y';
            c.PO_SA_Portale__C = false;
            c.OF_Bonifica_Locked_Row__c = false;
           insert c;
        
        EOF_GW_WS_Request.FiberRequest frequest = new EOF_GW_WS_Request.FiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
        
        //-----insert EAI Service Log------
        list<EOF_EAI_Service_Log__c> vlstslog = new list<EOF_EAI_Service_Log__c>();
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog.recordTypeId = eaiRecordType;
        eaiLog.EOF_Tipo_Comunicazione__c = '1';
        eaiLog.EOF_ID_Risorsa__c = 'Test_01';
        vlstslog.add(eaiLog);
       
         String eaiRecordType1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ChangeOrderRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog1 = new EOF_EAI_Service_Log__c();
        eaiLog1.Caso__c  = c.Id;
        eaiLog1.EOF_ID_Notifica__c = 'test_02';
        eaiLog1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        eaiLog1.EOF_Tipo_COmunicazione_String__c = 'SF->OM%';
         eaiLog1.EOF_Tipo_Comunicazione__c = '11';
         eaiLog.EOF_ID_Risorsa__c = 'Test_01';
        eaiLog1.recordTypeId = eaiRecordType1;
        vlstslog.add(eaiLog1);
        insert vlstslog;
    }
    
     static TestMethod void ViewDettagliBozze_test(){
     Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO_CO_FiberRequest').getRecordTypeId();
        
        
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Contact con = new Contact();
        con.LastName= 'Test';
        con.AccountId = acc.Id;
        insert con;
        
        Profile p = [select id from profile where name='Partner Community Super User'];

        User u = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US', profileid = p.Id, country='United States',
            ContactId = con.Id,
            timezonesidkey='America/Los_Angeles', username='test1230@noemail.com');
        insert u;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
        // System.RunAs(thisUser){
         EOF_EAI_Service_Log__c  service = new EOF_EAI_Service_Log__c ();
        //service.OF_SA_ACK__c = True;
        service.EOF_Stato_Richiesta__c='Bozza Portale';
        service.EOF_ID_Risorsa__c = a.name;
        service.EOF_Tipo_Comunicazione_String__c = 'Change Order';
        service.RecordTypeId = RecordTypeIdser;
        insert service;
        
       
        
         
        System.debug('@@@Service'+service);
        
           case c = [SELECT Id, CaseNumber, AccountId, RecordTypeId, Status, Origin, Subject, Description, EOF_Codice_Ordine_OLO__c, 
                  EOF_Id_Notifica__c, EOF_Identificativo_del_POP__c, EOF_GPON_Attestazione__c, EOF_GPON_Vincolante__c, 
                  EOF_Impresa__c, EOF_Id_Risorsa__c, EOF_Recapito_Telefonico_Cliente_1__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Comunicazione_OLO__c, 
                  EOF_Data_Notifica__c,OF_SA_Motivazione__c,EOF_Collegamento_P2P__c,OF_SA_Id_Servizio__c,OF_SA_CODICE_MOTIVAZIONE__c,
                  EOF_Provincia_WS__c,EOF_Comune_WS__c,EOF_Particella_Toponomastica_WS__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c, 
                  EOF_Opzione_System_Unico__c , PO_SA_Portale__C,OF_Bonifica_Locked_Row__c FROM Case where  EOF_Tipologia_Servizio__c = 'test sasya1' limit 1];
     
          list<EOF_EAI_Service_Log__c> sl = [select id, EOF_Tipo_comunicazione_String__c,OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,
                                     Caso__c,EOF_Codice_Operatore__c,EOF_Codice_Ordine_Olo__c,EOF_Data_Notifica__c,
                                     EOF_Stato_Richiesta__c,EOF_ID_NOTIFICA__C,OF_SA_ESITO__C,EOF_CODICE_MOTIVAZIONE__C,
                                     EOF_MOTIVAZIONE__C,EOF_Retry__c,EOF_Codice_Errore__c,EOF_Causale_Errore__c,EOF_Codice_Ordine_EOF__c,
                                     EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,EOF_TIPOLOGIA_APPARATO__C,OF_SA_SERVICE_VLAN__C,
                                     OF_SA_ESITO_RITIRO_APPARATO__C,EOF_Nome_Cliente__c,EOF_COGNOME_CLIENTE__c,
                                     EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                                     EOF_PIN_INTERVENTO_A_VUOTO__c,EOF_NOTE__c
                                     from EOF_EAI_Service_Log__c 
                                     where EOF_ID_Notifica__c = 'test_01'];
        OF_CodificaProfiloListini__c cp = new OF_CodificaProfiloListini__c();
         // OF_CodificaProfiloListini__c.LogWrapper wrap = new OF_CodificaProfiloListini__c.LogWrapper();
        cp.name = '1';
        cp.IsPortalValid__c = true;
        cp.OF_ListinoCanoneName__c = 'testStream';
        cp.OF_ProfiloCommerciale__c = 'Test Profile';
        cp.OF_Profilolistino__c = 'Test Record';
        insert cp;
        PO_TP_COMP_ListaBozze_Controller.BozzeWrapper bw = new PO_TP_COMP_ListaBozze_Controller.BozzeWrapper();     
        system.runas(u){   
        PO_TP_COMP_ListaBozze_Controller classetest = new PO_TP_COMP_ListaBozze_Controller();
       /* EOF_EAI_Service_Log__c item = new EOF_EAI_Service_Log__c();
        item.Id='a008E000008cZw9QAE';
        item.EOF_ID_Risorsa__c='12345';
        item.EOF_PROFILO__c='prof';
        item.EOF_STATO_ORDINE__c='attiv';
        item.EOF_Data_Ora_Creazione__c=Date.parse('25/07/2018');*/
        bw.id='Testing';
        bw.IDRisorsa='Testing';
        bw.Profilo='Testing';
        bw.Stato= 'Testing';
        bw.Listino = 'Testing';
        bw.IdScelta = 'CO';
        bw.DataAttivazione= 'Testing';
        classetest.pageDown();
        classetest.pageUp();
        classetest.setPagination(true);
        classetest.preparePage();
        classetest.IdScelta = service.Id;
        classetest.offset_page = 123;
        classetest.idRis = 'Test';
        classetest.ViewDettagliBozze();
      }     
    } 
}