public class PO_COMP_TT_Visualizza_Controller {
    public EOF_EAI_Service_Log__c SLogToView{set;get;}
     
    public string slogId {set;get;}  // id del case in esame
    
    public boolean bozza{get;set;}
    public boolean inLavorazione{get;set;}
    public boolean richiestaChiusura{get;set;}
    public boolean sospeso{get;set;}
    public string inoltrato{get;set;}
    public string tipoRisorsa{get;set;}
    
    public string inputTimeStr {get; set;} // per supporto all'apexinput
    public string inputTimeStr2 {get; set;} // per il ritorno di datatime
    //AA 11/07/18 - Variabile per gestire il cruscotto!
    public boolean switchTTMSystem {get; set;}

    
    //Costruttore
    public PO_COMP_TT_Visualizza_Controller()
    {
       //apex outout pannel to false (all)
       inLavorazione=false;
       richiestaChiusura=false;
       sospeso=false;
        inoltrato='';
        
       slogId=ApexPages.currentPage().getParameters().get('origId').trim();
       System.debug('@@@slogId'+slogId);
       if(ApexPages.currentPage().getParameters().containsKey('inoltrato')){
            inoltrato=ApexPages.currentPage().getParameters().get('inoltrato').trim();
       }  
       
       if(slogId != null && slogId!=''){ 
        
            // da rivedere la query 
            SLogToView=[select id,EOF_Codice_Ordine_OLO__c,EOF_Codice_Comunicazione_OLO__c, EOF_Stato_Richiesta__c, 
                                EOF_Codice_Operatore__c,  EOF_Categoria_Guasto__c, EOF_ID_Notifica__c,EOF_ID_Risorsa__c,
                                EOF_Causale_Apertura__c, EOF_Tipo_Comunicazione__c, EOF_Tipo_comunicazione_string__c, EOF_Data_Ora_Inizio_Guasto__c,EOF_Nome_Cliente__c, 
                                EOF_COgnome_CLiente__c, EOF_RECAPITO_TELEFONICO_CLIENTE_1__c, EOF_RECAPITO_TELEFONICO_CLIENTE_2__c, 
                                EOF_NOME_REFERENTE_TECNICO_OLO__c, EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,
                                EOF_Verifica_apparato_cliente__c, EOF_Descrizione_Problema__c,EOF_NOTE__c,EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c,
                                EOF_Data_Ora_Richiesta_Annullamento__c,EOF_Causale_Desospensione__c,EOF_Referente_desospensione__c,EOF_Data_Ora_Autoripristinato__c,
                                EOF_Data_Ora_Desospensione__c,EOF_NOTE_CLIENTE__c,EOF_Intervento_Congiunto__c,EOF_Data_Ora_Scarto__c,EOF_Data_Ora_Creazione__c,
                                EOF_Data_Ora_Notifica_Sospensione__c,EOF_Data_Ora_Notifica_Desospensione__c,EOF_Data_Ora_Notifica_Annullamento__c,
                                EOF_Data_Ora_Notifica_Chiusura__c,Causale_Scarto__c,EOF_Descrizione_Causale_Scarto__c,Causale_Sospensione__c,
                                Descrizione_Evento_Risoluzione__c,EOF_Rischedulazione_Appuntamento__c, EOF_Richiesta_Notifica__c,
                                EOF_Tec_Eof__c,EOF_Tel_Tec_Eof__c,EOF_Data_Ora_Intervento_Congiunto__c,EOF_STATO_ORDINE__c    
                                from EOF_EAI_Service_Log__c  where id =:slogId];
            if(SLogToView.EOF_Stato_Richiesta__c=='Bozza') bozza=true;
            if(SLogToView.EOF_STATO_ORDINE__c =='In Lavorazione') inLavorazione=true;
            if(SLogToView.EOF_STATO_ORDINE__c =='Richiesta Chiusura') richiestaChiusura=true;
            if(SLogToView.EOF_STATO_ORDINE__c =='Sospeso') sospeso=true;
            
            tipoRisorsa=ReturnTipoRisorsa();
            
       }else{
            SLogToView= new EOF_EAI_Service_Log__c();
       }   
    }
    //Reindirizza nella pagina di tutte le richieste Inserite
    public PageReference ListaRichiesteInserite()
    {
        return new PageReference('/PO_TT_DisplayRequest');
    }
    //Reindirizza nella pagina di Inserimento Richiesta(Form di compilazione)
    public PageReference ReferenceNewInsertPage()
    {
        return new PageReference('/PO_TT_InsertNewRequest');
    }
    //Reindirizza nella pagina di Inserimento Richiesta(Form di compilazione)
    //con i campi già compilati del Caso da modificare
    public PageReference ToModifyCase()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTModifica');
        return pg;
    }
    
    public PageReference ToInoltraCase()
    {
        
        try{
            SLogToView.EOF_Stato_Richiesta__c='In Inserimento' ;
            update SLogToView;
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
            tt.TIPO_COMUNICAZIONE='1'; 
            //tt.CODICE_OPERATORE=SLogToView.EOF_CODICE_OPERATORE__c; // contact 
            tt.CODICE_OPERATORE=ReturnCodiceOpertore();
            tt.CODICE_COMUNICAZIONE_OLO=SLogToView.EOF_Codice_Comunicazione_OLO__c;
            tt.CATEGORIA_GUASTO=SLogToView.EOF_Categoria_Guasto__c;       
            tt.ID_NOTIFICA=String.valueOf(system.now().getTime());        
            tt.ID_RISORSA=SLogToView.EOF_ID_Risorsa__c;
            tt.DATA_ORA_INIZIO_GUASTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Inizio_Guasto__c); // date to string
            tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Richiesta_Annullamento__c);// date to string
            tt.DATA_ORA_DESOSPENSIONE=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Desospensione__c);// date to string
            tt.DATA_ORA_AUTORIPRISTINATO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Autoripristinato__c);// date to string
            tt.CAUSALE_RICHIESTA_ANNULLAMENTO=SLogToView.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
            tt.CAUSALE_DESOSPENSIONE=SLogToView.EOF_Causale_Desospensione__c;
            tt.NOME_CLIENTE=SLogToView.EOF_Nome_Cliente__c;
            tt.COGNOME_CLIENTE=SLogToView.EOF_COgnome_CLiente__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_1=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_2=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;           
            tt.NOME_REFERENTE_TECNICO_OLO=SLogToView.EOF_NOME_REFERENTE_TECNICO_OLO__c;            
            tt.TELEFONO_REFERENTE_TECNICO_OLO=SLogToView.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;                       //da vedere
            tt.EMAIL_REFERENTE_TECNICO_OLO=SLogToView.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            tt.REFERENTE_DESOSPENSIONE=SLogToView.EOF_Referente_desospensione__c;
            tt.VERIFICA_APPARATO_CLIENTE=SLogToView.EOF_Verifica_apparato_cliente__c;
            tt.DESCRIZIONE_PROBLEMA=SLogToView.EOF_Descrizione_Problema__c;
            tt.NOTE_CLIENTE= SLogToView.EOF_NOTE_CLIENTE__c;       //da vedere     
            tt.NOTE= SLogToView.EOF_NOTE__c;  
            tt.CAUSALE_APERTURA=SLogToView.EOF_Causale_Apertura__c;
            tt.INTERVENTO_CONGIUNTO=SLogToView.EOF_Intervento_Congiunto__c;
            System.debug('@@@@@tt'+tt);
            System.debug('@@@@@SLogToView '+SLogToView );
            //tt.TEC_OLO=
            //?tt.TEL_TEC_OLO=
            //tt.DATA_ORA_INTERVENTO_CONGIUNTO=
            //SlogToview.EOF_Richiesta_Notifica__c = OF_TTM_Utils.copy_TT_request(tt);
            //SlogToview.EOF_Tipo_comunicazione_string__c = 'PO - TT ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE);
            //Per decidere su quale servizio inoltrare la richiesta mi basterà controllare il rubinetto
            Boolean hasCheckSyncError = false;
            List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
            Date dataswitchTTM = listCustomSett[0].OF_DataSwitchTTM__c;
            if( dataswitchTTM!= null && date.today() >= dataswitchTTM ){
                System.debug('Still old system');
                if(listCustomSett[0].OF_TT_TuttoSuTTM__c){
                	SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                	hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
                }
                else if(!String.isBlank(listCustomSett[0].OF_TT_CodOpOLOSuTTM__c) && listCustomSett[0].OF_TT_CodOpOLOSuTTM__c==TT.CODICE_OPERATORE){
                	SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                	hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
                }
                else{
                	SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                	hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;  
                }
                
            }else{
                SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;  
            }
            
            PageReference pg; 
            if(!hasCheckSyncError){
            //if(SLogToView.EOF_STATO_Ordine__c!='error'){ 
                
                SLogToView.EOF_Stato_Richiesta__c='Inserita Portale';
                //SLogToView.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(tt.DATA_NOTIFICA);
                SLogToView.EOF_ID_NOTIFICA__c=tt.ID_NOTIFICA;
                update SLogToView;
                pg = new PageReference('/PO_TT_InsertNewRequest');
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato','Trouble Ticket Inoltrato Correttamente');
                
               
            }
            else{
                pg = new PageReference('/PO_TT_InsertNewRequest');
                //pg.getParameters().put('motivo',SLogToView.EOF_motivazione__c);
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato',SLogToView.EOF_motivazione__c);
                
            }
            
            return pg;
            
            
        }
        catch(DMLexception e){
            ApexPages.addMessages(e);
            
        }
        
        return ListaRichiesteInserite();
    }
    
  
    
    public PageReference ToAnnulla()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTRichiestaAnnullamento');
        return pg;
    }
    
    
    public PageReference ToInoltraRichiestaAnnullamento()
    {
        try{
            //AA recupero il valore per andare su TTM o TT
            switchTTMSystem = OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom(SLogToView.EOF_Codice_Comunicazione_OLO__c);
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
            tt.TIPO_COMUNICAZIONE='9'; 
            //tt.CODICE_OPERATORE=SLogToView.EOF_CODICE_OPERATORE__c; // contact 
            tt.CODICE_OPERATORE=ReturnCodiceOpertore();
            tt.CODICE_COMUNICAZIONE_OLO=SLogToView.EOF_Codice_Comunicazione_OLO__c;
            tt.CATEGORIA_GUASTO=SLogToView.EOF_Categoria_Guasto__c;       
            tt.ID_NOTIFICA=String.valueOf(system.now().getTime());        
            tt.ID_RISORSA=SLogToView.EOF_ID_Risorsa__c;
            //tt.DATA_ORA_INIZIO_GUASTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Inizio_Guasto__c); // date to string
            tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(datetime.valueOfGmt(inputTimeStr2)-offset);
            system.debug('PO_COMP_TT ' + tt.DATA_ORA_RICHIESTA_ANNULLAMENTO);
            //inputTimeStr2
            //tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Richiesta_Annullamento__c);// date to string
            //tt.DATA_ORA_DESOSPENSIONE=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Desospensione__c);// date to string
            //tt.DATA_ORA_AUTORIPRISTINATO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Autoripristinato__c);// date to string
            tt.CAUSALE_RICHIESTA_ANNULLAMENTO=SLogToView.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
            //tt.CAUSALE_DESOSPENSIONE=SLogToView.EOF_Causale_Desospensione__c;
            tt.NOME_CLIENTE=SLogToView.EOF_Nome_Cliente__c;
            tt.COGNOME_CLIENTE=SLogToView.EOF_COgnome_CLiente__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_1=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_2=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;           
            tt.NOME_REFERENTE_TECNICO_OLO=SLogToView.EOF_NOME_REFERENTE_TECNICO_OLO__c;            
            tt.TELEFONO_REFERENTE_TECNICO_OLO=SLogToView.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;                       //da vedere
            tt.EMAIL_REFERENTE_TECNICO_OLO=SLogToView.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            //tt.REFERENTE_DESOSPENSIONE=SLogToView.EOF_Referente_desospensione__c;
            //tt.VERIFICA_APPARATO_CLIENTE=SLogToView.EOF_Verifica_apparato_cliente__c;
            //tt.DESCRIZIONE_PROBLEMA=SLogToView.EOF_Descrizione_Problema__c;
            tt.NOTE_CLIENTE= SLogToView.EOF_NOTE_CLIENTE__c;       //da vedere     
            tt.NOTE= SLogToView.EOF_NOTE__c;  
            //tt.CAUSALE_APERTURA=SLogToView.EOF_Causale_Apertura__c;
            //tt.INTERVENTO_CONGIUNTO=SLogToView.EOF_Intervento_Congiunto__c;
            //tt.TEC_OLO=
            //?tt.TEL_TEC_OLO=
            //tt.DATA_ORA_INTERVENTO_CONGIUNTO=  
            //SlogToview.EOF_Richiesta_Notifica__c = OF_TTM_Utils.copy_TT_request(tt);
            //SlogToview.EOF_Tipo_comunicazione_string__c = 'PO - TT ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE);
            Boolean hasCheckSyncError = false;
            System.debug('***** SISTEMA TTM?? ' + switchTTMSystem);
            if (switchTTMSystem){//nuovo sistema TTM
                SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
            }else{//vecchio sistema
                SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;
            }
            
            PageReference pg;
           // if(!OF_TT_EntryChecks.checkSynchError){ 
            //if(SLogToView.EOF_STATO_Ordine__c!='error'){ 
            if(!hasCheckSyncError){ 
                SLogToView.EOF_Stato_Richiesta__c='Inserita Portale';
                //SLogToView.EOF_STATO_Ordine__c=SLogToView.Case_Portale__r.Status;
                //SLogToView.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(tt.DATA_NOTIFICA);
                SLogToView.EOF_ID_NOTIFICA__c=tt.ID_NOTIFICA;
                update SLogToView;
                pg = new PageReference('/PO_TT_InsertNewRequest');
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato','Trouble Ticke Inoltrato Correttamente');
                
               
            }else{
                pg = new PageReference('/PO_TT_InsertNewRequest');
                //pg.getParameters().put('motivo',SLogToView.EOF_motivazione__c);
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato',SLogToView.EOF_motivazione__c);
                
            }
            
            return pg;
            
            
        }
        catch(DMLexception e){
            ApexPages.addMessages(e);
            
        }
        
        return ListaRichiesteInserite();
        
    }
    
    
    
    public PageReference ToTestOK()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTTestOK');
        return pg;
    }
    
    public PageReference ToInoltraTestOK()
    {
        try{
            //AA recupero il valore per andare su TTM o TT
            switchTTMSystem = OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom(SLogToView.EOF_Codice_Comunicazione_OLO__c);
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
            tt.TIPO_COMUNICAZIONE='12'; 
            //tt.CODICE_OPERATORE=SLogToView.EOF_CODICE_OPERATORE__c; // contact 
            tt.CODICE_OPERATORE=ReturnCodiceOpertore();
            tt.CODICE_COMUNICAZIONE_OLO=SLogToView.EOF_Codice_Comunicazione_OLO__c;
            tt.CATEGORIA_GUASTO=SLogToView.EOF_Categoria_Guasto__c;       
            tt.ID_NOTIFICA=String.valueOf(system.now().getTime());        
            tt.ID_RISORSA=SLogToView.EOF_ID_Risorsa__c;
            //tt.DATA_ORA_INIZIO_GUASTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Inizio_Guasto__c); // date to string
            //tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Richiesta_Annullamento__c);// date to string
            //tt.DATA_ORA_DESOSPENSIONE=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Desospensione__c);// date to string
            //tt.DATA_ORA_AUTORIPRISTINATO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Autoripristinato__c);// date to string
            //tt.CAUSALE_RICHIESTA_ANNULLAMENTO=SLogToView.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
            //tt.CAUSALE_DESOSPENSIONE=SLogToView.EOF_Causale_Desospensione__c;
            tt.NOME_CLIENTE=SLogToView.EOF_Nome_Cliente__c;
            tt.COGNOME_CLIENTE=SLogToView.EOF_COgnome_CLiente__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_1=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_2=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;           
            tt.NOME_REFERENTE_TECNICO_OLO=SLogToView.EOF_NOME_REFERENTE_TECNICO_OLO__c;            
            tt.TELEFONO_REFERENTE_TECNICO_OLO=SLogToView.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;                       //da vedere
            tt.EMAIL_REFERENTE_TECNICO_OLO=SLogToView.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            //tt.REFERENTE_DESOSPENSIONE=SLogToView.EOF_Referente_desospensione__c;
            //tt.VERIFICA_APPARATO_CLIENTE=SLogToView.EOF_Verifica_apparato_cliente__c;
            //tt.DESCRIZIONE_PROBLEMA=SLogToView.EOF_Descrizione_Problema__c;
            tt.NOTE_CLIENTE= SLogToView.EOF_NOTE_CLIENTE__c;       //da vedere     
            tt.NOTE= SLogToView.EOF_NOTE__c;  
            tt.CAUSALE_APERTURA=SLogToView.EOF_Causale_Apertura__c;
            tt.INTERVENTO_CONGIUNTO=SLogToView.EOF_Intervento_Congiunto__c;
            //tt.TEC_OLO=
            //?tt.TEL_TEC_OLO=
            //tt.DATA_ORA_INTERVENTO_CONGIUNTO=  
            //SlogToview.EOF_Richiesta_Notifica__c = OF_TTM_Utils.copy_TT_request(tt);
            //SlogToview.EOF_Tipo_comunicazione_string__c = 'PO - TT ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE);

            Boolean hasCheckSyncError = false;
            if (switchTTMSystem){//nuovo sistema TTM
                SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
            }else{//vecchio sistema
                SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;
            }
             
            PageReference pg;
            //if(!OF_TT_EntryChecks.checkSynchError){ 
            //if(SLogToView.EOF_STATO_Ordine__c!='error'){ 
            if(!hasCheckSyncError){
                SLogToView.EOF_Stato_Richiesta__c='Inserita Portale';
                //SLogToView.EOF_STATO_Ordine__c=SLogToView.Case_Portale__r.Status;
                //SLogToView.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(tt.DATA_NOTIFICA);
                SLogToView.EOF_ID_NOTIFICA__c=tt.ID_NOTIFICA;
                update SLogToView;
                pg = new PageReference('/PO_TT_InsertNewRequest');
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato','Trouble Ticke Inoltrato Correttamente');
            }else{
                pg = new PageReference('/PO_TT_InsertNewRequest');
                //pg.getParameters().put('motivo',SLogToView.EOF_motivazione__c);
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato',SLogToView.EOF_motivazione__c);
            }
            
            return pg;
        }
        catch(DMLexception e){
            ApexPages.addMessages(e);
        }
        return ListaRichiesteInserite();
    }
    
    public PageReference ToTestKO()
    {
        
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTTestKO');
        return pg;
    }
    
    public PageReference ToInoltraTestKO()
    {
        try{
            //AA recupero il valore per andare su TTM o TT
            switchTTMSystem = OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom(SLogToView.EOF_Codice_Comunicazione_OLO__c);
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
            tt.TIPO_COMUNICAZIONE='11'; 
            //tt.CODICE_OPERATORE=SLogToView.EOF_CODICE_OPERATORE__c; // contact 
            tt.CODICE_OPERATORE=ReturnCodiceOpertore();
            tt.CODICE_COMUNICAZIONE_OLO=SLogToView.EOF_Codice_Comunicazione_OLO__c;
            tt.CATEGORIA_GUASTO=SLogToView.EOF_Categoria_Guasto__c;       
            tt.ID_NOTIFICA=String.valueOf(system.now().getTime());        
            tt.ID_RISORSA=SLogToView.EOF_ID_Risorsa__c;
            //tt.DATA_ORA_INIZIO_GUASTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Inizio_Guasto__c); // date to string
            //tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Richiesta_Annullamento__c);// date to string
            //tt.DATA_ORA_DESOSPENSIONE=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Desospensione__c);// date to string
            //tt.DATA_ORA_AUTORIPRISTINATO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Autoripristinato__c);// date to string
            //tt.CAUSALE_RICHIESTA_ANNULLAMENTO=SLogToView.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
            //tt.CAUSALE_DESOSPENSIONE=SLogToView.EOF_Causale_Desospensione__c;
            tt.NOME_CLIENTE=SLogToView.EOF_Nome_Cliente__c;
            tt.COGNOME_CLIENTE=SLogToView.EOF_COgnome_CLiente__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_1=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_2=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;           
            tt.NOME_REFERENTE_TECNICO_OLO=SLogToView.EOF_NOME_REFERENTE_TECNICO_OLO__c;            
            tt.TELEFONO_REFERENTE_TECNICO_OLO=SLogToView.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;                       //da vedere
            tt.EMAIL_REFERENTE_TECNICO_OLO=SLogToView.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            tt.REFERENTE_DESOSPENSIONE=SLogToView.EOF_Referente_desospensione__c;
            //tt.VERIFICA_APPARATO_CLIENTE=SLogToView.EOF_Verifica_apparato_cliente__c;
            tt.DESCRIZIONE_PROBLEMA=SLogToView.EOF_Descrizione_Problema__c;
            tt.NOTE_CLIENTE= SLogToView.EOF_NOTE_CLIENTE__c;       //da vedere     
            tt.NOTE= SLogToView.EOF_NOTE__c;  
            tt.CAUSALE_APERTURA=SLogToView.EOF_Causale_Apertura__c;
            tt.INTERVENTO_CONGIUNTO=SLogToView.EOF_Intervento_Congiunto__c;
            //tt.TEC_OLO=
            //?tt.TEL_TEC_OLO=
            //tt.DATA_ORA_INTERVENTO_CONGIUNTO=  
            //SlogToview.EOF_Richiesta_Notifica__c = OF_TTM_Utils.copy_TT_request(tt);
            //SlogToview.EOF_Tipo_comunicazione_string__c = 'PO - TT ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE);
            
            Boolean hasCheckSyncError = false;
            if (switchTTMSystem){//nuovo sistema TTM
                SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
            }else{//vecchio sistema
                SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;
            }            
            
            PageReference pg;
            //if(!OF_TT_EntryChecks.checkSynchError){ 
            //if(SLogToView.EOF_STATO_Ordine__c!='error'){ 
            if(!hasCheckSyncError){ 
                SLogToView.EOF_Stato_Richiesta__c='Inserita Portale';
                //SLogToView.EOF_STATO_Ordine__c=SLogToView.Case_Portale__r.Status;
                //SLogToView.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(tt.DATA_NOTIFICA);
                SLogToView.EOF_ID_NOTIFICA__c=tt.ID_NOTIFICA;
                update SLogToView;
                pg = new PageReference('/PO_TT_InsertNewRequest');
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato','Trouble Ticket Inoltrato Correttamente');
            }else{
                pg = new PageReference('/PO_TT_InsertNewRequest');
                //pg.getParameters().put('motivo',SLogToView.EOF_motivazione__c);
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato',SLogToView.EOF_motivazione__c);
                
            }
            return pg;
        }
        catch(DMLexception e){
            ApexPages.addMessages(e);
        }
        return ListaRichiesteInserite();
    }
    
    public PageReference ToDesospensione()
    {
        
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTDesospensione');
        return pg;
    }
    
    public PageReference ToInoltraNotificaDesospensione()
    {
        try{
            //AA recupero il valore per andare su TTM o TT
            switchTTMSystem = OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom(SLogToView.EOF_Codice_Comunicazione_OLO__c);
            SLogToView.EOF_Data_Ora_Desospensione__c=datetime.valueOfGmt(inputTimeStr2)-offset;
            //update SLogToview;
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
            tt.TIPO_COMUNICAZIONE='6'; 
            //tt.CODICE_OPERATORE=SLogToView.EOF_CODICE_OPERATORE__c; // contact 
            tt.CODICE_OPERATORE=ReturnCodiceOpertore();
            tt.CODICE_COMUNICAZIONE_OLO=SLogToView.EOF_Codice_Comunicazione_OLO__c;
            tt.CATEGORIA_GUASTO=SLogToView.EOF_Categoria_Guasto__c;       
            tt.ID_NOTIFICA=String.valueOf(system.now().getTime());        
            tt.ID_RISORSA=SLogToView.EOF_ID_Risorsa__c;
            //tt.DATA_ORA_INIZIO_GUASTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Inizio_Guasto__c); // date to string
            //tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Richiesta_Annullamento__c);// date to string
            tt.DATA_ORA_DESOSPENSIONE=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Desospensione__c);// date to string
            //tt.DATA_ORA_AUTORIPRISTINATO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Autoripristinato__c);// date to string
            //tt.CAUSALE_RICHIESTA_ANNULLAMENTO=SLogToView.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
            tt.CAUSALE_DESOSPENSIONE=SLogToView.EOF_Causale_Desospensione__c;
            tt.NOME_CLIENTE=SLogToView.EOF_Nome_Cliente__c;
            tt.COGNOME_CLIENTE=SLogToView.EOF_COgnome_CLiente__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_1=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_2=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;           
            tt.NOME_REFERENTE_TECNICO_OLO=SLogToView.EOF_NOME_REFERENTE_TECNICO_OLO__c;            
            tt.TELEFONO_REFERENTE_TECNICO_OLO=SLogToView.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;                       //da vedere
            tt.EMAIL_REFERENTE_TECNICO_OLO=SLogToView.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            tt.REFERENTE_DESOSPENSIONE=SLogToView.EOF_Referente_desospensione__c;
            //tt.VERIFICA_APPARATO_CLIENTE=SLogToView.EOF_Verifica_apparato_cliente__c;
            //tt.DESCRIZIONE_PROBLEMA=SLogToView.EOF_Descrizione_Problema__c;
            tt.NOTE_CLIENTE= SLogToView.EOF_NOTE_CLIENTE__c;       //da vedere     
            tt.NOTE= SLogToView.EOF_NOTE__c;  
            //tt.CAUSALE_APERTURA=SLogToView.EOF_Causale_Apertura__c;
            //tt.INTERVENTO_CONGIUNTO=SLogToView.EOF_Intervento_Congiunto__c;
            //tt.TEC_OLO=
            //?tt.TEL_TEC_OLO=
            //tt.DATA_ORA_INTERVENTO_CONGIUNTO=  
            //SlogToview.EOF_Richiesta_Notifica__c = OF_TTM_Utils.copy_TT_request(tt);
            //SlogToview.EOF_Tipo_comunicazione_string__c = 'PO - TT ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE);
             
            Boolean hasCheckSyncError = false;
            if (switchTTMSystem){//nuovo sistema TTM
                SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
            }else{//vecchio sistema
                SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;
            }
           
            PageReference pg;
            //if(!OF_TT_EntryChecks.checkSynchError){ 
            //if(SLogToView.EOF_STATO_Ordine__c!='error'){ 
            if(!hasCheckSyncError){
                SLogToView.EOF_Stato_Richiesta__c='Inserita Portale';
                //SLogToView.EOF_STATO_Ordine__c=SLogToView.Case_Portale__r.Status;
                //SLogToView.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(tt.DATA_NOTIFICA);
                SLogToView.EOF_ID_NOTIFICA__c=tt.ID_NOTIFICA;
                update SLogToView;
                pg = new PageReference('/PO_TT_InsertNewRequest');
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato','Trouble Ticket Inoltrato Correttamente, riceverà una notifica quando il ticket tornerà in lavorazione');  
            }else{
                pg = new PageReference('/PO_TT_InsertNewRequest');
                //pg.getParameters().put('motivo',SLogToView.EOF_motivazione__c);
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato',SLogToView.EOF_motivazione__c);
            }
            return pg;
        }
        catch(DMLexception e){
            ApexPages.addMessages(e);
        }
        return ListaRichiesteInserite();
    }
    
    public PageReference ToAutoripristinato(){
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTAutoripristinato');
        return pg;
    }
    
    public PageReference ToInoltraAutoripristinato(){
        try{
            //AA recupero il valore per andare su TTM o TT
            switchTTMSystem = OF_TTM_Utils.retrieveTTCaseSystemRefByCodCom(SLogToView.EOF_Codice_Comunicazione_OLO__c);

            SLogToView.EOF_Data_Ora_Autoripristinato__c=datetime.valueOfGmt(inputTimeStr2)-offset;
            
            OF_TT_WS_TroubleTicketRequest.TroubleTicket tt = new  OF_TT_WS_TroubleTicketRequest.TroubleTicket();
            tt.TIPO_COMUNICAZIONE='8'; 
            //tt.CODICE_OPERATORE=SLogToView.EOF_CODICE_OPERATORE__c; // contact 
            tt.CODICE_OPERATORE=ReturnCodiceOpertore();
            tt.CODICE_COMUNICAZIONE_OLO=SLogToView.EOF_Codice_Comunicazione_OLO__c;
            tt.CATEGORIA_GUASTO=SLogToView.EOF_Categoria_Guasto__c;       
            tt.ID_NOTIFICA=String.valueOf(system.now().getTime());        
            tt.ID_RISORSA=SLogToView.EOF_ID_Risorsa__c;
            //tt.DATA_ORA_INIZIO_GUASTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Inizio_Guasto__c); // date to string
            //tt.DATA_ORA_RICHIESTA_ANNULLAMENTO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Richiesta_Annullamento__c);// date to string
            //tt.DATA_ORA_DESOSPENSIONE=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Desospensione__c);// date to string
            tt.DATA_ORA_AUTORIPRISTINATO=OF_SA_GE_Utils.DateToString(SLogToView.EOF_Data_Ora_Autoripristinato__c);// date to string
            //tt.CAUSALE_RICHIESTA_ANNULLAMENTO=SLogToView.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c;
            tt.CAUSALE_DESOSPENSIONE=SLogToView.EOF_Causale_Desospensione__c;
            //tt.NOME_CLIENTE=SLogToView.EOF_Nome_Cliente__c;
            tt.COGNOME_CLIENTE=SLogToView.EOF_COgnome_CLiente__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_1=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
            tt.RECAPITO_TELEFONICO_CLIENTE_2=SLogToView.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;           
            tt.NOME_REFERENTE_TECNICO_OLO=SLogToView.EOF_NOME_REFERENTE_TECNICO_OLO__c;            
            tt.TELEFONO_REFERENTE_TECNICO_OLO=SLogToView.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;                       //da vedere
            tt.EMAIL_REFERENTE_TECNICO_OLO=SLogToView.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            tt.REFERENTE_DESOSPENSIONE=SLogToView.EOF_Referente_desospensione__c;
            //tt.VERIFICA_APPARATO_CLIENTE=SLogToView.EOF_Verifica_apparato_cliente__c;
            //tt.DESCRIZIONE_PROBLEMA=SLogToView.EOF_Descrizione_Problema__c;
            tt.NOTE_CLIENTE= SLogToView.EOF_NOTE_CLIENTE__c;       //da vedere     
            tt.NOTE= SLogToView.EOF_NOTE__c;  
            tt.CAUSALE_APERTURA=SLogToView.EOF_Causale_Apertura__c;
            tt.INTERVENTO_CONGIUNTO=SLogToView.EOF_Intervento_Congiunto__c;
            //tt.TEC_OLO=
            //?tt.TEL_TEC_OLO=
            //tt.DATA_ORA_INTERVENTO_CONGIUNTO=  
            //SlogToview.EOF_Richiesta_Notifica__c = OF_TTM_Utils.copy_TT_request(tt); 
            //SlogToview.EOF_Tipo_comunicazione_string__c = 'PO - TT ' + OF_TTM_Utils.getStringTipoComunicazione(tt.TIPO_COMUNICAZIONE);
             
            Boolean hasCheckSyncError = false;
            if (switchTTMSystem){//nuovo sistema TTM
                SLogToView = OF_TTM_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TTM_EntryChecks.checkSynchError;
            }else{//vecchio sistema
                SLogToView = OF_TT_EntryChecks.PORTAL_checkSync(tt,SLogToView);
                hasCheckSyncError = OF_TT_EntryChecks.checkSynchError;
            }
            
            PageReference pg;
            //if(!OF_TT_EntryChecks.checkSynchError){ 
            //if(SLogToView.EOF_STATO_Ordine__c!='error'){ 
            if(!hasCheckSyncError){
                SLogToView.EOF_Stato_Richiesta__c='Inserita Portale';
                //SLogToView.EOF_STATO_Ordine__c=SLogToView.Case_Portale__r.Status;
                //SLogToView.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(tt.DATA_NOTIFICA);
                SLogToView.EOF_ID_NOTIFICA__c=tt.ID_NOTIFICA;
                update SLogToView;
                pg = new PageReference('/PO_TT_InsertNewRequest');
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato','Trouble Ticket Inoltrato Correttamente');
            }else{
                pg = new PageReference('/PO_TT_InsertNewRequest');
                //pg.getParameters().put('motivo',SLogToView.EOF_motivazione__c);
                pg.getParameters().put('proc','TTVisualizza');
                pg.getParameters().put('origID',SLogToView.Id);
                pg.getParameters().put('inoltrato',SLogToView.EOF_motivazione__c);    
            }
            return pg;
        }
        catch(DMLexception e){
            ApexPages.addMessages(e);
        }
        return ListaRichiesteInserite();
    }   
    
    public PageReference ToAnnullaOperazione()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTVisualizza');
        return pg;
    }
    
    public PageReference ToInviaRichiesta()
    {
        PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
        pg.getParameters().put('origId',SLogToView.Id);
        pg.getParameters().put('proc','TTVisualizza');
        return pg;
    }    
    
    public Double offset{get{
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
    }}
    
    public String ReturnCodiceOpertore(){
    
        User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId() limit 1];
        return attuale.Account.EOF_Codice_Operatore__c;
    }
    
    public String ReturnTipoRisorsa(){ 
    
        List<Asset> TipoRisorsa=[select RecordType.name from Asset where EOF_ID_Risorsa__c =:SLogToView.EOF_ID_Risorsa__c limit 1];
        if(!TipoRisorsa.isEmpty()) {
            return TipoRisorsa[0].RecordType.name;
        } else {
            return '';
        }
    }
       
}