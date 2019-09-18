@isTest
public class OF_ManageOrderFromCase_GPONP_TEST {
    
   public static testMethod void tEST1(){
        
        // custom settings creation for codProfLis
        OF_CodificaProfiloListini__c codProfLis=new OF_CodificaProfiloListini__c();
        codProfLis.CosType__c='MONO_COS';
        codProfLis.IsPortalValid__c=true;
        codProfLis.Name='45M';
        codProfLis.OF_ListinoCanoneName__c='OPENSTREAM_500_100';
        codProfLis.OF_ProfiloCommerciale__c='OPENSTREAM_500_100';
        codProfLis.PO_CD_Profilo_Commerciale__c='OSCD_500_100';
        codProfLis.OF_Profilolistino__c='OPSTR_001_CAN_500_100';
        codProfLis.PO_PREPROV_ListinoCanoneName__c='PREPROV_500_100';
        insert codProfLis;
        
        OF_Tibco_userID__c tibco = new OF_Tibco_userID__c();
        tibco.Name = 'Tibco UserID';
        tibco.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom.Name = 'Status';
        IpCustom.OF_Enable_Trigger__c = true;
        insert IpCustom; 

        
        Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();
        Map<String,id> rtMap = new Map<String,id>(); 
        for(recordtype rt : [select developername,id from recordtype]){
               rtmap.put(rt.developername,rt.Id);
             }
        
        Account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO');
        insert accOLO;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = accOLO.id;
        insert contratto;
        
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = rtMap.get('PersonAccount')  ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contact cnt = new Contact();
        cnt.AccountId=accOLO.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
        cnt.RecordTypeId= rtMap.get('PO_Partner');
            
        insert cnt;
        
        Case c = new case();
        c.EOF_Account_OLO__c = accOLO.id;
        c.Subject = 'Richiesta di attivazione';
        c.EOF_Codice_Ordine_OLO__c = '02112016_37';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Acquisito';
        c.EOF_Fase__c = 'In Verifica BO';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test';
        c.EOF_Codice_Operatore_WS__c = 'VF';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        c.EOF_Numero_Civico_WS__c = '7';
        c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        c.EOF_Recapito_Test_Linea__c = '111';
        c.EOF_Tipologia_Apparato__c = 'test';
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.EOF_Order_Manager__c = true;
                insert c;
        
       Case c1 = new case();
        c1.EOF_Account_OLO__c = accOLO.id;
        c1.EOF_Codice_Ordine_OLO__c = 'Test';
        c1.EOF_Codice_Operatore_WS__c ='VF';
        c1.EOF_Contact__c = null;
        c1.status = 'Accettato';
        c1.EOF_FASE__C = 'NA';
        c1.EOF_ID_Building_WS__c ='Test';
       // c1.RecordTypeId = rtMap.get('OF_SA_Attivazione');
         c1.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c1.EOF_DATA_NOTIFICA__c=system.now();
        c1.EOF_Data_Prevista_Attivazione__c=system.today();
        insert c1;
        
        Case c3 = new case();
        c3.EOF_Account_OLO__c = accOLO.id;
        //c3.Subject = 'Richiesta di cessazione';
        c3.EOF_Codice_Ordine_OLO__c = '02112016_37';
        //c3.EOF_Data_Prevista_Attivazione__c = system.today();
        //c3.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c3.Status = 'Acquisito';
        c3.EOF_Fase__c = 'In Verifica BO';
        //c3.Type = '1';
        //c3.EOF_Tipologia_Servizio__c = 'test';
        c3.EOF_Codice_Operatore_WS__c = 'VF';
        c3.EOF_SLA_Premium_Assurance__c ='Y';
        //c3.Account = acc;
        c3.EOF_Identificativo_del_POP__c = 'PG_01';
        c3.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';       
        c3.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        // insert c3;
       
        
        Case c2 = new case();
        c2.EOF_Codice_Ordine_olo__c ='Test';
        c2.EOF_Account_OLO__c = accOLO.id;
        c2.EOF_Contact__c = null;
        c2.status = 'Ricevuto';
        c2.EOF_FASE__C = 'NA';
       // c2.RecordTypeId = rtMap.get('OF_SA_Cessazione') ;
        c2.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        //insert c2;
        //
        
         Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
        ccus.Name='test1';
        ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ccus.assetDevName__c='P2P';
        ccus.beAttivazioneList__c='Contributo Attivazione ,Canone';
        insert ccus;
        
        Asset a = new Asset();
        a.Status = 'Attivo';
        a.Name = 'Canone';
        a.EOF_ID_Risorsa__c = 'risorsa';
        a.AccountID = accOLO.Id;
        insert a;
        
         Asset a2 = new Asset();
        a2.Status = 'Attivo';
        a2.Name = 'Canone';
        a2.EOF_ID_Risorsa__c = 'risorsa';
        a2.AccountID = accOLO.Id;
        a2.OF_Contract__c = contratto.Id;
        a2.EOF_SLA_Premium_Assurance__c='Y';
        insert a2;
        
        Order ordine = new Order();
        ordine.OF_CaseID__c = c.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine.OF_Asset__c = a.id;
        ordine.AccountId = accOLO.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        //ordine.ContractId =contratto.id;
        insert ordine;
        
         Order ordine1 = new Order();
       // ordine1.OF_CaseID__c = c4.id;
        //ordine.OF_Asset_Verticale__c = va.id;
        ordine1.OF_Asset__c = a2.id;
        ordine1.AccountId = accOLO.id;
        ordine1.EffectiveDate = date.today();
        ordine1.status = 'Aperto';
        ordine1.OF_IDOrdineEOF__c='tatta';
        ordine1.ContractId=contratto.id;
        insert ordine1;
        
        Case c4 = new case();
        c4.EOF_Account_OLO__c = accOLO.id;
        c4.EOF_Codice_Ordine_OLO__c = '02112016_48';
        c4.Status = 'Espletato';
        // c4.Account = acc;
        c4.EOF_Fase__c = 'In Verifica BO';
        c4.EOF_Codice_Operatore_WS__c = 'VF';
        c4.EOF_SLA_Premium_Assurance__c ='Y';
        c4.EOF_Identificativo_del_POP__c = 'PG_03';
        c4.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';       
        c4.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c4.OF_Order__c=ordine1.id;
        insert c4;
        
      case c5=[select actionDate_Remedy__c,OF_SA_Motivazione__c,OF_SA_Codice_Motivazione__c,id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c,EOF_GPON_Attestazione__c,EOF_Apparato__c,EOF_SLA_Premium_Assurance__c,EOF_Progetto_Speciale__c,EOF_Tipologia_Apparato__c,EOF_Password_Apparato__c,EOF_ID_Building_WS__c,PO_Comune__c,EOF_Provincia_WS__c,EOF_Particella_Toponomastica_WS__c,PO_Indirizzo_collegamento__c,PO_Civico__c,EOF_Scala_Palazzina_WS__c,OF_SA_Profilo__c,OF_SA_Promozione__c,OF_SA_CODICE_PROGETTO_SPECIALE__c,OF_SA_Cluster_Promozione__c,EOF_Comune_WS__c,EOF_Istat_Comune__c,EOF_Istat_Provincia__c,EOF_Indirizzo_WS__c,EOF_Numero_Civico_WS__c FROM case where EOF_Codice_Ordine_OLO__c = '02112016_48'];   
       
        contract con = new contract();
        con.AccountID = acc.Id;
        con.OF_IdContratto__c = 'Test';
        con.StartDate = System.today();
        con.ContractTerm = 1234;
        con.Status = 'Draft';
        insert con;
        Id RecordTypeIdlis = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Id RecordTypeIdcom = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('VLAN').getRecordTypeId();

        
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
///Abhishek Anand
 		OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;        
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
       
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        contrattoServizio.OF_Contract__c=a2.OF_Contract__c;
        contrattoServizio.OF_Servizio__c=servizio.id;
        
        insert contrattoServizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'VLAN1';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        
        insert ce;
        
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=a2.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c4.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.OF_EsitoRitiroApparato__c='0';
        CEI.OF_TipologiaApparato__c='1ONTVFX-1.10096378-123185280-LVRRST52R21G273B-';       
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
       
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=servizio.id;
        
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        
        insert lr1;
        
      
        
        
        OF_BillingElement__c bec2=new OF_BillingElement__c();
        //bec2.Name='Contributo Ritiro';
         bec2.Name='Canone premium';
        Date ini123 = Date.newInstance(2099,1,31);
        Date fin123= Date.newInstance(2099,1,3);
        bec2.OF_DataFineValidita__c=ini123;
        bec2.OF_DataInizioValidita__c=fin123;
        bec2.OF_CommercialElement__c=ce.id;
        bec2.OF_Attivo__c=true;
       
         insert bec2;
       
      
        
        system.debug('billingintest:'+bec2);
        system.debug('billingintest for query field0:'+bec2.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec2.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec2.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];
        
        bec2=bec3;
        
        update bec2;
        
        
        
        system.debug('billingintest1:'+bec2);
        
         system.debug('billingintest2:'+bec2.OF_Attivo__c);
         system.debug('billingintest3:'+bec2.OF_Servizio__c);
        system.debug('billingintest4:'+bec2.name);
        system.debug('billingintest for query field3test:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        
        
          OF_BillingElement__c bec=new OF_BillingElement__c();
        bec.Name='Contributo Attivazione';
        Date ini12 = Date.newInstance(2099,1,31);
        Date fin12= Date.newInstance(2099,1,3);
        bec.OF_DataFineValidita__c=ini12;
        bec.OF_DataInizioValidita__c=fin12;
        bec.OF_CommercialElement__c=ce.id;
        bec.OF_Attivo__c=true;
       
         insert bec;
       
      
        
        system.debug('billingintest:'+bec);
        system.debug('billingintest for query field0:'+bec.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];
        
        bec=bec1;
        
        update bec;
        
        
         
        system.debug('billingintest1:'+bec);
        
         system.debug('billingintest2:'+bec.OF_Attivo__c);
         system.debug('billingintest3:'+bec.OF_Servizio__c);
        system.debug('billingintest4:'+bec.name);
        system.debug('billingintest for query field3test:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        // Instantiate the Pricebook2 record first, setting the Id
       
          
        //--//
        
        OF_BillingElement__c bec4=new OF_BillingElement__c();
        bec4.Name='Contributo Consegna e istallazione';
        Date ini1234 = Date.newInstance(2099,1,31);
        Date fin1234= Date.newInstance(2099,1,3);
        bec4.OF_DataFineValidita__c=ini1234;
        bec4.OF_DataInizioValidita__c=fin1234;
        bec4.OF_CommercialElement__c=ce.id;
        bec4.OF_Attivo__c=true;
       
         insert bec4;
       
      
        
        
        OF_BillingElement__c bec5=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna e istallazione'];
        
        bec4=bec5;
        
        update bec4;
        
        
        OF_BillingElement__c bec6=new OF_BillingElement__c();
        bec6.Name='Canone';
        Date ini12345 = Date.newInstance(2099,1,31);
        Date fin12345= Date.newInstance(2099,1,3);
        bec6.OF_DataFineValidita__c=ini12345;
        bec6.OF_DataInizioValidita__c=fin12345;
        bec6.OF_CommercialElement__c=ce.id;
        bec6.OF_Attivo__c=true;
       
         insert bec6;
       
      
        
        
        OF_BillingElement__c bec7=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone'];
        
        bec6=bec7;
        
        update bec6;
        
        //Contributo Consegna TV BOX
        //
         OF_BillingElement__c bec8=new OF_BillingElement__c();
        bec8.Name='Contributo Consegna TV BOX';
        Date ini123456 = Date.newInstance(2099,1,31);
        Date fin123456= Date.newInstance(2099,1,3);
        bec8.OF_DataFineValidita__c=ini123456;
        bec8.OF_DataInizioValidita__c=fin123456;
        bec8.OF_CommercialElement__c=ce.id;
        bec8.OF_Attivo__c=true;
       
         insert bec8;
       
      
        
        
        OF_BillingElement__c bec9=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna TV BOX'];
        
        bec8=bec9;
        
        update bec8;
        
        
        
        //---// 
   
    //Abhishek Anand
       
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
            
        );        
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                            FROM Pricebook2 
                            WHERE Id = :standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
    
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Consegna e Istallazione',
            IsActive = true
        );
        insert testProduct1;
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
        insert customPB;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=a2.Id,
            IsActive = true,
            OF_Master__c =false
        );
        insert testPbe1;   
        
