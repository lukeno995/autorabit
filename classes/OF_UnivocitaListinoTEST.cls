@isTest
public class OF_UnivocitaListinoTEST {
    
    public static testmethod void t1() {
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
		Date inizio = Date.newInstance(2016,1,1);
		Date fine = Date.newInstance(2099,12,31);
		catalogo.name = 'Catalogo_Test';
		catalogo.OF_Attivo__c = true;
		catalogo.OF_DataInizioValidita__c = inizio;
		catalogo.OF_DataFineValidita__c = fine;
		insert catalogo;
		
		OF_Servizio__c servizio = new OF_Servizio__c();
		servizio.name = 'test';
		servizio.OF_Attivo__c = true;
		servizio.OF_DataInizioValidita__c = inizio;
		servizio.OF_DataFineValidita__c = fine;
		servizio.OF_CatalogoCommerciale__c = catalogo.id;
		servizio.OF_Servizio_Code__c = 'code';

		insert servizio;
		
		OF_Listino__c l = new OF_Listino__c();
		l.name = 'test';
		l.Servizio__c = servizio.Id;
		l.OF_Attivo__c = true;
		l.OF_ListinoDefault__c = true;
		l.OF_DataInizioValidita__c = inizio;
		l.OF_Attivo__c = true;
		l.OF_ListinoDefault__c = true;
		l.OF_DataFineValidita__c = fine;
		l.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Fattibilità' LIMIT 1].Id;

		insert l;
    }

//     /**Questo metodo crea i Dati da utilizzare nella Classe di Test**/
//     @testSetup
//     static void createData()
//     {
//       /**Creazione Account**/
//         List<Account> listAccount = new List<Account>();
//         listAccount = OF_AreaGeograficaUtilityTest.createAccountOLO(); 
//         /**Creazione Servizi**/
//         List<OF_Servizio__c> listServizi = new List<OF_Servizio__c>();
//         listServizi = OF_AreaGeograficaUtilityTest.createServizi();
//         /****Creazione Contratti****/
//         Map<ID,String> mapAcc = new Map<ID,String>();
//         List<Contract> listContract = new List<Contract>();
//         OF_AreaGeograficaUtilityTest.getMappa(listAccount);//getMappa
//         listContract = OF_AreaGeograficaUtilityTest.createContract(listAccount);
//         /**Creazione Associazione Contratti-Servizi**/
//         List<OF_ContrattoServizio__c> listContrServ = new List<OF_ContrattoServizio__c>();
//         listContrServ = OF_AreaGeograficaUtilityTest.createContractService(listContract,listServizi,mapAcc);
        
//         /**Creazione Listini**/
//         List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
//         List<OF_BillingElement__c> listBillingElement = new List<OF_BillingElement__c>();
//         List<OF_ServizioBillingElement__c> listServiziBillingElement = new List<OF_ServizioBillingElement__c>();
        
//         listCommercial=OF_AreaGeograficaUtilityTest.createCommercialElement(listServizi);
//         listBillingElement = createBillingElement(listCommercial);
//         listServiziBillingElement=OF_AreaGeograficaUtilityTest.createServiziBillingElement(listBillingElement,listContrServ);
//         //OF_AreaGeograficaUtilityTest.createListini(listServiziBillingElement);
//     }
    
//     public static list<OF_BillingElement__c> CreateBillingElement(List<OF_CommercialElement__c> listaCommercial)
// 	{	
// 		List<OF_BillingElement__c> listBilling =new List<OF_BillingElement__c>();
		
// 		for( OF_CommercialElement__c item : listaCommercial)
//         {
// 			OF_BillingElement__c billElem = new OF_BillingElement__c();
// 			billElem.name = 'Canone';
// 			billElem.OF_Attivo__c = true;
// 			billElem.OF_CommercialElement__c = item.Id;
// 			billElem.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
// 			billElem.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
// 			listBilling.add(billElem);
			
// 			OF_BillingElement__c billElem1 = new OF_BillingElement__c();
// 			billElem1.name = 'Contributo Attivazione';
// 			billElem1.OF_Attivo__c = true;
// 			billElem1.OF_CommercialElement__c = item.Id;
// 			billElem1.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
// 			billElem1.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
// 			listBilling.add(billElem1);
// 		}
		
// 		insert listBilling;
// 		return listBilling;
// 	}
    
    //  static testmethod void MetodoGPONPassiva1()
    //  {
    //      List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
    //                                                       FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

    //      List<RecordType> rtypes = [Select Name, Id From RecordType
    //               where sObjectType='OF_Listino__c' and isActive=true];
    //      Map<String,String> RecordTypes = new Map<String,String>{};
    //      for(RecordType rt: rtypes)
    //          RecordTypes.put(rt.Name,rt.Id);
        
