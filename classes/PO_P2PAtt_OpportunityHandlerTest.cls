@isTest(SeeAllData=true) 
public class PO_P2PAtt_OpportunityHandlerTest {
     @isTest
     static  void testMethod1(){
       
         PO_P2PAtt_OpportunityHandler PO=new PO_P2PAtt_OpportunityHandler();
     }  
        
    //     /*OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
    //     tibco.Name = 'Tibco UserID';
    //     tibco.OF_Tibco_ID__c = '00558000001f743AAA';
    //     insert tibco;
        
    //     OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
    //     IpCustom.Name = 'Status';
    //     IpCustom.OF_Enable_Trigger__c = true;
    //     insert IpCustom; */
    
    //      String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    //     Account acc = new Account();
    //     acc.Lastname = 'TestAccount';
    //     acc.Phone = '0000';
    //     acc.EOF_Phone_2__c = '0000';
    //     acc.EOF_Provincia__c = 'Milano';
    //     acc.EOF_Comune__c = 'Milano';
    //     acc.EOF_Indirizzo__c = 'Piazzale Gorini';
    //     acc.RecordTYpeId = AccountRecordTypeId ;
    //     acc.EOF_Particella_Toponomastica__c = '123';
    //     acc.EOF_Numero_Civico__c = '7';
    //     insert acc;
        
    //     Contract contratto = new Contract();
    //     contratto.OF_IdContratto__c = 'TEST_TIS_001';
    //     contratto.AccountId = acc.id;
    //     insert contratto;
        
    //     Asset asset_1 = new Asset();
    //     asset_1.Name = 'IDR1234';
    //     asset_1.Status = 'Attivo';
    //     asset_1.EOF_ID_Risorsa__c = 'IDR1234';
    //     //asset_1.recordTypeId = assetRecordTypeId;
    //     asset_1.accountId = acc.id;
    //   //  asset_1.OF_Contract__c = contratto.Id;
    //     insert asset_1;
        
    //     Case c = new Case();
    //     String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c.AccountId = acc.id;
    //     c.EOF_Codice_Ordine_OLO__c = 'Test222222222';
    //     c.EOF_Contact__c = null;
    //     c.EOF_Id_Risorsa__c='test';
    //     c.status = 'Accettato';
    //     c.EOF_FASE__C = 'NA';
    //     c.OF_SA_Profilo__c='new';
    //     c.RecordTypeId=CaseRecordTypeId;
    //     c.AssetId=asset_1.id;
    //     c.EOF_Identificativo_del_POP__c='test';
    //     c.OF_Esito_Consegna_Apparato__c='2';    
        
    //     insert c;
         
        
    //     case c1=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__c,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test222222222' limit 1];
        
    //     system.debug('casec1'+c1);
    //     Case c2 = new Case();
    //     String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c2.AccountId = acc.id;
    //     c2.EOF_Codice_Ordine_OLO__c = 'Test12222222222';
    //     c2.EOF_Contact__c = null;
    //     c2.EOF_Id_Risorsa__c='test1';
    //     c2.status = 'Accettato';
    //     c2.EOF_FASE__C = 'NA';
    //     c2.OF_SA_Profilo__c='new';
    //     c2.RecordTypeId=CaseRecordTypeId1;
    //     c2.AssetId=asset_1.id;
    //     c2.EOF_Identificativo_del_POP__c='test11';
    //     c2.OF_Esito_Consegna_Apparato__c='2';
    //     c2.PO_Richiesta_a_fattibilit__c=c1.ID;
    //     c2.PO_Tipo_percorso__c='Singola Via';
    //     c2.PO_Numero_fibre_richieste__c='1';
        
    //     insert c2;
    //     system.debug('casec2vvvvvv:'+c2.PO_Richiesta_a_fattibilit__c);
    //     system.debug('casec2'+c2.PO_Richiesta_a_fattibilit__r.caseNumber);
        
    //     case c3=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__r.caseNumber,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test12222222222' limit 1];
        
    //      system.debug('casec3:'+c3.PO_Richiesta_a_fattibilit__r.caseNumber);
    //     OF_CodificaProfiloListini__c CPC1=new OF_CodificaProfiloListini__c();
    //     CPC1.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC1.Name='new';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC1;
        
    //     OF_CodificaProfiloListini__c CPC2=new OF_CodificaProfiloListini__c();
    //     CPC2.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC2.Name='new2';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC2;
            
    //     Order ordine = new Order();
    //     ordine.OF_CaseID__c = c3.id;
    //     //ordine.OF_Asset_Verticale__c = va.id;
    //     //ordine.OF_Asset__c = asset_t.id;
    //     ordine.AccountId = acc.id;
    //     ordine.EffectiveDate = date.today();
    //     ordine.status = 'Aperto';
    //     //ordine.OF_Contratto__c=contratto.id;
    //     insert ordine;
     
    //     OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
    //     Date inizio = Date.newInstance(2016,1,1);
    //     Date fine = Date.newInstance(2099,12,31);
    //     catalogo.name = 'Catalogo_Test';
    //     catalogo.OF_Attivo__c = true;
    //     catalogo.OF_DataInizioValidita__c = inizio;
    //     catalogo.OF_DataFineValidita__c = fine;
    //     insert catalogo;
      
        
    //     OF_Servizio__c servizio = new OF_Servizio__c();
    //     servizio.name = 'P2P Attiva';
    //     Date inizio2 = Date.newInstance(2016,1,1);
    //     Date fine2 = Date.newInstance(2099,12,31);
    //     servizio.OF_Attivo__c = true;
    //     servizio.OF_DataInizioValidita__c = inizio2;
    //     servizio.OF_DataFineValidita__c = fine2;
    //     servizio.OF_CatalogoCommerciale__c = catalogo.id;
    //     insert servizio;
        
    //      OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
    //     Date inizio1 = Date.newInstance(2016,1,1);
    //     Date fine1 = Date.newInstance(2099,12,31);
    //     ce.name ='SINGOLA VIA MONOFIBRA';
    //     ce.OF_Attivo__c = true;
    //     ce.OF_DataInizioValidita__c = inizio1;
    //     ce.OF_DataFineValidita__c = fine1;
    //     ce.OF_Servizio__c = servizio.id;
        
    //     insert ce;
        
    //      OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
       
