public with sharing class PO_OF_DetailBozze_Controller {
public List<EOF_EAI_Service_Log__c> SlVLAN{get;set;}
public boolean VLAN {get;set;}
public List<EOF_EAI_Service_Log__c> slList{get;set;} 
public EOF_EAI_Service_Log__c slOrig{get;set;}
public String idVLAN  {get;set;}
public String idRisorsa  {get;set;}
public List<BozzaDetailWrapper> listaWrapper {get;set;}
public boolean verifyProfilo{get;set;}
public boolean viewError{get;set;}
public boolean viewProfilo{get;set;}
public boolean errorCodOp {get;set;}
public boolean errorID {get;set;}
public boolean errorData {get;set;}
public boolean errorNot {get;set;}
public boolean errorCodO {get;set;}
public boolean errorKIT {get;set;}
public boolean errorUSER {get;set;}
public boolean errorSERVICE {get;set;}
public boolean errorPROFILO {get;set;}
public boolean errorCUSTOMER {get;set;}
public boolean errorMODELLODS {get;set;}
public boolean errorINFO {get;set;}
//Check errore Sync
public boolean errorSync{get;set;}
//Stringa errore Sync
public String syncErrorMsg {get;set;}
public string Kit{get;set;}

    public PO_OF_DetailBozze_Controller() {
        errorSync = false;
        verifyProfilo = true;			
        viewError=false;
        viewProfilo=false;
        errorID=false;
        errorCodOp=false;
        errorData=false;
        errorNot=false;
        errorCodO=false;
        VLAN=false;
        errorKIT=false;
        errorUSER=false;
        errorSERVICE=false;
        errorPROFILO=false;
        errorCUSTOMER=false;
        errorMODELLODS=false;
        errorINFO=false;
        
      //  if(!test.isRunningTest()){
            
        idRisorsa=ApexPages.currentPage().getParameters().get('idRisorsa');
        
        slOrig = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,OF_SA_USER_VLAN__c,OF_SA_KIT_CONSEGNA_VLAN__c,
                    OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c
                    from EOF_EAI_Service_Log__c where id=:idRisorsa]; 
     //   }
        slList = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,
                    OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,
                    OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c
                    from EOF_EAI_Service_Log__c where recordtype.developername='OF_SA_Vlan' and OF_SA_VLan_Log__c=:idRisorsa and
                    EOF_Stato_Richiesta__c='Bozza Portale' ];
                                                  
        
        if(!slList.isEmpty()){
            SlVLAN=new List<EOF_EAI_Service_Log__c>();
            listaWrapper= new List<BozzaDetailWrapper>();
            for(EOF_EAI_Service_Log__c slAgg : slList){
                if(slAgg.recordtype.developername=='OF_SA_Vlan'){
                    BozzaDetailWrapper temp= new BozzaDetailWrapper();
                    temp.kitConsegna=slAgg.OF_SA_KIT_CONSEGNA_VLAN__c;
                    temp.service=slAgg.OF_SA_SERVICE_VLAN__c;
                    temp.customer=slAgg.OF_SA_CUSTOMER_VLAN__c;
                    temp.informazioni=slAgg.OF_SA_INFORMAZIONI_VLAN__c;
                    temp.user=slAgg.OF_SA_USER_VLAN__c;
                    temp.profilo=slAgg.OF_SA_PROFILO_VLAN__c; 
                    temp.modelloServizio=slAgg.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
                    temp.id=slAgg.Id;
                    listaWrapper.add(temp);                 
                    VLAN=true;
                }
            }
        }
    }

    public PageReference cessaVLAN (){
        EOF_EAI_Service_Log__c sl = [select id from EOF_EAI_Service_Log__c where id=:idVLAN];
        delete sl;
        PageReference pg = new PageReference('/PO_OF_DetailBozze');
        pg.getParameters().put('idRisorsa',idRisorsa);
        return pg;    
    }

    public PageReference modificaVLAN (){       
        
        PageReference pg = new PageReference('/PO_LA_ModificaVLAN');
        pg.getParameters().put('IdVLAN', idVLAN);
        system.debug('*** idVLAN: '+ idVLAN);
        pg.getParameters().put('Mode','mod');
        pg.getParameters().put('idRisorsa',idRisorsa);
        system.debug('*** idRisorsa: '+ idRisorsa);
        return pg;
    }

    public PageReference aggiungiVLAN (){
        PageReference pg = new PageReference('/PO_LA_ModificaVLAN');
        pg.getParameters().put('idRisorsa',idRisorsa);
        pg.getParameters().put('Mode','ins');
        return pg;
    }
    
    public PageReference changeOrder (){
        
        PageReference pg = new PageReference('/PO_LA_ModificaBozze');
        pg.getParameters().put('idRisorsa',idRisorsa);  
        pg.getParameters().put('goto', 'PO_OF_DetailBozze?idRisorsa='+idRisorsa);
        /*pg.getParameters().put('Id',IdVLAN);
        pg.getParameters().put('Mode','mod');*/
        return pg;
        
    }
    
    public PageReference redirectRichiesteInserite(){
        PageReference pg = new PageReference('/PO_OpenStream_DisplayRequest');
        return pg;
    }
    
    public PageReference inoltraChangeOrder (){
        System.debug('***** INSIDE INOLTRA CHANGE ORDER!!!');
        //Done AA: Richiamare OF_CO_OLO_EntryChecks.PortalSync
        //Simuliamo l'oggetto della request del ws
        OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request changeOrd = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.OLO_ChangeSetup_OpenStream_Request();
        
        changeOrd.CODICE_OPERATORE = slOrig.EOF_CODICE_OPERATORE__c;
        changeOrd.CODICE_ORDINE_OLO = slOrig.EOF_Codice_Ordine_OLO__c;
        changeOrd.DATA_NOTIFICA = OF_CO_GE_Utils.dateToString(System.now());
        changeOrd.ID_NOTIFICA = String.valueOf(System.now().getTime());
        changeOrd.ID_RISORSA = slOrig.EOF_Id_Risorsa__c;
        changeOrd.CODICE_PROGETTO_SPECIALE = slOrig.EOF_CODICE_PROGETTO_SPECIALE__c;
        changeOrd.PROMOZIONE = slOrig.EOF_PROMOZIONE__c;
        changeOrd.CLUSTER_PROMOZIONE = slOrig.EOF_CLUSTER_PROMOZIONE__c;
        changeOrd.NOTE = slOrig.EOF_NOTE__c;
        changeOrd.PROFILO = slOrig.EOF_PROFILO__c;
        //Creazione delle vlan
        changeOrd.VLAN = new List<OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN>();
        if(listaWrapper != null){
            for (BozzaDetailWrapper vlan : listaWrapper){
                OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN vl = new OF_CO_WS_IN_OLO_ChangeSetup_OpenStream.VLAN();
                    vl.KIT_CONSEGNA_VLAN = vlan.kitConsegna;
                    vl.USER_VLAN = vlan.user;
                    vl.SERVICE_VLAN = vlan.service;
                    vl.PROFILO_VLAN = vlan.profilo;
                    vl.CUSTOMER_VLAN = vlan.customer;
                    vl.MODELLO_DI_SERVIZIO_VLAN = vlan.modelloServizio;
                    vl.INFORMAZIONI_VLAN = vlan.informazioni;

                changeOrd.VLAN.add(vl);
            }
        }
        //Richiamo al metodo di check sync
        slOrig = OF_CO_OLO_EntryChecks.PORTAL_SyncChecksChangeSetup(changeOrd, slOrig);
        if(slOrig.EOF_STATO_Ordine__c != 'error'){ 
            //Creo la lista di sLog che andrò ad aggiornare
            List<EOF_EAI_Service_Log__C> slToUpdate = new List<EOF_EAI_Service_Log__C>();
            //Ciclo le vlan e setto i nuovi valori
            for(EOF_EAI_Service_Log__c slV : SlVLAN){
                slv.EOF_Stato_Richiesta__c='Inserita Portale';
                slToUpdate.add(slV);
            }
            //Setto i valori al sLog originale
            slOrig.EOF_Stato_Richiesta__c='Inserita Portale';
        	slOrig.EOF_DATA_NOTIFICA__c=OF_SA_GE_Utils.StringToDate(changeOrd.DATA_NOTIFICA);
        	slOrig.EOF_ID_NOTIFICA__c=changeOrd.ID_NOTIFICA;
            //Aggiungo il sLog originale alla lista da aggiornare
        	slToUpdate.add(slOrig);
            //Aggiorno la lista di sLog modificati
        	update slToUpdate;
            errorID = false;
            //Restituisco la pagina di richieste inserite
            //PageReference pg = new PageReference('/PO_OpenStream_DisplayRequest');
            return null;
        }else{//Caso di errore nei check syncroni
            errorID = true;        
            //Stringa errore Sync
            syncErrorMsg = 'Errore! ' + slOrig.EOF_MOTIVAZIONE__c;
            return null;
        }
        /*if(!verifyFields()){
				return null;
			}	
        system.debug('*****Changeorder Orig'+slOrig);
        system.debug('*****Changeorder ListaVLAN'+slList);

        Case c = new Case();

        if(!OF_CO_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_CO_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_CO_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_CO_GE_Utils.checkRTMap=true;
        } 

        c.RecordTypeId=OF_CO_GE_Utils.rtMap.get('EOF_Caso_ChangeOrder_OPENSTREAM');
        c.EOF_Codice_Operatore_WS__c = slOrig.EOF_Codice_Operatore__c;            
        c.EOF_Codice_Ordine_OLO__c = slOrig.EOF_Codice_Ordine_OLO__c;
        c.EOF_Data_Notifica__c = slOrig.EOF_Data_Notifica__c;
        c.EOF_Id_Notifica__c = slOrig.EOF_ID_Notifica__c;  
        c.EOF_Id_Risorsa__c = slOrig.EOF_ID_Risorsa__c;
        c.OF_SA_CODICE_PROGETTO_SPECIALE__c = slOrig.EOF_CODICE_PROGETTO_SPECIALE__c;
        c.OF_SA_Promozione__c = slOrig.EOF_PROMOZIONE__c;
        c.OF_SA_Cluster_Promozione__c = slOrig.EOF_CLUSTER_PROMOZIONE__c;

        if(slOrig.EOF_NOTE__c!=null && string.isnotblank(slOrig.EOF_NOTE__c)){
            c.EOF_Note__c = slOrig.EOF_NOTE__c.abbreviate(255);
        }else{
            c.EOF_Note__c = slOrig.EOF_NOTE__c;
        }

        c.OF_SA_Profilo__c = slOrig.EOF_PROFILO__c;
        c.subject='Richiesta Change Order';
        c.status='Inviato';
        c.EOF_FASE__C='NA';
        c.PO_SA_Portale__c=true;
        insert c;
        system.debug('******case c '+c);

        
        List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();

        Id vlanCEId = [SELECT Id FROM OF_CommercialElement__c where OF_Servizio__r.Name='Open Stream' AND Name='VLAN' LIMIT 1].Id;
            system.debug('vlanCEId======='+vlanCEId);//Added by Sasya to test the test record insertion.
        //Ciclo la lista di vlan della request e li aggiungo alla lista di VLAN
        system.debug('******* vlan list'+ listaWrapper);
        
        for (BozzaDetailWrapper vlan :listaWrapper){
            OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
            cei.recordtypeid=OF_CO_GE_Utils.rtMap.get('OF_VLAN');
            //Info sulla vlan                       
            cei.OF_KITCONSEGNAVLAN__C = vlan.kitConsegna;  
            cei.OF_USERVLAN__C = vlan.user;
            cei.OF_SERVICEVLAN__C = vlan.service;                
            cei.OF_PROFILOVLAN__C = vlan.profilo;
            cei.OF_CUSTOMERVLAN__C = vlan.customer;
            cei.OF_MODELLODISERVIZIOVLAN__C = vlan.modelloServizio;
            cei.OF_INFORMAZIONIVLAN__C = vlan.informazioni;
            //Lego le VLAN al Case
            cei.OF_Case__c = c.Id;
            cei.OF_SA_VLAN__c = c.Id;
            //Imposto il CEI di tipologia VLAN
            cei.OF_CommercialElement__c = vlanCEId;
            
            ceiList.add(cei);
        }
        // Controllo se la lista è popolata
        if(!ceiList.isEmpty()){
            system.debug('****** ceiList '+ceiList);
            insert ceiList;
        }   

        OM_CreateAckNackRequestActivation(String.valueOf(c.id), ApexPages.currentPage().getParameters().get('idRisorsa'));

        return null;*/
    }

    public boolean verifyProfiloNew(String TextProfilo) {
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
      
        If(objListino != null && objListino.IsPortalValid__c==true){
            verifyProfilo = true;
        }else{
            verifyProfilo = false;
        }      
        system.debug('verifyProfiloNewGB'+verifyProfilo);   
		system.debug('***** verifyProfilo '+ verifyProfilo);
        return verifyProfilo;
    }

    public boolean verifyFields(){
        for (EOF_EAI_Service_Log__c itm : slList){
            slOrig.OF_SA_KIT_CONSEGNA_VLAN__c=itm.OF_SA_KIT_CONSEGNA_VLAN__c;
            slOrig.OF_SA_USER_VLAN__c=itm.OF_SA_USER_VLAN__c;
            slOrig.OF_SA_SERVICE_VLAN__c=itm.OF_SA_SERVICE_VLAN__c;
            slOrig.OF_SA_PROFILO_VLAN__c=itm.OF_SA_PROFILO_VLAN__c;
            slOrig.OF_SA_CUSTOMER_VLAN__c=itm.OF_SA_CUSTOMER_VLAN__c;
            slOrig.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c=itm.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
            slOrig.OF_SA_INFORMAZIONI_VLAN__c=itm.OF_SA_INFORMAZIONI_VLAN__c;
            
            if(slOrig.OF_SA_KIT_CONSEGNA_VLAN__c==null || string.isblank(slOrig.OF_SA_KIT_CONSEGNA_VLAN__c) 
                || slOrig.OF_SA_KIT_CONSEGNA_VLAN__c.length()>10){
                    
                errorKIT=true;
                return false;
            }else{
			    errorKIT=false;
            }
            
            if( slOrig.OF_SA_USER_VLAN__c==null || string.isblank(slOrig.OF_SA_USER_VLAN__c) || slOrig.OF_SA_USER_VLAN__c.length()>4){
                errorUSER=true;
                return false;
			}else{
				errorUSER=false;
			}

            if(slOrig.OF_SA_SERVICE_VLAN__c==null || string.isblank(slOrig.OF_SA_SERVICE_VLAN__c) || slOrig.OF_SA_SERVICE_VLAN__c.length()>4){
                errorSERVICE=true;
                return false;
			}else{
			    errorSERVICE=false;
			}

            if(slOrig.OF_SA_PROFILO_VLAN__c==null || string.isblank(slOrig.OF_SA_PROFILO_VLAN__c) || slOrig.OF_SA_PROFILO_VLAN__c.length()>4){
                errorPROFILO=true;
                return false;
			}else{
				errorPROFILO=false;
			}
            
            if(!string.isblank(slOrig.OF_SA_CUSTOMER_VLAN__c)){
                if(slOrig.OF_SA_CUSTOMER_VLAN__c.length()>4){
                    errorCUSTOMER=true;
                    return false;
                }
			}else{
				errorCUSTOMER=false;
            }

            if(!string.isblank(slOrig.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c)){
                if(slOrig.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c.length()>4){
                    errorMODELLODS=true;
                    return false;
                }
			}else{
			    errorMODELLODS=false;
            }

            if(!string.isblank(slOrig.OF_SA_INFORMAZIONI_VLAN__c)){
                if(slOrig.OF_SA_INFORMAZIONI_VLAN__c.length()>255){ 
                    errorINFO=true;
                    return false;
                }
			}else{
				errorINFO=false;
            }
        }

        if(!verifyProfiloNew(slOrig.EOF_PROFILO__c)){
    	    viewError=true;
            viewProfilo=false;
			system.debug('**verifyProfilo '+viewError+' , '+viewProfilo );           		
		}else{
			viewError=false;
		}
 
        if( slOrig.EOF_ID_Risorsa__c=='' || slOrig.EOF_ID_Risorsa__c==null){
            errorID=true;
            system.debug('****ID '+ errorID );
        }else{
            errorID=false;
        }

        if( slOrig.EOF_Codice_Operatore__c=='' || slOrig.EOF_Codice_Operatore__c==null){
            errorCodOp=true; 
        }else{
            errorCodOp=false;
        }
        if(slOrig.EOF_Data_Notifica__c==null){
            errorData=true;
        }else{ 
            errorData=false;
        }

        if( slOrig.EOF_ID_Notifica__c=='' || slOrig.EOF_ID_Notifica__c==null){
            errorNot=true;
        }else{
            errorNot=false;
        }
        if( slOrig.EOF_Codice_Ordine_OLO__c=='' || slOrig.EOF_Codice_Ordine_OLO__c==null){
            errorCodO=true;
        }else{
            errorCodO=false;
        }

        if(errorID || errorCodOp || errorData || errorNot || errorCodO || viewError || errorINFO || errorMODELLODS || errorCUSTOMER || errorPROFILO || errorSERVICE || errorUSER || errorKIT ){
            system.debug('entrato... qualche campo non validato viewProfilo '+viewProfilo + ' viewError'+viewError);
            return false;
        }
        else{
            return true;
        }
    }

    public class BozzaDetailWrapper{
        public String kitConsegna{get;set;}
        public String service{get;set;}
        public String customer{get;set;}
        public String informazioni{get;set;}
        public String user{get;set;}
        public String profilo{get;set;}
        public String modelloServizio{get;set;}
        public String id{get;set;}

        public BozzaDetailWrapper(){}
    }
    /*@future (callout=true)
    public static void OM_CreateAckNackRequestActivation (String caseId, String idRisorsa){
        //Recupero il case avente tutte le info della request
        Case c = [SELECT Id,Codice_Ordine_EOF__c,EOF_Codice_Operatore_WS__c, EOF_Codice_Ordine_OLO__c, EOF_Data_Notifica__c, EOF_Id_Notifica__c, EOF_Id_Risorsa__c, OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c    
                          FROM Case
                          WHERE Id = :caseId 
                          LIMIT 1];
        //Vado a recuperarmi l'id servizio dal case di attivazione
        Case caseAttivazione = [Select Id,OF_SA_ID_Servizio__c, RecordType.Name, RecordType.DeveloperName, Status, Asset.Name
                              FROM Case
                              WHERE RecordType.Name = 'EOF_Caso_Attivazione_OPENSTREAM'
                              AND RecordType.DeveloperName = 'OF_SA_Attivazione'
                              AND Status = 'Espletato'
                              AND Asset.Name =:c.EOF_Id_Risorsa__c LIMIT 1];
        //Recupero la lista di VLAN richieste dall'utente
        //Done AA: Farsi passare lista VLAN
        List<OF_CommercialElementIstanziato__c> listVLANToMap = [SELECT OF_KITCONSEGNAVLAN__C, OF_USERVLAN__C, OF_SERVICEVLAN__C, OF_PROFILOVLAN__C, OF_CUSTOMERVLAN__C, OF_MODELLODISERVIZIOVLAN__C, OF_INFORMAZIONIVLAN__C
                                                                 FROM OF_CommercialElementIstanziato__c
                                                                 WHERE OF_Case__c = :caseId];


         GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element wsInput = new GW_ChangeSetupOpenStream_Input.ChangeSetupOpenStreamOM_element();
            wsInput.TIPO_COMUNICAZIONE = '15';
            wsInput.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
            wsInput.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
            wsInput.CODICE_ORDINE_OF = c.Codice_Ordine_EOF__c;
            wsInput.DATA_NOTIFICA = c.EOF_Data_Notifica__c;
            wsInput.ID_NOTIFICA = c.EOF_Id_Notifica__c;
            wsInput.ID_RISORSA = c.EOF_Id_Risorsa__c;
            wsInput.CODICE_PROGETTO_SPECIALE = c.OF_SA_CODICE_PROGETTO_SPECIALE__c;
            wsInput.PROMOZIONE = c.OF_SA_Promozione__c;
            wsInput.CLUSTER_PROMOZIONE = c.OF_SA_Cluster_Promozione__c;
            wsInput.NOTE = c.EOF_Note__c;
            //Done AA: Recuperare id servizio
            wsInput.ID_SERVIZIO = caseAttivazione.OF_SA_ID_Servizio__c;
            wsInput.PROFILO = c.OF_SA_Profilo__c;
            wsInput.VLAN = mapVLAN(listVLANToMap);
        
        //Variabile esito chiamata
        GW_ChangeSetupOpenStream_Response.Esito_element respTemp = new GW_ChangeSetupOpenStream_Response.Esito_element();
        //aggiungo il metodo di ACK finto per riallineare SF in caso di exception per locked row
        if(OF_CO_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
            respTemp.Esito='0';
            //resetto il campo a false per evitare problemi successivi
            OF_CO_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c=false;
        }
        else{ 
            //Done AA: Sostituire la chiamata dal vecchio servizio, al nuovo servizio!!
            //inserire qui la logica della calllout asincrona all'olo e da li l'inoltro a OM
            GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1 stub = new GW_ChangeSetupOpenStream.ChangeSetupOpenStreamPortTypeEndpoint1();           
            //set timeout
            stub.timeout_x = 30000;
            //Done AA: richiamare metodo nuovo
            respTemp = stub.ChangeSetupOpenStream(wsInput);
        }
        //Done AA: Gestire ACK
        if(respTemp.Esito=='0'){
            //aggiungo la ricezione dell'ACK sul service Log della notifica all'OLO
            /*OF_CO_GE_Utils.slSFOM.OF_SA_ACK__c=true;
            OF_CO_GE_Utils.slSFOM.EOF_Response__C='ACK';
            
            //setto l'ACK sul case
            c.OF_Response_Da_OM__c='ACK';  
            
            OF_CO_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OM - ACK - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_ChangeSetup_OpenStream_Request',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - ACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                EOF_Codice_Ordine_Olo__c = c.EOF_Codice_Ordine_OLO__c,
                EOF_Data_Notifica__c = c.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'OK',
                //Done AA: va bene l'id notifica della response?
                EOF_ID_NOTIFICA__C = respTemp.ID_NOTIFICA,
                OF_SA_ESITO__C = respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
                EOF_Retry__c = OF_CO_GE_Utils.retry,
                OF_SA_ACK__c = true  
            ); 
        } 
        //Done AA: Gestire NACK con retry
        else{
            //aggiungo la ricezione del NACK sul service Log dell'inoltro ad OM
            /*OF_CO_GE_Utils.slSFOM.OF_SA_ACK__c=false;
            OF_CO_GE_Utils.slSFOM.EOF_Response__C='NACK';
            OF_CO_GE_Utils.slSFOM.EOF_Codice_errore__c=respTemp.CODICE_MOTIVAZIONE;

           //setto il NACK sul case
           if(respTemp.CODICE_MOTIVAZIONE=='A00' || respTemp.CODICE_MOTIVAZIONE=='A04' || respTemp.CODICE_MOTIVAZIONE=='100' || respTemp.CODICE_MOTIVAZIONE=='200'){
                c.OF_Response_Da_OM__c='NACK TECNICO';
           }
           else{
                c.OF_Response_Da_OM__c='NACK';
           } 
            OF_CO_GE_Utils.slSFOMResp = new EOF_EAI_Service_Log__c(
                EOF_Tipo_comunicazione_String__c='SF->OM - NACK - ChangeOrderRequest',
                OF_SA_Direzione_Flusso__c='SF-OM',
                OF_SA_Metodo__c='OLO_ChangeSetup_OpenStream_Request',
                Caso__c = c.Id,
                RecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - CO - NACK').getRecordTypeId(),                                        
                EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                EOF_Codice_Ordine_Olo__c = c.EOF_Codice_Ordine_OLO__c,
                EOF_Data_Notifica__c = c.EOF_Data_Notifica__c,
                EOF_Stato_Richiesta__c = 'KO',
                //Done AA: va bene l'id notifica della response?
                EOF_ID_NOTIFICA__C = respTemp.ID_NOTIFICA,
                OF_SA_ESITO__C = respTemp.ESITO,
                EOF_CODICE_MOTIVAZIONE__C = respTemp.CODICE_MOTIVAZIONE, 
                EOF_MOTIVAZIONE__C = respTemp.MOTIVAZIONE,
                EOF_Retry__c = OF_CO_GE_Utils.retry,
                OF_SA_ACK__c = false
            );
        }
        //LOGGO LA REQUEST 
        OF_CO_GE_Utils.create_EAI_Log(wsInput);
        //Inserisco il log
        insert OF_CO_GE_Utils.slSFOMResp;         

        if(respTemp.Esito=='0'){           

           EOF_EAI_Service_Log__c slOrig=[select id,EOF_Stato_Richiesta__c from EOF_EAI_Service_Log__c where id=:idRisorsa]; 
            
            List<EOF_EAI_Service_Log__c> slList = [select id from EOF_EAI_Service_Log__c where recordtype.developername='OF_SA_Vlan' and OF_SA_VLan_Log__c=:idRisorsa and
                                                    EOF_Stato_Richiesta__c='Bozza Portale' ];
            
               
                slOrig.EOF_Stato_Richiesta__c = 'Inserita Portale';
                //delete slList;                                    
                //delete slOrig;
                
            }
            
    }

    private static List<GW_ChangeSetupOpenStream_Input.VLAN_element> mapVLAN(List<OF_CommercialElementIstanziato__c> listVLANToMap){
        //Creo la lista che restituirò
        List<GW_ChangeSetupOpenStream_Input.VLAN_element> wsVLANList = new List<GW_ChangeSetupOpenStream_Input.VLAN_element>();
        //Setto i valori nella nuova lista
        for(OF_CommercialElementIstanziato__c vlan : listVLANToMap){
            GW_ChangeSetupOpenStream_Input.VLAN_element vlanToAdd = new GW_ChangeSetupOpenStream_Input.VLAN_element();
                vlanToAdd.KIT_CONSEGNA_VLAN = vlan.OF_KITCONSEGNAVLAN__C;
                vlanToAdd.USER_VLAN = vlan.OF_USERVLAN__C;
                vlanToAdd.SERVICE_VLAN = vlan.OF_SERVICEVLAN__C;
                vlanToAdd.PROFILO_VLAN = vlan.OF_PROFILOVLAN__C;
                vlanToAdd.CUSTOMER_VLAN = vlan.OF_CUSTOMERVLAN__C;
                vlanToAdd.MODELLO_DI_SERVIZIO_VLAN = vlan.OF_MODELLODISERVIZIOVLAN__C;
                vlanToAdd.INFORMAZIONI_VLAN = vlan.OF_INFORMAZIONIVLAN__C;
            wsVLANList.add(vlanToAdd);
        }
        return wsVLANList;
    }*/
}