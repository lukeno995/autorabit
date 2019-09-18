@isTest
public class ForwardRequestTTM_Sincronizzazion_Test {

private static testMethod void test1() 
{
        String ID_REQ_FORWARD2TTM;
        String REQ_FORWARD2TTM;
        String TIPO_COMUNICAZIONE_FORWARD2TTM;
        String[] ID_REQ_FORWARD2TTM_type_info = new String[]{'ID_REQ_FORWARD2TTM','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'1','1','false'};
        String[] REQ_FORWARD2TTM_type_info = new String[]{'REQ_FORWARD2TTM','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'1','1','false'};
        String[] TIPO_COMUNICAZIONE_FORWARD2TTM_type_info = new String[]{'TIPO_COMUNICAZIONE_FORWARD2TTM','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'1','1','false'};
        String[] apex_schema_type_info = new String[]{'http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd','true','false'};
        String[] field_order_type_info = new String[]{'ID_REQ_FORWARD2TTM','REQ_FORWARD2TTM','TIPO_COMUNICAZIONE_FORWARD2TTM'};
        
        ForwardRequestTTM_Sincronizzazion.Forward2TTM_Req_element forward1 = new ForwardRequestTTM_Sincronizzazion.Forward2TTM_Req_element(); 
}

private static testMethod void test2()  
{
 
        String id_notifica;
        String data_notifica;
        String esito;
        String codice_motivazione;
        String motivazione;
        String id_tt;
        String[] id_notifica_type_info = new String[]{'id_notifica','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] data_notifica_type_info = new String[]{'data_notifica','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] esito_type_info = new String[]{'esito','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] codice_motivazione_type_info = new String[]{'codice_motivazione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] motivazione_type_info = new String[]{'motivazione','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] id_tt_type_info = new String[]{'id_tt','http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd',null,'0','1','false'};
        String[] apex_schema_type_info = new String[]{'http://xmlns.enel.it/OLO_Gateway/Sicronizzazione/Notifica.xsd','true','false'};
        String[] field_order_type_info = new String[]{'id_notifica','data_notifica','esito','codice_motivazione','motivazione','id_tt'};   
        
         ForwardRequestTTM_Sincronizzazion.TroubleTicketFwdResp_element forward2 = new  ForwardRequestTTM_Sincronizzazion.TroubleTicketFwdResp_element();
    
}

}