    //     Date ini = Date.newInstance(2016,1,1);
    //     Date fin= Date.newInstance(2099,12,31);
    //     ce1.name = 'RIBALTAMENTO IMPIANTO';
    //     ce1.OF_Attivo__c = true;
    //     ce1.OF_DataInizioValidita__c = ini;
    //     ce1.OF_DataFineValidita__c = fin;
    //     ce1.OF_Servizio__c = servizio.id;
    //     insert ce1;
        
        
    //     OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI.OF_Asset__c=asset_1.id;
    //     CEI.OF_Stato__c='Attivo';
    //     CEI.RecordTypeId=ComRecordTypeId;
    //     CEI.OF_Case__c=c3.id;
    //     CEI.OF_EsitoConsegnaApparato__c='2';
    //     CEI.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI;
        
        
    //     OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI1.OF_Asset__c=asset_1.id;
    //     CEI1.OF_Stato__c='Attivo';
    //     CEI1.RecordTypeId=ComRecordTypeId1;
    //     CEI1.OF_Case__c=c3.id;
    //     CEI1.OF_EsitoConsegnaApparato__c='1';
    //      CEI1.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI1;
        
        
    //      OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
    //     //CEI.Name='SINGOLA VIA MONOFIBRA';
    //     CEI2.OF_Asset__c=asset_1.id;
    //     CEI2.OF_Stato__c='Attivo';
    //     CEI2.RecordTypeId=ComRecordTypeId1;
    //     CEI2.OF_Case__c=c3.id;
    //     CEI2.OF_EsitoConsegnaApparato__c='0';
    //     CEI2.OF_CommercialElement__c=CE.id;
    //      //CEI2.OF_CommercialElement__c='SINGOLA VIA MONOFIBRA';
    //     // CEI2.OF_CommercialElementName__c = 'SINGOLA VIA MONOFIBRA';
    //     insert CEI2;
        
    //     OF_BillingElement__c be = new OF_BillingElement__c();
    //     be.OF_CommercialElement__c = ce.id;
    //     Date ini113 = Date.newInstance(2099,1,31);
    //     Date fin113= Date.newInstance(2099,1,3);
    //     be.OF_DataFineValidita__c=ini113;
    //     be.OF_DataInizioValidita__c=fin113;
    //     insert be;
        
    //     OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
    //     sb1.OF_Servizio__c=servizio.id;
    //     sb1.OF_BillingElement__c = be.id;
    //     insert sb1;
        
    //     OF_Listino__c lr1=new OF_Listino__c();
    //     String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
    //     Date ini11 = Date.newInstance(2099,1,31);
    //     Date fin11= Date.newInstance(2099,1,3);
    //     lr1.OF_DataFineValidita__c=ini11;
    //     lr1.OF_DataInizioValidita__c=fin11;
    //     lr1.OF_ServizioBillingElement__c=sb1.Id;
    //     lr1.OF_Attivo__c = true;
    //     lr1.RecordTypeId = ComRecordTypeId3;
    //     lr1.OF_ListinoDefault__c = true;
    //     insert lr1;
        
    //       // Instantiate the Pricebook2 record first, setting the Id
    //     Pricebook2 standardPricebook = new Pricebook2(
    //         Id = Test.getStandardPricebookId(),
    //         IsActive = true,
    //         PO_Commercial_element__c=ce.Id,
    //         OF_Listino__c=lr1.Id,
    //         Name='P2PATT_001_CAN_SINGMONO_sttesttest123456'
            
    //     );        
    //     //update standardPricebook;
        
    //     // Re-Query for the Pricebook2 record, for debugging
    //     standardPricebook = [SELECT IsStandard,IsActive,PO_Commercial_element__c,OF_Listino__c
    //                         FROM Pricebook2 
    //                         WHERE Id = :standardPricebook.Id];
        
    //     // Create the Product
    //     Product2 testProduct = new Product2(
    //         Name = 'Contributo Verticale',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct;
        
    //     // Create the PricebookEntry
    //   /*  PricebookEntry testPbe = new PricebookEntry(
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true
    //     );
    //     insert testPbe;*/
        
    //     Product2 testProduct1 = new Product2(
    //         Name = 'Contributo Consegna e Istallazione',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct1;
        
    //     Pricebook2 customPB = new Pricebook2(Name='P2PATT_001_CAN_SINGMONO_sttesttest123456', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
    //     insert customPB;
        
    //     // Create the PricebookEntry
    //     PricebookEntry testPbe1 = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =false
    //     );
    //     insert testPbe1;   
        
    //      PricebookEntry testPbecus = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = customPB.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =true
    //     );
        
      
        
    //     insert testPbecus; 
        
    //     PO_P2PAtt_OpportunityHandler.createOppChild(c3);
         
    // }
    
    // static testMethod void testMethod2(){
       
    //     PO_P2PAtt_OpportunityHandler PO=new PO_P2PAtt_OpportunityHandler();
        
    //     /*OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
    //     tibco.Name = 'Tibco UserID';
    //     tibco.OF_Tibco_ID__c = '00558000001f743AAA';
    //     insert tibco;
        
    //     OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
    //     IpCustom.Name = 'Status';
    //     IpCustom.OF_Enable_Trigger__c = true;
    //     insert IpCustom; */
    
    //      String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    //     Account acc = new Account();
    //     acc.Lastname = 'TestAccount';
    //     acc.Phone = '0000';
    //     acc.EOF_Phone_2__c = '0000';
    //     acc.EOF_Provincia__c = 'Milano';
    //     acc.EOF_Comune__c = 'Milano';
    //     acc.EOF_Indirizzo__c = 'Piazzale Gorini';
    //     acc.RecordTYpeId = AccountRecordTypeId ;
    //     acc.EOF_Particella_Toponomastica__c = '123';
    //     acc.EOF_Numero_Civico__c = '7';
    //     insert acc;
        
    //     Contract contratto = new Contract();
    //     contratto.OF_IdContratto__c = 'TEST_TIS_001';
    //     contratto.AccountId = acc.id;
    //     insert contratto;
        
    //     Asset asset_1 = new Asset();
    //     asset_1.Name = 'IDR1234';
    //     asset_1.Status = 'Attivo';
    //     asset_1.EOF_ID_Risorsa__c = 'IDR1234';
    //     //asset_1.recordTypeId = assetRecordTypeId;
    //     asset_1.accountId = acc.id;
    //   //  asset_1.OF_Contract__c = contratto.Id;
    //     insert asset_1;
        
    //     Case c = new Case();
    //     String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c.AccountId = acc.id;
    //     c.EOF_Codice_Ordine_OLO__c = 'Test222222222';
    //     c.EOF_Contact__c = null;
    //     c.EOF_Id_Risorsa__c='test';
    //     c.status = 'Accettato';
    //     c.EOF_FASE__C = 'NA';
    //     c.OF_SA_Profilo__c='new';
    //     c.RecordTypeId=CaseRecordTypeId;
    //     c.AssetId=asset_1.id;
    //     c.EOF_Identificativo_del_POP__c='test';
    //     c.OF_Esito_Consegna_Apparato__c='2';    
        
    //     insert c;
         
        
    //     case c1=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__c,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test222222222' limit 1];
        
    //     system.debug('casec1'+c1);
    //     Case c2 = new Case();
    //     String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c2.AccountId = acc.id;
    //     c2.EOF_Codice_Ordine_OLO__c = 'Test12222222222';
    //     c2.EOF_Contact__c = null;
    //     c2.EOF_Id_Risorsa__c='test1';
    //     c2.status = 'Accettato';
    //     c2.EOF_FASE__C = 'NA';
    //     c2.OF_SA_Profilo__c='new';
    //     c2.RecordTypeId=CaseRecordTypeId1;
    //     c2.AssetId=asset_1.id;
    //     c2.EOF_Identificativo_del_POP__c='test11';
    //     c2.OF_Esito_Consegna_Apparato__c='2';
    //     c2.PO_Richiesta_a_fattibilit__c=c1.ID;
    //     c2.PO_Tipo_percorso__c='Singola Via';
    //     c2.PO_Numero_fibre_richieste__c='2';
        
