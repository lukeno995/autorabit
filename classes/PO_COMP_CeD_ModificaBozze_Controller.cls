public class PO_COMP_CeD_ModificaBozze_Controller {
    
    public  EOF_EAI_Service_Log__c sl {get;set;}
    public static String idRisorsa{get;set;}
    public boolean verifyProfilo{get;set;}
    public boolean viewError{get;set;}
    public boolean viewProfilo{get;set;}
    public boolean errorCodOp {get;set;}
    public boolean errorID {get;set;}
    public boolean errorData {get;set;}
    public boolean errorNot {get;set;}
    public boolean errorCodO {get;set;}
    public string profiloCommerciale{get;set;}
    public string IDRis{get;set;}
    public string codiceOrdine{get;set;}
    public string dataNotifica{get;set;}
    public string idNotifica{get;set;}
    /*public string NomeReferente{get;set;}
    public string CognomeReferente{get;set;}
    public string TelefonoReferente{get;set;}
    public string EmailReferente{get;set;}
    public string TelefonoReferenteOperatore{get;set;}
    public string NomeCliente{get;set;}
    public string CognomeCliente{get;set;}
    public string RecapitoTelefonicoCliente1{get;set;}
    public string RecapitoTelefonicoCliente2{get;set;}
    public string InformazioniLogisticaApparati{get;set;}
    public string DataPrevistaAttivazione{get;set;}
    public string OrarioAppuntamento{get;set;}*/
    public string CodiceProgettoSpeciale{get;set;}
    public string Promozione{get;set;}
    public string ClusterPromozione{get;set;}
    public string Note{get;set;}
    /*public string IDBuilding{get;set;}
    public string ScalaPalazzina{get;set;}
    public string NumeroTelefonicoPrincipaleLinea{get;set;}
    public string RecapitoTestLinea{get;set;}
    public string IdentificativoDelPop{get;set;}*/
    public string Profilo{get;set;}


    public PO_COMP_CeD_ModificaBozze_Controller(){
        
        verifyProfilo = true; 
        viewError=false;
        viewProfilo=false;
        errorID=false;
        errorCodOp=false;
        errorData=false;
        errorNot=false;
        errorCodO=false;
        if(idRisorsa == null || String.isBlank(idRisorsa) ){
            idRisorsa = ApexPages.currentPage().getParameters().get('idRisorsa');
        }
        system.debug('*** id risorsa' + idRisorsa);
        sl=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
            EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
            EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
            EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
            EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
            EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c
            from EOF_EAI_Service_Log__c where id=:idRisorsa LIMIT 1];   
        
        System.debug('*** id risorsa ' + idRisorsa);
        System.debug('*** service log ' + sl);
    
        /*lw=new LogWrapper(); 
        lw.iDRisorsa=sl.EOF_ID_Risorsa__c;
        lw.nomeReferente=sl.EOF_NOME_REFERENTE_TECNICO_OLO__c;
        lw.cognomeReferente=sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c;
        lw.telefonoReferente=sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
        lw.emailReferente=sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
        lw.telefonoReferenteOperatore=sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c;
        lw.nomeCliente=sl.EOF_Nome_Cliente__c;
        lw.cognomeCliente=sl.EOF_COgnome_CLiente__c;
        lw.recapitoTelefonicoCliente1=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c;
        lw.recapitoTelefonicoCliente2=sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c;
        lw.informazioniLogisticaApparati=sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c;
        lw.dataPrevistaAttivazione=string.valueOfGmt(sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c);
        lw.orarioAppuntamento=sl.EOF_ORARIO_APPUNTAMENTO__c;
        lw.codiceProgettoSpeciale=sl.EOF_CODICE_PROGETTO_SPECIALE__c;
        lw.promozione=sl.EOF_PROMOZIONE__c;
        lw.clusterPromozione=sl.EOF_CLUSTER_PROMOZIONE__c;
        lw.note=sl.EOF_NOTE__c;
        lw.iDBuilding=sl.EOF_ID_BUILDING__c;
        lw.scalaPalazzina=sl.EOF_SCALA_PALAZZINA__c;
        lw.numeroTelefonicoPrincipaleLinea=sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c;
        lw.recapitoTestLinea=sl.EOF_RECAPITO_TEST_LINEA__c;
        lw.identificativoDelPop=sl.EOF_ID_Pop__c;
        lw.profilo=sl.EOF_PROFILO__c;
        lw.profiloCommerciale=sl.EOF_PROFILO__c;*/
    }
    
    public PageReference AggiornaCO()
    {
        if(!verifyFields()){
            return null;
        }           

        //sl.EOF_ID_Risorsa__c=IDRis;
        sl.EOF_Codice_Ordine_OLO__c=codiceOrdine;
        //sl.EOF_Data_Notifica__c=Datetime.valueOfGmt(dataNotifica);
        sl.EOF_Data_Notifica__c= null;
        sl.EOF_ID_Notifica__c=null;
        //sl.EOF_ID_Notifica__c=idNotifica;
        /*sl.EOF_NOME_REFERENTE_TECNICO_OLO__c=NomeReferente;
        sl.EOF_COGNOME_REFERENTE_TECNICO_OLO__c=CognomeReferente;
        sl.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c=TelefonoReferente;
        sl.EOF_EMAIL_REFERENTE_TECNICO_OLO__c=EmailReferente;
        sl.EOF_TELEFONO_REFERENTE_OLO_ONFIELD_NOTEC__c=TelefonoReferenteOperatore;
        sl.EOF_Nome_Cliente__c=NomeCliente;
        sl.EOF_COgnome_CLiente__c=CognomeCliente;
        sl.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c=RecapitoTelefonicoCliente1;
        sl.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c=RecapitoTelefonicoCliente2;
        sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c=InformazioniLogisticaApparati;
        sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c=Date.parse(DataPrevistaAttivazione);
        sl.EOF_ORARIO_APPUNTAMENTO__c=OrarioAppuntamento;*/
        sl.EOF_CODICE_PROGETTO_SPECIALE__c=CodiceProgettoSpeciale;
        sl.EOF_PROMOZIONE__c=Promozione;
        sl.EOF_CLUSTER_PROMOZIONE__c=ClusterPromozione;
        sl.EOF_NOTE__c=Note;
        /*sl.EOF_ID_BUILDING__c=IDBuilding;
        sl.EOF_SCALA_PALAZZINA__c=ScalaPalazzina;
        sl.EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c=NumeroTelefonicoPrincipaleLinea;
        sl.EOF_RECAPITO_TEST_LINEA__c=RecapitoTestLinea;
        sl.EOF_ID_Pop__c=IdentificativoDelPop;*/
        sl.EOF_PROFILO__c=Profilo;   

        update sl;
        PageReference pageRef = new PageReference('/PO_CeD_DettaglioBozze');
        pageRef.getParameters().put('idRisorsa',ApexPages.currentPage().getParameters().get('idRisorsa'));
        system.debug('***** slog aggiornato order!! ' + sl);
        return pageRef; 
    }
    
    public PageReference goBackward (){         
        //PageReference pg = new PageReference('/PO_OF_DetailBozze');
        //pg.getParameters().put('idRisorsa',ApexPages.currentPage().getParameters().get('idRisorsa'));
        
        Id assetId = [SELECT Id 
                      FROM Asset 
                      WHERE Name = :sl.EOF_ID_Risorsa__c
                      AND Status = 'Attivo' 
                      LIMIT 1].Id;

        //MOD AA 21/06 
        if (ApexPages.currentPage().getParameters().get('proc') != null && ApexPages.currentPage().getParameters().get('proc').equalsIgnoreCase('newBozza') ) {
            delete sl;
        }
        if (ApexPages.currentPage().getParameters().get('goto') != null && !String.isBlank(ApexPages.currentPage().getParameters().get('goto')) ) {
            PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('goto'));
            return pg;
        }else{
            PageReference pg = new PageReference('/PO_DetailChange_CeD');
            pg.getParameters().put('origId',assetId);
            return pg; 
        }
    }

    public boolean verifyProfiloNew(String TextProfilo) {
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
      
        If(objListino != null /*&& objListino.IsPortalValid__c==true*/ && objListino.PO_CD_Profilo_Commerciale__c!=null){
            verifyProfilo = true;
        }else{
            verifyProfilo = false;
        }      
        system.debug('verifyProfiloNewGB'+verifyProfilo);   
        system.debug('***** verifyProfilo '+ verifyProfilo);
        return verifyProfilo;
    }

    public PageReference runSearchProfilo() 
    {
        viewProfilo=true;
        String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');  
        system.debug('***** runsearch '+ TextProfilo);
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
    	If(objListino != null /*&& objListino.IsPortalValid__c==true*/ && objListino.PO_CD_Profilo_Commerciale__c!=null){
    		profiloCommerciale=(string)objListino.PO_CD_Profilo_Commerciale__c; 
    	}else{
    		profiloCommerciale= 'N/A';  		
    	}
        //profiloCommerciale ='TEST 2 TEST';
        system.debug('***** runsearch PC '+ profiloCommerciale);
        viewError=false; 
        
        return null;
      }

      public boolean verifyFields(){

          if(!verifyProfiloNew(Profilo)){
            viewError=true;
            viewProfilo=false;
            system.debug('**verifyProfilo '+viewError+' , '+viewProfilo );                  
        }else{
            viewError=false;
        }
        if( codiceOrdine=='' || codiceOrdine==null){
            errorCodO=true;
            
        }else{
            errorCodO=false;
        }

        if(errorID || errorData || errorNot || errorCodO || viewError){
            system.debug('entrato... qualche campo non validato viewProfilo '+viewProfilo + ' viewError'+viewError);
            return false;
        }
        else{
            return true;
        }
    }
    
    public class LogWrapper{
        public String iDRisorsa{get;set;}
        public String nomeReferente{get;set;}
        public String cognomeReferente{get;set;}
        public String telefonoReferente{get;set;}
        public String emailReferente{get;set;}
        public String telefonoReferenteOperatore{get;set;}
        public String nomeCliente{get;set;}
        public String cognomeCliente{get;set;}
        public String recapitoTelefonicoCliente1{get;set;}
        public String recapitoTelefonicoCliente2{get;set;}
        public String informazioniLogisticaApparati{get;set;}
        public String dataPrevistaAttivazione{get;set;}
        public String orarioAppuntamento{get;set;}
        public String codiceProgettoSpeciale{get;set;}
        public String promozione{get;set;}
        public String clusterPromozione{get;set;}
        public String note{get;set;}
        public String iDBuilding{get;set;}
        public String scalaPalazzina{get;set;}
        public String numeroTelefonicoPrincipaleLinea{get;set;}
        public String recapitoTestLinea{get;set;}
        public String identificativoDelPop{get;set;}
        public String profilo{get;set;}
        public String profiloCommerciale{get;set;}
        
        public LogWrapper(){}
    }
}