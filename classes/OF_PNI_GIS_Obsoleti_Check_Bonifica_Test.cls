@isTest
public class OF_PNI_GIS_Obsoleti_Check_Bonifica_Test {

  public static Verticali__c createVerticaliCustomSetting() {
    Verticali__c cs = new Verticali__c();
    cs.Name = 'test';
    cs.delayAlgoritmo__c = 1;
    cs.delayBonifica__c = 240;
    cs.Email__c = 'test@test.org';
    cs.Email_CC__c = 'test@test.org';
    cs.Email_from__c = 'Delivery Services Openfiber';
    cs.emailSubject__c = 'subj';
    cs.giorniTolleranza__c = -2;
    cs.limitBatch__c = 10;
    cs.TextBody__c = 'text';

    insert cs;
    return cs;
  }

  public static Case caseActivationCreation(Account acc, Account accOLO, Asset asset_t,order ord) {
    String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
    List<Case> vlstcase =  new List<Case>();
    Case c = new Case();
    c.EOF_Account_OLO__c = accOLO.Id;
    c.Subject = 'Richiesta Attivazione';
    c.EOF_Codice_Ordine_OLO__c = '02112016_37' + Math.rint(Math.random() * 100);
    c.EOF_Data_Prevista_Attivazione__c = system.today();
    c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
    c.Status = 'Espletato';
    c.EOF_Fase__c = 'Espletato OK';
    c.Type = '1';
    c.EOF_Tipologia_Servizio__c = 'test1';
    c.EOF_Codice_Operatore_WS__c = 'VF';
    c.EOF_SLA_Premium_Assurance__c = 'Y';
    c.Account = acc;
    c.AssetId = asset_t.id;
    c.OwnerId = userInfo.getUserId();
    c.RecordTypeId = CaseRecordTypeId;
    c.EOF_Id_Notifica__c = 'test_01';
    c.Origin = 'Web';
    c.Priority = 'Medium';
    c.EOF_GPON_Vincolante__c = 'Y';
    c.OF_Order__c = ord.id;
    insert c;

    return c;
  }

  public static OF_BillingElement__c createContributoVerticale(OF_CommercialElement__c ce, String name) {
    OF_BillingElement__c be = new OF_BillingElement__c();
    be.name = name != null ? name : 'Contributo Verticale';
    be.OF_CommercialElement__c = ce.id;
    Date inizio = Date.newInstance(2016,1,1);
    Date fine = Date.newInstance(2099,12,31);
    be.OF_Attivo__c = true;
    be.OF_DataInizioValidita__c = inizio;
    be.OF_DataFineValidita__c = fine;
    insert be;
    return be;
  }