         PricebookEntry testPbecus = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = customPB.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=a2.Id,
            IsActive = true,
            OF_Master__c =true
        );
/// Abhishek Anand
        
        
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
            OF_Asset__c=a.id,
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
        
      
        
        Asset a1 = new Asset();
        a1.RecordTypeId = rtMap.get('OF_OpenStream');
        a1.status='Attivo';
        a1.EOF_ID_Risorsa__c='risorsa';
        a1.name='Test';
        a1.accountId=accOlo.id;
        a1.ContactId= cnt.id;
        a1.OF_Case__c=c1.id;
        a1.EOF_OLO__c='VF';
        //insert a1;
        
        
        test.startTest();
        OF_ManageOrderFromCase_GPONP mOfC = new OF_ManageOrderFromCase_GPONP();
        //OF_ManageOrderFromCase_GPONP.o=ordine;
        mOfC.ManageOrder(c);
        mOfC.ManageOrder(c1);
        mOfC.ManageOrder(c2);
        mOfC.ManageOrder(c3);
        
        
        mOfC.creazioneOrdine(c,'OF_INORDER');
        c.Status = 'Acquisito KO';
        mOfC.creazioneOrdine(c,'OF_INORDER');
        //mOfC.creazioneOrdine(c1,'OF_INORDER');
        c1.Status = 'Acquisito KO';
        mOfC.creazioneOrdine(c1,'OF_INORDER');
       // mOfC.creazioneOrdine(c2,'OF_INORDER');
        c2.Status = 'Acquisito KO';
        mOfC.creazioneOrdine(c2,'OF_INORDER');
      //  mOfC.creazioneOrdine(c3,'OF_INORDER');
      //  c3.Status = 'Acquisito KO';
      //  mOfC.creazioneOrdine(c3,'OF_INORDER');
        //mOfC.creazioneOrdine(c,'OF_OUTORDER');
        c.Status = 'Cessato KO';
        mOfC.creazioneOrdine(c,'OF_OUTORDER');
       // mOfC.creazioneOrdine(c1,'OF_OUTORDER');
        c1.Status = 'Cessato KO';
        mOfC.creazioneOrdine(c1,'OF_OUTORDER');
       // mOfC.creazioneOrdine(c2,'OF_OUTORDER');
        c2.Status = 'Cessato KO';
        mOfC.creazioneOrdine(c2,'OF_OUTORDER');
       // mOfC.creazioneOrdine(c3,'OF_OUTORDER');
      //  c3.Status = 'Cessato KO';
       // mOfC.creazioneOrdine(c3,'OF_OUTORDER');
        
       // mOfC.AggiornoOrdine(c5);
        //mOfC.AggiornoOrdine(c1);
       // mOfC.AggiornoOrdine(c2);
      //  mOfC.AggiornoOrdine(c3);
        
      //  mOfC.CreateClienteRetail(c.id,a.id);
      //  mOfC.CreateClienteRetail(c1.id,a1.id);
        
        
        test.stoptest();
        
        
    }
    
    
    public static testMethod void tEST2(){
        
   
        OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
        tibco1.Name = 'Tibco UserID';
        tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco1;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom1.Name = 'Status';
        IpCustom1.OF_Enable_Trigger__c = true;
        insert IpCustom1; 
        
   
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount1';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR12341';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.EOF_SLA_Premium_Assurance__c='Y';
     
        insert asset_1;
        
        
         Order ordine = new Order();
        ordine.AccountId = acc.id;
        ordine.ContractId= contratto.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_IDRisorsa__c='test';
        ordine.OF_SlaPremiumAssurance__c='Y';
        insert ordine;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test1';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test1';
        c.OF_Esito_Consegna_Apparato__c='2';  
        c.OF_Order__c=ordine.id;
        c.OF_IDContratto__c=contratto.id;
       
        insert c;
        
        case c1=[select id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case Where EOF_Identificativo_del_POP__c='test1'];
        
        Case c2 = new Case();
        String CaseRecordTypeIdc2 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
        c2.AccountId = acc.id;
        c2.EOF_Codice_Ordine_OLO__c = 'Test1c2';
        c2.EOF_Contact__c = null;
        c2.EOF_Id_Risorsa__c='testc2';
        c2.status = 'Cessato';
        c2.EOF_FASE__C = 'NA';
        c2.OF_SA_Profilo__c='1';
        c2.RecordTypeId=CaseRecordTypeIdc2;
        c2.AssetId=asset_1.id;
        c2.EOF_Identificativo_del_POP__c='testc2';
        c2.OF_Esito_Consegna_Apparato__c='2';  
        c2.OF_Order__c=ordine.id;
        c2.OF_IDContratto__c=contratto.id;
       
        insert c2;
        
        Case c3 = new Case();
        String CaseRecordTypeIdc3 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        c3.AccountId = acc.id;
        c3.EOF_Codice_Ordine_OLO__c = 'Test1c3';
        c3.EOF_Contact__c = null;
        c3.EOF_Id_Risorsa__c='testc3';
        c3.status = 'Cessato';
        c3.EOF_FASE__C = 'NA';
        c3.OF_SA_Profilo__c='1';
        c3.RecordTypeId=CaseRecordTypeIdc3;
        c3.AssetId=asset_1.id;
        c3.EOF_Identificativo_del_POP__c='testc3';
        c3.OF_Esito_Consegna_Apparato__c='2';  
        c3.OF_Order__c=ordine.id;
        c3.OF_IDContratto__c=contratto.id;
       
        insert c3;
        
        
        Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
        ccus.Name='test1';
        ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ccus.assetDevName__c='P2P';
        ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione,Contributo Consegna e istallazione,Canone,Contributo Consegna TV BOX';
        insert ccus;
            
        
        Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
        cer.name='testcer1';
        cer.ceName__c='VLAN1';
        cer.ceiDevName__c='CPE_Passivi';
        
        insert cer;
        
        
     
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
      
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
       // servizio.name = 'GPON';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
       
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Servizio__c=servizio.id;
        
        insert contrattoServizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'VLAN1';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        
        insert ce;
        
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.OF_TipologiaApparato__c='1ONTVFX-1.10096378-123185280-LVRRST52R21G273B-';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
       
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=servizio.id;
        
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        
        insert lr1;
        
      
        
        
        OF_BillingElement__c bec2=new OF_BillingElement__c();
        bec2.Name='Canone premium';
        Date ini123 = Date.newInstance(2099,1,31);
        Date fin123= Date.newInstance(2099,1,3);
        bec2.OF_DataFineValidita__c=ini123;
        bec2.OF_DataInizioValidita__c=fin123;
        bec2.OF_CommercialElement__c=ce.id;
        bec2.OF_Attivo__c=true;
       
         insert bec2;
       
      
        
        system.debug('billingintest:'+bec2);
        system.debug('billingintest for query field0:'+bec2.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec2.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec2.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];
        
        bec2=bec3;
        
        update bec2;
        
        
        
        system.debug('billingintest1:'+bec2);
        
         system.debug('billingintest2:'+bec2.OF_Attivo__c);
         system.debug('billingintest3:'+bec2.OF_Servizio__c);
        system.debug('billingintest4:'+bec2.name);
        system.debug('billingintest for query field3test:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        
        
          OF_BillingElement__c bec=new OF_BillingElement__c();
        bec.Name='Contributo Attivazione';
        Date ini12 = Date.newInstance(2099,1,31);
        Date fin12= Date.newInstance(2099,1,3);
        bec.OF_DataFineValidita__c=ini12;
        bec.OF_DataInizioValidita__c=fin12;
        bec.OF_CommercialElement__c=ce.id;
        bec.OF_Attivo__c=true;
       
         insert bec;
       
      
        
        system.debug('billingintest:'+bec);
        system.debug('billingintest for query field0:'+bec.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];
        
        bec=bec1;
        
        update bec;
       
        
        system.debug('billingintest1:'+bec);
        
         system.debug('billingintest2:'+bec.OF_Attivo__c);
         system.debug('billingintest3:'+bec.OF_Servizio__c);
        system.debug('billingintest4:'+bec.name);
        system.debug('billingintest for query field3test:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        
        
        OF_BillingElement__c bec4=new OF_BillingElement__c();
        bec4.Name='Contributo Consegna e istallazione';
        Date ini1234 = Date.newInstance(2099,1,31);
        Date fin1234= Date.newInstance(2099,1,3);
        bec4.OF_DataFineValidita__c=ini1234;
        bec4.OF_DataInizioValidita__c=fin1234;
        bec4.OF_CommercialElement__c=ce.id;
        bec4.OF_Attivo__c=true;
       
         insert bec4;
       
      
        
        
        OF_BillingElement__c bec5=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna e istallazione'];
        
        bec4=bec5;
        
        update bec4;
        
        
        OF_BillingElement__c bec6=new OF_BillingElement__c();
        bec6.Name='Canone';
        Date ini12345 = Date.newInstance(2099,1,31);
        Date fin12345= Date.newInstance(2099,1,3);
        bec6.OF_DataFineValidita__c=ini12345;
        bec6.OF_DataInizioValidita__c=fin12345;
        bec6.OF_CommercialElement__c=ce.id;
        bec6.OF_Attivo__c=true;
       
         insert bec6;
       
      
        
        
        OF_BillingElement__c bec7=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone'];
        
        bec6=bec7;
        
        update bec6;
        
        //Contributo Consegna TV BOX
        //
         OF_BillingElement__c bec8=new OF_BillingElement__c();
        bec8.Name='Contributo Consegna TV BOX';
        Date ini123456 = Date.newInstance(2099,1,31);
        Date fin123456= Date.newInstance(2099,1,3);
        bec8.OF_DataFineValidita__c=ini123456;
        bec8.OF_DataInizioValidita__c=fin123456;
        bec8.OF_CommercialElement__c=ce.id;
        bec8.OF_Attivo__c=true;
       
         insert bec8;
       
      
        
        
        OF_BillingElement__c bec9=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna TV BOX'];
        
        bec8=bec9;
        
        update bec8;
      
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
            
        );        
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                            FROM Pricebook2 
                            WHERE Id = :standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
      /*  PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true
        );
        insert testPbe;*/
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Consegna e Istallazione',
            IsActive = true
        );
        insert testProduct1;
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
        insert customPB;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =false
        );
        insert testPbe1;   
        
         PricebookEntry testPbecus = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = customPB.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =true
        );
        
        insert testPbecus; 
       
        OF_ManageOrderFromCase_GPONP mOfC = new OF_ManageOrderFromCase_GPONP();
               
       mOfC.AggiornoOrdine(c);
        //mOfC.AggiornoOrdine(c2);
        
        mOfC.getTipologiaServizioByCaseRType(c);
        mOfC.getTipologiaServizioByCaseRType(c2);
        mOfC.getTipologiaServizioByCaseRType(c3);
         
       
                
    }
    
    
   public static testMethod void tEST3(){
        OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
        tibco1.Name = 'Tibco UserID';
        tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco1;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom1.Name = 'Status';
        IpCustom1.OF_Enable_Trigger__c = true;
        insert IpCustom1; 
        
   
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount1';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR12341';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        asset_1.EOF_SLA_Premium_Assurance__c='Y';
     
        insert asset_1;
        
        
         Order ordine = new Order();
        ordine.AccountId = acc.id;
        ordine.ContractId= contratto.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_IDRisorsa__c='test';
        ordine.OF_SlaPremiumAssurance__c='Y';
        insert ordine;
        
        Case c = new Case();
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso Attivazione OPENSTREAM CeD').getRecordTypeId();
        c.AccountId = acc.id;
        c.EOF_Codice_Ordine_OLO__c = 'Test1';
        c.EOF_Contact__c = null;
        c.EOF_Id_Risorsa__c='test';
        c.status = 'Accettato';
        c.EOF_FASE__C = 'NA';
        c.OF_SA_Profilo__c='1';
        c.RecordTypeId=CaseRecordTypeId;
        c.AssetId=asset_1.id;
        c.EOF_Identificativo_del_POP__c='test1';
        c.OF_Esito_Consegna_Apparato__c='2';  
        c.OF_Order__c=ordine.id;
        c.OF_IDContratto__c=contratto.id;
       
        insert c;
        
        case c1=[select OF_SA_Motivazione__c,OF_SA_Codice_Motivazione__c,id,OF_IDContratto__c,OF_Order__c,OF_CPE_Quantity__c,NS_Rif__c,recordtypeId,recordtype.developername,AccountId,EOF_Codice_Ordine_OLO__c,EOF_Contact__c,EOF_Id_Risorsa__c,status,EOF_FASE__C,AssetId,EOF_Identificativo_del_POP__c,OF_Esito_Consegna_Apparato__c FROM case];
        
        Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
        ccus.Name='test1';
        ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ccus.assetDevName__c='P2P';
        ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione';
        insert ccus;
            
        
        Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
        cer.name='testcer1';
        cer.ceName__c='VLAN1';
        cer.ceiDevName__c='CPE_Passivi';
        
        insert cer;
        
        
     
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
      
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
       
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Servizio__c=servizio.id;
        
        insert contrattoServizio;
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'VLAN1';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        
        insert ce;
        
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
         String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=asset_1.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=c.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
       
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=servizio.id;
        
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        
        insert lr1;
        
      
        
        
        OF_BillingElement__c bec2=new OF_BillingElement__c();
        bec2.Name='Canone premium';
        Date ini123 = Date.newInstance(2099,1,31);
        Date fin123= Date.newInstance(2099,1,3);
        bec2.OF_DataFineValidita__c=ini123;
        bec2.OF_DataInizioValidita__c=fin123;
        bec2.OF_CommercialElement__c=ce.id;
        bec2.OF_Attivo__c=true;
       
         insert bec2;
       
      
        
        system.debug('billingintest:'+bec2);
        system.debug('billingintest for query field0:'+bec2.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec2.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec2.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];
        
        bec2=bec3;
        
        update bec2;
        
        
        
        system.debug('billingintest1:'+bec2);
        
         system.debug('billingintest2:'+bec2.OF_Attivo__c);
         system.debug('billingintest3:'+bec2.OF_Servizio__c);
        system.debug('billingintest4:'+bec2.name);
        system.debug('billingintest for query field3test:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        
        
          OF_BillingElement__c bec=new OF_BillingElement__c();
        bec.Name='Contributo Attivazione';
        Date ini12 = Date.newInstance(2099,1,31);
        Date fin12= Date.newInstance(2099,1,3);
        bec.OF_DataFineValidita__c=ini12;
        bec.OF_DataInizioValidita__c=fin12;
        bec.OF_CommercialElement__c=ce.id;
        bec.OF_Attivo__c=true;
       
         insert bec;
       
      
        
        system.debug('billingintest:'+bec);
        system.debug('billingintest for query field0:'+bec.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];
        
        bec=bec1;
        
        update bec;
       
        
        system.debug('billingintest1:'+bec);
        
         system.debug('billingintest2:'+bec.OF_Attivo__c);
         system.debug('billingintest3:'+bec.OF_Servizio__c);
        system.debug('billingintest4:'+bec.name);
        system.debug('billingintest for query field3test:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
            
        );        
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                            FROM Pricebook2 
                            WHERE Id = :standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        // Create the PricebookEntry
      /*  PricebookEntry testPbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true
        );
        insert testPbe;*/
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Consegna e Istallazione',
            IsActive = true
        );
        insert testProduct1;
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
        insert customPB;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =false
        );
        insert testPbe1;   
        
         PricebookEntry testPbecus = new PricebookEntry(
           // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = customPB.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=asset_1.Id,
            IsActive = true,
            OF_Master__c =true
        );
        
        insert testPbecus; 
       
             
         OF_Espletamento_Generico_AP EGA=new OF_Espletamento_Generico_AP(c1);
         OF_Espletamento_Generico_AP.getRtMap();
        OF_Espletamento_Generico_AP.BeiData BD=new OF_Espletamento_Generico_AP.BeiData(CEI,testProduct1);
        
         
        
        
        
        EGA.cessazioneCeiGPONP_OpenStream(false);
        EGA.cessazioneCeiGPONP_Remedy(false);
        
       
}

  
}