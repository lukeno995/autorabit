@isTest
public class PO_COMP_CeD_InsApp_Contr_TEST {
	
    public static testmethod void test1(){
      
        // account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        // end account creation
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        case c = new case();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Account_OLO__c = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.EOF_Data_Notifica__c= system.now();
        insert c;
        // end case creation
        
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CeD_InserimentoApparato_Contr.slOrig = sl;
        // end service log creation

        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.OF_SA_AZIONE_APPARATO__c = '0 - Consegna';
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_Cpe_Log__c=sl.id;
        //insert sc;
        // end cpe service log creation

        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        
        test.startTest();
        PO_COMP_CeD_InserimentoApparato_Contr iac = new PO_COMP_CeD_InserimentoApparato_Contr();
        iac.slApparato = sc;
        
        iac.annullaApparato();
        iac.InserisciApparato();
        iac.updateApparato();
        test.stopTest();
    }

    public static testmethod void test2(){
      
        // account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        // end account creation
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        case c = new case();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Account_OLO__c = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.EOF_Data_Notifica__c= system.now();
        insert c;
        // end case creation
        
        //service log creation 
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CeD_InserimentoApparato_Contr.slOrig = sl;
        // end service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_AZIONE_APPARATO__c = '1 - Consegna e installazione';
        sc.OF_SA_Cpe_Log__c=sl.id;
        //insert sc;
        // end cpe service log creation
        
        PO_COMP_CeD_InserimentoApparato_Contr.idApparato = '12345';
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', sl.id);
        System.currentPageReference().getParameters().put('orig', 'ATT');
        
        test.startTest();
        PO_COMP_CeD_InserimentoApparato_Contr iac = new PO_COMP_CeD_InserimentoApparato_Contr();
        iac.slApparato = sc;
        //iac.annullaApparato();
        iac.InserisciApparato();
        iac.updateApparato();
        test.stopTest();
    }

    public static testmethod void test3(){
      
        // account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        // end account creation
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        case c = new case();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Account_OLO__c = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.EOF_Data_Notifica__c= system.now();
        insert c;
        // end case creation
        
        
        //service log creation 
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CeD_InserimentoApparato_Contr.slOrig = sl;
        // end service log creation
        
        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_AZIONE_APPARATO__c = '2 - Solo installazione';
        sc.EOF_Esito_Consegna_Apparato__c = '';
        sc.OF_SA_Cpe_Log__c=sl.id;
        //insert sc;
        // end cpe service log creation
        
        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', 'ATT');
        System.currentPageReference().getParameters().put('orig', 'CESS');
            
        test.startTest();
        PO_COMP_CeD_InserimentoApparato_Contr iac = new PO_COMP_CeD_InserimentoApparato_Contr();
        iac.slApparato = sc;
        //iac.annullaApparato();
        iac.InserisciApparato();
        iac.updateApparato();
        test.stopTest();
    }

    public static testmethod void test4(){
      
        // account creation
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account acc = new account();
        acc.name ='test';
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Type = 'OLO';
        acc.industry = 'Telecommunications';
        acc.RecordTypeID = oloAccountRecordTypeId;
        
        insert acc;
        // end account creation
        
        // business account creation        
        String busAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Business').getRecordTypeId();
        Account bus = new Account();
        bus.name = 'Test';
        bus.RecordTypeId = busAccountRecordTypeId;
        insert bus;
        // end business account creation
        
        // case creation
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        case c = new case();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Account_OLO__c = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test';
        c.EOF_Contact__c = null;
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.EOF_Data_Notifica__c= system.now();
        insert c;
        // end case creation
        
        //service log creation 
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.RecordTypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('PO - SA - CD - OpenStreamRequest').getRecordTypeId(); 
        sl.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sl.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sl.EOF_ID_Notifica__c ='';
        sl.EOF_STATO_ORDINE__c ='Acquisito';
        
        insert sl;
        PO_COMP_CeD_InserimentoApparato_Contr.slOrig = sl;
        // end service log creation

        // cpe service log creation
        EOF_EAI_Service_Log__c sc = new EOF_EAI_Service_Log__c();
        sc.recordtypeId=Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        sc.EOF_Codice_Ordine_OLO__c =c.EOF_Codice_Ordine_OLO__c;
        sc.EOF_Data_Notifica__c= c.EOF_Data_Notifica__c;
        sc.OF_SA_AZIONE_APPARATO__c = '2 - Solo installazione';
        sc.EOF_Esito_Consegna_Apparato__c = '';
        sc.OF_SA_Cpe_Log__c=sl.id;
        //insert sc;
        // end cpe service log creation

        Test.setCurrentPageReference(new PageReference('PO_OpenStreamCeD_InsertNewReq')); 
        System.currentPageReference().getParameters().put('origId', 'CESS');
        
        test.startTest();
        PO_COMP_CeD_InserimentoApparato_Contr iac = new PO_COMP_CeD_InserimentoApparato_Contr();
        iac.slApparato = sc;
        
        iac.annullaApparato();
        iac.InserisciApparato();
        iac.updateApparato();
        test.stopTest();
    }
}