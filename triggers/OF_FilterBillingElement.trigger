// //Davide Gagliardi 27/02/2017
// //Trigger che serve per popolare correttamente la lookup 'Billing element' sull'oggetto Listino.
// //I billing element tra cui si potrà scegliere saranno solo quelli appartenenti ai servizi presenti nel contratto presente nel listino

 trigger OF_FilterBillingElement on OF_ContrattoServizio__c (after insert, after update, after delete) {
// /*
// try{

//     if(Trigger.isInsert && Trigger.isAfter){
        
//        /**CRM Modifica 30_03_2017 /Flaggo  OF_EsistenzaServizio 
//        a true la prima volta che viene aggiunto un Servizio**/
//        List<Contract> lo = new List<Contract>();
//        List<Contract> ContrToUpdate = new List<Contract>();
//        Set<ID> contrattiDaAggiornare = new Set<ID>(); 
//        /**/
//         Map<Id,OF_ServizioBillingElement__c> ServizioBillingElementMap = new Map<Id,OF_ServizioBillingElement__c>();        
//         set<id> Ids = new Set<id>();
//         for(OF_ContrattoServizio__c CS : Trigger.new){
//             Ids.add(CS.OF_Servizio__c);
//             /**crm modifica 30_03_2017**/
//             contrattiDaAggiornare.add(CS.OF_Contract__c);
//             /**/
//         }
//         system.debug('DG - Ids: ' + Ids);
//         /**crm modifica 30_03_2017**/
//         lo = [SELECT Id,OF_EsistenzaServizio__c FROM Contract WHERE Id IN : contrattiDaAggiornare];
//         if( lo != null && lo.size() > 0 )
//         {
//            for( Contract cx : lo )
//            {
//                cx.OF_EsistenzaServizio__c = true;
//                ContrToUpdate.add(cx);
//            }
//         }
//         update ContrToUpdate;
//         /**fine modifica**/
        
//         //mappa contenente tutti i billing element che appartengono al servizio selezionato
//         Map<Id,OF_BillingElement__c> BillingElementMap = new Map<Id,OF_BillingElement__c>([select id, name from OF_BillingElement__c where OF_CommercialElement__r.OF_Servizio__c in: IDS]);
//         system.debug('DG - BillingElementMap: ' + BillingElementMap);
        
//         for (OF_ContrattoServizio__c CS1 : trigger.new){
//             system.debug('DG - Siamo dentro al primo for');
//             for (id BEID : BillingElementMap.keyset()){
//             system.debug('DG - Siamo dentro al secondo for');
//                 OF_ServizioBillingElement__c SBE = new OF_ServizioBillingElement__c();
//                     SBE.OF_Contract__c = CS1.OF_Contract__c;
//                     SBE.OF_Servizio__c = CS1.OF_Servizio__c;
//                     SBE.OF_BillingElement__c = BillingElementMap.get(BEID).id;
//                     SBE.Name = BillingElementMap.get(BEID).name;
//                     system.debug('DG - SBE.OF_BillingElement__c: ' + SBE.OF_BillingElement__c);
//                 ServizioBillingElementMap.put(BEID, SBE);
//                 system.debug('DG - ServizioBillingElementMap: ' + ServizioBillingElementMap);
//             }
            
//         }
//             Insert ServizioBillingElementMap.values();
//     }
//     /* 27/02/2017 Deve funionare anche in update??? --> ci sarà la possibilità di modificare un record dell'oggetto OF_ContrattoServizio__c??? Se si aggiungere trigger.isUpdate
//     if(Trigger.isUpdate && Trigger.isAfter){
//     }*/
    
//     //Se il servizio viene eliminato sulla related list del contratto (= viene eliminato un record dell'oggetto: OF_ContrattoServizio__c) vengono eliminati tutti i record sull'oggetto OF_ServizioBillingElement__c, OF_AreaGeograficaJunction__c (e di conseguenza OF_AreaGeograficaCUstom__c) che hanno quell'id contratto e id servizio 
//     if(trigger.isDelete){
        
//         set<id> IDs1 = new set<id>();
        
//         map<id,OF_ServizioBillingElement__c> MapToDelete = new map<id,OF_ServizioBillingElement__c>();
//         map<id,OF_AreaGeograficaJunction__c> MapToDelete1 = new map<id,OF_AreaGeograficaJunction__c>();
//         list<OF_AreaGeograficaCustom__c> ListAGToDelete = new list<OF_AreaGeograficaCustom__c>();
                
//         for(OF_ContrattoServizio__c CS: Trigger.old) {
//             IDs1.add(CS.OF_Contract__c);
//         }
        
//         map<id,OF_ServizioBillingElement__c> ServizioBEMap = new map<id,OF_ServizioBillingElement__c>([select id, OF_Contract__c, OF_Servizio__c, OF_BillingElement__c from OF_ServizioBillingElement__c where OF_Contract__c =: IDs1]);
//         map<id,OF_AreaGeograficaJunction__c> AGJMap = new map<id,OF_AreaGeograficaJunction__c>([select id, OF_Contratto__c, Servizio__c, OF_AreaGeografica__c from OF_AreaGeograficaJunction__c where OF_Contratto__c =: IDs1]);
//         list<id> idAG = new list<id>();
        
//         system.debug('DG_OF_FilterBillingElement - ServizioBEMap: ' + ServizioBEMap);
//         system.debug('DG_OF_FilterBillingElement - AGJMap: ' + AGJMap);
        
//         map<id,OF_Listino__c> mapListini = new map<id,OF_Listino__c>([select id, OF_ServizioBillingElement__c from OF_Listino__c where OF_IDContract__c =: IDs1]);
//         list<id> IDList = new list<id>();
//         system.debug('DG_OF_FilterBillingElement - mapListini: ' + mapListini);
        
//         for(OF_ContrattoServizio__c CS1: Trigger.old){ 
//             //Cerco gli OF_ServizioBillingElement__c da eliminare                               
//             for(id IDSBE : ServizioBEMap.keySet()){
//                 if(ServizioBEMap.get(IDSBE).OF_Contract__c == CS1.OF_Contract__c && ServizioBEMap.get(IDSBE).OF_Servizio__c == CS1.OF_Servizio__c){
//                     //cerco a sistema se c'è un listino che ha associato un OF_ServizioBillingElement__c che sto cercando di eliminare
//                     system.debug('DG_OF_FilterBillingElement - Deentro if servizio billing element');
//                     for(id IDmapL : mapListini.keySet()){
//                         if(mapListini.get(IDmapL).OF_ServizioBillingElement__c == ServizioBEMap.get(IDSBE).id){
//                             IDList.add(IDmapL);
//                         }
//                     }
//                     if(IDList.size()>=1){
//                         CS1.id.addError('<span></br><b>Non puoi eliminare dal contratto il servizio perchè esiste un listino configurato con questo contratto e con un Billing Element di questo Servizio!</b></br></span>',false); 
//                         break;
//                     }
//                     MapToDelete.put(IDSBE, ServizioBEMap.get(IDSBE));
//                 }  
//             }
//             //Cerco le OF_AreaGeograficaJunction__c da eliminare   
//             for(id IDAGJ : AGJMap.keySet()){
//                 if(AGJMap.get(IDAGJ).OF_Contratto__c == CS1.OF_Contract__c && AGJMap.get(IDAGJ).Servizio__c == CS1.OF_Servizio__c){
//                     system.debug('DG_OF_FilterBillingElement - Deentro if area geografica junction');
//                     MapToDelete1.put(IDAGJ, AGJMap.get(IDAGJ));
//                     idAG.add(AGJMap.get(IDAGJ).OF_AreaGeografica__c);
//                 }  
//             }
//         }
//         //Cerco le OF_AreaGeograficaCustom__c da eliminare
//         if(idAG.size() > 0 && idAG != null){
//             ListAGToDelete = [select id from OF_AreaGeograficaCustom__c where id IN: idAG];
//         }
        
//         //Elimino i OF_ServizioBillingElement__c
//         if(MapToDelete.size() > 0){
//             system.debug('DG_OF_FilterBillingElement - MapToDelete: ' + MapToDelete);
//             delete MapToDelete.values();
//         }
//         //Elimino le OF_AreaGeograficaJunction__c
//         if(MapToDelete1.size() > 0){
//             system.debug('DG_OF_FilterBillingElement - MapToDelete1: ' + MapToDelete1);
//             delete MapToDelete1.values();
//         }
//         //Elimino le OF_AreaGeograficaCustom__c
//         if(ListAGToDelete.size() > 0){
//             system.debug('DG_OF_FilterBillingElement - ListAGToDelete: ' + ListAGToDelete);
//             //30/05/2017 commentato perchè scritto così elimina le aree geografiche custom anche se sono associate ad altre aree geografiche junction
//             //              Bisognerebbe fare un controllo, se non sono associate aree geografiche junction a quella custom allora elimino, altrimenti no
//             //delete ListAGToDelete;
//         }
        
//         //Lista dei contratti associati ai OF_ContrattoServizio__c che sto processando
//         list<contract> contracts = new list<contract>([select id, OF_EsistenzaServizio__c from contract where id IN: IDs1]);
//         list<contract> contractsToUpdate = new list<contract>();
//         system.debug('DG_OF_FilterBillingElement - contracts: ' +contracts);
        
//         list<OF_ContrattoServizio__c> CSList = new list<OF_ContrattoServizio__c>([select id, OF_Contract__c from OF_ContrattoServizio__c where OF_Contract__c IN: IDs1]);
//         list<OF_ContrattoServizio__c> CSListToCompare = new list<OF_ContrattoServizio__c>();
//         system.debug('DG_OF_FilterBillingElement - CSList: ' +CSList);
//         //Per ogni contratto verifiche se ci sono servizi associati, se non ci sono metto la checkbox OF_EsistenzaServizio__c a false
//         for(Contract cont : contracts){
            
//             for(OF_ContrattoServizio__c CS : CSList){
                
//                 if(CS.OF_Contract__c == cont.id){
//                     CSListToCompare.add(CS);
//                 }
//             }
            
//             if(CSListToCompare.size() == 0){
//                 cont.OF_EsistenzaServizio__c = false;
//                 contractsToUpdate.add(cont);
//             }
//         }
//         //Aggiorno il contratto
//         if(contractsToUpdate.size() > 0){
//             update contractsToUpdate;
//         }
//     }
    
//   }catch(Exception e )
//   {
//   OF_Utility.logMessage(true,'L',
//         'Trigger: OF_FilterBillingElement',
//         'SObject: OF_ContrattoServizio__c',
//         'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
//     );   
//   }*/
 }