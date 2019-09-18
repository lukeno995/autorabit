@isTest
public class OF_CO_CRM_Handler_Test{
    public static testMethod void OF_CO_CRM_HandlerMethod(){
    
        Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();

    System.debug('@@@RecordTypeIdlis '+RecordTypeIdlis);
    System.debug('@@@RecordTypeIdlis '+RecordTypeIdcom);
        
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
    
        order ord = new order();
        ord.OF_Profilo__c = 'Test';
        ord.AccountId = acc.Id;
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
         contract con = new contract();
        con.AccountID = acc.Id;
        con.OF_IdContratto__c = 'Test';
        con.StartDate = System.today();
        con.ContractTerm = 1234;
        con.Status = 'Draft';
        insert con;
        
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        insert com;
        
        OF_BillingElement__c bill = new OF_BillingElement__c ();
        bill.Name = 'Contributo Cambio Profilo';
        bill.OF_CommercialElement__c = com.Id;
        bill.OF_DataInizioValidita__c = System.today();
        bill.OF_DataFineValidita__c = System.today();
        insert bill;
        
        OF_ServizioBillingElement__c ser = new OF_ServizioBillingElement__c();
        ser.name = 'Contributo Cambio Profilo';
        ser.OF_BillingElement__c = bill.Id;
        ser.OF_Contract__c = con.Id;
        insert ser;
        
        OF_Listino__c lis = new OF_Listino__c();
        lis.Name = 'Test';
        lis.OF_Attivo__c = true;
        lis.OF_IDContract__c= con.Id;
        lis.OF_DataFineValidita__c = System.today();
        lis.OF_DataInizioValidita__c = System.today();
        lis.RecordTypeId = RecordTypeIdlis;
        lis.OF_ServizioBillingElement__c =ser.Id;
        insert lis;
        OF_Listino__c lis1 = new OF_Listino__c();
        lis1.Name = 'Contributo Cambio Profilo';
        lis1.OF_Attivo__c = true;
        lis1.OF_IDContract__c= con.Id;
        lis1.OF_DataFineValidita__c = System.today();
        lis1.OF_DataInizioValidita__c = System.today();
        lis1.RecordTypeId = RecordTypeIdlis;
        lis1.OF_ServizioBillingElement__c =ser.Id;
        insert lis1;
        List<OF_CommercialElementIstanziato__c> comList = new List<OF_CommercialElementIstanziato__c>();
        
         OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_Asset__c  = a.id;
        istan.OF_CommercialElement__c = com.Id;
        istan.RecordTypeId = RecordTypeIdcom;
        insert istan;
        
         Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware',OF_ListinoCustom__c =lis.Id);
        insert prod;
       // prod.name = 'Contributo Cambio Profilo';
       // update prod;
        
        //Id pricebookId = Test.getStandardPricebookId();
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = prod.Id, UnitPrice = 10000, IsActive = true);
        //insert standardPrice;
        
         Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Canone', isActive=true,OF_Listino__c = lis.Id
        );
        insert priceB;
        
        pricebookentry pbeStd = new pricebookentry(
          Product2Id = prod.id,
            Pricebook2Id = pricebookId,
            isActive = true,
            unitprice = -9999
        );
        insert pbeStd;
        
        pricebookentry pbe = new pricebookentry(
            Product2Id = prod.id,
            Pricebook2Id = priceB.Id,
            isActive = true,
            UnitPrice = -9999,
            OF_Asset__c = a.Id,OF_DataCessazione2__c = system.today(),OF_CommercialElementIstanziato__c =istan.id
            
        );
        insert pbe;
        
     OF_CO_CRM_Handler.manageAssetBillingElement(a.Id,ord);
     OF_CO_CRM_Handler.manageAssetVlan(a.Id,comList);
     
    }
    
   /* public static testMethod void OF_CO_CRM_HandlerMethod1(){
    
        Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();

        
        Account acc = new Account();
        acc.name= 'Test';
        insert acc;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = acc.Id;
        insert a;
    
        order ord = new order();
        ord.OF_Profilo__c = 'Test';
        ord.AccountId = acc.Id;
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
         contract con = new contract();
        con.AccountID = acc.Id;
        con.OF_IdContratto__c = 'Test';
        con.StartDate = System.today();
        con.ContractTerm = 1234;
        con.Status = 'Draft';
        insert con;
        
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        insert com;
        
        OF_BillingElement__c bill = new OF_BillingElement__c ();
        bill.Name = 'Contributo Cambio Profilo';
        bill.OF_CommercialElement__c = com.Id;
        bill.OF_DataInizioValidita__c = System.today();
        bill.OF_DataFineValidita__c = System.today();
        insert bill;
        
        OF_ServizioBillingElement__c ser = new OF_ServizioBillingElement__c();
        ser.name = 'Contributo Cambio Profilo';
        ser.OF_BillingElement__c = bill.Id;
        ser.OF_Contract__c = con.Id;
        insert ser;
        
        OF_Listino__c lis = new OF_Listino__c();
        lis.Name = 'Test';
        lis.OF_Attivo__c = true;
        lis.OF_IDContract__c= con.Id;
        lis.OF_DataFineValidita__c = System.today();
        lis.OF_DataInizioValidita__c = System.today();
        lis.RecordTypeId = RecordTypeIdlis;
        lis.OF_ServizioBillingElement__c =ser.Id;
        insert lis;
        
        List<OF_CommercialElementIstanziato__c> comList = new List<OF_CommercialElementIstanziato__c>();
        
         OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_Asset__c  = a.id;
        istan.OF_CommercialElement__c = com.Id;
        istan.RecordTypeId = RecordTypeIdcom;
        insert istan;
        
         Product2 prod = new Product2(Name = 'Contributo Cambio Profilo', Family = 'Hardware',OF_ListinoCustom__c =lis.Id);
        insert prod;
        
        //Id pricebookId = Test.getStandardPricebookId();
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = prod.Id, UnitPrice = 10000, IsActive = true);
        //insert standardPrice;
        
         Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Canone', isActive=true,OF_Listino__c = lis.Id
        );
        insert priceB;
        
        pricebookentry pbeStd = new pricebookentry(
          Product2Id = prod.id,
            Pricebook2Id = pricebookId,
            isActive = true,
            unitprice = -9999
        );
        insert pbeStd;
        
        pricebookentry pbe = new pricebookentry(
            Product2Id = prod.id,
            Pricebook2Id = priceB.Id,
            isActive = true,
            UnitPrice = -9999,
            OF_Asset__c = a.Id,OF_DataCessazione2__c = system.today(),OF_CommercialElementIstanziato__c =istan.id
            
        );
        insert pbe;
        
     OF_CO_CRM_Handler.manageAssetBillingElement(a.Id,ord);
     OF_CO_CRM_Handler.manageAssetVlan(a.Id,comList);
     
    }*/
}