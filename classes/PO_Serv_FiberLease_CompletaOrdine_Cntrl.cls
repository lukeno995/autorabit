public class PO_Serv_FiberLease_CompletaOrdine_Cntrl {
    public string date4{get;set;}
    public string str{get;set;}
    public case ordercasedit {get;set;}
    public String recordOfferta {get;set;}
    public string stringdate_In_PO_ModalController{get;set;}
    
    public PO_Serv_FiberLease_CompletaOrdine_Cntrl(){
        string orderCaseId= ApexPages.currentPage().getParameters().get('ordercaseditId');
        
        ordercasedit=[Select id, CaseNumber, PO_Case_Collegamento__r.casenumber, PO_Case_Collegamento__c, PO_Tipo_percorso__c,
                    PO_Case_Collegamento__r.PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, Status, PO_Nome_E_Cognome_PM__c,
                    PO_Data_Attivazione_Richiesta__c, PO_Numero_Telefonico_PM__c, PO_isDataOrder__c,
                    NS_Rif__c,		/*LM CR02*/PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c,
                    /*LM CR02*/PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c,
                    PO_Case_Collegamento__r.parent.PO_isDataOrder__c, ParentId, Parent.casenumber, Parent.PO_IndrizoCal__c,
                    Parent.parent.PO_isDataOrder__c, EOF_Note_Operatore__c
                    from Case where Id=: orderCaseId];       
        
        if(String.isBlank(ordercasedit.NS_Rif__c))
        {
            ordercasedit.NS_Rif__c = getTheNsRif(ordercasedit.Id);
        }
    }
    
    private String getTheNsRif(Id idOrdine) 
    {
        String result = '';
        //Se Ns Rif è stato valorizzato lo valorizzo sull'ordine corrente
        Case richiesta;
        Case collegamento;
        Case ordine;
        
        List<Case> ordini = [SELECT Id, PO_Case_Collegamento__c FROM Case WHERE Id = :idOrdine];         
        if(ordini != null && ordini.size() > 0)
        {
            ordine = ordini[0];
        }
        
        List<Case> collegamenti = [SELECT Id, PO_Richiesta_a_fattibilit__c FROM Case WHERE Id = :ordine.PO_Case_Collegamento__c];         
        if(collegamenti != null && collegamenti.size() > 0)
        {
            collegamento = collegamenti[0];
        }        
        
        List<Case> richieste = [SELECT Id FROM Case WHERE Id = :collegamento.PO_Richiesta_a_fattibilit__c];        
        if(richieste != null && richieste.size() > 0)
        {
            richiesta = richieste[0];
        }
        
        List<Case> collegamentiDellaRichiesta = [SELECT Id FROM Case WHERE PO_Richiesta_a_fattibilit__c = :richiesta.Id];  
        List<Id> idsCollegamenti = new List<Id>();
        for(Case c : collegamentiDellaRichiesta)
        {
            idsCollegamenti.add(c.Id);
        }
        
        List<Case> tuttiGliOrdini = [SELECT id, NS_Rif__c  FROM Case WHERE PO_Case_Collegamento__c in :idsCollegamenti];
        for(Case o : tuttiGliOrdini)
        {
            if (String.isNotBlank(o.NS_Rif__c))
            {
              result = o.NS_Rif__c;
                break;
            }
        }   
        
        return result;
    }
    
    private void aggiornaTuttiGliOrdini(Id idOrdine, String nsrif)
    {
        //Aggiorno tutti gli ordini di tutti i collegamenti di questa richiesta con il valore Ns Rif di questo ordine
        Case richiesta;
        Case collegamento;
        Case ordine;
        
        List<Case> ordini = [SELECT Id, PO_Case_Collegamento__c FROM Case WHERE Id = :idOrdine];         
        if(ordini != null && ordini.size() > 0)
        {
            ordine = ordini[0];
        }
        
        List<Case> collegamenti = [SELECT Id, PO_Richiesta_a_fattibilit__c FROM Case WHERE Id = :ordine.PO_Case_Collegamento__c];         
        if(collegamenti != null && collegamenti.size() > 0)
        {
            collegamento = collegamenti[0];
        }        
        
        List<Case> richieste = [SELECT Id FROM Case WHERE Id = :collegamento.PO_Richiesta_a_fattibilit__c];        
        if(richieste != null && richieste.size() > 0)
        {
            richiesta = richieste[0];
        }
        
        List<Case> collegamentiDellaRichiesta = [SELECT Id FROM Case WHERE PO_Richiesta_a_fattibilit__c = :richiesta.Id];  
        List<Id> idsCollegamenti = new List<Id>();
        for(Case c : collegamentiDellaRichiesta)
        {
            idsCollegamenti.add(c.Id);
        }
        
        List<Case> tuttiGliOrdini = [SELECT id, OF_Order__c FROM Case WHERE PO_Case_Collegamento__c in :idsCollegamenti];
        //FD 2019-02-26 - start
        List<Id> idOrders = new List<Id>();
        for(Case o : tuttiGliOrdini)
        {
            o.NS_Rif__c = nsrif;
            idOrders.add(o.OF_Order__c);
        }
        List<Order> orders = [SELECT Id FROM Order WHERE Id IN: idOrders];
        for(Order ord : orders){
            ord.NS_Rif__c = nsrif;
        }
        update orders;
        //FD 2019-02-26 - end
        update tuttiGliOrdini;
    }
    
    public pagereference SaveOrderCase()
    {
        System.debug('************* AA valore di "ordercase.PO_Nome_E_Cognome_PM__c = ' + ordercasedit.PO_Nome_E_Cognome_PM__c);
        System.debug('************* AA valore di "ordercase.PO_Numero_Telefonico_PM__c = ' + ordercasedit.PO_Numero_Telefonico_PM__c);
        str = date4.replace('/', '-');        
        ordercasedit.PO_Data_Attivazione_Richiesta__c = str;
        Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
       /* //EC 2018 - 08 - 30 commentiamo perché l'owner non deve ancora cambiare, 
        cambierà solo quando l'utente di portale cliccherà su Invia Ordine ordercasedit.OwnerId = codaSupportoVendite.Id; */
        update ordercasedit;
        //vogliamo prendere il Log collegamento, che corrisponde al parent id del log ordine
        EOF_EAI_Service_Log__c parentLog = [SELECT id, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_SL_Riferimento__c 
                                            FROM EOF_EAI_Service_Log__c 
                                            WHERE Caso__c = :ordercasedit.ParentId 
                                            LIMIT 1];
        //FD 2016-03-06
        EOF_EAI_Service_Log__c orderLog = [SELECT id, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_SL_Riferimento__c 
                                            FROM EOF_EAI_Service_Log__c 
                                            WHERE Caso__c =: ApexPages.currentPage().getParameters().get('ordercaseditId') 
                                            LIMIT 1];
        orderLog.PO_Data_Attivazione_Richiesta__c = str;
        orderLog.PO_note_operatore__c = ordercasedit.EOF_Note_Operatore__c;
        update orderLog;
        
        aggiornaTuttiGliOrdini(ordercasedit.Id, ordercasedit.NS_Rif__c);

        PageReference pg = new PageReference('/PO_Serv_FiberLease_Riepilogo');        
        pg.getParameters().put('parentId', parentLog.EOF_SL_Riferimento__c);
        return pg;
    }
    
    public pagereference orderAnnulla()
    {
       // case parencs = [select id,parentid,OwnerId from case where id=:ordercasedit.PO_Case_Collegamento__c];
        EOF_EAI_Service_Log__c parentLog = [select id, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_SL_Riferimento__c 
                                             FROM EOF_EAI_Service_Log__c 
                                             WHERE Caso__c = :ordercasedit.ParentId
                                             LIMIT 1]; //from EOF_EAI_Service_Log__c where Caso__c=:ordercasedit.id LIMIT 1];
        case parencs = [select id,parentid,OwnerId from case where  id=:ordercasedit.ParentId LIMIT 1];
        system.debug('parentid========'+parencs.parentid);
         system.debug('parentLOGid========'+parentLog.id);
        
        //pagereference pg = new pagereference('/PO_P2PAtt_RiepReq_ElCo');
        pagereference pg = new pagereference('/PO_Serv_FiberLease_Riepilogo');
        
        pg.getParameters().put('parentId',parentLog.EOF_SL_Riferimento__c);
        // pg.getParameters().put('id',parencs.Id);
        return pg;
    }
    
    
}