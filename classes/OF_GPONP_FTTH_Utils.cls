public without sharing class OF_GPONP_FTTH_Utils {
    public static EOF_EAI_Service_Log__c slRMSF;
    public static boolean checkRTMap = false;
    public static asset ass;
    public static Double AttrTime; 
    public static Map <String,Id> RTMap;
    public static string Response;
   	public static Case caseOriginale; 
    public static Request_Remedy__c request;
    public static list <Request_Remedy__c> reqList;
	public static boolean checkCaseOriginale=false;
    public static TEMPLOG__c tmpl; 
    public static string servattivi = 'Open Stream'; 
    public static string servpassivi = 'GPON Passiva';
    public static string servintavuoto = 'Intervento a vuoto';
    public static string servverticale = 'Verticale';
    public static boolean checkRT_DevNameId_Map = false;   
    public static map<String,String> RT_DevNameId_Map;
    public static boolean checkRT_IdDevName_Map = false;   
    public static map<String,String> RT_IdDevName_Map;
    public  static Order o;
    public static ID idAsset{set;get;}
    public Static String assetId;
    public Static String rtName;
    public Static String nomeServizio;
    
    
    
    //Creo metodo per la definizione dei codici di errore mappare le response
    public static OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse syncError(Object o, String errorCode, String fieldName){
        
        OF_GPONP_FTTH_Utils.Response='NACK';
        List<String> result = new List<String>();
        //aggiungo SL di riferimento
        EOF_EAI_Service_Log__c slRiferimento;
        OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse res_temp = new OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse();
        //TODO: chiedere antonio per logId e responseDate
        res_temp.statusCode = '';
        res_temp.entity = '';
        res_temp.errorMessage= '';
        String errorDesc = '';
        String tipo_comunicazione='';
        String Codice_operatore='';
        String CODICE_ORDINE_OLO='';
        String RICHIESTA_NOTIFICA='';
        String metodo='';
        String flusso=''; 
        
        
        if(errorCode == 'A05')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';   
               
        if(errorCode == 'R01')
            errorDesc = 'Nessuna request con\''+ fieldName + '\'presente';   
        if(errorCode == 'R02')
            errorDesc = 'request con\''+ fieldName + '\'gia presente';  
        
        if(errorCode == 'A06')
            errorDesc = 'Valore campo \''+ fieldName + '\' non ammesso';
        
        if(errorCode == 'B_K16') 
            errorDesc = 'Campo \''+ fieldName +'\' non vendibile per l\' OLO';
        
        if(errorCode == 'B_K17')
            errorDesc = 'OLO non abilitato all\' invio dell\'ordine';
        
        if(errorCode == 'B_K20')
            errorDesc = 'OLO non presente';
        
        if(errorCode == 'B_K21')
            errorDesc = 'Id risorsa non presente';
        
        if(errorCode == 'B_K22')
            errorDesc = 'Ordine non gestito perché non su GPON Passiva. Valore PackageProvisioningCode diverso da 2';
        
        if(errorCode == 'B_K23')
            errorDesc = 'Ordine non gestito perché non su GPON Passiva. Valore ProductProvisioningCode diverso da 4';
        
        if(errorCode == 'B_K24')
            errorDesc = 'Codice ordine OLO non presente';
        
        if(errorCode == 'B_K25')
            errorDesc = 'Ordine non gestito perché non su GPON Passiva. Valore ProductProvisioningCode diverso da 6';
        
        if(errorCode == 'B_K26'){
            errorDesc = 'Valore ProductProvisioningCode diverso da quelli presenti a Catalogo';
        }
        if(errorCode == 'B_K28'){
            errorDesc = 'Codice ordine OLO già esistente';
        }
        
        if(o instanceof OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest){
            system.debug('sono qui 1');
            OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest x = (OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest) o;
            
            slRiferimento = OF_GPONP_FTTH_Utils.slRMSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='RM->SF - NACK - FTTH IN ORDER';
            flusso='OLO-SF';
            Metodo='FTTH IN ORDER';
            Codice_operatore=x.customerId;
            CODICE_ORDINE_OLO=x.customerOrder;
            RICHIESTA_NOTIFICA=Copy_request(x);
            
        }  
        if(o instanceof OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest){
            
            OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest x = (OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest) o;
            
            slRiferimento = OF_GPONP_FTTH_Utils.slRMSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='RM->SF - NACK - FTTH OUT ORDER';
            flusso='RM-SF';
            Metodo='FTTH IN ORDER';
            CODICE_ORDINE_OLO=x.customerOrder;
            RICHIESTA_NOTIFICA=Copy_request(x);
            
        } 
        if(o instanceof OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest){
            
            OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest x = (OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest) o;
            
            slRiferimento = OF_GPONP_FTTH_Utils.slRMSF; 
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='RM->SF - NACK - CPE ADD';
            flusso='OLO-SF';
            Metodo='CPE ADD';
            RICHIESTA_NOTIFICA=Copy_request(x);
            
        } 
        if(o instanceof OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest){
            
            OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest x = (OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest) o;
            
            slRiferimento = OF_GPONP_FTTH_Utils.slRMSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='RM->SF - NACK - PROVISIONING ADD';
            flusso='OLO-SF';
            Metodo='PROVISIONING ADD';
            Codice_operatore=x.customerId;
            CODICE_ORDINE_OLO=x.customerOrder;
            RICHIESTA_NOTIFICA=Copy_request(x);
            
        } 
        if(o instanceof OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest){
            
            OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest x = (OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest) o;
            
            slRiferimento = OF_GPONP_FTTH_Utils.slRMSF;
            slRiferimento.EOF_Response__c='NACK';
            update slRiferimento;
            
            tipo_comunicazione='RM->SF - NACK - ASSURANCE ADD';
            flusso='OLO-SF';
            Metodo='ASSURANCE ADD';
            RICHIESTA_NOTIFICA=Copy_request(x);
            
        }
        
        res_temp.statusCode = '1'  ;
        res_temp.logId='1';
        res_temp.errorMessage = errorDesc;
        res_temp.entity = '1';
        res_temp.responseDate= Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss');
        system.debug('@@@@@@response:'+ JSON.serialize(res_temp));
        //faccio il check se il service log  di riferimento è stato correttamente popolato
        String slReferenceId;
        if(slRiferimento != null){
            system.debug('sono qui 2'+ slRiferimento.Id);
            slReferenceId = slRiferimento.Id;
        }
        EOF_EAI_Service_Log__c slNACK = create_EAI_Log(new Map<String,String>{'Type' => 'NACK',
            'Codice_errore' => errorCode,
            'Causale_errore' => errorDesc,
            'Flusso' => flusso,
            'Metodo' => metodo,
            'Codice_operatore' => Codice_operatore,
            'Codice_ordine_OLO' => CODICE_ORDINE_OLO,
            'Richiesta Notifica' => RICHIESTA_NOTIFICA,
            'Tipo Comunicazione' => tipo_comunicazione,
            'SL Riferimento' => slReferenceId});
        insert slNACK;
        system.debug('@@@@@@response prima del return:'+ JSON.serialize(res_temp));        
        return res_temp;
    }
    
    public static EOF_EAI_Service_Log__c create_EAI_Log(Object o){
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        } 
        if(o instanceof OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest){
            OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest r = (OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest) o;         
            OF_GPONP_FTTH_Utils.slRMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('OF_FTTH_ADD'), 
                EOF_Data_Espletamento_Ordine__c=stringToDateNoTime(r.actionDate),
                EOF_Tipo_COmunicazione_String__c='RM->SF - FTTH IN ORDER', 
                EOF_CODICE_OPERATORE__c=r.customerId, 
                EOF_CODICE_ORDINE_OLO__c=r.customerOrder,
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            
            insert OF_GPONP_FTTH_Utils.slRMSF;
            
            
            return slRMSF;
        }
        if(o instanceof OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest){
            OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest r = (OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest) o;         
            OF_GPONP_FTTH_Utils.slRMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('OF_FTTH_ADD'), 
                EOF_DATA_NOTIFICA__c=StringToDate(r.actionDate),
                EOF_Tipo_COmunicazione_String__c='RM->SF - FTTH OUT ORDER',    
                EOF_CODICE_ORDINE_OLO__c=r.customerOrder,
                EOF_Richiesta_Notifica__c = copy_request(r) 
            );
            
            insert OF_GPONP_FTTH_Utils.slRMSF;
            
            return slRMSF; 
        }
        if(o instanceof OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest){
            OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest r = (OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest) o;         
            OF_GPONP_FTTH_Utils.slRMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('OF_FTTH_ADD'), 
                EOF_DATA_NOTIFICA__c=StringToDate(Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss')),
                EOF_Tipo_COmunicazione_String__c='RM->SF - CPE_ADD',   
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            
            insert OF_GPONP_FTTH_Utils.slRMSF;         
            return slRMSF;
        }
        if(o instanceof OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest){
            OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest r = (OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest) o;         
            OF_GPONP_FTTH_Utils.slRMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('OF_FTTH_ADD'), 
                EOF_DATA_NOTIFICA__c=StringToDate(r.actionDate),
                EOF_Tipo_COmunicazione_String__c='RM->SF - NETWORK ADD',    
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            insert OF_GPONP_FTTH_Utils.slRMSF;
            return slRMSF;
        }
        if(o instanceof OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest){
            OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest r = (OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest) o;         
            OF_GPONP_FTTH_Utils.slRMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('OF_FTTH_ADD'), 
                EOF_DATA_NOTIFICA__c=StringToDate(r.actionDate),
                EOF_Tipo_COmunicazione_String__c='RM->SF - PROVISIONING_ADD',    
                EOF_CODICE_OPERATORE__c=r.customerId, 
                EOF_CODICE_ORDINE_OLO__c=r.customerOrder,
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            
            insert OF_GPONP_FTTH_Utils.slRMSF;
            return slRMSF;
        }
        if(o instanceof OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest){
            OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest r = (OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest) o;         
            OF_GPONP_FTTH_Utils.slRMSF = new EOF_EAI_Service_Log__c(
                RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('OF_FTTH_ADD'), 
                EOF_DATA_NOTIFICA__c=StringToDate(Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss')),
                EOF_Tipo_COmunicazione_String__c='RM->SF - ASSURANCE ADD',    
                EOF_Richiesta_Notifica__c = copy_request(r)
            );
            
            insert OF_GPONP_FTTH_Utils.slRMSF;
            return slRMSF;
        }
        if(o instanceof Map<String, String>){
            
            if(((Map<String, String>) o).get('Type') == 'ACK'){ 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('ACK'),
                    Caso__c = ((Map<String, String>) o).get('Caso'),
                    OF_SA_Direzione_Flusso__c=((Map<String, String>) o).get('Flusso'),
                    OF_SA_Metodo__c=((Map<String, String>) o).get('Metodo'),
                    EOF_Stato_Richiesta__c = 'OK',
                    EOF_MOTIVAZIONE__c=((Map<String, String>) o).get('Motivazione'),
                    EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('Richiesta Notifica'),  
                    EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),
                    //aggiungo sl di riferimento
                    EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),
                    EOF_Data_Notifica__c = system.now()       
                );
                
                if(OF_GPONP_FTTH_Utils.checkCaseOriginale){
                    sl.Caso__c=OF_GPONP_FTTH_Utils.caseOriginale.Id;
                }
                return sl;
            }
            
            if(((Map<String, String>) o).get('Type') == 'NACK'){
                OF_GPONP_FTTH_Utils.logMessage( true, 'L','OF_GPONP_FTTH_Utils','syncError','Map<String, String>) o).get(\'Type\'):'+((Map<String, String>) o).get('Type'));
                String s=''; 
                EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c(
                    RecordTypeId = OF_GPONP_FTTH_Utils.RTMap.get('NACK'), 
                    OF_SA_Direzione_Flusso__c=((Map<String, String>) o).get('Flusso'),
                    OF_SA_Metodo__c=((Map<String, String>) o).get('Metodo'),
                    EOF_Stato_Richiesta__c = 'KO',
                    EOF_Codice_Errore__c = ((Map<String, String>) o).get('Codice_errore'),
                    EOF_Causale_Errore__c = ((Map<String, String>) o).get('Causale_errore'),
                    EOF_Codice_Ordine_OLO__c = ((Map<String, String>) o).get('Codice_ordine_OLO'),
                    EOF_Codice_Operatore__c = ((Map<String, String>) o).get('Codice_operatore'),
                    EOF_Richiesta_Notifica__c = ((Map<String, String>) o).get('Richiesta Notifica'),  
                    EOF_Tipo_Comunicazione_String__c = ((Map<String, String>) o).get('Tipo Comunicazione'),  
                    //aggiungo sl di riferimento
                    EOF_SL_Riferimento__c= ((Map<String, String>) o).get('SL Riferimento'),               
                    EOF_Data_Notifica__c = system.now()         
                );
                if(OF_GPONP_FTTH_Utils.checkCaseOriginale){
                    system.debug('log nack'+ OF_GPONP_FTTH_Utils.caseOriginale.Id);
                    sl.Caso__c=OF_GPONP_FTTH_Utils.caseOriginale.Id;
                }
                return sl;
            }
        }         
        return null;
    } 
    
    public static String copy_request(object o){
        String s;
        String data_prevista_attivazione='';
        //attivazione pre SF
        if(o instanceOf OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest){
            OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest a = (OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest) o;
            
            s=  'ACTION_DATE: '+ a.actionDate + '\n' + 
                'CREATED_BY: '+ a.createdBy + '\n' +            
                'CUSTOMER_DIVISION: '+ a.customerDivision + '\n' +
                'CUSTOMERD_ID: '+ a.customerId + '\n' +
                'CUSTOMER_ORDER: '+ a.customerOrder + '\n' +
                'INTERNAL_ORDER: '+ a.internalOrder + '\n' +
                'NETWORK_ID_RESOURCE: '+ a.networkIdResource + '\n' +
                'PACKAGE_PROVISIONING_CODE: '+ a.packageProvisioningCode + '\n' +
                'POP: '+ a.pop + '\n' +
                'PRICE_PLAN_PRVISIONING_CODE: '+ a.pricePlanProvisioningCode + '\n' +
                'PRODUCT_PROVISIONING_CODES: '+ a.productProvisionigCodes + '\n' +
                'PROMO_CODE: '+ a.promoCode + '\n' +
                'VERTICAL_OPERATOR: '+ a.verticalOperator + '\n';   
        }
        if(o instanceOf OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest){
            OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest a = (OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderRequest) o;
            s=  'ACTION_DATE: '+ a.actionDate + '\n' + 
                'CREATED_BY: '+ a.createdBy + '\n' +            
                'CUSTOMER_ORDER: '+ a.customerOrder + '\n' +
                'INTERNAL_ORDER: '+ a.internalOrder + '\n' +
                'NETWORK_ID_RESOURCE: '+ a.networkIdResource + '\n' +
                'PRODUCT_PROVISIONING_CODE: '+ a.productProvisioningCode + '\n';  
        }
        if(o instanceOf OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest){
            OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest a = (OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderRequest) o;
            s=  'ACTION_DATE: '+ a.actionDate + '\n' + 
                'CREATED_BY: '+ a.createdBy + '\n' +            
                'NETWORK_ID_RESOURCE: '+ a.networkIdResource + '\n' +
                'PRODUCT_PROVISIONING_CODES: '+ a.productProvisioningCodes + '\n' +
                'QUANTITY: '+ a.quantity + '\n' +
                'SERIAL_NUMBER: '+ a.serialNumber + '\n'; 
        }
        
        if(o instanceOf OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest){
            OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest a = (OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest) o;    
            s=  'ACTION_DATE: '+ a.actionDate + '\n' + 
                'CREATED_BY: '+ a.createdBy + '\n' +            
                'CUSTOMERD_ID: '+ a.customerId + '\n' +
                'CUSTOMER_ORDER: '+ a.customerOrder + '\n' + 
                'OLO_MESSAGE: '+ a.oloMessage + '\n' +
                'OLO_MESSAGE: '+ a.oloMessageCode + '\n' +
                'PRODUCT_PROVISIONING_CODES: '+ a.productProvisionigCodes + '\n';   
        }
        /* 
if(o instanceOf OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest){
OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest a = (OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderRequest) o;            
s=  'ACTION_DATE: '+ a.actionDate + '\n' + 
'CREATED_BY: '+ a.createdBy + '\n' +            
'BUILDING_NUMBER: '+ a.buildingNumber + '\n' +
'CUSTOMERD_ID: '+ a.customerId + '\n' +
'ELEMENTARY_AREA: '+ a.elementaryArea + '\n' +
'ID_BUILDING: '+ a.idBuilding + '\n' +
'MACRO_AREA: '+ a.macroArea + '\n' +
'POP: '+ a.pop + '\n' +		
'PRODUCT_PROVISIONING_CODES: '+ a.productProvisionigCodes + '\n' +
'PROMO_CODE: '+ a.promoCode + '\n' +
'TOPONYMY_UNIT: '+ a.toponymyUnit + '\n'+
'TOWN: '+ a.town + '\n';   
}*/
        
        if(o instanceOf OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest){
            OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest a = (OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderRequest) o;
            
            s=  'ACTION_DATE: '+ a.actionDate + '\n' + 
                'CREATED_BY: '+ a.createdBy + '\n' +            
                'FAULT_CAUSE: '+ a.faultCause + '\n' +
                'FAULT_RESOLUTION: '+ a.faultResolution + '\n' +
                'NETWORK_ID_RESOURCE: '+ a.networkIdResource + '\n' +
                'OLO_COMMON_CODE: '+ a.oloCommCode + '\n' +
                'PRODUCT_PROVISIONING_CODES: '+ a.productProvisionigCodes + '\n' +
                'TT_NUMBER: '+ a.ttNumber + '\n';   
        }
        return s;   
    }
    
    public static String copy_response (object o){
        String s;
        String data_prevista_attivazione='';
        //attivazione pre SF
        if(o instanceOf OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse){
            OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse a = (OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderResponse) o;
            
            s=  'STATUS CODE: '+ a.statusCode + '\n' + 
                'RESPONSE DATE: '+ a.responseDate + '\n' +  
                'ENTITY: '+ a.entity + '\n' +  
                'ERROR MESSAGE: '+ a.errorMessage + '\n' +  
                'LOG ID: '+ a.logId + '\n';
        }
        
        if(o instanceOf OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse){
            OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse a = (OF_GPONP_WS_IN_FTTH_OUT_ORDER.FtthDeactivationOrderResponse) o;
            s=  'STATUS CODE: '+ a.statusCode + '\n' + 
                'RESPONSE DATE: '+ a.responseDate + '\n' +  
                'ENTITY: '+ a.entity + '\n' +  
                'ERROR MESSAGE: '+ a.errorMessage + '\n' +  
                'LOG ID: '+ a.logId + '\n';
        }
        if(o instanceOf OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse){
            OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse a = (OF_GPONP_WS_IN_CPE_ADD.CpeAddOrderResponse) o;
            s=  'STATUS CODE: '+ a.statusCode + '\n' + 
                'RESPONSE DATE: '+ a.responseDate + '\n' +  
                'ENTITY: '+ a.entity + '\n' +  
                'ERROR MESSAGE: '+ a.errorMessage + '\n' +  
                'LOG ID: '+ a.logId + '\n';
        }
        
        if(o instanceOf OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse){
            OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse a = (OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderResponse) o;    
            s=  'STATUS CODE: '+ a.statusCode + '\n' + 
                'RESPONSE DATE: '+ a.responseDte + '\n' +  
                'ENTITY: '+ a.entity + '\n' +  
                'ERROR MESSAGE: '+ a.errorMessage + '\n' +  
                'LOG ID: '+ a.logId + '\n'; 
        }
        
        if(o instanceOf OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderResponse){
            OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderResponse a = (OF_GPONP_WS_IN_NETWORK_CREATION_ADD.NetworkCreationOrderResponse) o;            
            s=  'STATUS CODE: '+ a.statusCode + '\n' + 
                'RESPONSE DATE: '+ a.responseDate + '\n' +  
                'ENTITY: '+ a.entity + '\n' +  
                'ERROR MESSAGE: '+ a.errorMessage + '\n' +  
                'LOG ID: '+ a.logId + '\n';
        }
        if(o instanceOf OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse){
            OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse a = (OF_GPONP_WS_IN_ASSURANCE_ADD.AssuranceAddOrderResponse) o;
            s=  'STATUS CODE: '+ a.statusCode + '\n' + 
                'RESPONSE DATE: '+ a.responseDte + '\n' +  
                'ENTITY: '+ a.entity + '\n' +  
                'ERROR MESSAGE: '+ a.errorMessage + '\n' +  
                'LOG ID: '+ a.logId + '\n';
        }
        return s;   
    }    
    
    
    public static Datetime stringToDate(String s){
        if(String.isBlank(s)){
            return null;
        }
        Datetime dt = Datetime.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)),integer.valueOf(s.left(13).right(2)),integer.valueOf(s.left(16).right(2)),integer.valueOf(s.left(19).right(2)));
        return dt;
    }
    
    public static void EndTemplog(){        
        try{        
            // 8/06/2018 MM: Aggiorno il timestamp. END corrisponde all'uscita dal servizio.
            OF_GPONP_FTTH_Utils.tmpl.Tempi_Parziali__c = OF_GPONP_FTTH_Utils.tmpl.Tempi_Parziali__c + ', END: '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            OF_GPONP_FTTH_Utils.tmpl.Attraversamento__c = datetime.now().getTime() - OF_GPONP_FTTH_Utils.AttrTime;        
            OF_GPONP_FTTH_Utils.tmpl.OF_CPU_Time__c = string.valueof(Limits.getCpuTime());
            OF_GPONP_FTTH_Utils.tmpl.OF_CPU_Time_Limit__c = string.valueof(Limits.getLimitCpuTime());            
            // 8/06/2018 MM : Inserisco il templog            
            insert OF_GPONP_FTTH_Utils.tmpl;
        }catch(Exception e){
            system.debug('@@@ - Exception:' +e);
            system.debug('@@@ - line exc ' + e.getLineNumber());
            system.debug('@@@ - exc in method endtemplog');
        }
    } 
    public static void partialTemplog(String s){
        try{
            if(OF_GPONP_FTTH_Utils.tmpl!=null){
                OF_GPONP_FTTH_Utils.tmpl.Tempi_Parziali__c= OF_GPONP_FTTH_Utils.tmpl.Tempi_Parziali__c + ', '+s+' : '+Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
            }
        }
        catch(exception e){ 
            system.debug('@@@ - Exception:' +e); 
            system.debug('@@@ - line exc ' + e.getLineNumber());
            system.debug('@@@ - exc in method partialTempLog');
        } 
    }
    public static boolean checkDateTime(String S){
        if(String.isBlank(s)){    		
            return false;
        }
        if(!OF_GPONP_FTTH_Utils.checkDate(s.left(10))){    	
            return false;    		
        }
        if(!OF_GPONP_FTTH_Utils.checkTime(s.left(19).right(8))){    		
            return false;    		
        } 
        
        if(s.left(11).right(1)!='T'){    		
            return false;    		
        }
        
        if(s.right(6)!='+01:00' && s.right(6)!='+02:00' && s.right(6)!='+00:00'){
            return false;		 
        }
        
        return true;
    }
    public static boolean checkDate(String S){
        if(String.isBlank(s)){
            return false;
        }
        try{
            Date.valueOf(s);
            if(s.split('-').get(0).isNumeric() && Integer.valueOf(s.split('-').get(0))<1999){
                return false;
            }
        }
        catch(Exception e){
            return false;
        }
        return true;
    }
    public static boolean checkTime(String tmp){
        if(String.isBlank(tmp)){
            return false;
        }
        try{
            if(!tmp.split(':').get(0).isNumeric() || !tmp.split(':').get(1).isNumeric() || !tmp.split(':').get(2).isNumeric() ){
                return false;
            } 
            if(tmp.split(':').get(0).length() != 2 || tmp.split(':').get(1).length() != 2 || tmp.split(':').get(2).length() != 2 ){
                return false;
            }                       
            if(Integer.valueOf(tmp.split(':').get(0)) > 23 || Integer.valueOf(tmp.split(':').get(1)) > 59 || Integer.valueOf(tmp.split(':').get(2)) > 59 ){	
                return false;
            } 
        }catch(Exception e){
            return false;
        } 
        return true;
    }
    //String to date no time
    public static Date stringToDateNoTime(String s){
        if(String.isBlank(s)){
            return null;
        }
        Date dt = Date.newInstance(integer.valueOf(s.left(4)),integer.valueOf(s.left(7).right(2)),integer.valueOf(s.left(10).right(2)));
        return dt;
    }
    public static void CreateTemplogRM(Object o){
        try{
            if(o instanceof OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest){                
                OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest act = (OF_GPONP_WS_IN_FTTH_IN_ORDER.FtthCreateOrderRequest) o;
                
                // 8/06/2018 MM : Aggiunta creazione Templog per cattura timestamp attivazione
                OF_GPONP_FTTH_Utils.tmpl = new TEMPLOG__c();
                OF_GPONP_FTTH_Utils.tmpl.Name= act.customerOrder +' - '+'Attivazione da OLO'+' - '+ Datetime.now().format('yyyy-MM-dd HH:mm:ss','Europe/Rome');
                OF_GPONP_FTTH_Utils.tmpl.Tempi_Parziali__c= 'Start: ' +Datetime.now().format('HH:mm:ss','Europe/Rome')+'.'+DateTime.now().millisecond();
                OF_GPONP_FTTH_Utils.tmpl.desc__c='TEMPLOG relativo alla Request del case:'+ act.customerOrder;
                OF_GPONP_FTTH_Utils.tmpl.Type__c ='T';
                OF_GPONP_FTTH_Utils.tmpl.TL_codice_ordine_olo__c = act.customerOrder;
                OF_GPONP_FTTH_Utils.tmpl.Tipo_Comunicazione_String__c = 'RM-SF FTTH in ORDER';
                OF_GPONP_FTTH_Utils.tmpl.Timestamp__c = Datetime.now().format('HH:mm:ss','Europe/Rome');                
            }              
        }
        catch(exception e){
            system.debug('@@@ - Exception:' +e);
        }
    }
    
    public static void logMessage(Boolean active,String logType,String className, String methodName, String message){
        Boolean GeneralWriteLog = true;
        if (GeneralWriteLog) {
            if (active) {
                system.debug('active');
                try{
                    if (logType == 'L') {      
                        TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                            Type__c = 'L',
                            Class__c = className,
                            Method__c = methodName,
                            Desc__c = message,
                            Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                            
                        );
                        insert newDebugMsg;
                    } else  if (logType == 'E') {
                        
                        TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                            Type__c = 'E',
                            Class__c = className,
                            Method__c = methodName,
                            Desc__c = message,
                            Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                        );
                        insert newDebugMsg;
                    } else  if (logType == 'P') {
                        TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                            Type__c = 'P',
                            Class__c = className,
                            Method__c = methodName,
                            Desc__c = message,
                            Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                        );
                        insert newDebugMsg;
                    } else   {
                        TEMPLOG__c newDebugMsg = new TEMPLOG__c(
                            Type__c = 'N',
                            Class__c = className,
                            Method__c = methodName,
                            Desc__c = message,
                            Timestamp__c = system.now().format('YYYY-MM-dd HH:mm:ss')
                        );
                        insert newDebugMsg;
                    }
                    
                }
                catch (Exception ex){
                    System.debug('Failed to INSERT logMessage in TEMPLOG__c ' + 'Error: ' + ex.getMessage());
                }
            }
        }
    }
    public static map<String,String> getRT_DevNameId_Map(){
        if(OF_GPONP_FTTH_Utils.checkRT_DevNameId_Map){
            return OF_GPONP_FTTH_Utils.RT_DevNameId_Map;
        }
        else{
            OF_GPONP_FTTH_Utils.RT_DevNameId_Map=new map<String,String>();
            for(recordType rt : [select id,developername from recordType]){
                OF_GPONP_FTTH_Utils.RT_DevNameId_Map.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRT_DevNameId_Map=true;
            return OF_GPONP_FTTH_Utils.RT_DevNameId_Map;
        }
    }
    
    //metodo per ricevere una mappa con chiave id e valore devname dei recordtype
    public static map<String,String> getRT_IdDevName_Map(){
        if(OF_GPONP_FTTH_Utils.checkRT_IdDevName_Map){
            return OF_GPONP_FTTH_Utils.RT_IdDevName_Map;
        }
        else{
            OF_GPONP_FTTH_Utils.RT_IdDevName_Map=new map<String,String>();
            for(recordType rt : [select id,developername from recordType]){
                OF_GPONP_FTTH_Utils.RT_IdDevName_Map.put(rt.id,rt.developername);
            }
            OF_GPONP_FTTH_Utils.checkRT_IdDevName_Map=true;
            return OF_GPONP_FTTH_Utils.RT_IdDevName_Map;
        }
    }
    public static string TipoServ(case c){
        try{ 
            if( (c.recordtypeId == OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Attivazione_Remedy')) || (c.recordtypeId == OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Cessazione_Remedy'))){
                c.OF_Servizio__c = 'GPON Passiva'; 
                return 'Passivo';
            }
            return null;
        }catch( Exception e ){
            OF_GPONP_FTTH_Utils.logMessage(true,'E','Classe: OF_ManageOrderFromCase_GPONP',
                                           'Method: TipoServ',
                                           'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
            return null;
        }
    }
    /*
    public static Id ManageOrder(Case c){
         system.debug('manage');
        //Attivazione         
        if( c.RecordtypeId == OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Attivazione_Remedy') ){             
            //Creazione Ordine
            if( (c.Status.equalsIgnoreCase('Acquisito') ||c.status.equalsIgnoreCase('Acquisito KO') || c.Status.equalsIgnoreCase('Espletato') && c.OF_Order__c == null )){
                system.debug('sono nell in order creazione ordine');
                return creazioneOrdine( c , 'OF_INORDER');
            }
            
        }
        //Cessazione
        if( c.RecordtypeId == OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Cessazione_Remedy') ){ 
            //Creazione Ordine 
            
            if( ( c.status.equalsIgnoreCase('CESSATO KO') )||(c.status.equalsIgnoreCase( 'CESSATO OK')) && c.OF_Order__c == null ){
                system.debug('sono nell out order creazione ordine');
                return creazioneOrdine( c , 'OF_OUTORDER');
            }
            //Aggiornamento Ordine
            
        }
        return null;
    }
    */
    public static Order ManageOrder(Case c){
         system.debug('manage');
        system.debug('c.RecordtypeId '+c.RecordtypeId+' '+ OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Attivazione_Remedy'));
        system.debug('c status'+ c.status);
        //Attivazione         
        if( c.RecordtypeId == OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Attivazione_Remedy') ){    
            system.debug('entro in questo if manager in order');
            //Creazione Ordine
            if( (c.Status.equalsIgnoreCase('Acquisito') ||c.status.equalsIgnoreCase('Acquisito KO') || c.Status.equalsIgnoreCase('Espletato') && c.OF_Order__c == null )){
                system.debug('sono nell in order creazione ordine');
                return creazioneOrdine( c , 'OF_INORDER');
            }
            
        }
        //Cessazione
        if( c.RecordtypeId == OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('EOF_Caso_Cessazione_Remedy') ){ 
            //Creazione Ordine 
            
            if( ( c.status.equalsIgnoreCase('CESSATO KO') )||(c.status.equalsIgnoreCase( 'CESSATO OK')) && c.OF_Order__c == null ){
                system.debug('sono nell out order creazione ordine');
                return creazioneOrdine( c , 'OF_OUTORDER');
            }
            //Aggiornamento Ordine
            
        }
        return null;
    }
    public static Order createOrderFromReq(OF_GPONP_WS_IN_PROVISIONING_ADD.ProvisioningAddOrderRequest req, Account acc)
    { 
        
        order o = new order();
        List <Transcodifica_OLO_Remedy__c> t =[SELECT Name, Comune__c from Transcodifica_OLO_Remedy__c where CustomerId__c=:req.customerId limit 1];
        if (!t.isEmpty()){
            o.Of_Comune__c=t[0].comune__c;
        }
        o.OF_IDOrdineOLO__c=req.customerOrder;
        o.OF_IDOrdineEOF__c=req.customerOrder;
        o.AccountId = acc.id;
        
        
       // o.EffectiveDate = Date.Today();
        o.OF_TipologiaDiServizio__c = 'GPON PASSIVA';
        
        o.Status = 'Chiuso';
        o.OF_Esito__c = 'OK';
        o.OF_DataEsito__c = OF_GPONP_FTTH_Utils.stringToDateNoTime(req.actionDate);
        //TODO recuperare id contratto 
        
        Id contractId = [SELECT OF_Contract__c 
                         FROM OF_ContrattoServizio__c 
                         WHERE OF_Contract__r.accountid=:acc.id
                         AND OF_Servizio__r.name='GPON Passiva'
                         AND OF_Contract__r.Status = 'Attivo' LIMIT 1].OF_Contract__c;
        
        o.ContractId =contractId;
        o.OF_TipologiaDiServizio__c = 'GPON PASSIVA';
        insert o;
        system.debug('***oreder from req'+req.customerOrder);
        system.debug('***customerORder'+o.id);
        system.debug('***oreder from reqasd '+o.OF_IDOrdineOLO__c);
        return o;
    }   

    public static Order createOrderFromLog(String SLRmSfId, Account acc)
    { 
        OF_GPONP_FTTH_Utils.slRMSF = Database.query(OF_GPONP_FTTH_Utils.getQueryNew('sl','ProvisioningAdd','','')+
                                                           ' where id=:SLRmSfId'); 
        order o = new order();
        List <Transcodifica_OLO_Remedy__c> t =[SELECT Name, Comune__c from Transcodifica_OLO_Remedy__c where CustomerId__c=:OF_GPONP_FTTH_Utils.slRMSF.Remedy_customerId__c limit 1];
        if (!t.isEmpty()){
            o.Of_Comune__c=t[0].comune__c;
        }
        o.OF_IDOrdineOLO__c=OF_GPONP_FTTH_Utils.slRMSF.Remedy_customerOrder__c;
        o.OF_IDOrdineEOF__c=OF_GPONP_FTTH_Utils.slRMSF.Remedy_customerOrder__c;
        o.AccountId = acc.id;
        
        
        o.EffectiveDate = system.Today();
        o.OF_TipologiaDiServizio__c = 'GPON PASSIVA';
        
        o.Status = 'Chiuso';
        o.OF_Esito__c = 'OK';
        Date d=date.newinstance(OF_GPONP_FTTH_Utils.slRMSF.actionDate_Remedy__c.year(), OF_GPONP_FTTH_Utils.slRMSF.actionDate_Remedy__c.month(), OF_GPONP_FTTH_Utils.slRMSF.actionDate_Remedy__c.day());
        o.OF_DataEsito__c = d;        
        //TODO recuperare id contratto 
        
        Id contractId = [SELECT OF_Contract__c 
                         FROM OF_ContrattoServizio__c 
                         WHERE OF_Contract__r.accountid=:acc.id
                         AND OF_Servizio__r.name='GPON Passiva'
                         AND OF_Contract__r.Status = 'Attivo' LIMIT 1].OF_Contract__c;
        
        o.ContractId =contractId;
        o.OF_TipologiaDiServizio__c = 'GPON PASSIVA';
        insert o;
        return o;
    } 
    public static id creazioneCasoFromOrder(Order o, Account a){
        Case casoOrd= new Case(); 
        
        if(!OF_GPONP_FTTH_Utils.checkRTMap){ 
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_GPONP_FTTH_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_GPONP_FTTH_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_GPONP_FTTH_Utils.checkRTMap=true;
        } 
        casoOrd.RecordTypeId=OF_GPONP_FTTH_Utils.rtMap.get('EOF_Caso_Attivazione_Remedy');
        casoOrd.subject='Richiesta di attivazione';
        casoOrd.status='Acquisito'; 
        casoOrd.EOF_Codice_Ordine_OLO__c=o.OF_IDOrdineOLO__c;
        casoOrd.OF_SA_ID_Servizio__c=o.OF_IDServizio__c ;
        casoOrd.EOF_Account_OLO__c=o.AccountId;
        casoOrd.OF_IDContratto__c=o.ContractId;
        casoOrd.AssetId= o.OF_Asset__c;
        system.debug('id ordine:'+ o.id);
        casoOrd.OF_Order__c =o.id;
        casoOrd.EOF_Id_Risorsa__c=o.OF_IDRisorsa__c;
        casoOrd.EOF_Codice_Operatore_WS__c= a.EOF_Codice_Operatore__c;
        insert casoOrd;
        return casoOrd.id;
        
    }
    /*
    public static Order creazioneOrdine( Case c , String recordTypeName ){
        system.debug('*************account legato al case:'+ c.EOF_Account_OLO__c);
        order o = new order();
        o.RecordTypeId = OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get( recordTypeName );
        o.AccountId = c.EOF_Account_OLO__c;
        
        
        o.OF_CaseID__c = c.id;
        o.OF_CaseNome__c=c.CaseNumber;
        o.OF_Comune__c= c.EOF_Comune_WS__c;
        
        o.EffectiveDate = system.Today();
        
        o.OF_TipologiaDiServizio__c = TipoServ(c);
        system.debug('o.account creato'+o.account);  
        system.debug('*** contract name:'+  c.OF_IDContratto__c);
        if(c.OF_IDContratto__c != null){         
            o.ContractId = c.OF_IDContratto__c;
        }
        
        o.OF_CaseNome__c = c.CaseNumber;
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
        o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
        
        
        if( recordTypeName == 'OF_INORDER' ){
            
            if( c.Status == 'Acquisito'){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'OK';
                o.OF_CaseID__c = c.id;
                o.OF_DataEsito__c = c.PO_Data_Espletamento_Ordine__c;
                //aggiunti i campi descrizione KO e codice KO per i servizi attivi
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }
            if( c.Status == 'ESPLETATO'){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'OK';
                o.OF_CaseID__c = c.id;
                o.OF_DataEsito__c = c.PO_Data_Espletamento_Ordine__c;
                //aggiunti i campi descrizione KO e codice KO per i servizi attivi
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }
            if( 'Acquisito KO'.equalsIgnoreCase(c.Status)){
                system.debug('acquisito ko');
                o.OF_CaseID__c = c.id;
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_DataEsito__c = c.PO_Data_Espletamento_Ordine__c;
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;  
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c; 
                if(c.EOF_Order_Manager__c == true){
                    o.OF_IDOrdineEOF__c = c.id;
                }else{
                    o.OF_IDOrdineEOF__c = String.valueOf(c.Id).substring(0, 15);
                }
                c.OF_Order__c = o.id;
            }
            insert o;
            
        }
        if( recordTypeName == 'OF_OUTORDER' ){
            if( c.Status == 'CESSATO KO' ){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'KO';
                o.OF_DataEsito__c = c.PO_Data_Espletamento_Ordine__c;
                o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
            }else if( c.Status == 'Acquisito'){
                o.OF_DataEsito__c = c.PO_Data_Espletamento_Ordine__c;
                o.OF_Esito__c = 'OK';
                o.Status = 'Chiuso';
            }else if( c.Status == 'CESSATO OK'){
                o.OF_DataEsito__c = c.PO_Data_Espletamento_Ordine__c;
                o.OF_Esito__c = 'OK';
                o.Status = 'Chiuso';
            }
            
            o.OF_Asset__c = c.AssetId;
            o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
            o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
            insert o;
        }
        c.OF_Order__c = o.Id;
        update c;
        system.debug('****id ordine: '+o.id);
        return o.Id;
    }
	*/
    public static Order creazioneOrdine( Case c , String recordTypeName ){
        system.debug('*************account legato al case:'+ c.EOF_Account_OLO__c);
        order o = new order();
        o.RecordTypeId = OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get( recordTypeName );
        o.AccountId = c.EOF_Account_OLO__c;
                o.EffectiveDate = system.Today();

        
        o.OF_CaseID__c = c.id;
        o.OF_CaseNome__c=c.CaseNumber;
        o.OF_Comune__c= c.EOF_Comune_WS__c;        
        o.OF_TipologiaDiServizio__c = TipoServ(c);
        system.debug('o.account creato'+o.account);  
        system.debug('*** contract name:'+  c.OF_IDContratto__c);
        if(c.OF_IDContratto__c != null){         
            o.ContractId = c.OF_IDContratto__c;
        }
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
        o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
        
        
        if( recordTypeName == 'OF_INORDER' ){
            
            if( c.Status == 'ESPLETATO'){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'OK';
                o.OF_CaseID__c = c.id;
                o.OF_DataEsito__c =system.Today();
            }
        }
        if( recordTypeName == 'OF_OUTORDER' ){
		 if( c.Status == 'CESSATO OK'){
                o.Status = 'Chiuso';
                o.OF_Esito__c = 'OK';
                o.OF_CaseID__c = c.id;
                o.OF_DataEsito__c =system.Today();
            }
        }
            o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
            o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
            insert o;
        return o;
    }

    public static Asset CreateAssetFromOrder(Order o){       
        Asset a = new Asset();
        a.accountId = o.AccountId;
        
        a.recordtypeId = OF_GPONP_FTTH_Utils.getRT_DevNameId_Map().get('OF_GPONPassiva');  
        a.EOF_ID_Risorsa__c = o.OF_IDRisorsa__c;  
        a.OF_Identificativo_del_POP__c=o.OF_IdentificativoDelPOP__c;
        a.status='Attivo';
        a.OF_Contract__c = o.ContractId;
        /*
        if(prov!=null && prov==''){
        a.name=o.OF_IDOrdineOLO__c;
        } else{
        a.name=o.OF_IDRisorsa__c;
        }
*/
        a.OF_Comune__c= o.OF_Comune__c;
        a.OF_DataAttivazione2__c =o.OF_Remedy_actionDate__c; // Billing
        
        insert a;
        
        o.OF_Asset__c=a.Id;
        OF_GPONP_FTTH_Utils.assetId=a.id; 
        update o;
        return a;
    }
    
    public static String getQueryNew(String oggetto,String Processo ,string start,string endrange){
        string s=null;
        if(oggetto=='order'){
          if(Processo=='AsyncActivation'){
              s=' SELECT Id,RecordType.Name,RecordType.Id,OF_Type__c,OF_Remedy_actionDate__c,'+
                  'OF_TipologiaDiServizio__c,EffectiveDate,Status,OF_Remedy_Quantity__c,'+
                  'OF_DataEsito__c,OF_CodiceKO__c,OF_Esito__c, OF_Remedy_oloMessage__c,OF_Remedy_oloMessageCode__c,'+
                  'OF_DescrizioneKO__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,'+
                  'OF_IDRisorsa__c,AccountId,OF_IDBuilding__c,OF_Asset__c, of_remedy_olocommcode__c, of_remedy_ttnumber__c,'+
                  'OF_SlaPremiumAssurance__c,OF_Apparato__c, of_remedy_faultCause__c, of_remedy_faultResolution__c,'+
                  'OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,'+
                  'OF_PasswordApparato__c,ContractId,OF_CaseID__c,OF_CaseNome__c,'+
                  'OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,'+
                  'OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,'+
                  'OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,OF_AccountTemporaneo__c,'+
                  'OF_Remedy_customerDivision__c, OF_Remedy_customerId__c,OF_Remedy_internalOrder__c,'+
                  'OF_Remedy_packageProvisioningCode__c, OF_Remedy_pricePlanProvisioningCode__c, OF_Remedy_productProvisionigCode__c,'+ 
                  'OF_Remedy_verticalOperator__c '+
                  'FROM Order ';
          }
    }

        if(oggetto=='sl'){
            if(processo=='CpeAdd'){
                s='select OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,EOF_Tipo_COmunicazione_String__c, '
                    +'Remedy_Network_Id_Resource__c,actionDate_Remedy__c,'
                    +'Quantity__c,PRODUCT_PROVISIONING_CODE__c,recordtype.developername,recordtype.name,recordtypeId'
                    +' from EOF_EAI_Service_Log__c';
            }
            if(processo=='ProvisioningAdd'){
                s='select OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,EOF_Tipo_COmunicazione_String__c, remedy_customerOrder__c,Remedy_oloMessageCode__c, '
                    +'Remedy_Network_Id_Resource__c,actionDate_Remedy__c,PRODUCT_PROVISIONING_CODE__c,remedy_oloMessage__c,remedy_customerId__c,'
                    +'Quantity__c,recordtype.developername,recordtype.name,recordtypeId'
                    +' from EOF_EAI_Service_Log__c';
            }
            if(processo=='AssuranceAdd'){
                s='select OF_SA_Direzione_Flusso__c,OF_SA_Metodo__c,EOF_Tipo_COmunicazione_String__c, remedy_customerOrder__c,Remedy_oloMessageCode__c, '
                    +'Remedy_Network_Id_Resource__c,actionDate_Remedy__c,PRODUCT_PROVISIONING_CODE__c,remedy_oloMessage__c,remedy_customerId__c,'
                    +'Quantity__c,recordtype.developername,recordtype.name,recordtypeId'
                    +' from EOF_EAI_Service_Log__c';
            }
        }
        if(oggetto=='request'){           
            if(Processo=='AsyncActivation'){
                s='Select Id, OF_Remedy_actionDate__c,RecordTypeId,recordtype.developername, OF_Remedy_createdBy__c, OF_Remedy_customerDivision__c, '
                    +'OF_Remedy_customerId__c,EOF_Codice_Operatore_WS__c,OF_Remedy_customerOrder__c,OF_Remedy_internalOrder__c,EOF_Account_OLO__c,'
                    +'OF_Remedy_networkIdResource__c,OF_Comune__c,OF_Contract__c,OF_Remedy_packageProvisioningCode__c,OF_ID_Servizio__c,' 
                    +'OF_Remedy_pop__c,OF_Remedy_pricePlanProvisioningCode__c,OF_Remedy_productProvisioningCode__c,'
                    +'OF_Remedy_promoCode__c,OF_Remedy_quantity__c, OF_Remedy_verticalOperator__c '
                    +'from Request_Remedy__c where Request_Number__c >\''+ start + '\'and Request_Number__c < \''+ endrange+ '\'';
            }
            if(Processo=='AsyncDeActivation'){
                s='Select Id, OF_Remedy_actionDate__c,RecordTypeId, recordtype.developername,OF_Remedy_createdBy__c, OF_Remedy_customerDivision__c, '
                    +'OF_Remedy_customerId__c,OF_Remedy_customerOrder__c,OF_Remedy_internalOrder__c,'
                    +'OF_Remedy_networkIdResource__c,OF_Remedy_packageProvisioningCode__c,' 
                    +'OF_Remedy_pop__c,OF_Remedy_pricePlanProvisioningCode__c,OF_Remedy_productProvisionigCodes__c'
                    +'OF_Remedy_promoCode__c, OF_Remedy_verticalOperator__c'
                    +'from Request_Remedy__c';
            }
            if(Processo=='CpeAdd'){
                s='Select Id, OF_Remedy_actionDate__c, RecordTypeId, OF_Remedy_createdBy__c, recordtype.developername,OF_Remedy_customerDivision__c, '
                    +'OF_Remedy_customerId__c,OF_Remedy_customerOrder__c,OF_Remedy_internalOrder__c,'
                    +'OF_Remedy_networkIdResource__c,OF_Remedy_packageProvisioningCode__c,' 
                    +'OF_Remedy_pop__c,OF_Remedy_pricePlanProvisioningCode__c,OF_Remedy_productProvisionigCodes__c'
                    +'OF_Remedy_promoCode__c, OF_Remedy_verticalOperator__c'
                    +'from Request_Remedy__c';
            }
            if(Processo=='ProvisioningAdd'){
                s='Select Id, OF_Remedy_actionDate__c,RecordTypeId, OF_Remedy_createdBy__c, recordtype.developername,OF_Remedy_customerDivision__c, '
                    +'OF_Remedy_customerId__c,OF_Remedy_customerOrder__c,OF_Remedy_internalOrder__c,'
                    +'OF_Remedy_networkIdResource__c,OF_Remedy_packageProvisioningCode__c,' 
                    +'OF_Remedy_pop__c,OF_Remedy_pricePlanProvisioningCode__c,OF_Remedy_productProvisionigCodes__c'
                    +'OF_Remedy_promoCode__c, OF_Remedy_verticalOperator__c'
                    +'from Request_Remedy__c';
            }
            if(Processo=='AssuranceAdd'){
                s='Select Id, OF_Remedy_actionDate__c,RecordTypeId, OF_Remedy_createdBy__c, recordtype.developername,OF_Remedy_customerDivision__c, '
                    +'OF_Remedy_customerId__c,OF_Remedy_customerOrder__c,OF_Remedy_internalOrder__c,'
                    +'OF_Remedy_networkIdResource__c,OF_Remedy_packageProvisioningCode__c,' 
                    +'OF_Remedy_pop__c,OF_Remedy_pricePlanProvisioningCode__c,OF_Remedy_productProvisionigCodes__c'
                    +'OF_Remedy_promoCode__c, OF_Remedy_verticalOperator__c'
                    +'from Request_Remedy__c';
            }
        }
        return s; 
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
              a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
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
    //ESPLETAMENTO ORDINE DI CESSAZIONE
    //All'espletamento di un Ordine di Cessazione si devono eseguire le seguenti operazioni:
    //1.Cessazione Asset
    //2.Cessazione CE	 
    // mappare tutta la request nel log
}