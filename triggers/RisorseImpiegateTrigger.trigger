trigger RisorseImpiegateTrigger on OF_CQS_Risorse_Impiegate__c (before insert,after insert) {
	
	// EC Start 2018 - 10 - 22 
	//verifichiamo che per la data CQS_RisImp_Data__c selezionata non esistano altri record.
	
	if((Trigger.isBefore)&&(Trigger.isInsert))  { 
		
		system.debug('@@@@@@@@@@@@@@@@@ Risorse impiegate parte il trigger in before insert');
	
		Map<String,String> formattedProgettoData = new Map<String,String>();
		for(OF_CQS_Risorse_Impiegate__c var : [SELECT id, CQS_RisImp_Progetto__c, CQS_RisImp_Data__c, CQS_RisImp_TipoRapporto__c FROM OF_CQS_Risorse_Impiegate__c  WHERE CQS_RisImp_TipoRapporto__c = 'Consuntivo']){
   			//formattedProgettoData.add(var.CQS_RisImp_Progetto__c + '_' + var.CQS_RisImp_Data__c);
   			String sData = String.ValueOF(var.CQS_RisImp_Data__c).left(10).remove('-').trim();
   			formattedProgettoData.put(var.CQS_RisImp_Progetto__c + '_' + sData,var.CQS_RisImp_Progetto__c + '_' + sData);
   			system.debug('@@@@@@@@@@@EC stampiamo per la prima volta solo la mappa formattedProgettoData ' + formattedProgettoData);
   			System.debug('@@@@@@@@@@@EC nel primo for il record di Risorse Impiegate appena inserito, var, vale ' + var);
   		}
   		system.debug('@@@@@@@@@@EC fuori dal primo for prima del secondo. La mappa formattedProgettoData è ' + formattedProgettoData);

		for(OF_CQS_Risorse_Impiegate__c var1 : Trigger.New){
			if(var1.CQS_RisImp_TipoRapporto__c=='Consuntivo'){ 
				String progId2=var1.CQS_RisImp_Progetto__c; 
				system.debug('@@@@@@@@@@@EC progId2 è ' + progId2);
				String sData2 = String.ValueOF(var1.CQS_RisImp_Data__c).left(10).remove('-').trim();
				system.debug('@@@@@@@@@@@EC sData2 è ' + sData2);
				System.debug('@@@@@@@@@@@EC il record di Risorse Impiegate PRIMO IF  var1.CQS_RisImp_TipoRapporto__c  ' + var1.CQS_RisImp_TipoRapporto__c);
				System.debug('@@@@@@@@@@@EC il record di Risorse Impiegate PRIMO IF  var1.CQS_RisImp_Progetto__c + _ + var1.CQS_RisImp_Data__c  ' + var1.CQS_RisImp_Progetto__c + '_' + sData2);
				system.debug('@@@@@@@@@@@EC stampiamo per la seconda volta solo la mappa formattedProgettoData ' + formattedProgettoData);
				String stringaToCheck = formattedProgettoData.get(progId2 + '_' + sData2);
				System.debug('@@@@@@@@@@@EC stringaToCheck è ' + stringaToCheck);
				system.debug('@@@@@@@@@@@EC CIAONE formattedProgettoData.containsKey(var1.CQS_RisImp_Progetto__c + _ + var1.CQS_RisImp_Data__c) è ' + formattedProgettoData.containsKey(var1.CQS_RisImp_Progetto__c + '_' + sData2));
	  			//if(formattedProgettoData.containsKey(var1.CQS_RisImp_Progetto__c + '_' + var1.CQS_RisImp_Data__c) == true ) {
	  			if(stringaToCheck!=null && stringaToCheck!='' && stringaToCheck == String.ValueOF(var1.CQS_RisImp_Progetto__c) + '_' + String.ValueOF(var1.CQS_RisImp_Data__c).left(10).remove('-').trim()){
	  			system.debug('@@@@@@@@@@@EC CIAONE 2!');
	  			var1.addError('Non è possibile inserire più di un consuntivo con la stessa data');
	  			System.debug('@@@@@@@@@@@EC il record di Risorse Impiegate SECONDO IF  var1.CQS_RisImp_Progetto__c  ' + var1.CQS_RisImp_Progetto__c + ', sData2' + sData2);
				}
			}
			else{
			System.debug('@@@@@@@@@EC else il var1.CQS_RisImp_TipoRapporto__c ' + var1.CQS_RisImp_TipoRapporto__c);
			}
		}
	

}
// EC end 2018 - 10 - 22

 if((Trigger.isAfter)&&(Trigger.isInsert))  {
    
    system.debug('@@@@@@@@@@@@@@@@@ Risorse impiegate parte il trigger in after insert');
    
    //EC start share 2018 - 10 - 18
     Set<Id> SetProgetti = new Set<Id>();
     Map<Id,Id> mapRisImpProg = new Map<Id,Id>();
    //EC end share 2018 - 10 - 18
    
    //      'Consuntivo'
    Set<Id> risImpIdSet = new Set<Id>();
    Integer SommaFTEeffettive;
    Set<String> ldoSet = new Set<String>();
    Set<String> meseAnnoSt = new Set<String>();
    Integer progressivoSettimanaleImp1;
    Integer progressivoSettimanaleImp2;
    Integer progressivoSettimanaleImp3;
    Integer progressivoSettimanaleImp4;
    Integer progressivoSettimanaleImp5;
    
    Map<String, List<OF_CQS_Risorse_Impiegate__c>> ldoMaRisImp = new Map<String, List<OF_CQS_Risorse_Impiegate__c>>();
    for(OF_CQS_Risorse_Impiegate__c risImp: Trigger.New){
        if(risImp.CQS_RisImp_TipoRapporto__c=='Consuntivo') {
            
            risImpIdSet.add(risImp.id);
            SetProgetti.add(risImp.CQS_RisImp_Progetto__c); //EC 2018 - 10 - 18
       		mapRisImpProg.put(risImp.id,risImp.CQS_RisImp_Progetto__c); //EC 2018 - 10 - 18
        }
        
    }
    List<OF_CQS_Risorse_Impiegate__c> newlist= new List<OF_CQS_Risorse_Impiegate__c>();
    List<OF_CQS_Risorse_Impiegate__c> oldlist= new List<OF_CQS_Risorse_Impiegate__c>();
    if(!risImpIdSet.isEmpty()){
       system.debug('@@@@@@@@@@@@@@@@@ Risorse impiegate risImpIdSet non è vuoto'); 
        for(OF_CQS_Risorse_Impiegate__c oldRi:[Select id, CQS_RisImp_Data__c, CQS_RI_LDO__c, CQS_RisImp_Impresa_Mandataria__c,
                                                            CQS_RisImp_Somma_FTE_formula1__c,CQS_RisImp_TipoRapporto__c,OF_CQS_Comune_Ris_Imp__c,
                                                            CQS_RisImp_MeseAnno_Riferimento_Formula__c,CQS_RisImp_FTE_effettive__c,CQS_RisImp_Somma_FTE__c,
                                                            CQS_RisImp_NsettAnno__c,CQS_RisImp_ProgrSett_Contrattista1__c,CQS_RisImp_ProgrSett_Contrattista2__c,
                                                            CQS_RisImp_ProgrSett_Contrattista3__c,CQS_RisImp_ProgrSett_Contrattista4__c,
                                                            CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName, 
                                                            CQS_RisImp_Somma_FTE_formula2__c, CQS_RisImp_Somma_FTE_formula3__c, CQS_RisImp_Somma_FTE_formula4__c,
                                                            CQS_RisImp_Pian_Sett_Contrattista5__c,CQS_RisImp_FTE_altre_attivita5__c,
                                                            CQS_RisImp_FTE_lavori_civili5__c,CQS_RisImp_FTE_ldelivery_vertadd5__c,CQS_RisImp_FTE_lavoriOttici_posacavo5__c,
                                                            CQS_RisImp_FTElavori_ottici_giunzcoll5__c,CQS_RisImp_Somma_FTE5__c,CQS_RisImp_Somma_FTE_formula5__c,
                                                            OF_CQS_Contrattista_Lotto5__c,CQS_RisImp_ProgrSett_Contrattista5__c
                                                            from OF_CQS_Risorse_Impiegate__c 
              where ID=:risImpIdSet]){
                 OF_CQS_Risorse_Impiegate__c ri = new OF_CQS_Risorse_Impiegate__c();
                 ri.OF_CQS_N_B_RISIMP__c= oldRi.CQS_RisImp_MeseAnno_Riferimento_Formula__c+oldRi.CQS_RI_LDO__c;
                  ri.CQS_RisImp_Somma_FTE__c=oldRi.CQS_RisImp_Somma_FTE_formula1__c;
                	system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@EC LDO set lo andremo a popolare con oldRi.CQS_RI_LDO__c. oldRi è ' + oldRi);
                  	system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@EC  oldRi.CQS_RisImp_Data__c. oldRi è ' + oldRi.CQS_RisImp_Data__c);
                 	system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@EC nello specifico oldRi.CQS_RI_LDO__c.  è ' + oldRi.CQS_RI_LDO__c + ', oldRi.CQS_RisImp_TipoRapporto__c ' +  oldRi.CQS_RisImp_TipoRapporto__c + ', oldRi.CQS_RisImp_NsettAnno__c ' + oldRi.CQS_RisImp_NsettAnno__c);
                      oldlist.add(oldRi);
                      newlist.add(ri);
                      ldoSet.add(oldri.CQS_RI_LDO__c);
                      meseAnnoSt.add(oldRi.CQS_RisImp_MeseAnno_Riferimento_Formula__c);
                  }
                  system.debug('@@@@@@@@@@@@@@@@EC (1) newList conta ' +  newlist.size() + ' record');
                  system.debug('@@@@@@@@@@@@@@@@EC (1) newList è così popolata: ' +  newlist);
            
            List<OF_CQS_Risorse_Impiegate__c> Pianlist = [Select id, CQS_RisImp_Data__c, CQS_RI_LDO__c, CQS_RisImp_Impresa_Mandataria__c,
                                                                CQS_RisImp_Somma_FTE_formula1__c,CQS_RisImp_TipoRapporto__c,OF_CQS_Comune_Ris_Imp__c,
                                                                CQS_RisImp_MeseAnno_Riferimento_Formula__c,CQS_RisImp_FTE_effettive__c,CQS_RisImp_Somma_FTE__c,
                                                                CQS_RisImp_NsettAnno__c,CQS_RisImp_ProgrSett_Contrattista1__c,CQS_RisImp_ProgrSett_Contrattista2__c,
                                                                CQS_RisImp_ProgrSett_Contrattista3__c,CQS_RisImp_ProgrSett_Contrattista4__c,
                                                                CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName, 
                                                                CQS_RisImp_Somma_FTE_formula2__c, CQS_RisImp_Somma_FTE_formula3__c, CQS_RisImp_Somma_FTE_formula4__c,
                                                                CQS_RisImp_Pian_Sett_Contrattista5__c,CQS_RisImp_FTE_altre_attivita5__c,
                                                                CQS_RisImp_FTE_lavori_civili5__c,CQS_RisImp_FTE_ldelivery_vertadd5__c,CQS_RisImp_FTE_lavoriOttici_posacavo5__c,
                                                                CQS_RisImp_FTElavori_ottici_giunzcoll5__c,CQS_RisImp_Somma_FTE5__c,CQS_RisImp_Somma_FTE_formula5__c,
                                                                OF_CQS_Contrattista_Lotto5__c,CQS_RisImp_ProgrSett_Contrattista5__c
                                                                from OF_CQS_Risorse_Impiegate__c 
                                                            where CQS_RisImp_TipoRapporto__c ='Pianificato' and CQS_RI_LDO__c in:ldoSet and CQS_RisImp_MeseAnno_Riferimento_Formula__c in : meseAnnoSt];
            system.debug('@@@@@@@@@@@@@@@@ò LDO è ' + ldoSet + ' meseAnnoSt è ' + meseAnnoSt);
            for(OF_CQS_Risorse_Impiegate__c pian:Pianlist){
                  system.debug('@@@@@@@@@@@@@@@@@ nel for di Pianlist'); 
                for(OF_CQS_Risorse_Impiegate__c cons:newlist){
                    if(cons.OF_CQS_N_B_RISIMP__c==pian.CQS_RisImp_MeseAnno_Riferimento_Formula__c+pian.CQS_RI_LDO__c){
                        system.debug('@@@@@ 1');
                        if(String.isBlank(pian.CQS_RisImp_FTE_effettive__c)){
                            system.debug('@@@@@ 2');
                            pian.CQS_RisImp_FTE_effettive__c=String.valueOf(cons.CQS_RisImp_Somma_FTE__c);
                        }
                        else{
                            system.debug('@@@@@ 3');
                            pian.CQS_RisImp_FTE_effettive__c=String.valueOf(integer.valueOf(pian.CQS_RisImp_FTE_effettive__c)+Integer.valueOf(cons.CQS_RisImp_Somma_FTE__c));
                        }
                        
                    }
                    
                }
                
            }
              
               //EC 2018 - 10 - 16
 					system.debug('@@@@@@@@@@@@@@@@EC Fuori al primo for');
 						
 					system.debug('@@@@@@@@@@@@@@@@EC (2) stampiamo nuovamente newList conta ' +  newlist.size() + ' record');
                  	system.debug('@@@@@@@@@@@@@@@@EC (2) stampiamo nuovamente newList è così popolata: ' +  newlist);
                    List<OF_CQS_Risorse_Impiegate__c> pianSSettlist = [Select id, CQS_RisImp_Data__c, CQS_RI_LDO__c, CQS_RisImp_Impresa_Mandataria__c,
                                                                CQS_RisImp_Somma_FTE_formula1__c,CQS_RisImp_TipoRapporto__c,OF_CQS_Comune_Ris_Imp__c,
                                                                CQS_RisImp_MeseAnno_Riferimento_Formula__c,CQS_RisImp_FTE_effettive__c,CQS_RisImp_Somma_FTE__c,
                                                                CQS_RisImp_NsettAnno__c,CQS_RisImp_ProgrSett_Contrattista1__c,CQS_RisImp_ProgrSett_Contrattista2__c,
                                                                CQS_RisImp_ProgrSett_Contrattista3__c,CQS_RisImp_ProgrSett_Contrattista4__c,
                                                                CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName, 
                                                                CQS_RisImp_Somma_FTE_formula2__c, CQS_RisImp_Somma_FTE_formula3__c, CQS_RisImp_Somma_FTE_formula4__c,
                                                                CQS_RisImp_Somma_FTE4__c,CQS_RisImp_Pian_Sett_Contrattista5__c,CQS_RisImp_FTE_altre_attivita5__c,
                                                                CQS_RisImp_FTE_lavori_civili5__c,CQS_RisImp_FTE_ldelivery_vertadd5__c,CQS_RisImp_FTE_lavoriOttici_posacavo5__c,
                                                                CQS_RisImp_FTElavori_ottici_giunzcoll5__c,CQS_RisImp_Somma_FTE5__c,CQS_RisImp_Somma_FTE_formula5__c,
                                                                OF_CQS_Contrattista_Lotto5__c,CQS_RisImp_ProgrSett_Contrattista5__c
                                                                from OF_CQS_Risorse_Impiegate__c 
                                                            where CQS_RisImp_TipoRapporto__c ='Pianificato Settimanale' and CQS_RI_LDO__c in:ldoSet and CQS_RisImp_MeseAnno_Riferimento_Formula__c in : meseAnnoSt];
            		system.debug('@@@@@@@@@@@@@@@@EC pianSSettlist.size() è ' + pianSSettlist.size() + ', LDO è ' + ldoSet + ' meseAnnoSt è ' + meseAnnoSt);
           			 for(OF_CQS_Risorse_Impiegate__c pianS:pianSSettlist){
           			 	 system.debug('@@@@@@@@@@@@@@@@@ nel for di pianSSettlist'); 
           			 	 system.debug('@@@@@@@@@@@@@@@@@ oldList conta: ' + oldlist.size() + ' record');
           			 	 system.debug('@@@@@@@@@@@@@@@@@ oldList vale: ' + oldlist);
           			 	 
                		for(OF_CQS_Risorse_Impiegate__c cons1:oldlist){
                			 system.debug('@@@@@@@@@@@@@@@@@ nel secondo for di pianSSettlist, cons1.CQS_RisImp_NsettAnno__c è ' + cons1.CQS_RisImp_NsettAnno__c + ', pianS.CQS_RisImp_NsettAnno__c: ' + pianS.CQS_RisImp_NsettAnno__c); 
	                        if(cons1.CQS_RisImp_NsettAnno__c==pianS.CQS_RisImp_NsettAnno__c){
	                        	 system.debug('@@@@@@@@@@@@@@@@@ nel primo if di pianSSettlist, cons1.CQS_RisImp_NsettAnno__c è ' + cons1.CQS_RisImp_NsettAnno__c + ', pianS.CQS_RisImp_NsettAnno__c: ' + pianS.CQS_RisImp_NsettAnno__c);
		                        if(cons1.CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName=='OF_CQS_Ati_Imprese_Mandatarie' || cons1.CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName=='CQS_Imprese_in_raggruppamento'){
		                        	system.debug('@@@@@@@@EC è il caso di RTI come impresa mandataria, infatti cons1.CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName è ' + cons1.CQS_RisImp_Impresa_Mandataria__r.RecordType.DeveloperName);
			                       	System.debug('@@@@@@@@EC vediamo che ce mette pianS.CQS_RisImp_ProgrSett_Contrattista1__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista1__c);
                                    if(String.isBlank(pianS.CQS_RisImp_ProgrSett_Contrattista1__c)){
			                            system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista1__c non è mai stata valorizzata quindi assegnamo il valore CQS_RisImp_Somma_FTE__c');
			                            pianS.CQS_RisImp_ProgrSett_Contrattista1__c=String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula1__c);
										system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista1__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista1__c);			                            
			                            pianS.CQS_RisImp_ProgrSett_Contrattista2__c=String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula2__c);
			                            system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista2__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista2__c);
			                            pianS.CQS_RisImp_ProgrSett_Contrattista3__c=String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula3__c);
			                            system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista3__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista3__c);
			                            pianS.CQS_RisImp_ProgrSett_Contrattista4__c=String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula4__c);
		                        		system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista4__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista4__c);
		                        		pianS.CQS_RisImp_ProgrSett_Contrattista5__c=String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula5__c);// EC contrattista 5 2018-10-22
		                        		system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista5__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista5__c);
		                        	}
		                        	else{
			                            system.debug('@@@@@EC  nel for di pianSSettlist ELSE');
			                            pianS.CQS_RisImp_ProgrSett_Contrattista1__c=String.valueOf(integer.valueOf(pianS.CQS_RisImp_ProgrSett_Contrattista1__c)+Integer.valueOf(cons1.CQS_RisImp_Somma_FTE_formula1__c));
			                            system.debug('@@@@@EC nel for di pianSSettlist ELSE CQS_RisImp_ProgrSett_Contrattista1__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista1__c);
			                            pianS.CQS_RisImp_ProgrSett_Contrattista2__c=String.valueOf(integer.valueOf(pianS.CQS_RisImp_ProgrSett_Contrattista2__c)+Integer.valueOf(cons1.CQS_RisImp_Somma_FTE_formula2__c));
			                            pianS.CQS_RisImp_ProgrSett_Contrattista3__c=String.valueOf(integer.valueOf(pianS.CQS_RisImp_ProgrSett_Contrattista3__c)+Integer.valueOf(cons1.CQS_RisImp_Somma_FTE_formula3__c));
			                            pianS.CQS_RisImp_ProgrSett_Contrattista4__c=String.valueOf(integer.valueOf(pianS.CQS_RisImp_ProgrSett_Contrattista4__c)+Integer.valueOf(cons1.CQS_RisImp_Somma_FTE_formula4__c));
		                        		system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista2__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista2__c + ', CQS_RisImp_ProgrSett_Contrattista3__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista3__c + ', CQS_RisImp_ProgrSett_Contrattista4__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista4__c);
		                        		pianS.CQS_RisImp_ProgrSett_Contrattista5__c=String.valueOf(integer.valueOf(pianS.CQS_RisImp_ProgrSett_Contrattista5__c)+Integer.valueOf(cons1.CQS_RisImp_Somma_FTE_formula5__c)); //EC contrattista 5 2018 - 10 - 22
		                        		system.debug('@@@@@EC nel for di pianSSettlist IF CQS_RisImp_ProgrSett_Contrattista2__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista2__c + ', CQS_RisImp_ProgrSett_Contrattista3__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista3__c + ', CQS_RisImp_ProgrSett_Contrattista5__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista5__c);
		                        	}
		                        	
		                        }
		                        
		                       	 else{
		                        	system.debug('@@@@@@@@EC è il caso di Impresa Singola come impresa mandataria');
		                        	if(String.isBlank(pianS.CQS_RisImp_ProgrSett_Contrattista1__c)){
			                            system.debug('@@@@@EC CQS_RisImp_ProgrSett_Contrattista1__c non è mai stata valorizzata quindi assegnamo il valore CQS_RisImp_Somma_FTE__c');
			                            system.debug('@@@@@EC cons1.CQS_RisImp_Somma_FTE_formula1__c è ' + cons1.CQS_RisImp_Somma_FTE_formula1__c); 
			                            pianS.CQS_RisImp_ProgrSett_Contrattista1__c=String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula1__c);
			                            system.debug('@@@@@@@@EC String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula1__c) è ' + String.valueOf(cons1.CQS_RisImp_Somma_FTE_formula1__c));
			                            pianS.CQS_RisImp_ProgrSett_Contrattista2__c='0';
			                            pianS.CQS_RisImp_ProgrSett_Contrattista3__c='0';
			                            pianS.CQS_RisImp_ProgrSett_Contrattista4__c='0';
			                            pianS.CQS_RisImp_ProgrSett_Contrattista5__c='0';
			                            system.debug('@@@@@EC nel for di pianSSettlist If Impresa Singola CQS_RisImp_ProgrSett_Contrattista1__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista1__c);
		                        	}
		                        	else{
			                            system.debug('@@@@@ 3');
			                            pianS.CQS_RisImp_ProgrSett_Contrattista1__c=String.valueOf(integer.valueOf(pianS.CQS_RisImp_ProgrSett_Contrattista1__c)+Integer.valueOf(cons1.CQS_RisImp_Somma_FTE_formula1__c));
		                         		pianS.CQS_RisImp_ProgrSett_Contrattista2__c='0';
			                            pianS.CQS_RisImp_ProgrSett_Contrattista3__c='0';
			                            pianS.CQS_RisImp_ProgrSett_Contrattista4__c='0';
			                            pianS.CQS_RisImp_ProgrSett_Contrattista5__c='0';
			                            system.debug('@@@@@EC nel for di pianSSettlist ELSE di Impresa Singola,  CQS_RisImp_ProgrSett_Contrattista1__c: ' +  pianS.CQS_RisImp_ProgrSett_Contrattista1__c  + ' CQS_RisImp_ProgrSett_Contrattista2__c è ' + pianS.CQS_RisImp_ProgrSett_Contrattista2__c + ', CQS_RisImp_ProgrSett_Contrattista3__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista3__c + ', CQS_RisImp_ProgrSett_Contrattista4__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista4__c + ', CQS_RisImp_ProgrSett_Contrattista5__c: ' + pianS.CQS_RisImp_ProgrSett_Contrattista5__c);
		                        	}
		                        }
	                         }   
	                
	           			 }
          			 }	
           	
           	//EC end 2018 - 10 - 16   	
            
            update PianList;
            update pianSSettlist;

			system.debug('MM - la mappa mapRisImpProg contiene:'+ mapRisImpProg);
        	system.debug('MM - il setProgetti contiene:' +setProgetti);
        	//system.debug('@@@@ CQS_RisorseImpiegateController_Test.checK: '+CQS_RisorseImpiegateController_Test.checK);
        	CQS_Utils.setApexSharingRisImp(mapRisImpProg,setProgetti);
        }
        
    }

}