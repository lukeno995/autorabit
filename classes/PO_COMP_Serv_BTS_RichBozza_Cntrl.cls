public class PO_COMP_Serv_BTS_RichBozza_Cntrl {
    
    public boolean showPagBozze{get;set;}
    public boolean showPag{get;set;}
    public String offertaRecord{get;set;}
    public User attuale {get; set;} 
    
    public List<EOF_EAI_Service_Log__c> fattLogBozzaList {get;set;}
    public List<EOF_EAI_Service_Log__c> collLogBozzaList {get;set;}
    public EOF_EAI_Service_Log__c parentLog {get;set;}
    //public List<Case> ordCaseList {get;set;}
    public String parentLogId{get;set;}
    public String collLogId{get;set;}
    
    public Decimal pageRecord{get;set;}
    public Integer offset_page{get;set;}
    public Decimal totpg{get;set;} 
    public boolean showRow{get;set;} 
    public Integer totRec{get;set;} 
    
    
    public Integer totalRecord{get;set;}    
    public Integer pageActual{get;set;}
    public Decimal totalpage{get;set;}
    public Integer totalRecordBozze{get;set;}    
    public Integer pageActualBozze{get;set;}
    public Decimal totalpageBozze{get;set;}
    
    public list<attachment> attlst {get;set;}
    public list<attachment> newAtt {get;set;}
    public list<attachment> attxlxs {get;set;}  
    
    //Costruttore.
    public PO_COMP_Serv_BTS_RichBozza_Cntrl(){
        
    totalRecord=0; 
    pageActual=0;
    pageRecord=5; 
    totalpage=0; 
    showRow=true;
    Integer off=0;
    parentLogId=''; 
        
    offertaRecord='BTS';
    showPagBozze=false;
    showPag=false;
    
    attuale=[select Id,AccountId,Account.EOF_Codice_Operatore__c,
                    ContactId,Contact.AccountId 
                    from user 
                    where Id=:userinfo.getUserId()];
    
    fattLogBozzaList=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,Name,
                          OwnerId,CreatedDate,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,
                          PO_Nome_Progetto__c, PO_Offerta__c,EOF_Codice_Operatore__c,
                          PO_SA_Data_Inserimento_Ordine__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,
                          EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                          EOF_Telefono_Referente_OLO_Onfield_Notec__c,
                          EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,EOF_Nome_Cliente__c,
                          EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                          EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,
                          EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                          EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,
                          EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                          EOF_RECAPITO_TEST_LINEA__c,EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,
                          OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,
                          OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,
                          EOF_TIPOLOGIA_APPARATO__c,OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c,
                          OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                          EOF_Tipo_Comunicazione_String__c,EOF_GPON_Attestazione__c
                          from EOF_EAI_Service_Log__c
                          where recordType.developerName='PO_Log_BTS_Request'
                          AND EOF_Stato_Richiesta__c='Bozza'
                          AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c
                          AND PO_Offerta__c=:offertaRecord
                          ORDER BY CreatedDate DESC
                          LIMIT:(integer)pageRecord  OFFSET :off];
        
                        showPagBozze=(!fattLogBozzaList.isEmpty())?true:false;
                        showPag=(!fattLogBozzaList.isEmpty())?true:false;
                if(parentLogId!=null && parentLogId!=''){       
                        parentLog=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,Name,
                                OwnerId,CreatedDate,EOF_Stato_Richiesta__c,EOF_STATO_ORDINE__c,
                                PO_Nome_Progetto__c, PO_Offerta__c,EOF_Codice_Operatore__c,
                                PO_SA_Data_Inserimento_Ordine__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c
                                from EOF_EAI_Service_Log__c
                                where recordType.developerName='PO_Log_BTS_Request'
                               AND id=:parentLogId];
                }
                
        totRec=[Select count() from EOF_EAI_Service_Log__c where recordType.developerName='PO_Log_BTS_Request' /*'PO_Collegamento_P2P' */
                    AND EOF_Stato_Richiesta__c='Bozza'
                    AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c
                    AND PO_Offerta__c=:offertaRecord];
        system.debug('@@@@@@@@@ totRec è ' + totRec);
                    /*AND EOF_Codice_Ordine_OLO__c!='' */
                    /*AND AccountId=:attuale.Contact.AccountId
                    AND PO_Offerta__c='P2P Base'];        
                */
        system.debug('@@@@@@@@@EC stiamo per calcolare totpg, qualcosa va in eccezione. i valori sono: totpg ' + totpg +', totRec' + totRec +', pageRecord' + pageRecord);        
                
        totpg = (totRec /pageRecord).round(RoundingMode.CEILING); 
        setPagination(null);  
    
    }

    //Metodo vediReq in bozza
    //To Change 
    public Pagereference vediReqBozza(){
        id pLogId = parentLogId;
        system.debug('@@@@@@@EC nel metodo vediReqBozza. pLogId è ' + pLogId);
        
        Pagereference pg1 = new Pagereference('/PO_Serv_BTS_Riepilogo');     
        
        pg1.getParameters().put('parentId', pLogId);
        pg1.getParameters().put('Mode', 'edit');
        return pg1; 
    }
    
    
    public PageReference pageDown()
    { 
        setPagination(false); 
        return null; 
    }
    
    public PageReference pageUp()
    { 
        setPagination(true); 
        return null; 
    }

