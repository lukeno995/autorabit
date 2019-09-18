@isTest
public class PO_FATT_WS_IN_Espletamento_Test{

    public static testmethod void EspletamentoMethod(){
    
     Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
        OF_CaseOrderStateModelCS__c setting = new OF_CaseOrderStateModelCS__c();
        setting.Name = 'Test Setting';
        setting.OF_EsitoOrder__c = 'OK';
        setting.OF_FaseDiCreazione__c= true;
        setting.OF_RecordTypeCaseAttivo__c= 'Whatever';
        setting.PO_RecordTypeCaseOrdineEventoTemporaneo__c= rtId3;
        setting.PO_RecordTypeCaseOrdineFiberLease__c= rtId3;
        setting.PO_RecordTypeCaseOrdineFiberLink__c= rtId3;
        setting.PO_RecordTypeCaseOrdineIRU__c= rtId3;
        setting.PO_RecordTypeCaseOrdineP2P__c= rtId3;
        setting.OF_RecordTypeCasePassivo__c= 'Whatever';
        setting.OF_RecordTypeOrder__c= 'Whatever';
        setting.OF_StatoCase__c= 'Espletato';
        setting.OF_StatoOrder__c= 'Aperto';
        setting.OF_TipologiaFlusso__c= 'Whatever';
        insert setting;
        
        
        OF_CodificaProfiloListini__c profilo = new OF_CodificaProfiloListini__c();
        profilo.name = 'Testing';
        profilo.IsPortalValid__c = true;
        profilo.OF_ListinoCanoneName__c = 'Testing';
        profilo.OF_ProfiloCommerciale__c ='Testing';
        profilo.OF_Profilolistino__c = 'Testing';
        insert profilo; 
        
        
        Product2 p = new product2(name='x');
        insert p;
        //Pricebook2 standard = [Select Id, Name, IsActive From Pricebook2 where IsStandard = true LIMIT 1];
        
       // Pricebook2 stdPb = [select Id from Pricebook2 limit 1];
        Pricebook2 stdPb = new Pricebook2();
           // stdPb.OF_Listino__c=l.Id;
            stdPb.name='test';
            stdPb.isActive=true;
            insert stdPb;
           // Id pricebookId = Test.getStandardPricebookId();

       // insert new PricebookEntry(pricebook2id = Test.getStandardPricebookId(), product2id = p.id,unitprice=1.0, isActive=true);
        
       // Pricebook2 pb = new pricebook2(name='test');
       // insert pb;

        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;

        Account acc = new Account();
        acc.name  = 'Test';
        insert acc;
        
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
insert OppRecA;

OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3);
insert OppLI_Rec;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.EffectiveDate = system.today();
        ord.PO_Opportunity__c=OppRecA.Id;
        insert ord ;
        
        Case cs = new Case();
        cs.Status = 'Espletato';
        cs.EOF_Fase__c = 'Espletato';
        cs.OF_AggiornoOrdine__c = False;
        cs.OF_Order__c = ord.Id;
        cs.RecordTypeId = rtId3;
        insert cs;
        
