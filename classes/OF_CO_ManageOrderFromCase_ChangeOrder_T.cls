/*
@isTest
public class OF_CO_ManageOrderFromCase_ChangeOrder_T 
{

@testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
  
@isTest
     public static  void  Function1()
     { 
     
      Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
         Account acc=new Account();
         acc.Name='Account1';
         insert acc;
         
         contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';
        insert contra;
        
         
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
         
         
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.name = 'Open Stream';
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
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
        ser.OF_Contract__c = contra.Id;
        insert ser;
        
        OF_Listino__c lis = new OF_Listino__c();
        lis.Name = 'Test';
        lis.OF_Attivo__c = true;
        lis.OF_IDContract__c= contra.Id;
        lis.OF_DataFineValidita__c = System.today();
        lis.OF_DataInizioValidita__c = System.today();
        lis.RecordTypeId = RecordTypeIdlis;
        lis.OF_ServizioBillingElement__c =ser.Id;
        insert lis;
        
         Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        //Id pricebookId = Test.getStandardPricebookId();
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = prod.Id, UnitPrice = 10000, IsActive = true);
        //insert standardPrice;
        
         Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Test', isActive=true,OF_Listino__c = lis.Id
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
            OF_Asset__c = a.Id,OF_DataCessazione2__c = system.today()
            
        );
        insert pbe;
       
        case C1=new case();
        C1.OF_Response_Da_OLO__c='RDO1';
        C1.OF_Response_Da_OM__c='RDOM1';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.OF_SA_Profilo__c='OSP1';
        C1.EOF_Note__c='ENC1';
        C1.Status='Modificato KO'; 
        C1.AssetId=a.Id;
        c1.EOF_Codice_Errore__c='ERRORCo';  
        c1.EOF_Causale_Errore__c='ERRORSo';
        c1.EOF_Account_OLO__c=acc.id;
        c1.OF_Order__c=ord.id;
         
        insert C1;
        
        
        
        OF_ContrattoServizio__c conser = new OF_ContrattoServizio__c();
        conser.OF_Contract__c = contra.Id;
        conser.OF_Servizio__c = ser1.Id;
        insert conser;
         
          OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_CommercialElement__c = com.Id;
        insert istan;
        //OF_CommercialElementIstanziato__c CEI= new OF_CommercialElementIstanziato__c();
        //CEI.OF_Case__c=C1.ID;
         
       // OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(C1); 
         
        Test.startTest();
         
        OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(C1);
        OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderAsync(C1.Id);
        OF_CO_ManageOrderFromCase_ChangeOrder.codeCoverage();
        Test.stopTest(); 

     }
}
*/

//-----------------------x----------------------


