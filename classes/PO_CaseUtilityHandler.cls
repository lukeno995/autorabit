public class PO_CaseUtilityHandler {
    
    public PO_CaseUtilityHandler() {
	}
	
    // public Static Void CalculateOpp(list<opportunity> vlstOpp){
        
    //     //  Map<ID, Opportunity> parentOpps = new Map<ID, Opportunity>();
    //     Map<id,case> casesMap = new map<id,case>();
                
    //     set<id> Oppids = new set<id>();
    //     set<id> caseids = new set<id>();
        
    //     for(opportunity opp : vlstOpp){
            
    //         if(opp.PO_Offerta_totale__c !=null){
    //             Oppids.add(opp.PO_Offerta_totale__c );//id dell'opportunità padre
    //             caseids.add(opp.PO_Collegamento__c);//set di id del case
    //         }
            
    //     }
    //     //lista di opportunità padre
    //     List<Opportunity> OppLst =  [select RecordType.name,PO_Incluso_nell_offerta__c, PO_Offerta_totale__c, PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
    //                                  Id,name,PO_Richiesta_fattibilit__r.ID,PO_Totale_canoni__c,PO_Summary__c,
    //                                  PO_Totale_contributi_attivazione__c,PO_Totale_costi_aggiuntivi__c,PO_CostiCollegamento__c,
    //                                  PO_Canone_manutenzione_collegamento__c,PO_Corrispettivo_IRU__c,
    //                                  PO_Canone_annuo_1anno__c,PO_Contributo_attivazione_1anno__c,PO_Costi_Aggiuntivi_Anno1__c,
    //                                  PO_Canone_annuo_2anni__c,PO_Contributo_attivazione_2anni__c,PO_Costi_Aggiuntivi_Anno2__c,
    //                                  PO_Canone_annuo_3anni__c,PO_Contributo_attivazione_3anni__c,PO_Costi_Aggiuntivi_Anno3__c,
    //                                  PO_Canone_annuo_AltriAnni__c,PO_Contributo_attivazione_altri_anni__c,PO_Costi_Aggiuntivi_Altri_Anni__c,
    //                                  PO_CostiAggiuntiviCollegamento__c,PO_Valore_medio_annuo_altre_coppie__c,PO_Valore_medio_annuo_totale__c,PO_Valore_totale_prima_coppia_fino_2030__c
    //                                  from Opportunity where PO_Offerta_totale__c IN : Oppids ] ;
        
    //     map<Id,opportunity> parentOpps = new map<id,opportunity>(
    //         [select PO_Offerta_totale__c,Id,name,PO_Richiesta_fattibilit__r.ID,PO_Totale_canoni__c,PO_Summary__c,
    //          PO_Totale_contributi_attivazione__c,
    //          PO_Totale_canoni_manutenzione__c,PO_Totale_corrispettivi_IRU__c,
    //          PO_Totale_Canone_Anno1__c,PO_Totale_Contributi_Attiva_Anno1__c,PO_Totale_Costi_Aggiuntivi_Anno1__c,
    //          PO_Totale_Canone_Anno2__c,PO_Totale_Contributi_Attiva_Anno2__c,PO_Totale_Costi_Aggiuntivi_Anno2__c,
    //          PO_Totale_Canone_Anno3__c,PO_Totale_Contributi_Attiva_Anno3__c,PO_Totale_Costi_Aggiuntivi_Anno3__c,
    //          PO_Totale_Canone_Altri_Anni__c,PO_Totale_Contributi_Attiva_Altri_Anni__c,PO_Totale_Costi_Aggiuntivi_Altri_Anni__c,
    //          PO_Totale_costi_aggiuntivi__c,PO_Totale_valori_medi_annui_altre_copp__c,PO_Totale_valori_medi_annui__c,PO_Totale_valori_prime_coppie_fino_2030__c
    //          from Opportunity where Id =: Oppids and PO_Richiesta_fattibilit__c != null 
    //         ]);
        
        
    //     decimal val1 = 0.0;
    //     decimal val2 = 0.0;
    //     decimal val3 = 0.0;
    //     //CRM 08/08/2017
    //     decimal val4 = 0.0;
    //     decimal val5 = 0.0;
    //     //END CRM 08/08/2017
    //     //10/08/2017 Modifica CRM
    //     decimal val6 = 0.0;
    //     decimal val7 = 0.0;
    //     decimal val8 = 0.0;
    //     decimal val9 = 0.0;
    //     decimal val10 = 0.0;
    //     decimal val11 = 0.0;
    //     decimal val12 = 0.0;
    //     decimal val13 = 0.0;
    //     decimal val14 = 0.0;
    //     decimal val15 = 0.0;
    //     decimal val16 = 0.0;
    //     decimal val17 = 0.0;
    //     decimal val18 = 0.0;
    //     decimal val19 = 0.0;
    //     decimal val20 = 0.0;
    //     decimal val21 = 0.0;
    //     //END 10/08/2017 Modifica CRM
        
    //     if(OppLst.size()>0)   
    //         for( Opportunity opp : OppLst){
                
    //             Opportunity oppobj = parentOpps.get(opp.PO_Offerta_totale__c);
                
    //             if(opp.PO_Incluso_nell_offerta__c == true){
                    
    //                 //CRM 08/08/2017
    //                 //CRM 01/09/2017 Modifica --> aggiunto PO Oppty Misto Lease-Link per FW
    //                 /*START P2P & IRU & Fiber Lease & Misto Lease-Link per FW*/
    //                 if(opp.RecordType.name == 'PO Oppty collegamenti' || 
    //                   opp.RecordType.name == 'PO Oppty IRU' || 
    //                   opp.recordtype.name == 'PO Oppty Evento Temporaneo' ||
    //                   /*opp.RecordType.name == 'PO Oppty Fiber Lease' ||*/
    //                   opp.RecordType.name == 'PO Oppty Misto Lease-Link per FW')
    //                 {
                         
                        
                        
    //                     /**NOT FIBER LEASE**/
    //                     if(opp.RecordType.name != 'PO Oppty Misto Lease-Link per FW')
    //                     {
    //                         if(opp.PO_CostiAggiuntiviCollegamento__c != null ){
    //                             val3 += opp.PO_CostiAggiuntiviCollegamento__c;                    
    //                             System.debug( val3 +'val3 <====> opp.PO_CostiAggiuntiviCollegamento__c' +opp.PO_CostiAggiuntiviCollegamento__c );
    //                         }
    //                     }
    //                     if(opp.PO_Contributo_attivazione_collegamento__c != null ){
    //                         val2 += opp.PO_Contributo_attivazione_collegamento__c; 
    //                         System.debug( val2 +'val2 <====> opp.PO_Contributo_attivazione_collegamento__c' +opp.PO_Contributo_attivazione_collegamento__c );
    //                     }
                        
    //                     /**START ONLY IRU**/
    //                     if(opp.RecordType.name == 'PO Oppty IRU')
    //                     {
    //                         if(opp.PO_Canone_manutenzione_collegamento__c != null ) {
    //                             val4 += opp.PO_Canone_manutenzione_collegamento__c;
    //                             System.debug( val4 +'val4 <====> opp.PO_Canone_manutenzione_collegamento__c' +opp.PO_Canone_manutenzione_collegamento__c );
    //                         }
    //                         if(opp.PO_Corrispettivo_IRU__c != null ) {
    //                             val5 += opp.PO_Corrispettivo_IRU__c;
    //                             System.debug( val5 +'val5 <====> opp.PO_Corrispettivo_IRU__c' +opp.PO_Corrispettivo_IRU__c );
    //                         }
    //                     }
    //                     /**START ONLY P2P & EVENTO TEMPORANEO & FIBER LEASE MISTO**/
    //                     else{
    //                         if(opp.PO_Canone_collegamento__c != null ) {
    //                             val1 += opp.PO_Canone_collegamento__c;
    //                             System.debug( val1 +'val1 <====> opp.PO_Canone_collegamento__c' +opp.PO_Canone_collegamento__c );
    //                         }
    //                     }
    //                 }
    //                 /**START FIBER LINK**/
    //                 if(opp.RecordType.name == 'PO Oppty Fiber Link')
    //                 {
    //                     //10/08/2017 Modifica CRM
    //                     /*Anno 1*/
    //                     if(opp.PO_Canone_annuo_1anno__c != null)
    //                     {
    //                         val6 += opp.PO_Canone_annuo_1anno__c;
    //                     }
    //                     if(opp.PO_Contributo_attivazione_1anno__c != null)
    //                     {
    //                         val7 += opp.PO_Contributo_attivazione_1anno__c;
    //                     }
    //                     if(opp.PO_Costi_Aggiuntivi_Anno1__c != null)
    //                     {
    //                         val8 += opp.PO_Costi_Aggiuntivi_Anno1__c;
    //                     }
    //                     /*Anno 2*/
    //                     if(opp.PO_Canone_annuo_2anni__c != null && opp.PO_Incluso_nell_offerta__c == true)
    //                     {
    //                         val9 += opp.PO_Canone_annuo_2anni__c;
    //                     }
    //                     if(opp.PO_Contributo_attivazione_2anni__c != null)
    //                     {
    //                         val10 += opp.PO_Contributo_attivazione_2anni__c;
    //                     }
    //                     if(opp.PO_Costi_Aggiuntivi_Anno2__c != null)
    //                     {
    //                         val11 += opp.PO_Costi_Aggiuntivi_Anno2__c;
    //                     }
    //                     /*Anno 3*/
    //                     if(opp.PO_Canone_annuo_3anni__c != null)
    //                     {
    //                         val12 += opp.PO_Canone_annuo_3anni__c;
    //                     }
    //                     if(opp.PO_Contributo_attivazione_3anni__c != null)
    //                     {
    //                         val13 += opp.PO_Contributo_attivazione_3anni__c;
    //                     }
    //                     if(opp.PO_Costi_Aggiuntivi_Anno3__c != null)
    //                     {
    //                         val14 += opp.PO_Costi_Aggiuntivi_Anno3__c;
    //                     }
    //                     /*Altri Anni*/
    //                     if(opp.PO_Canone_annuo_AltriAnni__c != null)
    //                     {
    //                         val15 += opp.PO_Canone_annuo_AltriAnni__c;
    //                     }
    //                     if(opp.PO_Contributo_attivazione_altri_anni__c != null)
    //                     {
    //                         val16 += opp.PO_Contributo_attivazione_altri_anni__c;
    //                     }
    //                     if(opp.PO_Costi_Aggiuntivi_Altri_Anni__c != null)
    //                     {
    //                         val17 += opp.PO_Costi_Aggiuntivi_Altri_Anni__c;
    //                     }
    //                     //END 10/08/2017 Modifica CRM
    //                 }
    //                 //31/08/2017 Modifica CRM
    //                 /**START FIBER LEASE & FIBER LEASE MISTO**/
    //                 if(opp.RecordType.name == 'PO Oppty Fiber Lease' || opp.RecordType.name == 'PO Oppty Misto Lease-Link per FW')
    //                 {
    //                     if(opp.PO_CostiCollegamento__c != null)
    //                     {
    //                         val21 += opp.PO_CostiCollegamento__c;
    //                     }
    //                     if(opp.PO_Valore_medio_annuo_altre_coppie__c != null)
    //                     {
    //                         val18 += opp.PO_Valore_medio_annuo_altre_coppie__c;
    //                     }
    //                     if(opp.PO_Valore_medio_annuo_totale__c != null)
    //                     {
    //                         val19 += opp.PO_Valore_medio_annuo_totale__c;
    //                     }
    //                     if(opp.PO_Valore_totale_prima_coppia_fino_2030__c != null)
    //                     {
    //                         val20 += opp.PO_Valore_totale_prima_coppia_fino_2030__c;
    //                     }
    //                 }
    //                 //END CRM 31/08/2017
    //                 //END CRM 08/08/2017
    //             }
                
    //             oppObj.PO_Totale_canoni__c =  val1;
                
    //             oppObj.PO_Totale_contributi_attivazione__c = val2;
                
    //             oppObj.PO_Totale_costi_aggiuntivi__c = val3;
                
    //             //CRM 08/08/2017
    //             oppObj.PO_Totale_canoni_manutenzione__c =  val4;
                
    //             oppObj.PO_Totale_corrispettivi_IRU__c =  val5;
    //             //END CRM 08/08/2017
                
    //             //10/08/2017 Modifica CRM
    //             oppObj.PO_Totale_Canone_Anno1__c = val6;
    //             oppObj.PO_Totale_Contributi_Attiva_Anno1__c = val7;
    //             oppObj.PO_Totale_Costi_Aggiuntivi_Anno1__c = val8;
    //             oppObj.PO_Totale_Canone_Anno2__c = val9;
    //             oppObj.PO_Totale_Contributi_Attiva_Anno2__c = val10;
    //             oppObj.PO_Totale_Costi_Aggiuntivi_Anno2__c = val11;
    //             oppObj.PO_Totale_Canone_Anno3__c = val12;
    //             oppObj.PO_Totale_Contributi_Attiva_Anno3__c = val13;
    //             oppObj.PO_Totale_Costi_Aggiuntivi_Anno3__c = val14;
    //             oppObj.PO_Totale_Canone_Altri_Anni__c = val15;
    //             oppObj.PO_Totale_Contributi_Attiva_Altri_Anni__c = val16;
    //             oppObj.PO_Totale_Costi_Aggiuntivi_Altri_Anni__c = val17;
    //             //31/08/2017 Modifica CRM
    //             //14/09/2017 Modifica CRM
    //             if(opp.RecordType.name == 'PO Oppty Fiber Lease' || opp.RecordType.name == 'PO Oppty Misto Lease-Link per FW')
    //                 oppObj.PO_Totale_costi_aggiuntivi__c = val21;
    //             oppObj.PO_Totale_valori_medi_annui_altre_copp__c = val18;
    //             oppObj.PO_Totale_valori_medi_annui__c = val19;
    //             oppObj.PO_Totale_valori_prime_coppie_fino_2030__c = val20;
    //             //END 31/08/2017 Modifica CRM
    //             //END 10/08/2017 Modifica CRM
                
    //         }
        
        
    //     Update parentOpps.values() ;
        
      
        
        
    // }
    
    // //20/10/2017 CRM
    // public static void OffertaCreata(list<case> caseFattList)
    // {
    //     List<Case> caseToUpdate = new List<Case>();
    //     for (case cFatt : caseFattList)
    //     {
    //         //controllo se ci sono altri case figli
    //         list<case> tuttiIFigli = cFatt.Collegamenti__r;
    //         if(tuttiIFigli.size()>0)
    //         {
    //             Integer contaFigli=0;
    //             boolean checkFibLeasMista = false;
    //             boolean check = false;
    //             for(Case c : tuttiIFigli)
    //             {
    //                 if(c.EOF_Fase__C=='Completato' || c.status=='Annullato')
    //                 {
    //                     //Almeno un case collegamento deve essere completato
    //                     if(c.EOF_Fase__C=='Completato')
    //                     {
    //                         check = true;
    //                     }
    //                     contaFigli=contaFigli+1;
    //                     if(c.PO_Drop_FL_1__c == true)
    //                     {
    //                         checkFibLeasMista = true;
    //                     }
    //                 }
    //             }
    //             system.debug('CRM contaFigli: ' + contaFigli);
    //             system.debug('CRM tuttiIFigli.size(): ' + tuttiIFigli.size());
    //             if(check == true &&
    //               tuttiIFigli.size()==contaFigli)
    //             {
                    
    //                 cFatt.EOF_Fase__c='Offerta Creata';
    //                 if(checkFibLeasMista == true)
    //                 {
    //                     cFatt.PO_Durata_affitto__c = 3;
    //                 }
    //                 caseToUpdate.add(cFatt);
    //             }
    //         }
    //     }
    //     update caseToUpdate;
    // }
    // //20/10/2017 END CRM
    
    // //20/10/2017 CRM
    // public static void OffertaCreataDaTriggerPOUpdateOppCase(list<case> caseFattList)
    // {
    //     List<Case> caseToUpdate = new List<Case>();
    //     for (case cFatt : caseFattList)
    //     {
    //         //controllo se ci sono altri case figli
    //         list<case> tuttiIFigli = cFatt.Collegamenti__r;
    //         //va considerato il fatto che uno dei collegamenti è annullato nel trigger ma in before update
    //         //quindi non risulterà tra questi che sono stati estratti dal DB
    //         //nel conteggio va quindi considerato il fatto che contaFigli sarà uno in meno
    //         if(tuttiIFigli.size()>0)
    //         {
    //             Integer contaFigli=0;
    //             boolean checkFibLeasMista = false;
    //             boolean check = false;
    //             for(Case c : tuttiIFigli)
    //             {
    //                 if(c.EOF_Fase__C=='Completato' || c.status=='Annullato')
    //                 {
    //                     //Almeno un case collegamento deve essere completato
    //                     if(c.EOF_Fase__C=='Completato')
    //                     {
    //                         check = true;
    //                     }
    //                     contaFigli=contaFigli+1;
    //                     if(c.PO_Drop_FL_1__c == true)
    //                     {
    //                         checkFibLeasMista = true;
    //                     }
    //                 }
    //             }
    //             system.debug('CRM contaFigli: ' + contaFigli);
    //             system.debug('CRM tuttiIFigli.size(): ' + tuttiIFigli.size());
    //             if(check == true &&
    //               tuttiIFigli.size()==contaFigli+1)
    //             {
                    
    //                 cFatt.EOF_Fase__c='Offerta Creata';
    //                 if(checkFibLeasMista == true)
    //                 {
    //                     cFatt.PO_Durata_affitto__c = 3;
    //                 }
    //                 caseToUpdate.add(cFatt);
    //             }
    //         }
    //     }
    //     update caseToUpdate;
    // }
    
    // //08/08/2017 CRM
    // //31/08/2017 Modifica --> si utilizza il campo PO_Lunghezza_tratta_prima_via__c per il confronto
    // //01/09/2017 Modifica --> aggiunta la fiber lease mista
    // public static void ParamFattibilita(map<Id, case> mapcase)
    // {
        
    //     Map<ID, Schema.RecordTypeInfo> rtCaseMap = Schema.SObjectType.Case.getRecordTypeInfosById();
        
    //     Parametri_Fattibilita__c ParamFatt = Parametri_Fattibilita__c.getValues('Default');
    //     //System.debug('inside the methodParamFatt: '+ParamFatt);
        
    //     decimal Lungh;
        
    //     for(Id casId : mapcase.keyset())
    //     {
    //         case cas = mapcase.get(casId);
            
    //         string RTCaseName = rtCaseMap.get(cas.RecordTypeId).getName();
            
    //         System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita - RTCaseName: '+RTCaseName);
            
    //         if(RTCaseName == 'PO Collegamento Fiber link')
    //         {
    //             Lungh = cas.PO_Lunghezza_tratta_prima_via__c;
    //         }
            
    //         else if(RTCaseName == 'PO Collegamento Fiber Lease')
    //         {
    //             Lungh = cas.PO_Lunghezza_m__c;
    //         }
    //         System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita - Lungh: '+Lungh);
            
    //         /**Fascia 1**/
    //         if(Lungh <= (ParamFatt.Fascia1__c * 1000))
    //         {
    //             System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita: dentro fascia 1');
    //             cas.PO_Listino__c = 'Fascia 1';
    //         }
    //         /**Fascia 2**/
    //         else if(Lungh > (ParamFatt.Fascia1__c * 1000) && Lungh <= (ParamFatt.Fascia2__c * 1000))
    //         {
    //             System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita: dentro fascia 2');
    //             cas.PO_Listino__c = 'Fascia 2';
    //         }
    //         /**Fascia 3**/
    //         else if(Lungh > (ParamFatt.Fascia2__c * 1000) && Lungh <= (ParamFatt.Fascia3__c * 1000))
    //         {
    //             System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita: dentro fascia 3');
    //             cas.PO_Listino__c = 'Fascia 3';
    //         }
    //         /**Fascia 4**/
    //         else if(Lungh > (ParamFatt.Fascia3__c * 1000) &&  Lungh <= (ParamFatt.Fascia4__c * 1000))
    //         {
    //             System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita: dentro fascia 4');
    //             cas.PO_Listino__c = 'Fascia 4';
    //         }
    //         /**Fascia 5**/
    //         //06/09/2017 CRM modifica --> Tolto il limite superiore delle fasce (10000)
    //         else if(Lungh > (ParamFatt.Fascia4__c * 1000) && Lungh <= (ParamFatt.Fascia5__c * 1000))
    //         {
    //             System.debug('DG_PO_CaseUtilityHandler_ParamFattibilita: dentro fascia 5');
    //             cas.PO_Listino__c = 'Fascia 5';
    //         }
    //     }
    // }
    // //END 08/08/2017 CRM
    
    // //05/09/2017
    // //Aggiorno il campo Drop FL (1) sul caso padre in base al valore che è presente sul figlio
    // public static void CaseFattDropFL(map<Id, boolean> mapcase)
    // {
    //     //Parent Case
    //     list<case> caseList = [select id, PO_Drop_FL_1__c from case where id IN: mapcase.keySet()];
    //     System.debug('DG_PO_CaseUtilityHandler_CaseFattDopFL - caseList: ' + caseList);
        
    //     list<case> caseToUpdate = new list<case>(); 
        
    //     for(case cs : caseList)
    //     {
    //         System.debug('DG_PO_CaseUtilityHandler_CaseFattDopFL - mapcase.get(cs.id): ' + mapcase.get(cs.id));
    //         cs.PO_Drop_FL_1__c = mapcase.get(cs.id);
    //         caseToUpdate.add(cs);
    //     }
    //     //19/09/2017 CRM
    //     if(caseToUpdate.size() > 0)
    //     {
    //         System.debug('DG_PO_CaseUtilityHandler_CaseFattDopFL - caseToUpdate: ' + caseToUpdate);
    //         update caseToUpdate;
    //     }
    //     //update caseList;
    //     //19/09/2017 END CRM
    // }
    // //END 05/09/2017
    
    // //19/09/2017 CRM
    // //Se il campo PO_Drop_FL_1__c == true allora il campo PO_Posa_1_nuovo_Drop__c deve essere messo a 0
    // public static void CaseCollDropFL(map<Id, case> MapCaseColl)
    // {
    //     for(case cs : MapCaseColl.values())
    //     {
    //         System.debug('DG_PO_CaseUtilityHandler_CaseFattDopFL - prima cs.PO_Posa_1_nuovo_Drop__c: ' + cs.PO_Posa_1_nuovo_Drop__c);
    //         cs.PO_Posa_1_nuovo_Drop__c = 0.00;
    //         System.debug('DG_PO_CaseUtilityHandler_CaseFattDopFL - dopo cs.PO_Posa_1_nuovo_Drop__c: ' + cs.PO_Posa_1_nuovo_Drop__c);
    //     }
    // }
    // //END 19/09/2017
  
}