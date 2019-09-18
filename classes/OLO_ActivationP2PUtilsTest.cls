@isTest
public class OLO_ActivationP2PUtilsTest {

    @isTest 
    static void createActivationRqstPassivaTest() {
        PO_ServFatt_DataFactory.WrapData p2pBaseWrapped = PO_ServFatt_DataFactory.createP2PBaseData();

        Case fatt = [SELECT PO_Offerta__c, casenumber FROM Case WHERE Id =:  p2pBaseWrapped.casePadre.id];
        p2pBaseWrapped.casePadre.EOF_Codice_Ordine_OLO__c = 'TIS_' + fatt.caseNumber;
        update p2pBaseWrapped.casePadre;

        System.debug('@#@#@#@# wrapped data: ' + p2pBaseWrapped);

        Map<Id,Id> map_collegIdOrdineId = new Map<Id,Id>();
        map_collegIdOrdineId.put(p2pBaseWrapped.caseCollegamento.Id, p2pBaseWrapped.caseOrdine.Id);

        Id idNotify = createNotify();
        OLO_Activation_P2PSchema.Create_P2P_Request_element rqst = 
            OLO_ActivationP2PUtils.createActivationRqst(map_collegIdOrdineId, idNotify);

         System.debug('@@@__#####__@@@ request: ' + rqst);

        System.assertEquals(fatt.PO_Offerta__c, rqst.fattibilita.TIPO_CONTRATTO);
        System.assertEquals(idNotify, rqst.header.ID_NOTIFICA);
    }

    @isTest
    static void createActivationRqstAttivaTest() {
        PO_ServFatt_DataFactory.WrapData p2pAttivaWrapped = PO_ServFatt_DataFactory.createP2PAttivaData();

        Case fatt = [SELECT PO_Offerta__c, casenumber FROM Case WHERE Id =:  p2pAttivaWrapped.casePadre.id];
        p2pAttivaWrapped.casePadre.EOF_Codice_Ordine_OLO__c = 'TIS_' + fatt.caseNumber;
        update p2pAttivaWrapped.casePadre;

        EOF_VLAN__c vlan = new EOF_VLAN__c();
        vlan.caso__c = p2pAttivaWrapped.caseCollegamento.Id;        
        insert vlan;

        Map<Id,Id> map_collegIdOrdineId = new Map<Id,Id>();
        System.debug('##### createActivationRqstAttivaTest - caseCollegamento: ' + p2pAttivaWrapped.caseCollegamento);
        System.debug('##### createActivationRqstAttivaTest - caseOrdine: ' + p2pAttivaWrapped.caseOrdine);
        map_collegIdOrdineId.put(p2pAttivaWrapped.caseCollegamento.Id, p2pAttivaWrapped.caseOrdine.Id);

        Id idNotify = createNotify();
        OLO_Activation_P2PSchema.Create_P2P_Request_element rqst = 
            OLO_ActivationP2PUtils.createActivationRqst(map_collegIdOrdineId, idNotify);

         System.debug('@@@__#####__@@@ request: ' + rqst);

        System.assertEquals(fatt.PO_Offerta__c, rqst.fattibilita.TIPO_CONTRATTO);
        System.assertEquals(idNotify, rqst.header.ID_NOTIFICA);
    }

    @isTest
    static void createIdNotificaTest() {
        Case testCase = new Case();
        insert testCase;

        Id ntfId = OLO_ActivationP2PUtils.createIdNotifica(testCase.Id);
        EOF_Notify__c ntf = [SELECT Id FROM EOF_Notify__c WHERE Id =: ntfId];

        System.assertEquals(ntf.Id, ntfId);
    } 

    @isTest
    static void formatEsitoCollegamento() {
        String expected = 'SI - in FTTH';
        String actual = OLO_ActivationP2PUtils.formatEsitoCollegamento('SI in FTTH');

        System.assertEquals(expected, actual);

    }

    @isTest 
    static void formatNomeKitConsegnaTest() {
        String nomeKit = 'Vodafone_KIT_0003022747';       
       	String formatted = OLO_ActivationP2PUtils.formatNomeKitConsegna('VF', nomeKit);  
        
        String expected = 'VF_KIT_0003022747';
        System.assertEquals(expected, formatted);      	
    }
    
