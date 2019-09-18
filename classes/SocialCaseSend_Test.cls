@isTest
public class SocialCaseSend_Test {
static testMethod void method1 (){
        test.startTest();
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = oloAccountRecordTypeId ;
        insert accOLO;
    
        //-------Case -------------
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
        c.Account = accOLO;
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
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.PO_SA_Portale__C = false;
       	c.OF_Bonifica_Locked_Row__c = false;
        insert c;
        
   Contact contact = new Contact(
       		FirstName = 'Amalia',
            LastName = 'De Lana', 
            accountId = accOLO.id,
           
            Phone = '00212678801164', MobilePhone = '00212523346925',
            email = 'kbrazi@salesforce.com');
            
        insert contact;    
    	
    	SocialPersona spers = new SocialPersona();
    	spers.name='PersonaTest';
    	spers.ParentId=contact.id;
        spers.SN_AutomaticReply__c=false;
    spers.Provider='Facebook';
    	insert spers;
    
        SocialPost sp = new SocialPost();
        sp.name= 'Test';
    	sp.MessageType='Private';
    	sp.parentid =c.id;
    	sp.personaid=spers.id;
        insert sp;
   
     SocialCaseSend.sendAckforSocialCase(sp.id);
    
            SocialPost sptwt = new SocialPost();
        sptwt.name= 'Test2';
    	sptwt.MessageType='Direct';
    	sptwt.parentid =c.id;
    	sptwt.personaid=spers.id;
        insert sptwt;
    SocialCaseSend.sendAckforSocialCase(sptwt.id);
    test.stopTest();
    }
}