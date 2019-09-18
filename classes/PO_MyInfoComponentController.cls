public class PO_MyInfoComponentController {
    
    public PO_MyInfoComponentController(){       
      
    }
    public user usr {
        get{
            user user = [Select Contact.Name,
                         Contact.FirstName,
                         Contact.LastName,
                         Contact.Email,
                         Contact.PO_Contatto_telefonico__c,                         
                         Contact.PO_N_Licenza__c,
                         Contact.PO_Struttura_di_appartenenza__c,
                         AccountId,
                         ContactId
                         From User Where Id = :UserInfo.getUserId()];
            return user;
        }
        set;
    }
}