    //     insert c2;
    //     system.debug('casec2vvvvvv:'+c2.PO_Richiesta_a_fattibilit__c);
    //     system.debug('casec2'+c2.PO_Richiesta_a_fattibilit__r.caseNumber);
        
    //     case c3=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__r.caseNumber,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test12222222222' limit 1];
        
    //      system.debug('casec3:'+c3.PO_Richiesta_a_fattibilit__r.caseNumber);
    //     OF_CodificaProfiloListini__c CPC1=new OF_CodificaProfiloListini__c();
    //     CPC1.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC1.Name='new';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC1;
        
    //     OF_CodificaProfiloListini__c CPC2=new OF_CodificaProfiloListini__c();
    //     CPC2.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC2.Name='new2';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC2;
            
    //     Order ordine = new Order();
    //     ordine.OF_CaseID__c = c3.id;
    //     //ordine.OF_Asset_Verticale__c = va.id;
    //     //ordine.OF_Asset__c = asset_t.id;
    //     ordine.AccountId = acc.id;
    //     ordine.EffectiveDate = date.today();
    //     ordine.status = 'Aperto';
    //     //ordine.OF_Contratto__c=contratto.id;
    //     insert ordine;
     
    //     OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
    //     Date inizio = Date.newInstance(2016,1,1);
    //     Date fine = Date.newInstance(2099,12,31);
    //     catalogo.name = 'Catalogo_Test';
    //     catalogo.OF_Attivo__c = true;
    //     catalogo.OF_DataInizioValidita__c = inizio;
    //     catalogo.OF_DataFineValidita__c = fine;
    //     insert catalogo;
      
        
    //     OF_Servizio__c servizio = new OF_Servizio__c();
    //     servizio.name = 'P2P Attiva';
    //     Date inizio2 = Date.newInstance(2016,1,1);
    //     Date fine2 = Date.newInstance(2099,12,31);
    //     servizio.OF_Attivo__c = true;
    //     servizio.OF_DataInizioValidita__c = inizio2;
    //     servizio.OF_DataFineValidita__c = fine2;
    //     servizio.OF_CatalogoCommerciale__c = catalogo.id;
    //     insert servizio;
        
    //      OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
    //     Date inizio1 = Date.newInstance(2016,1,1);
    //     Date fine1 = Date.newInstance(2099,12,31);
    //     ce.name ='SINGOLA VIA MONOFIBRA';
    //     ce.OF_Attivo__c = true;
    //     ce.OF_DataInizioValidita__c = inizio1;
    //     ce.OF_DataFineValidita__c = fine1;
    //     ce.OF_Servizio__c = servizio.id;
        
    //     insert ce;
        
    //      OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
       
    //     Date ini = Date.newInstance(2016,1,1);
    //     Date fin= Date.newInstance(2099,12,31);
    //     ce1.name = 'RIBALTAMENTO IMPIANTO';
    //     ce1.OF_Attivo__c = true;
    //     ce1.OF_DataInizioValidita__c = ini;
    //     ce1.OF_DataFineValidita__c = fin;
    //     ce1.OF_Servizio__c = servizio.id;
    //     insert ce1;
        
        
    //     OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI.OF_Asset__c=asset_1.id;
    //     CEI.OF_Stato__c='Attivo';
    //     CEI.RecordTypeId=ComRecordTypeId;
    //     CEI.OF_Case__c=c3.id;
    //     CEI.OF_EsitoConsegnaApparato__c='2';
    //     CEI.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI;
        
        
    //     OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI1.OF_Asset__c=asset_1.id;
    //     CEI1.OF_Stato__c='Attivo';
    //     CEI1.RecordTypeId=ComRecordTypeId1;
    //     CEI1.OF_Case__c=c3.id;
    //     CEI1.OF_EsitoConsegnaApparato__c='1';
    //      CEI1.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI1;
        
        
    //      OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
    //     //CEI.Name='SINGOLA VIA MONOFIBRA';
    //     CEI2.OF_Asset__c=asset_1.id;
    //     CEI2.OF_Stato__c='Attivo';
    //     CEI2.RecordTypeId=ComRecordTypeId1;
    //     CEI2.OF_Case__c=c3.id;
    //     CEI2.OF_EsitoConsegnaApparato__c='0';
    //     CEI2.OF_CommercialElement__c=CE.id;
    //      //CEI2.OF_CommercialElement__c='SINGOLA VIA MONOFIBRA';
    //     // CEI2.OF_CommercialElementName__c = 'SINGOLA VIA MONOFIBRA';
    //     insert CEI2;
        
    //     OF_BillingElement__c be = new OF_BillingElement__c();
    //     be.OF_CommercialElement__c = ce.id;
    //     Date ini113 = Date.newInstance(2099,1,31);
    //     Date fin113= Date.newInstance(2099,1,3);
    //     be.OF_DataFineValidita__c=ini113;
    //     be.OF_DataInizioValidita__c=fin113;
    //     insert be;
        
    //     OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
    //     sb1.OF_Servizio__c=servizio.id;
    //     sb1.OF_BillingElement__c = be.id;
    //     insert sb1;
        
    //     OF_Listino__c lr1=new OF_Listino__c();
    //     String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
    //     Date ini11 = Date.newInstance(2099,1,31);
    //     Date fin11= Date.newInstance(2099,1,3);
    //     lr1.OF_DataFineValidita__c=ini11;
    //     lr1.OF_DataInizioValidita__c=fin11;
    //     lr1.OF_ServizioBillingElement__c=sb1.Id;
    //     lr1.OF_Attivo__c = true;
    //     lr1.RecordTypeId = ComRecordTypeId3;
    //     lr1.OF_ListinoDefault__c = true;
    //     insert lr1;
        
    //       // Instantiate the Pricebook2 record first, setting the Id
    //     Pricebook2 standardPricebook = new Pricebook2(
    //         Id = Test.getStandardPricebookId(),
    //         IsActive = true,
    //         PO_Commercial_element__c=ce.Id,
    //         OF_Listino__c=lr1.Id,
    //         Name='P2PATT_001_CAN_SINGBI_sttesttest123456'
            
    //     );        
    //     //update standardPricebook;
        
    //     // Re-Query for the Pricebook2 record, for debugging
    //     standardPricebook = [SELECT IsStandard,IsActive,PO_Commercial_element__c,OF_Listino__c
    //                         FROM Pricebook2 
    //                         WHERE Id = :standardPricebook.Id];
        
    //     // Create the Product
    //     Product2 testProduct = new Product2(
    //         Name = 'Contributo Verticale',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct;
        
