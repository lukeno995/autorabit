public with sharing class PO_OpenStreamService_Controller {
   
    public boolean VLAN{get;set;}
    public boolean ServizioAggiuntivo{get;set;}
    public boolean Apparato{get;set;}  
    public boolean richiestaAttivazione{get;set;} 
    public boolean richiestaIdRisorsa{get;set;}
    public boolean richiestaCessazione{get;set;}
    //EC - 2018 - 05 -21 ChangeOrder START
    public boolean richiestaChangeOrder{get;set;}
    public boolean changeOrderInoltrato{get;set;}
    //End - 2018 - 05 - 21 ChangeOrder END
    public boolean attivazioneInserita{get;set;}
    public boolean cessazioneInserita{get;set;}
    public boolean sceltaRequest{get;set;}
    public boolean attivazioneInoltrata{get;set;}
    public boolean cessazioneInoltrata{get;set;}
    public EOF_EAI_Service_Log__C sl {get;set;}  
    public boolean DesospAnnullRimod {get;set;}
    public static Map<String,String> RTMap {get;set;} //EC 2019 - 03 - 28
    public static boolean checkRTMap {get; set;} //EC 2019 - 03 - 28
    
        
     
    
    public PO_OpenStreamService_Controller(){
        //setto tutte le variabili dei component a false
        attivazioneInserita=false;
        cessazioneInserita=false;
        richiestaAttivazione=false;
        richiestaCessazione=false;
        richiestaChangeOrder=false; //  //EC - 2018 - 05 -21 ChangeOrder
        VLAN=false;
        Apparato=false;
        ServizioAggiuntivo=false;
        sceltaRequest=false;
        attivazioneInoltrata=false;
        cessazioneInoltrata=false;
        DesospAnnullRimod=false;
        richiestaIdRisorsa=false;
        changeOrderInoltrato=false;
        PO_OpenStreamService_Controller.checkRTMap = false;
        
         //EC start 2019 - 03 - 28
    //     if(PO_OpenStreamService_Controller.RTMap==null){
    	// if(!PO_OpenStreamService_Controller.checkRTMap){
	      	PO_OpenStreamService_Controller.RTMap= rtMapCreation();
  //    	 }
//         }
        //EC end 2019 - 03 - 28
        //EC aggiunti a tutte le query i campi del case. 2019 04 03, se va bene ok, altrimenti cancella Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
        //check per service Log in bozza
            List<EOF_EAI_Service_Log__c> slList = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,
                                                    EOF_STATO_ORDINE__c, EOF_Codice_Operatore__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where EOF_Stato_Richiesta__c='Bozza' and 
                                                    ownerId=:userinfo.getUserId() and recordtype.developername='PO_SA_FiberRequest' order by createdDate desc];
        if(!slList.isEmpty()){
            sl=slList[0];   
        }                                       
        if(ApexPages.currentPage().getParameters().get('proc') =='insVLAN'){
            VLAN=true;
            
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='editVLAN'){
            VLAN=true;
            
        }
        
        else if(ApexPages.currentPage().getParameters().get('proc') =='insApp'){
            Apparato=true; 
            PO_COMP_InserimentoApparato_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,
                                                    EOF_STATO_ORDINE__c,Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where ID=:ApexPages.currentPage().getParameters().get('origId')];
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='editApparato'){
            Apparato=true; 
            PO_COMP_InserimentoApparato_Controller.idApparato=ApexPages.currentPage().getParameters().get('idApparato');
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='insServAgg'){ 
            ServizioAggiuntivo=true; 
            PO_COMP_InserimentoServAgg_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where ID=:ApexPages.currentPage().getParameters().get('origId')];
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='editServAgg'){
            ServizioAggiuntivo=true; 
            PO_COMP_InserimentoServAgg_Controller.idServAgg=ApexPages.currentPage().getParameters().get('idServAgg');
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='editAttivazione'){
            richiestaAttivazione=true;
            PO_COMP_RichiestaAttivazione_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where ID=:ApexPages.currentPage().getParameters().get('origId')];
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='editCessazione'){
            richiestaCessazione=true;
            PO_COMP_RichiestaCessazione_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where ID=:ApexPages.currentPage().getParameters().get('origId')];
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='confirmPageATT'){
            attivazioneInserita=true;
            PO_COMP_AttivazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')];
            
        }
         
        else if(ApexPages.currentPage().getParameters().get('proc') =='confirmPageCESS'){
            cessazioneInserita=true;
            PO_COMP_cessazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')];
            
        }
        
        else if(ApexPages.currentPage().getParameters().get('proc') =='attivazioneInserita'){
            attivazioneInserita=true;
            if(ApexPages.currentPage().getParameters().get('origId') !=null){
                PO_COMP_AttivazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')];
            }
            
        }
         
        else if(ApexPages.currentPage().getParameters().get('proc') =='cessazioneInserita'){
            cessazioneInserita=true;
            PO_COMP_cessazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')]; 
        }
        
        else if(ApexPages.currentPage().getParameters().get('proc') =='InserimentoRichiestaATT'){
            richiestaAttivazione=true;
        }
         else if(ApexPages.currentPage().getParameters().get('proc') =='InserimentoRichiestaCESS'){
            richiestaIdRisorsa=true;
        }
        //EC - 2018 - 05 - 21 START ChangeOrder
        else if(ApexPages.currentPage().getParameters().get('proc') =='reqChangeOrderInserita'){
            changeOrderInoltrato=true;
            PO_COMP_cessazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')]; 
        }
         else if(ApexPages.currentPage().getParameters().get('proc') =='InserimentoRichiestaCHANORD'){
            richiestaIdRisorsa=true;
        }   else if(ApexPages.currentPage().getParameters().get('proc') =='CHANORD'){
            richiestaChangeOrder=true;
        }else if(ApexPages.currentPage().getParameters().get('proc') =='CESS'){
            richiestaCessazione=true;
        }
        //EC - 2018 - 05 - 21 END  ChangeOrder
        else if(ApexPages.currentPage().getParameters().get('proc') =='successInsertCESS'){
            cessazioneInserita=true;
            PO_COMP_cessazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')]; 
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='errorInsertCESS'){
            cessazioneInserita=true; 
            PO_COMP_cessazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')]; 
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='successInsertATT'){
            attivazioneInserita=true;
            PO_COMP_attivazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')]; 
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='errorInsertATT'){
            attivazioneInserita=true;
            PO_COMP_attivazioneInserita_Controller.slOrig=[select id,recordtype.developername,EOF_Codice_Operatore__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c, 
                                                    EOF_STATO_ORDINE__c, Caso__r.OF_SA_Interfaccia_OM__c, Caso__r.Status
                                                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('origId')]; 
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='attivazioneInoltrata'
                || ApexPages.currentPage().getParameters().get('proc') =='errorDesosp'
                || ApexPages.currentPage().getParameters().get('proc') =='successDesosp'
                || ApexPages.currentPage().getParameters().get('proc') =='errorRimod'
                || ApexPages.currentPage().getParameters().get('proc') =='successRimod'
                || ApexPages.currentPage().getParameters().get('proc') =='errorAnnull'
                || ApexPages.currentPage().getParameters().get('proc') =='successAnnull'){
            attivazioneInoltrata=true;
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='cessazioneInoltrata'){    
            cessazioneInoltrata=true;
        }
        else if(ApexPages.currentPage().getParameters().get('proc') =='desospensione'
                || ApexPages.currentPage().getParameters().get('proc') =='rimodulazioneDAC'
                || ApexPages.currentPage().getParameters().get('proc') =='annullamento'){
            DesospAnnullRimod=true; 
        }
        
        /*
        else if(ApexPages.currentPage().getParameters().get('proc') =='ricInsCESS'){
            PO_COMP_cessazioneInserita_Controller.slOrig=sl;
            richiestaCessazione=true;
        } 
        */
        else{
            sceltaRequest=true;
        }
        
    }
    
    public static pagereference goTo(String to){
        PageReference pageRef = new PageReference('/partnercommunity/PO_OpenStreamService_InsertNewRequest');
        pageref.getParameters().put('proc',to);
        pageRef.setRedirect(true);
        return pageref;
    }
    
    //EC start 2019 - 03 - 28
    public static Map<String,String> rtMapCreation(){
		 
	        //vado a creare la mappa dei recordtype per poi utilizzarla
	    	PO_OpenStreamService_Controller.RTMap = new  map<String,String>();
	    	for(recordtype rt : [select id,developername from recordtype]){
	    		PO_OpenStreamService_Controller.RTMap.put(rt.developername,rt.id);
	    	}
	    	PO_OpenStreamService_Controller.checkRTMap=true;
    		return PO_OpenStreamService_Controller.RTMap;
    }
    //EC end 2019 - 03 - 28
    
    
}