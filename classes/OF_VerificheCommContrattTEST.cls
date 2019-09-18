@isTest
public class OF_VerificheCommContrattTEST {
// 	@testSetup
//     static void createData()
//     {        
//         /**Creazione Catalogo commerciale**/
//         List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
//         List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
//         List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();
        
//         listServizi = OF_AreaGeograficaUtilityTest.createServizi();
//         listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
//         listBillingElement = OF_AreaGeograficaUtilityTest.createBillingElement(listCommercial);
        
// 		/**Creazione custom setting**/
// 		list<OF_CaseOrderStateModelCS__c> CustSett = new list<OF_CaseOrderStateModelCS__c>();
// 		CustSett = OF_AreaGeograficaUtilityTest.CustomSetting();
//     }

    public static testmethod void t1() {
        Test.startTest();
        new OF_VerificheCommContratt();
        Test.stopTest();
    }
//     static testmethod void Metodo1()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     //String CaseRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        
// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloWIND.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Attivo';
// 	insert contr;
	
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Passiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s.Id;
//     insert AGJ;
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	//c.recordtypeid = CaseRecordTypeId;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.today();
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
    
// 	/**Errore sul contratto non attivo**/
//     static testmethod void Metodo2()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     //String CaseRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();

// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloWIND.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Non Attivo';
// 	insert contr;
	
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Passiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s.Id;
//     insert AGJ;
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	//c.recordtypeid = CaseRecordTypeId;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.today();
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
	
// 	/**Errore sulla data di attivazione**/
// 	static testmethod void Metodo3()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     //String CaseRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();

// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloWIND.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Attivo';
// 	insert contr;
	
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Passiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s.Id;
//     insert AGJ;
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	//c.recordtypeid = CaseRecordTypeId;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.newInstance(2200,01,01);
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
	
// 	/**Errore sul servizio**/
// 	static testmethod void Metodo4()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     //String CaseRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();

// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloWIND.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Attivo';
// 	insert contr;
	
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Attiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s.Id;
//     insert AGJ;
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	//c.recordtypeid = CaseRecordTypeId;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.today();
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
	
//     /**Errore sull'area geografica junction**/
// 	static testmethod void Metodo5()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
//   	Account accOloVF = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     //String CaseRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();

// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
//     accOloVF.Name = 'Vodafone';
// 	accOloVF.EOF_Codice_Operatore__c = 'VF';
// 	accOloVF.Type = 'OLO';
// 	accOloVF.Industry = 'Telecommunications';
// 	accOloVF.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloVF;
        
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloVF.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Attivo';
// 	insert contr;
	
//     Contract contr1 = new Contract();
// 	contr1.AccountId = accOloWIND.Id;
// 	contr1.OF_IdContratto__c = '14';
// 	contr1.StartDate = System.today();
// 	contr1.ContractTerm = 3;
// 	contr1.Status = 'Attivo';
// 	insert contr1;
        
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Passiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s.Id;
//     //insert AGJ;
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	//c.recordtypeid = CaseRecordTypeId;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.today();
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
    
//     /**Trouble ticket**/
// 	static testmethod void Metodo6()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     String CaseTTRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
        
// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloWIND.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Attivo';
// 	insert contr;
	
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Passiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s.Id;
//     insert AGJ;
    
//     //Asset
//     asset ass = new asset();
//     ass.name = 'asset';
//     ass.AccountId = accOloWIND.Id;
//     ass.Status = 'Attivo';
//     insert ass;    
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
//     c.RecordTypeId = CaseTTRecordTypeId;
//     c.AssetId = ass.Id;
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.today();
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
	
// 	/**Verifiche su comune fallite**/
// 	static testmethod void Metodo7()
//     {	
// 	//Account
// 	Account accOloWIND = new Account();
        
// 	String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
//     //String CaseRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();

// 	accOloWIND.Name = 'Wind';
// 	accOloWIND.EOF_Codice_Operatore__c = 'WN';
// 	accOloWIND.Type = 'OLO';
// 	accOloWIND.Industry = 'Telecommunications';
// 	accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
// 	insert accOloWIND;
	
// 	//Contract
// 	Contract contr = new Contract();
// 	contr.AccountId = accOloWIND.Id;
// 	contr.OF_IdContratto__c = '14';
// 	contr.StartDate = System.today();
// 	contr.ContractTerm = 3;
// 	contr.Status = 'Attivo';
// 	insert contr;
	
//     //Contratto servizio   
//     OF_Servizio__c s = [select id from OF_Servizio__c where name = 'GPON Passiva' limit 1];
//     OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
//     cs.OF_Contract__c = contr.Id;
//     cs.OF_Servizio__c = s.Id;
//     insert cs;
	
// 	OF_Servizio__c s1 = [select id from OF_Servizio__c where name = 'GPON Attiva' limit 1];
//     OF_ContrattoServizio__c cs1 = new OF_ContrattoServizio__c();
//     cs1.OF_Contract__c = contr.Id;
//     cs1.OF_Servizio__c = s1.Id;
//     insert cs1;
    
//     //Area geografica custom
//     OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
//     AreaGeoCustom.OF_Comune__c = 'Milano';
//     AreaGeoCustom.OF_Istat__c = '20141';
//     insert AreaGeoCustom;
        
//     //Area geografica junction
//     OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
//     AGJ.OF_Contratto__c = contr.Id;
//     AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
//     AGJ.Servizio__c = s1.Id;
//     insert AGJ;
    
//     //Asset
//     asset ass = new asset();
//     ass.name = 'asset';
//     ass.AccountId = accOloWIND.Id;
//     ass.Status = 'Attivo';
//     insert ass;    
        
// 	//Case
// 	case c = new case();
// 	c.status = 'Ricevuto';
// 	c.EOF_Fase__c = 'NA';
//     c.AssetId = ass.Id;
// 	c.EOF_Account_OLO__c = accOloWIND.id;
// 	//c.recordtypeid = CaseRecordTypeId;
// 	c.EOF_Codice_Ordine_OLO__c = 'OLO0001';
// 	c.EOF_Tipologia_Servizio__c = '1';
// 	c.EOF_Order_Manager__c = true;
// 	c.EOF_ID_Building_WS__c = '123456789';
// 	c.EOF_Identificativo_del_POP__c = 'PG_01';
// 	c.EOF_Data_Prevista_Attivazione__c = Date.today();
// 	insert c;
// 	OF_AreaGeograficaUtilityTest.createNotify(c);
// 	OF_AreaGeograficaUtilityTest.createNetworkInventory(c);
	
// 	//Aggiorno lo stato per far partire il trigger
// 	c.Status = 'Acquisito';
// 	update c;   
//     }
}