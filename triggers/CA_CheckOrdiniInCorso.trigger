trigger CA_CheckOrdiniInCorso on Case (Before insert) {
    
    RecordType checkRType = [select Id from recordtype where developername = 'CA_Amministratori' and sobjecttype = 'Case' limit 1];
    Set<String> IdBuildingInseriti = new Set<String>();
    List<Case> caseNuovi = new List<Case>();
    Boolean checkTrigger=false;
    for(Case c : trigger.new){
        if(c.recordtypeId==checkRType.id){
        	if(!String.isBlank(c.CA_ID_Building__c)){
	            IdBuildingInseriti.add(c.CA_ID_Building__c);
	            caseNuovi.add(c);
	            checkTrigger=true;
        	}
        }
    }
    if(checkTrigger){  
	    List<Case> CaseInCorso = [select Id,EOF_Codice_Ordine_OLO__C,Status,EOF_ID_Building_WS__c from Case where (recordtype.developerName='EOF_Caso_Attivazione' OR recordtype.developerName='OF_SA_Attivazione') and EOF_ID_Building_WS__c in:IdBuildingInseriti order by createdDate ASC];
	    List<Case> caseToUpdate = new List<Case>();
	    if(!CaseInCorso.isEmpty()){ 
	        for(Case cNuovo : caseNuovi){
	        	Integer i=0;
	            for(Case c : CaseInCorso){
	                if(cNuovo.CA_ID_Building__c==c.EOF_ID_Building_WS__c){
	                    cNuovo.CA_Codice_Ordine_in_Corso__c=c.EOF_Codice_Ordine_OLO__C;
	                    cNuovo.CA_Stato_Ordine_in_Corso__c=c.status;
	                    i=i+1;
	                    cNuovo.CA_Numero_Ordini_in_Corso__c=i;
	                }
	            } 
	            if(i>0){
	            	caseToUpdate.add(cNuovo);
	            }
	        } 
	    }
    }
}