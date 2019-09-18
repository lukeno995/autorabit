public class PO_Serv_CircDir_OrderDetails_Ctrl {
    
    public case c {get;set;}
    public List<EOF_EAI_Service_Log__c> orderLogsList {get;set;}
    public EOF_EAI_Service_Log__c ordLog{get;set;}
    public String recordOfferta {get;set;}
    public Case childCaseObj {get;set;}
    public string CaseDetail{get;set;}
    public string offertEvento {get;set;}
    public string cliente {get;set;}    
    public string cliente1 {get;set;}
    public string cliente2 {get;set;}
    public list<Attachment> orderAtt {get;set;}
    public string ordercasedisplayordinedate{get;set;}
    public string childDate {set;get;}    
    
    
    
    public PO_Serv_CircDir_OrderDetails_Ctrl() {
        
        //if (ApexPages.currentPage().getParameters().get('id') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('id') )){
        if (ApexPages.currentPage().getParameters().get('orderLogId') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('orderLogId') )){

            system.debug('idordercaser pagina:' + ApexPages.currentPage().getParameters().get('orderLogId'));
            
            c= [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
                PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,
                NS_Rif__c,
                PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
                from case where Id=:ApexPages.currentPage().getParameters().get('id') Limit 1];
            
            ordLog=[select id, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c, EOF_STATO_ORDINE__c, 
                    PO_Prime_Contractor__c, CreatedDate, EOF_SL_Riferimento__r.EOF_SL_Riferimento__r.CreatedDate, Note_Sospensione_Operatore__c, 
                    EOF_NOTE__c, PO_Sito__c, PO_Indirizzo_collegamento__c,EOF_SL_Riferimento__r.PO_Indirizzo_collegamento__c
                    from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('orderLogId') Limit 1];

            
            //orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
            orderatt = [select id,name,parentid,IsPrivate,createddate 
                        from attachment where parentid =: ApexPages.currentPage().getParameters().get('orderLogId') AND IsPrivate = false    
                        ORDER BY createddate DESC];
            
        }
        
    }
    
    public pagereference GoBack(){
        String parentLogFattId=[Select EOF_SL_Riferimento__r.EOF_SL_Riferimento__c 
                            from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('orderLogId') Limit 1 ].EOF_SL_Riferimento__r.EOF_SL_Riferimento__c;
        PageReference pg = new PageReference('/PO_Serv_CircDir_RequestDetails_Ctrl');
        pg.getParameters().put('id', parentLogFattId);
        return pg;
    }    
}