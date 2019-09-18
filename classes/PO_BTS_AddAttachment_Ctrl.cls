public class PO_BTS_AddAttachment_Ctrl {
    //Dichiarazione variabili
    public String fileName{get;set;}
    public Blob fileBody{get;set;}
    public Case parentCaseObj{get;set;}
    public EOF_EAI_Service_Log__c parentLogObj{get;set;}
    public String logAttIdToSend {get;set;}
    
    //Costruttore
    public PO_BTS_AddAttachment_Ctrl(){
        String parentLogId = ApexPages.currentPage().getParameters().get('parentId');
        if(parentLogId != null && String.isNotBlank(parentLogId)){
            parentLogObj = [SELECT Id, Caso__c
                            FROM EOF_EAI_Service_Log__c
                            WHERE Id = :parentLogId];
        }

    }
    //Metodo di upload del file
    public PageReference attachUpload() {
        Attachment caseAttach = new Attachment();
        Attachment logAttach = new Attachment();
        
        caseAttach.OwnerId = UserInfo.getUserId();
        caseAttach.ParentId = parentLogObj.Caso__c;
        caseAttach.name = 'OffertaAccettata_'+fileName;
        caseAttach.body = fileBody;
        try{//EC 2018 - 10 - 10 gestiamo il tentativo di upload senza allegato
        insert caseAttach;
        }
        catch(Exception e){
         // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getDmlMessage(0)));
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Bisogna selezionare un file da allegare cliccando sull\'apposito bottone ' + e.getDmlMessage(0) ));
        }
        caseAttach = null;

        logAttach.OwnerId = UserInfo.getUserId();
        logAttach.ParentId = parentLogObj.Id;
        logAttach.name = 'OffertaAccettata_'+fileName;
        logAttach.body = fileBody;
        insert logAttach;
        logAttIdToSend=logAttach.id;
        logAttach = null;
        //Svuoto il filebody
        fileBody = null;
        parentLogObj.PO_Offerta_Caricata__c = true;
        update parentLogObj;
        
        //PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        PageReference pg = new PageReference('/PO_Serv_BTS_Riepilogo');        
        
        pg.getParameters().put('parentId', parentLogObj.Id);
        pg.getParameters().put('OffUploaded',logAttIdToSend);
        return pg;
    }
}