        OF_Tibco_userID__c tibco =new OF_Tibco_userID__c();         
        tibco.OF_Tibco_ID__c ='test';
        tibco.Name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig=New OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=false;
        insert abilitaTrig;
        
         Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'test', Email='Test@testorg478.com', 
            EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p1.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='test@test478.com');
          insert u;
        
        PO_FATT_WS_IN_Espletamento  esmento = new PO_FATT_WS_IN_Espletamento(cs);
        esmento.espletamento_OK();
        
        Map<string,OF_CodificaProfiloListini__c> mapCodifica = new  Map<string, OF_CodificaProfiloListini__c>();
        //mapCodifica = OF_CodificaProfiloListini__c.getall();
        mapCodifica.put('Test',profilo);
        PO_FATT_WS_IN_Espletamento.AggiornoOrdine(cs,ord,setting,mapCodifica);
        
        //esmento.espletamento_KO();
    
    }
    
    public static testmethod void EspletamentoMethod1(){
    
     Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PO Collegamento P2P').getRecordTypeId();
        Id rtId1 = CaseRecordTypeInfo.get('PO Collegamento Fiber link').getRecordTypeId();
        Id rtId2 = CaseRecordTypeInfo.get('PO Collegamento Fiber Lease').getRecordTypeId();
        Id rtId3 = CaseRecordTypeInfo.get('PO Collegamento IRU').getRecordTypeId();
        Id rtId4 = CaseRecordTypeInfo.get('PO Collegamento Evento Temporaneo').getRecordTypeId();
        
        OF_CaseOrderStateModelCS__c setting = new OF_CaseOrderStateModelCS__c();
        setting.Name = 'Test Setting';
        setting.OF_EsitoOrder__c = 'OK';
        setting.OF_FaseDiCreazione__c= true;
        setting.OF_RecordTypeCaseAttivo__c= 'Whatever';
        setting.PO_RecordTypeCaseOrdineEventoTemporaneo__c= rtId3;
        setting.PO_RecordTypeCaseOrdineFiberLease__c= rtId3;
        setting.PO_RecordTypeCaseOrdineFiberLink__c= rtId3;
        setting.PO_RecordTypeCaseOrdineIRU__c= rtId3;
        setting.PO_RecordTypeCaseOrdineP2P__c= rtId3;
        setting.OF_RecordTypeCasePassivo__c= 'Whatever';
        setting.OF_RecordTypeOrder__c= 'Whatever';
        setting.OF_StatoCase__c= 'Espletato KO';
        setting.OF_StatoOrder__c= 'Aperto';
        setting.OF_TipologiaFlusso__c= 'Whatever';
        insert setting;
        
        
        OF_CodificaProfiloListini__c profilo = new OF_CodificaProfiloListini__c();
        profilo.name = 'Testing';
        profilo.IsPortalValid__c = true;
        profilo.OF_ListinoCanoneName__c = 'Testing';
        profilo.OF_ProfiloCommerciale__c ='Testing';
        profilo.OF_Profilolistino__c = 'Testing';
        insert profilo; 
        
        
        Product2 p = new product2(name='x');
        insert p;
        //Pricebook2 standard = [Select Id, Name, IsActive From Pricebook2 where IsStandard = true LIMIT 1];
        
       // Pricebook2 stdPb = [select Id from Pricebook2 limit 1];
        Pricebook2 stdPb = new Pricebook2();
           // stdPb.OF_Listino__c=l.Id;
            stdPb.name='test';
            stdPb.isActive=true;
            insert stdPb;
           // Id pricebookId = Test.getStandardPricebookId();

       // insert new PricebookEntry(pricebook2id = Test.getStandardPricebookId(), product2id = p.id,unitprice=1.0, isActive=true);
        
       // Pricebook2 pb = new pricebook2(name='test');
       // insert pb;

        PricebookEntry pbe = new PricebookEntry( Pricebook2Id = Test.getStandardPricebookId(), product2id=p.id,unitprice=1.0, isActive=true);
        insert pbe;

        Account acc = new Account();
        acc.name  = 'Test';
        insert acc;
        
        
        Opportunity OppRecA = new Opportunity(AccountId = Acc.Id, name='Opp', stageName='Open', closeDate=Date.newInstance(2008,10,10));
insert OppRecA;

OpportunityLineItem OppLI_Rec = new OpportunityLineItem(OpportunityId = OppRecA.Id, pricebookentryid=pbe.id, UnitPrice = 100, Quantity = 3);
insert OppLI_Rec;
        
        order ord = new order();
        ord.AccountId = acc.Id;
        ord.Status = 'Aperto';
        ord.EffectiveDate = system.today();
        ord.PO_Opportunity__c=OppRecA.Id;
        insert ord ;
        
        Case cs = new Case();
        cs.Status = 'Espletato KO';
        cs.EOF_Fase__c = 'Espletato KO';
        cs.OF_AggiornoOrdine__c = true;
        cs.OF_Order__c = ord.Id;
        cs.RecordTypeId = rtId3;
        insert cs;
        
        OF_Tibco_userID__c tibco =new OF_Tibco_userID__c();         
        tibco.OF_Tibco_ID__c ='test';
        tibco.Name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig=New OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=false;
        insert abilitaTrig;
        
         Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'test', Email='Test@testorg478.com', 
            EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p1.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='test@test478.com');
          insert u;
        
        PO_FATT_WS_IN_Espletamento  esmento = new PO_FATT_WS_IN_Espletamento(cs);
       // esmento.espletamento_OK();
        
        Map<string,OF_CodificaProfiloListini__c> mapCodifica = new  Map<string, OF_CodificaProfiloListini__c>();
        //mapCodifica = OF_CodificaProfiloListini__c.getall();
        mapCodifica.put('Test',profilo);
        PO_FATT_WS_IN_Espletamento.AggiornoOrdine(cs,ord,setting,mapCodifica);
        
        esmento.espletamento_KO();
    
    }
}