    @isTest 
    static void formatNomeKitConsegnaInvalidInput() {
        String nomeKit = '0003022747';       
       	String formatted = OLO_ActivationP2PUtils.formatNomeKitConsegna('VF', nomeKit);  
        
       System.assertEquals(nomeKit, formatted);	
    }

    @isTest
    static void buildCollOrdineCaseMapTest() {
        PO_ServFatt_DataFactory.WrapData p2pbase = PO_ServFatt_DataFactory.createP2PBaseData();
        Id collId = p2pbase.caseCollegamento.Id;
        Id ordId = p2pbase.caseOrdine.Id;      
        
        Map<Id,Id> map_collIdOrdineId = new Map<Id,Id>();
        map_collIdOrdineId.put(collId, ordId);

        Map<Case,Case> map_collCaseOrdineCase = OLO_ActivationP2PUtils.buildCollOrdineCaseMap(map_collIdOrdineId);
        List<Case> keys = new List<Case>();
        keys.addAll(map_collCaseOrdineCase.keySet());
        
        System.assertEquals(collId, keys[0].Id);   
        System.assertEquals(ordId, map_collCaseOrdineCase.values()[0].Id);  

    }

    static Id createNotify() {
        EOF_Notify__c notf = new EOF_Notify__c();

        notf.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('DOM Notifica di Attivazione').getRecordTypeId();
		notf.EOF_Data_Notifica__c = system.now();
        System.debug('##### OLO_ActivationP2PUtils.createIdNotifica -- before insert -- notifyy: ' + notf);
        // eof_inviata = true serve a non far partire una callout innescata dal trigger su eof_notify
		notf.EOF_Inviata__c = true;
        
        insert notf;
        System.debug('##### OLO_ActivationP2PUtils.createIdNotifica -- after insert -- notifyy id: ' + notf.Id);

        return notf.Id;
    }


    @isTest
    static void writeLogTest() {
        OLO_Activation_P2PSchema.Create_P2P_Request_element rqst = new OLO_Activation_P2PSchema.Create_P2P_Request_element();
        OLO_Activation_P2PSchema.Fattibilita fatt_rqst = new OLO_Activation_P2PSchema.Fattibilita();
        OLO_Activation_P2PSchema.Header_Request header_rqst =  new OLO_Activation_P2PSchema.Header_Request();
        OLO_Activation_P2PSchema.ORDINE_element ordine_rqst = new OLO_Activation_P2PSchema.ORDINE_element();
        List<OLO_Activation_P2PSchema.ORDINE_element> list_ordineRqst = 
            new List<OLO_Activation_P2PSchema.ORDINE_element>();

        rqst.header = header_rqst;
        rqst.fattibilita = fatt_rqst;
        list_ordineRqst.add(ordine_rqst);
        fatt_rqst.ORDINE = list_ordineRqst;
        
        OLO_Activation_P2PSchema.Create_Response response = null;

        PO_ServFatt_DataFactory.WrapData cases =  PO_ServFatt_DataFactory.createP2PAttivaData();
        List<Case> casesToUpdate = new List<Case>();
        Case fatt = [SELECT EOF_Codice_Ordine_OLO__c FROM Case WHERE Id =: cases.casePadre.Id];
        Case ordine = [SELECT EOF_Codice_Ordine_OLO__c FROM Case WHERE Id =: cases.caseOrdine.Id];

        fatt.EOF_Codice_Ordine_OLO__c = 'FATT_0001';
        ordine.EOF_Codice_Ordine_OLO__c = 'ORDINE_0001';
        casesToUpdate.add(fatt);
        casesToUpdate.add(ordine);
        update casesToUpdate;

        header_rqst.DATA_CREAZIONE = System.now();
        header_rqst.ID_NOTIFICA = createNotify();
         
        fatt_rqst.ID_FATTIBILITA = fatt.EOF_Codice_Ordine_OLO__c;       
        ordine_rqst.ID_ORDINE = ordine.EOF_Codice_Ordine_OLO__c;

        EOF_EAI_Service_Log__c actual = OLO_ActivationP2PUtils.writeLog(rqst, response);
        System.debug('actual ' + actual);
		
        List<EOF_EAI_Service_Log__c> expected = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE Id =: actual.Id];
        System.assertEquals(1,expected.size());

    }

}