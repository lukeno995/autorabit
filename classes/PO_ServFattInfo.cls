public class PO_ServFattInfo {
	private Map<String, ServFattList__c> cs;
	private List<ServFattList__c> srvList;

	public PO_ServFattInfo() {
		cs = ServFattList__c.getAll();
		srvList = cs.values();
	}

	public Set<String> getNames() {
		return cs.keySet();
	}

	public List<String> getCodes() {
		List<String> codes = new List<String>();
		for (ServFattList__c c : srvList) {
			codes.add(c.code__c);
		}
		return codes;
	}

	/**
	 * @return Mappa<RecordType.DeveloperName del Case, InfoServizio>
	 */
	public Map<String, ServFattList__c> getEspletamentoPSMServiceMap() {
		Map<String, ServFattList__c> m = new Map<String, ServFattList__c>();
		for (ServFattList__c c : srvList) {
			if (String.isNotBlank(c.externalSystem__c) && c.externalSystem__c.containsIgnoreCase('PSM')) {
				m.put(c.caseDevName__c, c);
			}
		}
		return m;
	}

	/**
	 * @return Mappa<RecordType.DeveloperName del Case, InfoServizio>
	 */
	public Map<String, ServFattList__c> getCaseDevNameMap() {
		Map<String, ServFattList__c> m = new Map<String, ServFattList__c>();
		for (ServFattList__c c : srvList) {
			m.put(c.caseDevName__c, c);
		}
		return m;
	}

	public Set<String> getDevNamesForOpportunityHandler() {
		Set<String> toReturn = new Set<String>();
		for (ServFattList__c c : srvList) {
			toReturn.add(c.oppChildDevName__c);
			toReturn.add(c.oppParentDevName__c);
		}
		return toReturn;
	}

	public List<String> getCessazioneBeList(String srvName) {
		ServFattList__c info = cs.get(srvName);
		if (info == null) {
			return new List<String>();
		}
		return info.cessazioneBeList__c.split(',');
	}
}