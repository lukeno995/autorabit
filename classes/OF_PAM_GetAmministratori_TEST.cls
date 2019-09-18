@isTest
public class OF_PAM_GetAmministratori_TEST  
{    
    @testSetup
    static void createData()
    {
		CA_Amministratore__c amministratore1 = new CA_Amministratore__c();
        CA_Amministratore__c amministratore2 = new CA_Amministratore__c();
        CA_Amministratore__c amministratore3 = new CA_Amministratore__c();
        CA_Amministratore__c amministratore4 = new CA_Amministratore__c();
        List<CA_Amministratore__c> amministratoriDaInserire = new List<CA_Amministratore__c>();
        
        amministratore1.Name = 'Rossi';
        amministratore1.CA_Citt__c = 'Roma';
        
        amministratore2.Name = 'RossiDue';
        amministratore2.CA_Citt__c = 'Milano';
        
        amministratore3.Name = 'Gialli';
        
        amministratore4.Name = 'ragione sociale test';
        
        amministratoriDaInserire.add(amministratore1);
        amministratoriDaInserire.add(amministratore2);
        amministratoriDaInserire.add(amministratore3);
        amministratoriDaInserire.add(amministratore4);
        
        insert amministratoriDaInserire;
    }
    
    static testmethod void byCognome()
    {
        OF_PAM_GetAmministratori.GetAmministratoriRequest request = new OF_PAM_GetAmministratori.GetAmministratoriRequest();
        request.Stringa_Cognome = 'ros'; 
        
        List<OF_PAM_GetAmministratori.GetAmministratoriResponse> response = OF_PAM_GetAmministratori.WS_GetAmministratori(request);
        
        System.assertEquals(response.size(), 2);
    }
    
    static testmethod void byRagioneSociale()
    {
        OF_PAM_GetAmministratori.GetAmministratoriRequest request = new OF_PAM_GetAmministratori.GetAmministratoriRequest();
        request.Stringa_RagSociale = 'ragi';  
        
        List<OF_PAM_GetAmministratori.GetAmministratoriResponse> response = OF_PAM_GetAmministratori.WS_GetAmministratori(request);
        System.assertEquals(response.size(), 1);
    }
    
    static testmethod void byCognomeAndRagioneSociale()
    {
        OF_PAM_GetAmministratori.GetAmministratoriRequest request = new OF_PAM_GetAmministratori.GetAmministratoriRequest();
        request.Stringa_Cognome = 'ros'; 
        request.Stringa_RagSociale = 'ragi';  
        
        List<OF_PAM_GetAmministratori.GetAmministratoriResponse> response = OF_PAM_GetAmministratori.WS_GetAmministratori(request);
        System.assertEquals(response.size(), 3);
    }    
    
    static testmethod void CognomeAndRagioneSocialeAreEmpty()
    {
        OF_PAM_GetAmministratori.GetAmministratoriRequest request = new OF_PAM_GetAmministratori.GetAmministratoriRequest();        
        
        List<OF_PAM_GetAmministratori.GetAmministratoriResponse> response = OF_PAM_GetAmministratori.WS_GetAmministratori(request);
        System.assertEquals(response.size(), 0);
    }
    
    static testmethod void byCittaAlso()
    {
        OF_PAM_GetAmministratori.GetAmministratoriRequest request = new OF_PAM_GetAmministratori.GetAmministratoriRequest();
        request.Stringa_Cognome = 'ros';
        request.Stringa_Citta = 'roma';
        
        List<OF_PAM_GetAmministratori.GetAmministratoriResponse> response = OF_PAM_GetAmministratori.WS_GetAmministratori(request);
        System.assertEquals(response.size(), 1);
    }
}