@isTest
public class OF_CO_ManageOrderFromCase_ChangeOrder_T 
{

@testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
  
@isTest
     public static  void  Function1()
     { 
     
      Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
         Account acc=new Account();
         acc.Name='Account1';
         insert acc;
         
         contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';
        insert contra;
        
         
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
         
         
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.name = 'Open Stream';
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
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
        ser.OF_Contract__c = contra.Id;
        insert ser;
        
        OF_Listino__c lis = new OF_Listino__c();
        lis.Name = 'Test';
        lis.OF_Attivo__c = true;
        lis.OF_IDContract__c= contra.Id;
        lis.OF_DataFineValidita__c = System.today();
        lis.OF_DataInizioValidita__c = System.today();
        lis.RecordTypeId = RecordTypeIdlis;
        lis.OF_ServizioBillingElement__c =ser.Id;
        insert lis;
        
         Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        //Id pricebookId = Test.getStandardPricebookId();
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = prod.Id, UnitPrice = 10000, IsActive = true);
        //insert standardPrice;
        
         Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Test', isActive=true,OF_Listino__c = lis.Id
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
            OF_Asset__c = a.Id,OF_DataCessazione2__c = system.today()
            
        );
        insert pbe;
       
        case C1=new case();
        C1.OF_Response_Da_OLO__c='RDO1';
        C1.OF_Response_Da_OM__c='RDOM1';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.OF_SA_Profilo__c='OSP1';
        C1.EOF_Note__c='ENC1';
        C1.Status='Modificato KO'; 
        C1.AssetId=a.Id;
        c1.EOF_Codice_Errore__c='ERRORCo';  
        c1.EOF_Causale_Errore__c='ERRORSo';
        c1.EOF_Account_OLO__c=acc.id;
        c1.OF_Order__c=ord.id;
         
        insert C1;
        
        
        
        OF_ContrattoServizio__c conser = new OF_ContrattoServizio__c();
        conser.OF_Contract__c = contra.Id;
        conser.OF_Servizio__c = ser1.Id;
        insert conser;
         
          OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_CommercialElement__c = com.Id;
        insert istan;
        //OF_CommercialElementIstanziato__c CEI= new OF_CommercialElementIstanziato__c();
        //CEI.OF_Case__c=C1.ID;
         
       // OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(C1); 
         
        Test.startTest();
         
        OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(C1);
        OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderAsync(C1.Id);
        //Commented fake method as suggested by Pietro on 15012019 
        //OF_CO_ManageOrderFromCase_ChangeOrder.codeCoverage();
        OF_CO_ManageOrderFromCase_ChangeOrder.CreaOrdineInAsincrono((string)C1.id);
        Test.stopTest(); 

     }
    
    @isTest
     public static  void  Function2()
     { 
     
      Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
         Account acc=new Account();
         acc.Name='Account1';
         insert acc;
         
         contract contra = new contract();
        contra.AccountId = acc.Id;
        contra.OF_IdContratto__c = 'Test';
        contra.StartDate = System.today();
        contra.ContractTerm = 123;
        contra.Status = 'Attivo';
        insert contra;
        
         
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
         
         
        OF_CatalogoCommerciale__c cata = new OF_CatalogoCommerciale__c();
        cata.OF_Attivo__c = True;
        cata.OF_DataFineValidita__c = System.today();
        cata.OF_DataInizioValidita__c = system.today();
        insert cata;
        
        OF_Servizio__c ser1 = new OF_Servizio__c();
        ser1.OF_Attivo__c = True;
        ser1.name = 'Open Stream';
        ser1.OF_CatalogoCommerciale__c = cata.Id;
        ser1.OF_DataFineValidita__c = System.today();
        ser1.OF_DataInizioValidita__c = System.today();
        insert ser1 ;
        
        OF_CommercialElement__c com = new OF_CommercialElement__c();
        com.OF_Attivo__c = True;
        com.name = 'SERVIZIO OPEN STREAM BASE';
        com.OF_DataFineValidita__c = System.today();
        com.OF_DataInizioValidita__c = System.today();
        com.OF_Servizio__c = ser1.Id;
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
        ser.OF_Contract__c = contra.Id;
        insert ser;
        
        OF_Listino__c lis = new OF_Listino__c();
        lis.Name = 'Test';
        lis.OF_Attivo__c = true;
        lis.OF_IDContract__c= contra.Id;
        lis.OF_DataFineValidita__c = System.today();
        lis.OF_DataInizioValidita__c = System.today();
        lis.RecordTypeId = RecordTypeIdlis;
        lis.OF_ServizioBillingElement__c =ser.Id;
        insert lis;
        
         Product2 prod = new Product2(Name = 'Canone', Family = 'Hardware');
        insert prod;
        
        //Id pricebookId = Test.getStandardPricebookId();
        
        //PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = prod.Id, UnitPrice = 10000, IsActive = true);
        //insert standardPrice;
        
         Id pricebookId = Test.getStandardPricebookId();
    
        pricebook2 priceB = new Pricebook2(
          Name='Test', isActive=true,OF_Listino__c = lis.Id
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
            OF_Asset__c = a.Id,OF_DataCessazione2__c = system.today()
            
        );
        insert pbe;
       
        case C1=new case();
        C1.OF_Response_Da_OLO__c='RDO1';
        C1.OF_Response_Da_OM__c='RDOM1';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.OF_SA_Profilo__c='OSP1';
        C1.EOF_Note__c='ENC1';
        C1.Status='Inviato'; 
        C1.AssetId=a.Id;
        c1.EOF_Codice_Errore__c='ERRORCo';  
        c1.EOF_Causale_Errore__c='ERRORSo';
        c1.EOF_Account_OLO__c=acc.id;
        c1.OF_Order__c=ord.id;
         
        insert C1;
        
        
        
        OF_ContrattoServizio__c conser = new OF_ContrattoServizio__c();
        conser.OF_Contract__c = contra.Id;
        conser.OF_Servizio__c = ser1.Id;
        insert conser;
         
          OF_CommercialElementIstanziato__c istan = new OF_CommercialElementIstanziato__c();
        istan.OF_CEStandard__c =a.Id;
        istan.OF_CommercialElement__c = com.Id;
        insert istan;
        //OF_CommercialElementIstanziato__c CEI= new OF_CommercialElementIstanziato__c();
        //CEI.OF_Case__c=C1.ID;
         
       // OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(C1); 
         
        Test.startTest();
         
        OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(C1);
        OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderAsync(C1.Id);
        
        //Commented fake method as suggested by Pietro on 15012019 
        //OF_CO_ManageOrderFromCase_ChangeOrder.codeCoverage();
        OF_CO_ManageOrderFromCase_ChangeOrder.CreaOrdineInAsincrono((string)C1.id);
        Test.stopTest(); 

     }
}