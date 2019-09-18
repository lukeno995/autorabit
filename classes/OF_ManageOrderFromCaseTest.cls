@isTest

public class OF_ManageOrderFromCaseTest{

 

    public static testmethod void OF_ManageOrderFromCaseMethod(){
    
   
    
        //Creazione Account
        List<Account> listAccount = new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        listAccount.add(a);
        listAccount.add(a1);
        
        insert listaccount;
        
        //listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO(); 
        
        //Creazione Catalogo commerciale
        List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();
        
        listServizi = OF_AreaGeograficaUtilityTest.createServizi();
        listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
        listBillingElement = OF_AreaGeograficaUtilityTest.createBillingElement(listCommercial);
        
        //Creazione Contratti
        Map<ID,String> mapAcc = new Map<ID,String>();
        List<Contract> listContract = new List<Contract>();
        OF_AreaGeograficaUtilityTest.getMappa(listAccount);//getMappa
        listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
        OF_AreaGeograficaUtilityTest.createAreaGeoJunction(listContract, listServizi);
        
        //Creazione Associazione Contratti-Servizi
        List<OF_ContrattoServizio__c> listContrServ = new List<OF_ContrattoServizio__c>();
        listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract,listServizi,mapAcc);
        
        //Creazione Listini
        List<OF_ServizioBillingElement__c> listServiziBillingElement = new List<OF_ServizioBillingElement__c>();
        listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
        
