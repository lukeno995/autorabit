@isTest
public class OF_SA_SendRetryAttivi_MethodsTest
{
    static testmethod Map<String,String> RecordType(){       
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Account' OR sObjectType='Contact' OR sObjectType = 'EOF_EAI_Service_Log__c' OR sObjectType = 'OF_CommercialElementIstanziato__c')  and isActive=true];
        Map<String,String> RecordType = new Map<String,String>{};
            for(RecordType rt: rtypes)
            RecordType.put(rt.Name,rt.Id);        
        return RecordType;
    }
    
    static testMethod void Method2(){

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        

        
        Map<String,String> RecordTypeMap = RecordType();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = ActivationReq.CODICE_OPERATORE;
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        Account acc = new Account();
        acc.name = ActivationReq.COGNOME_CLIENTE;
        acc.EOF_Codice_Operatore__c ='VF';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        /* Account acc1 = new Account();
acc1.name = 'test';
acc1.EOF_Codice_Operatore__c ='VF';
acc1.RecordTypeId = RecordTypeMap.get('Cliente Business');
// insert acc;  */      
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = ActivationReq.NOME_REFERENTE_TECNICO_OLO;
        con.LastName = ActivationReq.COGNOME_REFERENTE_TECNICO_OLO;
        con.Phone = ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO;
        con.Email = ActivationReq.EMAIL_REFERENTE_TECNICO_OLO;
        insert con;        
        
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Contact__c = con.id;
        c.status = 'Ricevuto';
        c.EOF_FASE__C = 'NA';
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c ='VF';  
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        OF_SA_GE_Utils.caseOriginale = c ;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slfiberReq.caso__c=c.Id;
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        OF_SA_GE_Utils.testNackTecnicoOLO=true;
        OF_SA_GE_Utils.testNackTecnicoOM=true;
            
        OF_SA_GE_Utils.listApp=new list<EOF_EAI_Service_Log__C>();
        Test.startTest();        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        OF_SA_GE_Utils.slSFOLO=slFiberReq;
        OF_SA_GE_Utils.cliente = acc;        
        OF_SA_SendRetryAttivi_Methods.retryCalloutOLOOM(c.Id,'OF_SA_FiberNotify',slFiberReq.EOF_Codice_Ordine_OLo__C);
        Test.stopTest(); 
    }
    
