public class PO_P2PAttiva_InsertNewRequest_Ctrl {
	public List<SelectOption> requestOptions{get;set;}
	public String accountname{get;set;}
	public User usr{get;set;}
	public String offertaP2PAttiva{get;set;}
	public String Nome{get;set;}
	public String requestSelected{get;set;}
	public string retUrl;
	public String tipoP2PAttiva {get;set;} //EC 2019 05 23 aggiunto per P2P Attiva fase2 capire se è una eLine o una eAccess
	Map<String,Id> rtMap{get;set;}

	public PO_P2PAttiva_InsertNewRequest_Ctrl() {
		retUrl=ApexPages.currentPage().getUrl();
		//Setto la tipologia di offert
		offertaP2PAttiva = 'P2P Attiva';
		//EC 2019 05 23
		tipoP2PAttiva=ApexPages.currentPage().getParameters().get('tipoP2Patt'); 
		
		//Recupero l'utente loggato
		usr = [SELECT Id, Contact.Account.Name, Account.EOF_Codice_Operatore__c
			   FROM User
			   WHERE Id = :UserInfo.getUserId()];
		//Popolo il campo Azienda
		accountname=usr.Contact.Account.Name;
		//Popolo la lista della dropdown
		requestOptions= new List<SelectOption>();
		requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
		requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));

		List<recordtype> rtList=[select Id,developerName from recordtype]; 
        rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        } 
	}
	//Funzione eseguita al click di Annulla
	public PageReference DeleteParentCase(){
		return new PageReference('/PO_Index');
	}
	//Funzione eseguita al click di Inserisci richiesta
	public Pagereference toP2PAttiva(){
		system.debug('@@@@EC appena nel metodo toP2PAttiva. tipoP2PAttiva: ' + tipoP2PAttiva);
    	PageReference pageRef = new PageReference('');
   		if(requestSelected=='ATT'){//ATTIVAZIONE
            //Inserisco il log della bozza
            EOF_EAI_Service_Log__c parentLog = new EOF_EAI_Service_Log__c();
            if(tipoP2PAttiva == 'eLine'){
                parentLog.RecordTypeId=rtMap.get('P2P_Attiva_Request_E_Line');
            }else{
                parentLog.RecordTypeId=rtMap.get('PO_P2PAttiva_Request');
            }
            parentLog.PO_SA_Data_Inserimento_Ordine__c = datetime.now();
            parentLog.EOF_Data_Notifica__c = datetime.now();
            parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
            parentLog.EOF_Stato_Richiesta__c='Bozza Portale';
            parentLog.EOF_STATO_ORDINE__c ='Bozza Portale';
            parentLog.EOF_Codice_Operatore__c=usr.Account.EOF_Codice_Operatore__c;
            parentLog.PO_Nome_Progetto__c=Nome;
            parentLog.PO_Offerta__c = 'P2P Attiva';
            //LM 30/05
            if(tipoP2PAttiva == 'eLine'){
                parentLog.PO_Tipo_di_collegamento__c ='E-Line';
            }else{
                parentLog.PO_Tipo_di_collegamento__c ='E-Access';
            }
			//Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
			insert parentLog;
			parentLog.EOF_Codice_Ordine_OLO__c= [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id = :parentLog.Id].Name.replace('LOG-',parentLog.EOF_Codice_Operatore__c+'_');
			update parentLog;
            //Aggiungo l'id alla pagina
            if(tipoP2PAttiva == 'eLine'){
                pageRef = new PageReference('/PO_P2PAttiva_EditLogInfoELine');
                // parametro da portare nelle pagine per evitare errori sul Recordtype
                pageref.getParameters().put('tipoP2Patt',tipoP2PAttiva);
                
            }else{
                  // parametro da portare nelle pagine per evitare errori sul Recordtype
                pageref.getParameters().put('tipoP2Patt',tipoP2PAttiva);
                pageRef = new PageReference('/PO_P2PAttiva_EditLogInfo');
            }
				pageRef.getParameters().put('parentId', parentLog.Id);
				pageref.getParameters().put('tipoP2Patt','P2PattAttivazione');
				pageref.getParameters().put('retUrl',retUrl);
   		}else if(requestSelected=='CESS'){// CESSAZIONE
			pageRef = new PageReference('/PO_P2PAttiva_InserimentoIdRisorsa');
   		}
   		pageref.getParameters().put('tipoP2Patt',tipoP2PAttiva);//EC 2019 05 24
		pageref.getParameters().put('Nome',Nome);
		pageRef.setRedirect(true);
    	return pageref;
    }
}