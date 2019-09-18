public class PO_P2PAttiva_ChildReqDetails_Ctrl {
    public String recordOfferta {get;set;}
    public EOF_EAI_Service_Log__c childLog {get;set;}
    public EOF_EAI_Service_Log__c profileObj {get;set;}
    public EOF_EAI_Service_Log__c parentLog {get;set;}
    public List<EOF_EAI_Service_Log__c> listNephewVLAN {get;set;}
    public Boolean showVLAN {get;set;}
    public opportunity childoppobj {get;set;}
    public Integer LunghezzaTrattaPrimaViaCalculated {get;set;}
    public user usr {get; set;}
    public Id accId;
    public List<attachment> childcasedisplayattlist{get;set;}
    public String tipoP2PAttiva {get;set;}
    public Account accountN{get;set;}
    public boolean searchLogBoolean{get;set;}
    
    public PO_P2PAttiva_ChildReqDetails_Ctrl(){
        showVLAN = false;
        User ContactUser = [Select contactId from User where id=:UserInfo.getUserId()];
        usr=[Select Name,Profile.Name,IsActive,Contact.Account.Id,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
             contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
             contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
             contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,contact.PO_Servizio_Incident_Management__c,
             contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c,Contact.Account.EOF_Codice_Operatore__c
             From User
             Where Id =: System.UserInfo.getUserId()];
        accId = usr.Contact.Account.Id;
        Id accId = [Select AccountId from Contact where id =: ContactUser.ContactId].AccountId;
        accountN = [select Name from Account where id =:accId];
        tipoP2PAttiva=ApexPages.currentPage().getParameters().get('tipoP2Patt');
        system.debug('recordOfferta vale ' + recordOfferta);
        system.debug('id da URL ' + ApexPages.currentPage().getParameters().get('childId'));
        String childLogId = ApexPages.currentPage().getParameters().get('childId');
        childLog= [select Id, Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                   EOF_Codice_Ordine_OLO__c,Name, EOF_Codice_Operatore__c, EOF_Stato_Richiesta__c,PO_Prime_Contractor__c,
                   Note_Sospensione_Operatore__c,PO_Sito__c,PO_Offerta__c,caso__r.PO_Tipo_percorso__c,caso__r.PO_Numero_fibre_richieste__c,
                   PO_Tipo_di_collegamento__c,EOF_ID_Pop__c,PO_Indirizzo_collegamento__c, EOF_SL_Riferimento__c,
                   EOF_Comune__c,PO_Nome_Progetto__c,EOF_PROFILO__c,PO_Civico__c,PO_Nota_sito__c,EOF_STATO_ORDINE__c,
                   PO_Disponibilit_della_rete_a_partire_da__c, PO_Tempi_di_attivazione_mesi__c, PO_Lunghezza_tratta_prima_via__c,
                   Caso__c, PO_BB_1_via_interessato__c, PO_Posa_1_via_nuovo_Drop__c,
                   ID_Sede__c,TrafficLoadBalancing__c,Tipologia_CPE__c,Tipologia_Alimentazione__c,Tipologia_Sede__c,
                   ID_Sede_Master__r.ID_Sede__c,Service_Attribute__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                   Interfaccia_CPE__c,COS5_PIR__c,COS5_CIR__c,
                   COS3_PIR__c,COS3_CIR__c,COS1_PIR__c,COS1_CIR__c
                   from EOF_EAI_Service_Log__c where id=:childLogId];
        if(tipoP2PAttiva =='eLine'){
            if(childLog.Tipologia_Sede__c!='Master'){
                profileObj =[SELECT id,PO_P2PAttiva_Opzione__c,OF_SA_PROFILO_VLAN__c,EOF_PROFILO__c,COS5_PIR__c,COS5_CIR__c,
                             COS3_PIR__c,COS3_CIR__c,COS1_PIR__c,COS1_CIR__c
                             FROM EOF_EAI_Service_Log__c
                             WHERE EOF_SL_Riferimento__c =:childLogId 
                             AND Recordtype.DeveloperName='OF_SA_Vlan_ELine']; //EC 2019 06 18 aggiunta where condition poiché sia ordine sia vlan hanno come SL_Riferimento il collegamento, ma solo la VLAN ha le informazioni che ci servono relative al profilo
            }
        }else{
            profileObj =[SELECT id,PO_P2PAttiva_Opzione__c,OF_SA_PROFILO_VLAN__c,EOF_PROFILO__c,COS5_PIR__c,COS5_CIR__c,
                         COS3_PIR__c,COS3_CIR__c,COS1_PIR__c,COS1_CIR__c
                         FROM EOF_EAI_Service_Log__c
                         WHERE EOF_SL_Riferimento__c =:childLogId 
                         AND Recordtype.DeveloperName='OF_SA_Vlan'];
        }
        childoppobj= new opportunity();
        searchLogBoolean = false;
        
        childcasedisplayattlist=[select id,Name,parentId, body, Description, OwnerId, 
                                 createdDate,BodyLength,ContentType, createdById, LastModifiedDate,
                                 LastModifiedById from Attachment where (parentId=:childLog.Caso__c or parentId=:childLog.id)];
        
        listNephewVLAN = [SELECT Id, RecordType.DeveloperName, OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_SERVICE_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c, 
                          OF_SA_USER_VLAN__c, OF_SA_PROFILO_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c
                          FROM EOF_EAI_Service_Log__c
                          WHERE EOF_SL_Riferimento__c = :childLogId];
        
        if (listNephewVLAN != null && listNephewVLAN.size() > 0){
            showVLAN = true;
        }
        
        List<Case> caseList = [SELECT Id, PO_Disponibilit_della_rete_a_partire_da__c, PO_Tipo_di_collegamento__c,
                               PO_BB_1_via_interessato__c, PO_Posa_1_via_nuovo_Drop__c, PO_Tempi_di_attivazione_mesi__c,
                               PO_Lunghezza_tratta_prima_via__c
                               FROM Case WHERE Id = : childLog.Caso__c];
        if(caseList != null && caseList.size() > 0)
        {
            childLog.PO_Disponibilit_della_rete_a_partire_da__c = caseList[0].PO_Disponibilit_della_rete_a_partire_da__c;
            childLog.PO_Tempi_di_attivazione_mesi__c = caseList[0].PO_Tempi_di_attivazione_mesi__c;                                   
            childLog.PO_Tipo_di_collegamento__c = caseList[0].PO_Tipo_di_collegamento__c;
            
            childLog.PO_BB_1_via_interessato__c = caseList[0].PO_BB_1_via_interessato__c;
            childLog.PO_Posa_1_via_nuovo_Drop__c = caseList[0].PO_Posa_1_via_nuovo_Drop__c; 
            
            if (caseList[0].PO_Lunghezza_tratta_prima_via__c != null && caseList[0].PO_Lunghezza_tratta_prima_via__c > 0)
            {            
                LunghezzaTrattaPrimaViaCalculated = Integer.valueof(caseList[0].PO_Lunghezza_tratta_prima_via__c);   
            }
        }        
    }
    
    public pagereference detailparentlog(){
        PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        //pg.getParameters().put('cLogId', childLog.EOF_SL_Riferimento__c);
        pg.getParameters().put('parentId', childLog.EOF_SL_Riferimento__c);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
    }
    
    public pagereference DesospendiClg(){
        
        PageReference pg = new PageReference('/PO_P2PAttiva_DesospClg');
        pg.getParameters().put('ChildId', childLog.id);
        pg.getParameters().put('proc','desospensione');
        
        return pg;
        
    }
}