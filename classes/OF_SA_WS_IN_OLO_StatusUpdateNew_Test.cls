@isTest
public class OF_SA_WS_IN_OLO_StatusUpdateNew_Test{
    static testMethod void OLO_StatusUpdateMethod(){
        Test.startTest();
        {
            OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest req = new OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdateRequest();
            req.CODICE_OPERATORE = ''; 
            req.CODICE_ORDINE_OLO = '9876543';
            req.DATA_NOTIFICA= String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
            req.ID_NOTIFICA = String.valueOf(System.now().getTime());
            //req.AZIONE = '1';
            //req.CODICE_MOTIVAZIONE = '1';
            //req.MOTIVAZIONE = 'test';
            //req.DATA_PREVISTA_ATTIVAZIONE = '';
            //req.ORARIO_APPUNTAMENTO = '';
            req.NOME_CLIENTE = '';
            req.COGNOME_CLIENTE = '';
            req.RECAPITO_TELEFONICO_CLIENTE_1 = '';
            req.RECAPITO_TELEFONICO_CLIENTE_2 = '';
            req.NOTE = 'qweqw';
            
            OF_SA_WS_IN_OLO_StatusUpdateNew.OLO_StatusUpdate(req);
        }
        }
}