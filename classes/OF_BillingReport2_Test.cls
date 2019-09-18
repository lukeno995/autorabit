/*
@isTest
public class OF_BillingReport2_Test{
    public static testMethod void OF_BillingReportMethod(){
    
        Account acc = new account();
        acc.name = 'Billing Report';
        insert acc;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.OF_Comune__c ='Test';
        ord.OF_Comune__c = 'Test';
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'GPON Passiva';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        OF_BillingElement__c obe = new OF_BillingElement__c();
        obe.OF_CommercialElement__c = com.Id;
        obe.Name = 'Canone';
        //obe.OF_Servizio__c = ofs.Id;
        obe.OF_Attivo__c = true;
        obe.OF_DataFineValidita__c = system.today();
        obe.OF_DataInizioValidita__c = system.today();
        insert obe;
        
        Product2 prod = new Product2();
        prod.Name = 'Test'; 
        //prod.OF_Servizio__c = ofs.Id;
        prod.OF_BillingElement__c = obe.Id;
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = prod.Id;
        standardPrice.UnitPrice = 10000; 
        standardPrice.IsActive = true;
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2();
        customPB.Name='Custom Pricebook';
        customPB.isActive=true;
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry();
        customPrice.OF_Order__c = ord.Id;
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2018, 9, 15, 12, 30, 0);
        //customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);  
        customPrice.Pricebook2Id = customPB.Id;
        customPrice.Product2Id = prod.Id;
        customPrice.UnitPrice = 12000; 
        customPrice.IsActive = true;
        insert customPrice;
        
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);
        update customPrice;
     
        Catalogo_Billing__c cb = new Catalogo_Billing__c();
        cb.OF_Account__c = acc.Id;
        cb.Customer_Name__c = 'Test';
        cb.EOF_Comune__c ='Test';
        cb.EOF_Customer_ID__c = 'Test';  
        insert cb;  
        
        OF_BillingReport2 obr = new OF_BillingReport2();
        obr.dat = Date.newInstance(1900,1,1);
        obr.dat1 = Date.newInstance(2100,1,1);
        obr.combotypeout='Attivazioni';
        obr.downloadasExcel();
        obr.getvlstWrapper();
        obr.getComboType();
        obr.displayMethod();
        obr.getLstwrapRecords();
        obr.setPagination();
        obr.first();
        obr.last();
        obr.previous();
        obr.next();
        //da togliere
        obr.codeCoverage();
        
        
        OF_BillingReport2.wrapperReport wrap = new OF_BillingReport2.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
        //wrap.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
    
    }
    
    public static testMethod void OF_BillingReportMethod1(){
    
        Account acc = new account();
        acc.name = 'Billing Report';
        insert acc;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.OF_Comune__c ='Test';
        ord.OF_Comune__c = 'Test';
        ord.OF_IDRisorsa__c = 'Test';
        //ord.OF_Type__c = 'INORDER';
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'Open Stream';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        OF_BillingElement__c obe = new OF_BillingElement__c();
        obe.OF_CommercialElement__c = com.Id;
        obe.Name = 'Canone Premium';
        //obe.OF_Servizio__c = ofs.Id;
        obe.OF_Attivo__c = true;
        obe.OF_DataFineValidita__c = system.today();
        obe.OF_DataInizioValidita__c = system.today();
        insert obe;
        
        Product2 prod = new Product2();
        prod.Name = 'Test'; 
        //prod.OF_Servizio__c = ofs.Id;
        prod.OF_BillingElement__c = obe.Id;
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = prod.Id;
        standardPrice.UnitPrice = 10000; 
        standardPrice.IsActive = true;
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2();
        customPB.Name='Custom Pricebook';
        customPB.isActive=true;
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry();
        customPrice.OF_Order__c = ord.Id;
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2018, 9, 15, 12, 30, 0);
        //customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);  
        customPrice.Pricebook2Id = customPB.Id;
        customPrice.Product2Id = prod.Id;
        customPrice.UnitPrice = 12000; 
        customPrice.IsActive = true;
        insert customPrice;
        
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);
        update customPrice;
        
        String combotypeout ='Attivazioni';
        Catalogo_Billing__c cb = new Catalogo_Billing__c();
        cb.OF_Account__c = acc.Id;
        cb.Customer_Name__c = 'Test';
        cb.EOF_Comune__c ='Test';
        cb.EOF_Customer_ID__c = 'Test';  
        insert cb;  
        
        OF_BillingReport2 obr = new OF_BillingReport2();
        obr.dat = Date.newInstance(1900,1,1);
        obr.dat1 = Date.newInstance(2100,1,1);
        obr.combotypeout='Attivazioni';
        obr.downloadasExcel();
        obr.getvlstWrapper();
        obr.getComboType();
        obr.displayMethod();
        obr.getLstwrapRecords();
        obr.setPagination();
        obr.first();
        obr.last();
        obr.previous();
        obr.next();
        
        
        
        OF_BillingReport2.wrapperReport wrap = new OF_BillingReport2.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
        //wrap.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
    
    }
 }
 */
 
 @isTest
