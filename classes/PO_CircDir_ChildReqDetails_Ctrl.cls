public class PO_CircDir_ChildReqDetails_Ctrl {
    public String recordOfferta {get;set;}
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public EOF_EAI_Service_Log__c parentLog {get;set;}
    public List<EOF_EAI_Service_Log__c> listNephewVLAN {get;set;}
    public Boolean showVLAN {get;set;}
    public opportunity childoppobj{get;set;}
    public boolean showAllegati{get;set;}
    public String childLogCollS{get;set;} //nel caso in cui si vedessero i dettagli dell'ordine  passiamo anche il parametro del collegamentoLog per tornare al riepilogo di tutta la fattibilità.
    public String childLogId{get;set;} //è un child generico sia Collegamento sia Ordine.
    public List<attachment> childcasedisplayattlist{get;set;}
    public String pLogIdS{get;set;}
    
    public boolean searchLogBoolean{get;set;}
    
    public PO_CircDir_ChildReqDetails_Ctrl(){
        showVLAN = false;
        showAllegati=false;
        system.debug('recordOfferta vale ' + recordOfferta);
        system.debug('id da URL ' + ApexPages.currentPage().getParameters().get('childId'));
        pLogIdS = ApexPages.currentPage().getParameters().get('parentId'); //Collegamento nel caso in cui si venisse dal dettaglio di un ordine.
        
        childLogId = ApexPages.currentPage().getParameters().get('childId'); //child generico potrebbe essere sia un Collegamento sia un  Ordine.

        
        childLog= [select Id, Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c, EOF_Codice_Ordine_OLO__c,Name, EOF_Codice_Operatore__c, EOF_Stato_Richiesta__c,PO_Prime_Contractor__c,
                    Note_Sospensione_Operatore__c,PO_Sito__c,PO_Offerta__c,PO_Tipo_percorso__c,PO_Numero_fibre_richieste__c,
                    PO_Tipo_di_collegamento__c,EOF_ID_Pop__c,PO_Indirizzo_collegamento__c, EOF_SL_Riferimento__c, RecordType.developerName,
                   
                    EOF_SITO__c, EOF_NOTA_SITO__c, EOF_INDIRIZZO__c, EOF_NUMERO_CIVICO__c,
                   
                    //campi nuovi
                    PO_Disponibilit_della_rete_a_partire_da__c, PO_Tempi_di_attivazione_mesi__c, PO_Lunghezza_tratta_prima_via__c, PO_Pop_1_di_riferimento__c, PO_Lunghezza_tratta_seconda_via__c, 
                    PO_Pop_2_di_riferimento__c, PO_Data_Attivazione_Ordine__c, PO_Data_Attivazione_Richiesta__c, EOF_NOTE__c,
                   
                    PO_Civico_3__c, PO_Log_Comune_3__c,
                   
                   Caso__r.PO_Nome_Comune3__c, Caso__r.PO_Nome_Comune4__c, //FD 2019-03-10
                   
                    EOF_Comune__c,PO_Nome_Progetto__c,EOF_PROFILO__c,PO_Civico__c,PO_Nota_sito__c,EOF_STATO_ORDINE__c,
                   PO_Log_Comune_2__c //FD 2019-03-08
                    from EOF_EAI_Service_Log__c where id=:childLogId];
        
      //  }            
        
                       
        childoppobj= new opportunity();
        searchLogBoolean = false;
            
        childcasedisplayattlist=[select id,Name,parentId, body, Description, OwnerId, 
                                createdDate,BodyLength,ContentType, createdById, LastModifiedDate,
                                LastModifiedById from Attachment where (parentId=:childLog.Caso__c or parentId=:childLog.id)];
       
       showAllegati=(!childcasedisplayattlist.isEmpty())?true:false;

    }
    
    public pagereference detailparentlog(){
        //PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        PageReference pg = new PageReference('/PO_Serv_Circuiti_Diretti_Riepilogo');    
        system.debug('@@@@@@@EC abbiamo chiamato il metodo per tornare indietro alla pagina di riepilogo e passiamo i parametri');  
       
       if(pLogIdS!=null && pLogIdS !=''){
         pg.getParameters().put('parentId', pLogIdS);
         system.debug('@@@@@@@EC venivamo da un ordine e passiamo come parentId pLogIdS : ' +pLogIdS);
        }
        else{
        pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
         system.debug('@@@@@@EC venivamo da un collegamento e passiamo come parentId childLog.EOF_SL_Riferimento__c : ' + childLog.EOF_SL_Riferimento__c);
        }
        system.debug('@@@@@@EC alla fine per tornare al parent pg è ' + pg);
        pg.setRedirect(true);
        return pg;
    }
}