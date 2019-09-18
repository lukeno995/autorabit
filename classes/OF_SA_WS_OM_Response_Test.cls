@isTest
public class OF_SA_WS_OM_Response_Test {
    public static  testmethod void OF_SA_WS_OM_Response_Test1()
    {
        String ID_NOTIFICA; 
        String ESITO;
        String CODICE_MOTIVAZIONE;
        String MOTIVAZIONE;
        String[] ID_NOTIFICA_type_info = new String[]{'ID_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/Esito',null,'1','1','false'};
        String[] ESITO_type_info = new String[]{'ESITO','http://enel.it/schemas/class/ServiziAttivi/Esito',null,'1','1','false'};
        String[] CODICE_MOTIVAZIONE_type_info = new String[]{'CODICE_MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/Esito',null,'0','1','false'};
        String[] MOTIVAZIONE_type_info = new String[]{'MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/Esito',null,'0','1','false'};
        String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/Esito','true','false'};
        String[] field_order_type_info = new String[]{'ID_NOTIFICA','ESITO','CODICE_MOTIVAZIONE','MOTIVAZIONE'};
        
        OF_SA_WS_OM_Response.Esito_element wrap = new  OF_SA_WS_OM_Response.Esito_element();
    }
}