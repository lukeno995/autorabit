public without sharing class OF_StatusUpdateP2PBase extends OF_StatusUpdateP2PService {
    public OF_StatusUpdateP2PBase() {
		System.debug('@@@@@@ OF_StatusUpdateP2PBase istanziata');
    }

	public override OF_StatusUpdate_P2P.Response doEspletamento(OF_StatusUpdate_P2P.Request rqst, OF_StatusUpdate_P2P.Response rspnse) {
		return OF_Utils_P2P.handleEspletamentoBase(rqst, rspnse); 
	}
}