  public static OF_CommercialElement__c CE_Creation(OF_Servizio__c serv) {
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

  public static Order orderCreation(OF_Asset_Verticale__c va, Account acc) {
    Order ordine = new Order();
    ordine.OF_Asset_Verticale__c = va.id;
    ordine.OF_Asset__c = va.Asset__c; // asset_t.id;
    ordine.AccountId = acc.id; // va.Asset__r.accountId;
    ordine.EffectiveDate = date.today();
    ordine.status = 'Aperto';
    insert ordine;

    return ordine;
  }

  public static OF_CatalogoCommerciale__c Catalogo_Creation() {
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

  public static OF_Servizio__c Servizio_Creation(OF_CatalogoCommerciale__c cat) {
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

  public static Account accountOFCreation() {
    String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
    Account acc = new Account();
    acc.Name = 'OpenFiber';
    acc.Type = 'OLO';
    acc.EOF_Codice_Operatore__c = 'OF';
    acc.RecordTYpeId = AccountRecordTypeId;
    insert acc;
    return acc;
  }

  public static Contract createContract(Account acc) {
    Contract contratto = new Contract();
    contratto.OF_IdContratto__c = 'TEST_TIS_001';
    contratto.AccountId = acc.id;
    insert contratto;
    return contratto;
  }

  public static OF_ContrattoServizio__c createContrattoServizio(Contract contr, OF_Servizio__c serv) {
    OF_ContrattoServizio__c conServ = new OF_ContrattoServizio__c();
    conServ.OF_Contract__c = contr.Id;
    conServ.OF_Servizio__c = serv.id;

    insert conServ;
    return conServ;
  }

  public static Asset assetCreation(Account acc, String contractId) {
    String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
    Asset asset_1 = new Asset();
    asset_1.Name = 'IDR1234';
    asset_1.Status = 'Attivo';
    asset_1.EOF_ID_Risorsa__c = 'IDR1234';
    asset_1.recordTypeId = assetRecordTypeId;
    asset_1.accountId = acc.id;
    asset_1.OF_Contract__c = contractId;
    insert asset_1;

    return asset_1;
  }

  public static Account account_OLO_Creation() {
    String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
    Account accOLO = new Account();
    accOLO.Name = 'Vodafone';
    accOLO.EOF_Codice_Operatore__c = 'VF';
    accOLO.Type = 'OLO';
    accOLO.Industry = 'Telecommunications';
    accOLO.RecordTYpeId = oloAccountRecordTypeId;
    insert accOLO;

    return accOLO;
  }

  public static OF_Asset_Verticale__c assetVerticaleCreation(Asset asset1, String idScala) {
    OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();

    //va.stato__c = 'Attivo';
    va.Indirizzo__c = 'Nazionale';
    va.Civico__c = '34';
    va.Comune__c = 'Milano';
    va.ID_DB_Building__c = 'ID_DB_001';
    va.ID_DB_Scala_Palazzina__c = 'AX001';
    va.ID_GIS_Scala_Palazzina__c = idScala;
    va.Particella_Toponomastica__c = 'Via';
    va.Cardinalita_Scala__c = 1;
    va.Asset__c = asset1.id;

    insert va;

    return va;
  }

  public static OF_Billing_Element_Verticale__c billingElementVCreation(Case c, OF_Asset_Verticale__c va, DateTime created) {
    OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
    verticalBE.name = 'BEV-' + va.ID_GIS_Scala_Palazzina__c + Math.rint(Math.random() * 100);
    verticalBE.ID_Risorsa__c = 'test';
    verticalBE.OLO__c = c.EOF_Account_OLO__c;
    verticalBE.OF_Status__c = 'ATTIVO';
    verticalBE.Data_Attivazione__c = System.now();
    //Relaziono il BE Verticale all'Asset Standard
    verticalBE.Asset__c = va.Asset__c; // asset_t.id;
    //Relaziono il BE Verticale all'Asset Verticale
    verticalBE.Asset_Verticale__c = va.id;
    insert verticalBE;

    Test.setCreatedDate(verticalBE.Id, created);

    return verticalBE;
  }

  public static List<OF_Billing_Element_Verticale__c> createListaBev() {
    List<OF_Billing_Element_Verticale__c> listaBEV = new List<OF_Billing_Element_Verticale__c>();

    Account accOf = accountOFCreation();
    Contract contratto1 = createContract(accOf);
    Contract contratto2 = createContract(accOf);
    Contract contratto3 = createContract(accOf);
    OF_CatalogoCommerciale__c cc = Catalogo_Creation();
    OF_Servizio__c serv1 = Servizio_Creation(cc);
    createContrattoServizio(contratto1, serv1);
    OF_CommercialElement__c ce = CE_Creation(serv1);
    createContributoVerticale(ce, 'Contributo di storno Verticale');
    createContributoVerticale(ce, null);
    Account oloVoda = account_OLO_Creation();
    Asset asset1 = assetCreation(accOf, contratto1.id);
    Asset asset2 = assetCreation(accOf, contratto1.id);
    Asset asset3 = assetCreation(accOf, contratto1.id);
    OF_Asset_Verticale__c av1 = assetVerticaleCreation(asset1, 'scalaA');
    Order ord = orderCreation(av1 /*, asset1*/, accOf);
    Case c1 = caseActivationCreation(accOf, oloVoda, asset1, ord);
    OF_Billing_Element_Verticale__c bev1 = billingElementVCreation(c1, av1, System.now());
    listaBEV.add(bev1);
    OF_Billing_Element_Verticale__c bev2 = billingElementVCreation(c1, av1, System.now().addDays(-2));
    listaBEV.add(bev2);
    OF_Billing_Element_Verticale__c bev3 = billingElementVCreation(c1, av1, System.now().addDays(-20));
    listaBEV.add(bev3);

    return listaBEV;
  }

  public static Pricebook2 createStandardPricebook2(Id idAsset) {
    Pricebook2 standardPricebook = new Pricebook2(
      Id = Test.getStandardPricebookId(),
      IsActive = true
    );
    update standardPricebook;

    Product2 prod1 = new Product2(Name = 'Contributo Verticale',
                                  Family = 'prod2Family');
    insert prod1;
    PricebookEntry standardPrice1 = new PricebookEntry(
      Pricebook2Id = standardPricebook.Id, Product2Id = prod1.Id,
      UnitPrice = 10000, IsActive = true, OF_Asset__c = idAsset);
    insert standardPrice1;

    Product2 prod2 = new Product2(Name = 'Contributo Storno Verticale',
                                  Family = 'prod2Family');
    insert prod2;
    PricebookEntry standardPrice2 = new PricebookEntry(
      Pricebook2Id = standardPricebook.Id, Product2Id = prod2.Id,
      UnitPrice = 10000, IsActive = true, OF_Asset__c = idAsset);
    insert standardPrice2;

    return standardPricebook;
  }

  public static testMethod void bonificaTest() {

    createVerticaliCustomSetting();
    List<OF_Billing_Element_Verticale__c> bevs = createListaBev();

    createStandardPricebook2(bevs.get(0).Asset__c);

    List<OF_Billing_Element_Verticale__c> listaBEV = [SELECT id, ID_Risorsa__c, Asset__c, Asset__r.OF_Contract__c, Asset_Verticale__c, Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, OLO__r.name, Data_Attivazione__c, CreatedDate, LastModifiedDate
                                                      FROM OF_Billing_Element_Verticale__c
                                                      WHERE OF_Status__c = 'ATTIVO' AND Asset_Verticale__r.ID_GIS_Scala_Palazzina__c = 'scalaA'
                                                          ORDER BY Asset_Verticale__r.ID_GIS_Scala_Palazzina__c, OLO__r.name, Data_Attivazione__c];

    Test.startTest();
    OF_PNI_GIS_Obsoleti_Check_Bonifica toTest = new OF_PNI_GIS_Obsoleti_Check_Bonifica();
    toTest.run(listaBEV);
    Test.stopTest();
  }

}