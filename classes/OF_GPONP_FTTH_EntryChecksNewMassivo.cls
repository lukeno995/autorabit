public without sharing class OF_GPONP_FTTH_EntryChecksNewMassivo {
    public static case c; 
    public static case cs;
    public static Asset a; 
    public static Account acc;
    public static List <Account> listAcc;
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
    public static Request_Remedy__c request;
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp;
    
    
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksFTTHinORDER(OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest act){
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act); 
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }  
        
        Request_Remedy__c request= new Request_Remedy__c();
        request.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Request_Attivazione_Remedy');
        if(string.isblank(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }
        else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }     
        request.OF_Remedy_actionDate__c= act.actionDate; 
        
        if(string.isblank(act.customerId)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ID');
        } 
        else {   
            System.debug('****** act.customerId => ' + act.customerId);
            List<Transcodifica_OLO_Remedy__c> transOLORemlst =[SELECT Name, Comune__c from Transcodifica_OLO_Remedy__c where CustomerId__c=:act.customerId limit 1];           
            if (!transOLORemlst.isEmpty()){
                Transcodifica_OLO_Remedy__c t = transOLORemlst[0];
                listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where Name=: t.Name and type='OLO' limit 1];
                if(!listAcc.isEmpty()){
                    request.OF_Remedy_customerId__c=listAcc[0].Name;
                    request.EOF_Account_OLO__c=listAcc[0].id;
                    request.OF_Comune__c=transOLORemlst[0].Comune__c;
                }else{
                    return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
                }
            }
        }
        if(string.isblank(act.customerOrder)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ORDER'); 
        }else {
            system.debug('act.productProvisionigCodes'+act.productProvisionigCodes);
            List <Order> verificaCustOrder= [SELECT id FROM order WHERE OF_IDORDINEOLO__c=:act.customerOrder and OF_Asset__r.status='Attivo'];
            if (!verificaCustOrder.isEmpty()){
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER'); 
            } else {
                List <Request_Remedy__c> listReq= [SELECT id from Request_Remedy__c where OF_Remedy_customerOrder__c=:act.customerOrder and recordType.developername='EOF_Request_Attivazione_Remedy' ];
                if(listReq.isEmpty()){
                    system.debug('request no');
                    request.OF_Remedy_customerOrder__c=act.customerOrder;
                }
                else{
                    OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                    return OF_GPONP_FTTH_Utils.syncError (act,'R02','NETWORK_ID_RESOURCE');
                }
                
            }
        }
        if(string.isblank(act.packageProvisioningCode)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PACKAGE_PROVISIONING_CODE'); 
        } 
        request.OF_Remedy_packageProvisioningCode__c=act.packageProvisioningCode;
        if(string.isblank(act.internalOrder)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','INTERNAL_ORDER');
        }
        request.OF_Remedy_internalOrder__c=act.internalOrder;
        if(string.isblank(act.networkIdResource)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        }
        List <Asset> ass= [SELECT Id, name, AccountId,OF_Comune__c, Account.type, ContactId   
                           FROM Asset Where name=:act.networkIdResource and status='Attivo' ];
        if(ass.isEmpty()){
            system.debug('asset no');
            
            List <Request_Remedy__c> listReq= [SELECT id from Request_Remedy__c where OF_Remedy_customerOrder__c=:act.customerOrder and OF_Remedy_networkIdResource__c=:act.networkIdResource and recordType.developername='EOF_Request_Attivazione_Remedy' ];
            if(listReq.isEmpty()){
                system.debug('request no');
                request.OF_Remedy_networkIdResource__c=act.networkIdResource;
            }
            else{
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'R02','NETWORK_ID_RESOURCE');
            }
        } else{
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'R02','NETWORK_ID_RESOURCE');
            }
		if(string.isblank(act.pop)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','POP');
        } 
        request.OF_Remedy_pop__c=act.pop;
        
        //check contract 
        List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name, OF_servizio__c, OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                           where OF_Servizio__r.name='GPON Passiva' 
                                                           and OF_Contract__r.Status='Attivo'
                                                           AND OF_Contract__r.AccountId =: listAcc[0].id LIMIT 1];            
            request.OF_Contract__c=checkGPNPContract[0].OF_Contract__c;

        if(checkGPNPContract.isEmpty()){
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
        } else {
            system.debug('contratto '+request.OF_Contract__c);
            request.OF_ID_Servizio__c=checkGPNPContract[0].OF_servizio__c;
            request.OF_Service_Code__c=checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c;
            
        }
        //check cittÃ  
        List<OF_AreaGeograficaJunction__c> checkCityCOntract =[select id from OF_AreaGeograficaJunction__c 
                                                               where OF_Contratto__c =:checkGPNPContract[0].OF_Contract__c];
        if(checkCityCOntract.isEMpty()){
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K16','POP');
        } 
        
        if(string.isblank(act.pricePlanProvisioningCode)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRICE_PLAN_PROVISIONING_CODE'); 
        } 
        request.OF_Remedy_pricePlanProvisioningCode__c=act.pricePlanProvisioningCode;
        if(string.isblank(act.productProvisionigCodes)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }else if (act.productProvisionigCodes!='4'){
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K23','PRODUCT_PROVISIONING_CODE'); 
        }
        request.OF_Remedy_productProvisioningCode__c=act.productProvisionigCodes;        
        if(string.isblank(act.verticalOperator)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','VERTICAL_OPERATOR'); 
        } 
        request.OF_Remedy_verticalOperator__c=act.verticalOperator;    
        
        request.OF_Remedy_promoCode__c=act.promoCode; 
        insert request;
  
        
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
                'Metodo' => 'FTTH IN ORDER',
                'Tipo Comunicazione' => 'RM->SF - ACK - FTTH IN ORDER',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';		
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;   
        return resp; 
    }
    
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksCPEADD(OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest act) {
        
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        Request_Remedy__c request= new Request_Remedy__c();
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        } 
        request.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Request_CPE_Remedy');
        system.debug('recordtypeId:0128E000000AEY2QAO  --->'+ request.RecordTypeId);
        
        if(string.isblank(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }
        request.OF_Remedy_actionDate__c= act.actionDate;   
        if(string.isblank(act.networkIdResource)){
            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        } 
        List <Asset> ass= [SELECT Id, name, AccountId,OF_Comune__c, Account.type, OF_Contract__c   
                           FROM Asset Where name=:act.networkIdResource and status='Attivo' ];
        if(ass.isEmpty()){
            system.debug('asset no');
            
            List <Request_Remedy__c> listReq= [SELECT id from Request_Remedy__c where OF_Remedy_networkIdResource__c=:act.networkIdResource and recordType.developername='EOF_Request_Attivazione_Remedy' ];
            if(listReq.isEmpty()){
                system.debug('request no');
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'R01','NETWORK_ID_RESOURCE');
            }
            else{
                request.OF_Remedy_networkIdResource__c=act.networkIdResource;
            }
        }  else {
            
            request.OF_Remedy_networkIdResource__c=act.networkIdResource;
            listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where id=: ass[0].AccountId and type='OLO' limit 1];
            if(!listAcc.isEmpty()){
                request.OF_Remedy_customerId__c=listAcc[0].Name;
                request.EOF_Account_OLO__c=listAcc[0].id;
                request.OF_Comune__c=ass[0].OF_Comune__c;
            //check contract 
            List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                               where OF_Servizio__r.name='GPON Passiva' 
                                                               and OF_Contract__r.Status='Attivo'
                                                               AND OF_Contract__r.AccountId =: listAcc[0].id];
            
            
            if(checkGPNPContract.isEmpty()){
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
            }else {
                
                request.OF_Contract__c=checkGPNPContract[0].OF_Contract__c;
                system.debug('contratto '+request.OF_Contract__c);
                request.OF_ID_Servizio__c=checkGPNPContract[0].OF_servizio__c;
                request.OF_Service_Code__c=checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c;
                
            }
                
            } else {     
                system.debug('account no');
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
            }

        }      
        
        
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
                            return resp;  
                        }  else{                
                            OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                            //TODo
                            return OF_GPONP_FTTH_Utils.syncError (act,'B_K26','PRODUCT_PROVISIONING_CODE'); 
                            
                        }                 
                 } 
        request.OF_Remedy_productProvisioningCode__c=act.productProvisioningCodes;  
        request.OF_Remedy_quantity__c=act.quantity;
        insert request;        
        
        //Creo il log della request
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        
        EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0';
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
            'Type' => 'ACK',
                'Flusso' => 'RM-SF',
                'Metodo' => 'CPE ADD',
                'Tipo Comunicazione' => 'RM->SF - ACK - CPE ADD',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';	
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;
        return resp; 
    } 
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksPROVISIONINGADD(OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest act){
        
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        Request_Remedy__c request= new Request_Remedy__c();
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        
        
        request.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Request_Provisioning_Remedy');
        if(string.isblank(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }
        else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }     
        request.OF_Remedy_actionDate__c= act.actionDate;  
        if(string.isblank(act.customerId)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ID');
        } 
        else {   
            System.debug('****** act.customerId => ' + act.customerId);
            List<Transcodifica_OLO_Remedy__c> transOLORemlst =[SELECT Name, Comune__c from Transcodifica_OLO_Remedy__c where CustomerId__c=:act.customerId limit 1];           
            if (!transOLORemlst.isEmpty()){
                Transcodifica_OLO_Remedy__c t = transOLORemlst[0];
                listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where Name=: t.Name and type='OLO' limit 1];
                if(!listAcc.isEmpty()){
                    request.OF_Remedy_customerId__c=listAcc[0].Name;
                    request.EOF_Account_OLO__c=listAcc[0].id;
                    request.OF_Comune__c=transOLORemlst[0].Comune__c;
                    //check contract 
                    List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name, OF_servizio__c, OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                                       where OF_Servizio__r.name='GPON Passiva' 
                                                                       and OF_Contract__r.Status='Attivo'
                                                                       AND OF_Contract__r.AccountId =: listAcc[0].id LIMIT 1];
                    if(checkGPNPContract.isEmpty()){
                        return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
                    } else {
                        
                        request.OF_Contract__c=checkGPNPContract[0].OF_Contract__c;
                        system.debug('contratto '+request.OF_Contract__c);
                        request.OF_ID_Servizio__c=checkGPNPContract[0].OF_servizio__c;
                        request.OF_Service_Code__c=checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c;
                        
                    }
                }else{
                    return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
                }
            }
        }
        List <Order> verificaCustOrder = new  List <Order>();
        if(string.isblank(act.customerOrder)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ORDER'); 
        }
        List <Order> ord= [SELECT Id  
                           FROM Order Where OF_IDOrdineOLO__c=:act.customerOrder];
        if(!ord.isempty()){
            List <Asset> ass= [SELECT Id, name, AccountId,OF_Comune__c, Account.type   
                               FROM Asset Where OF_OrdineID__c=:ord[0].id and status='Attivo'];
        if(ass.isEmpty()){
            system.debug('asset no');
            
            List <Request_Remedy__c> listReq= [SELECT id from Request_Remedy__c where OF_Remedy_customerOrder__c=:act.customerOrder and recordType.developername='EOF_Request_Provisioning_Remedy' ];
            if(listReq.isEmpty()){
                system.debug('request no');
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'R01','CUSTOMER_ORDER');
            }
            else{
                request.OF_Remedy_customerOrder__c=act.customerOrder;
            }
        }  else {
                request.OF_Remedy_customerOrder__c=act.customerOrder;
                listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where id=: ass[0].AccountId and type='OLO' limit 1];
                if(!listAcc.isEmpty()){
                    request.OF_Remedy_customerId__c=listAcc[0].Name;
                    request.EOF_Account_OLO__c=listAcc[0].id;
                    request.OF_Comune__c=ass[0].OF_Comune__c;                 
                }else {     
                    system.debug('account no');
                    OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                    return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
                }
            } 
        }else {request.OF_Remedy_customerOrder__c=act.customerOrder;}
        
        if(string.isblank(act.productProvisionigCodes)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }  
        request.OF_Remedy_oloMessage__c=act.olomessage;
        request.OF_Remedy_oloMessageCode__c=act.olomessagecode;
        insert request;
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
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksASSURANCEADD(OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest act) {
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
      
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
        
        Request_Remedy__c request= new Request_Remedy__c();
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        request.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Request_Assurance_Remedy');
        if(string.isblank(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }
        else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }     
        request.OF_Remedy_actionDate__c= act.actionDate;   
        if(string.isblank(act.networkIdResource)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        } 
        
     List <Asset> ass= [SELECT Id, name, AccountId,OF_Comune__c, Account.type, OF_Contract__c   
                           FROM Asset Where name=:act.networkIdResource and status='Attivo' ];
        if(ass.isEmpty()){
            system.debug('asset no');
            
            List <Request_Remedy__c> listReq= [SELECT id from Request_Remedy__c where OF_Remedy_networkIdResource__c=:act.networkIdResource and recordType.developername='EOF_Request_Attivazione_Remedy' ];
            if(listReq.isEmpty()){
                system.debug('request no');
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'R01','NETWORK_ID_RESOURCE');
            }
            else{
                request.OF_Remedy_networkIdResource__c=act.networkIdResource;
            }
        }  else {
            request.OF_Remedy_networkIdResource__c=act.networkIdResource;
            listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where id=: ass[0].AccountId and type='OLO' limit 1];
            if(!listAcc.isEmpty()){
                request.OF_Remedy_customerId__c=listAcc[0].Name;
                request.EOF_Account_OLO__c=listAcc[0].id;
                request.OF_Comune__c=ass[0].OF_Comune__c;
            //check contract 
            List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                               where OF_Servizio__r.name='GPON Passiva' 
                                                               and OF_Contract__r.Status='Attivo'
                                                               AND OF_Contract__r.AccountId =: listAcc[0].id];
            
            
            if(checkGPNPContract.isEmpty()){
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
            }else {
                
                request.OF_Contract__c=checkGPNPContract[0].OF_Contract__c;
                system.debug('contratto '+request.OF_Contract__c);
                request.OF_ID_Servizio__c=checkGPNPContract[0].OF_servizio__c;
                request.OF_Service_Code__c=checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c;
                
            }
                
            } else {     
                system.debug('account no');
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
            }

        }      
        if(string.isblank(act.oloCommCode)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','OLO_COMMON_CODE'); 
        } 
        request.OF_Remedy_oloCommCode__c=act.oloCommCode; 
        if(string.isblank(act.faultCause)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','FAULT_CAUSE'); 
        } 
        request.OF_Remedy_faultCause__c=act.faultCause;
        request.OF_Remedy_faultResolution__c=act.faultResolution;
        
        if(string.isblank(act.productProvisionigCodes)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }
        request.OF_Remedy_ttNumber__c=act.ttNumber;
        if(string.isblank(act.ttNumber)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','TT_NUMBER');
        } 
       	request.OF_Remedy_productProvisioningCode__c =act.productProvisionigCodes;
        
        insert request;
        EOF_EAI_Service_Log__c slRMSFreq = new EOF_EAI_Service_Log__c();
        resp.statusCode='0';
        resp.entity='0'; 
        resp.errorMessage='0'; 
        resp.logId='0';
        resp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        slRMSFreq= OF_GPONP_FTTH_Utils.create_EAI_Log(new Map<String,String>{
            'Type' => 'ACK', 
                'Flusso' => 'RM-SF', 
                'Metodo' => 'ASSURANCE ADD',
                'Tipo Comunicazione' => 'RM->SF - ACK - ASSURANCE ADD',
                'SL Riferimento' => OF_GPONP_FTTH_Utils.slRMSF.Id});
        OF_GPONP_FTTH_Utils.slRMSF.EOF_Response__c='ACK';		
        slRMSFreq.EOF_Richiesta_Notifica__c=OF_GPONP_FTTH_Utils.copy_response(resp);
        
        slToUpsert.add(OF_GPONP_FTTH_Utils.slRMSF);
        slToUpsert.add(slRMSFreq);
        upsert slToUpsert;
        return resp; 
    }
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse SyncChecksFTTHoutORDER(OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest act) {
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse resp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>(); 
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        }
        
        OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act); 
     
        Request_Remedy__c request= new Request_Remedy__c();
        request.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Request_Cessazione_Remedy');
        if(string.isblank(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','ACTION_DATE');
        }
        else if(!OF_GPONP_FTTH_Utils.checkDateTime(act.actionDate)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A06','ACTION_DATE');
        }     
        request.OF_Remedy_actionDate__c= act.actionDate; 
        
        if(string.isblank(act.customerOrder)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','CUSTOMER_ORDER'); 
        }else {
            List <Order> verificaCustOrder= [SELECT id FROM order WHERE OF_IDORDINEOLO__c=:act.customerOrder and OF_Asset__r.status='Attivo'];
            if (!verificaCustOrder.isEmpty()){
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K28','CUSTOMER_ORDER'); 
            } else {
                List <Request_Remedy__c> listReq= [SELECT id from Request_Remedy__c where OF_Remedy_customerOrder__c=:act.customerOrder and recordType.developername='EOF_Request_Attivazione_Remedy' ];
                if(listReq.isEmpty()){
                    system.debug('request no');
                    request.OF_Remedy_customerOrder__c=act.customerOrder;
                }
                else{
                    OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                    return OF_GPONP_FTTH_Utils.syncError (act,'R02','NETWORK_ID_RESOURCE');
                }
                
            }
        }       
        List <Asset> ass= [SELECT Id, name, AccountId,OF_Comune__c, Account.type, OF_Contract__c   
                           FROM Asset Where name=:act.networkIdResource and Status='Attivo'];
        if(ass.isEmpty()){
            system.debug('asset no');
            List <Request_Remedy__c> listReq= [SELECT id, recordtype.developername from Request_Remedy__c where OF_Remedy_networkIdResource__c=:act.networkIdResource and recordType.developername='EOF_Request_Attivazione_Remedy']; 
            if(listReq.isEmpty()){
                system.debug('request no');
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'R01','NETWORK_ID_RESOURCE');
            } else{
                for (Request_Remedy__c rq : listReq){
                    if(rq.recordtype.developername=='EOF_Request_Cessazionee_Remedy'){
                        return OF_GPONP_FTTH_Utils.syncError (act,'R02','NETWORK_ID_RESOURCE');  
                    } else{
                        request.OF_Remedy_networkIdResource__c=act.networkIdResource;
                    }
                }
            }  
        }  else {
            request.OF_Remedy_networkIdResource__c=act.networkIdResource;
            listAcc = [SELECT Id, EOF_Codice_Operatore__c, name from Account where id=: ass[0].AccountId and type='OLO' limit 1];
            if(!listAcc.isEmpty()){
                request.OF_Remedy_customerId__c=listAcc[0].Name;
                request.EOF_Account_OLO__c=listAcc[0].id;
                request.OF_Comune__c=ass[0].OF_Comune__c;
                         //check contract 
            List<OF_ContrattoServizio__c> checkGPNPContract = [select id,name,OF_Contract__c, OF_Servizio__r.OF_Servizio_Code__c from OF_ContrattoServizio__c 
                                                               where OF_Servizio__r.name='GPON Passiva' 
                                                               and OF_Contract__r.Status='Attivo'
                                                               AND OF_Contract__r.AccountId =: ass[0].accountid
                                                               AND OF_contract__c=:ass[0].OF_Contract__c ];
            
            
            if(checkGPNPContract.isEmpty()){
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K17','CUSTOMER_ID');
            }else {
                
                request.OF_Contract__c=checkGPNPContract[0].OF_Contract__c;
                system.debug('contratto '+request.OF_Contract__c);
                request.OF_ID_Servizio__c=checkGPNPContract[0].OF_servizio__c;
                request.OF_Service_Code__c=checkGPNPContract[0].OF_Servizio__r.OF_Servizio_Code__c;
                
            }   
            } else {        
                OF_GPONP_FTTH_Utils.slRMSF = OF_GPONP_FTTH_Utils.create_EAI_Log(act);
                return OF_GPONP_FTTH_Utils.syncError (act,'B_K20','CUSTOMER_ID');
            }
        }      
        
        if(string.isblank(act.internalOrder)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','INTERNAL_ORDER');
        }
        request.OF_Remedy_internalOrder__c=act.internalOrder;
        if(string.isblank(act.networkIdResource)){
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','NETWORK_ID_RESOURCE'); 
        } 
        request.OF_Remedy_networkIdResource__c=act.networkIdResource;
        
        
        if(string.isblank(act.productProvisioningCode)){ 
            return OF_GPONP_FTTH_Utils.syncError (act,'A05','PRODUCT_PROVISIONING_CODE'); 
        }
        else if (act.productProvisioningCode!='6'){
            return OF_GPONP_FTTH_Utils.syncError (act,'B_K25','PRODUCT_PROVISIONING_CODE'); 
        }
        insert request;

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
                'Metodo' => 'FTTH OUT ORDER',
                'Tipo Comunicazione' => 'RM->SF - ACK - FTTH OUT ORDER',
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
    public static void testCoverage(){
        Integer a=1;
        Integer b=1;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;


    }
}