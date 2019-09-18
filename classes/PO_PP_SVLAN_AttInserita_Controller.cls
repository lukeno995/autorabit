public class PO_PP_SVLAN_AttInserita_Controller {

    public EOF_EAI_Service_Log__c sl{get;set;}
    public EOF_EAI_Service_Log__c sl_kit{get;set;}
    public EOF_EAI_Service_Log__c sl_edit{get;set;}
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public List<EOF_EAI_Service_Log__c> SlVLAN{get;set;}
    public boolean VLAN{get;set;} 
    public boolean confirmPage{get;set;} 
    public String IdVLAN{get;set;}
    public boolean success{get;set;}
    public boolean error{get;set;}
    public boolean modifica_VLAN{get;set;}
    public String motivoErr{get;set;}
    public List<EOF_EAI_Service_Log__c> slList{get;set;}
    public List<EOF_EAI_Service_Log__c> slListVlan{get;set;}
    public String IdLog{get;set;}
    public String idLogVLAN{get;set;}
    public String id_kit{get;set;}
    public Id id_log_richiestaVLAN {get;set;}
    public String proc{get;set;}
    public String kitName {get;set;}
    public OF_CommercialElementIstanziato__c kitSelezionato {get;set;}
    public String codOp {get;set;}
    public String show_buttons {get;set;}
    public boolean no_renderedButtons {get;set;}
    public String id_asset {get;set;}
    public EOF_EAI_Service_Log__c richiestaVLAN{get;set;}
    public boolean showFieldsPostInsert{get;set;}
    public EOF_EAI_Service_Log__c sl_update{get;set;}
    
    public String sceltaMono {get;set;}
    public String vLanPadre {get;set;}
    public String sceltaMulti {get;set;}
    public String[] arr_cos {get;set;}
    public EOF_EAI_Service_Log__c sl_cos{get;set;}
    public EOF_EAI_Service_Log__c sl_Mcos{get;set;}
    public List<EOF_EAI_Service_Log__c> list_sl_Mcos{get;set;}
    public String cos_type {get;set;}

    public PO_PP_SVLAN_AttInserita_Controller()
    {
        VLAN=false;
        modifica_VLAN = false;
        confirmPage = false;
        no_renderedButtons = true;
        showFieldsPostInsert = false;
        sl=slOrig;
        
        sceltaMono = '';
        sceltaMulti = '';

        //id_kit = ApexPages.currentPage().getParameters().get('id_kit');
        //IdLog = ApexPages.currentPage().getParameters().get('origId');
        kitName = ApexPages.currentPage().getParameters().get('nameKit');
        idLogVLAN = ApexPages.currentPage().getParameters().get('IdVLAN');
        proc = ApexPages.currentPage().getParameters().get('proc');
        id_log_richiestaVLAN = ApexPages.currentPage().getParameters().get('id_richVLAN');
        show_buttons = ApexPages.currentPage().getParameters().get('show_buttons');

        if(show_buttons=='false')
        {
            no_renderedButtons = false;
            showFieldsPostInsert = true;
        }
        
        //system.debug('------------------------> ID Service LOG : ' +IdLog);
        //system.debug('------------------------> ID Kit : ' +id_kit);
        system.debug('------------------------> Nome KIT : ' +kitName);
        system.debug('------------------------> ID Log VLAN : ' +idLogVLAN);
        system.debug('------------------------> ID Log Richiesta VLAN : '+id_log_richiestaVLAN);
        system.debug('------------------------> Proc : ' +proc);
        system.debug('------------------------> Prima della query');
        
        codOp = [SELECT Contact.account.name 
                FROM User 
                WHERE id = :userinfo.getuserid() 
                LIMIT 1].Contact.account.name;
                
        system.debug('***Cod Op: ****'+codOp);
        
        //Recupero i dati del KIT ricercato casella di ricerca
        if(kitName!=null)
        {
            /*
            sl_kit = [select id, recordtype.developername, EOF_Codice_Operatore__c,
                     Nome_del_KIT__c, POP__c, Banda_Interfaccia__c, Traffico__c, EOF_NOTE__c
                     from EOF_EAI_Service_Log__c
                     where id =:id_kit];     
            */
            
            system.debug('@@@Cod Op: @@@'+codOp);
            
            kitSelezionato = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Pop__c, PO_PP_Banda_Interfaccia__c, PO_PP_InterfacciaKit__c, 
                              PO_PP_Servizio_Commerciale__c, OF_Stato__c, RecordType.name, of_asset__c, of_asset__r.name, OF_Asset__r.account.name, 
                              OF_Case__c, OF_Asset__r.EOF_ID_Risorsa__c, OF_DataAttivazione__c, PO_PP_Note__c 
                              from OF_CommercialElementIstanziato__c
                              where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                              and OF_Asset__r.account.name =:codOp
                              and OF_Asset__r.status='Attivo'
                              and PO_PP_Nome_KIT__c=:kitName
                              limit 1
                            ];
            
            id_asset = kitSelezionato.of_asset__c;
        }
        
        if(kitSelezionato!=null)
        {
            //Recupero la richiesta VLAN
            richiestaVLAN =  [select id, name, EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c, OF_PP_KIT_Log__c, 
            						EOF_Codice_Operatore__c,OF_PP_KIT_Log__r.Nome_del_KIT__c, 
            						EOF_Tipo_Comunicazione_String__c, CreatedDate ,	
            						OF_PP_NomeRichiesta__c ,OF_PP_NomeRichiesta_Figlio__c,Nome_del_KIT__c
                              from EOF_EAI_Service_Log__c 
                              where id=:id_log_richiestaVLAN
                             ];
            if(string.isBlank(richiestaVLAN.Nome_del_KIT__c)){
            richiestaVLAN.Nome_del_KIT__c =kitName;
           // update richiestaVLAN;
            }
            
            System.debug('****ID richiestaVLAN****:'+richiestaVLAN.id);
            
            //Recupero tutti i log delle VLAN partendo dalla richiesta VLAN
            slList = [select id, name, OF_PP_KIT_Log__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c,
                     PO_PP_POP_raccolta__c, Banda_Interfaccia__c, PO_PP_cos_type__c, SVLAN__c, EOF_Note__c, CreatedDate, 
                     PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, 
                     EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c,OF_PP_NomeRichiesta__c,OF_PP_NomeRichiesta_Figlio__c,PO_PP_User_VLAN__c
                     from EOF_EAI_Service_Log__c 
                     where PO_PP_ID_RichiestaVLAN__c=:id_log_richiestaVLAN
                     and RecordType.DeveloperName = 'PO_PP_VLAN'];
        
            System.debug('***slList.size***:'+slList.size());
            
            if(ApexPages.currentPage().getParameters().get('proc') =='attivazioneInserita'){
                system.debug('------------------------>confirmPage=true');
                confirmPage=true;
            }
            if(ApexPages.currentPage().getParameters().get('proc') =='successInsertATT'){
                success=true;
                confirmPage=true;
            }
            if(ApexPages.currentPage().getParameters().get('proc') =='errorInsertATT'){
                error=true;
                motivoErr=ApexPages.currentPage().getParameters().get('motivo');
                confirmPage=true;
            }
            if(ApexPages.currentPage().getParameters().get('proc') =='editVLAN')
            {
                System.debug('***Sono in MODIFICA VLAN***');
                modifica_VLAN=true;
                
                sl_edit = [select id, name, OF_PP_KIT_Log__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c, 
                          POP__c, Banda_Interfaccia__c, PO_PP_cos_type__c, SVLAN__c, EOF_Note__c, PO_PP_POP_raccolta__c,CreatedDate, 
                          PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, 
                          EOF_STATO_Ordine__c, EOF_Stato_Richiesta__c
                          from EOF_EAI_Service_Log__c 
                          where id=:idLogVLAN];
                
                System.debug('****idLogVLAN MOD****: '+idLogVLAN);
                sl = sl_edit;
            }
        }
    }
    
    public List<SelectOption> getItemsMonoCos() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0','0'));
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('5','5'));
        return options;
    }
    
    public List<SelectOption> getItemsMultiCos() 
    {
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('0 - 1','0 - 1'));
        options.add(new SelectOption('0 - 5','0 - 5'));
        //options.add(new SelectOption('1 - 5','1 - 5'));
        options.add(new SelectOption('0 - 1 - 5','0 - 1 - 5'));
        return options;
    }
    
    public PageReference aggiungiVLAN(){
        
        PageReference pageRef = new PageReference('/PO_PP_InserimentoSVLAN');
        pageRef.getParameters().put('richVLan','NO');
        pageRef.getParameters().put('proc','insVLAN');
        pageRef.getParameters().put('richVLan','NO');
        pageRef.getParameters().put('orig','ATT');
        //pageRef.getParameters().put('id_kit',id_kit);
        pageRef.getParameters().put('nameKit',kitName);
        pageRef.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
        return pageref;
    }

    public pagereference editVLAN()
    { 
        //id_kit = ApexPages.currentPage().getParameters().get('id_kit');
        
        PageReference pg = new PageReference('/PO_PP_RiepilogoSVLAN');
        pg.getParameters().put('proc','editVLAN');
        pg.getParameters().put('IdVLAN',IdVLAN);
        pg.getParameters().put('richVLan','NO');
        //pg.getParameters().put('id_kit',id_kit);
        pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
        pg.getParameters().put('nameKit',kitName);
        pg.getParameters().put('show_buttons','false');
        return pg;
    }
    
    public pagereference deleteVLAN()
    {
        System.debug('@@@Entro nel metodo DELETE VLAN');
        
        EOF_EAI_Service_Log__c VLANToDelete = new EOF_EAI_Service_Log__c();
        VLANToDelete.Id = IdVLAN;
        System.debug('@@@@Prima della DeleteVLAN****slList.size***: '+slList.size());
        delete VLANToDelete; 
        
        slListVlan = [select id
                     from EOF_EAI_Service_Log__c 
                     where PO_PP_ID_RichiestaVLAN__c=:id_log_richiestaVLAN
                     and RecordType.DeveloperName = 'PO_PP_VLAN'];
                     
        System.debug('@@@@Dopo la DeleteVLAN****slListVlan.size***: '+slListVlan.size());
        
        if(slListVlan.size()==0)
        {
            EOF_EAI_Service_Log__c slog_richiestaVLAN = new EOF_EAI_Service_Log__c();
            slog_richiestaVLAN.id = id_log_richiestaVLAN;
            delete slog_richiestaVLAN;
            PageReference pageRef = new PageReference('/PO_PP_InserimentoKit');
            return pageRef;
        }
        //id_kit = ApexPages.currentPage().getParameters().get('id_kit');
        PageReference pg = new PageReference('/PO_PP_RiepilogoSVLAN');
        //pg.getParameters().put('orig','ATT');
        pg.getParameters().put('nameKit',kitName);
        //pg.getParameters().put('id_kit',id_kit);
        pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
        return pg;
    }
    
    public pageReference aggiorna(){
        
        /*
        if(sl.PO_PP_cos_type__c.equalsIgnoreCase('MonoCOS'))
        {
            sl.PO_PP_cos_class__c = sceltaMono;
        }
        else if(sl.PO_PP_cos_type__c.equalsIgnoreCase('MultiCOS'))
        {
            sl.PO_PP_MultiCos_Class__c = sceltaMulti;    
        }
        */
        
        System.debug('***Class post modifica***:'+sl.PO_PP_cos_class__c);
        /*
        if(sl.PO_PP_cos_remarking__c.equalsIgnoreCase('None')){
            sl.PO_PP_cos_remarking__c = '';
        }
        if(sl.PO_PP_dhcp_Option82__c.equalsIgnoreCase('None')){
            sl.PO_PP_dhcp_Option82__c = '';
        }
        */
        System.debug('***Type post modifica***:'+sl.PO_PP_cos_type__c);
        
        /*
        if(sl.PO_PP_cos_type__c.equalsIgnoreCase('MonoCOS'))
            showMonoCos = true;
        else
            showMultiCos = true;
        */
            
        update sl; //aggiorno il log post modifiche

        PageReference pg = new PageReference('/PO_PP_RiepilogoSVLAN');
        pg.getParameters().put('origId',sl.Id);
        //pg.getParameters().put('id_kit',id_kit);
        pg.getParameters().put('nameKit',kitName);
        pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
        modifica_VLAN=false;
        return pg;
    }
    
    public pageReference annullaModifiche(){

        PageReference pg = new PageReference('/PO_PP_RiepilogoSVLAN');
        pg.getParameters().put('origId',sl.Id);
        //pg.getParameters().put('id_kit',id_kit);
        pg.getParameters().put('nameKit',kitName);
        pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
        modifica_VLAN=false;
        return pg;
    }

    public pageReference inoltraRequest()
    {
        List<EOF_EAI_Service_Log__C> slToUpdate = new List<EOF_EAI_Service_Log__C>();
       
        if(slList.size()>0)
        {
            Integer increment = 0;
            
            for(EOF_EAI_Service_Log__c slv : slList)
            {   
                System.debug('++++++slv++++++: '+slv);
                
                //Inserito check per le bozze
                if(slv.EOF_Stato_Richiesta__c.equalsIgnoreCase('Bozza Portale') )
                {
                    OF_PP_WS_IN_OLO_Activation.VLAN_PP vlan = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();
                    List<OF_PP_WS_IN_OLO_Activation.COS> cos_list = new List<OF_PP_WS_IN_OLO_Activation.COS>();
                    increment++;
                    vlan.PROGRESSIVO_ORDINE = increment;
                    System.debug('^^^^vlan.PROGRESSIVO_ORDINE^^^^:'+vlan.PROGRESSIVO_ORDINE);
                    slv.PO_PP_Progressivo_Ordine__c = vlan.PROGRESSIVO_ORDINE;
                    vlan.ID = slv.id;
                    vlan.ID_RICHIESTA = id_log_richiestaVLAN;
                    System.debug('^^^^vlan.ID_RICHIESTA^^^^:'+vlan.ID_RICHIESTA);
                    vlan.POP = slv.PO_PP_POP_raccolta__c;
                    vlan.SVLAN = slv.SVLAN__c;
                    vlan.COS_REMARKING = slv.PO_PP_cos_remarking__c;
                    vlan.DHCP_OPTION82 = slv.PO_PP_dhcp_Option82__c;
                    vlan.COS_TYPE = slv.PO_PP_cos_type__c;
                    //Start - Campi del KIT
                    vlan.NOME_KIT = kitSelezionato.PO_PP_Nome_KIT__c;
                    System.debug('§§§§__vlan.NOME_KIT___§§§§:'+vlan.NOME_KIT);
                    vlan.BANDA_INTERFACCIA = kitSelezionato.PO_PP_Banda_Interfaccia__c;
                    vlan.INTERFACCIA = kitSelezionato.PO_PP_InterfacciaKit__c;
                    vlan.POP_KIT = kitSelezionato.PO_PP_Pop__c;
                    //END - Campi del KIT
                    
                    //Add - PG - 09-11
                    vlan.CODICE_ORDINE_SO = slv.OF_PP_NomeRichiesta_Figlio__c; 
                    vlan.CODICE_ORDINE_SFDC = slv.OF_PP_NomeRichiesta__c;
                    //End - PG - 09-11
                    
                    if(slv.PO_PP_cos_type__c.equalsIgnoreCase('MultiCOS'))
                    {
                        System.debug('++++++MultiCOS Class: '+slv.PO_PP_MultiCos_Class__c);
                        slv.PO_PP_cos_class__c = slv.PO_PP_MultiCos_Class__c;
                        slv.PO_PP_MultiCos_Class__c = '';
                        vlan.COS_CLASS = slv.PO_PP_cos_class__c;
                        vlan.USER_VLAN = '835';
                    }
                    else
                    {
                        vlan.COS_CLASS = slv.PO_PP_cos_class__c;
                        if(slv.PO_PP_cos_class__c.equalsIgnoreCase('0') ){
                            vlan.USER_VLAN = '835';
                        }
                        else if(slv.PO_PP_cos_class__c.equalsIgnoreCase('1') ){
                            vlan.USER_VLAN = '935';
                        }
                        else{
                            vlan.USER_VLAN = '837';
                        }
                    }
                    vlan.ID_ASSET = id_asset;
                    vlan.CODICE_OPERATORE = slv.EOF_Codice_Operatore__c;
                    vlan.STATO_ORDINE = 'Accettato';
                    vlan.DATA_NOTIFICA = OF_PP_GE_Utils.DateToString(system.now());
                    System.debug('***vlan.DATA_NOTIFICA ***:'+vlan.DATA_NOTIFICA);
                    
                    vlan.ID_NOTIFICA = String.valueOf(system.now().getTime());
                    vlan.NOTE = slv.EOF_NOTE__c;
                    
                    System.debug('§§§§§__slv.PO_PP_cos_type__c__§§§§:'+slv.PO_PP_cos_type__c);
                    
                    if(slv.PO_PP_cos_type__c.equalsIgnoreCase('MonoCOS'))
                    {
                        OF_PP_WS_IN_OLO_Activation.COS monoCos = new OF_PP_WS_IN_OLO_Activation.COS();
                        monoCos.TIPO = slv.PO_PP_cos_type__c;
                        monoCos.CLASSE = slv.PO_PP_cos_class__c;
                        monoCos.ID_VLAN = slv.id;
                        cos_list.add(monoCos);
                    }
                    else if(slv.PO_PP_cos_type__c.equalsIgnoreCase('MultiCOS'))
                    {
                        //System.debug('*****slv.PO_PP_MultiCos_Class__c****:'+slv.PO_PP_MultiCos_Class__c);
                        
                        String cos_class = slv.PO_PP_cos_class__c.replaceAll( '\\s+', '');
                        //System.debug('*********' + sl.PO_PP_cos_class__c);
                        //Inserisco i COS inseriti da portale in una lista di stringhe
                        arr_cos = cos_class.split('\\-');
                        System.debug('***Array COS***e size:'+arr_cos+' '+arr_cos.size());
                        
                        for(Integer i=0; i<arr_cos.size(); i++)
                        {
                            System.debug('****FOR****');
                            OF_PP_WS_IN_OLO_Activation.COS cos = new OF_PP_WS_IN_OLO_Activation.COS();
                            cos.TIPO = slv.PO_PP_cos_type__c;
                            cos.CLASSE = arr_cos[i];
                            cos.ID_VLAN = slv.id;
                            cos_list.add(cos);
                        }
                    }
                    vlan.listaCOS = cos_list;
                    System.debug('****vlan.listaCOS***:'+vlan.listaCOS);
                    sl = OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksActivation_SVLAN(vlan,slv); 
                    
                    //Aggiorno campi del log della VLAN
                    sl.EOF_Stato_Richiesta__c = 'Inserita Portale';
                    sl.EOF_STATO_Ordine__c = 'Accettato';
                    sl.EOF_DATA_NOTIFICA__c = OF_PP_GE_Utils.StringToDate(vlan.DATA_NOTIFICA);
                    sl.EOF_ID_NOTIFICA__c = vlan.ID_NOTIFICA;
                    //sgancio il log del portale dal Case -->Rimossa
                    //sl.Caso__c = null;
                    slToUpdate.add(sl);
                }
            }
            update slToUpdate;
            //Aggiorno lo stato della richiesta VLAN
            System.debug('****richiestaVLAN.EOF_Stato_Richiesta__c***PRIMA***:'+richiestaVLAN.EOF_Stato_Richiesta__c);
            richiestaVLAN.EOF_Stato_Richiesta__c = 'Inserita Portale';
            richiestaVLAN.EOF_STATO_Ordine__c = 'Accettato';
            System.debug('****richiestaVLAN.EOF_Stato_Richiesta__c***DOPO***:'+richiestaVLAN.EOF_Stato_Richiesta__c);
            update richiestaVLAN;
        }
        PageReference pg;
        
        if(sl.EOF_Stato_Richiesta__c!='error')
        { 
            showFieldsPostInsert = true;
            pg = new PageReference('/PO_PP_RiepilogoSVLAN');
            //pg.getParameters().put('id_kit',id_kit);
            pg.getParameters().put('proc','successInsertATT');
            pg.getParameters().put('nameKit',kitName);
            pg.getParameters().put('origID',sl.Id);
            pg.getParameters().put('richVLan','NO');
            pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
            pg.getParameters().put('show_buttons','false');
        }
        else
        {
            pg = new PageReference('/PO_PP_RiepilogoSVLAN');
            pg.getParameters().put('motivo',sl.EOF_motivazione__c);
            pg.getParameters().put('nameKit',kitName);
            pg.getParameters().put('proc','errorInsertATT');
            //pg.getParameters().put('id_kit',id_kit);
            pg.getParameters().put('origID',sl.Id);
        }
        return pg;
    }
}