/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class EOF_GW_Utils_TEST3 {
	
    static testmethod void EOF_GW_Utils_testmethod_1(){
        //create profile
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        //end create profile
        
        //create user
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
        //end create user
        
        // create group
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        // end create group
        
        // OLO account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
        // end OLO account creation
        
        // person account creation
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
        // end person account creation
        
        // network inventory creation
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
        //end network inventory creation 
        
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        // end case creation
        
        // asset creation
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
       // end asset creation
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       	frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
        
        test.startTest();
        system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
        test.stopTest();
    }
    

    static testMethod void EOF_GW_Utils_TESTMETHOD_17() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
		User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.TIPO_COMUNICAZIONE = '1';
	    frequest.CODICE_ORDINE_OLO = '02112016_38';
	    
	    frequest.COGNOME_CLIENTE='';
	    frequest.CODICE_ORDINE_OLO = '02112016_39';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.tipo_comunicazione='1';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.CODICE_ORDINE_OLO = '02112016_40';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.CODICE_ORDINE_OLO = '02112016_41';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = null;
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_42';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_43';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='PG_01';
	    frequest.Provincia='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_44';
	    frequest.tipo_comunicazione='1';
	    frequest.Provincia='PG';
	    frequest.comune=''; 
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);



*/
	    
	    
	    
	     
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_18() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

        // User Creation
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.CODICE_ORDINE_OLO = '02112016_41';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = null;
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_42';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_43';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='PG_01';
	    frequest.Provincia='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    

		*/


	    
	    
	    
	     
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_19() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];

        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_43';
	    frequest.tipo_comunicazione='1';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='PG_01';
	    frequest.Provincia='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
 
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_2() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_44';
	    frequest.tipo_comunicazione='1';
	    frequest.Provincia='PG';
	    frequest.comune=''; 
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_45';
	    frequest.tipo_comunicazione='1';
	    frequest.Provincia='PG';
	    frequest.comune='Perugia'; 
	    frequest.indirizzo='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_46';
	    frequest.tipo_comunicazione='1';
	    frequest.Provincia='PG';
	    frequest.comune='Perugia'; 
	    frequest.indirizzo='via dei Pini';
	    frequest.numero_civico='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_47';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_48';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_49';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_50';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='10_054_054039_8000064301_40';
	    frequest.NOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_51';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    */
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_20() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_46';
	    frequest.tipo_comunicazione='1';
	    frequest.Provincia='PG';
	    frequest.comune='Perugia'; 
	    frequest.indirizzo='via dei Pini';
	    frequest.numero_civico='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_47';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_48';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_49';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_50';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='10_054_054039_8000064301_40';
	    frequest.NOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_51';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    */
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_21() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_48';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_49';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_50';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='10_054_054039_8000064301_40';
	    frequest.NOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_51';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    */
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_22() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_50';
	    frequest.tipo_comunicazione='1';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='10_054_054039_8000064301_40';
	    frequest.NOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_51';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_3() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_52';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_53';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_54';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_55';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    for(integer x=0; x<55; x++){
	    	frequest.NOME_REFERENTE_TECNICO_OLO=frequest.NOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_56';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
	    for(integer x=0; x<55; x++){
	    	frequest.COGNOME_REFERENTE_TECNICO_OLO=frequest.COGNOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	     
	    
	    
	    
	    frequest.TIPO_COMUNICAZIONE = '11';
	    frequest.CODICE_ORDINE_OLO = '02112016_39';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    */
	    system.test.stopTest();
        
    }
     static testMethod void EOF_GW_Utils_TESTMETHOD_30() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_54';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_55';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    for(integer x=0; x<55; x++){
	    	frequest.NOME_REFERENTE_TECNICO_OLO=frequest.NOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_56';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
	    for(integer x=0; x<55; x++){
	    	frequest.COGNOME_REFERENTE_TECNICO_OLO=frequest.COGNOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	     
	    
	    
	    
	    frequest.TIPO_COMUNICAZIONE = '11';
	    frequest.CODICE_ORDINE_OLO = '02112016_39';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    */
	    system.test.stopTest();
        
    }
     static testMethod void EOF_GW_Utils_TESTMETHOD_31() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_56';
	    frequest.tipo_comunicazione='1';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
	    for(integer x=0; x<55; x++){
	    	frequest.COGNOME_REFERENTE_TECNICO_OLO=frequest.COGNOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	     
	    
	    
	    
	    frequest.TIPO_COMUNICAZIONE = '11';
	    frequest.CODICE_ORDINE_OLO = '02112016_39';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_4() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_56';
	    frequest.tipo_comunicazione='1';
	    for(integer x=0; x<55; x++){
	    	frequest.TELEFONO_REFERENTE_TECNICO_OLO=frequest.TELEFONO_REFERENTE_TECNICO_OLO+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_58';
	    frequest.tipo_comunicazione='1';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
	    for(integer x=0; x<55; x++){
	    	frequest.IDENTIFICATIVO_DEL_POP=frequest.IDENTIFICATIVO_DEL_POP+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_40() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_59';
	    frequest.tipo_comunicazione='1';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    for(integer x=0; x<75; x++){
	    	frequest.COGNOME_CLIENTE=frequest.COGNOME_CLIENTE+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.CODICE_ORDINE_OLO = '02112016_60';
	    frequest.tipo_comunicazione='1';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    for(integer x=0; x<75; x++){
	    	frequest.RECAPITO_TELEFONICO_CLIENTE_1=frequest.RECAPITO_TELEFONICO_CLIENTE_1+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    /*
	    frequest.CODICE_ORDINE_OLO = '02112016_61';
	    frequest.tipo_comunicazione='1';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1='1234';
	    frequest.OPZIONE_SYSTEM_UNICO='s';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_62';
	    frequest.tipo_comunicazione='1';
	    frequest.GPON_VINCOLANTE='s';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    */
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_42() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_61';
	    frequest.tipo_comunicazione='1';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1='1234';
	    frequest.OPZIONE_SYSTEM_UNICO='s';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_62';
	    frequest.tipo_comunicazione='1';
	    frequest.GPON_VINCOLANTE='s';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_5() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.apparato='s';
	    frequest.CODICE_ORDINE_OLO = '02112016_62';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.SLA_PREMIUM_ASSURANCE='s';
	    frequest.CODICE_ORDINE_OLO = '02112016_63';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_50() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.apparato='s';
	    frequest.CODICE_ORDINE_OLO = '02112016_62';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.SLA_PREMIUM_ASSURANCE='s';
	    frequest.CODICE_ORDINE_OLO = '02112016_63';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_51() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    frequest.tipologia_servizio='si';
	    frequest.CODICE_ORDINE_OLO = '02112016_64';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.COLLEGAMENTO_P2P='si';
	    frequest.CODICE_ORDINE_OLO = '02112016_65';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_52() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.PROGETTO_SPECIALE=frequest.PROGETTO_SPECIALE+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_66';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.TIPOLOGIA_APPARATO=frequest.TIPOLOGIA_APPARATO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_67';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_53() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH=frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_68';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_6() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    for(integer x=0; x<55; x++){
	    	frequest.PASSWORD_APPARATO=frequest.PASSWORD_APPARATO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_68';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.RECAPITO_TEST_LINEA=frequest.RECAPITO_TEST_LINEA+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_69';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_61() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.SCALA_PALAZZINA=frequest.SCALA_PALAZZINA+'a';
	    }	    
	    frequest.CODICE_ORDINE_OLO = '02112016_70';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.GPON_ATTESTAZIONE=frequest.GPON_ATTESTAZIONE+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_71';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.RECAPITO_TELEFONICO_CLIENTE_2=frequest.RECAPITO_TELEFONICO_CLIENTE_2+'a';
	    }
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_62() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.RECAPITO_TELEFONICO_CLIENTE_2=frequest.RECAPITO_TELEFONICO_CLIENTE_2+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_72';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.NOME_CLIENTE=frequest.NOME_CLIENTE+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_73';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_63() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA=frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_74';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_7() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.PARTICELLA_TOPONOMASTICA=frequest.PARTICELLA_TOPONOMASTICA+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_69';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.NUMERO_CIVICO=frequest.NUMERO_CIVICO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_70';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
     static testMethod void EOF_GW_Utils_TESTMETHOD_70() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.INDIRIZZO=frequest.INDIRIZZO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_71';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.COMUNE=frequest.COMUNE+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_72';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
     static testMethod void EOF_GW_Utils_TESTMETHOD_72() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	   
	    for(integer x=0; x<55; x++){
	    	frequest.PROVINCIA=frequest.PROVINCIA+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_73';
	    frequest.tipo_comunicazione='1';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    
	    
	    system.test.stopTest();
        
    }

    static testMethod void EOF_GW_Utils_TESTMETHOD_80() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.TIPO_COMUNICAZIONE = '1';
	   
	    frequest.COGNOME_CLIENTE='';
	    frequest.CODICE_ORDINE_OLO = '02112016_39';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.tipo_comunicazione='11';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.CODICE_ORDINE_OLO = '02112016_40';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_81() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.CODICE_ORDINE_OLO = '02112016_41';
	    frequest.tipo_comunicazione='11';
	    frequest.data_notifica = null;
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_42';
	    frequest.tipo_comunicazione='11';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_82() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_43';
	    frequest.tipo_comunicazione='11';
	    frequest.data_notifica = EOF_GW_GE_Utils.DateToString(datetime.now());
	    frequest.IDENTIFICATIVO_DEL_POP='PG_01';
	    frequest.Provincia='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_44';
	    frequest.tipo_comunicazione='11';
	    frequest.Provincia='PG';
	    frequest.comune=''; 
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_9() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_45';
	    frequest.tipo_comunicazione='11';
	    frequest.Provincia='PG';
	    frequest.comune='Perugia'; 
	    frequest.indirizzo='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.CODICE_ORDINE_OLO = '02112016_46';
	    frequest.tipo_comunicazione='11';
	    frequest.Provincia='PG';
	    frequest.comune='Perugia'; 
	    frequest.indirizzo='via dei Pini';
	    frequest.numero_civico='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_90() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_47';
	    frequest.tipo_comunicazione='11';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_48';
	    frequest.tipo_comunicazione='11';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_91() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_49';
	    frequest.tipo_comunicazione='11';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_50';
	    frequest.tipo_comunicazione='11';
	    frequest.numero_civico='41';
	    frequest.particella_toponomastica='Via';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='4444';
	    frequest.ID_BUILDING='10_054_054039_8000064301_40';
	    frequest.NOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	   
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_92() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_51';
	    frequest.tipo_comunicazione='11';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_10() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_52';
	    frequest.tipo_comunicazione='11';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_53';
	    frequest.tipo_comunicazione='11';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_100() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_54';
	    frequest.tipo_comunicazione='11';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_55';
	    frequest.tipo_comunicazione='11';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    for(integer x=0; x<30; x++){
	    	frequest.NOME_REFERENTE_TECNICO_OLO=frequest.NOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_101() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	   
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_56';
	    frequest.tipo_comunicazione='11';
	    frequest.NOME_REFERENTE_TECNICO_OLO='Andrea';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO='Rossi';
	    for(integer x=0; x<55; x++){
	    	frequest.COGNOME_REFERENTE_TECNICO_OLO=frequest.COGNOME_REFERENTE_TECNICO_OLO+'a';
	    }
        frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
        frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
        frequest.GPON_VINCOLANTE='Y';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	     
	    
	    
	    
	    frequest.TIPO_COMUNICAZIONE = '11';
	    frequest.CODICE_ORDINE_OLO = '02112016_39';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_11() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_56';
	    frequest.tipo_comunicazione='11';
	    for(integer x=0; x<30; x++){
	    	frequest.TELEFONO_REFERENTE_TECNICO_OLO=frequest.TELEFONO_REFERENTE_TECNICO_OLO+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_58';
	    frequest.tipo_comunicazione='11';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO='4444';
	    for(integer x=0; x<55; x++){
	    	frequest.IDENTIFICATIVO_DEL_POP=frequest.IDENTIFICATIVO_DEL_POP+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_110() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_59';
	    frequest.tipo_comunicazione='11';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    for(integer x=0; x<75; x++){
	    	frequest.COGNOME_CLIENTE=frequest.COGNOME_CLIENTE+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.CODICE_ORDINE_OLO = '02112016_60';
	    frequest.tipo_comunicazione='11';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO='test@test.it';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    for(integer x=0; x<75; x++){
	    	frequest.RECAPITO_TELEFONICO_CLIENTE_1=frequest.RECAPITO_TELEFONICO_CLIENTE_1+'a';
	    }
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_111() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_61';
	    frequest.tipo_comunicazione='11';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1='1234';
	    frequest.OPZIONE_SYSTEM_UNICO='s';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_62';
	    frequest.tipo_comunicazione='11';
	    frequest.GPON_VINCOLANTE='s';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_12() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    frequest.apparato='s';
	    frequest.CODICE_ORDINE_OLO = '02112016_62';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.SLA_PREMIUM_ASSURANCE='s';
	    frequest.CODICE_ORDINE_OLO = '02112016_63';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_121() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    frequest.tipologia_servizio='si';
	    frequest.CODICE_ORDINE_OLO = '02112016_64';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    frequest.COLLEGAMENTO_P2P='si';
	    frequest.CODICE_ORDINE_OLO = '02112016_65';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_122() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.PROGETTO_SPECIALE=frequest.PROGETTO_SPECIALE+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_66';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.TIPOLOGIA_APPARATO=frequest.TIPOLOGIA_APPARATO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_67';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_123() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH=frequest.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_68';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
   
    static testMethod void EOF_GW_Utils_TESTMETHOD_13() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    for(integer x=0; x<55; x++){
	    	frequest.PASSWORD_APPARATO=frequest.PASSWORD_APPARATO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_68';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.RECAPITO_TEST_LINEA=frequest.RECAPITO_TEST_LINEA+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_69';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_130() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.SCALA_PALAZZINA=frequest.SCALA_PALAZZINA+'a';
	    }	    
	    frequest.CODICE_ORDINE_OLO = '02112016_70';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.GPON_ATTESTAZIONE=frequest.GPON_ATTESTAZIONE+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_71';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_131() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.RECAPITO_TELEFONICO_CLIENTE_2=frequest.RECAPITO_TELEFONICO_CLIENTE_2+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_72';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<55; x++){
	    	frequest.NOME_CLIENTE=frequest.NOME_CLIENTE+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_73';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_132() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA=frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA+'a';
	    }
	    
	    frequest.CODICE_ORDINE_OLO = '02112016_74';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_14() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    for(integer x=0; x<20; x++){
	    	frequest.PARTICELLA_TOPONOMASTICA=frequest.PARTICELLA_TOPONOMASTICA+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_69';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<8; x++){
	    	frequest.NUMERO_CIVICO=frequest.NUMERO_CIVICO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_70';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_140() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    
	    for(integer x=0; x<55; x++){
	    	frequest.INDIRIZZO=frequest.INDIRIZZO+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_71';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    for(integer x=0; x<50; x++){
	    	frequest.COMUNE=frequest.COMUNE+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_72';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    system.test.stopTest();
        
    }
    
    static testMethod void EOF_GW_Utils_TESTMETHOD_141() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
       // frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    
	    
	    
	    
	    for(integer x=0; x<20; x++){
	    	frequest.PROVINCIA=frequest.PROVINCIA+'a';
	    }
	    frequest.CODICE_ORDINE_OLO = '02112016_73';
	    frequest.tipo_comunicazione='11';
	    insert EOF_GW_GE_Utils.create_EAI_Log(frequest);
	    EOF_GW_Utils.checkSync(frequest);
	    
	    
	    
	    
	    
	    system.test.stopTest();
        
    }
    /*
    static testMethod void EOF_GW_Utils_TESTMETHOD_15() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.TIPO_COMUNICAZIONE = '2';
	    EOF_GW_Utils.checkSync(frequest);
	    
	    system.test.stopTest();
        
    }
    static testMethod void EOF_GW_Utils_TESTMETHOD_150() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='dprobertdemo1@camfed.org');
        insert u;
          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	
	    frequest.TIPO_COMUNICAZIONE = '3';
	    EOF_GW_Utils.checkSync(frequest);
	    frequest.TIPO_COMUNICAZIONE = '4';
	    EOF_GW_Utils.checkSync(frequest);
	    
	   
	    system.test.stopTest();
        
    }
    */
    static testMethod void EOF_GW_Utils_TESTMETHOD_151() {
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        // User Creation
        
        User u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;

          
        Group bo = [SELECT Id FROM Group WHERE Name = 'Coda Operatori BO' AND Type = 'Queue'];
        system.debug('U-----' + u.Id);
        
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
        
       EOF_Network_Inventory__c i =new EOF_Network_Inventory__c();
       i.EOF_ID_BUILDING__C = '10_054_054039_8000064301_40';
       i.EOF_Stato_Building__c=104;
       i.EOF_Pop__c='PG_01';
       insert i;
       
       
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today().addDays(1);
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
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
        c.OwnerId = u.Id;
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c=true;
        insert c;
        
        Asset a = new Asset();
       a.status='Attivo';
       a.EOF_ID_Risorsa__c='risorsa';
       a.name=c.Id;
       a.accountId=accOlo.id;
       insert a;
        
         String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
        EOF_Notify__c objEOF = new EOF_Notify__c();
        objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
        objEOF.EOF_ID_Notifica__c = 'Test Id';
        objEOF.EOF_Stato_Richiesta__c = 'OK';
        objEOF.EOF_Codice_Operatore__c = 'VF';
        objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
        objEOF.EOF_Data_Notifica__c = system.now();
        objEOF.EOF_Note__c = 'Test Note';
        objEOF.EOF_Inviata__c = false;
        objEOF.Caso__c = c.id;
        objEOF.RecordTYpeId = NotifyRecordTypeId;
        
        insert objEOF;
        
        EOF_GW_WS_Request.returnFiberResponse rfr =new EOF_GW_WS_Request.returnFiberResponse();
        EOF_GW_WS_Request.fiberRequest frequest = new EOF_GW_WS_Request.fiberRequest();
        frequest.TIPO_COMUNICAZIONE = '2';
	    frequest.CODICE_OPERATORE = 'VF';
	    frequest.CODICE_ORDINE_OLO = '02112016_37';
	    frequest.DATA_NOTIFICA = EOF_GW_GE_Utils.DateToString(system.today());
	    frequest.ID_NOTIFICA = 'test_01';
	    frequest.IDENTIFICATIVO_DEL_POP = 'PG_01';
	    frequest.GPON_ATTESTAZIONE = 'rwrfsaac';
	    frequest.GPON_VINCOLANTE = 'N';
	    frequest.ID_RISORSA = 'risorsa';
	    frequest.NOME_CLIENTE = 'XYZ';
	    frequest.COGNOME_CLIENTE = 'XYZ';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_1 = '4444';
	    frequest.RECAPITO_TELEFONICO_CLIENTE_2 = '55555';
	    frequest.PROVINCIA = 'Milano';
	    frequest.NUMERO_TELEFONICO_PRINCIPALE_LINEA='111';
	    frequest.COMUNE = 'Milano';
	    frequest.PARTICELLA_TOPONOMASTICA = '123';
	    frequest.INDIRIZZO = 'Piazzale Gorini';
	    frequest.NUMERO_CIVICO = '6';
	    frequest.ID_BUILDING = '10_054_054039_8000064301_40';
	    frequest.SCALA_PALAZZINA = '';
	    frequest.NOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.COGNOME_REFERENTE_TECNICO_OLO = 'Gianni';
	    frequest.TELEFONO_REFERENTE_TECNICO_OLO = '1234';
	    frequest.EMAIL_REFERENTE_TECNICO_OLO = 'Gianni@test.it';
	    frequest.DATA_PREVISTA_ATTIVAZIONE = EOF_GW_GE_Utils.DateToStringNoTime(date.newInstance(2099,12,21));
	    frequest.CAUSALE_RICHIESTA_ANNULLAMENTO = 'A_K8';
	    frequest.CODICE_RICHIESTA_ANNULLAMENTO = 'Test Error';
	    frequest.APPARATO = '';
	    frequest.TIPOLOGIA_APPARATO = 'test';
	    frequest.NOTE = 'xyz';
	    frequest.TIPOLOGIA_SERVIZIO = '1';
	    frequest.SLA_PREMIUM_ASSURANCE = 'Y';
	    frequest.ORARIO_APPUNTAMENTO = '12:34:56';
	    system.test.startTest();
	    system.Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
	    frequest.TIPO_COMUNICAZIONE = '1';
	    EOF_GW_Utils.fr_tmp=frequest;
	    EOF_GW_Utils.create_notify(c, 5, 'KO', 'B_K4', 'test');
	    EOF_GW_Utils.create_notify(c, 5, 'KO', 'B_K5', 'test');
	    EOF_GW_Utils.create_notify(c, 5, 'KO', 'B_K6', 'test');
	    EOF_GW_Utils.create_notify(c, 5, 'KO', 'A_K3', 'test');
	    EOF_GW_Utils.create_notify(c, 5, 'KO', 'A_K14', 'test');
	    EOF_GW_Utils.create_notify(c, 12, 'KO', 'C_K13', 'test');
	    
	    system.test.stopTest();
        
    }
}