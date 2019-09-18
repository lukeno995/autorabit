@isTest
public class CaseQueueUtility_Test {
    
    public static testmethod void MethodOne(){ 
        
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
        
        //-------Case Creation-------------
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        list<case> vlstcase =  new list<case>();
        Case c = new Case();
        c.EOF_Account_OLO__c = accOLO.Id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Accettato';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
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
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        //c.PO_PP_ID_Richiesta__c=c.id;
        insert c;
        vlstcase.add(c);
    
    CaseQueueUtility.BeforeUpdate(vlstcase);   
        
        }

}