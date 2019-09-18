public class OF_VerificheCommContratt {
    
    public OF_VerificheCommContratt() {}

    //metodo che ricevuti un case e un contract mi restituisce true se le verifiche sono passate e false se non sono passate
//     public static boolean VerificaEsistenzaContratto(contract contr, case ca, map<id, OF_ContrattoServizio__c> ContrServMap){

//         boolean CheckEsistenza = false;
        
//         system.debug('DG6 - dentro le verifiche contratto');
        
//         system.debug('DG6 - contr.Status: ' + contr.Status);
//         if(contr.Status == 'Attivo'){      
//               CheckEsistenza = true;
//         }
//         else{
//             CheckEsistenza = false;
//             return CheckEsistenza ;
//         }
        
//         system.debug('DG6 - contr.StartDate: ' + contr.StartDate);        
//         system.debug('DG6 - contr.EndDate: ' + contr.EndDate);        
//         system.debug('DG6 - ca.EOF_Data_Prevista_Attivazione__c: ' + ca.EOF_Data_Prevista_Attivazione__c);        
//         if( (ca.EOF_Data_Prevista_Attivazione__c >= contr.StartDate) && (ca.EOF_Data_Prevista_Attivazione__c <= contr.EndDate) ){      
//               CheckEsistenza = true;
//         }       
//         else{
//             CheckEsistenza = false;
//             return CheckEsistenza ;
//         }
        
//         system.debug('DG6 - ca.EOF_Account_OLO__c: ' + ca.EOF_Account_OLO__c);
//         system.debug('DG6 - contr.AccountId: ' + contr.AccountId);
//         if(ca.EOF_Account_OLO__c == contr.AccountId){      
//               CheckEsistenza = true;
//         }             
//         else{
//             CheckEsistenza = false;
//             return CheckEsistenza ;
//         } 
        
//         system.debug('DG6 - ContrServMap: ' + ContrServMap);
//         system.debug('DG6 - ContrServMap.size(): ' + ContrServMap.size());
//         for (id contID : ContrServMap.keySet()){
//             //DG 17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.
//             system.debug('DG6 - Servizio: ' + ContrServMap.get(contID).OF_Servizio__r.name);
//             system.debug('DG6 - ContrServMap.get(contID): ' + ContrServMap.get(contID)); 
            
//             system.debug( 'DGG - id ' + contID);
            
//             system.debug('DG6 - ContrServMap.get(contID).OF_Servizio__r.name: '+ContrServMap.get(contID).OF_Servizio__r.name);
             
//             if (ContrServMap.get(contID).OF_Servizio__r.name == 'GPON Passiva'){ 
//                 CheckEsistenza = true;
//                 break;
//             }
//             else{
//                 system.debug('DG6 - Servizio no GPON Passiva');
//                 CheckEsistenza = false;
//             }
//         }
//         system.debug('DG6 - CheckEsistenza: ' + CheckEsistenza);
        
//         system.debug('DG6 - verifica esistenza contratto andata a buon fine. CheckEsistenza: ' + CheckEsistenza);
//         return CheckEsistenza;

//     }
    
    
//     public static boolean VerificaEsistenzaCitta(contract contr, case ca, EOF_Network_Inventory__c NI, list<OF_AreaGeograficaJunction__c> AreaGeo){
        
//         system.debug('DG6 - dentro le verifiche città');
        
//         boolean CheckCitta = false;
        
//         if (AreaGeo != null){
//             for (OF_AreaGeograficaJunction__c AGJ : AreaGeo){
//                 //Parto dall'Id building che trovo sul case e mi vado a ricercare il comune corrispondente!!!
                
//                 system.debug('DG6 - contr.id: ' + contr.id);
//                 system.debug('DG6 - AGJ.OF_Contratto__c: ' + AGJ.OF_Contratto__c);
//                 system.debug('DG6 - AGJ.OF_AreaGeografica__r.OF_Istat__c: ' + AGJ.OF_AreaGeografica__r.OF_Istat__c);
//                 system.debug('DG6 - NI.EOF_Comune__c: ' + NI.EOF_Comune__c);
//                 system.debug('DG6 - AGJ.Servizio__r.name: ' + AGJ.Servizio__r.name);
                
//                 //DG 17-03-2017 - ad oggi l'unico servizio che si può richiedere è la GPON Passiva.
//                 if( (contr.id == AGJ.OF_Contratto__c) && (NI.EOF_Comune__c == AGJ.OF_AreaGeografica__r.OF_Istat__c) && (AGJ.Servizio__r.name == 'GPON Passiva') ){
//                     CheckCitta = true;
//                     return CheckCitta;
//                 }
//                 else{
//                     CheckCitta = false;
//                 }
//             }
//             return CheckCitta;
//         }
//         else
//             CheckCitta = false;
        
//         system.debug('DG6 - verifica esistenza città andata a buon fine. CheckCitta: ' + CheckCitta);
//         return CheckCitta;
//     }
	
// 	//DG creato metodo per ricursività trigger quando creo i clienti retail nel trouble ticket    
//     private static boolean run = true;
//     public static boolean runOnce(){
//         if(run){
//             run=false;
//             return true;
//         }else{
//             return run;
//         }
//     }

}