    //     // Create the PricebookEntry
    //   /*  PricebookEntry testPbe = new PricebookEntry(
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true
    //     );
    //     insert testPbe;*/
        
    //     Product2 testProduct1 = new Product2(
    //         Name = 'Contributo Consegna e Istallazione',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct1;
        
    //     Pricebook2 customPB = new Pricebook2(Name='P2PATT_001_CAN_SINGBI_sttesttest123456', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
    //     insert customPB;
        
    //     // Create the PricebookEntry
    //     PricebookEntry testPbe1 = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =false
    //     );
    //     insert testPbe1;   
        
    //      PricebookEntry testPbecus = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = customPB.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =true
    //     );
        
      
        
    //     insert testPbecus; 
        
    //     PO_P2PAtt_OpportunityHandler.createOppChild(c3);
         
    // }
    
    // static testMethod void testMethod3(){
       
    //     PO_P2PAtt_OpportunityHandler PO=new PO_P2PAtt_OpportunityHandler();
        
    //     /*OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
    //     tibco.Name = 'Tibco UserID';
    //     tibco.OF_Tibco_ID__c = '00558000001f743AAA';
    //     insert tibco;
        
    //     OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
    //     IpCustom.Name = 'Status';
    //     IpCustom.OF_Enable_Trigger__c = true;
    //     insert IpCustom; */
    
    //      String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    //     Account acc = new Account();
    //     acc.Lastname = 'TestAccount';
    //     acc.Phone = '0000';
    //     acc.EOF_Phone_2__c = '0000';
    //     acc.EOF_Provincia__c = 'Milano';
    //     acc.EOF_Comune__c = 'Milano';
    //     acc.EOF_Indirizzo__c = 'Piazzale Gorini';
    //     acc.RecordTYpeId = AccountRecordTypeId ;
    //     acc.EOF_Particella_Toponomastica__c = '123';
    //     acc.EOF_Numero_Civico__c = '7';
    //     insert acc;
        
    //     Contract contratto = new Contract();
    //     contratto.OF_IdContratto__c = 'TEST_TIS_001';
    //     contratto.AccountId = acc.id;
    //     insert contratto;
        
    //     Asset asset_1 = new Asset();
    //     asset_1.Name = 'IDR1234';
    //     asset_1.Status = 'Attivo';
    //     asset_1.EOF_ID_Risorsa__c = 'IDR1234';
    //     //asset_1.recordTypeId = assetRecordTypeId;
    //     asset_1.accountId = acc.id;
    //   //  asset_1.OF_Contract__c = contratto.Id;
    //     insert asset_1;
        
    //     Case c = new Case();
    //     String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c.AccountId = acc.id;
    //     c.EOF_Codice_Ordine_OLO__c = 'Test222222222';
    //     c.EOF_Contact__c = null;
    //     c.EOF_Id_Risorsa__c='test';
    //     c.status = 'Accettato';
    //     c.EOF_FASE__C = 'NA';
    //     c.OF_SA_Profilo__c='new';
    //     c.RecordTypeId=CaseRecordTypeId;
    //     c.AssetId=asset_1.id;
    //     c.EOF_Identificativo_del_POP__c='test';
    //     c.OF_Esito_Consegna_Apparato__c='2';    
        
    //     insert c;
         
        
    //     case c1=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__c,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test222222222' limit 1];
        
    //     system.debug('casec1'+c1);
    //     Case c2 = new Case();
    //     String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c2.AccountId = acc.id;
    //     c2.EOF_Codice_Ordine_OLO__c = 'Test12222222222';
    //     c2.EOF_Contact__c = null;
    //     c2.EOF_Id_Risorsa__c='test1';
    //     c2.status = 'Accettato';
    //     c2.EOF_FASE__C = 'NA';
    //     c2.OF_SA_Profilo__c='new';
    //     c2.RecordTypeId=CaseRecordTypeId1;
    //     c2.AssetId=asset_1.id;
    //     c2.EOF_Identificativo_del_POP__c='test11';
    //     c2.OF_Esito_Consegna_Apparato__c='2';
    //     c2.PO_Richiesta_a_fattibilit__c=c1.ID;
    //     c2.PO_Tipo_percorso__c='Doppia Via';
    //     c2.PO_Numero_fibre_richieste__c='1';
        
    //     insert c2;
    //     system.debug('casec2vvvvvv:'+c2.PO_Richiesta_a_fattibilit__c);
    //     system.debug('casec2'+c2.PO_Richiesta_a_fattibilit__r.caseNumber);
        
    //     case c3=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__r.caseNumber,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test12222222222' limit 1];
        
    //      system.debug('casec3:'+c3.PO_Richiesta_a_fattibilit__r.caseNumber);
    //     OF_CodificaProfiloListini__c CPC1=new OF_CodificaProfiloListini__c();
    //     CPC1.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC1.Name='new';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC1;
        
    //     OF_CodificaProfiloListini__c CPC2=new OF_CodificaProfiloListini__c();
    //     CPC2.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC2.Name='new2';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC2;
            
    //     Order ordine = new Order();
    //     ordine.OF_CaseID__c = c3.id;
    //     //ordine.OF_Asset_Verticale__c = va.id;
    //     //ordine.OF_Asset__c = asset_t.id;
    //     ordine.AccountId = acc.id;
    //     ordine.EffectiveDate = date.today();
    //     ordine.status = 'Aperto';
    //     //ordine.OF_Contratto__c=contratto.id;
    //     insert ordine;
     
    //     OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
    //     Date inizio = Date.newInstance(2016,1,1);
    //     Date fine = Date.newInstance(2099,12,31);
    //     catalogo.name = 'Catalogo_Test';
    //     catalogo.OF_Attivo__c = true;
    //     catalogo.OF_DataInizioValidita__c = inizio;
    //     catalogo.OF_DataFineValidita__c = fine;
    //     insert catalogo;
      
        
    //     OF_Servizio__c servizio = new OF_Servizio__c();
    //     servizio.name = 'P2P Attiva';
    //     Date inizio2 = Date.newInstance(2016,1,1);
    //     Date fine2 = Date.newInstance(2099,12,31);
    //     servizio.OF_Attivo__c = true;
    //     servizio.OF_DataInizioValidita__c = inizio2;
    //     servizio.OF_DataFineValidita__c = fine2;
    //     servizio.OF_CatalogoCommerciale__c = catalogo.id;
    //     insert servizio;
        
    //      OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
    //     Date inizio1 = Date.newInstance(2016,1,1);
    //     Date fine1 = Date.newInstance(2099,12,31);
    //     ce.name ='SINGOLA VIA MONOFIBRA';
    //     ce.OF_Attivo__c = true;
    //     ce.OF_DataInizioValidita__c = inizio1;
    //     ce.OF_DataFineValidita__c = fine1;
    //     ce.OF_Servizio__c = servizio.id;
        
    //     insert ce;
        
    //      OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
       
