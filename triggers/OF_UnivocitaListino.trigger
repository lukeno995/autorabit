//27-02-2017 Davide Gagliardi
//Trigger per gestire l'univocità del listino e le logiche sulle date
//07/05/2017 DG modificata la logica per la fase 2.
//  -Univocità viene fatta considerando più campi (vengono conisderati anche i campi della sezione apparati)
//  -Gestione del listino di default (per ogni billing element ci deve essere configurato solo un listino di default)

trigger OF_UnivocitaListino on OF_Listino__c (before insert, before update) {
    OF_Listino__c l = trigger.new[0];
    //boolean check;
    
    //set<id> ids = new set<id>();
    //24/07/2017 DG Modifica Canone Open stream
    //set<id> idsBE = new set<id>();
    //END 24/07/2017 DG Modifica
    //for(OF_Listino__c lis : trigger.new){
     //   ids.add(lis.recordtypeID);
        //24/07/2017 DG Modifica Canone Open stream
        //idsBE.add(lis.OF_ServizioBillingElement__c);
        //END 24/07/2017 DG Modifica
    //}
    //system.debug('DG_OF_UnivocitaListino - ids: ' + ids);
    //system.debug('DG_OF_UnivocitaListino - idsBE: ' + idsBE);
    
    /*24/07/2017 DG Modifica Canone Open stream
    //Creo una mappa tra id e nome del BE. Mi serve quando faccio il controllo sul nome. Non fa accedere direttamente al nome del BE ma solo all'id del ServizioBillingElement
    list<OF_ServizioBillingElement__c> ServBEList = [select id, name from OF_ServizioBillingElement__c where id IN: idsBE];    
    
    map<id, string> NameBEMap = new map<id, string>();
    
    for(OF_ServizioBillingElement__c SBE : ServBEList)
    {
        NameBEMap.put(SBE.id, SBE.name);
    }
    system.debug('DG_OF_UnivocitaListino - NameBEMap: ' + NameBEMap);
    //END 24/07/2017 DG Modifica
    
    //08/05/2017 Aggiunti i campi per l'univocità del listino default
    list<OF_Listino__c> ListiniToCompare = new list<OF_Listino__c> ([select id, name, OF_ServizioBillingElement__c, OF_ServizioBillingElement__r.OF_BillingElement__r.name, OF_DataInizioValidita__c, 
                                                                            OF_DataFineValidita__c, OF_IDContract__c, OF_ListinoDefault__c, RecordTypeId, RecordType.name, OF_TipologiaApparato__c, 
                                                                            OF_ProgettoSpeciale__c, OF_Promozione__c, OF_ClusterPromozione__c, OF_CodiceProgettoSpeciale__c,
                                                                            PO_Servizio_Billing_Element_Fattibilita__c,PO_Servizio_Billing_Element_Fattibilita__r.OF_BillingElement__r.name,OF_Servizio__c
                                                                     from OF_Listino__c
                                                                     where recordtypeID IN: ids]);
    system.debug('DG_OF_UnivocitaListino - ListiniToCompare: ' + ListiniToCompare);
    
    String ListinoGPONPassivaRTId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
    String ListinoOpenStreamRTId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
    String ListinoExtraRTId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Extra').getRecordTypeId();
    string ListinoFattRT = Schema.SObjectType.OF_LIstino__c.getRecordTypeInfosByName().get('Fattibilità').getRecordTypeId();
    system.debug('DG_OF_UnivocitaListino - ListinoGPONPassivaRTId: ' + ListinoGPONPassivaRTId + ' ----- ListinoOpenStreamRTId: ' + ListinoOpenStreamRTId + '----- ListinoExtraRTId: ' + ListinoExtraRTId);
    
    for(OF_Listino__c lis : trigger.new){
        
        for(OF_Listino__c lis1 : ListiniToCompare){
            
            if(lis.RecordTypeId == lis1.RecordTypeId){
                
                system.debug('DG_OF_UnivocitaListino - dentro doppio ciclo e dentro if');
                
              
                //Per ogni billing element non ci può essere più di un listino default (checkbox OF_ListinoDefault__c = true)
                //Listini non fattibilità
                //07/08/2017 Modifica CRM - aggiunto if
                if(lis.RecordTypeId != ListinoFattRT)
                {
                    if(OF_UtilitiesUnivocitaListino.UnivocitaDefault(lis, lis1) == true){
                        system.debug('DG_OF_UnivocitaListino - Dentro UnivocitaDefault');
              
                        if(trigger.isInsert){
                            lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreUnivLisDefault(lis1), false);
                            break;
                        }
                        //In update non devo considerare il listino che si sta aggiornando
                        if((trigger.isUpdate) && (trigger.oldMap.get(lis.Id).id != lis1.Id)){
                            lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreUnivLisDefault(lis1), false);
                            break;
                        }
                    }
                //Listini fattibilità
                //07/08/2017 Modifica CRM - aggiunto controllo univocità per fattibilità
                }else{
                    /*if(OF_UtilitiesUnivocitaListino.UnivocitaDefaultFattibi(lis, lis1) == true){
                        system.debug('DG_OF_UnivocitaListino - Dentro UnivocitaDefaultFattibi');
                        /*******STAMPO GLI ERRORI SE PRESENTI*******
                        if(trigger.isInsert){
                            lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreUnivLisDefaultFatt(lis1), false);
                            break;
                        }
                        //In update non devo considerare il listino che si sta aggiornando
                        if((trigger.isUpdate) && (trigger.oldMap.get(lis.Id).id != lis1.Id)){
                            lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreUnivLisDefaultFatt(lis1), false);
                            break;
                        }
                    }
                }

                check = false;
                //Controllo GPON Passiva
                if(lis.RecordTypeid == ListinoGPONPassivaRTId){
                        system.debug('DG_OF_UnivocitaListino - dentro GPON Passiva');
                    check = OF_UtilitiesUnivocitaListino.UnivocitaDetailPassivi(lis, lis1);
                }
                //30/10/2017 Modifica canone
                /*Controllo Open Stream - 24/07/2017 DG Modifica Canone Open stream aggiunto "&& NameBEMap.get(lis.OF_ServizioBillingElement__c) != 'Canone'"
                if(lis.RecordTypeId == ListinoOpenStreamRTId && NameBEMap.get(lis.OF_ServizioBillingElement__c) != 'Canone'){
                        system.debug('DG_OF_UnivocitaListino - dentro Open Stream');
                    check = OF_UtilitiesUnivocitaListino.UnivocitaDetailOpenStream(lis, lis1);
                //24/07/2017 DG Modifica Canone Open stream
                }else if(lis.RecordTypeId == ListinoOpenStreamRTId && NameBEMap.get(lis.OF_ServizioBillingElement__c) == 'Canone' && lis1.OF_ServizioBillingElement__r.OF_BillingElement__r.name == 'Canone')
                    {
                        check = OF_UtilitiesUnivocitaListino.UnivocitaCanone(lis, lis1);
                    }
             
                if(lis.RecordTypeId == ListinoOpenStreamRTId){
                    check = OF_UtilitiesUnivocitaListino.UnivocitaDetailOpenStream(lis, lis1);
                }
                //30/10/2017 END
                
                //Controllo Extra
                if(lis.RecordTypeId == ListinoExtraRTId){
                        system.debug('DG_OF_UnivocitaListino - dentro Extra');
                    check = OF_UtilitiesUnivocitaListino.UnivocitaDetailExtra(lis, lis1);
                }
                        system.debug('DG_OF_UnivocitaListino - check: ' + check);
             

                if(check == true)
                {
                    if(trigger.isInsert){
                        lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreUnivLis(lis1), false);
                        break;
                    }
                    //In update non devo considerare il listino che si sta aggiornando
                    if((trigger.isUpdate) && (trigger.oldMap.get(lis.Id).id != lis1.Id)){
                        lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreUnivLis(lis1), false);
                        break;
                    }
                }
                
              
                else{
                    check = false;
                    //Controllo GPON Passiva
                    if(lis.RecordTypeId == ListinoGPONPassivaRTId){
                        system.debug('DG_OF_UnivocitaListino - dentro GPON passiva');
                        check = OF_UtilitiesUnivocitaListino.UnivocitaDatePassivi(lis, lis1);
                    }
                    //Controllo Open Stream - 24/07/2017 DG Modifica Canone Open stream aggiunto "&& NameBEMap.get(lis.OF_ServizioBillingElement__c) != 'Canone'"
                    //30/10/2017 Modifica canone
                    //if(lis.RecordTypeId == ListinoOpenStreamRTId  && NameBEMap.get(lis.OF_ServizioBillingElement__c) != 'Canone'){
                    if(lis.RecordTypeId == ListinoOpenStreamRTId){
                        system.debug('DG_OF_UnivocitaListino - dentro Open Stream');
                        check = OF_UtilitiesUnivocitaListino.UnivocitaDateOpenStream(lis, lis1);
                    }
                    //Controllo Extra    
                    if(lis.RecordTypeId == ListinoExtraRTId){
                        system.debug('DG_OF_UnivocitaListino - dentro Extra');
                        check = OF_UtilitiesUnivocitaListino.UnivocitaDateExtra(lis, lis1);
                    }
                    system.debug('DG_OF_UnivocitaListino - check: ' + check);

                    if(check == true){
                           
                        if(trigger.isInsert){
                            lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreDate(lis1), false);
                            break;
                        }
                        //In update non devo considerare il listino che si sta aggiornando
                        if((trigger.isUpdate) && (trigger.oldMap.get(lis.Id).id != lis1.Id)){
                            lis.adderror(OF_UtilitiesUnivocitaListino.MsgErroreDate(lis1), false);
                            break;
                        }
                    }
                }
            }
        }
    }*/
}