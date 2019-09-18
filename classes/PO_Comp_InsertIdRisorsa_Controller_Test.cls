@isTest
public class PO_Comp_InsertIdRisorsa_Controller_Test {


   public static testMethod void Method1()
   {
   

    Id RecordTypeIdlis = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
       
    
    Account acc = new Account();
    acc.name= 'Test';
    acc.EOF_Codice_Operatore__c='t1';
      
    insert acc;
       system.debug(acc.Id);
       
    user u=new user();
    u.ContactId=acc.PersonContactId;
       system.debug(u.AccountId);
       system.debug(u.ContactId);
        
    Asset a = new Asset();
    a.Status = 'Attivo';
    a.Name = 'demo';
    a.AccountID = acc.Id;
    a.RecordTypeId = RecordTypeIdlis ;
    insert a; 
    
   ApexPages.currentPage().getParameters().put('idRisorsa',a.name);
   ApexPages.currentPage().getParameters().put('valid','false');
   ApexPages.currentPage().getParameters().put('proc','InserimentoRichiestaCHANORD');
   PO_COMP_InsertIdRisorsa_Controller obj1 =new PO_COMP_InsertIdRisorsa_Controller() ;  
   pagereference pg;
   pg=obj1.routeRequest();
    ApexPages.currentPage().getParameters().put('valid','true');
    //PO_COMP_InsertIdRisorsa_Controller obj1 =new PO_COMP_InsertIdRisorsa_Controller() ;  
  // pagereference pg;
   pg=obj1.routeRequest();
  
   }
    
  public static testMethod void Method2()  
  {
     PO_COMP_InsertIdRisorsa_Controller obj1=new  PO_COMP_InsertIdRisorsa_Controller();
   
     pagereference pg;
     pg=obj1.routeRequest();
  }
    
}