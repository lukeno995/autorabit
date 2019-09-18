public class PO_P2PAttiva_KIT_Controller {
    
    public User actualUser {get; set;}
	public String recordOfferta {get;set;}
    public string nomeAzienda {get;set;}
    public EOF_EAI_Service_Log__c sl {get;set;}
    public EOF_EAI_Service_Log__c slestratta {get;set;}
    public EOF_EAI_Service_Log__c sLogKit {get;set;}
    public EOF_EAI_Service_Log__c sLogCollgm {get;set;}
    public Map<String,Id> rTypeDevId {get;set;}
    public static EOF_EAI_Service_Log__c slOrig{get;set;}
    public boolean modifyMode{get;set;}
    public boolean insertMode{get;set;}
    public boolean Apparati{get;set;}
    public String cLogId {get;set;}
    public String parentId {get;set;}
    public String kitId{get;set;}
    public Static integer contKitprogressivo{get;set;}
    public String nomeKit{get;set;}
    public String s1{get;set;}
    public boolean checkDelete{get;set;}
    public Static String popName {get;set;}
    public List<SelectOption>  optPopList {get;set;}
    public List<EOF_EAI_Service_Log__c> vlanLogChild;
    public List<SelectOption>  optKITList {get;set;}
    public List<SelectOption> servicePopList {get;set;}
    public string elencoNull {get;set;}
    public String hiddenValuePOP{get;set;}
    public String hiddenName{get;set;}
    public String nameKitFromList{get;set;}
    public String nameKitFromListNew{get;set;}
    public String serviceAttribute {get; set;}
    public String hiddenValuePOP2 {get; set;}
    public String nomeKit1 {get; set;}
    public List<SelectOption> assignedPop {get; set;}
    
    // I kit di tipo EPL non sono in 'condivisione', appartengono ad 
    // una sola richiesta. Quelli EVPL possono essere condivisi tra più richieste.
    private static final String SERVICE_EPL = 'EPL';
    private static final String SERVICE_EVPL = 'EVPL';
    private static final String OP_MODIFY = 'mod';
    private static final String QUERY_STRING_OPERATION = 'op';
    public String tipoP2PAttiva {get;set;}
    private Map<String,SObject> map_KitNameToObject;    
    
    public PO_P2PAttiva_KIT_Controller(){
        tipoP2PAttiva=ApexPages.currentPage().getParameters().get('tipoP2Patt'); 
        rTypeDevId = new Map<String,Id>();
        for(recordtype rt : [SELECT DeveloperName FROM recordtype]) {
            rTypeDevId.put(rt.DeveloperName, rt.Id);
        }
        actualUser = [SELECT Id, Contact.Account.EOF_Codice_Operatore__c, Account.EOF_Codice_Operatore__c , Account.name 
            FROM user WHERE Id=:userinfo.getUserId()];     
        //nomeAzienda = actualUser.Account.name;

        contKitprogressivo=0; 
        checkDelete=false;
        initializeId();
        findKitNames();
        initializeAssignedPOP();
        findSLogKit();        
        scegliPop();
        
        System.debug('@@cLogId'+cLogId);        
        if((parentId==null || parentId=='') &&(!String.isBlank(cLogId))){
            parentId=[select id,EOF_SL_Riferimento__c from EOF_EAI_Service_Log__c where id=: cLogId].EOF_SL_Riferimento__c;
        }
        if (!String.isBlank(cLogId)) {
            sLogCollgm = [SELECT OF_PP_KIT_Log__c, kit_in_condivisione__c FROM EOF_EAI_Service_Log__c WHERE Id =: cLogId]; 
        } 

        //faccio il check in caso di delete avviso che ci sono delle vlan che verranno cancellate
        /* if(ApexPages.currentPage().getParameters().get('from')=='RiepReq'){
            vlanLogChild =[select id from EOF_EAI_Service_Log__c where OF_PP_KIT_Log__c =:kitId];
            System.debug('@@@@@@');
            if(!vlanLogChild.isEmpty()){
                checkDelete=true;
            }
        } */
        // valorizzo lista dei kit in condivisione (scelta EVPL)
        // modifica o inserimento
        
        
        String[] traffico = new String[]{'VULA Openstream Direct','VULA Openstream City Edge','BITSTREAM - Openstream Regional'};
            this.elencoTRAFFICO = new SelectOption[]{};
                
                for (String t: traffico) {
                    this.elencoTRAFFICO.add(new SelectOption(t,t));
                }
        
        String[] interfaccia = new String[]{'None','1 Giga','10 Giga'};
            this.elencoInterfacce = new SelectOption[]{};
                
                for (String i: interfaccia) {
                    this.elencoInterfacce.add(new SelectOption(i,i));
                }
        
        String[] offerte = new String[]{'KIT','VLAN'};
            this.elencoOfferte = new SelectOption[]{};
                
                for (String c: offerte) {
                    this.elencoOfferte.add(new SelectOption(c,c));
                }
        
    }
    
    private void findSLogKit() {
        initializeId();
        if (kitId != null) {
            slestratta = [SELECT id, Name, EOF_Stato_Richiesta__c, EOF_ID_Pop__c,   
                          PO_P2PAttiva_Nome_del_KIT__c,PO_P2PAttiva_KIT_Indirizzo_Consegna__c, 
                          PO_P2PAttiva_Optical_Rate_Limiting__c, EOF_SL_Riferimento__c, 
                          kit_in_condivisione__c, Service_Attribute__c
                          FROM EOF_EAI_Service_Log__c
                          WHERE Id =: kitId];
        } else {
            slestratta = new EOF_EAI_Service_Log__c();        
        }
        
    } 
    
    public SelectOption[] elencoOfferte {
        public get;
        private set;
    }
    public SelectOption[] elencoTRAFFICO {
        public get;
        private set;
    }
    public SelectOption[] elencoInterfacce {
        public get;
        private set;
    }

    public void initializeAssignedPOP() {
        assignedPop = new List<SelectOption>();
        for(String key : map_KitNameToObject.keySet()) {
            if(map_KitNameToObject.get(key) instanceof EOF_EAI_Service_Log__c) {
                String value = ((EOF_EAI_Service_Log__c)map_KitNameToObject.get(key)).EOF_ID_Pop__c;
                if(value != null) {
                    assignedPop.add(new SelectOption(value, value));
                }
            }
        }
    }

    public PageReference insertKitLog() {
        System.debug('@@@@ SERVICE ATTRIBUTE: ' + serviceAttribute);
        System.debug('@@@nameKitFromListNew'+nameKitFromListNew);
        Id kitId = null;
        initializeid();
        // sto modificando il kit
        if( OP_MODIFY == ApexPages.currentPage().getParameters().get(QUERY_STRING_OPERATION)) {
            return updateKitLog();
        } else {
            if(slestratta.Service_Attribute__c == SERVICE_EPL || 
                ((nameKitFromListNew =='-') && (slestratta.Service_Attribute__c == SERVICE_EVPL)) ) {
                kitId = inserisciNuovoKit();
            }  else  {
                String kitName = String.isNotBlank(nameKitFromList) ? nameKitFromList : nameKitFromListNew;
                List<EOF_EAI_Service_Log__c> logToUpdate = updateVlan(kitName, null);
                update logToUpdate; 
                System.debug('##### nameKitFromList: ' + nameKitFromList);
                System.debug('##### slestratta.PO_P2PAttiva_Nome_del_KIT__c: ' + slestratta.PO_P2PAttiva_Nome_del_KIT__c);
                bindToSLogCollegamento(); 
            }
        }
        
        PageReference pg = new PageReference ('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('cLogId',cLogId);
        pg.getParameters().put('parentId',parentId);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.getParameters().put('kitId',kitId); 
        return pg;
    }

    // Metodo che stava in 'inserisciVlan_Controller'
    public Id inserisciNuovoKit(){
        System.debug('@@@@@@@@@@@@@@@@@@EC abbiamo chiamato il metodo inserisciNuovoKit');
        initializeId();
        Id rtSLogKitId = rTypeDevId.get(RTypeServFattibilita.LOG_P2P_ATTIVA_KIT);
        sLogKit = new EOF_EAI_Service_Log__c();
        sLogKit.EOF_SL_Riferimento__c=parentId;
        sLogKit.recordtypeId = rtSLogKitId;
        sLogKit.EOF_Stato_Richiesta__c='NA';
        sLogKit.EOF_CODICE_OPERATORE__c=actualUser.Contact.Account.EOF_Codice_Operatore__c;
        sLogKit.EOF_Tipo_Comunicazione_String__c='KIT Consegna';
        sLogKit.Nome_del_KIT__c='';//nomeAzienda + s1.replace('LOG-', '_KIT_');//nomekit;
        sLogKit.Modello_di_Servizio__c='';//ModelloServizio;  
        sLogKit.Service_Attribute__c = slestratta.Service_Attribute__c;
        sLogKit.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = slestratta.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
        sLogKit.EOF_ID_Pop__c = slestratta.EOF_ID_Pop__c;   
        sLogKit.PO_P2PAttiva_Optical_Rate_Limiting__c = slestratta.PO_P2PAttiva_Optical_Rate_Limiting__c;
        System.debug('@@@@@@@@@@@@@@@@@@ eof_id_pop:' + slestratta.EOF_ID_Pop__c);
        insert sLogKit; 
        Map<String, EOF_EAI_Service_Log__c> map_nameSlToUpdate = updateLogAfterInsert();
        System.debug('nome del kit: ' + map_nameSlToUpdate.get('kit').PO_P2PAttiva_Nome_del_KIT__c);
        
        List<EOF_EAI_Service_Log__c> logsToUpdate = updateVlan(
            map_nameSlToUpdate.get('kit').PO_P2PAttiva_Nome_del_KIT__c, sLogKit.Id);

        logsToUpdate.add(map_nameSlToUpdate.get('kit'));
        logsToUpdate.add(map_nameSlToUpdate.get('collegamento'));
        update logsToUpdate;

        return sLogKit.Id;
    } 

    private Map<String, EOF_EAI_Service_Log__c> updateLogAfterInsert() {
        initializeId();
        System.debug('updateLogAfterInsert: cLogId: '+ cLogId);
        Map<String, EOF_EAI_Service_Log__c> map_nameSlToUpdate = new Map<String, EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c kitLog = new EOF_EAI_Service_Log__c();
        EOF_EAI_Service_Log__c sLogCollgm = new EOF_EAI_Service_Log__c();

        kitLog=[SELECT id, Name, EOF_Stato_Richiesta__c, EOF_ID_Pop__c,   
                    PO_P2PAttiva_Nome_del_KIT__c,PO_P2PAttiva_KIT_Indirizzo_Consegna__c, 
                    PO_P2PAttiva_Optical_Rate_Limiting__c, EOF_SL_Riferimento__c, 
                    kit_in_condivisione__c, Service_Attribute__c, EOF_Codice_Ordine_OLO__c
                    FROM EOF_EAI_Service_Log__c 
                    WHERE id=: sLogKit.Id];
    
        kitLog.PO_P2PAttiva_Nome_del_KIT__c= actualUser.Account.EOF_Codice_Operatore__c + kitLog.Name.replace('LOG-', '_KIT_');   
        kitLog.EOF_Codice_Ordine_OLO__c = actualUser.Account.EOF_Codice_Operatore__c + kitLog.Name.replace('LOG-', '_');
        sLogCollgm.Id = cLogId;
        sLogCollgm.OF_PP_KIT_Log__c = sLogKit.Id;
        sLogCollgm.Service_attribute__c = kitLog.Service_attribute__c == 'EPL' ? 'EPL' : 'EVPL';
        System.debug('##### updateLogAfterInsert -- id collegamento / id kit: ' + sLogCollgm.Id + ' / ' + sLogKit.Id);

        map_nameSlToUpdate.put('kit', kitLog);
        map_nameSlToUpdate.put('collegamento', sLogCollgm);
        
        return map_nameSlToUpdate;
    }
    
    //EC start 2018 - 09 - 24 TO change  pageReference dopo aver creato le pagine:
    //
    public PageReference updateKitLog() {
        initializeId();
        EOF_EAI_Service_Log__c toUpdate = findSLogById(kitId);
        toUpdate.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = slestratta.PO_P2PAttiva_KIT_Indirizzo_Consegna__c;
        toUpdate.EOF_ID_Pop__c = slestratta.EOF_ID_Pop__c;   
        toUpdate.PO_P2PAttiva_Optical_Rate_Limiting__c = slestratta.PO_P2PAttiva_Optical_Rate_Limiting__c;
        update toUpdate;
        Pagereference pg= new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId',parentId);
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.getParameters().put('kitId',kitId);        
        pg.setRedirect(true);
        return pg;
    } 

    private List<EOF_EAI_Service_Log__c> updateVlan(String kitName, Id kitId) {
        System.debug('##### updateVlan: cLogId' + cLogId);
        System.debug('##### updateVlan: kitId' + kitId);
        List<EOF_EAI_Service_Log__c> list_sLogVlan = [SELECT PO_P2PAttiva_Kit_Consegna_VLan__c, OF_SA_KIT_CONSEGNA_VLAN__c, OF_PP_KIT_Log__c 
            FROM EOF_EAI_Service_Log__c WHERE EOF_SL_Riferimento__c =: cLogId and RecordTypeId =: rTypeDevId.get('OF_SA_Vlan')];
   
        if(!list_sLogVlan.isEmpty()) {    
            list_sLogVlan[0].PO_P2PAttiva_Kit_Consegna_VLan__c = kitName;
            list_sLogVlan[0].OF_SA_KIT_CONSEGNA_VLAN__c = kitName;
            System.debug('##### updateVlan: nome del kit: ' + kitName);

            if(kitId != null) {
                list_sLogVlan[0].OF_PP_KIT_Log__c = kitId;
                System.debug('##### updateVlan: kitId: ' + kitId); 
            }
 
        }
        return list_sLogVlan;
    }
	
	public void findKitNames() {
        optKITList= new List<SelectOption>();
        optKITList.add(new SelectOption('-','-'));
        String codOperatore = '';
        if(actualUser.Account != null ) {
            codOperatore= actualUser.Account.EOF_Codice_Operatore__c;
        }

        map_KitNameToObject = new Map<String,sObject>();
        for(EOF_EAI_Service_Log__c kitLog: [SELECT PO_P2PAttiva_Nome_del_KIT__c, EOF_ID_Pop__c
                                            FROM EOF_EAI_Service_Log__c 
                                            WHERE RecordTypeId =: rTypeDevId.get('PO_Log_P2P_Attiva_KIT') 
                                            AND EOF_SL_Riferimento__c =:parentId
                                            AND PO_P2PAttiva_Nome_del_KIT__c!='']){
                                                optKITList.add(new SelectOption(kitLog.PO_P2PAttiva_Nome_del_KIT__c,kitLog.PO_P2PAttiva_Nome_del_KIT__c));
                                                map_KitNameToObject.put(kitLog.PO_P2PAttiva_Nome_del_KIT__c, kitLog);
                                                 
                                            }

        for(Case c : [SELECT Account.EOF_Codice_Operatore__c,PO_PP_NomeKit__c
                FROM Case
                WHERE Account.EOF_Codice_Operatore__c =: codOperatore
                AND RecordType.DeveloperName = 'PO_Case_P2P_Attiva_KIT'
                AND status in ('Acquisito','In Lavorazione' , 'Verificato')
                AND service_attribute__c =: SERVICE_EVPL ]) {
     
            optKITList.add(new SelectOption(c.PO_PP_NomeKit__c, c.PO_PP_NomeKit__c));
            map_KitNameToObject.put(c.PO_PP_NomeKit__c, c);
            }
    }

    private void initializeId() {
        cLogId = Apexpages.currentPage().getParameters().get('cLogId');
        parentId = Apexpages.currentPage().getParameters().get('parentId');
        kitId = Apexpages.currentPage().getParameters().get('kitId');
        
    }
    

    private EOF_EAI_Service_Log__c findSLogById(Id logId) {
        EOF_EAI_Service_Log__c logRecord = [SELECT id, Name, EOF_Stato_Richiesta__c, EOF_ID_Pop__c,   
                PO_P2PAttiva_Nome_del_KIT__c,PO_P2PAttiva_KIT_Indirizzo_Consegna__c, 
                PO_P2PAttiva_Optical_Rate_Limiting__c, EOF_SL_Riferimento__c, 
                kit_in_condivisione__c, Service_Attribute__c 
            FROM EOF_EAI_Service_Log__c
            WHERE Id =: logId];
        
        return logRecord;
    }   
    
	private void bindToSLogCollegamento(){
        initializeId();
        System.debug('##### bindToSLogCollegamento - getting value from map, key= ' + slestratta.PO_P2PAttiva_Nome_del_KIT__c);
        sObject objKit = map_KitNameToObject.get(slestratta.PO_P2PAttiva_Nome_del_KIT__c);
        System.debug('##### value is ' + objKit);
        if (objKit == null) {
            return;
        }
        if(objKit instanceof EOF_EAI_Service_Log__c) {
            sLogCollgm.Id = cLogId;
            sLogCollgm.kit_in_condivisione__c = objKit.Id;
            update sLogCollgm;
        } else if (objKit instanceof Case) {
            // cerco log del case (kit) associato all'asset
            List<EOF_EAI_Service_Log__c> kitLogs = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE Caso__c =: objKit.Id];

            if(!kitLogs.isEmpty()) {
                sLogCollgm.Id = cLogId;
                sLogCollgm.kit_in_condivisione__c = kitLogs[0].Id;
                update sLogCollgm;
            }    
        }
	} 

    //LM START 2019 - 05 - 14
    public PageReference checkPopAssignedKIT(){
        string parentId= Apexpages.currentPage().getParameters().get('parentId');
        
        PageReference pg = ApexPages.currentPage();   
        pg.setRedirect(true);
        
        
        //EOF_EAI_Service_Log__c kitObj =  new EOF_EAI_Service_Log__c();
        
        Boolean isValid=false;
        
        List<String> stringValues = new List<String>();
        for(SelectOption so: optPopList){
            stringValues.add(so.getValue());
        }
        List<EOF_EAI_Service_Log__c> kitObj = [ SELECT id,PO_P2PAttiva_Optical_Rate_Limiting__c,EOF_ID_Pop__c,
                                               PO_P2PAttiva_KIT_Indirizzo_Consegna__c
                                               FROM EOF_EAI_Service_Log__c 
                                               WHERE EOF_SL_Riferimento__c  =: parentId
                                               AND EOF_ID_Pop__c =:hiddenValuePOP];
        System.debug('@@@optKITList'+kitObj);
        if(kitObj.size()>0){
            for(EOF_EAI_Service_Log__c kitL : kitObj){
                if(kitL.EOF_ID_Pop__c == hiddenValuePOP){
                    System.debug('dentro if');
                    isValid = true;
                    update kitObj;
                } 
            }  
        }
        if(isValid){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Esistono Kit con questo POP.');
            ApexPages.addMessage(myMsg); 
        }
        //initializeId();
        pg.getParameters().put('cLogId',cLogId);
        
        return pg;
    }       
    //LM END 2019 - 05 - 14

    //EC start 2018 - 09 - 26
    
    public PageReference getkitLogList()  {
        
        optKITList= new List<SelectOption>();
        optKITList.add(new SelectOption('-','-'));  
        
        initializeId();
        if(parentId==null || parentId==''){
            parentId=[select id,EOF_SL_Riferimento__c from EOF_EAI_Service_Log__c where id=: Apexpages.currentPage().getParameters().get('cLogId')].EOF_SL_Riferimento__c;
        }
        System.debug('@@@@PARENTID'+parentId);
        List<EOF_EAI_Service_Log__c> kitList = [SELECT id, Name, Caso__c, Caso__r.Status, Caso__r.ParentId,Caso__r.CaseNumber, PO_Offerta__c,PO_Nome_Progetto__c,ownerId,
                                                EOF_Codice_Ordine_OLO__c,EOF_Stato_Richiesta__c,CreatedDate,PO_Nota_sito__c, EOF_Codice_Operatore__c, EOF_Tipo_Comunicazione_String__c,
                                                EOF_STATO_ORDINE__c, EOF_SL_Riferimento__c, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,PO_Tipo_percorso__c, caso__r.CreatedDate, 
                                                caso__r.ClosedDate,Caso__r.parent.parent.PO_isDataOrder__c, Caso__r.PO_Nome_E_Cognome_PM__c, Caso__r.PO_Data_Attivazione_Richiesta__c, 
                                                Caso__r.PO_Numero_Telefonico_PM__c,PO_Indirizzo_collegamento__c, EOF_Comune__c,EOF_ID_Pop__c,PO_P2PAttiva_Optical_Rate_Limiting__c,
                                                PO_P2PAttiva_KIT_Indirizzo_Consegna__c,PO_P2PAttiva_Nome_del_KIT__c
                                                FROM EOF_EAI_Service_Log__c 
                                                WHERE EOF_SL_Riferimento__c =: parentId
                                                AND RecordType.DeveloperName = 'PO_Log_P2P_Attiva_KIT' /*and EOF_STATO_ORDINE__c in ('In Lavorazione',
'Accettato',
'Acquisito',
'In Approvazione Cliente')*/];
        
        if(kitList.size()>0){
            for(EOF_EAI_Service_Log__c kitL : kitList){
                if(kitL.PO_P2PAttiva_Nome_del_KIT__c!=null){
                    optKITList.add(new SelectOption(kitL.PO_P2PAttiva_Nome_del_KIT__c,kitL.PO_P2PAttiva_Nome_del_KIT__c));  
                }
            }
        }
        system.debug('optKITList======='+optKITList);
        system.debug('parentId======='+parentId);
        system.debug('kitList======='+kitList);
        
        PageReference pg;
        return pg;
    }
    
    //EC end 2018 - 09 - 26    
      
    public pagereference redirectFindKIT(){
        /* pagereference pr = new pagereference('/apex/PO_PP_FindKitPage');
        pr.setRedirect(true);
        return pr;
        */
        return null; 
    }
    //EC 2018 - 12 - 24 nuovo metodo eliminaKitLog
    
    public pageReference eliminaKitLog(){
        Pagereference pg= new PageReference(ApexPages.currentPage().getParameters().get('retUrl'));
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        pg.getParameters().put('cLogId',cLogId);
        List<EOF_EAI_Service_Log__c> totaleLogToDelete = new List<EOF_EAI_Service_Log__c>();
        
        List<EOF_EAI_Service_Log__c> kit = [Select id, RecordType.developerName from EOF_EAI_Service_Log__c where id=:Apexpages.currentPage().getParameters().get('kitId')];
        system.debug('@@@@@@EC chiamato il metodo eliminakitLog. il primo log da eliminare (il kit) verifica il recordtype: ' + kit);
        
        totaleLogToDelete.addAll(kit);
        // Nella nuova navigazione (E-access), posso eliminare un kit separatamente
        //EC il campo OF_SA_KIT_CONSEGNA_VLAN__c è un campo stringa, mentre OF_PP_KIT_Log__c è un campo di lookup
        /* List<EOF_EAI_Service_Log__c> vlanAssociateAlKitToDelete = [Select id, RecordType.developerName, 
                                                                   OF_SA_KIT_CONSEGNA_VLAN__c, OF_PP_KIT_Log__c
                                                                   from EOF_EAI_Service_Log__c 
                                                                   where RecordType.developerName='OF_SA_Vlan' 
                                                                   and OF_PP_KIT_Log__c=:Apexpages.currentPage().getParameters().get('kitId')];
        system.debug('@@@@@EC gli altri log da eliminare (le Vlan che hanno il kit da eliminare) sono in tutto: ' + vlanAssociateAlKitToDelete.size() +', verifica il recordType: ' + vlanAssociateAlKitToDelete);															
        
        totaleLogToDelete.addAll(vlanAssociateAlKitToDelete);
        system.debug('@@@@@EC il totale dei log da eliminare è: ' + vlanAssociateAlKitToDelete.size()); */

        if(totaleLogToDelete.size()>0){
            delete totaleLogToDelete;
            update updateVlan('', null);
            
        }
        pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
        return pg;
        
    }
    //End 2018 - 12 - 24
    /*EC ToDelete se funziona la nuova versione (sopra, ha lo stesso nome), altrimenti ripristinare. 2018 - 12 - 24
    public pageReference eliminaKitLog(){
        Pagereference pg= new PageReference(ApexPages.currentPage().getParameters().get('retUrl'));
        if(ApexPages.currentPage().getParameters().get('from')=='InsVlan'){
        delete slestratta;
        pg.getParameters().put('IdVLAN',ApexPages.currentPage().getParameters().get('slVlan'));
        pg.getParameters().put('Mode','mod');
        EOF_EAI_Service_Log__c slVlan = new EOF_EAI_Service_Log__c();
        slVlan.Id=ApexPages.currentPage().getParameters().get('slVlan');
        slVlan.OF_SA_KIT_CONSEGNA_VLAN__c=null;
        update slVlan;
        return pg;
        }
        if(ApexPages.currentPage().getParameters().get('op')=='ins'){
        delete slestratta;
        return pg;
        }
        if(ApexPages.currentPage().getParameters().get('from')=='RiepReq'){
        //se elimina il kit e il kit ha delle vlan associate vengono eliminate anche le vlan
        if(checkDelete){
        vlanLogChild.add(slestratta);
        delete vlanLogChild;
        }
        else{
        delete slestratta;
        }
        return pg;
        }
        return pg;
        }
        */
    public pageReference annullaKitLog(){
        Pagereference pg= new PageReference(ApexPages.currentPage().getParameters().get('retUrl'));
        if(ApexPages.currentPage().getParameters().get('from')=='InsVlan'){
            //delete slestratta;
            pg.getParameters().put('IdVLAN',ApexPages.currentPage().getParameters().get('slVlan'));
            pg.getParameters().put('Mode','mod');
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            EOF_EAI_Service_Log__c slVlan = new EOF_EAI_Service_Log__c();
            slVlan.Id=ApexPages.currentPage().getParameters().get('slVlan');
            slVlan.OF_SA_KIT_CONSEGNA_VLAN__c=null;
            update slVlan;
            return pg;
        }
        if(ApexPages.currentPage().getParameters().get('op')=='ins'){
            pg.getParameters().put('tipoP2Patt',tipoP2PAttiva);
            pg.getParameters().put('cLogId',cLogId);
            //delete slestratta;
            return pg;
        }
        return pg;
    }
    
   public void scegliPop(){
        
        List<POPServfatt__c> popList = POPServfatt__c.getAll().values();
        optPopList = new List<SelectOption>();  //optNomeProgetto      public List<SelectOption>  optPopList
        optPopList.add(new SelectOption(' - ',' - '));
        for(POPServfatt__c pList : popList){
            optPopList.add(new SelectOption(pList.Name,pList.Name));
         }
    }
}