@isTest
public class OF_TTM_WS_Notify_Utils_Test {

    @isTest
    public static void ccreate_EAI_Logtest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_WS_Notify_Utils.create_EAI_Log(o1);
    }
   
    @isTest
    public static void writeLogtest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     //OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
        OF_TTM_WS_IN_Notify.TTM_Notify ttm_req = new OF_TTM_WS_IN_Notify.TTM_Notify();
		ttm_req.TIPO_COMUNICAZIONE = '4444'; //3,4,5,7,10,13
		ttm_req.CODICE_COMUNICAZIONE_OLO = 'VF_ASS_TT_1234';
		ttm_req.ID_NOTIFICA = 'QWERTY123';    
		ttm_req.ID_TT = '123456';   
		ttm_req.CODICE_OPERATORE = 'VF';
		ttm_req.ID_RISORSA = 'ID_R123';
		ttm_req.DATA_ORA_NOTIFICA_SOSPENSIONE = '2017-08-22T19:20:30+01:00';  
		ttm_req.CAUSALE_SOSPENSIONE = '1';    
		ttm_req.DESCRIZIONE_INTERVENTO_RISOLUZIONE = '8';     
		//ttm_req.INTERVENTO_CONGIUNTO = 'Y';
		ttm_req.DATA_ORA_INTERVENTO_CONGIUNTO = '2017-04-12T19:20:30+01:00';
		ttm_req.TEC_OLO = 'Herman Strauss';
		ttm_req.TEL_TEC_OLO = '096457832';
		ttm_req.NOTE = 'TEST';
        
     //OF_TTM_WS_Notify_Utils.writeLog(o1);
        
       //OF_TTM_WS_Notify_Utils.sLogTTMSF = OF_TTM_WS_Notify_Utils.create_EAI_Log(ttm_req);
        
       

            //Inserisco il log della request
            //insert OF_TTM_WS_Notify_Utils.sLogTTMSF;
            
        EOF_EAI_Service_Log__c log_Portale = new EOF_EAI_Service_Log__c();

		//-------Case Creation-----------
		Case caso = new case();
		//Aggancio l'asset al case
		//caso.AssetId = objAsset.Id;
		caso.status = 'Chiuso';
		//update caso;

		//Aggancio il caso al log
		log_Portale.Caso__c  = caso.Id;
		//update log_Portale;
            OF_TTM_WS_Notify_Utils.sLogTTMSF=log_Portale;
              
        
            OF_TTM_WS_Notify_Utils.writeLog(ttm_req,'NACK','test','test');
            
        
    }
    
    @isTest
    public static void copy_requesttest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_WS_Notify_Utils.copy_request(o1);
    }
    
    @isTest
    public static void syncErrorCaseStatustest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_WS_Notify_Utils.syncErrorCaseStatus(o1);
    }
    
    @isTest
    public static void responseACKtest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_WS_Notify_Utils.responseACK(o1);
    }
     @isTest
    public static void responseToTTMByOLOResptest1()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'ACK'  ; 
     OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(o1);
    }
     @isTest
    public static void responseToTTMByOLOResptest2()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'NACK'  ; 
     EOF_EAI_Service_Log__c  e1 = new EOF_EAI_Service_Log__c();
     e1.EOF_Codice_Errore__c='test'; 
     e1.EOF_Causale_Errore__c='test';   
     OF_TTM_Utils.sLogSFOLOResp =e1;
     OF_TTM_Utils.sLogSFOLOResp =e1; 
     OF_TTM_WS_Notify_Utils.responseToTTMByOLOResp(o1);
    }
    
  /*  @isTest
    public static void responseExceptiontest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'ACK'  ; 
    // Exception e = new Exception() ;
     OF_TTM_WS_Notify_Utils.responseException(o1,e);
    }*/
    
    @isTest
    public static void syncErrorCodiceComunicazioneOLOtest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'ACK'  ; 
     OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO(o1);
    }
    
    @isTest
    public static void syncErrorCodiceComunicazioneOLO_TICKETID_TTMtest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'ACK'  ; 
     OF_TTM_WS_Notify_Utils.syncErrorCodiceComunicazioneOLO_TICKETID_TTM(o1);
    }
    
    @isTest
    public static void syncErrorStatustest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'ACK'  ; 
     OF_TTM_WS_Notify_Utils.syncErrorStatus(o1);
    }
    
    @isTest
    public static void CheckTipoComtest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_Utils.responseDaOLO = 'ACK'  ; 
     OF_TTM_WS_Notify_Utils.CheckTipoCom(o1);
    }
    
    @isTest
    public static void syncErrortest()
    {
     OF_TTM_WS_Notify_Utils ob1=new  OF_TTM_WS_Notify_Utils();
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     OF_TTM_WS_Notify_Utils.syncError(o1);
        
     o1.ID_RISORSA ='test'; 
     OF_TTM_WS_Notify_Utils.syncError(o1);
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1); 
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1);  
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     OF_TTM_WS_Notify_Utils.syncError(o1);  
      
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3='test'; 
     OF_TTM_WS_Notify_Utils.syncError(o1);   
       
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3='test'; 
     OF_TTM_WS_Notify_Utils.syncError(o1); 
     
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test'; 
     OF_TTM_WS_Notify_Utils.syncError(o1); 
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7='test'; 
     OF_TTM_WS_Notify_Utils.syncError(o1); 
     
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_10='test'; 
     OF_TTM_WS_Notify_Utils.syncError(o1); 
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5='test'; 
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1);   
       
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     o1.DATA_ORA_NOTIFICA_CHIUSURA='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test'; 
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1);    
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     o1.DATA_ORA_NOTIFICA_CHIUSURA='test';
     o1.CAUSALE_SOSPENSIONE='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1);  
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     o1.DATA_ORA_NOTIFICA_CHIUSURA='test';
     o1.CAUSALE_SOSPENSIONE='test';
     o1.REFERENTE_DESOSPENSIONE='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1); 
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     o1.DATA_ORA_NOTIFICA_CHIUSURA='test';
     o1.CAUSALE_SOSPENSIONE='test';
     o1.REFERENTE_DESOSPENSIONE='test';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='test';
     o1.INTERVENTO_CONGIUNTO ='test'; 
     OF_TTM_WS_Notify_Utils.INTERVENTO_CONGIUNTO_Y='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1);  
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     o1.DATA_ORA_NOTIFICA_CHIUSURA='test';
     o1.CAUSALE_SOSPENSIONE='test';
     o1.REFERENTE_DESOSPENSIONE='test';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='test';
     o1.TEC_OLO='test';
     o1.INTERVENTO_CONGIUNTO ='test'; 
     OF_TTM_WS_Notify_Utils.INTERVENTO_CONGIUNTO_Y='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1);  
        
     o1.ID_RISORSA ='test'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_NOTIFICA='test';
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.DATA_ORA_CREAZIONE_TT ='test';
     o1.ID_TT='test';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='test';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='test';
     o1.DATA_ORA_NOTIFICA_CHIUSURA='test';
     o1.CAUSALE_SOSPENSIONE='test';
     o1.REFERENTE_DESOSPENSIONE='test';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='test';
     o1.TEC_OLO='test';
     o1.TEL_TEC_OLO='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';   
     OF_TTM_WS_Notify_Utils.syncError(o1); 
      
      
     
       
        
    }  
    @isTest
    public static  void syncErrortest2()
     {
     
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
    
     o1.ID_NOTIFICA='test123412341234123412345test1234123412341234123451'; 
     o1.CODICE_OPERATORE='test'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     OF_TTM_WS_Notify_Utils.syncError(o1);  
       
     o1.ID_TT='test123412341234123412345test1234123412341234123451'; 
     o1.ID_NOTIFICA='test';    
     o1.CODICE_OPERATORE='test'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';  
     OF_TTM_WS_Notify_Utils.syncError(o1); 
         
     o1.CODICE_OPERATORE='test123412341234123412345test1234123412341234123451'; 
     o1.ID_TT='test';   
     o1.ID_NOTIFICA='test'; 
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.ID_RISORSA='tt';    
     OF_TTM_WS_Notify_Utils.syncError(o1);  
         
     o1.ID_RISORSA='test123412341234123412345test1234123412341234123451'; 
     o1.ID_TT='test';   
     o1.ID_NOTIFICA='test'; 
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     o1.CODICE_OPERATORE='tt';    
     OF_TTM_WS_Notify_Utils.syncError(o1);  
      
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='test';
     o1.CODICE_COMUNICAZIONE_OLO='test';
     OF_TTM_WS_Notify_Utils.syncError(o1);   
     
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='test123412341234123412345test1234123412341234123451';
     OF_TTM_WS_Notify_Utils.syncError(o1);  
    
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='t25';
     OF_TTM_WS_Notify_Utils.syncError(o1);
     
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='t1';
     OF_TTM_WS_Notify_Utils.syncError(o1);
     
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='t1';
     OF_TTM_WS_Notify_Utils.syncError(o1);
         
         o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='t1';
     OF_TTM_WS_Notify_Utils.syncError(o1);
         
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='t1';
     OF_TTM_WS_Notify_Utils.syncError(o1);
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='test';
     OF_TTM_WS_Notify_Utils.syncError(o1);     
       
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
     OF_TTM_WS_Notify_Utils.syncError(o1);
         
      o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='test';
     OF_TTM_WS_Notify_Utils.syncError(o1);  
         
       
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='t1';
     OF_TTM_WS_Notify_Utils.syncError(o1); 
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='test';
     OF_TTM_WS_Notify_Utils.syncError(o1); 
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345';
     OF_TTM_WS_Notify_Utils.syncError(o1); 
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='1234512345123451234512345';
     OF_TTM_WS_Notify_Utils.syncError(o1);
         
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='t1';
     OF_TTM_WS_Notify_Utils.syncError(o1);
         
      
     }
    
    @isTest
    public static  void syncErrortest3()
    {
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE ='1234512345123451234512345';   
     OF_TTM_WS_Notify_Utils.syncError(o1);  
        
        
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='t';  
     o1.CODICE_COMUNICAZIONE_OLO='t';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_SOSPENSIONE ='1234512345123451234512345';   
     OF_TTM_WS_Notify_Utils.syncError(o1);  
        
        
     }
    
    @isTest
    public static  void syncErrortest4()
    {
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='t';  
     o1.CODICE_COMUNICAZIONE_OLO='t';
     
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';  
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
    
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
  
     o1.DATA_ORA_NOTIFICA_DESOSPENSIONE='1234512345123451234512345';
        OF_TTM_WS_Notify_Utils.syncError(o1);    }
    
    @isTest
    public static  void syncErrortest5()
    {
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7 ='test';   
     o1.CODICE_COMUNICAZIONE_OLO='t';
     
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';  
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
    
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
     o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';   
  
        OF_TTM_WS_Notify_Utils.syncError(o1);    }
    
    @isTest
    public static  void syncErrortest6()
    {
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7 ='test';   
     o1.CODICE_COMUNICAZIONE_OLO='t';
     
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';  
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3='test';  
     //o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
    
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';   
  
        OF_TTM_WS_Notify_Utils.syncError(o1);    }
    
    @isTest
    public static  void syncErrortest7()
    {
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7 ='test';   
     o1.CODICE_COMUNICAZIONE_OLO='t';
     
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';  
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3='test'; 
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_10='test';  
     //o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
    
     //o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
     o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345'; 
  
        OF_TTM_WS_Notify_Utils.syncError(o1);    }
    
    @isTest
    public static  void syncErrortest8()
    {
     OF_TTM_WS_IN_Notify.TTM_Notify o1=new OF_TTM_WS_IN_Notify.TTM_Notify();
     o1.ID_NOTIFICA='test'; 
     o1.CODICE_OPERATORE='tt'; 
     o1.ID_RISORSA='test'; 
     o1.TIPO_COMUNICAZIONE='t';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_13 ='test';
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_7 ='t';   
     o1.CODICE_COMUNICAZIONE_OLO='t';
     
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_4='test';  
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_3='test'; 
     OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_10='test';
      OF_TTM_WS_Notify_Utils.TIPO_COMUNICAZIONE_5='test';   
     //o1.DATA_ORA_CREAZIONE_TT='1234512345123451234512345';
    
     //o1.DATA_ORA_NOTIFICA_ANNULLAMENTO='1234512345123451234512345';
    // o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345';
     o1.CAUSALE_SOSPENSIONE='t';
     o1.REFERENTE_DESOSPENSIONE='t1';
     o1.DESCRIZIONE_INTERVENTO_RISOLUZIONE='t';
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
     o1.INTERVENTO_CONGIUNTO='t';
     o1.TEC_OLO='t1';
     o1.TEL_TEC_OLO='t1';
     o1.DATA_ORA_INTERVENTO_CONGIUNTO='1234512345123451234512345';
    // o1.DATA_ORA_NOTIFICA_CHIUSURA ='1234512345123451234512345'; 
     o1.RISCHEDULAZIONE_APPUNTAMENTO='1234512345123451234512345';
        OF_TTM_WS_Notify_Utils.syncError(o1);    }
    @isTest
    public static  void stringToDateTimetest()
     {
        string date3 = string.valueof(datetime.now());
        OF_TTM_WS_Notify_Utils.stringToDateTime(date3);
        
    
     }
    
    @isTest
    public static  void DateTimeToStringtest()
     {
        datetime dt1=datetime.now();
        OF_TTM_WS_Notify_Utils.DateTimeToString(dt1);
        
    
     }
    
     @isTest
    public static  void verificaDateTimetest()
     {
        string date3 = string.valueof(datetime.now());
        OF_TTM_WS_Notify_Utils.verificaDateTime(date3);
        
    
     }
    
    @isTest
    public static  void getMethodValuetest()
     {
        list<string> nlist = new  list<string>{'3','4','5','7','10','13','8'};
            for(string str : nlist)
        {
            OF_TTM_WS_Notify_Utils.getMethodValue(str);
        }
        
        
    
     }
    @isTest
    public static  void getValueLogTipoComtest()
     {
        String statoRichiesta='Test';
        list<string> nlist = new  list<string>{'3','4','5','7','10','13','8'};
            for(string str : nlist)
        {
            OF_TTM_WS_Notify_Utils.getValueLogTipoCom(str,statoRichiesta);
        }
        
        
    
     }
     @isTest
    public static  void  nowtest()
     {
        
            OF_TTM_WS_Notify_Utils.now();
     }
    
     @isTest
    public static  void getDescRisoluzionetest()
     {
         OF_TTM_WS_Notify_Utils.getDescRisoluzione('');
        list<string> nlist = new  list<string>{'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21'};
            for(string str : nlist)
        {
            OF_TTM_WS_Notify_Utils.getDescRisoluzione(str);
        }
        
        
    
     }
    
    
}