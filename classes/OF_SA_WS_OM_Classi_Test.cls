@isTest
public class OF_SA_WS_OM_Classi_Test {
  public static testmethod void AggiornamentoStato_elementTest()
  {
      String[] CODICE_OPERATORE_type_info = new String[]{'CODICE_OPERATORE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'1','1','false'};
         String[] CODICE_ORDINE_OLO_type_info = new String[]{'CODICE_ORDINE_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'1','1','false'};
         String[] DATA_NOTIFICA_type_info = new String[]{'DATA_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'1','1','false'};
         String[] ID_NOTIFICA_type_info = new String[]{'ID_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'1','1','false'};
         String[] AZIONE_type_info = new String[]{'AZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'1','1','false'};
         String[] CODICE_MOTIVAZIONE_type_info = new String[]{'CODICE_MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] MOTIVAZIONE_type_info = new String[]{'MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] DATA_PREVISTA_ATTIVAZIONE_type_info = new String[]{'DATA_PREVISTA_ATTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] ORARIO_APPUNTAMENTO_type_info = new String[]{'ORARIO_APPUNTAMENTO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] NOME_CLIENTE_type_info = new String[]{'NOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] COGNOME_CLIENTE_type_info = new String[]{'COGNOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_1_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_1','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_2_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_2','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] NOTE_type_info = new String[]{'NOTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] TIPO_COMUNICAZIONE_type_info = new String[]{'TIPO_COMUNICAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] SORGENTE_type_info = new String[]{'SORGENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] CODICE_ORDINE_OF_type_info = new String[]{'CODICE_ORDINE_OF','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] SLA_DATE_type_info = new String[]{'SLA_DATE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] GPON_ATTESTAZIONE_type_info = new String[]{'GPON_ATTESTAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] GPON_VINCOLANTE_type_info = new String[]{'GPON_VINCOLANTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] ID_RISORSA_type_info = new String[]{'ID_RISORSA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] OPZIONE_SYSTEM_UNICO_type_info = new String[]{'OPZIONE_SYSTEM_UNICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] COLLEGAMENTO_P2P_type_info = new String[]{'COLLEGAMENTO_P2P','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] TRACCIATO_type_info = new String[]{'TRACCIATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] ID_SERVIZIO_type_info = new String[]{'ID_SERVIZIO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] PROFILO_type_info = new String[]{'PROFILO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] PROVINCIA_type_info = new String[]{'PROVINCIA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] COMUNE_type_info = new String[]{'COMUNE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] INDIRIZZO_type_info = new String[]{'INDIRIZZO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] NUMERO_CIVICO_type_info = new String[]{'NUMERO_CIVICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato',null,'0','1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AggiornamentoStato','true','false'};
         String[] field_order_type_info = new String[]{'CODICE_OPERATORE','CODICE_ORDINE_OLO','DATA_NOTIFICA','ID_NOTIFICA','AZIONE','CODICE_MOTIVAZIONE','MOTIVAZIONE','DATA_PREVISTA_ATTIVAZIONE','ORARIO_APPUNTAMENTO','NOME_CLIENTE','COGNOME_CLIENTE','RECAPITO_TELEFONICO_CLIENTE_1','RECAPITO_TELEFONICO_CLIENTE_2','NOTE','TIPO_COMUNICAZIONE','SORGENTE','CODICE_ORDINE_OF','SLA_DATE','GPON_ATTESTAZIONE','GPON_VINCOLANTE','ID_RISORSA','OPZIONE_SYSTEM_UNICO','COLLEGAMENTO_P2P','TRACCIATO','ID_SERVIZIO','PROFILO','PROVINCIA','COMUNE','INDIRIZZO','NUMERO_CIVICO'};
        OF_SA_WS_OM_Classi.AggiornamentoStato_element firstMethod = new OF_SA_WS_OM_Classi.AggiornamentoStato_element();
  }
    public static testmethod void AggiornamentoStato_elementTest2()
    {
         String[] CODICE_OPERATORE_type_info = new String[]{'CODICE_OPERATORE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] CODICE_ORDINE_OLO_type_info = new String[]{'CODICE_ORDINE_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] DATA_NOTIFICA_type_info = new String[]{'DATA_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] ID_NOTIFICA_type_info = new String[]{'ID_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] NOME_CLIENTE_type_info = new String[]{'NOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] COGNOME_CLIENTE_type_info = new String[]{'COGNOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_1_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_1','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_2_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_2','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] DATA_PREVISTA_ATTIVAZIONE_type_info = new String[]{'DATA_PREVISTA_ATTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] ORARIO_APPUNTAMENTO_type_info = new String[]{'ORARIO_APPUNTAMENTO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] NOTE_type_info = new String[]{'NOTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] CODICE_MOTIVAZIONE_type_info = new String[]{'CODICE_MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] MOTIVAZIONE_type_info = new String[]{'MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'1','1','false'};
         String[] TIPO_COMUNICAZIONE_type_info = new String[]{'TIPO_COMUNICAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] SORGENTE_type_info = new String[]{'SORGENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] CODICE_ORDINE_OF_type_info = new String[]{'CODICE_ORDINE_OF','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] SLA_DATE_type_info = new String[]{'SLA_DATE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] GPON_ATTESTAZIONE_type_info = new String[]{'GPON_ATTESTAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] GPON_VINCOLANTE_type_info = new String[]{'GPON_VINCOLANTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] ID_RISORSA_type_info = new String[]{'ID_RISORSA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] OPZIONE_SYSTEM_UNICO_type_info = new String[]{'OPZIONE_SYSTEM_UNICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] COLLEGAMENTO_P2P_type_info = new String[]{'COLLEGAMENTO_P2P','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] TRACCIATO_type_info = new String[]{'TRACCIATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] ID_SERVIZIO_type_info = new String[]{'ID_SERVIZIO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] PROFILO_type_info = new String[]{'PROFILO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] PROVINCIA_type_info = new String[]{'PROVINCIA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] COMUNE_type_info = new String[]{'COMUNE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] INDIRIZZO_type_info = new String[]{'INDIRIZZO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] NUMERO_CIVICO_type_info = new String[]{'NUMERO_CIVICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione',null,'0','1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/Rischedulazione','true','false'};
         String[] field_order_type_info = new String[]{'CODICE_OPERATORE','CODICE_ORDINE_OLO','DATA_NOTIFICA','ID_NOTIFICA','NOME_CLIENTE','COGNOME_CLIENTE','RECAPITO_TELEFONICO_CLIENTE_1','RECAPITO_TELEFONICO_CLIENTE_2','DATA_PREVISTA_ATTIVAZIONE','ORARIO_APPUNTAMENTO','NOTE','CODICE_MOTIVAZIONE','MOTIVAZIONE','TIPO_COMUNICAZIONE','SORGENTE','CODICE_ORDINE_OF','SLA_DATE','GPON_ATTESTAZIONE','GPON_VINCOLANTE','ID_RISORSA','OPZIONE_SYSTEM_UNICO','COLLEGAMENTO_P2P','TRACCIATO','ID_SERVIZIO','PROFILO','PROVINCIA','COMUNE','INDIRIZZO','NUMERO_CIVICO'};
         OF_SA_WS_OM_Classi.Rischedulazione_element secondMethod = new OF_SA_WS_OM_Classi.Rischedulazione_element();
    }
    public static testmethod void AggiornamentoStato_elementTest3()
    {
                OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element[] APPARATO;
         String[] CODICE_OPERATORE_type_info = new String[]{'CODICE_OPERATORE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'1','1','false'};
         String[] CODICE_ORDINE_OLO_type_info = new String[]{'CODICE_ORDINE_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'1','1','false'};
         String[] DATA_NOTIFICA_type_info = new String[]{'DATA_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'1','1','false'};
         String[] ID_NOTIFICA_type_info = new String[]{'ID_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'1','1','false'};
         String[] ID_RISORSA_type_info = new String[]{'ID_RISORSA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'1','1','false'};
         String[] NOME_CLIENTE_type_info = new String[]{'NOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] COGNOME_CLIENTE_type_info = new String[]{'COGNOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_1_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_1','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_2_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_2','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] NOTE_type_info = new String[]{'NOTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] TIPO_COMUNICAZIONE_type_info = new String[]{'TIPO_COMUNICAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] SORGENTE_type_info = new String[]{'SORGENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] CODICE_ORDINE_OF_type_info = new String[]{'CODICE_ORDINE_OF','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] SLA_DATE_type_info = new String[]{'SLA_DATE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] GPON_ATTESTAZIONE_type_info = new String[]{'GPON_ATTESTAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] GPON_VINCOLANTE_type_info = new String[]{'GPON_VINCOLANTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] OPZIONE_SYSTEM_UNICO_type_info = new String[]{'OPZIONE_SYSTEM_UNICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] CODICE_MOTIVAZIONE_type_info = new String[]{'CODICE_MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] MOTIVAZIONE_type_info = new String[]{'MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] COLLEGAMENTO_P2P_type_info = new String[]{'COLLEGAMENTO_P2P','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] TRACCIATO_type_info = new String[]{'TRACCIATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] ID_SERVIZIO_type_info = new String[]{'ID_SERVIZIO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] PROFILO_type_info = new String[]{'PROFILO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] PROVINCIA_type_info = new String[]{'PROVINCIA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] COMUNE_type_info = new String[]{'COMUNE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] INDIRIZZO_type_info = new String[]{'INDIRIZZO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] NUMERO_CIVICO_type_info = new String[]{'NUMERO_CIVICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] APPARATO_type_info = new String[]{'APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','-1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine','true','false'};
         String[] field_order_type_info = new String[]{'CODICE_OPERATORE','CODICE_ORDINE_OLO','DATA_NOTIFICA','ID_NOTIFICA','ID_RISORSA','NOME_CLIENTE','COGNOME_CLIENTE','RECAPITO_TELEFONICO_CLIENTE_1','RECAPITO_TELEFONICO_CLIENTE_2','NOTE','TIPO_COMUNICAZIONE','SORGENTE','CODICE_ORDINE_OF','SLA_DATE','GPON_ATTESTAZIONE','GPON_VINCOLANTE','OPZIONE_SYSTEM_UNICO','CODICE_MOTIVAZIONE','MOTIVAZIONE','COLLEGAMENTO_P2P','TRACCIATO','ID_SERVIZIO','PROFILO','PROVINCIA','COMUNE','INDIRIZZO','NUMERO_CIVICO','APPARATO'};
          OF_SA_WS_OM_Classi.Disattivazione_element ThirdMethod = new OF_SA_WS_OM_Classi.Disattivazione_element();
    }
      public static testmethod void AggiornamentoStato_elementTest4()
      {
            String[] TIPOLOGIA_APPARATO_type_info = new String[]{'TIPOLOGIA_APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] ID_APPARATO_type_info = new String[]{'ID_APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine',null,'0','1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/DisattivazioneOrdine','true','false'};
         String[] field_order_type_info = new String[]{'TIPOLOGIA_APPARATO','ID_APPARATO'};
             OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element FourthMethod = new OF_SA_WS_OM_Classi.DISATTIVAZIONE_APPARATO_element();
   
      }
    public static testmethod void AggiornamentoStato_elementTest5()
    {
         String[] KIT_CONSEGNA_VLAN_type_info = new String[]{'KIT_CONSEGNA_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] USER_VLAN_type_info = new String[]{'USER_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] SERVICE_VLAN_type_info = new String[]{'SERVICE_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] PROFILO_VLAN_type_info = new String[]{'PROFILO_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] INFORMAZIONI_VLAN_type_info = new String[]{'INFORMAZIONI_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] CUSTOMER_VLAN_type_info = new String[]{'CUSTOMER_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] MODELLO_DI_SERVIZIO_VLAN_type_info = new String[]{'MODELLO_DI_SERVIZIO_VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon','true','false'};
         String[] field_order_type_info = new String[]{'KIT_CONSEGNA_VLAN','USER_VLAN','SERVICE_VLAN','PROFILO_VLAN','INFORMAZIONI_VLAN','CUSTOMER_VLAN','MODELLO_DI_SERVIZIO_VLAN'};
   
         OF_SA_WS_OM_Classi.VLAN_element FifthMethod = new OF_SA_WS_OM_Classi.VLAN_element();
   
    }
    public static testmethod void AggiornamentoStato_elementTest6()
    {
          String[] TIPOLOGIA_APPARATO_type_info = new String[]{'TIPOLOGIA_APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] PASSWORD_APPARATO_type_info = new String[]{'PASSWORD_APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] AZIONE_APPARATO_type_info = new String[]{'AZIONE_APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] ID_APPARATO_type_info = new String[]{'ID_APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon','true','false'};
         String[] field_order_type_info = new String[]{'TIPOLOGIA_APPARATO','PASSWORD_APPARATO','AZIONE_APPARATO','ID_APPARATO'};
              OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element sixsthMethod = new OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element();
    }
     public static testmethod void AggiornamentoStato_elementTest7()
     {
           String[] NOME_SERVIZIO_type_info = new String[]{'NOME_SERVIZIO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] INFORMAZIONI_SERVIZIO_type_info = new String[]{'INFORMAZIONI_SERVIZIO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon','true','false'};
         String[] field_order_type_info = new String[]{'NOME_SERVIZIO','INFORMAZIONI_SERVIZIO'};
   
         OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element sevenththMethod = new OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element();

     }
    public static testmethod void AggiornamentoStato_elementTest8()
    {
         OF_SA_WS_OM_Classi.SERVIZIO_AGGIUNTIVO_element[] SERVIZIO_AGGIUNTIVO;
         OF_SA_WS_OM_Classi.ATTIVAZIONE_APPARATO_element[] APPARATO;
         OF_SA_WS_OM_Classi.VLAN_element[] VLAN;
         String[] CODICE_OPERATORE_type_info = new String[]{'CODICE_OPERATORE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] CODICE_ORDINE_OLO_type_info = new String[]{'CODICE_ORDINE_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] DATA_NOTIFICA_type_info = new String[]{'DATA_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] ID_NOTIFICA_type_info = new String[]{'ID_NOTIFICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] NOME_REFERENTE_TECNICO_OLO_type_info = new String[]{'NOME_REFERENTE_TECNICO_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] COGNOME_REFERENTE_TECNICO_OLO_type_info = new String[]{'COGNOME_REFERENTE_TECNICO_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] TELEFONO_REFERENTE_TECNICO_OLO_type_info = new String[]{'TELEFONO_REFERENTE_TECNICO_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] EMAIL_REFERENTE_TECNICO_OLO_type_info = new String[]{'EMAIL_REFERENTE_TECNICO_OLO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH_type_info = new String[]{'TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] NOME_CLIENTE_type_info = new String[]{'NOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] COGNOME_CLIENTE_type_info = new String[]{'COGNOME_CLIENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_1_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_1','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] RECAPITO_TELEFONICO_CLIENTE_2_type_info = new String[]{'RECAPITO_TELEFONICO_CLIENTE_2','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] INFORMAZIONI_LOGISTICA_APPARATI_type_info = new String[]{'INFORMAZIONI_LOGISTICA_APPARATI','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] DATA_PREVISTA_ATTIVAZIONE_type_info = new String[]{'DATA_PREVISTA_ATTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] ORARIO_APPUNTAMENTO_type_info = new String[]{'ORARIO_APPUNTAMENTO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] CODICE_PROGETTO_SPECIALE_type_info = new String[]{'CODICE_PROGETTO_SPECIALE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] PROMOZIONE_type_info = new String[]{'PROMOZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] CLUSTER_PROMOZIONE_type_info = new String[]{'CLUSTER_PROMOZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] NOTE_type_info = new String[]{'NOTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] ID_BUILDING_type_info = new String[]{'ID_BUILDING','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] SCALA_PALAZZINA_type_info = new String[]{'SCALA_PALAZZINA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] NUMERO_TELEFONICO_PRINCIPALE_LINEA_type_info = new String[]{'NUMERO_TELEFONICO_PRINCIPALE_LINEA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] RECAPITO_TEST_LINEA_type_info = new String[]{'RECAPITO_TEST_LINEA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] IDENTIFICATIVO_DEL_POP_type_info = new String[]{'IDENTIFICATIVO_DEL_POP','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'1','1','false'};
         String[] TIPO_COMUNICAZIONE_type_info = new String[]{'TIPO_COMUNICAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] SORGENTE_type_info = new String[]{'SORGENTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] CODICE_ORDINE_OF_type_info = new String[]{'CODICE_ORDINE_OF','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] SLA_DATE_type_info = new String[]{'SLA_DATE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] GPON_ATTESTAZIONE_type_info = new String[]{'GPON_ATTESTAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] GPON_VINCOLANTE_type_info = new String[]{'GPON_VINCOLANTE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] ID_RISORSA_type_info = new String[]{'ID_RISORSA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] OPZIONE_SYSTEM_UNICO_type_info = new String[]{'OPZIONE_SYSTEM_UNICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] CODICE_MOTIVAZIONE_type_info = new String[]{'CODICE_MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] MOTIVAZIONE_type_info = new String[]{'MOTIVAZIONE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] COLLEGAMENTO_P2P_type_info = new String[]{'COLLEGAMENTO_P2P','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] TRACCIATO_type_info = new String[]{'TRACCIATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] ID_SERVIZIO_type_info = new String[]{'ID_SERVIZIO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] PROFILO_type_info = new String[]{'PROFILO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] PROVINCIA_type_info = new String[]{'PROVINCIA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] COMUNE_type_info = new String[]{'COMUNE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] INDIRIZZO_type_info = new String[]{'INDIRIZZO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] NUMERO_CIVICO_type_info = new String[]{'NUMERO_CIVICO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] PARTICELLA_TOPONOMASTICA_type_info = new String[]{'PARTICELLA_TOPONOMASTICA','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] SLA_PREMIUM_ASSURANCE_type_info = new String[]{'SLA_PREMIUM_ASSURANCE','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','1','false'};
         String[] SERVIZIO_AGGIUNTIVO_type_info = new String[]{'SERVIZIO_AGGIUNTIVO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','-1','false'};
         String[] APPARATO_type_info = new String[]{'APPARATO','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','-1','false'};
         String[] VLAN_type_info = new String[]{'VLAN','http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon',null,'0','-1','false'};
         String[] apex_schema_type_info = new String[]{'http://enel.it/schemas/class/ServiziAttivi/OrderManagement/AttivazioneGpon','true','false'};
         String[] field_order_type_info = new String[]{'CODICE_OPERATORE','CODICE_ORDINE_OLO','DATA_NOTIFICA','ID_NOTIFICA','NOME_REFERENTE_TECNICO_OLO','COGNOME_REFERENTE_TECNICO_OLO','TELEFONO_REFERENTE_TECNICO_OLO','EMAIL_REFERENTE_TECNICO_OLO','TELEFONO_REFERENTE_OLO_ONFIELD_NOTECH','NOME_CLIENTE','COGNOME_CLIENTE','RECAPITO_TELEFONICO_CLIENTE_1','RECAPITO_TELEFONICO_CLIENTE_2','INFORMAZIONI_LOGISTICA_APPARATI','DATA_PREVISTA_ATTIVAZIONE','ORARIO_APPUNTAMENTO','CODICE_PROGETTO_SPECIALE','PROMOZIONE','CLUSTER_PROMOZIONE','NOTE','ID_BUILDING','SCALA_PALAZZINA','NUMERO_TELEFONICO_PRINCIPALE_LINEA','RECAPITO_TEST_LINEA','IDENTIFICATIVO_DEL_POP','TIPO_COMUNICAZIONE','SORGENTE','CODICE_ORDINE_OF','SLA_DATE','GPON_ATTESTAZIONE','GPON_VINCOLANTE','ID_RISORSA','OPZIONE_SYSTEM_UNICO','CODICE_MOTIVAZIONE','MOTIVAZIONE','COLLEGAMENTO_P2P','TRACCIATO','ID_SERVIZIO','PROFILO','PROVINCIA','COMUNE','INDIRIZZO','NUMERO_CIVICO','PARTICELLA_TOPONOMASTICA','SLA_PREMIUM_ASSURANCE','SERVIZIO_AGGIUNTIVO','APPARATO','VLAN'};
   
        OF_SA_WS_OM_Classi.AttivazioneGpona_element eighthMethod = new OF_SA_WS_OM_Classi.AttivazioneGpona_element();

    }
    
}