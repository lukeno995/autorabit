@isTest
public class OF_PP_WS_IN_OM_ResponseUpdate_Test {
    
    public static Account accountCreation(){

        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Phone = '081861784512';
        acc.EOF_Phone_2__c = '081861784512';
        acc.EOF_Provincia__c = 'Napoli';
        acc.EOF_Comune__c = 'Napoli';
        acc.EOF_Indirizzo__c = 'Piazza Plebiscito';
        acc.RecordTYpeId = AccountRecordTypeId;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '71';        
        insert acc;

        return acc;
    }
    
    public static Case caseKitCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning KITConsegna').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.OF_SA_Profilo__c = 'AG_11_36';
        c.accountId = acc.id;
        c.Status = 'Espletato';
        insert c;
        return c;
    }
    
    public static Case caseVlanCreation(Account acc)
    {
        Case c = new Case();
        String rTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO PreProvisioning VLAN').getRecordTypeId();
        c.RecordTypeId = rTypeId;
        c.PO_PP_NomeKit__c = 'TEST_K';
        c.OF_SA_Profilo__c = 'AG_11_36';
        c.accountId = acc.id;
        c.Status = 'Accettato';
        insert c;
        return c;
    }
    
    public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        return catalogo;
    }
    
    public static OF_Servizio__c ServizioPP_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'PREPROVISIONING';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio;
        servizio.OF_DataFineValidita__c = fine;
        servizio.OF_CatalogoCommerciale__c = cat.id;
        insert servizio;
        return servizio;
    }
    
    public static OF_CommercialElement__c CE_Kit_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO KIT';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    }  
    
    public static OF_CommercialElement__c CE_Vlan_Creation(OF_Servizio__c serv)
    {
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        ce.name = 'SERVIZIO VLAN';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio;
        ce.OF_DataFineValidita__c = fine;
        ce.OF_Servizio__c = serv.id;
        insert ce;
        return ce;
    } 
    
    public static Contract createContract(Account acc)
    {
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        return contratto;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract con, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
        cs.OF_Contract__c = con.id;
        cs.OF_Servizio__c = serv.id;
        insert cs;
        return cs;
    }
    
    public static Asset assetCreation(Account acc){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Preprovisioning').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'Test Asset PP';
        asset_1.Status = 'Attivo';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.AccountId = acc.id;
        insert asset_1;
        return asset_1;
    }
    
    static testmethod Map<String,String> RecordType()
    { 
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
        
        for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    
   static testMethod void testOLO_PreProv_StatusUpdate(){
       
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        //Profile p = [SELECT Id FROM Profile WHERE Name='Partner Community Super User'];
        //User u = [SELECT Id FROM user WHERE Name='Mario Rossi' and Profile.name='Partner Community Super User'];
       
        //Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true); 
        //System.runAs(u) {
              // The following code runs as user 'u'
              System.debug('Current User: ' + UserInfo.getUserName());
              System.debug('Current Profile: ' + UserInfo.getProfileId());
         
        Profile prf = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Usr = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt11', Email = 'unitTestMail111@atos.net', 
                                 EmailEncodingKey = 'UTF-8', LastName='Testing11', LanguageLocaleKey = 'en_US', 
                                 LocaleSidKey = 'en_US', ProfileId = prf.Id,UserRoleID = Usr.Id, 
                                 TimeZoneSidKey = 'America/Los_Angeles', UserName = 'PFProduction@test.com',isactive = true);
        insert thisUser;
        
        System.RunAs(thisUser)
        {   
            OF_Enable_PO_UpdateOppCase_Trigger__c tr = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            tr.Name = 'Status';
            tr.OF_Enable_Trigger__c = false;
            insert tr;
            
            Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
            
            List<RecordType> rtypes = [Select Name, Id 
                                       From RecordType 
                                       where (sObjectType='Case' OR sObjectType='Account') 
                                       and isActive=true];
            
            Map<String,String> RecordTyp = new Map<String,String>{};
            RecordType rt = [select id,Name 
                            from RecordType 
                            where SobjectType='case' 
                            and DeveloperName  ='OF_PP_PreProvisioning_Vlan' Limit 1];
            
            for(RecordType rtp: rtypes)
                RecordTyp.put(rtp.Name,rtp.Id);
            
            //Map<String,String> RecordTypeMap = RecordType();
            
            Account a = accountCreation();
            Case c = caseKitCreation(a);
            Case c2 = caseVlanCreation(a);
            Asset asset_1 = assetCreation(a);
            
            OF_CatalogoCommerciale__c cat = Catalogo_Creation();
            OF_Servizio__c servPP = ServizioPP_Creation(cat);
            OF_CommercialElement__c ce_kit = CE_Kit_Creation(servPP);
            OF_CommercialElement__c ce_vlan = CE_Vlan_Creation(servPP);
            
            Contract contratto = createContract(a);
            OF_Servizio__c servOpenStream = Servizio_Creation(cat);
            OF_ContrattoServizio__c cs = createContrattoServizio(contratto,servOpenStream);

            /**Account**/
            Account accOloWIND = new Account();       
            accOloWIND.Name = 'Tiscali';
            accOloWIND.EOF_Codice_Operatore__c = 'TIS';
            accOloWIND.Type = 'OLO';
            accOloWIND.Industry = 'Telecommunications';
            accOloWIND.RecordTYpeId = RecordTyp.get('OLO');
            insert accOloWIND;
            /**End Account**/
           
            /**Case**/
            Case c1 = new Case(); 
            c1.RecordTypeId = rt.id;
            c1.subject = 'Richiesta Attivazione VLAN';
            c1.status = 'Accettato';
            c1.EOF_FASE__C = 'NA';
            insert c1;
            
            OF_PP_GE_Utils.caseOriginale = c1;
            
                        // Inserting test Account
            Account acc = new Account();
            acc.name = 'Tiscali';
            acc.EOF_Codice_Operatore__c = 'TIS';
            insert acc;
            
            // Inserting test contact
            contact contatto = new contact();
            contatto.FirstName = 'Vlado';
            contatto.lastname = 'Test';
            contatto.Email = 'email@abc.com';
            contatto.PO_Contatto_telefonico__c ='1234';
            contatto.PO_N_Licenza__c = 'test';
            contatto.PO_Struttura_di_appartenenza__c = 'test';
            contatto.AccountId = acc.Id;
            contatto.PO_Super_User__c = true;
            insert contatto;
            
            Profile prof = [SELECT Id 
                            FROM Profile 
                            WHERE Name='Partner Community Super User'];
            
            // Inserting test user 
            User portal_user = new User();
            portal_user.Firstname = 'John';
            portal_user.LastName = 'Smith';
            portal_user.email = 'msmithtest25@company.com';
            portal_user.Alias = 'alias12';
            portal_user.CommunityNickname = 'commnick';
            portal_user.EmailEncodingKey = 'UTF-8';
            portal_user.Username = 'msmithtest25@company.com';
            portal_user.TimeZoneSidKey = 'America/Denver';
            portal_user.LocaleSidKey = 'en_US';
            portal_user.EmailEncodingKey = 'UTF-8';
            portal_user.LanguageLocaleKey = 'en_US';
            portal_user.ProfileId = prof.Id;
            portal_user.ContactId = contatto.id;
            insert portal_user;
            
            //Updating  Test contact owner with Test user 
            contatto.ownerid = portal_user.id;
            update contatto;
            
            OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN RescheduleRequest = new OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN();

            RescheduleRequest.CODICE_OPERATORE = 'TIS';
            RescheduleRequest.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            RescheduleRequest.ID_NOTIFICA = 'Test';
            //RescheduleRequest.NOME_CLIENTE = 'Test';
            //RescheduleRequest.COGNOME_CLIENTE = 'Test';
            //RescheduleRequest.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
            //RescheduleRequest.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
            //RescheduleRequest.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
            //RescheduleRequest.ORARIO_APPUNTAMENTO = 'Test';
            RescheduleRequest.CODICE_ORDINE_SFDC='test';
            RescheduleRequest.CODICE_ORDINE_SO=c.id;
            RescheduleRequest.STATO_ORDINE='10';
            RescheduleRequest.SERVICE_VLAN_ID='1234';
            RescheduleRequest.USER_VLAN='835';
            RescheduleRequest.NOTE = 'Test';
            //RescheduleRequest.COS = 'Test';
            RescheduleRequest.CODICE_MOTIVAZIONE = '01'; 
            RescheduleRequest.MOTIVAZIONE = 'Sbagliato tutto';

            Test.startTest();
            System.runAs(portal_user)
            {
                //Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
                OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateResponse respnce =  new OF_PP_WS_IN_OM_ResponseUpdate.OLO_StatusUpdateResponse();
                respnce = OF_PP_WS_IN_OM_ResponseUpdate.OLO_PreProv_StatusUpdate(RescheduleRequest);
                system.debug('>>>>>>>>>>>>< xxxxxxxxxxxxxxxx > STAMPO la RESPONS FINALE: ' + respnce);
            }
            Test.stopTest(); 
        }
        //}
    }
}