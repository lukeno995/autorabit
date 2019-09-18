public class OF_PP_SendRetryPP_Methods {
	
	@future(callout=true)
	public static void retryCalloutOLOOM(String caseId){
		//vado a creare la mappa dei recordtype per poi utilizzarla
        OF_PP_GE_Utils.RTMap = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype where sobjectType='EOF_EAI_Service_Log__c']){
            OF_PP_GE_Utils.RTMap.put(rt.developername,rt.id);
        }
        OF_PP_GE_Utils.checkRTMap=true;
        OF_PP_GE_Utils.retry=true;
		OF_PP_GE_Utils.caseOriginale=[select Id, OF_Bonifica_Locked_Row__c from case where id=:caseId];
		OF_PP_GE_Utils.caseOriginale.OF_Retry_Automatico__c=false;
		List<EOF_EAI_Service_Log__C> sList =[select id, recordtype.developername,EOF_Codice_Ordine_Olo__c,PO_PP_cos_class__c,EOF_CODICE_OPERATORE__c,
											Caso__c,PO_PP_ID_Richiesta_testo__c,PO_PP_Progressivo_Ordine__c,EOF_DATA_NOTIFICA__c,PO_PP_cos_remarking__c,
											EOF_ID_NOTIFICA__c,traffico__c,PO_PP_POP_raccolta__c,POP__c,Nome_del_KIT__c,PO_PP_dhcp_Option82__c,
											Banda_Interfaccia__c,PO_PP_Interfaccia__c,PO_PP_cos_type__c,PO_PP_User_VLAN__c, SVLAN__c
											from EOF_EAI_Service_Log__C where caso__c=:caseId and recordtype.developername in ('OF_PP_VLAN_ActivationRequest','OF_PP_COS')];
		
		for(EOF_EAI_Service_Log__C sl:sList){
			if(sl.recordtype.developername=='OF_PP_VLAN_ActivationRequest'){
				OF_PP_GE_Utils.slSFOM=sl;
			}
		}
		OF_PP_OLO_SendToOM.OM_CreateAckNackRequestActivation(sList);
		update OF_PP_GE_Utils.slSFOM;
	}
}