@isTest
public class OF_CreazioneAssetTest {
  @testSetup
  static void createData()
  {
       /**Creazione Account**/
        List<Account> listAccount = new List<Account>();
        listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO(); 
        /**Creazione Servizi**/
        List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
        listServizi = OF_AreaGeograficaUtilityTest.createServizi();
        /****Creazione Contratti****/
        Map<ID,String> mapAcc = new Map<ID,String>();
        List<Contract> listContract = new List<Contract>();
        OF_AreaGeograficaUtilityTest.getMappa(listAccount);//getMappa
        listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
       /**Creazione Associazione Contratti-Servizi**/
        List<OF_ContrattoServizio__c> listContrServ = new List<OF_ContrattoServizio__c>();
        listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract,listServizi,mapAcc);
        
        /**Creazione Listini**/
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();
        List<OF_ServizioBillingElement__c> listServiziBillingElement = new List<OF_ServizioBillingElement__c>();
        
        listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = OF_AreaGeograficaUtilityTest.createBillingElement(listCommercial);
        listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
        OF_AreaGeograficaUtilityTest.createListini(listServiziBillingElement);
   		
      	//Creazione custom setting configurazione
        OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting1();
  }
  static testmethod void MyUnitTest1()
  {
      Account acc = [select id from account limit 1];
      OF_Servizio__c serv = [select id from of_servizio__c where name = 'GPON Passiva'];
      OF_ContrattoServizio__c contServ = [select id,OF_Contract__c,OF_Servizio__c 
                                          from OF_ContrattoServizio__c 
                                          where OF_Servizio__c =: serv.Id limit 1];
      
      List<Contract> contr = [select id,StartDate,AccountId from contract where id =: contServ.OF_Contract__c];

      
      List<Product2> listProduct2 = [select id,OF_ListinoCustom__c,Name from product2 /*where OF_ListinoCustom__c in ('a0Q4E000001VYcLUAW', 'a0Q4E000001VYcOUAW','a0Q4E000001VYcRUAW')*/];
      OF_AreaGeograficaUtilityTest.createPriceBookStandard(listProduct2);
     
      system.debug('OS20 MyUnitTest1 listProduct2 ->'+listProduct2);
      
      Recordtype rectINORDER = [select id,name from recordtype where sobjecttype = 'Order' AND Name = 'INORDER'];
      Recordtype rectOUTORDER = [select id,name from recordtype where sobjecttype = 'Order' AND Name = 'OUTORDER'];
      
      Order ordine1 = new Order();
      Order ordine2 = new Order();
      Order ordine3 = new Order();
      
      ordine1.RecordTypeId = rectINORDER.Id;
      ordine2.RecordTypeId = rectOUTORDER.Id;
      ordine3.RecordTypeId = rectINORDER.Id;
      
      system.debug('contr.StartDate : '+contr[0].StartDate);
      ordine1.EffectiveDate = Date.newInstance(2016,1,1);
      ordine1.Status = 'Aperto';
      ordine1.AccountId = acc.Id;
      ordine1.Name ='test1';
      ordine1.OF_IDRisorsa__c = '12er';
      ordine1.OF_EsitoConsegnaApparato__c = 'Ribaltamento Impianto';
      
      system.debug('contr.StartDate : '+contr[0].StartDate);
      ordine2.EffectiveDate = Date.newInstance(2016,1,1);
      ordine2.Status = 'Aperto';
      ordine2.AccountId = acc.Id;
      ordine2.Name ='test2';
      ordine2.OF_IDRisorsa__c = '12erd';
      ordine2.OF_EsitoConsegnaApparato__c = 'Ribaltamento Impianto';
  
      system.debug('contr.StartDate : '+contr[0].StartDate);
      ordine3.EffectiveDate = Date.newInstance(2016,1,1);
      ordine3.Status = 'Aperto';
      ordine3.AccountId = acc.Id;
      ordine3.Name ='test3';
      ordine3.OF_IDRisorsa__c = '12erdf';
      ordine3.OF_EsitoConsegnaApparato__c = 'Installazione CPE';
  
      insert ordine1;
      insert ordine2;
      insert ordine3;
      
      ordine1.ContractId = contServ.OF_Contract__c;
      system.debug('OS04 OF_Contract__c : '+ordine1.ContractId);
      ordine1.Status = 'Chiuso';
      ordine1.OF_Esito__c = 'OK';
      ordine1.OF_SlaPremiumAssurance__c = 'Y';
    //  ordine2.OF_Type__c = 'INORDER';
      ordine1.Name = 'Test2';
      ordine1.OF_IDRisorsa__c  = '1234';
      update ordine1;
      
      /**Test aggiuntivi per coprire OF_UtilitiesCreazioneAsset**/
      List<Order> listOrder = new List<Order>();
      Map<String,ID> mpx = new Map<String,ID>();
      Map<String,order> mpx2 = new Map<String,order>();
      Map<ID,List<Order>> mpx1 = new Map<ID,List<Order>>();
      
      listOrder.add(ordine1);
      mpx.put(ordine1.OF_IDRisorsa__c,ordine1.Id);
      mpx1.put(contr[0].Id,listOrder);
      mpx2.put(ordine1.OF_IDRisorsa__c,ordine1);
      List<Asset> listAsset = OF_UtilitiesCreazioneAsset.CreazioneAsset(contr,mpx1);
      
      //OF_UtilitiesCreazioneAsset.AggiornamentoDisattivazioneBE(listAsset,mpx);
      //DG modificato 07-04-2017 E'stata modificato il trigger OF_CreazioneAsset
      OF_UtilitiesCreazioneAsset.AggiornamentoDisattivazioneBE(listAsset,mpx2);
      OF_UtilitiesCreazioneAsset.getControlli2('N');
      OF_UtilitiesCreazioneAsset.getControlli2('Y');
      OF_UtilitiesCreazioneAsset.getControlli2(NULL);
      
      OF_UtilitiesCreazioneAsset.AggiornamentoAsset(NULL,NULL);
      OF_UtilitiesCreazioneAsset.AggiornamentoAsset(listAsset,mpx2);

      
  }
}