    static testMethod void Method3(){        
        Map<String,String> RecordTypeMap = RecordType();
        try
        {
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();            
            ActivationReq.CODICE_OPERATORE = 'VF';
            ActivationReq.CODICE_ORDINE_OLO = 'Test';
            ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
            ActivationReq.ID_NOTIFICA = 'Test';
            ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
            ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
            ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
            ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
            ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
            ActivationReq.NOME_CLIENTE = 'Test';
            ActivationReq.COGNOME_CLIENTE = 'Test';
            ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
            ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
            ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
            ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
            ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
            ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
            ActivationReq.PROMOZIONE = 'Test';
            ActivationReq.CLUSTER_PROMOZIONE = 'Test';
            ActivationReq.NOTE = 'Test';
            ActivationReq.ID_BUILDING = 'Test';
            ActivationReq.SCALA_PALAZZINA = 'Test';
            ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
            ActivationReq.RECAPITO_TEST_LINEA = 'Test';
            ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
            ActivationReq.PROFILO = 'Test';            
            
            Account accOloWIND = new Account();       
            accOloWIND.Name = 'Wind';
            accOloWIND.EOF_Codice_Operatore__c = ActivationReq.CODICE_OPERATORE;
            accOloWIND.Type = 'OLO';
            accOloWIND.Industry = 'Telecommunications';
            accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');            
            insert accOloWIND;
            
            Account acc = new Account();
            acc.name = ActivationReq.COGNOME_CLIENTE;
            acc.EOF_Codice_Operatore__c ='VF';
            acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
            insert acc;
            
            
            contact con = new contact();
            con.AccountId = accOloWIND.id;
            con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
            con.FirstName = ActivationReq.NOME_REFERENTE_TECNICO_OLO;
            con.LastName = ActivationReq.COGNOME_REFERENTE_TECNICO_OLO;
            con.Phone = ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO;
            con.Email = ActivationReq.EMAIL_REFERENTE_TECNICO_OLO;
            insert con;
            
            Case c = new Case();
            c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
            c.EOF_Account_OLO__c = accOloWIND.id;
            c.EOF_Contact__c = con.id;
            c.status = 'Ricevuto';
            c.PO_SA_Portale__C =true;
            c.EOF_FASE__C = 'NA';
            c.EOF_Codice_Ordine_OLO__c='Test';
            c.EOF_Codice_Operatore_WS__c ='VF';  
            c.OF_Response_Da_OM__c='Test';
            c.OF_Bonifica_Locked_Row__c = true;            
            insert c;
            
            c = [select id,OF_Bonifica_Locked_Row__c  from case where id=:c.id];
            system.debug('InsideTest'+OF_SA_GE_Utils.caseOriginale);
            OF_SA_GE_Utils.caseOriginale = c ;
            
            system.debug('InsideTest'+OF_SA_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c );
            // OF_SA_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c = false;
            
            String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
            EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
            slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            slFiberReq.RecordTypeId = ListRecordTypePassId ;
            slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
            slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
            insert slFiberReq;
            
            EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
            slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
            slFiberReq1.OF_SA_Direzione_Flusso__c='SF-OM';            
            slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
            insert slFiberReq1;
            
            String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
            EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
            slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
            slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test'; 
            //slFiberReq2.Caso__c = c.Id;
            insert slFiberReq2;
            
            String ListRecordTypePassId2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Vlan').getRecordTypeId();
            EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
            slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            slFiberReq3.RecordTypeId = ListRecordTypePassId2 ;
            slFiberReq3.OF_SA_VLan_Log__c=slFiberReq.id;
            slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';            
            insert slFiberReq3;
            
            String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
            EOF_EAI_Service_Log__c slFiberReq4 = new EOF_EAI_Service_Log__c();
            slFiberReq4.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            slFiberReq4.RecordTypeId = ListRecordTypePassId3 ;
            slFiberReq4.OF_SA_Cpe_Log__c = slFiberReq.id;
            slFiberReq4.EOF_Codice_Ordine_OLo__C = 'Test';            
            insert slFiberReq4;
            
            String ListRecordTypePassId4 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();
            EOF_EAI_Service_Log__c slFiberReq5 = new EOF_EAI_Service_Log__c();
            slFiberReq5.eof_tipo_comunicazione_String__c = 'OLO->SF - ActivationRequest';
            slFiberReq5.RecordTypeId = ListRecordTypePassId4 ;
            slFiberReq5.OF_SA_servizi_Aggiuntivi_Log__c = slFiberReq.id;
            slFiberReq5.EOF_Codice_Ordine_OLo__C = 'Test';            
            insert slFiberReq5;
            
            OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
            trg.Name = 'Status';
            trg.OF_Enable_Trigger__c = false;
            insert trg;
            
            //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
            // OF_SA_GE_Utils.caseOriginale=c;
            OF_SA_GE_Utils.slOLOSF = slFiberReq;
            
            OF_Puntamento_Callout__c pnt = new OF_Puntamento_Callout__c();
            pnt.name = 'OGW';
            pnt.OF_OGW__c = 'OFS-SVIL-WS';
            insert pnt;
            
            List<EOF_EAI_Service_LOg__c> ListV = new List<EOF_EAI_Service_LOg__c>();
            OF_SA_GE_Utils.ListVLan = ListV;
            OF_SA_GE_Utils.listApp = new list<EOF_EAI_Service_Log__C>();
            OF_SA_GE_Utils.ListServAgg = new list<EOF_EAI_Service_Log__C>();
            
            OF_SA_GE_Utils.testNackTecnicoOLO=true;
            OF_SA_GE_Utils.testNackTecnicoOM=true;
            
            Test.startTest();            
            Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
            OF_SA_GE_Utils.slSFOLO = slFiberReq;
            OF_SA_GE_Utils.cliente = acc;
            OF_SA_SendRetryAttivi_Methods.retryCalloutOLOOM(c.Id,'OF_SA_FiberNotify',slFiberReq.EOF_Codice_Ordine_OLo__C);
            test.stopTest();
        }
        catch(exception e)
        {
        }
    }
    
