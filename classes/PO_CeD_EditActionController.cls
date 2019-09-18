public class PO_CeD_EditActionController {

    public String idc {get;set;}
    public Case c {get;set;}
    
    //costruttore    
    public PO_CeD_EditActionController(ApexPages.StandardController stdController)
    {
        //c = (Case)stdController.getRecord();
     	idc = ApexPages.currentPage().getParameters().get('Id');
     
     	System.debug(']]]]idc]]]]: '+idc);
        
     	//Query sul Case
     	c = [Select id, status, EOF_Fase__c, EOF_Id_Risorsa__c, EOF_Note_Appuntamento__c, EOF_Codice_Operatore_WS__c,
     	     EOF_Orario_Appuntamento__c, EOF_Data_Prevista_Attivazione__c, OF_SA_Codice_Motivazione__c, 
             OF_SA_Motivazione__c, EOF_Note__c, EOF_Codice_Ordine_OLO__c, Account.FirstName, Account.LastName,
             EOF_Recapito_Telefonico_Cliente_1__c
             from Case
             where id=:idc
           ];
    }

    public pageReference aggiornaDati()
    {
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule Notify = new OF_SA_WS_IN_OM_Reschedule.OM_Notify_Reschedule();
        Notify.CODICE_OPERATORE = c.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = c.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = c.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.NOME_CLIENTE = c.Account.FirstName;
        Notify.COGNOME_CLIENTE = c.Account.LastName;
        Notify.RECAPITO_TELEFONICO_CLIENTE_1 = c.EOF_Recapito_Telefonico_Cliente_1__c;
        Notify.DATA_PREVISTA_ATTIVAZIONE = String.valueOfGmt(c.EOF_Data_Prevista_Attivazione__c);
        Notify.ORARIO_APPUNTAMENTO = c.EOF_Orario_Appuntamento__c;
        Notify.NOTE = c.EOF_Note__c;
        Notify.CODICE_MOTIVAZIONE = 'R00';
        Notify.MOTIVAZIONE = 'Ripianificazione appuntamento causa OF'; 
        
        OF_SA_WS_IN_OM_Reschedule.OM_Notify_RescheduleResponse resp = OF_SA_CD_WS_IN_OM.OM_Reschedule(Notify);
        System.debug('***Reschedule RESP*** : '+resp);
        
        if(resp.ESITO=='0')
            update c;
     
        PageReference pg = new PageReference('/'+c.id);
        return pg;   
    }
    
    public pageReference annulla()
    {
        PageReference pg = new PageReference('/'+c.id);
        return pg;   
    }
}