    //      //Listino che va a buon fine
    //      OF_Listino__c listino1 = new OF_Listino__c();
    //      listino1.Name = 'Listino1';
    //      listino1.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
    //      listino1.OF_DataInizioValidita__c = Date.newInstance(2100,1,1);
    //      listino1.OF_DataFineValidita__c = Date.newInstance(2100,12,31);
    //      listino1.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
    //      listino1.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
    //      listino1.OF_ListinoDefault__c = true;
    //      listino1.OF_TipologiaApparato__c = 'Appa1';
    //      listino1.OF_ProgettoSpeciale__c = 'Prog1';
    //      try{
    //          insert listino1;
    //      }catch(Exception ex)
    //      {
    //          system.debug('ex1: '+ex);
    //      }
    //  }
	
// 	static testmethod void MetodoGPONPassiva2()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
// 		//Listino che va a buon fine
//         OF_Listino__c listino1 = new OF_Listino__c();
//         listino1.Name = 'Listino1';
//         listino1.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino1.OF_DataInizioValidita__c = Date.newInstance(2100,1,1);
//         listino1.OF_DataFineValidita__c = Date.newInstance(2100,12,31);
//         listino1.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino1.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino1.OF_ListinoDefault__c = true;
//         listino1.OF_TipologiaApparato__c = 'Appa1';
//         listino1.OF_ProgettoSpeciale__c = 'Prog1';
//         insert listino1;
		
//         //Listino che fallisce perchè ce ne è già uno di default in insert
//         OF_Listino__c listino3 = new OF_Listino__c();
//         listino3.Name = 'Listino1';
//         listino3.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino3.OF_DataInizioValidita__c = Date.newInstance(2101,1,1);
//         listino3.OF_DataFineValidita__c = Date.newInstance(2101,12,31);
//         listino3.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino3.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino3.OF_ListinoDefault__c = true;
//         listino3.OF_TipologiaApparato__c = 'Appa1';
//         listino3.OF_ProgettoSpeciale__c = 'Prog1';
//         try{
//             insert listino3;
//         }catch(Exception ex)
//         {
//             OF_Utility.logMessage(true,'L','ClassTest','MethodTest','ErrorMessageTest');
//             system.debug('ex3: '+ex);
//         }
//     }
	
// 	static testmethod void MetodoGPONPassiva3()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
// 		//Listino che va a buon fine
//         OF_Listino__c listino1 = new OF_Listino__c();
//         listino1.Name = 'Listino1';
//         listino1.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino1.OF_DataInizioValidita__c = Date.newInstance(2100,1,1);
//         listino1.OF_DataFineValidita__c = Date.newInstance(2100,12,31);
//         listino1.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino1.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino1.OF_ListinoDefault__c = true;
//         listino1.OF_TipologiaApparato__c = 'Appa1';
//         listino1.OF_ProgettoSpeciale__c = 'Prog1';
//         try{
//             insert listino1;
//         }catch(Exception ex)
//         {
//             system.debug('ex1: '+ex);
//         }
		
//         //Corretto
//         OF_Listino__c listino4 = new OF_Listino__c();
//         listino4.Name = 'Listino2';
//         listino4.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino4.OF_DataInizioValidita__c = Date.newInstance(2102,1,1);
//         listino4.OF_DataFineValidita__c = Date.newInstance(2102,12,31);
//         listino4.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino4.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino4.OF_ListinoDefault__c = false;
//         listino4.OF_TipologiaApparato__c = 'Appa2';
//         listino4.OF_ProgettoSpeciale__c = 'Prog1';
//         try{
//             insert listino4;
//         }catch(Exception ex)
//         {
//             system.debug('ex4: '+ex);
//         }
        
//         //Fallisce update per errore listino default
//         listino4.OF_ListinoDefault__c = true;
//         try{
//             update listino4;
//         }catch(Exception ex)
//         {
//             system.debug('exUp: '+ex);
//         }
//     }
	
// 	static testmethod void MetodoGPONPassiva4()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
// 		//Listino che va a buon fine
//         OF_Listino__c listino1 = new OF_Listino__c();
//         listino1.Name = 'Listino1';
//         listino1.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino1.OF_DataInizioValidita__c = Date.newInstance(2103,1,1);
//         listino1.OF_DataFineValidita__c = Date.newInstance(2103,12,31);
//         listino1.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino1.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino1.OF_ListinoDefault__c = false;
//         listino1.OF_TipologiaApparato__c = 'Appa2';
//         listino1.OF_ProgettoSpeciale__c = 'Prog1';
//         insert listino1;
		
//         //Fallisce per stessi dati
//         OF_Listino__c listino5 = new OF_Listino__c();
//         listino5.Name = 'Listino1';
//         listino5.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino5.OF_DataInizioValidita__c = Date.newInstance(2103,1,1);
//         listino5.OF_DataFineValidita__c = Date.newInstance(2103,12,31);
//         listino5.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino5.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino5.OF_ListinoDefault__c = false;
//         listino5.OF_TipologiaApparato__c = 'Appa2';
//         listino5.OF_ProgettoSpeciale__c = 'Prog1';
//         try{
//             insert listino5;
//         }catch(Exception ex)
//         {
//             system.debug('ex5: '+ex);
//         }
//     }
	
// 	static testmethod void MetodoGPONPassiva5()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
// 		//Listino che va a buon fine
//         OF_Listino__c listino1 = new OF_Listino__c();
//         listino1.Name = 'Listino1';
//         listino1.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino1.OF_DataInizioValidita__c = Date.newInstance(2103,1,1);
//         listino1.OF_DataFineValidita__c = Date.newInstance(2103,12,31);
//         listino1.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino1.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino1.OF_ListinoDefault__c = false;
//         listino1.OF_TipologiaApparato__c = 'Appa2';
//         listino1.OF_ProgettoSpeciale__c = 'Prog1';
//         insert listino1;
		
//         //Fallisce per date sovrapposte
//         OF_Listino__c listino6 = new OF_Listino__c();
//         listino6.Name = 'Listino2';
//         listino6.RecordTypeId = RecordTypes.get(listServBillPassivi[0].OF_ServizioNome__c);
//         listino6.OF_DataInizioValidita__c = Date.newInstance(2103,1,2);
//         listino6.OF_DataFineValidita__c = Date.newInstance(2103,12,30);
//         listino6.OF_ServizioBillingElement__c = listServBillPassivi[0].Id;
//         listino6.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino6.OF_ListinoDefault__c = false;
//         listino6.OF_TipologiaApparato__c = 'Appa2';
//         listino6.OF_ProgettoSpeciale__c = 'Prog1';
//         try{
//             insert listino6;
//         }catch(Exception ex)
//         {
//             system.debug('ex6: '+ex);
//         }
//     }   
    
//     static testmethod void MetodoOpenStream1()
//     {
//         List<OF_ServizioBillingElement__c> listServBillAttivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'Open Stream' and OF_BillingElement__r.name != 'Canone'];
        
//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
        
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         //Primo listino Servizi Attivi
//         OF_Listino__c listinoAtt = new OF_Listino__c();
//         listinoAtt.Name = 'Listino2';
//         listinoAtt.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt.OF_ListinoDefault__c = true;
//         listinoAtt.OF_TipologiaApparato__c = 'Appa1';
//         insert listinoAtt;
        
//         //Fallisce
//         OF_Listino__c listino2Att = new OF_Listino__c();
//         listino2Att.Name = 'Listino2';
//         listino2Att.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listino2Att.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listino2Att.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listino2Att.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listino2Att.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listino2Att.OF_ListinoDefault__c = false;
//         listino2Att.OF_TipologiaApparato__c = 'Appa1';
//         try{
//             insert listino2Att;
//         }catch(Exception ex)
//         {
//             system.debug('ex2Att: '+ex);
//         }
//     }
	
// 	static testmethod void MetodoOpenStream2()
//     {
//         List<OF_ServizioBillingElement__c> listServBillAttivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'Open Stream' and OF_BillingElement__r.name != 'Canone'];
        
//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
        
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         //Primo listino Servizi Attivi
//         OF_Listino__c listinoAtt = new OF_Listino__c();
//         listinoAtt.Name = 'Listino2';
//         listinoAtt.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt.OF_ListinoDefault__c = true;
//         listinoAtt.OF_TipologiaApparato__c = 'Appa1';
// 		insert listinoAtt;

//         //Inserimento OK
//         OF_Listino__c listino3Att = new OF_Listino__c();
//         listino3Att.Name = 'Listino2';
//         listino3Att.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listino3Att.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listino3Att.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listino3Att.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listino3Att.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listino3Att.OF_ListinoDefault__c = false;
//         listino3Att.OF_TipologiaApparato__c = 'Appa2';
//         try{
//             insert listino3Att;
//         }catch(Exception ex)
//         {
//             system.debug('ex3Att: '+ex);
//         }
//         //Fallisce update
//         listino3Att.OF_TipologiaApparato__c = 'Appa1';
//         try{
//             update listino3Att;
//         }catch(Exception ex)
//         {
//             system.debug('ex: '+ex);
//         }
//     }
	
// 	static testmethod void MetodoOpenStream3()
//     {
//         List<OF_ServizioBillingElement__c> listServBillAttivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'Open Stream' and OF_BillingElement__r.name != 'Canone'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
        
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         //Primo listino Servizi Attivi
//         OF_Listino__c listinoAtt = new OF_Listino__c();
//         listinoAtt.Name = 'Listino2';
//         listinoAtt.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt.OF_ListinoDefault__c = true;
//         listinoAtt.OF_TipologiaApparato__c = 'Appa1';
// 		insert listinoAtt;
		
//         //Fallisce inserimento per date
//         OF_Listino__c listinoAtt4 = new OF_Listino__c();
//         listinoAtt4.Name = 'Listino3';
//         listinoAtt4.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt4.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt4.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt4.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt4.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt4.OF_ListinoDefault__c = false;
//         listinoAtt4.OF_TipologiaApparato__c = 'Appa1';
//         try{
//             insert listinoAtt4;
//         }catch(Exception ex)
//         {
//             system.debug('ex4Att: '+ex);
//         }
//     }
	
// 	static testmethod void MetodoOpenStream4()
//     {
//         List<OF_ServizioBillingElement__c> listServBillAttivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'Open Stream' and OF_BillingElement__r.name != 'Canone'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
        
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         //Primo listino Servizi Attivi
//         OF_Listino__c listinoAtt = new OF_Listino__c();
//         listinoAtt.Name = 'Listino2';
//         listinoAtt.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt.OF_ListinoDefault__c = true;
//         listinoAtt.OF_TipologiaApparato__c = 'Appa1';
// 		insert listinoAtt;
		
//         //OK
//         OF_Listino__c listinoAtt5 = new OF_Listino__c();
//         listinoAtt5.Name = 'Listino4';
//         listinoAtt5.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt5.OF_DataInizioValidita__c = Date.newInstance(2120,1,1);
//         listinoAtt5.OF_DataFineValidita__c = Date.newInstance(2121,12,31);
//         listinoAtt5.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt5.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt5.OF_ListinoDefault__c = false;
//         listinoAtt5.OF_TipologiaApparato__c = 'Appa1';
//         try{
//             insert listinoAtt5;
//         }catch(Exception ex)
//         {
//             system.debug('ex5Att: '+ex);
//         }
        
//         //Update fallisce per le date
//         listinoAtt5.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt5.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         try{
//             update listinoAtt5;
//         }catch(Exception ex)
//         {
//             system.debug('ex5Att: '+ex);
//         }
//     }
    
//     static testmethod void MetodoOpenStreamCanone()
//     {
//         List<OF_ServizioBillingElement__c> listServBillAttivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'Open Stream' and OF_BillingElement__r.name = 'Canone'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
        
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         //Primo listino Servizi Attivi
//         OF_Listino__c listinoAtt = new OF_Listino__c();
//         listinoAtt.Name = 'Listino2';
//         listinoAtt.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt.OF_ListinoDefault__c = true;
//         listinoAtt.OF_TipologiaApparato__c = 'Appa1';
//         try{
//             insert listinoAtt;
//         }catch(Exception ex)
//         {
//             system.debug('exAtt: '+ex);
//         }
        
//         OF_Listino__c listinoAtt1 = new OF_Listino__c();
//         listinoAtt1.Name = 'Listino3';
//         listinoAtt1.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listinoAtt1.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listinoAtt1.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listinoAtt1.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listinoAtt1.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listinoAtt1.OF_ListinoDefault__c = false;
//         listinoAtt1.OF_TipologiaApparato__c = 'Appa2';
//         try{
//             insert listinoAtt1;
//         }catch(Exception ex)
//         {
//             system.debug('exAtt: '+ex);
//         }
        
//         //Fallisce
//         OF_Listino__c listino2Att = new OF_Listino__c();
//         listino2Att.Name = 'Listino3';
//         listino2Att.RecordTypeId = RecordTypes.get(listServBillAttivi[0].OF_ServizioNome__c);
//         listino2Att.OF_DataInizioValidita__c = Date.newInstance(2110,1,1);
//         listino2Att.OF_DataFineValidita__c = Date.newInstance(2111,12,31);
//         listino2Att.OF_ServizioBillingElement__c = listServBillAttivi[0].Id;
//         listino2Att.OF_IDContract__c = listServBillAttivi[0].OF_Contract__c;
//         listino2Att.OF_ListinoDefault__c = false;
//         listino2Att.OF_TipologiaApparato__c = 'Appa1';
//         try{
//             insert listino2Att;
//         }catch(Exception ex)
//         {
//             system.debug('ex2Att: '+ex);
//         }
//     }
	
// 	//Testo i listini dei servizi Extra    
//     static testmethod void MetodoExtra()
//     {
//         List<OF_ServizioBillingElement__c> listServBillExtra = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'EXTRA'];
        
//         system.debug('Metodo2 listServBillExtra: '+listServBillExtra);
        
//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         //Listino che va a buon fine
//         OF_Listino__c listino1 = new OF_Listino__c();
//         listino1.Name = 'Listino1';
//         listino1.RecordTypeId = RecordTypes.get(listServBillExtra[0].OF_ServizioNome__c);
//         listino1.OF_DataInizioValidita__c = Date.newInstance(2100,1,1);
//         listino1.OF_DataFineValidita__c = Date.newInstance(2100,12,31);
//         listino1.OF_ServizioBillingElement__c = listServBillExtra[0].Id;
//         listino1.OF_IDContract__c = listServBillExtra[0].OF_Contract__c;
//         listino1.OF_ListinoDefault__c = true;
//         try{
//             system.debug('Metodo2 insert listino1');
//             insert listino1;
//         }catch(Exception ex)
//         {
//             system.debug('Metodo2 ex1: '+ex);
//         }
        
//         //Fallisce per date sovrapposte
//         OF_Listino__c listino6 = new OF_Listino__c();
//         listino6.Name = 'Listino2';
//         listino6.RecordTypeId = RecordTypes.get(listServBillExtra[0].OF_ServizioNome__c);
//         listino6.OF_DataInizioValidita__c = Date.newInstance(2103,1,1);
//         listino6.OF_DataFineValidita__c = Date.newInstance(2103,12,31);
//         listino6.OF_ServizioBillingElement__c = listServBillExtra[0].Id;
//         listino6.OF_IDContract__c = listServBillExtra[0].OF_Contract__c;
//         listino6.OF_ListinoDefault__c = false;
//         try{
//             insert listino6;
//         }catch(Exception ex)
//         {
//             system.debug('ex6: '+ex);
//         }
        
//         //Fallisce dati uguali
//         OF_Listino__c listino4 = new OF_Listino__c();
//         listino4.Name = 'Listino1';
//         listino4.RecordTypeId = RecordTypes.get(listServBillExtra[0].OF_ServizioNome__c);
//         listino4.OF_DataInizioValidita__c = Date.newInstance(2102,1,1);
//         listino4.OF_DataFineValidita__c = Date.newInstance(2102,12,31);
//         listino4.OF_ServizioBillingElement__c = listServBillExtra[0].Id;
//         listino4.OF_IDContract__c = listServBillExtra[0].OF_Contract__c;
//         listino4.OF_ListinoDefault__c = false;
//         try{
//             insert listino4;
//         }catch(Exception ex)
//         {
//             system.debug('Metodo 2 ex4: '+ex);
//         }
        
//         //Fallisce date uguali
//         OF_Listino__c listino5 = new OF_Listino__c();
//         listino5.Name = 'Listino3';
//         listino5.RecordTypeId = RecordTypes.get(listServBillExtra[0].OF_ServizioNome__c);
//         listino5.OF_DataInizioValidita__c = Date.newInstance(2100,1,1);
//         listino5.OF_DataFineValidita__c = Date.newInstance(2100,12,31);
//         listino5.OF_ServizioBillingElement__c = listServBillExtra[0].Id;
//         listino5.OF_IDContract__c = listServBillExtra[0].OF_Contract__c;
//         listino5.OF_ListinoDefault__c = false;
//         try{
//             insert listino5;
//         }catch(Exception ex)
//         {
//             system.debug('ex5: '+ex);
//         }
//     }
    
//     static testmethod void trycatch()
//     {
// 		OF_UtilitiesUnivocitaListino.UnivocitaDetailPassivi(null, null);
// 		OF_UtilitiesUnivocitaListino.UnivocitaDatePassivi(null,null);
//         OF_UtilitiesUnivocitaListino.UnivocitaDetailOpenStream(null,null);
//         OF_UtilitiesUnivocitaListino.UnivocitaDateOpenStream(null,null);
//         OF_UtilitiesUnivocitaListino.UnivocitaDefault(null,null);
//         OF_UtilitiesUnivocitaListino.UnivocitaDateExtra(null,null);
//         OF_UtilitiesUnivocitaListino.UnivocitaDetailExtra(null, null);
//         OF_UtilitiesUnivocitaListino.UnivocitaCanone(null, null);
//     }
 }