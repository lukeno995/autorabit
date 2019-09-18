@IsTest(SeeAllData=false)
public class PO_OppLineItemTrigger_TEST {
    static testMethod void validateTriggerOPLI() {
    Account a = new Account(Name = 'Test Account Joe ');
    insert a;
     Pricebook2 pb22 = new Pricebook2(Name='testDIE');
     insert pb22;
    
    Product2 pro2 = new Product2(Name='BXCD', isActive=true);
    insert pro2;
    
    PricebookEntry pbe2 =new PricebookEntry(unitprice=0.01,Product2Id=pro2.Id,Pricebook2Id=Test.getStandardPricebookId(),
                                             isActive=true,UseStandardPrice = false);
     insert pbe2;  
    Opportunity o = new Opportunity();
    OpportunityLineItem ol = new OpportunityLineItem();
         

     
    o.AccountId = a.Id;
    o.Name = 'Test_Joe_123';
    o.StageName = 'Prospecting';
    o.CloseDate = date.today();
    o.Type = 'New Business';
    insert o;
         
    ol.OpportunityId = o.Id;
    ol.Quantity = 1;
    ol.UnitPrice = 2.00;
    ol.PricebookEntryId = pbe2.Id;
         
    insert ol;
    }
}