    //     Date ini = Date.newInstance(2016,1,1);
    //     Date fin= Date.newInstance(2099,12,31);
    //     ce1.name = 'RIBALTAMENTO IMPIANTO';
    //     ce1.OF_Attivo__c = true;
    //     ce1.OF_DataInizioValidita__c = ini;
    //     ce1.OF_DataFineValidita__c = fin;
    //     ce1.OF_Servizio__c = servizio.id;
    //     insert ce1;
        
        
    //     OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI.OF_Asset__c=asset_1.id;
    //     CEI.OF_Stato__c='Attivo';
    //     CEI.RecordTypeId=ComRecordTypeId;
    //     CEI.OF_Case__c=c3.id;
    //     CEI.OF_EsitoConsegnaApparato__c='2';
    //     CEI.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI;
        
        
    //     OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI1.OF_Asset__c=asset_1.id;
    //     CEI1.OF_Stato__c='Attivo';
    //     CEI1.RecordTypeId=ComRecordTypeId1;
    //     CEI1.OF_Case__c=c3.id;
    //     CEI1.OF_EsitoConsegnaApparato__c='1';
    //      CEI1.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI1;
        
        
    //      OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
    //     //CEI.Name='SINGOLA VIA MONOFIBRA';
    //     CEI2.OF_Asset__c=asset_1.id;
    //     CEI2.OF_Stato__c='Attivo';
    //     CEI2.RecordTypeId=ComRecordTypeId1;
    //     CEI2.OF_Case__c=c3.id;
    //     CEI2.OF_EsitoConsegnaApparato__c='0';
    //     CEI2.OF_CommercialElement__c=CE.id;
    //      //CEI2.OF_CommercialElement__c='SINGOLA VIA MONOFIBRA';
    //     // CEI2.OF_CommercialElementName__c = 'SINGOLA VIA MONOFIBRA';
    //     insert CEI2;
        
    //     OF_BillingElement__c be = new OF_BillingElement__c();
    //     be.OF_CommercialElement__c = ce.id;
    //     Date ini113 = Date.newInstance(2099,1,31);
    //     Date fin113= Date.newInstance(2099,1,3);
    //     be.OF_DataFineValidita__c=ini113;
    //     be.OF_DataInizioValidita__c=fin113;
    //     insert be;
        
    //     OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
    //     sb1.OF_Servizio__c=servizio.id;
    //     sb1.OF_BillingElement__c = be.id;
    //     insert sb1;
        
    //     OF_Listino__c lr1=new OF_Listino__c();
    //     String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
    //     Date ini11 = Date.newInstance(2099,1,31);
    //     Date fin11= Date.newInstance(2099,1,3);
    //     lr1.OF_DataFineValidita__c=ini11;
    //     lr1.OF_DataInizioValidita__c=fin11;
    //     lr1.OF_ServizioBillingElement__c=sb1.Id;
    //     lr1.OF_Attivo__c = true;
    //     lr1.RecordTypeId = ComRecordTypeId3;
    //     lr1.OF_ListinoDefault__c = true;
    //     insert lr1;
        
    //       // Instantiate the Pricebook2 record first, setting the Id
    //     Pricebook2 standardPricebook = new Pricebook2(
    //         Id = Test.getStandardPricebookId(),
    //         IsActive = true,
    //         PO_Commercial_element__c=ce.Id,
    //         OF_Listino__c=lr1.Id,
    //         Name='P2PATT_001_CAN_DOPPMONO_sttesttest123456'
            
    //     );        
    //     //update standardPricebook;
        
    //     // Re-Query for the Pricebook2 record, for debugging
    //     standardPricebook = [SELECT IsStandard,IsActive,PO_Commercial_element__c,OF_Listino__c
    //                         FROM Pricebook2 
    //                         WHERE Id = :standardPricebook.Id];
        
    //     // Create the Product
    //     Product2 testProduct = new Product2(
    //         Name = 'Contributo Verticale',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct;
        
    //     // Create the PricebookEntry
    //   /*  PricebookEntry testPbe = new PricebookEntry(
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true
    //     );
    //     insert testPbe;*/
        
    //     Product2 testProduct1 = new Product2(
    //         Name = 'Contributo Consegna e Istallazione',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct1;
        
    //     Pricebook2 customPB = new Pricebook2(Name='P2PATT_001_CAN_DOPPMONO_sttesttest123456', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
    //     insert customPB;
        
    //     // Create the PricebookEntry
    //     PricebookEntry testPbe1 = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =false
    //     );
    //     insert testPbe1;   
        
    //      PricebookEntry testPbecus = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = customPB.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =true
    //     );
        
      
        
    //     insert testPbecus; 
        
    //     PO_P2PAtt_OpportunityHandler.createOppChild(c3);
         
    // }
    
    //  static testMethod void testMethod4(){
       
    //     PO_P2PAtt_OpportunityHandler PO=new PO_P2PAtt_OpportunityHandler();
        
    //     /*OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
    //     tibco.Name = 'Tibco UserID';
    //     tibco.OF_Tibco_ID__c = '00558000001f743AAA';
    //     insert tibco;
        
    //     OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
    //     IpCustom.Name = 'Status';
    //     IpCustom.OF_Enable_Trigger__c = true;
    //     insert IpCustom; */
    
    //      String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    //     Account acc = new Account();
    //     acc.Lastname = 'TestAccount';
    //     acc.Phone = '0000';
    //     acc.EOF_Phone_2__c = '0000';
    //     acc.EOF_Provincia__c = 'Milano';
    //     acc.EOF_Comune__c = 'Milano';
    //     acc.EOF_Indirizzo__c = 'Piazzale Gorini';
    //     acc.RecordTYpeId = AccountRecordTypeId ;
    //     acc.EOF_Particella_Toponomastica__c = '123';
    //     acc.EOF_Numero_Civico__c = '7';
    //     insert acc;
        
    //     Contract contratto = new Contract();
    //     contratto.OF_IdContratto__c = 'TEST_TIS_001';
    //     contratto.AccountId = acc.id;
    //     insert contratto;
        
    //     Asset asset_1 = new Asset();
    //     asset_1.Name = 'IDR1234';
    //     asset_1.Status = 'Attivo';
    //     asset_1.EOF_ID_Risorsa__c = 'IDR1234';
    //     //asset_1.recordTypeId = assetRecordTypeId;
    //     asset_1.accountId = acc.id;
    //   //  asset_1.OF_Contract__c = contratto.Id;
    //     insert asset_1;
        
    //     Case c = new Case();
    //     String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c.AccountId = acc.id;
    //     c.EOF_Codice_Ordine_OLO__c = 'Test222222222';
    //     c.EOF_Contact__c = null;
    //     c.EOF_Id_Risorsa__c='test';
    //     c.status = 'Accettato';
    //     c.EOF_FASE__C = 'NA';
    //     c.OF_SA_Profilo__c='new';
    //     c.RecordTypeId=CaseRecordTypeId;
    //     c.AssetId=asset_1.id;
    //     c.EOF_Identificativo_del_POP__c='test';
    //     c.OF_Esito_Consegna_Apparato__c='2';    
        
