public class OF_CO_OLO_EntryChecks {  
    public static case c;
   
    //AA: Metodo per syncChecks Portale
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksChangeSetup(OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request deact, EOF_EAI_Service_Log__c slPort){
        OF_CO_GE_Utils.PORTAL=true;
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksChangeSetup(deact);
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_CO_GE_Utils.caseOriginale.status;
            slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_CO_GE_Utils.caseOriginale.Id);
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now();
        }
        else{
        	slPort.EOF_MOtivazione__c=resp.motivazione;
        	if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
        		slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
        	}
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        return slPort;
    } 
    //AA: Metodo check values per "OLO_ChangeSetup_OpenStream"
    public static OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksChangeSetup(OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request deact){
        try{
            //Done AA: Modificare in "ChangeOrder"
            OF_CO_GE_Utils.OPNAme='ChangeOrder da OLO';
            
            OF_CO_GE_Utils.tmpl = new TEMPLOG__c();
            OF_CO_GE_Utils.tmpl.Name= Deact.CODICE_ORDINE_OLO +' - '+OF_CO_GE_Utils.OPName+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
            OF_CO_GE_Utils.tmpl.Timestamp__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome');
            OF_CO_GE_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ Deact.codice_ordine_olo;
            OF_CO_GE_Utils.tmpl.Type__c ='T';
            // finisce qui
                    
            //Done AA: Aggiungere al metodo "create_EAI_Log" instance of per gestione log del "ChangeOrder"
            //creo il log della fiberrequest
            OF_CO_GE_Utils.slOLOSF = OF_CO_GE_Utils.create_EAI_Log(deact);
            System.debug('****** SYNC CHECK !!! REQUEST LOG ' + OF_CO_GE_Utils.slOLOSF);
            System.debug('****** SYNC CHECK !!! REQUEST LOG ' + OF_CO_GE_Utils.slOLOSF.Id);

            //Istanzio l'oggetto di response
            OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse res = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
            //Setto l'esito ad ok
            res.esito='0'; 

            //CONTROLLO CODICE OPERATORE
            if(string.isblank(deact.CODICE_OPERATORE)){
                //Done AA: Aggiungere al metodo "syncError" instance of per gestione Ack/Nack del "ChangeOrder"
                return OF_CO_GE_Utils.syncError (deact,'A_K9','CODICE_OPERATORE');
            }
            Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            Boolean olo_found = false;
            
            for(Schema.PicklistEntry s : ple){
                if(deact.CODICE_OPERATORE == s.getLabel()){
                    olo_found = true;
                }
            }       
            if(!olo_found) {
                return OF_CO_GE_Utils.syncError (deact,'A_K10','CODICE_OPERATORE');
            }
            //FINE CONTROLLO CODICE OPERATORE
            //CONTROLLI CODICE_ORDINE_OLO
            if(string.isblank(deact.CODICE_ORDINE_OLO) || deact.CODICE_ORDINE_OLO.length()>18 || deact.CODICE_ORDINE_OLO.contains('�')){
                if(string.isblank(deact.CODICE_ORDINE_OLO)){
                    return OF_CO_GE_Utils.syncError (deact,'A_K9','CODICE_ORDINE_OLO');
                }
                else if(deact.CODICE_ORDINE_OLO.length()>18){
                    return OF_CO_GE_Utils.syncError (deact,'A_K10','CODICE_ORDINE_OLO');
                }
                else if(deact.CODICE_ORDINE_OLO.contains('�')){
                    return OF_CO_GE_Utils.syncError (deact,'B04','CODICE_ORDINE_OLO');
                }
            }
            if(OF_CO_GE_Utils.checkCaseOriginale){
                return OF_CO_GE_Utils.syncError (deact,'A08','CODICE_ORDINE_OLO');
            }
            //FINE CONTROLLO CODICE OLO
            //CONTROLLO DATA_NOTIFICA
            if(string.isblank(deact.DATA_NOTIFICA)){
                return OF_CO_GE_Utils.syncError (deact,'A_K9','DATA_NOTIFICA');
            }
            if(!OF_CO_GE_Utils.checkDateTime(deact.DATA_NOTIFICA)){
                return OF_CO_GE_Utils.syncError (deact,'A_K10','DATA_NOTIFICA');
            }   
            //FINE CONTROLLO DATA NOTIFICA
            //CONTROLLO ID_NOTIFICA
            if(string.isblank(deact.ID_NOTIFICA)){
                return OF_CO_GE_Utils.syncError (deact,'A_K9','ID_NOTIFICA');
            }
            else if(deact.ID_NOTIFICA.length()>100){
                return OF_CO_GE_Utils.syncError (deact,'A_K10','ID_NOTIFICA');
            }
            else if(deact.ID_NOTIFICA.contains('�')){
                return OF_CO_GE_Utils.syncError (deact,'B04','ID_NOTIFICA');
            }
            //FINE CONTROLLO ID_NOTIFICA
            //CONTROLLO ID_RISORSA
            if(string.isblank(deact.ID_RISORSA)){
                return OF_CO_GE_Utils.syncError (deact,'A_K9','ID_RISORSA');
            }
            else if(deact.ID_RISORSA.length()>50){
                return OF_CO_GE_Utils.syncError (deact,'A_K10','ID_RISORSA');
            }
            else if(deact.ID_RISORSA.contains('�')){
                return OF_CO_GE_Utils.syncError (deact,'B04','ID_RISORSA');
            }
            //FINE CONTROLLO ID_RISORSA
            // CONTROLLO PROFILO
            if(string.isblank(deact.PROFILO)){
                return OF_CO_GE_Utils.syncError (deact,'A_K9','PROFILO');
            }
            else if(deact.PROFILO.length()>20){
                return OF_CO_GE_Utils.syncError (deact,'A_K10','PROFILO');
            }
            else if(deact.PROFILO.contains('�')){
                return OF_CO_GE_Utils.syncError (deact,'B04','PROFILO');
            }
            //FINE CONTROLLO PROFILO
            
            //CONTROLLI SUI CAMPI OPZIONALI
            //CONTROLLO SUL CAMPO OPZ CODICE_PROGETTO_SPECIALE
            if(!string.isblank(deact.CODICE_PROGETTO_SPECIALE)){
                if(deact.CODICE_PROGETTO_SPECIALE.length()>50){
                    return OF_CO_GE_Utils.syncError (deact,'A_K10','CODICE_PROGETTO_SPECIALE');
                }
                if(deact.CODICE_PROGETTO_SPECIALE.contains('�')){
                    return OF_CO_GE_Utils.syncError (deact,'B04','CODICE_PROGETTO_SPECIALE');
                }
            } 
            //CONTROLLO CAMPO OPZ PROMOZIONE
            if(!string.isblank(deact.PROMOZIONE)){
                if(deact.PROMOZIONE.length()>50){
                    return OF_CO_GE_Utils.syncError (deact,'A_K10','PROMOZIONE');
                }
                if(deact.PROMOZIONE.contains('�')){
                    return OF_CO_GE_Utils.syncError (deact,'B04','PROMOZIONE');
                }
            }
            //CONTROLLO CAMPO OPZ CLUSTER_PROMOZIONE
            if(!string.isblank(deact.CLUSTER_PROMOZIONE)){
                if(deact.CLUSTER_PROMOZIONE.length()>50){
                    return OF_CO_GE_Utils.syncError (deact,'A_K10','CLUSTER_PROMOZIONE');
                }
                if(deact.CLUSTER_PROMOZIONE.contains('�')){
                    return OF_CO_GE_Utils.syncError (deact,'B04','CLUSTER_PROMOZIONE');
                }
            }
            //CONTROLLO CAMPO OPZ NOTE
            if(!string.isblank(deact.NOTE)){
                if(deact.NOTE.length()>255){
                    return OF_CO_GE_Utils.syncError (deact,'A_K10','NOTE');
                }
                if(deact.NOTE.contains('�')){
                    return OF_CO_GE_Utils.syncError (deact,'B04','NOTE');
                }
            }
            //FINE CONTROLLI CAMPI OPZIONALI 
            //CONTROLLI SULLE VLAN
            if(deact.VLAN==null || deact.VLAN.isEmpty()){
	            return OF_CO_GE_Utils.syncError(deact,'A_K9','VLAN');
            }else{
                for (OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan : deact.vlan){
                    //CAMPI OBBLIGATORI!!
                    //CONTROLLO CAMPO KIT_CONSEGNA_VLAN
                    if(string.isblank(vlan.KIT_CONSEGNA_VLAN)){
                        return OF_CO_GE_Utils.syncError (deact,'A_K9','KIT_CONSEGNA_VLAN');
                    }
                    else if(vlan.KIT_CONSEGNA_VLAN.length()>10){
                        return OF_CO_GE_Utils.syncError (deact,'A_K10','KIT_CONSEGNA_VLAN');
                    }
                    else if(vlan.KIT_CONSEGNA_VLAN.contains('�')){
                        return OF_CO_GE_Utils.syncError (deact,'B04','KIT_CONSEGNA_VLAN');
                    }
                    //FINE CONTROLLO CAMPO KIT_CONSEGNA_VLAN
                    //CONTROLLO CAMPO USER_VLAN
                    if(string.isblank(vlan.USER_VLAN)){
                        return OF_CO_GE_Utils.syncError (deact,'A_K9','USER_VLAN');
                    }
                    else if(vlan.USER_VLAN.length()>4){
                        return OF_CO_GE_Utils.syncError (deact,'A_K10','USER_VLAN');
                    }
                    else if(vlan.USER_VLAN.contains('�')){
                        return OF_CO_GE_Utils.syncError (deact,'B04','USER_VLAN');
                    }
                    //FINE CONTROLLO CAMPO USER_VLAN
                    //CONTROLLO CAMPO SERVICE_VLAN
                    if(string.isblank(vlan.SERVICE_VLAN)){
                        return OF_CO_GE_Utils.syncError (deact,'A_K9','SERVICE_VLAN');
                    }
                    else if(vlan.SERVICE_VLAN.length()>4){
                        return OF_CO_GE_Utils.syncError (deact,'A_K10','SERVICE_VLAN');
                    }
                    else if(vlan.SERVICE_VLAN.contains('�')){
                        return OF_CO_GE_Utils.syncError (deact,'B04','SERVICE_VLAN');
                    }
                    //FINE CONTROLLO CAMPO SERVICE_VLAN
                    //CONTROLLO CAMPO PROFILO_VLAN
                    if(string.isblank(vlan.PROFILO_VLAN)){
                        return OF_CO_GE_Utils.syncError (deact,'A_K9','PROFILO_VLAN');
                    }
                    else if(vlan.PROFILO_VLAN.length()>4){
                        return OF_CO_GE_Utils.syncError (deact,'A_K10','PROFILO_VLAN');
                    }
                    else if(vlan.PROFILO_VLAN.contains('�')){
                        return OF_CO_GE_Utils.syncError (deact,'B04','PROFILO_VLAN');
                    }
                    //FINE CONTROLLO CAMPO PROFILO_VLAN
                    //CONTROLLO CAMPO CUSTOMER_VLAN
                    if(string.isblank(vlan.CUSTOMER_VLAN)){
                        return OF_CO_GE_Utils.syncError (deact,'A_K9','CUSTOMER_VLAN');
                    }
                    else if(vlan.CUSTOMER_VLAN.length()>4){
                        return OF_CO_GE_Utils.syncError(deact,'A_K10','CUSTOMER_VLAN');
                    }
                    else if(vlan.CUSTOMER_VLAN.contains('�')){
                        return OF_CO_GE_Utils.syncError(deact,'B04','CUSTOMER_VLAN');
                    }
                    
                    //FINE CONTROLLO CAMPI OBBLIGATORI
                    //CONTROLLI CAMPI OPZIONALI
                    //FINE CONTROLLO CAMPO CUSTOMER_VLAN
                    //CONTROLLO CAMPO MODELLO_DI_SERVIZIO_VLAN
                    if(!string.isblank(vlan.MODELLO_DI_SERVIZIO_VLAN)){
                        if(vlan.MODELLO_DI_SERVIZIO_VLAN.length()>20){
                            return OF_CO_GE_Utils.syncError(deact,'A_K10','MODELLO_DI_SERVIZIO_VLAN');
                        }
                        if(vlan.MODELLO_DI_SERVIZIO_VLAN.contains('�')){
                            return OF_CO_GE_Utils.syncError(deact,'B04','MODELLO_DI_SERVIZIO_VLAN');
                        }
                    }
                    //FINE CONTROLLO CAMPO MODELLO_DI_SERVIZIO_VLAN
                    //CONTROLLO CAMPO INFORMAZIONI_VLAN
                    if(!string.isblank(vlan.INFORMAZIONI_VLAN)){
                        if(vlan.INFORMAZIONI_VLAN.length()>255){
                            return OF_CO_GE_Utils.syncError(deact,'A_K10','INFORMAZIONI_VLAN');
                        }
                        if(vlan.INFORMAZIONI_VLAN.contains('�')){
                            return OF_CO_GE_Utils.syncError(deact,'B04','INFORMAZIONI_VLAN');
                        }
                    }
                    //FINE CONTROLLO CAMPO INFORMAZIONI_VLAN
                }
            }
            //FINE CONTROLLI VLAN

            //Se i controlli sincroni vanno a buon fine inserisco il case ed eseguo le varie operazioni
            if(!OF_CO_GE_Utils.checkRTMap){
                //vado a creare la mappa dei recordtype per poi utilizzarla
                OF_CO_GE_Utils.RTMap = new  map<String,String>();
                for(recordtype rt : [select id,developername from recordtype]){
                    OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
                }
                OF_CO_GE_Utils.checkRTMap=true;
            }   
            //creo ed inserisco il case
            Case c = new Case(); 

            c.RecordTypeId=OF_CO_GE_Utils.rtMap.get('EOF_Caso_ChangeOrder_OPENSTREAM');
            c.EOF_Codice_Operatore_WS__c = deact.CODICE_OPERATORE;            
            c.EOF_Codice_Ordine_OLO__c = deact.CODICE_ORDINE_OLO;
            c.EOF_Data_Notifica__c = OF_CO_GE_Utils.StringToDate(deact.DATA_NOTIFICA);
            c.EOF_Id_Notifica__c = deact.ID_NOTIFICA;  
            c.EOF_Id_Risorsa__c = deact.ID_RISORSA;
            c.OF_SA_CODICE_PROGETTO_SPECIALE__c = deact.CODICE_PROGETTO_SPECIALE;
            c.OF_SA_Promozione__c = deact.PROMOZIONE;
            c.OF_SA_Cluster_Promozione__c = deact.CLUSTER_PROMOZIONE;
            // 20/02/2018 MM : abbreviazione campo note se > 255
            if(deact.NOTE!=null && string.isnotblank(deact.NOTE)){
                c.EOF_Note__c = deact.NOTE.abbreviate(255);
            }else{
                c.EOF_Note__c = deact.NOTE;
            }
            c.OF_SA_Profilo__c = deact.PROFILO;
            c.subject='Richiesta Change Order';
            c.status='Inviato';
            c.EOF_FASE__C='NA';
            //Default false, se viene inserito da portale è true
            c.PO_SA_Portale__c=OF_CO_GE_Utils.PORTAL;
            insert c;
            /*AA Creazione ed inserimento delle VLAN spostate in async
            //Lista di VLAN
            List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();
            //RECUPERO L'Id del Commercial Element relativo alle VLAN
            Id vlanCEId = [SELECT Id 
                           FROM OF_CommercialElement__c 
                           WHERE OF_Servizio__r.Name='Open Stream' 
                           AND Name='VLAN' LIMIT 1].Id;
            //Ciclo la lista di vlan della request e li aggiungo alla lista di VLAN
            for (OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vlan : deact.vlan){
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                
                cei.recordtypeid=OF_CO_GE_Utils.rtMap.get('OF_VLAN');
                cei.OF_KITCONSEGNAVLAN__C = vlan.KIT_CONSEGNA_VLAN;
                cei.OF_USERVLAN__C = vlan.USER_VLAN;
                cei.OF_SERVICEVLAN__C = vlan.SERVICE_VLAN;
                cei.OF_PROFILOVLAN__C = vlan.PROFILO_VLAN;
                cei.OF_CUSTOMERVLAN__C = vlan.CUSTOMER_VLAN;
                cei.OF_MODELLODISERVIZIOVLAN__C = vlan.MODELLO_DI_SERVIZIO_VLAN;
                cei.OF_INFORMAZIONIVLAN__C = vlan.INFORMAZIONI_VLAN;
                //Lego le VLAN al Case
                cei.OF_Case__c = c.Id;
                cei.OF_SA_VLAN__c = c.Id;
                //Imposto il CEI di tipologia VLAN
                cei.OF_CommercialElement__c = vlanCEId;
                
                ceiList.add(cei);
            }
            // Controllo se la lista è popolata
            if(!ceiList.isEmpty()){
                insert ceiList;
            }
            */
            OF_CO_GE_Utils.caseOriginale=c;
            OF_CO_GE_Utils.checkCaseOriginale=true;
            List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
            slToUpsert.add(OF_CO_GE_Utils.create_EAI_Log(new Map<String,String>{'Type' => 'ACK',
                                                    'Codice_operatore' => deact.CODICE_OPERATORE,
                                                    'Codice_ordine_OLO' => deact.CODICE_ORDINE_OLO,
                                                    'Flusso' => 'OLO-SF',
                                                    'Metodo' => 'OLO_ChangeOrder',
                                                    'ID_notifica' => deact.ID_NOTIFICA,
                                                    'Tipo Comunicazione' => 'OLO->SF - ACK - ChangeOrderRequest',
                                                    'Caso' => c.Id,
                                                    'SL Riferimento' => OF_CO_GE_Utils.slOLOSF.Id}));
            OF_CO_GE_Utils.slOLOSF.EOF_Response__c='ACK';	
            OF_CO_GE_Utils.slOLOSF.Caso__c=c.Id;															
            slToUpsert.add(OF_CO_GE_Utils.slOLOSF);
            upsert slToUpsert;
            //Richiamo il metodo di controlli asincroni
            //Done AA: Aggiungere richiamo ai check asincroni di piergiorgio
            System.debug('PRIMA DEI CHECK ASINCRONI');
            System.debug('OF_CO_GE_Utils.slOLOSF.Id '+OF_CO_GE_Utils.slOLOSF.Id);
            OF_CO_OLO_AsyncChecks.OLO_AsyncChangeOrder(c.Id,OF_CO_GE_Utils.slOLOSF.Id);
            
            // 14/02/2018 MM : Aggiorno il timestamp. C corrisponde alla fine check Cessazione.
            OF_CO_GE_Utils.tmpl.Timestamp__c = OF_CO_GE_Utils.tmpl.Timestamp__c + ', C: '+Datetime.now().format('HH:mm:ss','Europe/Rome');
            // finisce qui
            // 14/02/2018 MM : Inserisco il templog
            try{
                insert OF_CO_GE_Utils.tmpl;
            }
            catch(Exception e){
                OF_CO_GE_Utils.tmpl.Type__c='E';
                OF_CO_GE_Utils.tmpl.desc__c='Errore :' +e;
                insert OF_CO_GE_Utils.tmpl;	
            }
            // finisce qui

            return res;
        }catch(Exception e){
            system.debug('*** ERRORE TRY CATCH ' + e.getMessage());
            system.debug('*** ERRORE TRY CATCH ' + e.getStackTraceString());
            return OF_CO_GE_Utils.syncError (deact,'A04','Errore interfaccia');
        }    
    }
}