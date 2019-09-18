public class PO_P2PAttiva_DesospClg_Controller {
	
    public EOF_EAI_Service_Log__c sl{get;set;}
    public case CaseClg {get;set;}
    public boolean desospendi{get;set;}
    public boolean success {get;set;}
    public String recordOfferta {get;set;}    
    
    public PO_P2PAttiva_DesospClg_Controller(){
    
        sl= [select Id, EOF_Codice_Ordine_OLO__c,Caso__c,Name, EOF_Codice_Operatore__c, EOF_Stato_Richiesta__c,PO_Prime_Contractor__c,
            Note_Sospensione_Operatore__c,PO_Sito__c,PO_Offerta__c,PO_Tipo_percorso__c,PO_Numero_fibre_richieste__c,
            PO_Tipo_di_collegamento__c,EOF_ID_Pop__c,PO_Indirizzo_collegamento__c, EOF_SL_Riferimento__c,
            EOF_Comune__c,PO_Nome_Progetto__c,EOF_PROFILO__c,PO_Civico__c,PO_Nota_sito__c,EOF_STATO_ORDINE__c, EOF_Comunicazioni_con_OLO__c, caso__r.Note_Sospensione_Operatore__c
            from EOF_EAI_Service_Log__c where Id=:Apexpages.currentPage().getParameters().get('ChildId')]; 
            
        CaseClg =[select id,status, eof_fase__c, EOF_COmunicazioni_con_OLO__c, Note_Sospensione_Operatore__c from case where id =: sl.caso__c];     
            
        desospendi = false;
        success = false;
        
        if(Apexpages.currentPage().getParameters().get('proc')=='desospensione'){
            desospendi=true;
            //title='Desospensione';
            sl.EOF_Motivazione__c='';
            //sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=null;
	    	sl.EOF_ORARIO_APPUNTAMENTO__c='';
	    	sl.EOF_Note__c='';
        }               
    
    }
    
    
	public pageReference annullaFlusso(){
	    
    	PageReference pg = new PageReference('/PO_P2PAttiva_OverviewchildLogReq');
        pg.getParameters().put('childid',Apexpages.currentPage().getParameters().get('ChildId'));
        return pg;
	}
	
	public pagereference InoltraFlusso(){
		
		// 2018-09-05 MM : faccio l'update del case
		CaseClg.status = 'Acquisito';
		CaseClg.eof_fase__c ='NA';
		CaseClg.EOF_Data_Ora_Desospensione__c = system.now();
		
		if(CaseClg.EOF_COmunicazioni_con_OLO__C != null){
			CaseClg.EOF_COmunicazioni_con_OLO__C= CaseClg.EOF_COmunicazioni_con_OLO__C +'\n'+ PO_P2PAttiva_DesospClg_Controller.DateToString(system.now()).left(19)+' - '+'Desospensione OLO'+' - '+userinfo.getName()+':\n'+sl.EOF_NOTE__c;
		
		}else{
			CaseClg.EOF_COmunicazioni_con_OLO__C= PO_P2PAttiva_DesospClg_Controller.DateToString(system.now()).left(19)+' - '+'Desospensione OLO'+' - '+userinfo.getName()+':\n'+sl.EOF_NOTE__c;
		
		}
		
		update CaseClg;
		
		// 2018-09-05 MM : finisce qui update del case
		
		// 2018-09-05 MM : faccio update del service log
		
		sl.EOF_STATO_ORDINE__c = CaseClg.status;
		
		if(sl.eof_comunicazioni_con_olo__c != null){
			sl.eof_comunicazioni_con_olo__c = sl.eof_comunicazioni_con_olo__c +'\n'+ PO_P2PAttiva_DesospClg_Controller.DateToString(system.now()).left(19)+' - '+'Desospensione OLO'+' - '+userinfo.getName()+':\n'+sl.EOF_NOTE__c;
		
		}else{
			sl.eof_comunicazioni_con_olo__c =  PO_P2PAttiva_DesospClg_Controller.DateToString(system.now()).left(19)+' - '+'Desospensione OLO'+' - '+userinfo.getName()+':\n'+sl.EOF_NOTE__c;
		
		}
		
		update sl;
		
		// finisce qui
		
		PageReference pg = new PageReference('/PO_P2PAttiva_OverviewchildLogReq');
	    pg.getParameters().put('childid',Apexpages.currentPage().getParameters().get('ChildId'));
	    return pg;
		
	
	}
	
    public static String dateToString(datetime dt){
        if(String.isBlank(String.valueOf(dt))){
            return null;
        }
        Integer offset = UserInfo.getTimeZone().getOffset(OF_TTM_Utils.now())/3600000;
        String prefix = (offset >= 0) ? '+'  : '-';
        String a = prefix + ((Math.abs(offset) < 10) ? ('0'+ Math.abs(offset) + ':00') : (Math.abs(offset) + ':00'));
        String s = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\''+a+'\'');
        return s;
    }	
    


}