    //     insert c;
         
        
    //     case c1=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__c,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test222222222' limit 1];
        
    //     system.debug('casec1'+c1);
    //     Case c2 = new Case();
    //     String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c2.AccountId = acc.id;
    //     c2.EOF_Codice_Ordine_OLO__c = 'Test12222222222';
    //     c2.EOF_Contact__c = null;
    //     c2.EOF_Id_Risorsa__c='test1';
    //     c2.status = 'Accettato';
    //     c2.EOF_FASE__C = 'NA';
    //     c2.OF_SA_Profilo__c='new';
    //     c2.RecordTypeId=CaseRecordTypeId1;
    //     c2.AssetId=asset_1.id;
    //     c2.EOF_Identificativo_del_POP__c='test11';
    //     c2.OF_Esito_Consegna_Apparato__c='2';
    //     c2.PO_Richiesta_a_fattibilit__c=c1.ID;
    //     c2.PO_Tipo_percorso__c='Doppia Via';
    //     c2.PO_Numero_fibre_richieste__c='2+2';
        
    //     insert c2;
    //     system.debug('casec2vvvvvv:'+c2.PO_Richiesta_a_fattibilit__c);
    //     system.debug('casec2'+c2.PO_Richiesta_a_fattibilit__r.caseNumber);
        
    //     case c3=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__r.caseNumber,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test12222222222' limit 1];
        
    //      system.debug('casec3:'+c3.PO_Richiesta_a_fattibilit__r.caseNumber);
    //     OF_CodificaProfiloListini__c CPC1=new OF_CodificaProfiloListini__c();
    //     CPC1.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC1.Name='new';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC1;
        
    //     OF_CodificaProfiloListini__c CPC2=new OF_CodificaProfiloListini__c();
    //     CPC2.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC2.Name='new2';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC2;
            
    //     Order ordine = new Order();
    //     ordine.OF_CaseID__c = c3.id;
    //     //ordine.OF_Asset_Verticale__c = va.id;
    //     //ordine.OF_Asset__c = asset_t.id;
    //     ordine.AccountId = acc.id;
    //     ordine.EffectiveDate = date.today();
    //     ordine.status = 'Aperto';
    //     //ordine.OF_Contratto__c=contratto.id;
    //     insert ordine;
     
    //     OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
    //     Date inizio = Date.newInstance(2016,1,1);
    //     Date fine = Date.newInstance(2099,12,31);
    //     catalogo.name = 'Catalogo_Test';
    //     catalogo.OF_Attivo__c = true;
    //     catalogo.OF_DataInizioValidita__c = inizio;
    //     catalogo.OF_DataFineValidita__c = fine;
    //     insert catalogo;
      
        
    //     OF_Servizio__c servizio = new OF_Servizio__c();
    //     servizio.name = 'P2P Attiva';
    //     Date inizio2 = Date.newInstance(2016,1,1);
    //     Date fine2 = Date.newInstance(2099,12,31);
    //     servizio.OF_Attivo__c = true;
    //     servizio.OF_DataInizioValidita__c = inizio2;
    //     servizio.OF_DataFineValidita__c = fine2;
    //     servizio.OF_CatalogoCommerciale__c = catalogo.id;
    //     insert servizio;
        
    //      OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
    //     Date inizio1 = Date.newInstance(2016,1,1);
    //     Date fine1 = Date.newInstance(2099,12,31);
    //     ce.name ='SINGOLA VIA MONOFIBRA';
    //     ce.OF_Attivo__c = true;
    //     ce.OF_DataInizioValidita__c = inizio1;
    //     ce.OF_DataFineValidita__c = fine1;
    //     ce.OF_Servizio__c = servizio.id;
        
    //     insert ce;
        
    //      OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
       
    //     Date ini = Date.newInstance(2016,1,1);
    //     Date fin= Date.newInstance(2099,12,31);
    //     ce1.name = 'RIBALTAMENTO IMPIANTO';
    //     ce1.OF_Attivo__c = true;
    //     ce1.OF_DataInizioValidita__c = ini;
    //     ce1.OF_DataFineValidita__c = fin;
    //     ce1.OF_Servizio__c = servizio.id;
    //     insert ce1;
        
        
    //     OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI.OF_Asset__c=asset_1.id;
    //     CEI.OF_Stato__c='Attivo';
    //     CEI.RecordTypeId=ComRecordTypeId;
    //     CEI.OF_Case__c=c3.id;
    //     CEI.OF_EsitoConsegnaApparato__c='2';
    //     CEI.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI;
        
        
    //     OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI1.OF_Asset__c=asset_1.id;
    //     CEI1.OF_Stato__c='Attivo';
    //     CEI1.RecordTypeId=ComRecordTypeId1;
    //     CEI1.OF_Case__c=c3.id;
    //     CEI1.OF_EsitoConsegnaApparato__c='1';
    //      CEI1.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI1;
        
        
    //      OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
    //     //CEI.Name='SINGOLA VIA MONOFIBRA';
    //     CEI2.OF_Asset__c=asset_1.id;
    //     CEI2.OF_Stato__c='Attivo';
    //     CEI2.RecordTypeId=ComRecordTypeId1;
    //     CEI2.OF_Case__c=c3.id;
    //     CEI2.OF_EsitoConsegnaApparato__c='0';
    //     CEI2.OF_CommercialElement__c=CE.id;
    //      //CEI2.OF_CommercialElement__c='SINGOLA VIA MONOFIBRA';
    //     // CEI2.OF_CommercialElementName__c = 'SINGOLA VIA MONOFIBRA';
    //     insert CEI2;
        
    //     OF_BillingElement__c be = new OF_BillingElement__c();
    //     be.OF_CommercialElement__c = ce.id;
    //     Date ini113 = Date.newInstance(2099,1,31);
    //     Date fin113= Date.newInstance(2099,1,3);
    //     be.OF_DataFineValidita__c=ini113;
    //     be.OF_DataInizioValidita__c=fin113;
    //     insert be;
        
    //     OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
    //     sb1.OF_Servizio__c=servizio.id;
    //     sb1.OF_BillingElement__c = be.id;
    //     insert sb1;
        
    //     OF_Listino__c lr1=new OF_Listino__c();
    //     String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
    //     Date ini11 = Date.newInstance(2099,1,31);
    //     Date fin11= Date.newInstance(2099,1,3);
    //     lr1.OF_DataFineValidita__c=ini11;
    //     lr1.OF_DataInizioValidita__c=fin11;
    //     lr1.OF_ServizioBillingElement__c=sb1.Id;
    //     lr1.OF_Attivo__c = true;
    //     lr1.RecordTypeId = ComRecordTypeId3;
    //     lr1.OF_ListinoDefault__c = true;
    //     insert lr1;
        
    //       // Instantiate the Pricebook2 record first, setting the Id
    //     Pricebook2 standardPricebook = new Pricebook2(
    //         Id = Test.getStandardPricebookId(),
    //         IsActive = true,
    //         PO_Commercial_element__c=ce.Id,
    //         OF_Listino__c=lr1.Id,
    //         Name='P2PATT_001_CAN_DOPPBI_sttesttest123456'
            
