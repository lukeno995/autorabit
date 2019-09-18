@IsTest
public class PO_TT_ListaRichieste_Controller_Test{
    static Map<String,String> RecordType()
    { 
        //Record Type case
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Asset')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
    
    for(RecordType rt: rtypes)
        RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    public static testmethod void test1 (){
      Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id, userRoleId=ur.id,
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        system.Runas(thisUser){    
     String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        
        insert accOLO;
           String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account acc = new Account();
      acc.Name = 'Test';
      
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.EOF_Codice_Operatore__c='tes';
        
        insert acc;
        //----Contact -------
        
        Contact contactPerson = new Contact();
        contactPerson.FirstName = 'xyz';
        contactPerson.LastName = 'xyz';
        contactPerson.Phone = '1234';
        contactPerson.Email = 'abc@xyz.com';
        
        insert contactPerson;

        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        //c.EOF_ID_Risorsa__c = 'Test';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c =system.today();
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
        
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        insert c; 
     
      //--------------EAI Log creation--------------
        String eaiRecordType = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - TT - TroubleTicketRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c  eaiLog = new EOF_EAI_Service_Log__c();
        eaiLog.Caso__c  = c.Id;
        eaiLog.EOF_Stato_Richiesta__c='Aperto';
        eaiLog.EOF_ID_Notifica__c = 'test_01';
        eaiLog.EOF_Codice_Ordine_OLO__c = 'test';
        eaiLog.EOF_Codice_Operatore__c='tes';
        eaiLog.recordTypeId = eaiRecordType;
        insert eaiLog;
        
            contact con = new contact(); 
            con.lastname = 'test';
            con.PO_Servizi_a_fattibilit__c = True;
            con.PO_P2P_Base__c = True;
            con.PO_Fiber_Link__c = True;
            con.PO_IRU__c = True;
            con.PO_Fiber_Lease__c = True;
            con.PO_Misto_Fiber_Lease_Link_per_Fastweb__c = True;
            con.PO_Servizio_Open_Stream__c = True;
            con.AccountId = acc.Id;      
            con.Email= 'testmail@atos.net';
            insert con;
            
       //  UserRole Ur = [Select ID FROM UserRole where Name = 'Wind Telecomunicazioni Spa Partner Executive'];
             Profile p1 = [SELECT Id FROM Profile WHERE Name='Partner Community User'];
            User u = new User(Alias = 'sta1ndt', Email='unitTestMail11@atos.net', 
                              EmailEncodingKey='UTF-8', LastName='Tes1ting', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = p1.Id,contactID= con.Id,
                              TimeZoneSidKey='America/Los_Angeles', UserName='tes1tmail1@po.net',isactive=true);
            insert u;
            system.runAs(u){
        test.startTest();
     List<String> jstr = new List<String>();
     jstr.add('1');
      List<String> jstr1 = new List<String>();
     jstr1.add('Acquisito');
      
          Apexpages.currentPage().getParameters().put('DataInizio',string.valueOF(system.today()));
          Apexpages.currentPage().getParameters().put('DataFine',string.ValueOF(system.today()));
           Apexpages.currentPage().getParameters().put('selectValueL1',JSON.serialize(jstr) );
            Apexpages.currentPage().getParameters().put('selectValueL2',JSON.serialize(jstr1));
          PO_TT_ListaRichieste_Controller lic = new PO_TT_ListaRichieste_Controller ();
          lic.runSearch();
          lic.ViewCaseDettail();
        
    test.stopTest();
       } 
    }
   }     
}