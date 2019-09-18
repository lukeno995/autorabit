public class PO_Serv_P2PBase_OrderDetails_Ctrl {
    
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
    
    
    
    public PO_Serv_P2PBase_OrderDetails_Ctrl() {
        
        //if (ApexPages.currentPage().getParameters().get('id') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('id') )){
        if (ApexPages.currentPage().getParameters().get('orderLogId') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('orderLogId') )){
            
            /*sl = [SELECT id, Name, eof_codice_ordine_olo__c,EOF_Stato_Richiesta__c, CreatedDate, EOF_Note__c FROM EOF_EAI_Service_log__c 
WHERE id =:ApexPages.currentPage().getParameters().get('id')];*/
            
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
            //ordLog.PO_Indirizzo_collegamento__c
            
            
            
            /*orderLogs = [SELECT id, Name, Caso__c, Caso__r.Status, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,
CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c
FROM EOF_EAI_Service_Log__c 
WHERE EOF_SL_Riferimento__c =: c.id
AND RecordType.DeveloperName = 'PO_P2P_Attiva_Ordine'];*/
            
            //orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
            orderatt = [select id,name,parentid,IsPrivate,createddate 
                        from attachment where parentid =: ApexPages.currentPage().getParameters().get('orderLogId') AND IsPrivate = false    
                        ORDER BY createddate DESC];
            
        }
        
    }
    
    public pagereference GoBack(){
        String parentLogFattId=[Select EOF_SL_Riferimento__r.EOF_SL_Riferimento__c 
                            from EOF_EAI_Service_Log__c where id=:ApexPages.currentPage().getParameters().get('orderLogId') Limit 1 ].EOF_SL_Riferimento__r.EOF_SL_Riferimento__c;
        PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('id', parentLogFattId);
        
        /*PageReference pg = new PageReference('/newPage');
pg.getParameters().put('goBackUrl', ApexPages.currentPage().getUrl());
//altri parametri
return pg; */
        
        //PageReference pg = new PageReference('/PO_P2P_Attivo_DisplayRequest');
        
        return pg;
    }
    
    public pagereference DetailPage(){
        
        pagereference pg = new pagereference('/PO_P2PAtt_RiepReq_ElCo');
        
        return pg;
    }
    
    /*
public pagereference EditOrderInfo(){

//Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
Id caseId = c.id;

//system.debug('CaseObj====='+caseId);

system.debug('il case ordine è:' +c);

if(caseId !=NULL) {
childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
from case where Id=:caseId Limit 1];



system.debug('childCaseObj====='+c.PO_Offerta__c);

offertEvento =  c.PO_Tipologia_Offerta__c;
cliente = c.PO_Indirizzo_collegamento__c + ','+ c.PO_Civico__c + ',' +c.PO_Nome_Comune__c;
if(c.PO_Nome_Comune3__c != null){
cliente1 = c.PO_Indirizzo_collegamento_partenza__c+' '+c.PO_Civico_partenza__c +','+ c.PO_Nome_Comune3__c ;
}
if(c.PO_Nome_Comune3__c == null){
cliente1 = c.PO_Indirizzo_collegamento_partenza__c+' '+c.PO_Civico_partenza__c ;
}
String collegamento = c.PO_indirizzo_collegamento_3__c;
string civico = c.PO_Civico_3__c;
string comune = c.PO_Nome_Comune4__c ;
if(c.PO_indirizzo_collegamento_3__c== null)
{
collegamento ='';
}
if(c.PO_Civico_3__c== null)
{
civico ='';
}
if(c.PO_Nome_Comune4__c == null)
{
comune ='';
}

cliente2 = collegamento +' '+civico +','+comune ;

if(c.PO_Nome_Comune4__c == null)
{
cliente2 = collegamento +' '+civico ;
}

if(c.PO_Data_Attivazione_Ordine__c!= null){
Integer d = c.PO_Data_Attivazione_Ordine__c.day();
Integer mo = c.PO_Data_Attivazione_Ordine__c.month();
Integer yr = c.PO_Data_Attivazione_Ordine__c.year();

DateTime DT = DateTime.newInstance(yr, mo, d);
//DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
system.debug('childDate====='+DT);
ordercasedisplayordinedate = DT.format('dd/MM/yyyy');
system.debug('childDate====='+childDate);
}

}

orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
ORDER BY createddate DESC];

return new pagereference ('/apex/PO_P2PAttiva_OverviewOrder?id='+caseId);
}*/         
    
}