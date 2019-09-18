@isTest
public class OF_CreateProduct2PriceBook2Test {
    
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
//         listServizi = createServizi();
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
	
     //Creazione Catalogo e Servizio
    //  public static List<OF_Servizio__c> createServizi()
    //  {
    //           Date myDate = Date.newInstance(2016,1,1);
    //           Date newDate = Date.newInstance(2099,12,31);
    //           OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();

    //           catalogo.Name = 'Catalogo 1';
    //           catalogo.OF_Attivo__c = true;
    //           catalogo.OF_DataInizioValidita__c = myDate;
    //           catalogo.OF_DataFineValidita__c = newDate;
    //           insert catalogo;
       
    //           /**Creazione Servizi**/
    //           List<OF_Servizio__c> listaServizi = new List<OF_Servizio__c>();
    //           OF_Servizio__c GPONAttiva = new OF_Servizio__c();
    //           OF_Servizio__c GPONPassiva = new OF_Servizio__c();
    //           OF_Servizio__c Fibra = new OF_Servizio__c();
    //   		  OF_Servizio__c P2P = new OF_Servizio__c();
        	
    //           GPONAttiva.Name = 'Open Stream';
    //           GPONAttiva.OF_Attivo__c = true;
    //           GPONAttiva.OF_CatalogoCommerciale__c = catalogo.Id;
    //           GPONAttiva.OF_DataInizioValidita__c = myDate;
    //           GPONAttiva.OF_DataFineValidita__c = newDate;
    //                       listaServizi.add(GPONAttiva);
    //           GPONPassiva.Name = 'GPON Passiva';
    //           GPONPassiva.OF_Attivo__c = true;
    //           GPONPassiva.OF_CatalogoCommerciale__c = catalogo.Id;
    //           GPONPassiva.OF_DataInizioValidita__c = myDate;
    //           GPONPassiva.OF_DataFineValidita__c = newDate;
    //                       listaServizi.add(GPONPassiva);
    //           Fibra.Name = 'Extra';
    //           Fibra.OF_Attivo__c = true;
    //           Fibra.OF_CatalogoCommerciale__c = catalogo.Id;
    //           Fibra.OF_DataInizioValidita__c = myDate;
    //           Fibra.OF_DataFineValidita__c = newDate;
    //                      listaServizi.add(Fibra);
        
    //      	  P2P.Name = 'P2P Base';
    //           P2P.OF_Attivo__c = true;
    //           P2P.OF_CatalogoCommerciale__c = catalogo.Id;
    //           P2P.OF_DataInizioValidita__c = myDate;
    //           P2P.OF_DataFineValidita__c = newDate;
    //                       listaServizi.add(P2P);
      
    //           if(listaServizi != null && listaServizi.size() > 0) insert listaServizi;
              
        
    //      return listaServizi;  
    
    //  }
    
//     //Creazione BE
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
    
    
//     //Fattibilità
//     static testmethod void Method1()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'P2P Base'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
        
//         OF_Listino__c listino1 = new OF_Listino__c();
//         listino1.Name = 'Listino1';
//         listino1.RecordTypeId = RecordTypes.get('Fattibilità');
//         listino1.OF_DataInizioValidita__c = Date.newInstance(2100,1,1);
//         listino1.OF_DataFineValidita__c = Date.newInstance(2100,12,31);
//         listino1.PO_Servizio_Billing_Element_Fattibilita__c = listServBillPassivi[0].Id;
//         listino1.OF_IDContract__c = listServBillPassivi[0].OF_Contract__c;
//         listino1.OF_ListinoDefault__c = true;
//         insert listino1;
//     }
    
//     //Update
//     static testmethod void Method2()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
     
//   		//Corretto
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
//         insert listino4;
        
//         listino4.name = 'NewListino';
//         update listino4;
        
//         listino4.OF_attivo__c = true;
//         update listino4;
        
//     }
    
//     //Delete
//     static testmethod void Method3()
//     {
//         List<OF_ServizioBillingElement__c> listServBillPassivi = [SELECT ID,OF_BillingElement__c,OF_Contract__c,OF_Servizio__c, OF_ServizioNome__c
//                                                           FROM OF_ServizioBillingElement__c where OF_ServizioNome__c = 'GPON Passiva'];

//         List<RecordType> rtypes = [Select Name, Id From RecordType
//                   where sObjectType='OF_Listino__c' and isActive=true];
//         Map<String,String> RecordTypes = new Map<String,String>{};
//         for(RecordType rt: rtypes)
//             RecordTypes.put(rt.Name,rt.Id);
     
//   		//Corretto
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
//         insert listino4;
        
//         delete listino4;
        
//     }

}