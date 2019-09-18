@isTest
public with sharing class PO_P2PAttiva_InserimentoVLAN_Ctrl_Test {

@isTest
static void testometodo1(){
   	    insertData();
        EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_InserimentoVLAN);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        PO_P2PAttiva_InserimentoVLAN_Controller ctrl = new PO_P2PAttiva_InserimentoVLAN_Controller();      	
        ctrl.hiddenNameProfilo='3Play';
        ctrl.hiddenOpzioneProfilo='Flexible';
   		ctrl.getRecordProfili();
    	ctrl.insertVlanLog();
    	//ctrl.annullavlan();
        //Fine scope del test
        Test.stopTest();
	}
    @isTest
	static void testometodo2(){
    	insertData2();
    	EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_InserimentoVLAN);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        PO_P2PAttiva_InserimentoVLAN_Controller ctrl = new PO_P2PAttiva_InserimentoVLAN_Controller();
        ctrl.hiddenNameProfilo='3Play';
        ctrl.hiddenOpzioneProfilo='Standard';
        ctrl.getRecordProfili();
    	ctrl.insertVlanLog();
    	//ctrl.annullavlan();
        //Fine scope del test
        Test.stopTest();
	}
    @isTest
    static void testometodo3(){
    insertData2();
     EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_InserimentoVLAN);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        PO_P2PAttiva_InserimentoVLAN_Controller ctrl = new PO_P2PAttiva_InserimentoVLAN_Controller();      	
        ctrl.hiddenNameProfilo='Voce e Dati';
        ctrl.hiddenOpzioneProfilo='Standard';
        ctrl.getRecordProfili();
    	ctrl.insertVlanLog();
        //ctrl.annullavlan();
        //Fine scope del test
        Test.stopTest();
	}
    @isTest
    static void testometodo4(){
    	insertData2();
    	 EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_InserimentoVLAN);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        PO_P2PAttiva_InserimentoVLAN_Controller ctrl = new PO_P2PAttiva_InserimentoVLAN_Controller();
        ctrl.hiddenNameProfilo='Voce e Dati';
        ctrl.hiddenOpzioneProfilo='Flexible';
        ctrl.getRecordProfili();
    	ctrl.insertVlanLog();
        //ctrl.annullavlan();
        //Fine scope del test
        Test.stopTest();
	}
    @isTest
    static void testometodo5(){
    	insertData2();
    	 EOF_EAI_Service_Log__c parentLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA' LIMIT 1];
        EOF_EAI_Service_Log__c childLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE PO_Nome_Progetto__c = 'TEST_AA_child' LIMIT 1];
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_InserimentoVLAN);
        //Setto l'id del childLog
        ApexPages.currentPage().getParameters().put('cLogId', childLog.Id);
        PO_P2PAttiva_InserimentoVLAN_Controller ctrl = new PO_P2PAttiva_InserimentoVLAN_Controller();
        ctrl.hiddenNameProfilo='Solo Dati';
        ctrl.hiddenOpzioneProfilo='Standard';
        ctrl.getRecordProfili();
    	ctrl.insertVlanLog();
        //ctrl.annullavlan();
        //Fine scope del test
        Test.stopTest();
	}
    public static void insertData (){
    List<RecordType> rtList = [SELECT developername, Id 
                                   FROM RecordType];
   Map<String,String> rtMap = new Map<String,String>();
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
            /*System.debug('rt.developerName: '+rt.developerName);*/
        }
    account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc; 
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;         
        
        OF_ElencoComuniItaliani__c comune = new OF_ElencoComuniItaliani__c();
        comune.OF_CodiceIstat__c = 'Test';
        comune.OF_Provincia__c = 'Test';
        comune.OF_Comune__c = 'Test';
        insert comune;
        
        //ParentLog
        EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();	
        parentLog.RecordTypeId = rtMap.get('PO_P2PAttiva_Request');
        parentLog.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
        parentLog.EOF_Data_Notifica__c = datetime.now();
        parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
        parentLog.EOF_Stato_Richiesta__c= 'Bozza Portale';
        parentLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
        parentLog.EOF_Codice_Operatore__c = acc.EOF_Codice_Operatore__c;
        parentLog.PO_Nome_Progetto__c = 'TEST_AA';
        parentLog.PO_Offerta__c = 'P2P Attiva';
        //Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
        System.debug('***parentLog insert: '+parentLog);
        insert parentLog;
        
        //ChildLog
        EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();	
        childLog.RecordTypeId = rtMap.get('P2P_Attiva_Collegamento');
        childLog.PO_Offerta__c = 'P2P Attiva';
        childLog.PO_Tipo_di_collegamento__c = 'Point-to-Point';
        childLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        childLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
        childLog.EOF_Codice_Operatore__c = acc.EOF_Codice_Operatore__c;
        childLog.EOF_Comune__c =  [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :comune.Id].OF_Comune__c;
        childLog.OF_Id_Comune__c = comune.Id;
        childLog.EOF_SL_Riferimento__c = parentLog.Id;
        childLog.PO_Nome_Progetto__c = 'TEST_AA_child';
        childLog.EOF_PROFILO__c = 'M';
  	    System.debug('***childLog insert: '+childLog);
        insert childLog;
        createCustomSettings();
	}
    public static void insertData2 (){
    List<RecordType> rtList = [SELECT developername, Id 
                                   FROM RecordType];
   Map<String,String> rtMap = new Map<String,String>();
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
            /*System.debug('rt.developerName: '+rt.developerName);*/
        }
    account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc; 
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;         
        
        OF_ElencoComuniItaliani__c comune = new OF_ElencoComuniItaliani__c();
        comune.OF_CodiceIstat__c = 'Test';
        comune.OF_Provincia__c = 'Test';
        comune.OF_Comune__c = 'Test';
        insert comune;
        
        //ParentLog
        EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();	
        parentLog.RecordTypeId = rtMap.get('PO_P2PAttiva_Request');
        parentLog.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
        parentLog.EOF_Data_Notifica__c = datetime.now();
        parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
        parentLog.EOF_Stato_Richiesta__c= 'Bozza Portale';
        parentLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
        parentLog.EOF_Codice_Operatore__c = acc.EOF_Codice_Operatore__c;
        parentLog.PO_Nome_Progetto__c = 'TEST_AA';
        parentLog.PO_Offerta__c = 'P2P Attiva';
        //Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
        System.debug('***parentLog insert: '+parentLog);
        insert parentLog;
        
        //ChildLog
        EOF_EAI_Service_Log__c childLog = new EOF_EAI_Service_Log__c();	
        childLog.RecordTypeId = rtMap.get('P2P_Attiva_Collegamento');
        childLog.PO_Offerta__c = 'P2P Attiva';
        childLog.PO_Tipo_di_collegamento__c = 'Point-to-Point';
        childLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
        childLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
        childLog.EOF_Codice_Operatore__c = acc.EOF_Codice_Operatore__c;
        childLog.EOF_Comune__c =  [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :comune.Id].OF_Comune__c;
        childLog.OF_Id_Comune__c = comune.Id;
        childLog.EOF_SL_Riferimento__c = parentLog.Id;
        childLog.PO_Nome_Progetto__c = 'TEST_AA_child';
        childLog.EOF_PROFILO__c = 'G';
  	    System.debug('***childLog insert: '+childLog);
        insert childLog;
        createCustomSettings();
	}
    public static void createCustomSettings() {
		List<Configurazione_VLAN__c> csList = new List<Configurazione_VLAN__c>();
		
		Configurazione_VLAN__c cs = new Configurazione_VLAN__c();
		
		cs.Name = 'SoloDatiStandard';
		cs.Profilo__c='Solo Dati';
		cs.COS1PIR__c='100';
		cs.COS1CIR__c='100';
		cs.COS5CIR__c='0';
		cs.COS3CIR__c='0';
		cs.COS5PIR__c='0';
		cs.COS3PIR__c='0';
		cs.Opzione__c='Standard';
		csList.add(cs);
		
		Configurazione_VLAN__c cs1 = new Configurazione_VLAN__c();
		cs1.Name = 'VoceDatiFlexible';
		cs1.Profilo__c='Voce e Dati';
		cs1.COS1PIR__c='95';
		cs1.COS1CIR__c='80';
		cs1.COS5CIR__c='20';
		cs1.COS3CIR__c='0';
		cs1.COS5PIR__c='20';
		cs1.COS3PIR__c='0';
		cs.Opzione__c='Flexible';
		csList.add(cs1);
		
		
		Configurazione_VLAN__c cs2 = new Configurazione_VLAN__c();
		cs2.Name = 'VoceDatiStandard';
		cs2.Profilo__c='Voce e Dati';
		cs2.COS1PIR__c='80';
		cs2.COS1CIR__c='80';
		cs2.COS5CIR__c='20';
		cs2.COS3CIR__c='0';
		cs2.COS5PIR__c='20';
		cs2.COS3PIR__c='0';
		cs.Opzione__c='Standard';
		csList.add(cs2);
		
		
		Configurazione_VLAN__c cs4 = new Configurazione_VLAN__c();
		cs4.Name = '3PlayFlexible';
		cs4.Profilo__c='3Play';
		cs4.COS1PIR__c='95';
		cs4.COS1CIR__c='95';
		cs4.COS5CIR__c='5';
		cs4.COS3CIR__c='25';
		cs4.COS5PIR__c='5';
		cs4.COS3PIR__c='95';
		cs.Opzione__c='Flexible';
		csList.add(cs4);
		
		Configurazione_VLAN__c cs5 = new Configurazione_VLAN__c();
		cs5.Name = '3PlayStandard';
		cs5.Profilo__c='3Play';
		cs5.COS1PIR__c='70';
		cs5.COS1CIR__c='70';
		cs5.COS5CIR__c='5';
		cs5.COS3CIR__c='25';
		cs5.COS5PIR__c='5';
		cs5.COS3PIR__c='25';
		cs.Opzione__c='Standard';
		csList.add(cs5);
		
		insert csList;
	}
}