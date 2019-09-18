@isTest
public class OF_GestioneServizi_Test{
    public static testmethod void OF_GestioneServiziMethod(){
     Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
      system.RunAS(thisUser)  {
    Account acc = new Account();
    acc.name = 'Test';
    acc.type='OLO';
    insert acc;
    
    contract cont1=new contract();
    cont1.AccountId = acc.id;
    cont1.name='test';
    insert cont1;
     OF_Configurazioni__c CustSett1 = new OF_Configurazioni__c();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSetting1();  
     case c = new case();
        c.status = 'Acquisito';
        c.OF_SA_Profilo__c= 'Test';
        c.subject = 'Richiesta di attivazione';
        c.OF_SA_Promozione__c= 'test';
       // c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = acc.id;
        c.OF_SA_CODICE_PROGETTO_SPECIALE__c = 'test';
        c.EOF_Tipologia_Servizio__c = '1';
        c.OF_SA_Cluster_Promozione__c = 'test';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Causale_Richiesta_Annullamento__c = 'Annullamento';
        c.EOF_Codice_Richiesta_Annullamento__c = 'AK1';
        c.OF_Servizio__c='P2P';
        c.OF_IDContratto__c=cont1.id;
        insert c;
        
        set<id> setIds = new set<id>();
        
    List<Asset> assList = new List<Asset>();
    
    Asset ass = new Asset();
    ass.OF_ServizioRichiesto__c=c.OF_Servizio__c;
    ass.Name = 'Test';
    ass.AccountId = acc.Id;
   // ass.OF_Case__c = c.Id;
    ass.OF_Contract__c = cont1.Id;
  // ass.OF_OrdineID__c = '';
    ass.Status = 'Registered';
    ass.OF_ID_Building__c = 'Test';
    ass.OF_Identificativo_del_POP__c = 'Test';
    ass.OF_GPON_Attestazione__c = 'Test';
    ass.OF_Comune__c = 'Test';
    ass.OF_DataAttivazione__c = System.today();
    ass.OF_Data__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
    ass.OF_Provincia__c = 'Test';
    ass.OF_Particella_Toponomastica__c = 'Test';
    ass.OF_Indirizzo__c = 'Test';
    ass.OF_Civico__c = 'Test';
    ass.OF_Scala_Palazzina__c = 'Test';
    ass.OF_ServizioRichiesto__c = 'Verticale';
    ass.EOF_ID_Risorsa__c = 'Test';
    ass.EOF_ID_Splitter_Secondario__c = 'Test';
    ass.EOF_Posizione_Splitter_Secondario__c = 'Test';
    ass.OF_ProgettoSpeciale__c = 'Test';
    ass.OF_IDCaseAttivazione__c = 'Test';
    ass.OF_ProfiloOpenStream__c = 'Test';
    ass.OF_Promozione__c = 'Test';
    ass.OF_ClusterPromozione__c = 'Test';
    ass.OF_TipologiaApparato__c = 'Test';
    ass.OF_CodiceProgettoSpeciale__c = 'Test';
    ass.OF_IDServizio__c = 'P2P';
    
    assList.add(ass);
    insert assList;
   for(Asset ass1:assList){
        setIds.add(ass1.id);
   }
    List<order> orderList = new List<order>();
    order ordine1 = new order();
    ordine1.EffectiveDate = Date.newInstance(2016,1,1);
      ordine1.Status = 'Aperto';
      ordine1.AccountId = acc.Id;
      ordine1.Name ='test1';
      ordine1.OF_IDRisorsa__c = '12er';
      ordine1.OF_EsitoConsegnaApparato__c = 'Ribaltamento Impianto';
     // ordine1.PO_Opportunity__c=opp.id;
      ordine1.OF_Asset__c=assList[0].id;
      ordine1.OF_TipologiaDiServizio__c='Attivo';
      ordine1.isFiberLease__c=true;
      
     orderList.add(ordine1);
     insert orderList ;
     ass.OF_OrdineID__c =ordine1.id;
     update ass;
    Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
      OF_Servizio__c p2pBase = new OF_Servizio__c();
        p2pBase.Name = 'P2P Base';
        p2pBase.OF_Attivo__c = true;
        p2pBase.OF_CatalogoCommerciale__c = catalogo.Id;
        p2pBase.OF_DataInizioValidita__c = System.today();
        p2pBase.OF_DataFineValidita__c = System.today();
        
        insert p2pBase;
    OF_CommercialElement__c ofcom = new OF_CommercialElement__c();
    ofcom.Name = 'Test';
    ofcom.OF_Attivo__c = true;
    ofcom.OF_DataFineValidita__c = System.today();
    ofcom.OF_DataInizioValidita__c=system.today();
    ofcom.OF_Servizio__c=p2pBase.id;
    insert ofcom;
    
    OF_CommercialElementIstanziato__c ofc = new OF_CommercialElementIstanziato__c();
    ofc.OF_CommercialElement__c = ofcom.ID;
    ofc.OF_Asset__c = ass.Id;
    ofc.OF_Stato__c = 'Attivo';
    ofc.OF_Nome_Servizio__c = 'Test';
    ofc.OF_ESITOSERVIZIO__c = 'Test';
    ofc.OF_EsitoConsegnaApparato__c = 'Test';
    ofc.OF_SA_VLAN__c = c.Id ;
    //ofc.OF_Profilo__c = 'Test';
    ofc.OF_TipologiaApparato__c = 'Test';
    ofc.OF_EsitoRitiroApparato__c = 'Test';
    
    insert ofc;
    
    OF_GestioneServizi  servizi = new OF_GestioneServizi ();
    OF_GestioneServizi.getIDAssetAssetObj(assList);
   
   OF_GestioneServizi.AttivazioneBECE('Test','Y');
    OF_GestioneServizi.AssociazioneOrderAsset(assList,orderList);
  OF_GestioneServizi.getIDAssetAssetObj(setIds);
  OF_GestioneServizi.CessazioneBECE('Test');
    
    }
    } 
}