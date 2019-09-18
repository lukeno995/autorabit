global class OF_PAM_GetAmministratori 
{
	global class GetAmministratoriRequest
    {      
    	webservice String Stringa_Cognome;
        webservice String Stringa_RagSociale;
        webservice String Stringa_Citta;
    }
    
    global class GetAmministratoriResponse
    {
        webservice String CognomeAmministratore; 
        webservice String AlboAmministratore; 
        webservice String ExternalID;
        webservice String Citta; 
        webservice String CodiceFiscale;
        webservice String EmailAmministratore;
        webservice String IDBuildingScala;
        webservice String IndirizzoAmministratore;
        webservice String NomeAmministratore;
        webservice String PIVA;
        webservice String TelefonoAmministratore;	
    }    
    
    webservice static List<GetAmministratoriResponse> WS_GetAmministratori(GetAmministratoriRequest request)
    {
        List<GetAmministratoriResponse> response = new List<GetAmministratoriResponse>();
        
        if(String.isBlank(request.Stringa_Cognome) && String.isBlank(request.Stringa_RagSociale))
        {
            return response;
        }
        
        if(!isLunghezzaDeiCampiInputOK(request.Stringa_Cognome, request.Stringa_RagSociale, request.Stringa_Citta))
        {
            return response;   
        }
        
        String query = 'SELECT Name, CA_Albo_Amministratore__c, CA_External_ID__c, CA_Citt__c, CA_Codice_Fiscale__c, CA_Email_Amministratore__c, CA_ID_Building_Scala__c, CA_Indirizzo_Amministratore__c, CA_Nome_Amministratore__c, CA_P_IVA__c, CA_Telefono_Amministratore__c FROM CA_Amministratore__c ';        
        
        if(String.isNotBlank(request.Stringa_Cognome) && String.isNotBlank(request.Stringa_RagSociale))
        {
            query += 'WHERE (Name LIKE \'' + request.Stringa_Cognome + '%\' OR Name LIKE \'' + request.Stringa_RagSociale + '%\')';
        }
        else if (String.isNotBlank(request.Stringa_Cognome))
        {
            query += 'WHERE Name LIKE \'' + request.Stringa_Cognome + '%\'';
        }
        else if (String.isNotBlank(request.Stringa_RagSociale))
        {
            query += 'WHERE Name LIKE \'' + request.Stringa_RagSociale + '%\'';
        }
        
        if(String.isNotBlank(request.Stringa_Citta))
        {
            query += ' AND CA_Citt__c = \'' + request.Stringa_Citta + '\'';
        }
        
        query += ' ORDER BY Name,CA_Nome_Amministratore__c ASC LIMIT 20';
        
        system.debug('query ' + query);
        
        List<CA_Amministratore__c> amministratori = new List<CA_Amministratore__c>();
        try
        {
        	amministratori = Database.query(query);
        }
        catch(Exception e)
        {       
            OF_Utility.logMessage(true,'E','OF_PAM_GetAmministratori','WS_GetAmministratori','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
            return response;
        }
        
        if(amministratori != null && amministratori.size() > 0)
        {
            for(CA_Amministratore__c amministratore : amministratori)
            {
                GetAmministratoriResponse rItem = new GetAmministratoriResponse();  
                
                rItem.CognomeAmministratore = amministratore.Name;
                rItem.AlboAmministratore = amministratore.CA_Albo_Amministratore__c;
				rItem.ExternalID = amministratore.CA_External_ID__c;
				rItem.Citta = amministratore.CA_Citt__c;
				rItem.CodiceFiscale = amministratore.CA_Codice_Fiscale__c;
				rItem.EmailAmministratore = amministratore.CA_Email_Amministratore__c;
				rItem.IDBuildingScala = amministratore.CA_ID_Building_Scala__c;
				rItem.IndirizzoAmministratore = amministratore.CA_Indirizzo_Amministratore__c;
				rItem.NomeAmministratore = amministratore.CA_Nome_Amministratore__c;
				rItem.PIVA = amministratore.CA_P_IVA__c;
				rItem.TelefonoAmministratore = amministratore.CA_Telefono_Amministratore__c;	
                
                response.add(rItem);
            }
        }
        
        system.debug('response ' + response);
        return response;
    }
    
    private static Boolean isLunghezzaDeiCampiInputOK(String cognome, String ragioneSociale, String citta)
    {
        if(String.isNotBlank(cognome))
        {
            if(cognome.length() < 2 || cognome.length() > 10)
                return false;
        }
        
        if(String.isNotBlank(ragioneSociale))
        {
            if(ragioneSociale.length() < 2 || ragioneSociale.length() > 10)
                return false;
        }
        
        if(String.isNotBlank(citta))
        {        
            if(citta.length() < 1 || citta.length() > 20)
                return false;
        }
            
        return true;
    }
}