    //     );        
    //     //update standardPricebook;
        
    //     // Re-Query for the Pricebook2 record, for debugging
    //     standardPricebook = [SELECT IsStandard,IsActive,PO_Commercial_element__c,OF_Listino__c
    //                         FROM Pricebook2 
    //                         WHERE Id = :standardPricebook.Id];
        
    //     // Create the Product
    //     Product2 testProduct = new Product2(
    //         Name = 'Contributo Verticale',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct;
        
    //     // Create the PricebookEntry
    //   /*  PricebookEntry testPbe = new PricebookEntry(
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true
    //     );
    //     insert testPbe;*/
        
    //     Product2 testProduct1 = new Product2(
    //         Name = 'Contributo Consegna e Istallazione',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct1;
        
    //     Pricebook2 customPB = new Pricebook2(Name='P2PATT_001_CAN_DOPPBI_sttesttest123456', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
    //     insert customPB;
        
    //     // Create the PricebookEntry
    //     PricebookEntry testPbe1 = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =false
    //     );
    //     insert testPbe1;   
        
    //      PricebookEntry testPbecus = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = customPB.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =true
    //     );
        
      
        
    //     insert testPbecus; 
        
    //     PO_P2PAtt_OpportunityHandler.createOppChild(c3);
         
    // }
    
    // static testMethod void testMethod5(){
       
    //     PO_P2PAtt_OpportunityHandler PO=new PO_P2PAtt_OpportunityHandler();
        
    //     /*OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
    //     tibco.Name = 'Tibco UserID';
    //     tibco.OF_Tibco_ID__c = '00558000001f743AAA';
    //     insert tibco;
        
    //     OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
    //     IpCustom.Name = 'Status';
    //     IpCustom.OF_Enable_Trigger__c = true;
    //     insert IpCustom; */
    
    //      String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    //     Account acc = new Account();
    //     acc.Lastname = 'TestAccount';
    //     acc.Phone = '0000';
    //     acc.EOF_Phone_2__c = '0000';
    //     acc.EOF_Provincia__c = 'Milano';
    //     acc.EOF_Comune__c = 'Milano';
    //     acc.EOF_Indirizzo__c = 'Piazzale Gorini';
    //     acc.RecordTYpeId = AccountRecordTypeId ;
    //     acc.EOF_Particella_Toponomastica__c = '123';
    //     acc.EOF_Numero_Civico__c = '7';
    //     insert acc;
        
    //     Contract contratto = new Contract();
    //     contratto.OF_IdContratto__c = 'TEST_TIS_001';
    //     contratto.AccountId = acc.id;
    //     insert contratto;
        
    //     Asset asset_1 = new Asset();
    //     asset_1.Name = 'IDR1234';
    //     asset_1.Status = 'Attivo';
    //     asset_1.EOF_ID_Risorsa__c = 'IDR1234';
    //     //asset_1.recordTypeId = assetRecordTypeId;
    //     asset_1.accountId = acc.id;
    //   //  asset_1.OF_Contract__c = contratto.Id;
    //     insert asset_1;
        
    //     Case c = new Case();
    //     String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c.AccountId = acc.id;
    //     c.EOF_Codice_Ordine_OLO__c = 'Test222222222';
    //     c.EOF_Contact__c = null;
    //     c.EOF_Id_Risorsa__c='test';
    //     c.status = 'Accettato';
    //     c.EOF_FASE__C = 'NA';
    //     c.OF_SA_Profilo__c='new';
    //     c.RecordTypeId=CaseRecordTypeId;
    //     c.AssetId=asset_1.id;
    //     c.EOF_Identificativo_del_POP__c='test';
    //     c.OF_Esito_Consegna_Apparato__c='2';    
        
    //     insert c;
         
        
    //     case c1=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__c,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test222222222' limit 1];
        
    //     system.debug('casec1'+c1);
    //     Case c2 = new Case();
    //     String CaseRecordTypeId1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
    //     //c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
    //     c2.AccountId = acc.id;
    //     c2.EOF_Codice_Ordine_OLO__c = 'Test12222222222';
    //     c2.EOF_Contact__c = null;
    //     c2.EOF_Id_Risorsa__c='test1';
    //     c2.status = 'Accettato';
    //     c2.EOF_FASE__C = 'NA';
    //     c2.OF_SA_Profilo__c='new';
    //     c2.RecordTypeId=CaseRecordTypeId1;
    //     c2.AssetId=asset_1.id;
    //     c2.EOF_Identificativo_del_POP__c='test11';
    //     c2.OF_Esito_Consegna_Apparato__c='2';
    //     c2.PO_Richiesta_a_fattibilit__c=c1.ID;
    //     c2.PO_Tipo_percorso__c='Doppia Via';
    //     c2.PO_Numero_fibre_richieste__c='2+2';
        
    //     insert c2;
    //     system.debug('casec2vvvvvv:'+c2.PO_Richiesta_a_fattibilit__c);
    //     system.debug('casec2'+c2.PO_Richiesta_a_fattibilit__r.caseNumber);
        
    //     case c3=[select id,CaseNumber,recordtypeId,OF_SA_Profilo__c,PO_Tipo_percorso__c,
    //              PO_Numero_fibre_richieste__c,PO_Costi_aggiuntivi_collegamento__c,
    //              PO_Richiesta_a_fattibilit__r.caseNumber,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,
    //              EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,
    //              OF_Esito_Consegna_Apparato__c FROM case where EOF_Codice_Ordine_OLO__c = 'Test12222222222' limit 1];
        
    //      system.debug('casec3:'+c3.PO_Richiesta_a_fattibilit__r.caseNumber);
    //     OF_CodificaProfiloListini__c CPC1=new OF_CodificaProfiloListini__c();
    //     CPC1.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC1.Name='new';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC1;
        
    //     OF_CodificaProfiloListini__c CPC2=new OF_CodificaProfiloListini__c();
    //     CPC2.OF_ListinoCanoneName__c='testtesttesttesttesttest123456';
    //     CPC2.Name='new2';
    //     CPC1.IsPortalValid__c=TRUE;
    //     insert CPC2;
            
    //     Order ordine = new Order();
    //     ordine.OF_CaseID__c = c3.id;
    //     //ordine.OF_Asset_Verticale__c = va.id;
    //     //ordine.OF_Asset__c = asset_t.id;
    //     ordine.AccountId = acc.id;
    //     ordine.EffectiveDate = date.today();
    //     ordine.status = 'Aperto';
    //     //ordine.OF_Contratto__c=contratto.id;
    //     insert ordine;
     
