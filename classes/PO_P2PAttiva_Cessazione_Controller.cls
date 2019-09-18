public class PO_P2PAttiva_Cessazione_Controller {
	public static EOF_EAI_Service_Log__c slOrig{get;set;}
	public EOF_EAI_Service_Log__c sl{get;set;}
	public boolean modifyMode{get;set;}
	public boolean insertMode{get;set;}
	public boolean Apparati{get;set;}
	public String messages{get;set;}
	public Map<String,Id> rtMap;

	public PO_P2PAttiva_Cessazione_Controller() {
		insertMode=false;
		modifyMode=false;
		apparati=false;
		if(ApexPages.currentPage().getParameters().get('parentId') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('parentId')) ){
			sl = [SELECT Id, recordtypeId, PO_SA_Data_Inserimento_Ordine__c, EOF_Data_Notifica__c, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, EOF_CODICE_OPERATORE__c,
							EOF_Tipo_Comunicazione_String__c, EOF_ID_Risorsa__c, PO_Nome_Progetto__c, EOF_Nome_Cliente__c, EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
							EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, EOF_NOTE__c, EOF_Codice_Ordine_OLO__c 
					FROM EOF_EAI_Service_Log__c
					WHERE Id = :ApexPages.currentPage().getParameters().get('parentId') ];
			modifyMode = true;
		}else{
			List<recordtype> rtList=[select Id,developerName from recordtype]; 
			rtMap = new Map<String,Id>(); 
			for(recordtype rt :rtList){
				rtMap.put(rt.developerName, rt.Id); 
			} 
			//Recupero l'utente loggato
			User usr = [SELECT Id, Contact.Account.Name, Account.EOF_Codice_Operatore__c
					FROM User
					WHERE Id = :UserInfo.getUserId()];
			sl = new EOF_EAI_Service_Log__c();
				sl.recordtypeId=rtMap.get('PO_P2PAttiva_Request'); 
				sl.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
				sl.EOF_Data_Notifica__c = datetime.now();
				sl.EOF_Stato_Richiesta__c='Bozza Portale';
				sl.EOF_STATO_ORDINE__c ='Bozza Portale';
				sl.EOF_CODICE_OPERATORE__c=usr.Account.EOF_Codice_Operatore__c;
				sl.EOF_Tipo_Comunicazione_String__c='Ordine di Cessazione';
				sl.PO_Nome_Progetto__c = ApexPages.currentPage().getParameters().get('Nome');
				sl.EOF_ID_Risorsa__c=ApexPages.currentPage().getParameters().get('IdRisorsa');
			insertMode = true;
		}
		
	}
	public pageReference savesl(){
    	try{
    		insert sl;
			PageReference pg = new PageReference('/PO_P2PAttiva_CessazioneDetails');
			pg.getParameters().put('origId', sl.Id);
			pg.getParameters().put('viewMode', 'modify');
    		return pg;
    	}catch(DMLexception e){
    		ApexPages.addMessages(e);
    		return null; 
    	}
    	PageReference pg = new PageReference('/PO_P2P_Attivo_DisplayRequest');
    	return pg;
    }
	public pageReference annullaInsSl(){ 
    	PageReference pg;
    	pg = new PageReference('/PO_P2P_Attivo_DisplayRequest');
    	return pg;
    }
	public pageReference updatesl(){
    	try{
			update sl;
		}catch(DMLexception e){
    		ApexPages.addMessages(e);
    		return null;
    	}
		PageReference pg = new PageReference('/PO_P2PAttiva_CessazioneDetails');
		pg.getParameters().put('origId', sl.Id);
		pg.getParameters().put('viewMode', 'modify');
    	return pg;
    }
}