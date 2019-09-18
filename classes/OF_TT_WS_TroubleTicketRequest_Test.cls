@isTest
public class OF_TT_WS_TroubleTicketRequest_Test {
	@testSetup
    static void testSetupData(){
    	OF_Conf_Tripletta_TTM__c config = new OF_Conf_Tripletta_TTM__c();
        	config.Name = 'TIS_OPENSTREAM';
        	config.POP_Abilitati__c = 'MI/FCO/9';
        insert config;         
    }
    static testMethod void Metodo12334252(){        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        	tt.TIPO_COMUNICAZIONE='1';
        OF_TTM_Utils.checkCaseOriginale=false; 
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    static testMethod void Metodo12334252bis(){  
        OF_Configurazioni__c conf = new OF_Configurazioni__c();
        	conf.Name = 'boh';
        	conf.OF_DataSwitchTTM__c = Date.today().addDays(-1);
        	conf.OF_TT_TuttoSuTTM__c = true;
        insert conf;
        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        	tt.TIPO_COMUNICAZIONE='1';
        OF_TTM_Utils.checkCaseOriginale=false; 
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    static testMethod void Metodo12334252bis1(){  
        OF_Configurazioni__c conf = new OF_Configurazioni__c();
        	conf.Name = 'boh';
        	conf.OF_DataSwitchTTM__c = Date.today().addDays(-1);
        	conf.OF_TT_TuttoSuTTM__c = false;
        insert conf;
        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        	tt.TIPO_COMUNICAZIONE='1';
        OF_TTM_Utils.checkCaseOriginale=false; 
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    static testMethod void Metodo12334252bis2(){  
        OF_Configurazioni__c conf = new OF_Configurazioni__c();
        	conf.Name = 'boh';
        	conf.OF_DataSwitchTTM__c = Date.today().addDays(-1);
        	conf.OF_TT_TuttoSuTTM__c = false;
        insert conf;
        Account accOLO = new Account();
            accOLO.Name = 'Tiscali';
            accOLO.EOF_Codice_Operatore__c = 'Tis';
            accOLO.Type = 'OLO';
            accOLO.Industry = 'Telecommunications';
        	accOLO.RecordTYpeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'OLO' LIMIT 1].Id;
        insert accOLO;
        
        Asset a = new Asset();
        	a.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'OF_OpenStream' LIMIT 1].Id;
        	a.Name = 'TEST_AA_001';
        	a.EOF_Id_Risorsa__c = 'TEST_AA_001';
        	a.AccountId = accOLO.Id;
        	a.OF_Identificativo_del_POP__c = 'MI/FCO/9';
        insert a;
        	
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        	tt.TIPO_COMUNICAZIONE='1';
        	tt.CODICE_OPERATORE = 'TIS';
        	tt.ID_RISORSA = 'TEST_AA_001';
        OF_TTM_Utils.checkCaseOriginale=false; 
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }

    @isTest
    public static  void Metodo1(){
        OF_TT_WS_TroubleTicketRequest ob1=new OF_TT_WS_TroubleTicketRequest();
        OF_TT_WS_TroubleTicketRequest.TroubleTicket ob2 = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse  ob3= new  OF_TT_WS_TroubleTicketRequest.returnTroubleTicketResponse();
        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt=new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    
    @isTest
    public static  void Metodo2(){        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        	tt.TIPO_COMUNICAZIONE='1';
        OF_TTM_Utils.checkCaseOriginale=true; 
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    
    
    
    @isTest
    public static  void Metodo3(){
           
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt=new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.TIPO_COMUNICAZIONE='2';
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    
     @isTest
    public static  void Metodo4(){
           
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt=new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.TIPO_COMUNICAZIONE='2';
        tt.CODICE_COMUNICAZIONE_OLO='test';
        OF_TTM_Utils.checkCaseOriginale=false; 
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    
    @isTest
    public static  void Metodo5(){
           
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt=new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.TIPO_COMUNICAZIONE='2';
        tt.CODICE_COMUNICAZIONE_OLO='test';
        OF_TTM_Utils.checkCaseOriginale=true; 
        case c1=new case();
        c1.OF_TroubleTicketManager__c=true;
        OF_TTM_Utils.caseOriginale=c1;
        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }
    
    @isTest
    public static  void Metodo6(){
   
        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket tt=new OF_TT_WS_TroubleTicketRequest.TroubleTicket();
        tt.TIPO_COMUNICAZIONE='2';
        tt.CODICE_COMUNICAZIONE_OLO='test';
        OF_TTM_Utils.checkCaseOriginale=true; 
        case c1=new case();
        c1.OF_TroubleTicketManager__c=false;
        OF_TTM_Utils.caseOriginale=c1;
        
        OF_TT_WS_TroubleTicketRequest.TroubleTicket(tt);
    }

}