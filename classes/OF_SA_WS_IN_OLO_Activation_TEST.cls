@isTest
public class OF_SA_WS_IN_OLO_Activation_TEST 
{
    
     static testMethod void OF_SA_WS_IN_OLO_ActivationTEST()
    {
    //  OF_SA_WS_IN_OLO_Activation OLO_Act = new OF_SA_WS_IN_OLO_Activation();
     
       /* OF_SA_WS_IN_OLO_Activation.VLAN OLO_VAN = new OF_SA_WS_IN_OLO_Activation.VLAN();
        OLO_VAN.KIT_CONSEGNA_VLAN = 'Test';
        OLO_VAN.USER_VLAN = 'Test';
        OLO_VAN.SERVICE_VLAN = 'Test';
        OLO_VAN.PROFILO_VLAN = 'Test';
        OLO_VAN.INFORMAZIONI_VLAN = 'Test';
        OLO_VAN.CUSTOMER_VLAN = 'Test';
        OLO_VAN.MODELLO_DI_SERVIZIO_VLAN = 'Test';
        List<OF_SA_WS_IN_OLO_Activation.VLAN> OLO_VLANList = new List<OF_SA_WS_IN_OLO_Activation.VLAN>();
        OLO_VLANList.add(OLO_VAN);
        
        OF_SA_WS_IN_OLO_Activation.APPARATO OLO_APPARATO = new OF_SA_WS_IN_OLO_Activation.APPARATO();
        OLO_APPARATO.TIPOLOGIA_APPARATO = 'Test';
        OLO_APPARATO.PASSWORD_APPARATO = 'Test';
        OLO_APPARATO.AZIONE_APPARATO = 'Test';
        List<OF_SA_WS_IN_OLO_Activation.APPARATO> OLO_APPARATOList = new List<OF_SA_WS_IN_OLO_Activation.APPARATO>();
        OLO_APPARATOList.add(OLO_APPARATO);
        
        OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO OLO_SERAGG = new OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO();
        OLO_SERAGG.NOME_SERVIZIO = 'Test'; 
        OLO_SERAGG.INFORMAZIONI_SERVIZIO = 'Test';
        List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO> OLO_SERAGGList = new List<OF_SA_WS_IN_OLO_Activation.SERVIZIO_AGGIUNTIVO>();
        OLO_SERAGGList.add(OLO_SERAGG);
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse OLO_ACTRESP = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse();
        OLO_ACTRESP.ID_NOTIFICA = 'Test';
        OLO_ACTRESP.ESITO = 'Test';
        OLO_ACTRESP.CODICE_MOTIVAZIONE = 'Test'; 
        OLO_ACTRESP.MOTIVAZIONE = 'Test';
        
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest OLO_ACTREQ = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest();
        OLO_ACTREQ.CODICE_OPERATORE='Test';
        OLO_ACTREQ.CODICE_ORDINE_OLO = 'Test';
        OLO_ACTREQ.DATA_NOTIFICA = 'Test';
        OLO_ACTREQ.ID_NOTIFICA = 'Test';
        OLO_ACTREQ.NOME_REFERENTE_TECNICO_OLO = 'Test';
        OLO_ACTREQ.COGNOME_REFERENTE_TECNICO_OLO = 'Test';
        OLO_ACTREQ.TELEFONO_REFERENTE_TECNICO_OLO = 'Test';
        OLO_ACTREQ.EMAIL_REFERENTE_TECNICO_OLO = 'Test';
        OLO_ACTREQ.TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH = 'Test';
        OLO_ACTREQ.NOME_CLIENTE = 'Test';
        OLO_ACTREQ.COGNOME_CLIENTE = 'Test';
        OLO_ACTREQ.RECAPITO_TELEFONICO_CLIENTE_1 = 'Test';
        OLO_ACTREQ.RECAPITO_TELEFONICO_CLIENTE_2 = 'Test';
        OLO_ACTREQ.INFORMAZIONI_LOGISTICA_APPARATI = 'Test';
        OLO_ACTREQ.DATA_PREVISTA_ATTIVAZIONE = 'Test';
        OLO_ACTREQ.ORARIO_APPUNTAMENTO = 'Test';
        OLO_ACTREQ.CODICE_PROGETTO_SPECIALE = 'Test';
        OLO_ACTREQ.PROMOZIONE = 'Test';
        OLO_ACTREQ.CLUSTER_PROMOZIONE = 'Test';
        OLO_ACTREQ.NOTE = 'Test';
        OLO_ACTREQ.ID_BUILDING = 'Test';
        OLO_ACTREQ.SCALA_PALAZZINA = 'Test';
        OLO_ACTREQ.NUMERO_TELEFONICO_PRINCIPALE_LINEA = 'Test';
        OLO_ACTREQ.RECAPITO_TEST_LINEA = 'Test';
        OLO_ACTREQ.IDENTIFICATIVO_DEL_POP = 'Test';
        OLO_ACTREQ.PROFILO = 'Test';
     // OLO_ACTREQ.VLAN.addAll(OLO_VLANList);
     // OLO_ACTREQ.APPARATO.addAll(OLO_APPARATOList);
     // OLO_ACTREQ.SERVIZIO_AGGIUNTIVO.addAll(OLO_SERAGGList);*/
      OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse omStatusUpdateNew = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationResponse(); 
       
        OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest omStatusUpdate = new OF_SA_WS_IN_OLO_Activation.OLO_ActivationRequest(); 
        OF_SA_WS_IN_OLO_Activation.OLO_Activation(omStatusUpdate);
        
    }
}