    static testMethod void Method4(){

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        

        
        Map<String,String> RecordTypeMap = RecordType();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = ActivationReq.CODICE_OPERATORE;
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND; 
        
        Account acc = new Account();
        acc.name = ActivationReq.COGNOME_CLIENTE;
        acc.EOF_Codice_Operatore__c ='VF';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        /* Account acc1 = new Account();
acc1.name = 'test';
acc1.EOF_Codice_Operatore__c ='VF';
acc1.RecordTypeId = RecordTypeMap.get('Cliente Business');
// insert acc;  */      
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = ActivationReq.NOME_REFERENTE_TECNICO_OLO;
        con.LastName = ActivationReq.COGNOME_REFERENTE_TECNICO_OLO;
        con.Phone = ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO;
        con.Email = ActivationReq.EMAIL_REFERENTE_TECNICO_OLO;
        insert con;        
        
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Cessazione_OPENSTREAM');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Contact__c = con.id;
        c.status = 'Ricevuto';
        c.EOF_FASE__C = 'NA';
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c ='VF';  
        c.OF_Response_Da_OM__c='Test';
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        OF_SA_GE_Utils.caseOriginale = c ;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test';
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        //slFiberReq2.Caso__c = c.id;        
        insert slFiberReq2;
        
        String ListRecordTypePassId3 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq3 = new EOF_EAI_Service_Log__c();
        slFiberReq3.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq3.RecordTypeId = ListRecordTypePassId3 ;
        slFiberReq3.OF_SA_Cpe_Log__c = slFiberReq.id;
        slFiberReq3.EOF_Codice_Ordine_OLo__C = 'Test';        
        insert slFiberReq3;
        
        //BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        
        OF_Puntamento_Callout__c pnt= new OF_Puntamento_Callout__c();
        pnt.name='OGW';
        pnt.OF_OGW__c ='OFS-SVIL-WS';
        insert pnt;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        OF_SA_GE_Utils.testNackTecnicoOLO=true;
        OF_SA_GE_Utils.testNackTecnicoOM=true;
            
        OF_SA_GE_Utils.listApp=new list<EOF_EAI_Service_Log__C>();
        Test.startTest();        
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());        
        OF_SA_GE_Utils.slSFOLO=slFiberReq;
        OF_SA_GE_Utils.cliente = acc;        
        OF_SA_SendRetryAttivi_Methods.retryCalloutOLOOM(c.Id,'OF_SA_FiberNotify',slFiberReq.EOF_Codice_Ordine_OLo__C);
        Test.stopTest(); 
    }
    
     static testMethod void Method5(){        

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
         
        Map<String,String> RecordTypeMap = RecordType();
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest ActivationReq = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();        
        ActivationReq.CODICE_OPERATORE = 'VF';
        ActivationReq.CODICE_ORDINE_OLO = 'Test';
        ActivationReq.DATA_NOTIFICA = '2017-06-01T18:30:15+01:00';
        ActivationReq.ID_NOTIFICA = 'Test';
        ActivationReq.NOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO = '123456789';
        ActivationReq.EMAIL_REFERENTE_TECNICO_OLO = 'Test@test.com';
        ActivationReq.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = '123456789';
        ActivationReq.NOME_CLIENTE = 'Test';
        ActivationReq.COGNOME_CLIENTE = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        ActivationReq.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        ActivationReq.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        ActivationReq.DATA_PREVISTA_ATTIVAZIONE = '2018-11-15';
        ActivationReq.ORARIO_APPUNTAMENTO = 'Test';
        ActivationReq.CODICE_PROGETTO_SPECIALE = 'Test';
        ActivationReq.PROMOZIONE = 'Test';
        ActivationReq.CLUSTER_PROMOZIONE = 'Test';
        ActivationReq.NOTE = 'Test';
        ActivationReq.ID_BUILDING = 'Test';
        ActivationReq.SCALA_PALAZZINA = 'Test';
        ActivationReq.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        ActivationReq.RECAPITO_TEST_LINEA = 'Test';
        ActivationReq.IDENTIFICATIVO_DEL_POP = 'Test';
        ActivationReq.PROFILO = 'Test';        
        
        Account accOloWIND = new Account();       
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = ActivationReq.CODICE_OPERATORE;
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = RecordTypeMap.get('OLO');        
        insert accOloWIND;
        
        Account acc = new Account();
        acc.name = ActivationReq.COGNOME_CLIENTE;
        acc.EOF_Codice_Operatore__c ='VF';
        acc.RecordTypeId = RecordTypeMap.get('Cliente Business');
        insert acc;
        
        contact con = new contact();
        con.AccountId = accOloWIND.id;
        con.RecordTypeId = RecordTypeMap.get('Referente Tecnico OLO');
        con.FirstName = ActivationReq.NOME_REFERENTE_TECNICO_OLO;
        con.LastName = ActivationReq.COGNOME_REFERENTE_TECNICO_OLO;
        con.Phone = ActivationReq.TELEFONO_REFERENTE_TECNICO_OLO;
        con.Email = ActivationReq.EMAIL_REFERENTE_TECNICO_OLO;
        insert con;        
        
        Case c = new Case();
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
        c.EOF_Account_OLO__c = accOloWIND.id;
        c.EOF_Contact__c = con.id;
        c.status = 'Ricevuto';
        c.EOF_FASE__C = 'NA';
        c.EOF_Codice_Ordine_OLO__c='Test';
        c.EOF_Codice_Operatore_WS__c ='VF';
        c.PO_SA_Portale__C=false;        
        insert c;
        
        OF_SA_GE_Utils.caseOriginale = c ;
        
        String ListRecordTypePassId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq = new EOF_EAI_Service_Log__c();
        slFiberReq.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq.RecordTypeId = ListRecordTypePassId ;
        slFiberReq.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq.EOF_Codice_Operatore__c=c.EOF_Codice_Operatore_WS__c;
        slfiberReq.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq.OF_SA_Metodo__c='';
        slFiberReq.EOF_CODICE_ORDINE_EOF__c='';
        slFiberReq.EOF_DATA_NOTIFICA__c=system.now();
        slFiberReq.EOF_ID_NOTIFICA__c='';
        slFiberReq.EOF_Tipo_Comunicazione__c='';
        slFiberReq.EOF_STATO_ORDINE__c='';
        slFiberReq.EOF_CODICE_MOTIVAZIONE__c='';
        slFiberReq.EOF_MOTIVAZIONE__c='';
        slFiberReq.caso__c=c.Id;
        slFiberReq.EOF_Richiesta_Notifica__c='';
        slFiberReq.EOF_GPON_Attestazione__c='';
        slFiberReq.EOF_NOME_CLIENTE__c='';
        slFiberReq.EOF_COGNOME_CLIENTE__c='';
        slFiberReq.EOF_RECAPITO_TELEFONICO_CLIENTE__c='';
        slFiberReq.EOF_DATA_PREVISTA_ATTIVAZIONE__c=system.today();
        slFiberReq.EOF_ORARIO_APPUNTAMENTO__c='';
        slFiberReq.EOF_PIN_INTERVENTO_A_VUOTO__c='';
        slFiberReq.EOF_NOTE__c='';
        
        insert slFiberReq;
        
        EOF_EAI_Service_Log__c slFiberReq1 = new EOF_EAI_Service_Log__c();
        slFiberReq1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
        slFiberReq1.OF_SA_Direzione_Flusso__c='SF-OM';        
        slFiberReq1.EOF_Codice_Ordine_OLo__C = 'Test'; 
        insert slFiberReq1;
        
        String ListRecordTypePassId1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberNotify').getRecordTypeId();
        EOF_EAI_Service_Log__c slFiberReq2 = new EOF_EAI_Service_Log__c();
        slFiberReq2.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
        slFiberReq2.RecordTypeId = ListRecordTypePassId1 ;
        slFiberReq2.EOF_Codice_Ordine_OLo__C = 'Test';
        slFiberReq2.OF_SA_Direzione_Flusso__c='SF-OM';
        slFiberReq2.Caso__c = c.Id;
        slFiberReq2.EOF_Codice_Ordine_OLO__c='Test';        
        insert slFiberReq2;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c trg = new OF_Enable_PO_UpdateOppCase_Trigger__c();
        trg.Name = 'Status';
        trg.OF_Enable_Trigger__c = false;
        insert trg;
        
        // BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
        OF_SA_GE_Utils.caseOriginale = c;
        OF_SA_GE_Utils.slOLOSF = slFiberReq;
        OF_Puntamento_Callout__c pnt = new OF_Puntamento_Callout__c();
        pnt.name = 'OGW';
        pnt.OF_OGW__c = 'OFS-SVIL-WS';
        insert pnt;
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        OF_SA_GE_Utils.slSFOLO = slFiberReq;
        OF_SA_GE_Utils.cliente = acc;
        OF_SA_SendRetryAttivi_Methods.retryCalloutOLOOM(c.Id,'OF_SA_Attivazione',slFiberReq.EOF_Codice_Ordine_OLo__C); 
        Test.stopTest(); 
        }
        
    
}