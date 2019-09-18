public class PO_P2P_Attiva_Utils {
//     public static boolean checkRTMap = false;
//     public static map<String,Id> RTMap;
//     public static String specialTerms= '60 giorni data fattura mediante bonifico bancario; I.V.A. esclusa, da applicare a norma di legge.';
//     public static String OpptyValiditaOfferta='30 giorni dalla data della presente;';
//     public static String rtCollCaseDevName='PO_Oppty_collegamenti';
//     public static String rtFattCaseDevName='PO_Oppty_Richiesta_fattibilit';
//     public static ID pb2Id;
//     public static OF_Listino__c listino;
   
    public  PO_P2P_Attiva_Utils (){
        
    }
//     public static void creaP2PAttOpportunity(Case fattCase, Case collCase){
//         PO_P2P_Attiva_Utils.RTMap = new map<String,Id>();
//         for(recordtype rt : [select id,developername from recordtype]){
//             PO_P2P_Attiva_Utils.RTMap.put(rt.developername,rt.id);
//         }
//         System.debug('@@@ FD collCase.RecordType.DeveloperName ' + collCase.RecordType.DeveloperName);
//         if(collCase.RecordType.DeveloperName=='PO_Collegamento_P2P_Attiva'){
            
//             Opportunity oppFatt = new Opportunity();
            
//             // oppFatt.ACCOUNTID=fattCase.Account;
//             oppFatt.RECORDTYPEID=PO_P2P_Attiva_Utils.RTMap.get(rtFattCaseDevName);
//             oppFatt.NAME='OffertaTotale';
//             oppFatt.STAGENAME='Prospecting';
//             oppFatt.PROBABILITY=10.0;
//             //oppFatt.PRICEBOOK2ID='';
//             oppFatt.OWNERID=userinfo.getUserId();
//             //oppFatt.PO_COLLEGAMENTO__C='';
//             //  oppFatt.PO_OFFERTA_TOTALE__C=20;
//             oppFatt.PO_RICHIESTA_FATTIBILIT__C= fattCase.id ;
//             oppFatt.PO_SPECIAL_TERMS__C=specialTerms;
//             oppFatt.PO_OPPTY_VALIDIT_OFFERTA__C= OpptyValiditaOfferta;
//             oppFatt.CloseDate=system.today().addDays(30);
//             insert oppFatt; 
            
//             Opportunity oppColl = new Opportunity();  
//             // oppColl.ACCOUNTID = collCase.Account;
//             oppColl.RECORDTYPEID = PO_P2P_Attiva_Utils.RTMap.get(rtCollCaseDevName);
//             oppColl.NAME = 'Offerta Collegamento';
//             oppColl.STAGENAME = 'Prospecting';
//             oppColl.PROBABILITY = 10.0;
//             //oppColl.PRICEBOOK2ID = pb2Id;
//             oppColl.OWNERID = userinfo.getUserId();
//             oppColl.PO_COLLEGAMENTO__C = collCase.id;
//             oppColl.PO_OFFERTA_TOTALE__C = oppFatt.id;
//             oppColl.PO_SPECIAL_TERMS__C = specialTerms;								
//             oppColl.PO_OPPTY_VALIDIT_OFFERTA__C = OpptyValiditaOfferta ;
//             oppColl.CloseDate=system.today().addDays(30);
//             insert oppColl; 
            
//             /*
// PO_Incluso_nell_offerta__c,PO_Offerta_totale__c, PO_Contratto__c, PO_Contributo_attivazione_collegamento__c,PO_Collegamento__c,
// PO_Canone_collegamento__c ,PO_Costi_aggiuntivi_collegamento__c,PO_Totale_canoni__c,
// PO_Sconto_costi_aggiuntivi_collegamento__c, //CRM 31/07/2017 Aggiunti campi
// PO_Totale_contributi_attivazione__c,PO_Totale_costi_aggiuntivi__c 
// */   
//         }   
        
//     }
//     /*
// 	public static Map<String,EmailTemplate> ritornaTemplates(List<String> listaNameTemplate){
// 		Map<String,EmailTemplate> mappaT=new Map<String,EmailTemplate>();
// 		List<EmailTemplate> et=[Select id, Name, subject, body, FolderId, Folder.Name, HtmlValue from 	EmailTemplate where Folder.Name=:eTfolderName and Name=:listaNameTemplate];
// 		for(EmailTemplate el:et){
// 		   mappaT.put(el.Name,el);
// 		}
// 		return mappaT;
// 	}
// 	*/
    
//     public static Map<String,OF_Listino__c> getListino(List<String> listaStringhe){
//         Map<String,OF_Listino__c> nListinoMap = NEW Map<String,OF_Listino__c>();
//         For(OF_Listino__c l1 :[Select id, Name, RecordTypeId, RecordType.DeveloperName, OF_Attivo__c,
//                               OF_ServizioBillingElement__c,OF_ClusterPromozione__c,OF_CodiceProgettoSpeciale__c,
//                               OF_CommercialElement__c,OF_DataFineValidita__c, OF_DataInizioValidita__c,OF_IDContract__c,
//                               ID_Prod__c,OF_ListinoDefault__c,OF_ProgettoSpeciale__c,OF_Promozione__c,OF_Servizio__c,
//                               PO_Servizio_Billing_Element_Fattibilita__c,OF_TipologiaApparato__c from OF_Listino__c where RecordType.DeveloperName =:listaStringhe]){ //OF_Servizio__c is a formulaField
//                               ///*'OF_Open_Stream' OR RecordType.DeveloperName='PO_Fattibilita'*/     
//                                   nListinoMap.put(l1.RecordType.DeveloperName,l1);                  
//                               }
// 	   //     listino= PO_P2P_Attiva_Utils.nListinoMap.get('');
//             return nListinoMap;
//     }
    
//     public Map<String,OF_CommercialElementIstanziato__c> mappaNomeCeI(){
//         Map<String,OF_CommercialElementIstanziato__c> nCeiMap = new Map<String,OF_CommercialElementIstanziato__c>();
//         for(OF_CommercialElementIstanziato__c cei: [Select id, Name from OF_CommercialElementIstanziato__c]){        
//             nCeiMap.put(cei.Name,cei); 
//         }
//         return nCeiMap;
//     }
    
   
}