        //Creazione custom setting
        list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
        CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();
        OF_Configurazioni__c CustSett1 = new OF_Configurazioni__c();
        CustSett1 = OF_AreaGeograficaUtilityTest.CustomSetting1();
        
    }
    
    static Map<String,String> RecordType()
    { 
        //Record Type case
        List<RecordType> rtypes = [Select Name, Id From RecordType where (sObjectType='Case' OR sObjectType='Asset')  and isActive=true];
        
        Map<String,String> RecordType = new Map<String,String>{};
    
    for(RecordType rt: rtypes)
        RecordType.put(rt.Name,rt.Id);
                
       return RecordType;
    }
    /*****GPON PASSIVA*****/
    //Questo metodo testa il Trigger OF_ManageOrderFromCase stato case = acquisito
    static testmethod void AttivazioneCreazioneOrdine()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
                
      List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        
        case c = new case();
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.status = 'Acquisito KO';
        c.OF_Order__c = null;
        c.EOF_Fase__c = 'NA';
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_ID_Building_WS__c = '123456789';
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Acquisito';
        update c;   
    }
    
    //Questo metodo testa il Trigger OF_ManageOrderFromCase stato case = Acquisito KO per controlli sul case
    static testmethod void AttivazioneCreazioneOrdineKO()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.status = 'Acquisito';
        c.OF_Order__c = null;
        c.EOF_Fase__c = 'NA';
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_ID_Building_WS__c = '123456789';
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Acquisito KO';
        update c;
        
    }
    
    //Questo metodo testa il Trigger OF_ManageOrderFromCase in caso di cessazione
    static testmethod void CessazioneCreazioneOrdine()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Ricevuto';
         
        c.OF_Order__c = null;
        c.subject = 'Richiesta di cessazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Cessazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);

        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Acquisito';
        update c;
        
    }
    
    
    //Questo metodo testa il Trigger OF_ManageOrderFromCase in caso di aggiornamento
    static testmethod void AggiornamentoOrdine()
    {  

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
     List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
    
    
            
   
        Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('OUTORDER').getRecordTypeId(); 
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
       
        case c = new case();
        c.status = 'Acquisito';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Causale_Richiesta_Annullamento__c = 'Annullamento';
        c.EOF_Codice_Richiesta_Annullamento__c = 'AK1';
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        
        asset ass = new asset();
        ass.Name = 'Test';
        ass.AccountId = accList[0].id;
       // insert ass;
        contract cont1=new contract();
        cont1.accountID=accList[0].id;
        cont1.name='test';
        insert cont1;
        order ord = [select id, OF_Asset__c from order where OF_CaseID__c =: c.id];
        ord.OF_Asset__c = ass.id;
        ord.ContractId=cont1.id;
        ord.RecordTypeId = rId1;
        
        update ord;
        
        c.Status = 'Espletato';
        update c;   
    }
    
    
    //Questo metodo testa il Trigger OF_ManageOrderFromCase in caso di aggiornamento 
    //In questo caso EOF_Causale_Richiesta_Annullamento__c e EOF_Codice_Richiesta_Annullamento__c sono vuoti
    static testmethod void AggiornamentoOrdine1()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
       List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Espletato';
        update c;
    }
    
    
    //Questo metodo testa il Trigger OF_ManageOrderFromCase per il trouble ticket
    static testmethod void CaseTroubleTicket()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
       List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.RecordTypeId = RecordTypeMap.get('Trouble Ticket');
        c.Status = 'Acquisito KO';
        c.OF_Order__c = null;
        c.EOF_Fase__c = 'NA';
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_ID_Building_WS__c = '123456789';
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        insert c;
        
        asset ass = new asset();
        ass.AccountId = c.EOF_Account_OLO__c;
        ass.RecordTypeId = RecordTypeMap.get('GPON Passiva');
        ass.EOF_ID_Risorsa__c = 'risorsa';
        ass.Name = 'risorsa';
        
       // insert ass;
        
        c.AssetId = ass.Id;
        
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Acquisito';
        update c;
    }
    
    /*****PORTALINO*****/
    //Questo metodo testa il Trigger OF_ManageOrderFromCase stato case = acquisito
    static testmethod void CreazioneOrdinePortalino()
    {   
        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
        case c = new case();
        c.RecordTypeId = RecordTypeMap.get('PO Collegamento P2P');
        c.Status = 'Cessato KO';
        c.OF_Order__c = null;
        c.AccountId = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        insert c; 
        
        
        
        opportunity opp = new opportunity();
        opp.StageName = 'Offerta accettata';
        opp.AccountId = accList[0].id;
        opp.Name = 'Offerta Collegamento';
        opp.PO_Collegamento__c = c.id;
        opp.CloseDate = Date.newInstance(2020,1,1);
        insert opp;
      
        
        
        try
        {
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.ManageOrder(c);
        OFMS.AggiornoOrdine(c);
        String recname = 'OF_OUTORDER';
        OFMS.creazioneOrdine(c,recname);
        }
        catch(exception e ){
            system.debug('error==='+e.getStackTraceString());
        }
    }
    
    static testmethod void CreazioneOrdinePortalino1()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        

        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
        case c = new case();
        c.RecordTypeId = RecordTypeMap.get('PO Collegamento P2P');
         c.Status = 'Acquisito KO';
        c.OF_Order__c = null;
        c.AccountId = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        insert c; 
        
        
        
        opportunity opp = new opportunity();
        opp.StageName = 'Offerta accettata';
        opp.AccountId = accList[0].id;
        opp.Name = 'Offerta Collegamento';
        opp.PO_Collegamento__c = c.id;
        opp.CloseDate = Date.newInstance(2020,1,1);
        insert opp;
      
        try
        {
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.ManageOrder(c);
        String recname = 'OF_OUTORDER';
        OFMS.creazioneOrdine(c,recname);
        }
        catch(exception e ){
            system.debug('error==='+e.getStackTraceString());
        }
            }
    
    static testmethod void CreazioneOrdinePortalino2()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        


        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        
        //Record Type case
        Map<String,String> RecordTypeMap = RecordType();
        
        case c = new case();
        c.RecordTypeId = RecordTypeMap.get('PO Collegamento P2P');
        c.Status = 'Acquisito';
        c.OF_Order__c = null;
        c.AccountId = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
        c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        insert c; 
        
        
        
        opportunity opp = new opportunity();
        opp.StageName = 'Offerta accettata';
        opp.AccountId = accList[0].id;
        opp.Name = 'Offerta Collegamento';
        opp.PO_Collegamento__c = c.id;
        opp.CloseDate = Date.newInstance(2020,1,1);
        insert opp;
      
        case c1 = new case();
        c1.RecordTypeId = RecordTypeMap.get('PO Ordine P2P');
        c1.status = 'Accettato';
        c1.OF_Order__c = null;
        c1.AccountId = accList[0].id;
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0001x';
        c1.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2020,1,1);
        c1.PO_Case_Collegamento__c = c.id;
        insert c1;  
        
        //Catch del trigger
        case c2 = new case();
        c2.RecordTypeId = RecordTypeMap.get('PO Ordine P2P');
        c2.status = 'Accettato';
        c2.PO_Case_Collegamento__c = c.id;
        insert c2;  
        try
        {
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.ManageOrder(c);
        String recname = 'OF_OUTORDER';
        OFMS.creazioneOrdine(c,recname);
        }
        catch(exception e ){
            system.debug('error==='+e.getStackTraceString());
        }
        //OFMS.AggiornoOrdine(c,'test');
        //OFMS.GestioneServiziAttiviAttivazione(c,'test');
        //OFMS.GestioneServiziAttiviCessazione(c,'test');
    }
    
    /*  static testmethod void CreazioneOrdinePortalino3()
    {   


        Map<String,String> RecordTypeMap = RecordType();
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        



        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Espletato';
        update c;
        
        
        
        
        
        opportunity opp = new opportunity();
        opp.StageName = 'Offerta accettata';
        opp.AccountId = accList[0].id;
        opp.Name = 'Offerta Collegamento';
        opp.PO_Collegamento__c = c.id;
        opp.CloseDate = Date.newInstance(2020,1,1);
        insert opp;
      
       
        
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }
    */
 /*   static testmethod void CreazioneOrdinePortalino9()
    {   

        Map<String,String> RecordTypeMap = RecordType();
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        



        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Espletato';
        update c;
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }*/
    
    static testmethod void CreazioneOrdinePortalino4()
    {   

        Map<String,String> RecordTypeMap = RecordType();
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        



        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
         c.Status = 'Espletato KO';
        update c;
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }
    static testmethod void CreazioneOrdinePortalino5()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        


        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Annullato';
        update c;
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }
    static testmethod void CreazioneOrdinePortalino6()
    {   

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        


        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Accettato KO';
        update c;
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }
  /* static testmethod void CreazioneOrdinePortalino7()
    {   

        Map<String,String> RecordTypeMap = RecordType();
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        


        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Servizio__c = 'GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Cessato';
        update c;
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }*/
  /*  static testmethod void CreazioneOrdinePortalino8()
    {   

        Map<String,String> RecordTypeMap = RecordType();
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        


        List<Account> accList= new List<Account>();
        Account a = new Account(name = 'test');
        Account a1 = new Account (name = 'test1');
        accList.add(a);
        accList.add(a1);
        
        insert accList;
        case c = new case();
        c.status = 'Accettato';
        c.OF_Servizio__c = 'Open Stream';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
        c.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        insert c;
        OF_AreaGeograficaUtilityTest.createNotify(c);
        OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
        OF_AreaGeograficaUtilityTest.OrderToCase(c);
        //Aggiorno lo stato per far partire il trigger
        c.Status = 'Cessato OK';
        update c;
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        OFMS.AggiornoOrdine(c);
        
        
        
    }
    */
    
    static testmethod void CreazioneOrdinePortalino10()
    {   
                
     Map<String,String> RecordTypeMap = RecordType();
     Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('OUTORDER').getRecordTypeId(); 


        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
        Account acc = new Account(name = 'test',type='OLO');
       
       
        insert acc;
          contract cont1=new contract();
        cont1.accountID=acc.id;
        cont1.name='test';
        insert cont1;
        case c1 = new case();
        c1.status = 'Acquisito KO';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002t';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = acc.id;
        
        insert c1;
        
          case c = new case();
        c.status = 'Acquisito KO';
        c.OF_Servizio__c = 'Open Stream';
       // c1.OF_IDContratto__c='test';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002y';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = acc.id;
        
        insert c;
       // OF_AreaGeograficaUtilityTest.createNotify(c1);
       // OF_AreaGeograficaUtilityTest.createNetworkInventory(c1);
        //OF_AreaGeograficaUtilityTest.OrderToCase(c1);
        //Aggiorno lo stato per far partire il trigger
       // c.Status = 'Cessato OK';
      //  update c;
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        //ofc.OF_ServiziExtraOperazione__c= true;
        insert ofc;
       account acct = new account();
        acct.name = 'Test';
        insert acct;
        
         
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= acc.id;
        insert cont;
        
        asset ass = new asset();
        ass.Name = 'Test';
       // ass.OF_Case__c = c1.Id;
    //   ass.recordtypeid = [select id from recordtype where developername ='OF_InterventoAVuoto'].id;
        
        ass.OF_case__c = c1.id;
        ass.AccountId = acc.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
      
        order ord = new Order();
        ord.OF_CaseID__c =c1.id;
        ord.Name='test';
        ord.AccountID=acct.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        
        insert ord;
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
        //OFMS.GestioneServiziAttiviCessazione(c1,ord);
        OFMS.creazioneOrdine(C,'OF_INORDER');
        c.status='Cessato KO';
        update c;
         OFMS.creazioneOrdine(C,'OF_OUTORDER');
         c.status='Acquisito';
        update c;
        OFMS.creazioneOrdine(C,'OF_INORDER');
        // OFMS.TipoServ(c);
       
        
    }
    
    static testmethod void CreazioneOrdinePortalino11()
    {
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
        
    Map<String,String> RecordTypeMap = RecordType();
     Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('OUTORDER').getRecordTypeId(); 
        
        
        Account acc = new Account(name = 'test',type='OLO');
       
       
        insert acc;
          contract cont1=new contract();
        cont1.accountID=acc.id;
        cont1.name='test';
        insert cont1;
        case c1 = new case();
        c1.status = 'Acquisito KO';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002i';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = acc.id;
        
        insert c1;
        
          case c = new case();
        c.status = 'Acquisito KO';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Cessazione');
        c.OF_Servizio__c = 'Open Stream';
       // c1.OF_IDContratto__c='test';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF_Caso_Attivazione_OPENSTREAM');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002o';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = acc.id;
        
        insert c;
       // OF_AreaGeograficaUtilityTest.createNotify(c1);
       // OF_AreaGeograficaUtilityTest.createNetworkInventory(c1);
        //OF_AreaGeograficaUtilityTest.OrderToCase(c1);
        //Aggiorno lo stato per far partire il trigger
       // c.Status = 'Cessato OK';
      //  update c;
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        //ofc.OF_ServiziExtraOperazione__c= true;
        insert ofc;
       account acct = new account();
        acct.name = 'Test';
        insert acct;
        
         
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= acc.id;
        insert cont;
        
        asset ass = new asset();
        ass.Name = 'Test';
       // ass.OF_Case__c = c1.Id;
    //   ass.recordtypeid = [select id from recordtype where developername ='OF_InterventoAVuoto'].id;
        
        ass.OF_case__c = c1.id;
        ass.AccountId = acc.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
      
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=acct.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        
        insert ord;
       
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
       OFMS.manageOrder(c);
       c.status='Espletato';
       c.OF_Order__c=ord.id;
       update c;
        OFMS.manageOrder(c);
        
    }
    
    /* static testmethod void CreazioneOrdinePortalino12()
    {
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
        
    Map<String,String> RecordTypeMap = RecordType();
     Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('OUTORDER').getRecordTypeId(); 
        
        
        Account acc = new Account(name = 'test',type='OLO');
       
       
        insert acc;
          contract cont1=new contract();
        cont1.accountID=acc.id;
        cont1.name='test';
        insert cont1;
        case c1 = new case();
        c1.status = 'Cessato KO';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002q';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = acc.id;
        
        insert c1;
        
          case c = new case();
        c.status = 'Cessato KO';
       c.RecordTypeId = RecordTypeMap.get('EOF Caso - Cessazione');
        c.OF_Servizio__c = 'Open Stream';
       // c1.OF_IDContratto__c='test';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002w';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = acc.id;
        
        insert c;
       // OF_AreaGeograficaUtilityTest.createNotify(c1);
       // OF_AreaGeograficaUtilityTest.createNetworkInventory(c1);
        //OF_AreaGeograficaUtilityTest.OrderToCase(c1);
        //Aggiorno lo stato per far partire il trigger
       // c.Status = 'Cessato OK';
      //  update c;
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        //ofc.OF_ServiziExtraOperazione__c= true;
        insert ofc;
       account acct = new account();
        acct.name = 'Test';
        insert acct;
        
         
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= acc.id;
        insert cont;
        
        asset ass = new asset();
        ass.Name = 'Test';
       // ass.OF_Case__c = c1.Id;
    //   ass.recordtypeid = [select id from recordtype where developername ='OF_InterventoAVuoto'].id;
        
        ass.OF_case__c = c1.id;
        ass.AccountId = acc.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
      
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=acct.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        
        insert ord;
       
        
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
       OFMS.manageOrder(c);
       c.status='Espletato';
       c.OF_Order__c=ord.id;
       update c;
        OFMS.manageOrder(c);
        
    } */
    
       static testmethod void CreazioneOrdinePortalino13()
    {
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        
    Map<String,String> RecordTypeMap = RecordType();
     Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('INORDER').getRecordTypeId(); 
        
        
        Account acc = new Account(name = 'test',type='OLO');
       
       
        insert acc;
          contract cont1=new contract();
        cont1.accountID=acc.id;
        cont1.name='test';
        insert cont1;
        case c1 = new case();
        c1.status = 'Acquisito KO';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002e';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = acc.id;
        
        insert c1;
        
          case c = new case();
        c.status = 'Acquisito KO';
        c.OF_Servizio__c = 'Acquisito';
       // c1.OF_IDContratto__c='test';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Cessazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002r';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = acc.id;
        
        insert c;
       // OF_AreaGeograficaUtilityTest.createNotify(c1);
       // OF_AreaGeograficaUtilityTest.createNetworkInventory(c1);
        //OF_AreaGeograficaUtilityTest.OrderToCase(c1);
        //Aggiorno lo stato per far partire il trigger
       // c.Status = 'Cessato OK';
      //  update c;
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        //ofc.OF_ServiziExtraOperazione__c= true;
        insert ofc;
       account acct = new account();
        acct.name = 'Test';
        insert acct;
        
         
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= acc.id;
        insert cont;
        
        asset ass = new asset();
        ass.Name = 'Test';
       // ass.OF_Case__c = c1.Id;
    //   ass.recordtypeid = [select id from recordtype where developername ='OF_InterventoAVuoto'].id;
        
        ass.OF_case__c = c1.id;
        ass.AccountId = acc.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
      
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=acc.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        ord.contractId=cont1.id;
        
        insert ord;
       ord=[select id,RecordtypeID,RecordType.developerName from Order where id=:ord.id];
        c=[select id,RecordTypeId,Status,OF_Order__c,EOF_Account_OLO__c from Case where id=:c.id];
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
       OFMS.manageOrder(c);
       //OFMS.GestioneServiziPassiviAttivazione(c,ord);
    
        
    }
   
   
    static testmethod void CreazioneOrdinePortalino14()
    {   
    Map<String,String> RecordTypeMap = RecordType();
     Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('INORDER').getRecordTypeId(); 

        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        

        
        
        Account acc = new Account(name = 'test',type='OLO');
       
       
        insert acc;
          contract cont1=new contract();
        cont1.accountID=acc.id;
        cont1.name='test';
        insert cont1;
        case c1 = new case();
        c1.status = 'Cessato';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        //c.RecordTypeId = RecordTypeMap.get('EOF Caso - Attivazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002y';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = acc.id;
        
        insert c1;
        
          case c = new case();
        c.status = 'Acquisito KO';
        c.OF_Servizio__c = 'Acquisito';
       // c1.OF_IDContratto__c='test';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di attivazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = RecordTypeMap.get('EOF Caso - Cessazione');
       // c1.EOF_Account_OLO__c = accList[0].id;
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002u';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = acc.id;
        
        insert c;
       // OF_AreaGeograficaUtilityTest.createNotify(c1);
       // OF_AreaGeograficaUtilityTest.createNetworkInventory(c1);
        //OF_AreaGeograficaUtilityTest.OrderToCase(c1);
        //Aggiorno lo stato per far partire il trigger
       // c.Status = 'Cessato OK';
      //  update c;
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        //ofc.OF_ServiziExtraOperazione__c= true;
        insert ofc;
       account acct = new account();
        acct.name = 'Test';
        insert acct;
        
         
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= acc.id;
        insert cont;
        
        asset ass = new asset();
        ass.Name = 'Test';
       // ass.OF_Case__c = c1.Id;
    //   ass.recordtypeid = [select id from recordtype where developername ='OF_InterventoAVuoto'].id;
        
        ass.OF_case__c = c1.id;
        ass.AccountId = acc.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
      
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=acc.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        ord.contractId=cont1.id;
        
        insert ord;
       ord=[select id,RecordtypeID,RecordType.developerName from Order where id=:ord.id];
        c=[select id,RecordTypeId,Status,OF_Order__c,EOF_Account_OLO__c from Case where id=:c.id];
        
     
        OF_ManageOrderFromCase OFMS = new OF_ManageOrderFromCase ();
       //OFMS.GestioneServiziPassiviAttivazione(c,ord);
       String recname = 'OF_OUTORDER';
       // OFMS.CopiaInfoCaseOrder(c,recname);
    
        
    }
    
    public static testmethod void test1(){
        
		map<String,String> rtMap=new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }
        
        Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('INORDER').getRecordTypeId(); 
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
        
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;
        
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        insert ofc;
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO') ;
        
        insert accOLO;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= accOLO.id;
        insert cont;
        
        contract cont1=new contract();
        cont1.accountID=accOLO.id;
        cont1.name='test';
        insert cont1;        
               
        case c1 = new case();
        c1.status = 'Cessato';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002y';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = accOLO.id;
        c1.RecordTypeId = rtMap.get('EOF_Caso_Attivazione');
        
        insert c1;
        
        case c = new case();
        c.status = 'Acquisito KO';
        c.OF_Servizio__c = 'Acquisito';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di Cessazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = rtMap.get('EOF_Caso_Cessazione');
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002u';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = accOLO.id;
        
        insert c;

        asset ass = new asset();
        ass.Name = 'Test';        
        ass.OF_case__c = c1.id;
        ass.AccountId = accOLO.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
        
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=accOLO.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        ord.contractId=cont1.id;
        //ord.OF_TipologiaDiServizio__c ='Passivo';
        
        insert ord;
        
        test.startTest();
        
        OF_ManageOrderFromCase mfc = new OF_ManageOrderFromCase();
        //mfc.GestioneServiziPassiviCessazione(c,ord,1);
        
        test.stopTest();
        
    }

    public static testmethod void test2(){
        
		map<String,String> rtMap=new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }
        
        Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('INORDER').getRecordTypeId(); 
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
        
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;
        
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        insert ofc;
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO') ;
        
        insert accOLO;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= accOLO.id;
        insert cont;
        
        contract cont1=new contract();
        cont1.accountID=accOLO.id;
        cont1.name='test';
        insert cont1;        
               
        case c1 = new case();
        c1.status = 'Cessato';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002y';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = accOLO.id;
        c1.RecordTypeId = rtMap.get('EOF_Caso_Attivazione');
        
        insert c1;
        
        case c = new case();
        c.status = 'Acquisito KO';
        c.OF_Servizio__c = 'Acquisito';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di Cessazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = rtMap.get('EOF_Caso_Cessazione');
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002u';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = accOLO.id;
        
        insert c;

        asset ass = new asset();
        ass.Name = 'Test';        
        ass.OF_case__c = c1.id;
        ass.AccountId = accOLO.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
        
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=accOLO.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Aperto';
        ord.contractId=cont1.id;
        ord.OF_TipologiaDiServizio__c ='Passivo';
        
        insert ord;
        
        test.startTest();
        
        OF_ManageOrderFromCase mfc = new OF_ManageOrderFromCase();
        //mfc.GestioneServiziPassiviCessazione(c,ord,1);
        
        test.stopTest();
        
    }

    public static testmethod void test3(){
        
		map<String,String> rtMap=new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }
        
        Schema.DescribeSObjectResult orderSchema = Schema.SObjectType.Order ; 
        Map<String,Schema.RecordTypeInfo> OrderRecordTypeInfo = orderSchema.getRecordTypeInfosByName(); 
        Id rId1 = OrderRecordTypeInfo.get('OUTORDER').getRecordTypeId();
        
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
        
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;
        
        OF_Configurazioni__c ofc = new OF_Configurazioni__c();
        ofc.Name='001';
        ofc.EOF_Attiva_Check_POP_OLO__c = true;
        ofc.EOF_Codice_Operatore_OLO__c= 'test';
        ofc.DataSwitchOM__c= System.today();
        ofc.OF_ServizioExtraName__c= 10;
        ofc.EOF_Pop_OM__c='test';
        insert ofc;
        
        account accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = rtMap.get('OLO') ;
        
        insert accOLO;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Accountid= accOLO.id;
        insert cont;
        
        contract cont1=new contract();
        cont1.accountID=accOLO.id;
        cont1.name='test';
        insert cont1;        
               
        case c1 = new case();
        c1.status = 'Cessato';
        c1.OF_Servizio__c = 'Open Stream';
        c1.OF_IDContratto__c=cont1.id;
        c1.OF_Servizio__c='GPON Passiva';
        c1.OF_Order__c = null;
        c1.subject = 'Richiesta di attivazione';
        c1.EOF_Fase__c = 'NA';
        c1.EOF_Codice_Ordine_OLO__c = 'OLO0002y';
        c1.EOF_Tipologia_Servizio__c = '1';
        c1.EOF_Order_Manager__c = true;
        c1.EOF_Identificativo_del_POP__c = 'PG_01';
        c1.EOF_Data_Prevista_Attivazione__c = Date.today();
        c1.OF_aggiornoOrdine__c = false;
        c1.EOF_Account_OLO__c = accOLO.id;
        c1.RecordTypeId = rtMap.get('EOF_Caso_Attivazione');
        
        insert c1;
        
        case c = new case();
        c.status = 'Acquisito KO';
        c.OF_Servizio__c = 'Acquisito';
        c.OF_Servizio__c='GPON Passiva';
        c.OF_Order__c = null;
        c.subject = 'Richiesta di Cessazione';
        c.EOF_Fase__c = 'NA';
        c.RecordTypeId = rtMap.get('EOF_Caso_Cessazione');
        c.EOF_Codice_Ordine_OLO__c = 'OLO0002u';
        c.EOF_Tipologia_Servizio__c = '1';
        c.EOF_Order_Manager__c = true;
        c.EOF_Identificativo_del_POP__c = 'PG_01';
        c.EOF_Data_Prevista_Attivazione__c = Date.today();
        c.OF_aggiornoOrdine__c = false;
        c.EOF_Account_OLO__c = accOLO.id;
        
        insert c;

        asset ass = new asset();
        ass.Name = 'Test';        
        ass.OF_case__c = c1.id;
        ass.AccountId = accOLO.id;
        ass.OF_ServizioRichiesto__c='GPON Passiva';
        ass.OF_TipoDiProcesso__c = 'Provisioning';
        ass.contactId=cont.id;
        insert ass;
        
        order ord = new Order();
        ord.OF_CaseID__c =c.id;
        ord.Name='test';
        ord.AccountID=accOLO.id;
        ord.OF_Asset__c = ass.id;
        ord.RecordTypeId = rId1;
        ord.EffectiveDate=system.today();
        ord.status='Chiuso';
        ord.contractId=cont1.id;
        //ord.OF_TipologiaDiServizio__c ='Passivo';
        ord.OF_Esito__c ='OK';        
        insert ord;
        
        test.startTest();
        
        OF_ManageOrderFromCase mfc = new OF_ManageOrderFromCase();
        //mfc.GestioneServiziPassiviCessazione(c,ord,0);
        
        test.stopTest();
        
    }    

}