public void setPagination(boolean next)
{ 
    if(next==null){
        pageActual=1; 
        totalpage = totpg; 
        totalRecord =totRec;
    }else if(next){ 
        if(pageActual<totalpage){ 
            pageActual++;
            totalpage = totpg; 
            totalRecord = totRec;
            preparePage(); 
        } 
    }else{ 
        if(pageActual>1){ 
            pageActual--; 
            totalpage = totpg; 
            totalRecord = totRec;
            preparePage(); 
        } 
    } 
   
   /* if(next==null){
        pageActual=1; 
        totalpage = totpg; 
        totalRecord =totRec;
    }else if(next){ 
        if(pageActual<totalpage){ 
            pageActual++;
            totalpage = totpg; 
            totalRecord = totRec;
            preparePage(); 
        } 
    }else{ 
        if(pageActual>1){ 
            pageActual--; 
            totalpage = totpg; 
            totalRecord = totRec;
            preparePage(); 
        } 
    } */
}

public void preparePage(){ 
    

    Integer off=(pageActual-1)*((integer)pageRecord); 
    //Integer off=(pageActual-1)*((integer)pageRecord); 

    fattLogBozzaList=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,
              EOF_Data_Notifica__c,EOF_ID_Notifica__c,PO_Offerta__c,PO_Nome_Progetto__c,
                      EOF_NOME_REFERENTE_TECNICO_OLO__c,EOF_COGNOME_REFERENTE_TECNICO_OLO__c,
                      EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                      EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                     EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,
                     EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,
                     EOF_CODICE_PROGETTO_SPECIALE__c,EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,
                     EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,
                      
                        CreatedDate, 
                      
                     EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,EOF_RECAPITO_TEST_LINEA__c, 
                      EOF_ID_Pop__c,EOF_PROFILO__c,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_USER_VLAN__c,
                      OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,
                      OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,
                      EOF_TIPOLOGIA_APPARATO__c,OF_SA_PASSWORD_APPARATO__c,
                      OF_SA_AZIONE_APPARATO__c,OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,
                      EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,
                      PO_SA_Data_Inserimento_Ordine__c
                      from EOF_EAI_Service_Log__c 
                    where recordType.developerName='PO_Log_BTS_Request'
                      AND EOF_Stato_Richiesta__c='Bozza' 
                      /*AND EOF_Codice_Ordine_OLO__c!='' */
                      AND EOF_Codice_Operatore__c=:attuale.Account.EOF_Codice_Operatore__c  
                      LIMIT:(integer)pageRecord  OFFSET :off ];
   }
    
    
    

}