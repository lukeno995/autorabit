public class PO_PP_DesospAnnull_controller {
  
    public EOF_EAI_Service_Log__c sl{get;set;}
    public boolean desospendi{get;set;}
    public boolean annulla{get;set;}
    public boolean rimodula{get;set;}
    public String title{get;set;}
    public List<SelectOption> MotivazioniOptions{get;set;}
    
    public PO_PP_DesospAnnull_controller()
    {
        sl= [select id,recordtype.developername,Caso__r.Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
            EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
            EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
            EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
            EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,OF_SA_KIT_CONSEGNA_VLAN__c,
            OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
            OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,
            OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,
            EOF_Motivazione__c,EOF_CODICE_OPERATORE__c,EOF_Comunicazioni_con_OLO__c
            from EOF_EAI_Service_Log__c 
            where Id=:Apexpages.currentPage().getParameters().get('origId')];
        
            desospendi=false;
            annulla=false;
            //rimodula=false; 
        
        if(Apexpages.currentPage().getParameters().get('proc')=='desospensione'){
            desospendi=true;
            title='Desospensione ';
            sl.EOF_Motivazione__c='';
            sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=null;
	    	sl.EOF_ORARIO_APPUNTAMENTO__c='';
	    	sl.EOF_Note__c='';
        }
        /* if(Apexpages.currentPage().getParameters().get('proc')=='rimodulazioneDAC'){
            rimodula=true;
            title='Rimodulazione DAC ';
            MotivazioniOptions = new List<SelectOption>();
            MotivazioniOptions.add(new SelectOption('',''));
	    	MotivazioniOptions.add(new SelectOption('C08 - Motivi Tecnici','C08 - Motivi Tecnici'));
	    	MotivazioniOptions.add(new SelectOption('D13 - Motivi Cliente','D13 - Motivi Cliente'));
	    	sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=null;
	    	sl.EOF_ORARIO_APPUNTAMENTO__c='';
	    	sl.EOF_Note__c='';
        }*/
        if(Apexpages.currentPage().getParameters().get('proc')=='annullamento'){
            annulla=true;
            title='Annullamento ';
            sl.EOF_MOTIVAZIONE__c='D12 - Annullamento su richiesta OLO';
            sl.EOF_Note__c='';
        }
    }
    
    public pageReference inoltraFlusso()
    {
        PageReference pg;
        system.debug('>>>>>>>>>>> DESOSPENDI -desospendi: '+desospendi);
        if(desospendi)
        {
            system.debug('>>>>>>>>>>> DESOSPENDI -001 ');
            OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
            sur.CODICE_ORDINE_OF=sl.Caso__r.Codice_Ordine_EOF__c; 
            sur.CODICE_OPERATORE=sl.EOF_CODICE_OPERATORE__c; 
            sur.CODICE_ORDINE_OLO=sl.Caso__r.Codice_Ordine_EOF__c;
            sur.DATA_NOTIFICA=OF_PP_GE_Utils.DateToString(system.now());
            sur.ID_NOTIFICA=String.valueOf(system.now().getTime());
            sur.AZIONE='0'; 
            sur.CODICE_MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.left(3);
            sur.MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.right(sl.EOF_MOTIVAZIONE__c.length()-5); 
            sur.DATA_PREVISTA_ATTIVAZIONE=OF_PP_GE_Utils.DateToStringNoTime(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
            sur.ORARIO_APPUNTAMENTO=sl.EOF_ORARIO_APPUNTAMENTO__c;
            //sur.NOME_CLIENTE=sl.EOF_NOME_CLIENTE__c;
            //sur.COGNOME_CLIENTE=sl.EOF_COGNOME_CLIENTE__c;
            //sur.RECAPITO_TELEFONICO_CLIENTE_1=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            //sur.RECAPITO_TELEFONICO_CLIENTE_2=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
            sur.NOTE=sl.EOF_NOTE__c;
            sl = OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(sur,sl);
            
            system.debug('>>>>>>>>>>> DESOSPENDI -0090 ');
            
            if(sl.EOF_STATO_Ordine__c!='error')
            { 
                system.debug('>>>>>>>>>>> DESOSPENDI -091 ');
                sl.EOF_DATA_NOTIFICA__c=OF_PP_GE_Utils.StringToDate(sur.DATA_NOTIFICA);
                sl.EOF_ID_NOTIFICA__c=sur.ID_NOTIFICA;
                update sl;
                pg = new PageReference('/PO_PP_InserimentoKit');
                pg.getParameters().put('proc','successDesosp');
                pg.getParameters().put('origId',sl.ID);
            }
            else
            {
                pg = new PageReference('/PO_PP_InserimentoKit');
                pg.getParameters().put('motivo',sl.EOF_motivazione__c);
                pg.getParameters().put('proc','errorDesosp');
                pg.getParameters().put('origId',sl.ID);
            }
            return pg;
        }
        if(annulla)
        {
            OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur = new OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest();
            sur.CODICE_ORDINE_OF=sl.Caso__r.Codice_Ordine_EOF__c; 
            sur.CODICE_OPERATORE=sl.EOF_CODICE_OPERATORE__c; 
            sur.CODICE_ORDINE_OLO=sl.EOF_CODICE_ORDINE_OLO__c;
            sur.DATA_NOTIFICA=OF_PP_GE_Utils.DateToString(system.now());
            sur.ID_NOTIFICA=String.valueOf(system.now().getTime());
            sur.AZIONE='1'; 
            sur.CODICE_MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.left(3);
            sur.MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.right(sl.EOF_MOTIVAZIONE__c.length()-5); 
            sur.DATA_PREVISTA_ATTIVAZIONE=OF_PP_GE_Utils.DateToStringNoTime(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
            sur.ORARIO_APPUNTAMENTO=sl.EOF_ORARIO_APPUNTAMENTO__c;
            // sur.NOME_CLIENTE=sl.EOF_NOME_CLIENTE__c;
            // sur.COGNOME_CLIENTE=sl.EOF_COGNOME_CLIENTE__c;
            // sur.RECAPITO_TELEFONICO_CLIENTE_1=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            // sur.RECAPITO_TELEFONICO_CLIENTE_2=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
            sur.NOTE=sl.EOF_NOTE__c;
            sl = OF_PP_OLO_EntryChecksKIT.PORTAL_SyncChecksStatusUpdate(sur,sl);
            
            if(sl.EOF_STATO_Ordine__c!='error')
            { 
                sl.EOF_DATA_NOTIFICA__c=OF_PP_GE_Utils.StringToDate(sur.DATA_NOTIFICA);
                sl.EOF_ID_NOTIFICA__c=sur.ID_NOTIFICA;
                update sl;
                pg = new PageReference('/PO_PP_InserimentoKit');
                pg.getParameters().put('proc','successAnnull');
            }
            else
            {
                pg = new PageReference('/PO_PP_InserimentoKit');
                pg.getParameters().put('motivo',sl.EOF_motivazione__c);
                pg.getParameters().put('proc','errorAnnull');
            }
        }
        
        /*  if(rimodula){
            OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r = new OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest();
            r.CODICE_ORDINE_OF=sl.Caso__r.Codice_Ordine_EOF__c; 
            r.CODICE_OPERATORE=sl.EOF_CODICE_OPERATORE__c; 
            r.CODICE_ORDINE_OLO=sl.EOF_CODICE_ORDINE_OLO__c;
            r.DATA_NOTIFICA=OF_PP_GE_Utils.DateToString(system.now());
            r.ID_NOTIFICA=String.valueOf(system.now().getTime());
            r.CODICE_MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.left(3);
            r.MOTIVAZIONE=sl.EOF_MOTIVAZIONE__c.right(sl.EOF_MOTIVAZIONE__c.length()-5); 
            r.DATA_PREVISTA_ATTIVAZIONE=OF_PP_GE_Utils.DateToStringNoTime(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
            r.ORARIO_APPUNTAMENTO=sl.EOF_ORARIO_APPUNTAMENTO__c;
            r.NOME_CLIENTE=sl.EOF_NOME_CLIENTE__c;
            r.COGNOME_CLIENTE=sl.EOF_COGNOME_CLIENTE__c;
            r.RECAPITO_TELEFONICO_CLIENTE_1=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            r.RECAPITO_TELEFONICO_CLIENTE_2=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
            r.NOTE=sl.EOF_NOTE__c;
            sl = OF_SA_OLO_EntryChecks.PORTAL_SyncChecksReschedule(r,sl);
            
            if(sl.EOF_STATO_Ordine__c!='error')
            { 
                sl.EOF_DATA_NOTIFICA__c=OF_PP_GE_Utils.StringToDate(r.DATA_NOTIFICA);
                sl.EOF_ID_NOTIFICA__c=r.ID_NOTIFICA;
                update sl;
                pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
                pg.getParameters().put('proc','successRimod');
            }
            else{
                pg = new PageReference('/PO_OpenStreamService_InsertNewRequest');
                pg.getParameters().put('motivo',sl.EOF_motivazione__c);
                pg.getParameters().put('proc','errorRimod');
            }
        }  
        */
        pg.getParameters().put('origID',sl.Id);
        return pg;
    }
    
    public pageReference annullaFlusso()
    {
        Pagereference pg = new Pagereference('/PO_RiepilogoKIT');
        //pg.getParameters().put('proc','attivazioneInoltrata');
        pg.getParameters().put('origID',Apexpages.currentPage().getParameters().get('origId'));
        return pg;
    }
}