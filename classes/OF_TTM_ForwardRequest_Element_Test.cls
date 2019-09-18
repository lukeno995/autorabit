@isTest

public class OF_TTM_ForwardRequest_Element_Test {

private static testMethod void test1() 
{      
        String ID_REQ_FORWARD2TTM;
        OF_TTM_ForwardRequest_Element.REQ_FORWARD2TTM_element REQ_FORWARD2TTM;
        String[] ID_REQ_FORWARD2TTM_type_info = new String[]{'ID_REQ_FORWARD2TTM','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] REQ_FORWARD2TTM_type_info = new String[]{'REQ_FORWARD2TTM','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'1','1','false'};
        String[] apex_schema_type_info = new String[]{'http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd','true','false'};
        String[] field_order_type_info = new String[]{'ID_REQ_FORWARD2TTM','REQ_FORWARD2TTM'};
        
        Test.setMock(WebServiceMock.class, new OF_TTM_ForwardRequest_Element_Mock());
        OF_TTM_ForwardRequest_Element.Forward2TTM_Req_element forward1 = new OF_TTM_ForwardRequest_Element.Forward2TTM_Req_element();

}

private static testMethod void test2() 
{      
        String id_notifica;
        String data_notifica;
        String esito;
        String codice_motivazione;
        String motivazione;
        String codice_comunicazione_olo;
        String[] id_notifica_type_info = new String[]{'id_notifica','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_notifica_type_info = new String[]{'data_notifica','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] esito_type_info = new String[]{'esito','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] codice_motivazione_type_info = new String[]{'codice_motivazione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] motivazione_type_info = new String[]{'motivazione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] codice_comunicazione_olo_type_info = new String[]{'codice_comunicazione_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] apex_schema_type_info = new String[]{'http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd','true','false'};
        String[] field_order_type_info = new String[]{'id_notifica','data_notifica','esito','codice_motivazione','motivazione','codice_comunicazione_olo'};
        
        Test.setMock(WebServiceMock.class, new OF_TTM_ForwardRequest_Element_Mock());
        OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element forward2 = new OF_TTM_ForwardRequest_Element.TroubleTicketFwdResp_element();
}

private static testMethod void test3() 
{
        String tipo_comunicazione;
        String codice_operatore;
        String codice_comunicazione_olo;
        String id_risorsa;
        String id_notifica;
        String categoria_guasto;
        String data_ora_autoripristinato;
        String nome_cliente;
        String cognome_cliente;
        String recapito_telefonico_cliente_1;
        String recapito_telefonico_cliente_2;
        String nome_referente_tecnico_olo;
        String telefono_referente_tecnico_olo;
        String email_referente_tecnico_olo;
        String note_cliente;
        String note;
        String orderid;
        String data_provisioning_servizio;
        String data_ora_inizio_guasto;
        String data_ora_inizio_sla;
        String verifica_apparato;
        String descrizione_problema;
        String causale_apertura;
        String intervento_congiunto;
        String tec_olo;
        String tel_tec_olo;
        String data_ora_intervento_congiunto;
        String service_type;
        String sla_type;
        String data_ora_notifica_olo;
        String data_ora_richiesta_annullamento;
        String causale_richiesta_annullamento;
        String data_ora_desospensione;
        String causale_desospensione;
        String[] tipo_comunicazione_type_info = new String[]{'tipo_comunicazione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'1','1','false'};
        String[] codice_operatore_type_info = new String[]{'codice_operatore','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] codice_comunicazione_olo_type_info = new String[]{'codice_comunicazione_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] id_risorsa_type_info = new String[]{'id_risorsa','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] id_notifica_type_info = new String[]{'id_notifica','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] categoria_guasto_type_info = new String[]{'categoria_guasto','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_autoripristinato_type_info = new String[]{'data_ora_autoripristinato','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] nome_cliente_type_info = new String[]{'nome_cliente','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] cognome_cliente_type_info = new String[]{'cognome_cliente','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] recapito_telefonico_cliente_1_type_info = new String[]{'recapito_telefonico_cliente_1','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] recapito_telefonico_cliente_2_type_info = new String[]{'recapito_telefonico_cliente_2','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] nome_referente_tecnico_olo_type_info = new String[]{'nome_referente_tecnico_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] telefono_referente_tecnico_olo_type_info = new String[]{'telefono_referente_tecnico_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] email_referente_tecnico_olo_type_info = new String[]{'email_referente_tecnico_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] note_cliente_type_info = new String[]{'note_cliente','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] note_type_info = new String[]{'note','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] orderid_type_info = new String[]{'orderid','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_provisioning_servizio_type_info = new String[]{'data_provisioning_servizio','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_inizio_guasto_type_info = new String[]{'data_ora_inizio_guasto','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_inizio_sla_type_info = new String[]{'data_ora_inizio_sla','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] verifica_apparato_type_info = new String[]{'verifica_apparato','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] descrizione_problema_type_info = new String[]{'descrizione_problema','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] causale_apertura_type_info = new String[]{'causale_apertura','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] intervento_congiunto_type_info = new String[]{'intervento_congiunto','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] tec_olo_type_info = new String[]{'tec_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] tel_tec_olo_type_info = new String[]{'tel_tec_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_intervento_congiunto_type_info = new String[]{'data_ora_intervento_congiunto','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] service_type_type_info = new String[]{'service_type','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] sla_type_type_info = new String[]{'sla_type','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_notifica_olo_type_info = new String[]{'data_ora_notifica_olo','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_richiesta_annullamento_type_info = new String[]{'data_ora_richiesta_annullamento','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] causale_richiesta_annullamento_type_info = new String[]{'causale_richiesta_annullamento','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_ora_desospensione_type_info = new String[]{'data_ora_desospensione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] causale_desospensione_type_info = new String[]{'causale_desospensione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] apex_schema_type_info = new String[]{'http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd','true','false'};
        String[] field_order_type_info = new String[]{'tipo_comunicazione','codice_operatore','codice_comunicazione_olo','id_risorsa','id_notifica','categoria_guasto','data_ora_autoripristinato','nome_cliente','cognome_cliente','recapito_telefonico_cliente_1','recapito_telefonico_cliente_2','nome_referente_tecnico_olo','telefono_referente_tecnico_olo','email_referente_tecnico_olo','note_cliente','note','orderid','data_provisioning_servizio','data_ora_inizio_guasto','data_ora_inizio_sla','verifica_apparato','descrizione_problema','causale_apertura','intervento_congiunto','tec_olo','tel_tec_olo','data_ora_intervento_congiunto','service_type','sla_type','data_ora_notifica_olo','data_ora_richiesta_annullamento','causale_richiesta_annullamento','data_ora_desospensione','causale_desospensione'};
    
        Test.setMock(WebServiceMock.class, new OF_TTM_ForwardRequest_Element_Mock());
        OF_TTM_ForwardRequest_Element.REQ_FORWARD2TTM_element forward3 = new OF_TTM_ForwardRequest_Element.REQ_FORWARD2TTM_element();
}

}