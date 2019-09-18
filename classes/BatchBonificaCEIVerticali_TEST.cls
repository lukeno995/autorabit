@isTest
public class BatchBonificaCEIVerticali_TEST {
    

    public static OF_Asset_Verticale__c assetVerticaleCreation1()
    {
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Nazionale'; 
        va.Civico__c = '34';
        va.Comune__c = 'Milano';
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001'; 
        va.ID_GIS_Scala_Palazzina__c = 'AX001'; 
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        insert va;
        
        return va;
    }
    
    public static OF_Asset_Verticale__c assetVerticaleCreation2()
    {
        OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
        
        //va.stato__c = 'Attivo';
        va.Indirizzo__c = 'Nazionale'; 
        va.Civico__c = '34';
        va.Comune__c = 'Milano';
        va.ID_DB_Building__c = 'ID_DB_001';
        va.ID_DB_Scala_Palazzina__c = 'AX001'; 
        va.ID_GIS_Scala_Palazzina__c = 'AX001'; 
        va.Particella_Toponomastica__c = 'Via';
        va.Cardinalita_Scala__c = 1;
        va.Inviato_PostGreSQL__c = true;
        insert va;
        
        return va;
    }
    
    public static Account accountCreation()
    {
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        return acc;
    }
    
    public static Asset assetCreation(Account acc){

        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = '1234567890123456789';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        //asset_1.EOF_ID_Risorsa__c = 'xxxx';
        asset_1.OF_ID_Building__c = 'yyyyy';
		asset_1.OF_Particella_Toponomastica__c  ='VIA';
        asset_1.OF_Indirizzo__c = 'JJJJJ';  
        asset_1.OF_Civico__c ='9';  
        asset_1.OF_Comune__c ='Napoli';        
        insert asset_1;

        return asset_1;
    }
    
    public static OF_Billing_Element_Verticale__c billingElementVCreation(Asset asset_t, OF_Asset_Verticale__c va)
    {
        OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
        verticalBE.name = 'BEV-'+asset_t.EOF_ID_Risorsa__c;
        verticalBE.ID_Risorsa__c = asset_t.EOF_ID_Risorsa__c;
        verticalBE.Data_Attivazione__c = System.now();
         verticalBE.OF_Status__c = 'Attivo';
        //Relaziono il BE Verticale all'Asset Standard
        verticalBE.Asset__c = asset_t.id;
        //Relaziono il BE Verticale all'Asset Verticale
        verticalBE.Asset_Verticale__c = va.id;
        insert verticalBE;
        return verticalBE;
    }
    
      public static OF_Staging_PNI__c stagingCreation()
    {
        OF_Staging_PNI__c stg = new OF_Staging_PNI__c();
        stg.OF_Comune__c='Napoli';
        insert stg;
        
        return stg;
    }
    
    
     public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv)
    {
      OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
      Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
      ce.name = 'Servizio Verticale';
      ce.OF_Attivo__c = true;
      ce.OF_DataInizioValidita__c = inizio;
      ce.OF_DataFineValidita__c = fine;
      ce.OF_Servizio__c = serv.id;
      insert ce;
      return ce;
    }  
    
    public static OF_BillingElement__c createContributoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo Verticale';
        be.OF_CommercialElement__c = ce.id;
      Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
      be.OF_Attivo__c = true;
      be.OF_DataInizioValidita__c = inizio;
      be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }
    
    public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv)
    {
        OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
        conServ.OF_Contract__c = contr.Id;
        conServ.OF_Servizio__c = serv.id;
        
        insert conServ;      
        return conServ;
    }
    
    public static OF_BillingElement__c createContributoStornoVerticale(OF_CommercialElement__c ce)
    {
        OF_BillingElement__c be = new OF_BillingElement__c();
        be.name = 'Contributo di storno Verticale';
        be.OF_CommercialElement__c = ce.id;
      Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
      be.OF_Attivo__c = true;
      be.OF_DataInizioValidita__c = inizio;
      be.OF_DataFineValidita__c = fine;
        insert be;
        return be;
    }


   public static OF_CommercialElementIstanziato__c  CEI_Creation(Asset assetStd,OF_CommercialElement__c CE)
    {
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        //CEI.Name='Test';
        CEI.OF_Asset__c=assetStd.id;
        CEI.OF_Stato__c='Attivo';
        CEI.OF_CommercialElement__c=CE.id;
        CEI.OF_IDRisorsa__c = assetStd.EOF_ID_Risorsa__c;
        CEI.OF_DataAttivazione__c = System.now();
        insert CEI;
      return CEI;
        
    }
        public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat)
    {
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'VERTICALE';
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
      servizio.OF_DataInizioValidita__c = inizio;
      servizio.OF_DataFineValidita__c = fine;
      servizio.OF_CatalogoCommerciale__c = cat.id;
       
      insert servizio;
      return servizio;
    }
    
    
      public static OF_CatalogoCommerciale__c Catalogo_Creation()
    {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
      catalogo.OF_DataInizioValidita__c = inizio;
      catalogo.OF_DataFineValidita__c = fine;
      insert catalogo;
      return catalogo;
    }

    public static testMethod void test_batch() {
       
        Test.startTest();
        
        Account acc = accountCreation();
        Asset stdAsset = assetCreation(acc);

        OF_CatalogoCommerciale__c cat = Catalogo_Creation();
        OF_Servizio__c serv = Servizio_Creation(cat);
        OF_CommercialElement__c ce_test = CE_Creation(serv);
        OF_CommercialElementIstanziato__c CEI_Creation =  CEI_Creation(stdAsset,ce_test);

        OF_Asset_Verticale__c va2 = assetVerticaleCreation2();
        OF_Billing_Element_Verticale__c bev2 = billingElementVCreation(stdAsset, va2);
        
        BatchBonificaCEIVerticali batchSend2 = new BatchBonificaCEIVerticali();
        
        DataBase.executeBatch(batchSend2); 
        
        Test.stopTest();
    }
    
 
}