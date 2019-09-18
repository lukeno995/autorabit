public class PO_EditContactController {
    
    public contact loggedInContact {get;set;}
    public account userAcc {get;set;}
    
    public PO_EditContactController(){
        
        user usr = [Select ContactId, AccountId From User Where Id = :UserInfo.getUserId()];
        System.debug('@@contactId:->'+ UserInfo.getUserId());
        System.debug('@@contactId:-> UserInfo'+UserInfo.getName());
        loggedInContact = [Select FirstName,LastName, Email,PO_Contatto_telefonico__c,
                           PO_N_Licenza__c,
                           PO_Struttura_di_appartenenza__c
                           From Contact
                           Where Id =:usr.ContactId 
                          ];
    }
    
    public pageReference saveIt(){
        
         System.debug('  UserInfo'+UserInfo.getName());
        update loggedInContact;
        
       // PageReference myinfopage = new PageReference('/PO_Index?page=MyInfo');
        PageReference myinfopage = new PageReference('/PO_Index');
        myinfopage.setRedirect(true);
        return myinfopage;
    }
    public pageReference cancelIt(){
      //  PageReference myinfopage = new PageReference('/PO_Index?page=MyInfo');
        PageReference myinfopage = new PageReference('/PO_Index');
        myinfopage.setRedirect(true);
        return myinfopage; 
    }
    
}