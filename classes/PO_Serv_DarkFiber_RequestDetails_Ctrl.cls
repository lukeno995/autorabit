public class PO_Serv_DarkFiber_RequestDetails_Ctrl {
    
    public EOF_EAI_Service_Log__c sl {get;set;}
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
    
    
    
        
    
    public PO_Serv_DarkFiber_RequestDetails_Ctrl() {
        
        if (ApexPages.currentPage().getParameters().get('parentId') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('parentId') )){
            
            /*sl = [SELECT id, Name, eof_codice_ordine_olo__c,EOF_Stato_Richiesta__c, CreatedDate, EOF_Note__c FROM EOF_EAI_Service_log__c 
            WHERE id =:ApexPages.currentPage().getParameters().get('id')];*/
            
            system.debug('id pagina:' + ApexPages.currentPage().getParameters().get('parentId'));
            
            sl = [SELECT Id,Name,PO_Offerta__c,PO_Nome_Progetto__c,ownerId,EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, Caso__r.Casenumber  
                 FROM EOF_EAI_Service_Log__c 
                 WHERE Id = :ApexPages.currentPage().getParameters().get('parentId')];
                 
            system.debug('id log:' + sl.id);     
        }

    }
    
    public pagereference BackToBeginning(){
    
        PageReference pg = new PageReference('/PO_Serv_DarkFiber_Riepilogo');
        pg.getParameters().put('cLogId', sl.id);
        
        //giovanni
        pg.getParameters().put('parentId', sl.id);
        
        return pg;
    }
    
    public pagereference DetailPage(){

        pagereference pg = new pagereference('/PO_Serv_DarkFiber_Riepilogo');
        
        return pg;
    }
    
    public pagereference EditOrderInfo(){
        
        Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
        system.debug('CaseObj====='+caseId);
        if(caseId !=NULL) {
            childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,
                            PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
                            PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,
                            NS_Rif__c,
                            PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
                            PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
                            from case where Id=:CaseDetail Limit 1];
            
            system.debug('childCaseObj====='+childCaseObj.PO_Offerta__c);
            offertEvento =  childCaseObj.PO_Tipologia_Offerta__c;
            cliente = childCaseObj.PO_Indirizzo_collegamento__c + ','+ childCaseObj.PO_Civico__c + ',' +childCaseObj.PO_Nome_Comune__c;
            if(childCaseObj.PO_Nome_Comune3__c != null){
                cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c+' '+childCaseObj.PO_Civico_partenza__c +','+ childCaseObj.PO_Nome_Comune3__c ;
            }
            if(childCaseObj.PO_Nome_Comune3__c == null){
                cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c+' '+childCaseObj.PO_Civico_partenza__c ;
            }
            String collegamento = childCaseObj.PO_indirizzo_collegamento_3__c;
            string civico = childCaseObj.PO_Civico_3__c;
            string comune = childCaseObj.PO_Nome_Comune4__c ;
            if(childCaseObj.PO_indirizzo_collegamento_3__c== null)
            {
                collegamento ='';
            }
            if(childCaseObj.PO_Civico_3__c== null)
            {
                civico ='';
            }
            if(childCaseObj.PO_Nome_Comune4__c == null)
            {
                comune ='';
            }
            
            cliente2 = collegamento +' '+civico +','+comune ;
            
            if(childCaseObj.PO_Nome_Comune4__c == null)
            {
                cliente2 = collegamento +' '+civico ;
            }
            
            if(childcaseobj.PO_Data_Attivazione_Ordine__c!= null)
            {
                Integer d = childcaseobj.PO_Data_Attivazione_Ordine__c.day();
                Integer mo = childcaseobj.PO_Data_Attivazione_Ordine__c.month();
                Integer yr = childcaseobj.PO_Data_Attivazione_Ordine__c.year();
                
                DateTime DT = DateTime.newInstance(yr, mo, d);
                //DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
                system.debug('childDate====='+DT);
                ordercasedisplayordinedate = DT.format('dd/MM/yyyy');
                system.debug('childDate====='+childDate);
            }
        }
        orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
                    ORDER BY createddate DESC];
        return new pagereference ('/apex/PO_Serv_DarkFiber_OverviewOrder?id='+caseId);
    }           

}