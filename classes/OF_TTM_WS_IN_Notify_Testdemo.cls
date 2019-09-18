@isTest
public class OF_TTM_WS_IN_Notify_Testdemo {

    @isTest
    public static void Forif_test() 
    { 
        //-------Log Creation-------------
		EOF_EAI_Service_Log__c log_Portale =new EOF_EAI_Service_Log__c ();

		//-------Case Creation-------------
		Case caso = new Case();
		log_Portale.Caso__c  = caso.Id;
		
		//-------------TTM Creation----------------		 
		OF_TTM_WS_IN_Notify.TTM_Notify ttm_req = new OF_TTM_WS_IN_Notify.TTM_Notify();
		ttm_req.TIPO_COMUNICAZIONE = '4'; //3,4,5,7,10,13
		ttm_req.CODICE_COMUNICAZIONE_OLO = 'VF_ASS_TT_1234';
		ttm_req.ID_NOTIFICA = 'QWERTY123';    
		ttm_req.ID_TT = '123456';   
		ttm_req.CODICE_OPERATORE = 'VF';
		ttm_req.ID_RISORSA = 'ID_R123';
		ttm_req.DATA_ORA_NOTIFICA_SOSPENSIONE = '2017-07-16T19:20:30+01:00';  
		ttm_req.CAUSALE_SOSPENSIONE = '1';    
		ttm_req.DESCRIZIONE_INTERVENTO_RISOLUZIONE = '8';     
		//ttm_req.INTERVENTO_CONGIUNTO = 'N';
		ttm_req.DATA_ORA_INTERVENTO_CONGIUNTO = '2017-08-22T19:20:30+01:00';
		ttm_req.TEC_OLO = 'Herman Strauss';
		ttm_req.TEL_TEC_OLO = '096457832';
		ttm_req.NOTE = 'TEST';
		//-------------TTM Ends-----------------------

		//Start test
        Test.startTest();       
        Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        OF_TTM_WS_IN_Notify.TTM_Notify(ttm_req);
        Test.stopTest();
    }
    
    @isTest
    public static void NotForif_test() 
    {
       
        //-------Log Creation-------------
		EOF_EAI_Service_Log__c log_Portale =new EOF_EAI_Service_Log__c ();
        EOF_EAI_Service_Log__c log_Portale1 =new EOF_EAI_Service_Log__c ();
		//-------Case Creation-------------
		Case caso1 = new Case();
		log_Portale.Caso__c  = caso1.Id; 
        
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7 ='test';   
     o1.CODICE_COMUNICAZIONE_OLO='t';
     
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';  
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3='test'; 
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_10='test';
      OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5='t';   
     //o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
    
     //o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     //o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     OF_TTM_WS_Notify_Utils.CAUSALE_SOSPENSIONE_3='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     //o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='2009-07-16T19:20:30-05:00';
     o1.INTERVENTO_CONGIUNTO='Y';
      OF_TTM_WS_Notify_Utils.INTERVENTO_CONGIUNTO_Y  ='Y';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='2009-07-16T19:20:30-05:00';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='2009-07-16T19:20:30-05:00'; 
      o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='1'; 
      //Start test
        Test.startTest();       
        Test.setMock(WebServiceMock.class, new OF_TTM_WS_IN_Notify_CalloutMock());
        OF_TTM_Utils.sLogSFOLO=log_Portale;
        //OF_TTM_Utils.sLogSFOLO=log_Portale;
        OF_TTM_Utils.sLogSFOLOResp=log_Portale1;
        //OF_TTM_WS_Notify_Utils.caseTTM=caso1;
        OF_TTM_WS_IN_Notify.TTM_Notify(o1);
        Test.stopTest();  
        
    }
    
    

}