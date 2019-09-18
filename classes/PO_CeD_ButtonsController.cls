public class PO_CeD_ButtonsController {
    
    public Case originalCase{get;set;}
    public String title{get;set;}   
    public String CaseId{get;set;}
    public String idNotify{get;set;}
    public String urlRedir{get;set;}
    public String perform{get;set;}
    public final Case c{get;set;}  
    public boolean mostraNotePerOLO{get;set;}
    public boolean mostraNoteInterneOrdine{get;set;}
    public boolean erroreAssegnazione{get;set;}
    public boolean mostraNoteOperatore{get;set;}
    public boolean mostraAnnulla{get;set;}
    public boolean mostraPrendiInCarico{get;set;} 
    public boolean mostraSospeso{get;set;} 
    public boolean mostraEspletatoOK{get;set;}
    public boolean mostraEspletatoKO{get;set;} 
    public boolean mostraAccettazione {get;set;} 
    public boolean mostraCessato {get;set;} 
    public boolean mostraCessatoKO {get;set;} 
    public boolean mostraModifica {get;set;} 
    public boolean mostraErrore {get;set;} 
    public boolean mostraRDAC {get;set;} 
    public boolean mostraDesospeso {get;set;}
    
    public PO_CeD_ButtonsController(ApexPages.StandardController stdController){ 
        
        originalCase = (Case)stdController.getRecord();
        
        //CRM Modifica 31_08_2017 Aggiunta dei due campi 1.PO_BB_1_interessato__c 2.PO_Posa_1_nuovo_Drop__c nella query
        //AS modifica aggiunti campi Owner.Id,Owner.Type
        system.debug('CRM 28_01_2019 PO_CeD_ButtonsController originalCase:'+originalCase);
        
        originalCase = [select Id, casenumber, EOF_Codice_Operatore_WS__c, EOF_Codice_Ordine_OLO__c, Account.FirstName, Account.LastName,
                        Contact.name, recordtypeid, EOF_Note_Operatore__c, Status, EOF_GPON_Attestazione__c, EOF_Orario_Appuntamento__c,
                        EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name, EOF_Note__c, recordType.DeveloperName, 
                        EOF_Fase__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c, PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c,  
                        PO_Note_Supporto_Vendite__c, PO_Owner_Originario__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, 
                        EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Recapito_Telefonico_Cliente_1__c,
                        EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c, OF_Esito_Consegna_Apparato__c, 
                        OF_SA_Codice_Motivazione__c, OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, 
                        EOF_Comune_WS__c, EOF_Provincia_WS__c, EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, Previous_Status__c,
                        EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, OF_Order__c, Contact.Email, EOF_Data_Prevista_Attivazione__c
                        from Case 
                        where Id=:ApexPages.currentPage().getParameters().get('Id')]; 
         
        erroreAssegnazione = false;
         
        mostraNotePerOLO = false;
        mostraNoteOperatore = false;
        
        if(originalCase.recordType.DeveloperName.equalsIgnoreCase('EOF_Caso_Attivazione_OPENSTREAM_CeD') 
            || originalCase.recordType.DeveloperName.equalsIgnoreCase('EOF_SP_Caso_Attivazione_CeD')){
     
            mostraNoteInterneOrdine = true;
            
            if(ApexPages.currentPage().getParameters().get('OLO')=='true'){
                mostraNotePerOLO = true;
             }
        }
        showButtonRules();
    }
    
    public void showButtonRules(){
    
        //inizializzo la visibilità
        mostraPrendiInCarico = false; 
        mostraSospeso = false; 
        mostraDesospeso = false;
        //mostraInviaDelivery = false;
        //mostraInviaIng = false;
        mostraEspletatoOK = false;
        mostraEspletatoKO = false; 
        mostraAccettazione = false;
        mostraCessato = false;
        mostraCessatoKO = false; 
        mostraModifica = false;
        mostraErrore = false;
        
        // List<GroupMember> gMemberList=[select UserOrGroupId from GroupMember where GroupId =:userinfo.getUserId()]; //esiste l'utente nella coda
        List<User> gAdminList = [select name, Profile.Name 
                                 from User 
                                 where Id =:userinfo.getUserId()]; //esiste l'utente admin
        
        System.debug('>>> visibilita originalCase.Owner.Type : '+originalCase.Owner.Type+' - originalCase.status: '+originalCase.status);
        
        //CRITERI DI VISUALIZZAZIONE PULSANTI
        
        //Visualizzo i pulsanti se il recordType è quello dei Case di ATTIVAZIONE per OpenStreamCD e GPON Passiva CD
        if(originalCase.recordType.developerName.equalsIgnoreCase('EOF_Caso_Attivazione_OPENSTREAM_CeD') 
        ||  originalCase.recordType.developerName.equalsIgnoreCase('EOF_SP_Caso_Attivazione_CeD'))
        {
            if(originalCase.Owner.Type!='Queue' && originalCase.Status !='Sospeso' 
                && originalCase.Status != 'Espletato' && originalCase.Status != 'Espletato KO'){
                        
                 mostraSospeso = true;
                 mostraModifica = true;
            }
            if(originalCase.Owner.Type=='Queue' && (UserInQueueGET() || gAdminList[0].Profile.Name =='System Administrator')
                && originalCase.Status!='Sospeso' &&  originalCase.Status!='Acquisito KO' 
                && originalCase.Status!='Espletato' && originalCase.Status!='Espletato KO' && originalCase.Status!='Inviato'){
                
                mostraPrendiInCarico = true;
            }
            if(originalCase.Status=='Annullato')
            {
                mostraAnnulla = false;
                //mostraInviaIng = false;
                mostraEspletatoOK = false; 
                //mostraInviaDelivery = false;
                mostraEspletatoKO = false; 
                mostraPrendiInCarico = false; 
                mostraSospeso = false;
                mostraModifica = false;
            }
            if(originalCase.Status=='Acquisito' && originalCase.Owner.Type!='Queue')
            {
                //mostraAnnulla = true;
                //mostraModifica = true;
                mostraRDAC = true;
                mostraAccettazione = true; 
                //mostraSospendi = true;
            }
            if(originalCase.Status=='Accettato')
            {
                //mostraAnnulla = true;
                //mostraModifica = true;
                mostraRDAC = true;
                mostraEspletatoOK = true; 
                mostraEspletatoKO = true; 
                //mostraSospendi = true;
            }
            if(originalCase.Status=='Sospeso' && originalCase.Owner.Type!='Queue')
            {
                mostraDesospeso = true;
                mostraRDAC = true;
            }
        }
        //Visualizzo i pulsanti se il recordType è quello dei Case di CESSAZIONE per OpenStreamCD e GPON Passiva CD
        if(originalCase.recordType.developerName.equalsIgnoreCase('EOF_Caso_Cessazione_OPENSTREAM_CD') 
        ||  originalCase.recordType.developerName.equalsIgnoreCase('EOF_SP_Caso_Cessazione_CeD'))
        {
            if(originalCase.Owner.Type!='Queue' &&  originalCase.Status=='Acquisito')
            {
                mostraCessato = true;
                mostraCessatoKO = true; 
            }
        }
    }   
    
    //AS START
    public static String findObjectNameFromRecordIdPrefix(String recordIdOrPrefix){
        String objectName = '';
        try{
            //Get prefix from record ID
            //This assumes that you have passed at least 3 characters
            String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);
             
            //Get schema information
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
             
            //Loop through all the sObject types returned by Schema
            for(Schema.SObjectType stype : gd.values()){
                Schema.DescribeSObjectResult r = stype.getDescribe();
                String prefix = r.getKeyPrefix();
                System.debug('Prefix is ' + prefix);
                 
                //Check if the prefix matches with requested prefix
                if(prefix!=null && prefix.equals(myIdPrefix)){
                    objectName = r.getName();
                    System.debug('Object Name! ' + objectName);
                    break;
                }
            }
        }
        catch(Exception e){
            System.debug(e);
        }
        return objectName;
    }
    
    
    public boolean UserInQueueGET(){
        
        System.debug('@@@@ originalCase.Owner.Type=' + originalCase.Owner.Type);
        // se owner è una queue
        
        if(originalCase.Owner.Type=='Queue')
        { 
            Set<id> UserIdSet = new Set<Id>();
            string OwnerGroupId = originalCase.Owner.Id; //Owner.Id ne prendo l'id
            List<GroupMember> gMemberList = [select UserOrGroupId 
                                             from GroupMember 
                                             where GroupId =:OwnerGroupId]; //estraggo i membri della coda
            
            if(gMemberList!=null && !gMemberList.isEmpty()) {
                for(GroupMember gMember:gMemberList){
                    if(findObjectNameFromRecordIdPrefix(gMember.UserOrGroupId)=='User'){
                        if(gMember.UserOrGroupId==UserInfo.getUserId()){ //se sono tra i membri della coda allora posso predenre in carico
                            return true;
                        }  
                    }
                    if(findObjectNameFromRecordIdPrefix(gMember.UserOrGroupId)=='Group'){
                        Group testgroup =[select RelatedId from Group where id =:gMember.UserOrGroupId];
                        if(testgroup.RelatedId==UserInfo.getUserRoleId()){ //se sono tra i membri della coda allora posso predenre in carico
                            return true;
                        }  
                    }      
                }
            }
        }
        return false;//altrimenti no
    }

    public Boolean UserInQueue{get{
        return UserInQueueGET();
    }}

    public void PrendiInCarico(){

        originalCase.Previous_Status__c = originalCase.status;
        originalCase.OwnerId = userinfo.getUserId();
        update originalCase; 
    }
    
    public void cessato_OK(){
        
        System.debug('<<< Cessato OK >>>');
        update originalCase;

        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.STATO_ORDINE = '6'; //CESSATO OK
        Notify.NOME_CLIENTE = originalCase.Account.FirstName;
        Notify.COGNOME_CLIENTE = originalCase.Account.LastName;
        Notify.GPON_DI_ATTESTAZIONE = originalCase.EOF_GPON_Attestazione__c;
        Notify.RECAPITO_TELEFONICO_CLIENTE = originalCase.EOF_Recapito_Telefonico_Cliente_1__c;
        Notify.DATA_PREVISTA_ATTIVAZIONE = String.valueOfGmt(originalCase.EOF_Data_Prevista_Attivazione__c);
        Notify.ORARIO_APPUNTAMENTO = originalCase.EOF_Orario_Appuntamento__c;
        //Notify.PIN_INTERVENTO_A_VUOTO='Y';
        Notify.NOTE = originalCase.EOF_Note__c;

        OF_SA_CD_WS_IN_OM.CD_OM_Notify_StatusUpdate(Notify);
    }
    
    public void cessato_KO(){
        
        System.debug('<<< Cessato KO >>>');
        originalCase.OF_SA_Codice_Motivazione__c = 'B07';
    	originalCase.OF_SA_Motivazione__c = 'ID Risorsa da cessare inesistente/errato';
        update originalCase;

        OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate Notify = new OF_SA_WS_IN_OM_StatusUpdate.OM_Notify_StatusUpdate();
        Notify.CODICE_OPERATORE = originalCase.EOF_Codice_Operatore_WS__c;
        Notify.CODICE_ORDINE_OLO = originalCase.EOF_Codice_Ordine_OLO__c;
        Notify.CODICE_ORDINE_OF = originalCase.id;
        Notify.DATA_NOTIFICA = System.Now().format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
        Notify.ID_NOTIFICA = String.valueOf(system.now().getTime());
        Notify.STATO_ORDINE = '7'; //CESSATO KO
        Notify.NOME_CLIENTE = originalCase.Account.FirstName;
        Notify.COGNOME_CLIENTE = originalCase.Account.LastName;
        Notify.GPON_DI_ATTESTAZIONE = originalCase.EOF_GPON_Attestazione__c;
        Notify.RECAPITO_TELEFONICO_CLIENTE = originalCase.EOF_Recapito_Telefonico_Cliente_1__c;
        Notify.DATA_PREVISTA_ATTIVAZIONE = String.valueOfGmt(originalCase.EOF_Data_Prevista_Attivazione__c);
        Notify.ORARIO_APPUNTAMENTO = originalCase.EOF_Orario_Appuntamento__c;
        //Notify.PIN_INTERVENTO_A_VUOTO='Y';
        Notify.NOTE = originalCase.EOF_Note__c;
        Notify.CODICE_MOTIVAZIONE = originalCase.OF_SA_Codice_Motivazione__c;
        Notify.MOTIVAZIONE = originalCase.OF_SA_Motivazione__c;

        OF_SA_CD_WS_IN_OM.CD_OM_Notify_StatusUpdate(Notify);
    }
    
    //Metodi vuoti e inutili ma necessari al deploy R4 in PROD 
    //Da cancellare 
    public void accettazione() 
    {
        
    }
    
    public void espletamento_OK()
    {
        
    }
    
    public void espletamento_KO()
    {
        
    }
    
    public void annulla()
    {
        
    }
}