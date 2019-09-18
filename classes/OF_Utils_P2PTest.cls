@isTest
public with sharing class OF_Utils_P2PTest {
    public class WrapData {
		public Case casePadre {get; set;}
		public Case caseCollegamento {get; set;}
		public Case caseOrdine {get; set;}
		public Case caseKit {get; set;}
		public EOF_EAI_Service_Log__c logCollegamento {get; set;}
		public EOF_EAI_Service_Log__c logRichiesta {get; set;}
		public Opportunity oppChild {get; set;}
		public ServFattList__c cs {get; set;}
	}
    // case.isDom è true
    @isTest
    static void getDestinationSystemMustBeDomByCase() {
		//insert new CustomSetting__c(Semaforo_DOM__c=true,Semaforo_Proxy_Portale__c=true);
        createSemaforoDomTrue();
		Case c = createCaseDomTrue('');
		createConfigurazioneMatching();
        Datetime myDT = Datetime.now();
         String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);
        //System.assertEquals('DOM', sys);
    }
    /* case.isDom è false. 
        Semaforo Dom è true. 
        Configurazione Dom non combacia con input
        Tipo servizio è P2P_Base
    */
    @isTest
    static void getDestinationSystemMustBePSMByConfig() {
        Case c = createCaseDomFalse('P2P Base');
        System.debug(c.PO_Offerta__c);
        createSemaforoDomTrue();
        createConfigurazioneMismatching();
        Datetime myDT = Datetime.now();
        if(!OF_Utils_P2P.checkIsDOM(c,myDT)){
             String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);
             System.assertEquals('PSM', sys);
        }

    }

    /*  case.isDom è false. 
        Semaforo Dom è true. 
        Configurazione Dom non combacia con input
        Tipo servizio è P2P_Attiva
    */
    @isTest
    static void getDestinationSystemMustBePONCByConfig() {
        Case c = createCaseDomFalse('P2P Attiva');
        createSemaforoDomTrue();
        createConfigurazioneMismatching();

        Datetime myDT = Datetime.now();
        String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);

        System.assertEquals('PO_NETWORK_CREATION', sys);
    }
    // case.isDom è false. 
    // Semaforo Dom è false. 
    // Tipo servizio è P2P_Attiva
    @isTest
    static void getDestinationSystemMustBePONCByService() {
        Case c = createCaseDomFalse('P2P Attiva');
        createSemaforoDomFalse();

        Datetime myDT = Datetime.now();
        String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);

        System.assertEquals('PO_NETWORK_CREATION', sys);
    }

    // case.isDom è false. 
    // Semaforo Dom è false. 
    // Tipo servizio è P2P_Base
    @isTest
    static void getDestinationSystemMustBePSMByService() {
        Case c = createCaseDomFalse('P2P Base');
        createSemaforoDomFalse();

        Datetime myDT = Datetime.now();
        String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);

        System.assertEquals('PSM', sys);
    }

    // case.isDom è false. 
    // Semaforo Dom è true. 
    // Configurazione Dom combacia con input
    // Tipo servizio è P2P_Attiva
    @isTest
    static void getDestinationSystemMustBeDOMByConfigAttiva() {
        Case c = createCaseDomTrue('P2P Attiva');
        createSemaforoDomTrue();

        Datetime myDT = Datetime.now();
        //System.debug('CHECKISDOM: '+ OF_Utils_P2P.checkIsDOM(c,myDT));
         if(OF_Utils_P2P.checkIsDOM(c,myDT)){
            String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);
            Case deCase= [select isDom__c from Case where id =: c.Id][0];
            System.assertEquals('DOM', sys);
            System.assert(deCase.isDom__c);
        }
    }
    // case.isDom è false. 
    // Semaforo Dom è true. 
    // Configurazione Dom combacia con input
    // Tipo servizio è P2P_Base
    @isTest
    static void getDestinationSystemMustBeDOMByConfigBase() {
        Case c = createCaseDomFalse('P2P Base');
        createSemaforoDomTrue();

        Datetime myDT = Datetime.now();
        String sys = OF_Utils_P2P.getDestinationSystem(c,myDT);
        
       // System.assertEquals('DOM', sys);
    }

    @isTest
    static void checkIsDOMTestTrue() {
        createSemaforoDomTrue();
        createConfigurazioneMatching();
        Case c = new Case();
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.PO_Offerta__c = 'P2P Attiva';
        c.RecordTypeId = RTypeServFattibilita.getRecordTypeIdByDevName(Case.getSObjectType(), 
            RTypeServFattibilita.CASE_P2P_ATTIVA_REQUEST);
        c.Status = 'In Lavorazione';
        insert c;

        Boolean actual = OF_Utils_P2P.checkIsDOM(c, System.now());
        System.assertEquals(true, actual);
    }

    /*
        Metodo : writeLog
        Response: Nack
    */
    @isTest
    static void writeLogNackTest() {
        OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstBase();
        OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();

        EOF_EAI_Service_Log__c sLog = OF_Utils_P2P.writeLog(rqst, rspnse);
        System.debug('***sLog id '+sLog.id);        

        EOF_EAI_Service_Log__c deLog = [select Caso__c from EOF_EAI_Service_Log__c where id =: sLog.Id Limit 1];
        
        Case c = [select Id from Case where EOF_Codice_Ordine_OLO__c =: rqst.id_fattibilita limit 1];

        System.assertNotEquals(null, deLog);
        //System.assertEquals(c.Id, deLog.Caso__c);
    }
    @isTest
   public static void checkEspletamentoNull() {

        OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstBase3();
        OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();
        OF_Utils_P2P.handleEspletamentoBase(rqst,rspnse);
    }

   @isTest
   public static void checkEspletamentoBase() {

        OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstBase();
        OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();
        OF_Utils_P2P.handleEspletamentoBase(rqst,rspnse);
    }
     @isTest
   public static void checkEspletamentoBase2() {

        OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstBase2();
        OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();
        OF_Utils_P2P.handleEspletamentoBase(rqst,rspnse);
    }
     @isTest
   public static void checkEspletamentoBaseKO() {

        OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstBase4();
        OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();
        OF_Utils_P2P.handleEspletamentoBase(rqst,rspnse);
    }
     @isTest
     public static void checkEspletamentoAttivaNull() {
        try {
             OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstAttiva2();
        	OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();
        	OF_Utils_P2P.handleEspletamentoAttiva(rqst,rspnse);
         } catch (Exception e) {
             System.assert(e instanceof IllegalRequestException);
         }
        
    }
    //originalCase.RecordType.DeveloperName=PO_Ordine_P2P_Attiva
    /* @isTest
     public static void checkEspletamentoAttiva() {
         
        OF_StatusUpdate_P2P.Request rqst = buildRequestOrdine('id_notifica');
        OF_StatusUpdate_P2P.Response rspnse = buildAckResponse('id_notifica');
        OF_Utils_P2P.handleEspletamentoAttiva(rqst,rspnse);
         System.debug('##size2:');
    }*/
    
    private static OF_StatusUpdate_P2P.Request buildRequestOrdine(String idNotifica) {
        PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();
        data.casePadre.EOF_Codice_Ordine_OLO__c = 'TIS_0001';
        data.caseOrdine.EOF_Codice_Ordine_OLO__c = 'TIS_0002';
        List<Case> toUpdate = new List<Case>();
        toUpdate.add(data.casePadre);
        toUpdate.add(data.caseOrdine);
        update toUpdate;
        OF_StatusUpdate_P2P.Request request = new OF_StatusUpdate_P2P.Request();
       
        request.id_notifica = idNotifica;
        request.id_esito = 'id_esito_1';
        request.id_fattibilita = 'TIS_0001';
        request.data_notifica = System.now();
        request.tipo_notifica = 'Ordine';
        request.id_ordine_kit = 'TIS_0002';
        request.stato_ordine = '2';
        request.id_risorsa = 'risorsa';
        request.data_espletamento_ordine = '2019-05-14';
        return request;
    }
    //originalCase.RecordType.DeveloperName=PO_Ordine_P2P_KIT
    /* @isTest
     public static void checkEspletamentoAttiva2() {

        OF_StatusUpdate_P2P.Request rqst = buildStatusUpdateRqstAttiva3();
        OF_StatusUpdate_P2P.Response rspnse = buildStatusUpdateNackResponse();
        OF_Utils_P2P.handleEspletamentoAttiva(rqst,rspnse);
         System.debug('##size3:');
    }*/

    /***************************************** 
        Data factory methods
    */ 

    public static Case createCaseDomTrue( String srv) {
        return createCaseByDom(true, srv);
    }

    public static Case createCaseDomFalse(String srv) {
        return createCaseByDom(false, srv);
    }
	/*
    public static Case createCaseByDom(Boolean isDom, String srv) {
        Case c = new Case(); 
        c.OF_Servizio__c = srv;
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.EOF_Data_Notifica__c = System.now();
        c.isDOM__c = isDom;
        insert c;
        return c;
    }
	*/
	//fatto noi
	public static Case createCaseByDom(Boolean isDom, String srv) {
        Case c = new Case(); 
		Map<String, Id> rtDevNameIdMap = getRecordType();
		createServFattList();
        ServFattList__c cs;
        
        if(srv=='') {
                c.PO_Offerta__c='';
           		 c.OF_Servizio__c = '';
        }
         
        if(srv =='P2P Attiva'){
				cs = ServFattList__c.getAll().get('P2P Attiva');
        		c.PO_Offerta__c='P2P Attiva';
           		 c.OF_Servizio__c = 'P2P Attiva';
                 
            	 Id idrecordtype=rtDevNameIdMap.get(cs.caseDevName__c);
    		    c.RecordTypeId = idrecordtype;
            	 
    	}
       if(srv =='P2P Base') {
				cs = ServFattList__c.getAll().get('P2P Base'); 
                c.PO_Offerta__c='P2P Base';
                c.OF_Servizio__c = 'P2P Base';
           		Id idrecordtype=rtDevNameIdMap.get(cs.caseDevName__c);
    		    c.RecordTypeId = idrecordtype;
           		
       }
        if(srv!=''){
            
    		
       }
       system.debug('#########'+ServFattList__c.getAll());
       //system.debug('##########Servizio: '+srv + ' cs: '+cs);
      
        //String cod_ordineolo = [select EOF_Codice_Ordine_OLO__c from Case where Id =: c.Id Limit 1][0].EOF_Codice_Ordine_OLO__c;
		c.Status = 'Acquisito';
        c.EOF_Codice_Ordine_OLO__c = 'TIS_0001';
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.EOF_Data_Notifica__c = System.now();
        c.isDOM__c = isDom;
        insert c;
        return c;
    }
    
    //metodo fake
    public static Case createCaseByDom2(Boolean isDom, String srv) {
        Case c = new Case(); 
		Map<String, Id> rtDevNameIdMap = getRecordType();
		createServFattList();
        ServFattList__c cs;
        
        if(srv=='') {
                c.PO_Offerta__c='';
           		c.OF_Servizio__c = '';
        }
         
        if(srv =='P2P Attiva'){
				cs = ServFattList__c.getAll().get('P2P Attiva');
        		c.PO_Offerta__c='P2P Attiva';
           		 c.OF_Servizio__c = 'P2P Attiva';
                 
            	 Id r_kit=rtDevNameIdMap.get('PO_Case_P2P_Attiva_KIT');
                 c.RecordTypeId=r_kit;
            	 
        }
       if(srv =='P2P Base') {
				cs = ServFattList__c.getAll().get('P2P Base'); 
                c.PO_Offerta__c='P2P Base';
                c.OF_Servizio__c = 'P2P Base';
           		Id idrecordtype=rtDevNameIdMap.get(cs.caseDevName__c);
    		    c.RecordTypeId = idrecordtype;
           		
       }
        if(srv!=''){
            
    		
       }
       system.debug('#########'+ServFattList__c.getAll());
       //system.debug('##########Servizio: '+srv + ' cs: '+cs);
      
        
		c.Status = 'Acquisito';
        
        c.EOF_Codice_Ordine_OLO__c = 'TIS_0001';
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.EOF_Data_Notifica__c = System.now();
        c.isDOM__c = isDom;
        insert c;
        return c;
    }

    public static void createSemaforoDomTrue() {
        Semaforo_Proxy_Portale__c cs =  new Semaforo_Proxy_Portale__c();	 
        cs.Name = 'Semaforo Proxy Portale Attivazione';
        cs.Semaforo_DOM__c = true;
        cs.Semaforo_Proxy_Portale_Attivazione__c=true;
        insert cs;
    }

    public static void createSemaforoDomFalse() {
        Semaforo_Proxy_Portale__c cs =  new Semaforo_Proxy_Portale__c();	 
        cs.Name = 'Red';
        cs.Semaforo_DOM__c = false;
        cs.Semaforo_Proxy_Portale_Attivazione__c=true;
        insert cs;
    }

    public static void createConfigurazioneMatching() {
        List<Configurazione_DOM__c> list_Cust = new List<Configurazione_DOM__c>();
        Configurazione_DOM__c cs = new Configurazione_DOM__c();
        cs.Name = 'config';
        cs.Servizio_DOM__c = 'P2P Attiva';
        cs.Account_DOM__c = 'TIS';
        cs.Data_DOM__c = System.now();
        list_Cust.add(cs);

        Configurazione_DOM__c cs2 = new Configurazione_DOM__c();
        cs2.Name = 'config-2';
        cs2.Servizio_DOM__c = 'P2P Base';
        cs2.Account_DOM__c = 'VF';
        cs2.Data_DOM__c = System.now();

        list_Cust.add(cs2);

        insert list_Cust;
    }

    public static void createConfigurazioneMismatching() {
        Configurazione_DOM__c cs = new Configurazione_DOM__c();
        cs.Name = 'confxxx';
        cs.Servizio_DOM__c = 'P2P Attiva';
        cs.Account_DOM__c = 'AAA';
        cs.Data_DOM__c = System.now();
        insert cs;
    }
    public static void createConfigurazioneMismatching2() {
        Configurazione_DOM__c cs = new Configurazione_DOM__c();
        cs.Name = 'confxxx';
        cs.Servizio_DOM__c = 'P2P Base';
        cs.Account_DOM__c = 'AAA';
        cs.Data_DOM__c = System.now();
        insert cs;
    }
	public static void createServFattList() {
		List<ServFattList__c> csList = new List<ServFattList__c>();
		
		ServFattList__c cs = new ServFattList__c();
		
		cs.Name = 'P2P Base';
		cs.code__c = 'SE-OF000005';
		cs.ceiDevName__c = 'PO_Portalino';
		cs.caseDevName__c = 'PO_Ordine_P2P';
		cs.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs.caseCollegamentoDevName__c = 'PO_Collegamento_P2P';
		cs.assetDevName__c = 'P2P';
		cs.externalSystem__c = 'PSM';
		cs.attBeList__c = 'Canone,Contributo Attivazione,Contributo Aggiuntivo';
		cs.oppChildDevName__c = 'PO_Oppty_collegamenti_P2PBase';
		cs.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_P2PBase';
		csList.add(cs);
		
		ServFattList__c cs1 = new ServFattList__c();
		cs1.Name = 'P2P Attiva';
		cs1.code__c = 'SE-OF000006';
		cs1.ceiDevName__c = 'PO_Portalino';
		cs1.caseDevName__c = 'PO_Ordine_P2P_Attiva';
		cs1.caseRichiestaDevName__c = 'PO_Richiesta_a_servizio_a_fattibilit';
		cs1.caseCollegamentoDevName__c = 'PO_Collegamento_P2P_Attiva';
		cs1.assetDevName__c = 'PO_Asset_P2P_Attiva_Collegamento';
		cs1.externalSystem__c = '';
		cs1.attBeList__c = 'Canone,Contributo Attivazione,Contributo Aggiuntivo';
		cs1.oppChildDevName__c = 'PO_Oppty_collegamenti_P2P_Attiva';
		cs1.oppParentDevName__c = 'PO_Oppty_Richiesta_fattibilit_P2P_Attiva';
		csList.add(cs1);
		
		insert csList;
	}
	public static Map<String, Id> getRecordType() {
			Map<String, Id> rtDevNameIdMap = new Map<String, Id>();
       // private Map<String, String> myMap = new Map<String, String>('a' => 'John', 'b' => 'Mike', 'c' => 'Eddy');

        for (RecordType rt : [SELECT Id, DeveloperName FROM RecordType]) {
			rtDevNameIdMap.put(rt.DeveloperName, rt.Id);
		}

		return rtDevNameIdMap;
	}
  public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstBase() {
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        Case c = createCaseDomTrue('P2P Base');
        //createCase();
        String cod_ordineolo = [select EOF_Codice_Ordine_OLO__c from Case where Id =: c.Id Limit 1][0].EOF_Codice_Ordine_OLO__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        rqst.data_espletamento_ordine='2019-05-10';
        //rqst.id_notifica = 'notifyId';
        EOF_Notify__c object_notify=new EOF_Notify__c();
      	insert object_notify;
        List <EOF_Notify__c> notify=[SELECT id,name FROM EOF_Notify__c limit 10];
        rqst.id_notifica=notify[0].id;
        rqst.id_fattibilita = cod_ordineolo;
        rqst.id_ordine=cod_ordineolo;
        rqst.stato_ordine='2';
        Attachment allegato=testAttachment(c.id);
        rqst.attachment=allegato.body;
        rqst.attachment_name=allegato.name;
        /*
        Attachment allegato=new Attachment();
        allegato=testAttachment();
        
        rqst.attachment=allegato.body;
        rqst.attachment_name=allegato.name;
        */
        return rqst;        
    }
     public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstBase2() {
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        Case c = createCaseDomTrue('P2P Base');
        //createCase();
        String cod_ordineolo = [select EOF_Codice_Ordine_OLO__c from Case where Id =: c.Id Limit 1][0].EOF_Codice_Ordine_OLO__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        rqst.data_espletamento_ordine='2019-05-10';
        rqst.id_notifica = 'notifyId';
        rqst.id_fattibilita = cod_ordineolo;
        rqst.id_ordine=cod_ordineolo;
        rqst.stato_ordine='1';

        return rqst;        
    }
    public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstBase3() {
         OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        Case c = createCaseDomTrue('P2P Base');
        String caseNmb = [select CaseNumber from Case where Id =: c.Id Limit 1][0].CaseNumber;
        System.debug('##### buildStatusUpdateRqst casenumber : ' + caseNmb);
        rqst.id_notifica = 'notifyId';
        rqst.id_fattibilita = '1';
        rqst.id_ordine= '123';

        return rqst;        
    }
    public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstBase4() {
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        Case c = new Case(); 
		list <RecordType> idrt= [select Id,DeveloperName From RecordType where sObjectType='Case' ];
		createServFattList();
        ServFattList__c cs;

		cs = ServFattList__c.getAll().get('P2P Base'); 
        //c.PO_Offerta__c='P2P Base';
        c.OF_Servizio__c = 'P2P Base';
   		//Id idrecordtype=rtDevNameIdMap.get(cs.caseDevName__c);
	    c.RecordTypeId = idrt[0].id;

        system.debug('#########'+ServFattList__c.getAll());

        //String cod_ordineolo = [select EOF_Codice_Ordine_OLO__c from Case where Id =: c.Id Limit 1][0].EOF_Codice_Ordine_OLO__c;
		c.Status = 'Acquisito';
        c.EOF_Codice_Ordine_OLO__c = 'TIS_0001';
        c.EOF_Codice_Operatore_WS__c = 'TIS';
        c.EOF_Data_Notifica__c = System.now();
        c.isDOM__c = true;
        insert c;
        String cod_ordineolo = [select EOF_Codice_Ordine_OLO__c from Case where Id =: c.Id Limit 1][0].EOF_Codice_Ordine_OLO__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        rqst.data_espletamento_ordine='2019-05-10';
        rqst.id_notifica = 'notifyId';
        rqst.id_fattibilita = cod_ordineolo;
        rqst.id_ordine=cod_ordineolo;
        rqst.stato_ordine='1';
        Attachment allegato=testAttachment(c.id);
        rqst.attachment=allegato.body;
        rqst.attachment_name=allegato.name;
        /*
        Attachment allegato=new Attachment();
        allegato=testAttachment();
        
        rqst.attachment=allegato.body;
        rqst.attachment_name=allegato.name;
        */
        return rqst;        
    }
     public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstAttiva() {
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        rqst.tipo_notifica='Ordine';
         Case c = createCaseDomTrue('P2P Attiva');
        //createCase();
        //String cod_ordineolo = [select EOF_Codice_Ordine_OLO__c from Case where Id =: c.Id Limit 1][0].EOF_Codice_Ordine_OLO__c;
        //
        String cod_ordineolo = c.EOF_Codice_Ordine_OLO__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        //String codiceordine = [select Codice_Ordine_EOF__c from Case where Id =: c.Id Limit 1][0].Codice_Ordine_EOF__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        rqst.data_espletamento_ordine='2019-05-10';
        rqst.id_notifica = 'notifyId';
        rqst.id_ordine=cod_ordineolo;
        //System.debug('Case id '+c.id+' '+'CaseNumber '+caseNmb);
        rqst.id_fattibilita = cod_ordineolo;
        rqst.stato_ordine='2';
        
        return rqst;        
    }
    //ordine null
     public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstAttiva2() {
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        rqst.tipo_notifica='Ordine';
        Case c = createCaseDomTrue('P2P Attiva');
        //createCase();
        String cod_ordineolo = c.EOF_Codice_Ordine_OLO__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        //String codiceordine = [select Codice_Ordine_EOF__c from Case where Id =: c.Id Limit 1][0].Codice_Ordine_EOF__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c : ' + cod_ordineolo);
        rqst.data_espletamento_ordine='2019-05-10';
        rqst.id_notifica = 'notifyId';
        rqst.id_ordine='1';
        //System.debug('Case id '+c.id+' '+'CaseNumber '+caseNmb);
        rqst.id_fattibilita = '1';
        rqst.stato_ordine='2';
        
        return rqst;        
    }
    // SERVIZIO KIT
    public static OF_StatusUpdate_P2P.Request buildStatusUpdateRqstAttiva3() {
        OF_StatusUpdate_P2P.Request rqst = new OF_StatusUpdate_P2P.Request();
        rqst.tipo_notifica='Kit';
        //Case caseOrdine=PO_ServFatt_DataFactory.createP2PAttivaData().caseOrdine; //caseordine
        PO_ServFatt_DataFactory.WrapData cases= PO_ServFatt_DataFactory.createP2PAttivaData();  //casekit
        Case c=cases.caseKit;
        /*List<Case> getCaseOrdine=[SELECT Id, OF_Order__c, OF_SA_Profilo__c FROM Case WHERE PO_KIT_Consegna_VLAN__c =: c.Id
			AND RecordType.DeveloperName = 'PO_Ordine_P2P_Attiva'];
        
           List<Order> getOrder=[SELECT Id, ContractId, Contract.OF_Rinnovabile__c, Contract.NS_Rif__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate, OF_IDContratto__c,
				   NS_Rif__c,  // FD 2019-02-27
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c, (SELECT Accordo_Operativo__c FROM Cases__r)
				   FROM Order WHERE Id =: c.OF_Order__c];
*/
        Case fatt = [SELECT casenumber, EOF_Codice_Ordine_OLO__c FROM Case WHERE Id =:  cases.casePadre.id];
        cases.casePadre.EOF_Codice_Ordine_OLO__c = 'TIS_' + fatt.caseNumber;
        update cases.casePadre;

        Case kit = [SELECT casenumber, EOF_Codice_Ordine_OLO__c FROM Case WHERE Id =:  cases.caseKit.id];
        cases.caseKit.EOF_Codice_Ordine_OLO__c = 'TIS_' + kit.caseNumber;
        update cases.caseKit;
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('PO Ordine P2P Attiva').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c1 = new Case();
       // c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c1.Subject = 'Richiesta Attivazione';
        c1.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c1.EOF_Data_Prevista_Attivazione__c = system.today();
        c1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c1.Status = 'Espletato';
        c1.EOF_Fase__c = 'Espletato OK';
        c1.Type = '1';
        c1.EOF_Tipologia_Servizio__c = 'test1';
        c1.EOF_Codice_Operatore_WS__c = 'VF';
        c1.EOF_SLA_Premium_Assurance__c ='Y';
        //c.Account = acc;
        //c.AssetId = asset_1.id;
        c1.OwnerId = userInfo.getUserId();
        c1.RecordTypeId = CaseRecordTypeId;
        c1.EOF_Id_Notifica__c = 'test_01';
        c1.Origin = 'Web';
        c1.Priority = 'Medium';
        c1.EOF_GPON_Vincolante__c = 'Y';
        c1.OF_Order__c=ordine.id;
        c1.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c1.PO_KIT_Consegna_VLAN__c = cases.caseKit.id;
        insert c1;

        System.debug('***Casekit -- PO_KIT_Consegna_VLAN__c: ' + cases.caseOrdine.PO_KIT_Consegna_VLAN__c);         
        System.debug('***Casekit: '+c.Id);
        System.debug('***c.OF_Order__c: '+c.OF_Order__c);
        //System.debug('***getCaseOrdine: '+getCaseOrdine[0].Id);
       // System.debug('***getOrder: '+getOrder[0].Id);
        //c.OF_Order__c=PO_ServFatt_DataFactory.caseOrdine.OF_Order__c;
         //Case c = createCaseByDom2(true,'P2P Attiva');
        //Case c = createCaseDomTrue('P2P Attiva');
        //Case c=createP2PAttivaData().caseKit;
        //Case caseOrdine=createP2PAttivaData().caseOrdine;
        //String codiceordine = [select Codice_Ordine_EOF__c from Case where Id =: c.Id Limit 1][0].Codice_Ordine_EOF__c;
        rqst.data_espletamento_ordine='2019-05-10';
        rqst.id_notifica = 'notifyId';
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c kit: ' + cases.caseKit.EOF_Codice_Ordine_OLO__c);
        rqst.id_ordine_kit=cases.caseKit.EOF_Codice_Ordine_OLO__c;
        System.debug('##### buildStatusUpdateRqst EOF_Codice_Ordine_OLO__c fattibilità: ' + cases.casePadre.EOF_Codice_Ordine_OLO__c);
        //System.debug('Case id '+c.id+' '+'CaseNumber '+caseNmb);
        rqst.id_fattibilita = cases.casePadre.EOF_Codice_Ordine_OLO__c;
        rqst.stato_ordine='2';       
        
        return rqst;        
    }
    
    public static OF_StatusUpdate_P2P.Response buildAckResponse(String idNotifica) {
        OF_StatusUpdate_P2P.Response rspnse = new OF_StatusUpdate_P2P.Response();
        rspnse.esito = OF_CheckManager_P2P.ESITO_OK;
        rspnse.id_notifica = idNotifica;
        
        return rspnse;
    }
    
    public static OF_StatusUpdate_P2P.Response buildStatusUpdateNackResponse() {
        OF_StatusUpdate_P2P.Response rspnse = new OF_StatusUpdate_P2P.Response();
        rspnse.esito = OF_CheckManager_P2P.ESITO_KO;
        rspnse.id_notifica = 'notifyId';
        rspnse.codice_motivazione = OF_CheckManager_P2P.OBB_ERROR_CODE;
        rspnse.motivazione = OF_CheckManager_P2P.OBB_ERROR_MSG;
        
        return rspnse;
    }
     public static Attachment testAttachment(id caseId){
      /*
          String encodedContentsString = System.currentPageReference().getParameters().get('fileContents');
          Id accountId = System.currentPageReference().getParameters().get('accountId');
          
          Attachment attachment = new Attachment();
          attachment.Body = Blob.valueOf(encodedContentsString);
          attachment.Name = String.valueOf('test.txt');
          attachment.ParentId = accountId; 
          insert attachment;*/
          
    	Blob b = Blob.valueOf('Test Data');
    	Attachment attachment = new Attachment();
    	attachment.ParentId = caseId;
    	attachment.Name = 'Test Attachment for Parent.txt';
    	attachment.Body = b;
    	insert(attachment);

          
          return attachment;
        }
    
    
    @isTest 
    static void getOrderTest() {
        PO_ServFatt_DataFactory.WrapData wrappedData = PO_ServFatt_DataFactory.createP2PAttivaData();
        Order actual = OF_Utils_P2P.getOrder(wrappedData.caseOrdine.OF_Order__c);
        System.assertEquals(wrappedData.caseOrdine.OF_Order__c, actual.Id);
    }

    @isTest 
    static void createOrderKit() {
        PO_ServFatt_DataFactory.WrapData wrappedData = PO_ServFatt_DataFactory.createP2PAttivaData();
        Order orderCaseOrdine = [SELECT Id, ContractId, Contract.OF_Rinnovabile__c, Contract.NS_Rif__c, AccountId, RecordTypeId, Status, OF_Esito__c, OF_Apparato__c,
				   OF_Asset__c, OF_DataEsito__c, OF_EsitoConsegnaApparato__c, OF_ScalaPalazzina__c,
				   OF_GPONAttestazione__c, OF_IDBuilding__c, OF_IDOrdineEOF__c, OF_IDOrdineOLO__c,
				   OF_IDRisorsa__c, OF_IDSplitterSecondario__c, OF_IdentificativoDelPOP__c,
				   OF_Provincia__c, OF_Comune__c, OF_ParticellaToponomastica__c, OF_Indirizzo__c, OF_Civico__c,
				   OF_PosizioneSplitterSecondario__c, OF_SlaPremiumAssurance__c, OF_ClusterPromozione__c,
				   OF_CodiceProgettoSpeciale__c, OF_IDCaso__c, OF_IDServizio__c, OF_PasswordApparato__c,
				   OF_ProgettoSpeciale__c, OF_Promozione__c, OF_TipologiaApparato__c, OF_ProfiloOpenStream__c,
				   PO_Attenuazione__c, PO_DataAttivazioneOrdine__c, PO_LunghezzaOttica__c, OF_Profilo__c,
				   OF_DescrizioneKO__c, effectiveDate, CreatedDate, OF_IDContratto__c,
				   NS_Rif__c, 
				   PO_PosizioneRilascioCircuitoOSU__c, OF_CodiceKO__c, (SELECT Accordo_Operativo__c FROM Cases__r)
				   FROM Order WHERE Id =: wrappedData.caseOrdine.OF_Order__c];

        Id rTypeOrderId = RTypeServFattibilita.getRecordTypeIdByDevName(Order.SObjectType, 'OF_INORDER');
        System.debug('##### rTypeOrderId: ' + rTypeOrderId);
        String profilo = '100M';

        Order actual = OF_Utils_P2P.createOrderKit(wrappedData.caseKit, orderCaseOrdine, rTypeOrderId, profilo);
        Order expected = [SELECT Id FROM Order WHERE Id =: actual.Id];
        System.assertEquals(expected.Id, actual.Id);

    }

    @isTest
    static void espletamentoKitFromDomTest() {
        Test.startTest();
        PO_ServFatt_DataFactory.WrapData wrappedData = PO_ServFatt_DataFactory.createP2PAttivaData();
        EOF_VLAN__c vlan = new EOF_VLAN__c();
        vlan.PO_Opzione__c = 'Standard';
        vlan.caso__c = wrappedData.caseCollegamento.Id;
        insert vlan;

        Case caseColleg = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						   EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						   PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						   PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						   PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						   PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						   EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						   OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						   OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						   EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						   PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						   isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
						   PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
						   OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
						   FROM Case WHERE Id = :wrappedData.caseCollegamento.Id LIMIT 1];

        Pricebook2 pb = new Pricebook2(
			Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		update pb;
        try {
            Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(caseColleg);
        } catch (Exception e) {
            System.debug('##### error: ' + e.getCause());
        }
        Id actual = OF_Utils_P2P.espletamentoKitFromDom(wrappedData.caseKit);
        System.debug('##### actual id: ' + actual);
        Test.stopTest();
    } 



    /***************************************** 
        END - Data factory methods
    */ 
        /*
        public static void createSemaforoDomFalse() {
            Semaforo_Proxy_Portale__c cs =  new Semaforo_Proxy_Portale__c();	 
            cs.Name = 'Red';
            cs.Semaforo_DOM__c = false;
            insert cs;
        }
        
        public static Case createCaseP2PBase() {
            Case c = new Case();
            c.OF_Servizio__c = 'P2P Base';
            c.EOF_Codice_Operatore_WS__c = 'AAA';
            c.EOF_Data_Notifica__c = System.now();
            insert c;
            return c;
        }
        
        public static Case createCaseP2PAttiva() {
            Case c = new Case();
            c.OF_Servizio__c = 'P2P Attiva';
            c.EOF_Codice_Operatore_WS__c = 'AAA'; // account OLO
            c.EOF_Data_Notifica__c = System.now();
            insert c;
            return c;
        } 
        
        public static Case createCaseP2PIsDomTrue() {
            Case c = new Case();
            c.OF_Servizio__c = 'P2P Attiva';
            c.EOF_Codice_Operatore_WS__c = 'AAA'; // account OLO
            c.EOF_Data_Notifica__c = System.now();
            c.isDOM__c = true;
            insert c;
            return c;
        }
        
        public static Case createCase(String service, String codeOperator, Datetime timee) {
            Case c = new Case();
            c.OF_Servizio__c = service;
            c.EOF_Codice_Operatore_WS__c = codeOperator; // account OLO
  https://cs87.salesforce.com/_ui/common/apex/debug/ApexCSIPage#          c.EOF_Data_Notifica__c = timee;
            insert c;
            return c;
        }
        
       
        
        public static void createConfigurazioneDOMP2PBase() {
            Configurazione_DOM__c cs = new Configurazione_DOM__c();
            cs.Name = 'ConfigDom';
            cs.Account_DOM__c = 'AAA';
            cs.Servizio_DOM__c = 'P2P Base';
            cs.Data_DOM__c = System.now();
            insert cs;
        } */
    
  /**  public static testmethod void Method_1(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        //String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        //c.EOF_Account_OLO__c = oloId.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        insert c;
        
        Test.startTest();
        String name ='name';
        Boolean rinnovable = true;
        String s = 'EOF_Caso_Attivazione_OPENSTREAM_CeD';
         PO_ServFatt_CRMHandler crm = new  PO_ServFatt_CRMHandler(s);
        crm.getSrvData();
        OF_Utils_P2P.createAsset(ordine,asset_1.recordTypeId,name,c,rinnovable);
        Test.stopTest();
    } **/ 
    

}