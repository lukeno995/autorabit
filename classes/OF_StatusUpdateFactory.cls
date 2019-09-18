public without sharing class OF_StatusUpdateFactory {

    OF_StatusUpdateFactory() {}
	
    public static OF_StatusUpdateP2PService getP2PService(String oloCode){
		String rType = getCaseRecordType(oloCode);
		if(rType.equalsIgnoreCase('PO_Ordine_P2P')) {
			return new OF_StatusUpdateP2PBase();
		}
		if(rType.equalsIgnoreCase('PO_Ordine_P2P_Attiva') 
			|| rType.equalsIgnoreCase('P2P_Attiva_COrdine_ELine')){
			return new OF_StatusUpdateP2PAttiva();
		}
		return null;
	}
    
	private static String getCaseRecordType(String oloCode) {
		List<Case> lCase = [select RecordType.developerName from case where EOF_Codice_Ordine_OLO__c =: oloCode limit 1];
		return (lCase.isEmpty()) ? '' : lCase[0].RecordType.developerName;
	}
}