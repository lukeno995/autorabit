public class PO_PP_Dettaglio_VLAN_KIT_controller {
    
    /*
    public EOF_EAI_Service_Log__c sl_kit{get;set;}
    public boolean VLAN{get;set;} 
    public String IdVLAN{get;set;}
    */
    public String idLogVLAN{get;set;}
    public String idLogKit{get;set;}
    public EOF_EAI_Service_Log__c slv {get;set;}
        
    public boolean showDettaglioVLAN{get;set;}
    public boolean showDettaglioKIT{get;set;}
    public String tipo{get;set;}

    public PO_PP_Dettaglio_VLAN_KIT_controller()
    {
        showDettaglioVLAN = false;
        //showDettaglioKIT = false;
        
        //idLogKit = ApexPages.currentPage().getParameters().get('kit');
        idLogVLAN = ApexPages.currentPage().getParameters().get('vlan');
        tipo = ApexPages.currentPage().getParameters().get('tipo');

        system.debug('------------------------> ID Log KIT : '+idLogKit);
        system.debug('------------------------> ID Log VLAN : '+idLogVLAN);
        system.debug('------------------------> Tipo: '+tipo);
        
        /*
        if(tipo=='kit')
        {
            showDettaglioKIT = true;
            showDettaglioVLAN = false;
        }
        else 
        */
        if(tipo=='vlan')
        {
            showDettaglioVLAN = true;
            //showDettaglioKIT = false;
        }
             
        //system.debug('------------------------> showDettaglioKIT: '+showDettaglioKIT);
        system.debug('------------------------> showDettaglioVLAN: '+showDettaglioVLAN);
        /*
        If(idLogKit!=null)
        {
            sl_kit = [select id, recordtype.developername, OF_PP_NomeRichiesta__c, EOF_Codice_Operatore__c,PO_PP_Interfaccia__c,EOF_Comunicazioni_con_OLO__c,
                     Nome_del_KIT__c, POP__c, Banda_Interfaccia__c, Traffico__c, EOF_NOTE__c,EOF_Stato_Richiesta__c 
                     from EOF_EAI_Service_Log__c
                     where id =:idLogKit];     
        }
        else 
        */
        If(idLogVLAN!=null)
        {
            //Recupero il log di portale della VLAN 
            slv = [select id, name, OF_PP_KIT_Log__c, OF_PP_NomeRichiesta_Figlio__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c,
                     PO_PP_POP_raccolta__c, Banda_Interfaccia__c, PO_PP_cos_type__c, SVLAN__c, PO_PP_User_VLAN__c,
                     EOF_Note__c, CreatedDate, PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, 
                     PO_PP_dhcp_Option82__c, EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c
                     from EOF_EAI_Service_Log__c 
                     where id=:idLogVLAN
                     and RecordType.DeveloperName = 'PO_PP_VLAN'];
            
            System.debug('***sl_logVlan***:'+slv);
        }
    }
}