public class OF_BillingReport2_Test{
    public static testMethod void OF_BillingReportMethod(){
    
        Account acc = new account();
        acc.name = 'Billing Report';
        insert acc;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.OF_Comune__c ='Test';
        ord.OF_Comune__c = 'Test';
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'GPON Passiva';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        OF_BillingElement__c obe = new OF_BillingElement__c();
        obe.OF_CommercialElement__c = com.Id;
        obe.Name = 'Canone';
        //obe.OF_Servizio__c = ofs.Id;
        obe.OF_Attivo__c = true;
        obe.OF_DataFineValidita__c = system.today();
        obe.OF_DataInizioValidita__c = system.today();
        insert obe;
        
        Product2 prod = new Product2();
        prod.Name = 'Test'; 
        //prod.OF_Servizio__c = ofs.Id;
        prod.OF_BillingElement__c = obe.Id;
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = prod.Id;
        standardPrice.UnitPrice = 10000; 
        standardPrice.IsActive = true;
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2();
        customPB.Name='Custom Pricebook';
        customPB.isActive=true;
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry();
        customPrice.OF_Order__c = ord.Id;
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2018, 9, 15, 12, 30, 0);
        //customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);  
        customPrice.Pricebook2Id = customPB.Id;
        customPrice.Product2Id = prod.Id;
        customPrice.UnitPrice = 12000; 
        customPrice.IsActive = true;
        insert customPrice;
        
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);
        update customPrice;
     
        Catalogo_Billing__c cb = new Catalogo_Billing__c();
        cb.OF_Account__c = acc.Id;
        cb.Customer_Name__c = 'Test';
        cb.EOF_Comune__c ='Test';
        cb.EOF_Customer_ID__c = 'Test';  
        insert cb;  
        
        OF_BillingReport2 obr = new OF_BillingReport2();
        obr.dat = Date.newInstance(1900,1,1);
        obr.dat1 = Date.newInstance(2100,1,1);
        obr.combotypeout='Attivazioni';
        obr.downloadasExcel();
        obr.getvlstWrapper();
        obr.getComboType();
        obr.displayMethod();
        obr.getLstwrapRecords();
        obr.setPagination();
        obr.first();
        obr.last();
        obr.previous();
        obr.next();
        //da togliere
        //Commented fake method as suggested by Pietro on 15012019
        // obr.codeCoverage();
        
        
        OF_BillingReport2.wrapperReport wrap = new OF_BillingReport2.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
        //wrap.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
    
    }
     
 //Edited on 15012019  
 

    public static testMethod void OF_BillingReportMethod1(){
    
        Account acc = new account();
        acc.name = 'Billing Report';
        insert acc;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.OF_Comune__c ='Test';
        ord.OF_Comune__c = 'Test';
        ord.OF_IDRisorsa__c = 'Test';
        //ord.OF_Type__c = 'INORDER';
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'Open Stream';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        OF_BillingElement__c obe = new OF_BillingElement__c();
        obe.OF_CommercialElement__c = com.Id;
        obe.Name = 'Canone Premium';
        //obe.OF_Servizio__c = ofs.Id;
        obe.OF_Attivo__c = true;
        obe.OF_DataFineValidita__c = system.today();
        obe.OF_DataInizioValidita__c = system.today();
        insert obe;
        
        Product2 prod = new Product2();
        prod.Name = 'Test'; 
        //prod.OF_Servizio__c = ofs.Id;
        prod.OF_BillingElement__c = obe.Id;
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = prod.Id;
        standardPrice.UnitPrice = 10000; 
        standardPrice.IsActive = true;
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2();
        customPB.Name='Custom Pricebook';
        customPB.isActive=true;
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry();
        customPrice.OF_Order__c = ord.Id;
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2018, 9, 15, 12, 30, 0);
        //customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);  
        customPrice.Pricebook2Id = customPB.Id;
        customPrice.Product2Id = prod.Id;
        customPrice.UnitPrice = 12000; 
        customPrice.IsActive = true;
        insert customPrice;
        
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);
        update customPrice;
        
        String combotypeout ='Attivazioni';
        Catalogo_Billing__c cb = new Catalogo_Billing__c();
        cb.OF_Account__c = acc.Id;
        cb.Customer_Name__c = 'Test';
        cb.EOF_Comune__c ='Test';
        cb.EOF_Customer_ID__c = 'Test';  
        insert cb;  
        
        OF_BillingReport2 obr = new OF_BillingReport2();
        obr.dat = Date.newInstance(1900,1,1);
        obr.dat1 = Date.newInstance(2100,1,1);
        obr.combotypeout='Cessazioni';
        obr.downloadasExcel();
        obr.getvlstWrapper();
        obr.getComboType();
        obr.displayMethod();
        obr.getLstwrapRecords();
        obr.setPagination();
        obr.first();
        obr.last();
        obr.previous();
        obr.next();
        
        
        
        OF_BillingReport2.wrapperReport wrap = new OF_BillingReport2.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
        //wrap.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
    
    }
    
     public static testMethod void OF_BillingReportMethod2(){
    
           Account acc = new account();
        acc.name = 'Billing Report';
        insert acc;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.OF_Comune__c ='Test';
        ord.OF_Comune__c = 'Test';
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'GPON Passiva';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        OF_BillingElement__c obe = new OF_BillingElement__c();
        obe.OF_CommercialElement__c = com.Id;
        obe.Name = 'Canone';
        //obe.OF_Servizio__c = ofs.Id;
        obe.OF_Attivo__c = true;
        obe.OF_DataFineValidita__c = system.today();
        obe.OF_DataInizioValidita__c = system.today();
        insert obe;
        
        Product2 prod = new Product2();
        prod.Name = 'Test'; 
        //prod.OF_Servizio__c = ofs.Id;
        prod.OF_BillingElement__c = obe.Id;
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = prod.Id;
        standardPrice.UnitPrice = 10000; 
        standardPrice.IsActive = true;
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2();
        customPB.Name='Custom Pricebook';
        customPB.isActive=true;
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry();
        customPrice.OF_Order__c = ord.Id;
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2018, 9, 15, 12, 30, 0);
        //customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);  
        customPrice.Pricebook2Id = customPB.Id;
        customPrice.Product2Id = prod.Id;
        customPrice.UnitPrice = 12000; 
        customPrice.IsActive = true;
        insert customPrice;
        
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);
        update customPrice;
     
        Catalogo_Billing__c cb = new Catalogo_Billing__c();
        cb.OF_Account__c = acc.Id;
        cb.Customer_Name__c = 'Test';
        cb.EOF_Comune__c ='Test';
        cb.EOF_Customer_ID__c = 'Test';  
        insert cb;  
        
        OF_BillingReport2 obr = new OF_BillingReport2();
        obr.dat = Date.newInstance(1900,1,1);
        obr.dat1 = Date.newInstance(2100,1,1);
        obr.combotypeout='CPE';
        obr.downloadasExcel();
        obr.getvlstWrapper();
        obr.getComboType();
        obr.displayMethod();
        obr.getLstwrapRecords();
        obr.setPagination();
        obr.first();
        obr.last();
        obr.previous();
        obr.next();
        //da togliere
        //Commented fake method as suggested by Pietro on 15012019
        // obr.codeCoverage();
        
        
        OF_BillingReport2.wrapperReport wrap = new OF_BillingReport2.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
        //wrap.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
     }
    
    public static testMethod void OF_BillingReportMethod3(){
    
        Account acc = new account();
        acc.name = 'Billing Report';
        insert acc;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.OF_Comune__c ='Test';
        ord.OF_Comune__c = 'Test';
        ord.EffectiveDate = system.today();
        ord.Status = 'Aperto';
        insert ord;
        
        OF_CatalogoCommerciale__c ofc = new OF_CatalogoCommerciale__c();
        ofc.OF_Attivo__c = true;
        ofc.OF_DataFineValidita__c = system.today();
        ofc.OF_DataInizioValidita__c = system.today();
        insert ofc;
        
        OF_Servizio__c ofs = new OF_Servizio__c();
        ofs.Name = 'Open Stream';
        ofs.OF_DataFineValidita__c = system.today();
        ofs.OF_DataInizioValidita__c = system.today();
        ofs.OF_CatalogoCommerciale__c = ofc.Id;
        insert ofs;
        
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Servizio__c = ofs .Id;
        com.OF_DataFineValidita__c = system.today();
        com.OF_DataInizioValidita__c = system.today();
        insert com;
        
        OF_BillingElement__c obe = new OF_BillingElement__c();
        obe.OF_CommercialElement__c = com.Id;
        obe.Name = 'Canone';
        //obe.OF_Servizio__c = ofs.Id;
        obe.OF_Attivo__c = true;
        obe.OF_DataFineValidita__c = system.today();
        obe.OF_DataInizioValidita__c = system.today();
        insert obe;
        
        Product2 prod = new Product2();
        prod.Name = 'Test'; 
        //prod.OF_Servizio__c = ofs.Id;
        prod.OF_BillingElement__c = obe.Id;
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = pricebookId;
        standardPrice.Product2Id = prod.Id;
        standardPrice.UnitPrice = 10000; 
        standardPrice.IsActive = true;
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2();
        customPB.Name='Custom Pricebook';
        customPB.isActive=true;
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry();
        customPrice.OF_Order__c = ord.Id;
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2018, 9, 15, 12, 30, 0);
        //customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);  
        customPrice.Pricebook2Id = customPB.Id;
        customPrice.Product2Id = prod.Id;
        customPrice.UnitPrice = 12000; 
        customPrice.IsActive = true;
        insert customPrice;
        
        customPrice.OF_DataAttivazione2__c = datetime.newInstance(2014, 9, 15, 13, 30, 0);
        update customPrice;
     
        Catalogo_Billing__c cb = new Catalogo_Billing__c();
        cb.OF_Account__c = acc.Id;
        cb.Customer_Name__c = 'Test';
        cb.EOF_Comune__c ='Test';
        cb.EOF_Customer_ID__c = 'Test';  
        insert cb;  
        
        OF_BillingReport2 obr = new OF_BillingReport2();
        obr.dat = Date.newInstance(1900,1,1);
        obr.dat1 = Date.newInstance(2100,1,1);
        obr.combotypeout='Attivazioni';
        obr.downloadasExcel();
        obr.getvlstWrapper();
        obr.getComboType();
        obr.displayMethod();
        obr.getLstwrapRecords();
        obr.setPagination();
        obr.first();
        obr.last();
        obr.previous();
        obr.next();
        //da togliere
        //Commented fake method as suggested by Pietro on 15012019
        // obr.codeCoverage();
        
        
        OF_BillingReport2.wrapperReport wrap = new OF_BillingReport2.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
        //wrap.wrapperReport(cb,ord,customPrice,'Test','Test','Test','Test');
    
    }
    
  
 }