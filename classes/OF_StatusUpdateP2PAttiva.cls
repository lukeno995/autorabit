// classe da cancellare dopo refactoring per sviluppo housing
public without sharing class OF_StatusUpdateP2PAttiva extends OF_StatusUpdateP2PService {
    public OF_StatusUpdateP2PAttiva() {
        System.debug('OF_StatusUpdateP2PAttiva istanziata.');
    }

    public override OF_StatusUpdate_P2P.Response doEspletamento(OF_StatusUpdate_P2P.Request rqst, OF_StatusUpdate_P2P.Response rspnse) {
	    return OF_Utils_P2P.handleEspletamentoAttiva(rqst, rspnse);  
    }
}