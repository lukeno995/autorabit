public without sharing class OF_GPONP_FTTH_EntryChecks {
    public static case c; 
    public static case cs;
    public static Asset a; 
    public static Account acc;
    public static Asset asst;
    public static String subject;
    public static String customerOrder;
    public static String accountOLO;
    public static String networkIdResource; 
    public static EOF_EAI_Service_Log__c slRMSFreq;
    public static Order ordine;
    public static String identificativoPop; 
    public static List<Asset> listAsset; 
    public static List <Case> caseList;
    public static Transcodifica_OLO_Remedy__c t;
    public static List <Order>listOrder;
    public static List <Account> accList;
    public static DateTime attDate; 
    public static Order ord;
    public static  List<Case_AssetRecordType__c> mcs;
    public static Id idOrd;
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp;
    
    
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksFTTHinORDER(OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest act)
    {
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        //Aggiorno il timestamp. ACQ.1 corrisponde a inizio check acquisizione.
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.1');
        c = new Case();   
        
        c.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Caso_Attivazione_Remedy');
        c.subject='Richiesta di attivazione';
        c.status='Acquisito';  
        c.PO_PP_ID_Richiesta__c=OF_GPONP_FTTH_Utils.slRMSF.id;  
        
        if(string.isblank(act.actionDate)){ 
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }
        else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            c.status='ACQUISITO KO'; 
            c.OF_SA_Codice_Motivazione__c='A06';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato correttamente';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
			OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        } else  
            
            c.actionDate_Remedy__c= OF_GPONP_FTTH_Utils.stringToDate(act.actionDate);   
        if(string.isblank(act.customerId)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ID');
        } 
        else {   
            System.debug('****** act.customerId => ' + act.customerId);
            List<Transcodifica_OLO_Remedy__c> transOLORemlst =[SELECT Name, Comune__c from Transcodifica_OLO_Remedy__c where CustomerId__c=:act.customerId limit 1];           
            if (!transOLORemlst.isEmpty()){
                Transcodifica_OLO_Remedy__c t = transOLORemlst[0];
                List <Account> listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where Name=: t.Name and type='OLO' limit 1];
                if(!listAcc.isEmpty()){
                    c.EOF_Account_OLO__c=listAcc[0].id;
                    System.debug('******EOF_Account_OLO__c='+listAcc[0].id);
                    c.EOF_Codice_Operatore_WS__c=listAcc[0].EOF_Codice_Operatore__c;
                    c.EOF_Comune_WS__c=transOLORemlst[0].Comune__c;
                    
                }
            }else{
                c.status='ACQUISITO KO';
                c.OF_SA_Codice_Motivazione__c='B_K20';
                c.OF_SA_Motivazione__c='OLO non presente';
                insert c;
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
				OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            	update OF_GPONP_FTTH_Utils.slRMSF;
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
            }
        }
        if(string.isblank(act.customerOrder)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ORDER'); 
        }else {
            system.debug('act.productProvisionigCodes'+act.productProvisionigCodes);
            List <Case> verificaCustOrder= [SELECT id, OF_SA_Motivazione__c, status FROM case WHERE EOF_Codice_Ordine_OLO__c=:act.customerOrder ];
            if (!verificaCustOrder.isEmpty()){
                for (Case cas : verificaCustOrder){
                    if(cas.status=='ACQUISITO KO' && cas.OF_SA_Motivazione__c=='Ordine non gestito perchè non su GPON Passiva. Valore ProductProvisioningCode diverso da 4'
                       && act.productProvisionigCodes!='4'){
                        system.debug('acquisito ko con ppc diverso da 4');
                        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                        return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER'); 
                    }  else if(cas.status=='ESPLETATO'){
                        system.debug('***espletato');
                        c.status='ACQUISITO KO';
                        c.OF_SA_Codice_Motivazione__c='B_K28';
                        c.OF_SA_Motivazione__c='Codice ordine OLO già  esistente';
                        insert c;
                        //OF_GPONP_FTTH_Utils.ManageOrder(c);
                        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                        OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
                        return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER'); 
                    }
                    else {
                        c.EOF_Codice_Ordine_OLO__c=act.customerOrder;
                    }
                }
            } else {
                c.EOF_Codice_Ordine_OLO__c=act.customerOrder;
            }
        }
        if(string.isblank(act.packageProvisioningCode)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;          
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PACKAGE_PROVISIONING_CODE'); 
            
        } 
        if(string.isblank(act.internalOrder)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','INTERNAL_ORDER');
        }
        
        if(string.isblank(act.networkIdResource)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        } c.EOF_Id_Risorsa__c=act.networkIdResource;
        
        /*else if (act.packageProvisioningCode!='2'){
c.status='ACQUISITO KO';
c.OF_SA_Codice_Motivazione__c='B_K22';
c.OF_SA_Motivazione__c='Ordine non gestito perchè non su GPON Passiva. Valore ProductProvisioningCode diverso da 2';
update c;            
OF_GPONP_FTTH_Utils.ManageOrder(c);
OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
return OF_GPONP_FTTH_Utils.syncError (act,'B_K22','PACKAGE_PROVISIONING_CODE'); 
}*/
        
        if(string.isblank(act.pop)){ 
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;           
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','POP');
        } else c.EOF_Identificativo_del_POP__c=act.pop;
        
        system.debug('identificativo del pop: '+c.EOF_Identificativo_del_POP__c);
        
        //check contract 
        List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 
                                                           where OF_Servizio__r.name='GPON Passiva' 
                                                           and OF_Contract__r.Status='Attivo'
                                                           AND OF_Contract__r.AccountId =: c.EOF_Account_OLO__c LIMIT 1];
        if(checkGPNPContract.isEmpty()){
            c.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            c.OF_SA_CODICE_MOTIVAZIONE__c = 'B_K17';
            c.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            c.EOF_Fase__c = 'NA';
            c.status='ACQUISITO KO';
            system.debug('Account name: '+ c.EOF_Account_OLO__c);
            insert c;
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
        }else{
            
            c.OF_IDContratto__c =checkGPNPContract[0].OF_Contract__c;
            
        }//check città
        List<OF_AreaGeograficaJunction__c> checkCityCOntract =[select id from OF_AreaGeograficaJunction__c 
                                                               where OF_Contratto__c =:checkGPNPContract[0].OF_Contract__c];
        if(checkCityCOntract.isEMpty()){
            c.EOF_Causale_Errore__c = 'Città /POP non vendibile per l\'OLO';
            c.OF_SA_CODICE_MOTIVAZIONE__c = 'B_K16';
            c.OF_SA_MOTIVAZIONE__c = 'Città /POP non vendibile per l\'OLO';
            c.EOF_Fase__c = 'NA';
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='B_K16';
            c.OF_SA_Motivazione__c='CittÃƒÂ /POP non vendibile per l\'OLO';
            insert c;
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K16','POP');
        } 
        
        if(string.isblank(act.pricePlanProvisioningCode)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;        
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRICE_PLAN_PROVISIONING_CODE'); 
        }
        if(string.isblank(act.productProvisionigCodes)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;         
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }else if (act.productProvisionigCodes!='4'){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K23','PRODUCT_PROVISIONING_CODE'); 
        }
        if(string.isblank(act.verticalOperator)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;         
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','VERTICAL_OPERATOR'); 
        } c.OF_Vertical_Operator__c=act.verticalOperator;
        
        
        c.EOF_Progetto_Speciale__c=act.promoCode; 
        c.status='ESPLETATO';
        insert c;
        system.debug('***** account olo:'+c.EOF_Account_OLO__c);
        OF_GPONP_FTTH_Utils.ManageOrder(c);
        
        Case caso =[SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c,actionDate_Remedy__c,EOF_Identificativo_del_POP__c,
                    status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,EOF_Comune_WS__c, 
                    OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c , RecordType.DeveloperName
                    FROM case WHERE id=:c.id];
        
        OF_Espletamento_Generico_AP epl= new OF_Espletamento_Generico_AP(caso);
        List <Asset> ass= [SELECT Id, EOF_ID_Risorsa__c, EOF_OLO__C, Status, Account.EOF_Codice_Operatore__c, Name, OF_DataAttivazione2__c,OF_CPE_Quantity__c  
                           FROM Asset Where EOF_ID_Risorsa__c=:act.networkIdResource and Account.EOF_Codice_Operatore__c=: caso.EOF_Codice_Operatore_WS__c ];
        
        Integer dataAsset;
        List<String> nomiPbeSet = new List<String>();
        nomiPbeSet.add('Contributo Attivazione');
        nomiPbeSet.add('Canone');
        OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
                                                     FROM OF_ContrattoServizio__c
                                                     WHERE OF_Contract__c = :caso.OF_IDContratto__c  AND OF_Servizio__r.Name=:'GPON Passiva'
                                                     LIMIT 1];
        Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
        
        if(!ass.isempty()){
            if(ass[0].status!='CESSATO') {
            dataAsset=ass[0].OF_DataAttivazione2__c .year();         
            if(dataAsset==2019 ){
                system.debug('@@@ data == 2019');
                epl.espletamentoRemedy(ass[0], mappaBE.values(), true);
                
            } else {
                List <Case> cs= [SELECT Id FROM Case Where EOF_ID_Risorsa__c=:ass[0].id AND EOF_Codice_Ordine_OLO__c=:act.customerOrder limit 1];
                if(!cs.isempty()){
                    cs[0].status='ACQUISITO KO';
                    cs[0].OF_SA_Codice_Motivazione__c='B_K28';
                    cs[0].OF_SA_Motivazione__c='Codice ordine OLO già  esistente';
                    insert cs[0];
                    OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                    OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
                    return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER');    
                }
            }
            }else {
                    c.status='ACQUISITO KO';
                    c.OF_SA_Codice_Motivazione__c='B_K28';
                    c.OF_SA_Motivazione__c='Codice ordine OLO già  esistente';
                    insert c;
                    OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
                    return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER');    

            }
        }  
        else {
            epl.espletamentoRemedy(asst, mappaBE.values(), true);  
        }          
        
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.2');
        // finisce qui        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }    
		EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0';
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        //creo ed inserisco l'ack ad RM (RM->SF - ACK - Ftth in Order) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
            'Type' => 'ACK',
                'Codice_ordine_OLO' => c.EOF_Codice_Ordine_OLO__c,
                'Flusso' => 'RM-SF',
                'Caso' =>c.Id,
                'Metodo' => 'FTTH IN ORDER',
                'Tipo Comunicazione' => 'RM->SF - ACK - FTTH OUT ORDER',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';
        OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.Id;		
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;   
        return resp;  
    }

    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksFTTHoutORDER(OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest act)
    {
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.1 corrisponde a inizio check acquisizione.
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.1');
        c = new Case(); 
        
        c.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Caso_Cessazione_Remedy'); 
        c.subject='Richiesta di cessazione';
        c.status='Acquisito';
        c.PO_PP_ID_Richiesta__c=OF_GPONP_FTTH_Utils.slRMSF.id;
        
        if(string.isblank(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }
        else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            c.status='CESSATO KO'; 
            c.OF_SA_Codice_Motivazione__c='A06';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato correttamente';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }
        else   
            c.actionDate_Remedy__c= OF_GPONP_FTTH_Utils.stringToDate(act.actionDate);   
        
        if(string.isblank(act.customerOrder)){
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ORDER'); 
        }
        if(string.isblank(act.internalOrder)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','INTERNAL_ORDER');
        }
        
        if(string.isblank(act.productProvisioningCode)){ 
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;         
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }
        else if (act.productProvisioningCode!='6'){
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='B_K25';
            c.OF_SA_Motivazione__c='Ordine non gestito perchè non su GPON Passiva. Valore ProductProvisioningCode diverso da 6';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K25','PRODUCT_PROVISIONING_CODE'); 
        }
        
        if(string.isblank(act.networkIdResource)){
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE');
        } 
        c.EOF_Id_Risorsa__c=act.networkIdResource;
        
        List <Asset> asst= [Select Id, EOF_ID_Risorsa__c from asset where name =:act.networkIdResource LIMIT 1];
        if(!asst.isEMpty()){
            
            List <Case> cs= [SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c, recordType.DeveloperName,
                             status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,
                             OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c 
                             FROM case WHERE subject='Richiesta di attivazione' AND AssetId=:asst[0].id];
            if(cs.isEmpty()){
                // chiedi claudio id risorsa non presente
                c.OF_SA_Codice_Motivazione__c='B_K21';
                c.OF_SA_Motivazione__c='Id risorsa non presenteampo obbligatorio non valorizzato';
                insert c;
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K21','NETWORK_ID_RESOURCE');
                
            }
            List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 
                                                               where OF_Servizio__r.name='GPON Passiva' 
                                                               and OF_Contract__r.Status='Attivo'
                                                               AND OF_Contract__r.AccountId =: cs[0].EOF_Account_OLO__c];
            
            if(checkGPNPContract.isEMpty()){
                c.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
                c.OF_SA_CODICE_MOTIVAZIONE__c = 'B_K17';
                c.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
                c.EOF_Fase__c = 'NA';
                c.status='CESSATO KO';
                c.OF_SA_Codice_Motivazione__c='B_K17';
                c.OF_SA_Motivazione__c='OLO non abilitato all\' invio dell\'ordine';
                insert c;
                OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
                
            }
            if (cs[0].EOF_Codice_Ordine_OLO__c==act.customerOrder){
                system.debug('verificaCustOrder.isEMpty'); 
                c.status='CESSATO KO';
                c.OF_SA_Codice_Motivazione__c='B_K28';
                c.OF_SA_Motivazione__c='Codice ordine OLO già  esistente';
                insert c;
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER'); 
            }  
            else {
                c.EOF_Codice_Ordine_OLO__c=act.customerOrder;
            }
            c.OF_IDContratto__c=cs[0].OF_IDContratto__c;
            c.status='CESSATO OK';   
            c.AssetId=asst[0].id;    
            c.EOF_Account_OLO__c=cs[0].EOF_Account_OLO__c;
            insert c;
            
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            /*
Order ordine =[SELECT ID FROM Order WHERE OF_CaseID__c =: c.id];
c.OF_Order__c =ordine.id;
c.OF_IDContratto__c = cs[0].Of_IDContratto__c; 
update c;
*/
            
            // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
            OF_GPONP_FTTH_Utils.partialTemplog('ACQ.2');
            Case caso =[SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c,actionDate_Remedy__c,
                        status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,
                        OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c , RecordType.DeveloperName
                        FROM case WHERE id=:c.id];
            OF_Espletamento_Generico_AP espl= new OF_Espletamento_Generico_AP(caso);
            espl.cessazioneCeiGPONP_Remedy(true);  
        }
        else { 
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='B_K21';
            c.OF_SA_Motivazione__c='Id risorsa non presente';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K21','CUSTOMER_ID');
        }
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>(); 
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        
        EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0';
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        //creo ed inserisco l'ack ad RM (RM->SF - ACK - Ftth in Order) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
            'Type' => 'ACK',
                'Codice_ordine_OLO' => c.EOF_Codice_Ordine_OLO__c,
                'Flusso' => 'RM-SF',
                'Caso' =>c.Id,
                'Metodo' => 'FTTH OUT ORDER',
                'Tipo Comunicazione' => 'RM->SF - ACK - FTTH OUT ORDER',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';
        OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.Id;		
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;
        OF_GPONP_FTTH_Utils.EndTemplog(); 
        return resp;  
    }  
    
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksCPEADD(OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest act){
        
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.1');
        
        if(string.isblank(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }
        
        if(string.isblank(act.networkIdResource)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        } 
        List <Asset> ass= [SELECT Id, EOF_ID_Risorsa__c, EOF_OLO__C, Status, Account.EOF_Codice_Operatore__c, Name, OF_CPE_QUANTITY__c  
                           FROM Asset Where name=:act.networkIdResource ];
        if(ass.isEmpty()){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
            
        }
        system.debug('product: '+act.productProvisioningCodes);
        if(string.isblank(act.productProvisioningCodes)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }
        else if (act.productProvisioningCodes!='9'&& act.productProvisioningCodes!='10' && 
                 act.productProvisioningCodes!='23'&&  act.productProvisioningCodes!='43'&&  act.productProvisioningCodes!='44'&& 
                 act.productProvisioningCodes!='45'&& act.productProvisioningCodes!='46'&&  act.productProvisioningCodes!='47'&& 
                 act.productProvisioningCodes!='48'&&  act.productProvisioningCodes!='70'&&  act.productProvisioningCodes!='71'&& 
                 act.productProvisioningCodes!='72'){ 
                     system.debug('entro nell else div');
                     if(act.productProvisioningCodes=='11'|| act.productProvisioningCodes=='40' || 
                        act.productProvisioningCodes=='41'|| act.productProvisioningCodes=='42'){
                            system.debug('sono qui');
                            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                            EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
                            resp.statusCode='0';
                            resp.entity='0'; 
                            resp.errorMessage='0';
                            resp.logId='0';
                            resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
                            //creo ed inserisco l'ack ad RM (RM->SF - ACK - Ftth in Order) e aggiorno il sl di riferimento con l'ACK
                            List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
                            slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
                                'Type' => 'ACK',
                                    'Motivazione' => 'Valore ProductProvisioningCode diverso da quelli presenti a Catalogo',
                                    'Flusso' => 'RM-SF',
                                    'Metodo' => 'CPE ADD',
                                    'Tipo Comunicazione' => 'RM->SF - ACK - CPE ADD',
                                    'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
                            OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';
                            slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
                            
                            slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
                            slToUpsert.add(slRMSFreq);
                            upsert slToUpsert;
                            OF_GPONP_FTTH_Utils.EndTemplog(); 
                            return resp;  
                        }  else{                
                            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                            //TODo
                            return OF_GPONP_FTTH_Utils.syncError (act,'B_K26','PRODUCT_PROVISIONING_CODE'); 
                            
                        }                 } 
        
        List <Case> c =   [SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c, actionDate_Remedy__c,
                           status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,	
                           OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c , RecordType.DeveloperName
                           FROM CASE Where AssetId=:ass[0].Id limit 1];
        
        Account acc = [SELECT type from Account where Id =: ass[0].AccountId limit 1];
        if(acc.type!='OLO'){        
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
        }    
        
        //check contract 
        List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 
                                                           where OF_Servizio__r.name='GPON Passiva' 
                                                           and OF_Contract__r.Status='Attivo'
                                                           AND OF_Contract__r.AccountId =: c[0].EOF_Account_OLO__c];
        system.debug('****contratto:'+checkGPNPContract[0].id);
        
        if(checkGPNPContract.isEmpty()){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
        }
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.2');
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        c[0].actionDate_Remedy__c= OF_GPONP_FTTH_Utils.stringToDate(act.actionDate);   
        
        
        OF_Espletamento_Generico_AP epl= new OF_Espletamento_Generico_AP(c[0]);
        OF_ContrattoServizio__c contrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
                                                     FROM OF_ContrattoServizio__c
                                                     WHERE OF_Contract__c = :c[0].OF_IDContratto__c  AND OF_Servizio__r.Name=:'GPON Passiva'
                                                     LIMIT 1];
        if(act.productProvisioningCodes=='9'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo Installazione CPE');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);          
        } 
        else if (act.productProvisioningCodes=='10'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo Ribaltamento impianto');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='23'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo Installazione ONT');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='43'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Tipo 1 Prolungamento fino a 5 m');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='1';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='44'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Tipo 2 Prolungamento fino a 5 m con canalina nuova');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='1';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='45'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Tipo 3 Prolungamento tra 5-15 m');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='1';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='46'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Tipo 4 Prolungamento tra 5-15 m con canalina nuova');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='1';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='47'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Tipo 5 Supplemento prolungamento oltre 15m');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            Integer q= integer.valueof(act.quantity);
            Integer quantity= q-15;
            ass[0].OF_CPE_Quantity__c=String.valueOf(quantity);         
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='48'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Compenso per intervento non contestuale');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='1';
            update ass[0];
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='70'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo Installazione CPE Base');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='71'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo Installazione CPE Plus');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='';
            update ass[0];         
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        else if (act.productProvisioningCodes=='72'){
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo Installazione CPE Premium');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,contrattoServizio.OF_Servizio__r.OF_Servizio_Code__c);
            ass[0].OF_CPE_Quantity__c='';
            update ass[0];               
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true);  
        }
        
        //Creo il log della request
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        
        EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0';
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        //creo ed inserisco l'ack ad RM (RM->SF - ACK - Ftth in Order) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
            'Type' => 'ACK',
                'Codice_ordine_OLO' => c[0].EOF_Codice_Ordine_OLO__c,
                'Flusso' => 'RM-SF',
                'Caso' =>c[0].Id,
                'Metodo' => 'CPE ADD',
                'Tipo Comunicazione' => 'RM->SF - ACK - CPE ADD',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';
        OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c[0].Id;		
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;
        OF_GPONP_FTTH_Utils.EndTemplog(); 
        return resp; 
    }
    
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksPROVISIONINGADD(OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest act){
        
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.1');
        
        if(string.isblank(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }     
        
        if(string.isblank(act.customerId)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ID');
        }   
        List <Transcodifica_OLO_Remedy__c> t =[SELECT Name, Comune__c from Transcodifica_OLO_Remedy__c where CustomerId__c=:act.customerId limit 1];
        if (!t.isEmpty()){
            accList = [SELECT Id, EOF_Codice_Operatore__c, name from Account where Name=: t[0].Name and type='OLO' limit 1];
            if(accList.isempty()) {        
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CSTOMER_ID'); 
            }
        }
        
        if(string.isblank(act.customerOrder)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ORDER'); 
        } 
        
        
        if(string.isblank(act.productProvisionigCodes)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }
        
        
        //check contract 
        List <Order> listOrd  = [SELECT Id,RecordType.Name,RecordType.Id,OF_Type__c,
                                 OF_TipologiaDiServizio__c,EffectiveDate,Status,
                                 OF_DataEsito__c,OF_CodiceKO__c,OF_Esito__c,
                                 OF_DescrizioneKO__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,
                                 OF_IDRisorsa__c,AccountId,OF_IDBuilding__c,OF_Asset__c,
                                 OF_SlaPremiumAssurance__c,OF_Apparato__c,
                                 OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                                 OF_PasswordApparato__c,ContractId,OF_CaseID__c,OF_CaseNome__c,
                                 OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,
                                 OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,
                                 OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,OF_AccountTemporaneo__c
                                 FROM Order 
                                 WHERE OF_IDOrdineOLO__c =: act.customerOrder];
        
        List <Case> caso =[SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c, actionDate_Remedy__c,EOF_Comune_WS__c, 
                           status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,
                           OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c , RecordType.DeveloperName
                           FROM case WHERE EOF_Codice_Ordine_OLO__c=:act.customerOrder];
        List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                           where OF_Servizio__r.name='GPON Passiva' 
                                                           and OF_Contract__r.Status='Attivo'
                                                           AND OF_Contract__r.AccountId =: accList[0].id];   
        if(checkGPNPContract.isEmpty()){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID'); 
        }
        /*
if( caso.isEmpty()){

OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
return OF_GPONP_FTTH_Utils.syncError (act,'B_K24','CUSTOMER_ORDER');
}		*/
        
        
        if (!listOrd.isEMpty()){
            system.debug('si order');
            OF_GPONP_FTTH_Utils.CreateAssetFromOrder(listOrd[0]);
            caso[0].actionDate_Remedy__c= OF_GPONP_FTTH_Utils.stringToDate(act.actionDate);  
            caso[0].Descrizione_IAV__c=act.oloMessage;
            caso[0].Code_IAV__c=act.oloMessageCode;
                OF_Espletamento_Generico_AP epl= new OF_Espletamento_Generico_AP(caso[0]);
            List <Asset> ass= [SELECT Id, EOF_ID_Risorsa__c, EOF_OLO__C, Status, Account.EOF_Codice_Operatore__c, Name, OF_DataAttivazione2__c , OF_CPE_QUANTITY__c, OF_Comune__c
                               FROM Asset Where EOF_ID_Risorsa__c =: act.customerOrder];
            
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo intervento a vuoto provisioning');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c);
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true); 
            
        } else { 
            /*
OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
return OF_GPONP_FTTH_Utils.syncError (act,'B_K24','CUSTOMER_ORDER');  
*/
            OF_GPONP_FTTH_Utils.createOrderFromReq(act,accList[0]);
            Order ordinepr  = [SELECT Id,RecordType.Name,RecordType.Id,OF_Type__c,
                               OF_TipologiaDiServizio__c,EffectiveDate,Status,
                               OF_DataEsito__c,OF_CodiceKO__c,OF_Esito__c,
                               OF_DescrizioneKO__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,
                               OF_IDRisorsa__c,AccountId,OF_IDBuilding__c,OF_Asset__c,
                               OF_SlaPremiumAssurance__c,OF_Apparato__c,
                               OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                               OF_PasswordApparato__c,ContractId,OF_CaseID__c,OF_CaseNome__c,
                               OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,
                               OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,
                               OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,OF_AccountTemporaneo__c
                               FROM Order 
                               WHERE OF_IDOrdineOLO__c =: act.customerOrder];
            OF_GPONP_FTTH_Utils.creazioneCasoFromOrder(ordinepr, accList[0]);
            OF_GPONP_FTTH_Utils.CreateAssetFromOrder(ordinepr);
            
            List <Case> casoPr =[SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c, actionDate_Remedy__c,EOF_Comune_WS__c,
                                 status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,
                                 OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c , RecordType.DeveloperName
                                 FROM case WHERE EOF_Codice_Ordine_OLO__c=:act.customerOrder];
            casoPr[0].actionDate_Remedy__c= OF_GPONP_FTTH_Utils.stringToDate(act.actionDate);   
            casoPr[0].Descrizione_IAV__c=act.oloMessage;
            casoPr[0].Code_IAV__c=act.oloMessageCode;
            OF_Espletamento_Generico_AP epl= new OF_Espletamento_Generico_AP(casoPr[0]);
            List <Asset> ass= [SELECT Id, EOF_ID_Risorsa__c, EOF_OLO__C, Status, Account.EOF_Codice_Operatore__c, Name, OF_DataAttivazione2__c , OF_CPE_QUANTITY__c
                               FROM Asset Where EOF_ID_Risorsa__c =: act.customerOrder];
            
            List<String> nomiPbeSet = new List<String>();
            nomiPbeSet.add('Contributo intervento a vuoto provisioning');
            Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c);
            epl.espletamentoRemedy(ass[0], mappaBe.values(), true); 
            delete casoPr[0];
        }
        
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        
        
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        
        EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0';
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        //creo ed inserisco l'ack ad RM (RM->SF - ACK - Ftth in Order) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
             'Type' => 'ACK',
                'Flusso' => 'RM-SF',
                'Metodo' => 'PROVISIONING ADD',
                'Tipo Comunicazione' => 'RM->SF - ACK - ASSURANCE ADD',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';	
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;
        return resp; 
    }  
    
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksNETWORKADD(OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest act){
        
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();    
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0';
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        return resp; 
    }  
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksASSURANCEADD(OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest act)
    {
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        // finisce qui
        c = new Case();   
        c.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Caso_ASSURANCE_Remedy');
        c.subject='Richiesta di risoluzione guasto';
        c.status='Acquisito';
        c.PO_PP_ID_Richiesta__c=OF_GPONP_FTTH_Utils.slRMSF.id; 
        
        
        if(string.isblank(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            c.status='ACQUISITO KO'; 
            c.OF_SA_Codice_Motivazione__c='A06';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato correttamente';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        } else  
        {
            attDate =OF_GPONP_FTTH_Utils.stringToDate(act.actionDate); 
            c.EOF_Data_Notifica__c= date.newinstance(attDate.year(), attDate.month(), attDate.day());
            system.debug('@@@@@ data case: '+ c.EOF_Data_Notifica__c);      
        }
        if(string.isblank(act.networkIdResource)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        } c.EOF_Id_Risorsa__c=act.networkIdResource;
        List <Asset> ass= [SELECT Id, EOF_ID_Risorsa__c, EOF_OLO__C, Status, Account.EOF_Codice_Operatore__c, Name, OF_DataAttivazione2__c, OF_CPE_QUANTITY__c  
                           FROM Asset Where EOF_ID_Risorsa__c=:act.networkIdResource ];
        if(!ass.isempty()){
            Account acc = [SELECT type,EOF_Codice_Operatore__c from Account where Id =: ass[0].AccountId limit 1];
            if(acc.type!='OLO'){        
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act); 
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','NETWORK_ID_RESOURCE'); 
            }            
            c.EOF_Account_OLO__c=acc.id;
            
            c.AssetId=ass[0].id;
            c.EOF_Codice_Operatore_WS__c=acc.EOF_Codice_Operatore__c;
        } else {
            c.status='CESSATO KO';
            c.OF_SA_Codice_Motivazione__c='B_K21';
            c.OF_SA_Motivazione__c='Id risorsa non presente';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K21','CUSTOMER_ID');
        }  
        // QUERY SU ASSET
        if(string.isblank(act.oloCommCode)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','OLO_COMMON_CODE'); 
        } 
        c.EOF_Codice_Comunicazione_OLO__c=act.oloCommCode; 
        c.EOF_Id_Risorsa__c=act.networkIdResource;
        
        if(string.isblank(act.faultCause)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','FAULT_CAUSE'); 
        } c.EOF_Id_Risorsa__c=act.networkIdResource;
        
        if(string.isblank(act.productProvisionigCodes)){
            c.status='ACQUISITO KO';
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;          
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }
        // finisce qui        
        
        if(string.isblank(act.ttNumber)){
            c.OF_SA_Codice_Motivazione__c='A05';
            c.OF_SA_Motivazione__c='Campo obbligatorio non valorizzato';
            insert c;
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','TT_NUMBER');
        } 
        
        //END AA 01/10/2018
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_GPONP_FTTH_Utils.partialTemplog('ACQ.2');
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        c.status='Chiuso';
        c.OF_FaultResolution__c =act.faultResolution;
        c.OF_TT_Number__c=act.ttNumber;
        c.EOF_Descrizione_Intervento_Risoluzione__c =act.faultCause;
        c.OLO_Comm_Code__c=act.oloCommCode;
        
        List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                           where OF_Servizio__r.name='GPON Passiva' 
                                                           and OF_Contract__r.Status='Attivo'
                                                           AND OF_Contract__r.AccountId =: ass[0].AccountId ];   
        if(checkGPNPContract.isEmpty()){
            c.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            c.OF_SA_CODICE_MOTIVAZIONE__c = 'B_K17';
            c.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            c.EOF_Fase__c = 'NA';
            c.status='ACQUISITO KO';
            insert c;
            OF_GPONP_FTTH_Utils.ManageOrder(c);
            OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.id;
            			update OF_GPONP_FTTH_Utils.slRMSF;
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
        }else{
            
            c.OF_IDContratto__c =checkGPNPContract[0].OF_Contract__c;
        }
        insert c;
        
        system.debug('********** account olo :'+ c.EOF_Account_OLO__c);
        system.debug('**** id asset: '+ ass[0].Id );
        List <Case> casoRemAtt =[SELECT Id,OF_IDContratto__c,EOF_Codice_Ordine_OLO__c, EOF_Account_OLO__c, EOF_Id_Risorsa__c, AssetId, RecordTypeId from Case Where AssetId=:ass[0].Id and subject='Richiesta di attivazione' limit 1];
        if(!casoRemAtt.isEmpty()){
            Order o1 = [SELECT Id,RecordType.Name,RecordType.Id,OF_Type__c,
                        OF_TipologiaDiServizio__c,EffectiveDate,Status,
                        OF_DataEsito__c,OF_CodiceKO__c,OF_Esito__c, 
                        OF_DescrizioneKO__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,
                        OF_IDRisorsa__c,AccountId,OF_IDBuilding__c,OF_Asset__c,
                        OF_SlaPremiumAssurance__c,OF_Apparato__c,
                        OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                        OF_PasswordApparato__c,ContractId,OF_CaseID__c,OF_CaseNome__c,
                        OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,
                        OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,
                        OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,OF_AccountTemporaneo__c
                        FROM Order 
                        WHERE OF_CaseID__c =: casoRemAtt[0].id];
            c.OF_Order__c =o1.id;
            update c;
            system.debug('******** id caso nuovo:'+ c.id+ c.recordtype.developername);
            Case caso =[SELECT id,EOF_Codice_Ordine_OLO__c,Codice_Ordine_EOF__c,OF_SA_ID_Servizio__c, EOF_Account_OLO__c, OF_IDContratto__c,
                        status, RecordTypeId, OF_Order__c, EOF_Codice_Operatore_WS__c, CaseNumber,PO_Data_Espletamento_Ordine__c, OF_SA_Codice_Motivazione__c,OF_TT_Number__c,
                        OF_SA_Motivazione__c, AssetId, EOF_Id_Risorsa__c, EOF_Progetto_Speciale__c , RecordType.DeveloperName, OLO_Comm_Code__c
                        FROM case WHERE id=:c.id];
             
            system.debug('******* recordtye:'+ caso.RecordType.DeveloperName );
            c.actionDate_Remedy__c= OF_GPONP_FTTH_Utils.stringToDate(act.actionDate);   
            OF_Espletamento_Generico_AP epl= new OF_Espletamento_Generico_AP(caso);
            
            if(act.productProvisionigCodes=='14'){
                List<String> nomiPbeSet = new List<String>();
                nomiPbeSet.add('Non Risolvibile: Causa CPE Cliente');
                Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c);
                
                
                epl.espletamentoRemedy(ass[0], mappaBe.values(), true); 
            }
            if(act.productProvisionigCodes=='15'||act.productProvisionigCodes=='16'){
                List<String> nomiPbeSet = new List<String>();  
                nomiPbeSet.add('Non Risolvibile: Causa Impianto Cliente');
                Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c);
                
                epl.espletamentoRemedy(ass[0], mappaBe.values(), true); 
            }
            if(act.productProvisionigCodes=='17'){
                List<String> nomiPbeSet = new List<String>();
                nomiPbeSet.add('Non riscontrato: Senza Uscita');
                Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c);
                
                epl.espletamentoRemedy(ass[0], mappaBe.values(), true); 
            }
            if(act.productProvisionigCodes=='18'){
                List<String> nomiPbeSet = new List<String>();
                nomiPbeSet.add('Non riscontrato: Con Uscita');
                Map<String, OF_BillingElement__c> mappaBE= OF_Espletamento_Generico_AP.getMapBeName_BE(nomiPbeSet,checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c);
                epl.espletamentoRemedy(ass[0], mappaBe.values(), true); 
            }
            system.debug('id codice ordine olo'+casoRemAtt[0].EOF_Codice_Ordine_OLO__c );
            o1.OF_IDOrdineOLO__c=casoRemAtt[0].EOF_Codice_Ordine_OLO__c;
            update o1;
            
        }
        
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        
        EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0'; 
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        //creo ed inserisco l'ack ad RM (RM->SF - ACK - Ftth in Order) e aggiorno il sl di riferimento con l'ACK
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
            'Type' => 'ACK', 
                'Codice_ordine_OLO' => c.EOF_Codice_Ordine_OLO__c,
                'Flusso' => 'RM-SF', 
                'Caso' =>c.Id, 
                'Metodo' => 'ASSURANCE ADD',
                'Tipo Comunicazione' => 'RM->SF - ACK - ASSURANCE ADD',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';
        OF_GPONP_FTTH_Utils.slRMSF.Caso__c=c.Id;		
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;
        OF_GPONP_FTTH_Utils.EndTemplog(); 
        return resp; 
    }

}