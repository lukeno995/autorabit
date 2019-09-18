@isTest
public class OLO_ActivationP2PRequestCheck_Test {
    
    @testSetup static void setup() {
    }
    
    @isTest
    static void checkActivationRequest_Test() {
        
        OLO_Activation_P2PSchema.Create_P2P_Request_element rqst = new OLO_Activation_P2PSchema.Create_P2P_Request_element();
        OLO_Activation_P2PSchema.Fattibilita fatt_rqst = new OLO_Activation_P2PSchema.Fattibilita();
        OLO_Activation_P2PSchema.Header_Request header_rqst =  new OLO_Activation_P2PSchema.Header_Request();
        // sotto Create_P2P_Request_element ho Fattibilita e Header_Request
        rqst.header = header_rqst;
        rqst.fattibilita = fatt_rqst;

        OLO_Activation_P2PSchema.ORDINE_element ordine_rqst = new OLO_Activation_P2PSchema.ORDINE_element();
        List<OLO_Activation_P2PSchema.ORDINE_element> list_ordineRqst = 
            new List<OLO_Activation_P2PSchema.ORDINE_element>();
        list_ordineRqst.add(ordine_rqst);

        OLO_Activation_P2PSchema.KIT kit_rqst = new OLO_Activation_P2PSchema.KIT();
        List<OLO_Activation_P2PSchema.KIT> list_kitRqst = 
            new List<OLO_Activation_P2PSchema.KIT>();
        list_kitRqst.add(kit_rqst);
        
        kit_rqst.AZIONE = 'AZIONE';
        kit_rqst.ID_ORDINE_KIT = 'idORDKIT';
        kit_rqst.NOME_KIT_CONSEGNA = 'NOME_KIT_CONSEGNA';
        kit_rqst.POP_CONSEGNA = 'POP_CONSEGNA';
        kit_rqst.INDIRIZZO_CONSEGNA = 'INDIRIZZO_CONSEGNA';
        kit_rqst.SERVICE_ATTRIBUTE = 'SERVICE_ATTRIBUTE';
       
        // sotto Fattibilita ho ORDINE_element e KIT        
        fatt_rqst.ORDINE = list_ordineRqst;
        fatt_rqst.SubInput4 = list_kitRqst;

        OLO_Activation_P2PSchema.SEDE  sede_rqst = new OLO_Activation_P2PSchema.SEDE();
        List<OLO_Activation_P2PSchema.SEDE> list_sedeRqst = 
            new List<OLO_Activation_P2PSchema.SEDE>();
        list_sedeRqst.add(sede_rqst);
        // sotto ordine ho sede
        ordine_rqst.SubInput1 = list_sedeRqst;

        OLO_Activation_P2PSchema.VLAN vlan_rqst = new OLO_Activation_P2PSchema.VLAN();
        List<OLO_Activation_P2PSchema.VLAN> list_vlanRqst = 
            new List<OLO_Activation_P2PSchema.VLAN>();
        list_vlanRqst.add(vlan_rqst);
        // sotto sede ho vlan
        sede_rqst.SubInput2 = list_vlanRqst;

        OLO_Activation_P2PSchema.COS cos_rqst = new OLO_Activation_P2PSchema.COS();
        List<OLO_Activation_P2PSchema.COS> list_cosRqst = 
            new List<OLO_Activation_P2PSchema.COS>();
        list_cosRqst.add(cos_rqst);
        // soto vlan ho cos
        vlan_rqst.SubInput5 = list_cosRqst;
        vlan_rqst.MODELLO_SERVIZIO = 'MODELLO_SERVIZIO';
        vlan_rqst.PROFILO = 'PROFILO';
        // valorizzo i campi

        header_rqst.DATA_CREAZIONE = System.now();
        header_rqst.ID_NOTIFICA = 'ID_notificaTest';
        header_rqst.TIPO_RICHIESTA = 'TipoReq';
         
        fatt_rqst.ID_FATTIBILITA = 'FATT_0001';  
        fatt_rqst.CODICE_OPERATORE = 'COD_OP_0001';
        
        ordine_rqst.ID_ORDINE = 'ORDINE_0001';
        ordine_rqst.AZIONE = 'AZIONE_ORD';
        ordine_rqst.TIPO_COLLEGAMENTO = 'E-Access';

        sede_rqst.ID_SEDE = 'id_sede';
        sede_rqst.NOME_SEDE = 'Nome_SedeTest';
        sede_rqst.INDIRIZZO = 'INDIRIZZO';
        sede_rqst.CIVICO = 'CIVICO';
        sede_rqst.COMUNE = 'COMUNE';
        sede_rqst.CODICE_ISTAT = 'CODICE_ISTAT';
        sede_rqst.POP_RACCOLTA = 'POP_RACCOLTA';
        
        sede_rqst.POP_CONSEGNA = 'POP_CONSEGNA';
        sede_rqst.NOME_KIT_CONSEGNA = 'NOME_KIT_CONSEGNA';
        
        sede_rqst.ID_COLLEGAMENTO = 'ID_COLLEGAMENTO';
        sede_rqst.TIPO_PERCORSO = 'TIPO_PERCORSO';
        
        System.debug(rqst);
        
        Test.startTest();
            OLO_ActivationP2PRequestCheck.checkActivationRequest(rqst);
            try {
                OLO_ActivationP2PRequestCheck.checkStringNotBlank('', 'NameTest');
            } catch (IllegalRequestException ex) {
                System.assertEquals('A_K9', ex.getCode());
                System.assertEquals('Campo NameTest obbligatorio non valorizzato (errore Tibco).', ex.getDescription());
            }
            try {
                OLO_ActivationP2PRequestCheck.checkStringFieldLength('valueTestLength', 'NameTest', 10);
            } catch (IllegalRequestException ex) {
                System.assertEquals('A_K10', ex.getCode());
            }
            try {
                OLO_ActivationP2PRequestCheck.checkObjectField(null, 'NameTest');
            } catch (IllegalRequestException ex) {
                System.assertEquals('A_K9', ex.getCode());
            }
            try {
                OLO_ActivationP2PRequestCheck.checkListField(null, 'NameTest');
            } catch (IllegalRequestException ex) {
                System.assertEquals('A_K9', ex.getCode());
            }
        Test.stopTest();
    }

}