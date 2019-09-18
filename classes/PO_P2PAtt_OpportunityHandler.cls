public class PO_P2PAtt_OpportunityHandler {
// 	public static boolean checkParentRecalculation=false;
// 	public static Id P2PAttContractId;
// 	public static pricebook2 P2PAttCanonePricebook;
// 	public static pricebook2 newPricebook;
//     public static opportunity createOppChild(Case c) {
//         Opportunity o = new opportunity();
//         o.CloseDate=system.today().addDays(150);
//         o.name='Offerta Collegamento';
//         o.StageName='Prospecting';
//         o.AccountId=c.accountId; 
//         o.PO_Collegamento__c=c.Id;
//         o.PO_CostiAggiuntiviCollegamento__c=c.PO_Costi_aggiuntivi_collegamento__c;
//      //   o.PO_Contratto__c=PO_P2PAtt_OpportunityHandler.getP2PAttContractId('OF');
//         o.Pricebook2ID=PO_P2PAtt_OpportunityHandler.getNewPricebook(c).Id; 
//         o.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('PO_Oppty_collegamenti_P2P_Attiva');
//         insert o;
//         //PO_P2PAtt_OpportunityHandler.createOppLineItems(o,c);
//         return o;
//     }
   public   PO_P2PAtt_OpportunityHandler (){
       
   }
   
//     public static opportunity createOppParent(Case casePadre,List<Case> tuttiIFigli){
//     	Opportunity o = new opportunity();
//         o.CloseDate=system.today().addDays(150);
//         o.name='Offerta Totale';
//         o.StageName='Prospecting';
//         o.AccountId=casePadre.accountId; 
//         o.PO_Richiesta_fattibilit__c=casePadre.Id;
//         o.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('PO_Oppty_Richiesta_fattibilit_P2P_Attiva');
//         o.Pricebook2Id=PO_P2PAtt_OpportunityHandler.getNewPricebook(casePadre).Id;
//         insert o;
//         List<opportunity> oppChildList = [select id,PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
//         									PO_CostiAggiuntiviCollegamento__c from opportunity where PO_Incluso_nell_offerta__c=true AND PO_Collegamento__c in :tuttiIFigli];
//         oppChildList.add(PO_P2PAtt_OpportunityHandler.calculateParentOpp(o,oppChildList));
//         update oppChildList;
//         return o;
//     }
//     public static void ricalculateOppParent(Set<Id> parentOppIdSet){
//     	PO_P2PAtt_OpportunityHandler.checkParentRecalculation=true;
//     	List<Opportunity> ParentOppList=[select id, (select id,PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
//         									PO_CostiAggiuntiviCollegamento__c from Opportunities__r where PO_Incluso_nell_offerta__c=true) from opportunity where id in :parentOppIdSet];
//     	for(Opportunity o:ParentOppList){
//     		PO_P2PAtt_OpportunityHandler.calculateParentOpp(o,o.Opportunities__r);
//     	}
//     	update ParentOppList;
//     }
//     /*
//     public static Id getP2PAttContractId(String codiceOperatore){
//     	if(PO_P2PAtt_OpportunityHandler.P2PAttContractId!=null){
//     		return PO_P2PAtt_OpportunityHandler.P2PAttContractId;
//     	}
//     	else{
//     		PO_P2PAtt_OpportunityHandler.P2PAttContractId=[select id,name,OF_Servizio__r.Name,OF_Contract__c  from OF_ContrattoServizio__c  where OF_Servizio__r.name='P2P Attiva' and OF_Contract__r.Account.EOF_Codice_Operatore__c =:codiceOperatore].OF_Contract__c ;
//     		return PO_P2PAtt_OpportunityHandler.P2PAttContractId;
//     	} 
//     }
//     */
//     public static pricebook2 getP2PAttCanonePricebook(Case cs){
//     	system.debug('@@@@ cs.PO_Tipo_percorso__c: '+cs.PO_Tipo_percorso__c+'; cs.PO_Numero_fibre_richieste__c: '+cs.PO_Numero_fibre_richieste__c);
//     	if(PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook!=null){
//     		return PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook;
//     	}
//     	else{
//     		Map <string, OF_CodificaProfiloListini__c> mapCodifica=OF_CodificaProfiloListini__c.getAll();
//       		system.debug('mappppdata:'+mapCodifica);
//       		Map<String,Pricebook2> tipoPricebookMap = new Map<String,Pricebook2>();
//       		for(pricebook2 pb:[SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,
//       							PO_Contratto__c ,PO_Contratto__r.id,PO_Commercial_element__r.OF_Servizio__c,
// 								PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__r.accountid  
// 								from pricebook2 where isactive = true 
// 								and OF_Master__c=true
// 								and PO_Commercial_element__r.OF_Servizio__r.Name='P2P Attiva']){
// 				tipoPricebookMap.put(pb.Name,pb);			
// 			}
// 			String pbName;
// 			if(mapCodifica.get(cs.OF_SA_Profilo__c) != null){
// 				pbName=mapCodifica.get(cs.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
// 			}
//             system.debug('pbnamedata:'+pbName);
// 			pbName=pbName.right(pbName.length()-14);
// 			system.debug('@@@@ pricebookName: '+pbName);
// 			if(cs.PO_Tipo_percorso__c == 'Singola Via' ){
// 				if(cs.PO_Numero_fibre_richieste__c=='1'){
// 					PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook = tipoPricebookMap.get('P2PATT_001_CAN_SINGMONO_'+pbName);
// 					return PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook;
// 				}
// 				else if(cs.PO_Numero_fibre_richieste__c=='2'){
// 					PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook = tipoPricebookMap.get('P2PATT_001_CAN_SINGBI_'+pbName);
// 					return PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook;
// 				}
// 			}
// 			else if(cs.PO_Tipo_percorso__c == 'Doppia Via'){ 
// 				if(cs.PO_Numero_fibre_richieste__c=='1'){
// 					PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook = tipoPricebookMap.get('P2PATT_001_CAN_DOPPMONO_'+pbName);
// 					return PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook;
// 				}
// 				else if(cs.PO_Numero_fibre_richieste__c=='2+2'){
// 					PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook = tipoPricebookMap.get('P2PATT_001_CAN_DOPPBI_'+pbName);
// 					return PO_P2PAtt_OpportunityHandler.P2PAttCanonePricebook;
// 				}
// 			}
//     	} 
//     	return null;
//     }
//     public static list<OpportunityLineItem> createOppLineItems(opportunity o,Case c){
//     	//all'opportunity è legato il pricebook relativo al canone selezionato
//     	//devo tirarmi fuori il contributo di attivazione e il contributo aggiuntivo relativi allo stesso commercial
//     	//element del canone
//     	//qui mi tiro fuori contributo attivazion e contributo aggiuntivo
//     	list<OpportunityLineItem> OpportunityLineItemsList=  new list<OpportunityLineItem>();
//     	list<PricebookEntry> newPbeList=  new list<PricebookEntry>();
    	
//     	for(PricebookEntry pbe:[select Id, Name, Pricebook2Id, Product2Id, UnitPrice, IsActive, UseStandardPrice,
//     							Pricebook2.name,Pricebook2.PO_Commercial_element__r.name 
// 								from PricebookEntry 
// 								where OF_Master__c=true
// 								//AND Pricebook2.PO_Commercial_element__c=:PO_P2PAtt_OpportunityHandler.getP2PAttCanonePricebook(c).PO_Commercial_element__c
//                                 AND (name in ('Contributo Attivazione','Contributo Aggiuntivo'))]){
// //									OR Pricebook2Id=:PO_P2PAtt_OpportunityHandler.getP2PAttCanonePricebook(c).Id)]){
// 			PricebookEntry newPbe=pbe.clone(false,true,false,false);
// 			newPbe.Pricebook2Id=PO_P2PAtt_OpportunityHandler.getNewPricebook(c).Id;
// 			newPbeList.add(newPbe);	 
//           system.debug('@@@@ newPbe: '+newPbe);									
// 		}
// 		insert newPbeList;
// 		for(PricebookEntry newPbe:newPbeList){
// 			OpportunityLineItemsList.add(new OpportunityLineItem(
//     												OpportunityId = o.Id, 
//                                                     PricebookEntryId = newPbe.id, 
//                                                     Quantity = 1, 
//                                                     PO_SalesPrice__c = newPbe.UnitPrice,
//                                                     unitprice = newPbe.UnitPrice 
//                                                   ));
// 		}
//         insert OpportunityLineItemsList;
//         return OpportunityLineItemsList;                            
//     } 
//     public static Pricebook2 getNewPricebook(Case c){
//     	if(PO_P2PAtt_OpportunityHandler.newPricebook!=null){
//     		return PO_P2PAtt_OpportunityHandler.newPricebook;
//     	}
//     	else{
// 	    	PO_P2PAtt_OpportunityHandler.newPricebook= new Pricebook2();
// 	    	PO_P2PAtt_OpportunityHandler.newPricebook.recordtypeId=OF_Utility.getRT_DevNameId_Map().get('OF_Pricebook');
// 	    	//PO_P2PAtt_OpportunityHandler.newPricebook.PO_Contratto__c=PO_P2PAtt_OpportunityHandler.getP2PAttContractId('OF');
// 	    	PO_P2PAtt_OpportunityHandler.newPricebook.isActive=true;
// 	    	//PO_P2PAtt_OpportunityHandler.newPricebook.PO_Commercial_element__c=PO_P2PAtt_OpportunityHandler.getP2PAttCanonePricebook(c).PO_Commercial_element__c;
// 	    	PO_P2PAtt_OpportunityHandler.newPricebook.name=c.PO_Richiesta_a_fattibilit__r.caseNumber+'_';//+PO_P2PAtt_OpportunityHandler.getP2PAttCanonePricebook(c).PO_Commercial_element__r.name;
// 	    	insert PO_P2PAtt_OpportunityHandler.newPricebook;
// 	    	return PO_P2PAtt_OpportunityHandler.newPricebook;
//     	}
//     }
//     public static opportunity calculateParentOpp(opportunity o,list<Opportunity> oppChildList){
//     	Decimal TotaleContributi=0.00;
//     	Decimal TotaleCostiAggiuntivi=0.00;
//     	Decimal TotaleCanoni=0.00;
//         for(opportunity opp:oppChildList){
//         	opp.PO_Offerta_totale__c=o.Id;
//     		TotaleContributi+=opp.PO_Contributo_attivazione_collegamento__c;
//         	TotaleCostiAggiuntivi+=opp.PO_CostiAggiuntiviCollegamento__c;
//         	TotaleCanoni+=opp.PO_Canone_collegamento__c;
//         }
//         o.PO_Totale_contributi_attivazione__c=TotaleContributi;
//     	o.PO_Totale_costi_aggiuntivi__c=TotaleCostiAggiuntivi;
//     	o.PO_Totale_canoni__c=TotaleCanoni;
//     	return o;
//     }
   
}