public class OF_TT_Case_Buttons_Controller{
    private Case originalCase;
    public boolean notifyNotSent{get;set;}
    public Integer notifyType{get;set;}    
    public String notifyStatus{get;set;}
    public String CaseId{get;set;}
    public String contactStatus{get;set;}
    public String browserSource{get;set;}
    public String idNotify{get;set;}
    public String recordTypeNotify{get;set;}
    public static xmlnsEnelItOloGatewaySicronizzazion.FiberNotifyRespType  res_notify; 
  
    public OF_TT_Case_Buttons_Controller(ApexPages.StandardController stdController){
        if(!system.test.isRunningTest()){
		    stdController.addFields(new List<String>{'EOF_codice_operatore_WS__c','EOF_Codice_Comunicazione_OLO__c','EOF_ID_Notifica__c',
		        'EOF_Data_Ora_Intervento_Congiunto__c','EOF_Id_Risorsa__c','EOF_Rischedulazione_Appuntamento__c','EOF_Data_Ora_Sospensione__c',
		        'EOF_Causale_Sospensione__c','EOF_Descrizione_Intervento_Risoluzione__c','EOF_Intervento_Congiunto__c', 'EOF_Referente_desospensione__c',
                'EOF_Note__c','EOF_Tel_Tec_EOF__c','EOF_Tec_EOF__c'});
        }
        originalCase = (Case)stdController.getRecord();
        system.debug('il case è: '+originalCase);                                                                   
    }  
    public void richiestaChiusura(){
        CaseId=originalcase.Id;
        of_TT_Utils.create_notify(originalcase, 5, '','');
        EOF_Notify__c notify = of_TT_Utils.getNotify();
        idNotify=notify.Id;
    }
    public void sospendi(){
        CaseId=originalcase.Id;
        of_TT_Utils.create_notify(originalcase, 4, '','');
        EOF_Notify__c notify = of_TT_Utils.getNotify();
        idNotify=notify.Id;
    }
    public void desospendi(){
        CaseId=originalcase.Id;
        of_TT_Utils.create_notify(originalcase, 7, '','');
        EOF_Notify__c notify = of_TT_Utils.getNotify();
        idNotify=notify.Id;
    }
    public void annulla(){
        CaseId=originalcase.Id;
        of_TT_Utils.create_notify(originalcase, 10, '','');
        EOF_Notify__c notify = of_TT_Utils.getNotify();
        idNotify=notify.Id;
    } 
    public void PrendiInCarico(){
        CaseId=originalcase.Id;
        originalCase.OwnerId=userinfo.getUserId();
        update originalCase;
    }   
    public void deleteNotifyNotSent(){
    	List<EOF_Notify__c> nList= [select Id from EOF_Notify__c where Caso__c=:originalCase.Id and EOF_inviata__c=false];
    	if(!nList.isEmpty()){
        delete nList;
		notifyNotSent= true;
    	}
    	else{
    		notifyNotSent= false;
    	}
    } 
      
}