    //     OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
    //     Date inizio = Date.newInstance(2016,1,1);
    //     Date fine = Date.newInstance(2099,12,31);
    //     catalogo.name = 'Catalogo_Test';
    //     catalogo.OF_Attivo__c = true;
    //     catalogo.OF_DataInizioValidita__c = inizio;
    //     catalogo.OF_DataFineValidita__c = fine;
    //     insert catalogo;
      
        
    //     OF_Servizio__c servizio = new OF_Servizio__c();
    //     servizio.name = 'P2P Attiva';
    //     Date inizio2 = Date.newInstance(2016,1,1);
    //     Date fine2 = Date.newInstance(2099,12,31);
    //     servizio.OF_Attivo__c = true;
    //     servizio.OF_DataInizioValidita__c = inizio2;
    //     servizio.OF_DataFineValidita__c = fine2;
    //     servizio.OF_CatalogoCommerciale__c = catalogo.id;
    //     insert servizio;
        
    //      OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
    //     Date inizio1 = Date.newInstance(2016,1,1);
    //     Date fine1 = Date.newInstance(2099,12,31);
    //     ce.name ='SINGOLA VIA MONOFIBRA';
    //     ce.OF_Attivo__c = true;
    //     ce.OF_DataInizioValidita__c = inizio1;
    //     ce.OF_DataFineValidita__c = fine1;
    //     ce.OF_Servizio__c = servizio.id;
        
    //     insert ce;
        
    //      OF_CommercialElement__c ce1 = new OF_CommercialElement__c();
       
    //     Date ini = Date.newInstance(2016,1,1);
    //     Date fin= Date.newInstance(2099,12,31);
    //     ce1.name = 'RIBALTAMENTO IMPIANTO';
    //     ce1.OF_Attivo__c = true;
    //     ce1.OF_DataInizioValidita__c = ini;
    //     ce1.OF_DataFineValidita__c = fin;
    //     ce1.OF_Servizio__c = servizio.id;
    //     insert ce1;
        
        
    //     OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI.OF_Asset__c=asset_1.id;
    //     CEI.OF_Stato__c='Attivo';
    //     CEI.RecordTypeId=ComRecordTypeId;
    //     CEI.OF_Case__c=c3.id;
    //     CEI.OF_EsitoConsegnaApparato__c='2';
    //     CEI.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI;
        
        
    //     OF_CommercialElementIstanziato__c CEI1=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId1 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
    //     //CEI.Name='Test';
    //     CEI1.OF_Asset__c=asset_1.id;
    //     CEI1.OF_Stato__c='Attivo';
    //     CEI1.RecordTypeId=ComRecordTypeId1;
    //     CEI1.OF_Case__c=c3.id;
    //     CEI1.OF_EsitoConsegnaApparato__c='1';
    //      CEI1.OF_CommercialElement__c=ce.id;
    //     //CEI.OF_CommercialElement__c=CE.id;
    //     insert CEI1;
        
        
    //      OF_CommercialElementIstanziato__c CEI2=new OF_CommercialElementIstanziato__c();
    //      String ComRecordTypeId2 = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('Servizi Aggiuntivi').getRecordTypeId();
    //     //CEI.Name='SINGOLA VIA MONOFIBRA';
    //     CEI2.OF_Asset__c=asset_1.id;
    //     CEI2.OF_Stato__c='Attivo';
    //     CEI2.RecordTypeId=ComRecordTypeId1;
    //     CEI2.OF_Case__c=c3.id;
    //     CEI2.OF_EsitoConsegnaApparato__c='0';
    //     CEI2.OF_CommercialElement__c=CE.id;
    //      //CEI2.OF_CommercialElement__c='SINGOLA VIA MONOFIBRA';
    //     // CEI2.OF_CommercialElementName__c = 'SINGOLA VIA MONOFIBRA';
    //     insert CEI2;
        
    //     OF_BillingElement__c be = new OF_BillingElement__c();
    //     be.OF_CommercialElement__c = ce.id;
    //     Date ini113 = Date.newInstance(2099,1,31);
    //     Date fin113= Date.newInstance(2099,1,3);
    //     be.OF_DataFineValidita__c=ini113;
    //     be.OF_DataInizioValidita__c=fin113;
    //     insert be;
        
    //     OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
    //     sb1.OF_Servizio__c=servizio.id;
    //     sb1.OF_BillingElement__c = be.id;
    //     insert sb1;
        
    //     OF_Listino__c lr1=new OF_Listino__c();
    //     String ComRecordTypeId3 = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
    //     Date ini11 = Date.newInstance(2099,1,31);
    //     Date fin11= Date.newInstance(2099,1,3);
    //     lr1.OF_DataFineValidita__c=ini11;
    //     lr1.OF_DataInizioValidita__c=fin11;
    //     lr1.OF_ServizioBillingElement__c=sb1.Id;
    //     lr1.OF_Attivo__c = true;
    //     lr1.RecordTypeId = ComRecordTypeId3;
    //     lr1.OF_ListinoDefault__c = true;
    //     insert lr1;
        
    //       // Instantiate the Pricebook2 record first, setting the Id
    //     Pricebook2 standardPricebook = new Pricebook2(
    //         Id = Test.getStandardPricebookId(),
    //         IsActive = true,
    //         PO_Commercial_element__c=ce.Id,
    //         OF_Listino__c=lr1.Id,
    //         Name='P2PATT_001_CAN_DOPPBI_sttesttest123456'
            
    //     );        
    //     //update standardPricebook;
        
    //     // Re-Query for the Pricebook2 record, for debugging
    //     standardPricebook = [SELECT IsStandard,IsActive,PO_Commercial_element__c,OF_Listino__c
    //                         FROM Pricebook2 
    //                         WHERE Id = :standardPricebook.Id];
        
    //     // Create the Product
    //     Product2 testProduct = new Product2(
    //         Name = 'Contributo Verticale',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct;
        
    //     // Create the PricebookEntry
    //   /*  PricebookEntry testPbe = new PricebookEntry(
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true
    //     );
    //     insert testPbe;*/
        
    //     Product2 testProduct1 = new Product2(
    //         Name = 'Contributo Consegna e Istallazione',
    //         IsActive = true,
    //         OF_BillingElement__c=be.id
    //     );
    //     insert testProduct1;
        
    //     Pricebook2 customPB = new Pricebook2(Name='P2PATT_001_CAN_DOPPBI_sttesttest123456', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
    //     insert customPB;
        
    //     // Create the PricebookEntry
    //     PricebookEntry testPbe1 = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = standardPricebook.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =false
    //     );
    //     insert testPbe1;   
        
    //      PricebookEntry testPbecus = new PricebookEntry(
    //       // Name='Contributo Consegna e Istallazione',
    //         Pricebook2Id = customPB.Id,
    //         Product2Id = testProduct1.Id,
    //         UnitPrice = 100,
    //         OF_Asset__c=asset_1.Id,
    //         IsActive = true,
    //         OF_Master__c =true
    //     );
    //     insert testPbecus; 
        
    //   List<Case> tuttiIFigli = new List<Case>();
    //   tuttiIFigli.add(c3);
        
        
        
        
    //     PO_P2PAtt_OpportunityHandler.createOppParent(c3,tuttiIFigli);
         
    // }
}