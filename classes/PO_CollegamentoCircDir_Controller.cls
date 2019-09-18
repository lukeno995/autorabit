public class  PO_CollegamentoCircDir_Controller {
    public Case originalCase {get; set;}
    public String title {get; set;}
    public String CaseId {get; set;}
    public String idNotify {get; set;}
    public String urlRedir {get; set;}
    public String perform {get; set;}
    public final Case c {get; set;}
    public boolean showModifica {get; set;}
    public boolean prendiInCaricoP2PAttiva {get; set;}
    public boolean viewPopUpPSM {get; set;}
    public boolean viewErrorFilePopUpPSM {get; set;}
    public Boolean UserInQueue {get; set;}
   // public Boolean ordineFattibilita {get; set;}
    public Boolean mostraNoteInterneOrdine {get; set;}
    public Boolean mostraNotePerOLO {get; set;}
    public boolean queueIng {get; set;}
    public boolean showFattibilitaCompletata {get; set;}
    public User usr {get; set;}
    
    public PO_CollegamentoCircDir_Controller(ApexPages.StandardController stdController) {
        originalCase = (Case)stdController.getRecord();
        system.debug('PO_CollegamentoCircDir_Controller originalCase:' + originalCase);
        originalCase=[select Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
                      EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c, PO_Tipologia_Offerta__c,
                      PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
                      PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
                      PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
                      PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
                      EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
                      OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
                      OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
                      EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
                      PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
                      isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
                      PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
                      OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c, PO_Posa_2_nuovo_Drop__c, PO_BB_2_interessato__c  // RDG
                      from Case where Id=:ApexPages.currentPage().getParameters().get('Id')];
        UserInQueue=false;
        prendiInCaricoP2PAttiva=false;
        queueIng=false; //2018 - 09 - 28
        showModifica = originalCase.owner.Id == UserInfo.getUserId() && !originalCase.isClosed && originalCase.EOF_Fase__c != 'In Attesa di Assegnazione' && originalCase.EOF_Fase__c !='In Lavorazione Network Creation' && (originalCase.status == 'Accettato' || originalCase.status == 'In Lavorazione' || originalCase.Status == 'Acquisito');
        User u =  [Select Id, ProfileId,UserRoleId, Profile.Name From User Where Id =:System.UserInfo.getUserId()];
        system.debug('@@@@@@OWNER'+originalCase.OwnerId);
        system.debug('@@@@@@OWNER'+originalCase.Owner.Type);
        if (originalCase.Owner.Type == 'Queue') { // se owner è una queue
            Set<id> UserIdSet = new Set<Id>();
            if (u.Profile.Name == 'System Administrator') {UserInQueue= true;}
            else{
                List<GroupMember> groupMemberList = [SELECT UserOrGroupId FROM GroupMember WHERE GroupId =:originalCase.Owner.Id];
                Set<Id> groupMemberIds = new Set<Id>();
                for (GroupMember gm : groupMemberList) {
                    groupMemberIds.add(gm.UserOrGroupId);
                }
                Map<Id, Group> mapIdGroup = new Map<Id, Group>([SELECT Id, RelatedId FROM Group WHERE Id IN: groupMemberIds]);
                for (Id gmId : groupMemberIds) {
                    if (findObjectNameFromRecordIdPrefix(gmId) == 'User') {
                        if (gmId == u.Id) { //se sono tra i membri della coda allora posso predenre in carico
                            UserInQueue= true;
                            break;
                        }
                    }
                    if (findObjectNameFromRecordIdPrefix(gmId) == 'Group') {
                        Group testgroup = mapIdGroup.get(gmId);
                        if ((testgroup != null) && (testgroup.RelatedId == u.UserRoleId)) { //se sono tra i membri della coda allora posso predenre in carico
                            UserInQueue= true;
                            break;
                        }
                    }
                }
            }
        }
        else if (originalCase.recordType.DeveloperName.contains('Ordine')) {
            mostraNoteInterneOrdine=true;
            if (ApexPages.currentPage().getParameters().get('OLO') == 'true') {mostraNotePerOLO=true;}
        }
        this.setViewPopUpPSM();
        this.setViewErrorFilePopUpPSM();
    }
    
    public static String findObjectNameFromRecordIdPrefix(String recordIdOrPrefix) {
        String objectName = '';
        try {
            //Get prefix from record ID
            //This assumes that you have passed at least 3 characters
            String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);
            
            //Get schema information
            Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe();
            
            //Loop through all the sObject types returned by Schema
            for (Schema.SObjectType stype : gd.values()) {
                Schema.DescribeSObjectResult r = stype.getDescribe();
                String prefix = r.getKeyPrefix();
                System.debug('Prefix is ' + prefix);
                
                //Check if the prefix matches with requested prefix
                if ((prefix != null) && prefix.equals(myIdPrefix)) {
                    objectName = r.getName();
                    System.debug('Object Name! ' + objectName);
                    break;
                }
            }
        }catch (Exception e) {System.debug(e);}
        return objectName;
    }
    
    public void PrendiInCarico() {
            originalCase.EOF_Fase__c='In Lavorazione';
            originalCase.Status='In Lavorazione';
            originalCase.PO_CircuitiDiretti__c=true;
            originalCase.OwnerId=userinfo.getUserId();
            update originalCase;
        EOF_EAI_Service_Log__c ChildLog = [SELECT id
                                           FROM EOF_EAI_Service_Log__c
                                           WHERE Caso__c = :originalCase.ID
                                           LIMIT 1];
        ChildLog.EOF_STATO_ORDINE__c = 'In Lavorazione';
        update ChildLog;
        
            return;
    }
    
    public void updateLog(String idChildCase) {
        system.debug('@@@@EC chiamiamo il metodo updateLog a cui passiamo un solo parametro, idChildCase: ' + idChildCase);
        Case childCase = [Select id, Status, PO_Disponibilit_della_rete_a_partire_da__c, PO_Tempi_di_attivazione_mesi__c from Case where id=: idChildCase]; //FD 2019-03-06
        EOF_EAI_Service_Log__c ChildLog = [SELECT id, EOF_Stato_Richiesta__c, EOF_STATO_ORDINE__c, Caso__c, eof_comunicazioni_con_olo__c, caso__r.Note_Sospensione_Operatore__c, EOF_NOTE__c, PO_Disponibilit_della_rete_a_partire_da__c, PO_Tempi_di_attivazione_mesi__c
                                           FROM EOF_EAI_Service_Log__c
                                           WHERE Caso__c = :idChildCase
                                           LIMIT 1]; //FD 2019-03-06
        system.debug('@@@@EC chiamiamo nel metodo updateLog creiamo e popoliamo serviceLog, ChildLog i cui valori sono: ' + ChildLog + ', dovrebbe essere un solo ChildLog');
        ChildLog.EOF_STATO_ORDINE__c = childCase.Status;
        // faccio l'update del campo comunicazioni con OLO sul log
        if (ChildLog.eof_comunicazioni_con_olo__c != null) {
            ChildLog.eof_comunicazioni_con_olo__c = ChildLog.eof_comunicazioni_con_olo__c + '\n' + OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + ChildLog.caso__r.Note_Sospensione_Operatore__c;
        }
        else{
            ChildLog.eof_comunicazioni_con_olo__c =  OM_GW_GE_Utils.DateToString(system.now()).left(19) + ' - ' + 'Desospensione OF' + ' - ' + userinfo.getName() + ':\n' + ChildLog.caso__r.Note_Sospensione_Operatore__c;
        }
        // finisce qui
        
        //FD 2019-03-06
        System.debug('@@@ PO_Tempi_di_attivazione_mesi__c: ' + childCase.PO_Tempi_di_attivazione_mesi__c);
        System.debug('@@@ PO_Disponibilit_della_rete_a_partire_da__c: ' + childCase.PO_Disponibilit_della_rete_a_partire_da__c);
        ChildLog.PO_Tempi_di_attivazione_mesi__c = childCase.PO_Tempi_di_attivazione_mesi__c;
        ChildLog.PO_Disponibilit_della_rete_a_partire_da__c = childCase.PO_Disponibilit_della_rete_a_partire_da__c;
        
        update ChildLog;
        system.debug('abbiamo appena terminato l\'update dello stato ChildLog, che adesso è: ' + ChildLog.EOF_STATO_ORDINE__c);
    }
    
    public void setViewPopUpPSM () {
        if (originalCase.view_PopUp_PSM__c) {viewPopUpPSM=true;}
        else{viewPopUpPSM=false;}
    }
    
    public void setViewErrorFilePopUpPSM() {
        if (originalCase.view_error_file_PSM__c) {viewErrorFilePopUpPSM=true;}
        else{ViewErrorFilePopUpPSM=false;}
    }
    
    public void InvioPSM() {
        System.debug('PO_CollegamentoCircDir_Controller - dentro InvioPSM');
        originalCase.Status ='In Lavorazione';
        originalCase.EOF_Fase__c= 'In Lavorazione Network Creation';
        originalCase.PO_FATT_History_Owner__c = UserInfo.getUserId();
        update originalCase;
        eof_notify__c iPSM = new eof_notify__c();
        if (!Test.isRunningTest()) {iPSM.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Attivazione').getRecordTypeId();}
        iPSM.EOF_Data_Notifica__c = system.now();
        iPSM.Caso__c = originalCase.id;
        insert iPSM;
        
        Case cpsm =[Select id, EOF_Note_Interne__c, PO_Nome_E_Cognome_PM__c, PO_Case_Collegamento__r.PO_Esito_collegamento__c,
                    EOF_Account_OLO__r.Name, PO_Tipologia_Offerta_ordine__c, PO_Tipo_percorso__c,
                    PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, PO_Case_Collegamento__r.EOF_ID_Risorsa__c,
                    //GB 12.05 start
                    PO_Case_Collegamento__r.PO_Tipologia_Offerta_ordine__c, PO_Case_Collegamento__r.PO_Comune2__c, PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c, PO_Indirizzo_collegamento__c,PO_Sito__c,PO_Nome_Comune__c,PO_Civico__c,PO_Sito_partenza__c,
                    PO_Indirizzo_collegamento_partenza__c, PO_Nome_Comune3__c,PO_Civico_partenza__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,
                    PO_Nome_Comune4__c, PO_Civico_3__c,CaseNumber,
                    //GB 12.05 end
                    PO_Numero_fibre_richieste__c, Contact.Name, PO_Case_Collegamento__r.PO_Posa_2_nuovo_Drop__c,
                    PO_Case_Collegamento__r.PO_BB_2_via_interessato__c, EOF_Codice_Ordine_OLO__c, PO_Case_Collegamento__r.LastModifiedBy.Name,
                    PO_Data_Attivazione_Richiesta__c, PO_Case_Collegamento__r.OF_Order__r.CreatedDate,
                    PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c, PO_Case_Collegamento__r.PO_BB_1_interessato__c, PO_Case_Collegamento__r.PO_BB_2_interessato__c,
                    PO_Pop_1_di_riferimento2__c, PO_Pop_2_di_riferimento2__c, PO_Case_Collegamento__r.PO_Drop_FL_1__c, PO_Case_Collegamento__r.PO_Drop_FL_2__c,
                    PO_Case_Collegamento__r.PO_Posa_1_nuovo_Drop__c, PO_Case_Collegamento__r.PO_Posa_1_via_nuovo_Drop__c, PO_Case_Collegamento__r.PO_Posa_2_via_nuovo_Drop__c,
                    PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c, PO_Case_Collegamento__r.PO_BB_1_via_interessato__c, PO_Case_Collegamento__r.PO_Lunghezza_m__c,
                    PO_Case_Collegamento__r.PO_Lunghezza_m2__c, PO_Case_Collegamento__r.PO_Note_fattibilit__c,
                    PO_Case_Collegamento__r.PO_Note_Network_Creation__c, PO_Case_Collegamento__r.CaseNumber,
                    PO_Case_Collegamento__r.PO_Pop_1_di_riferimento2__r.Name, PO_Case_Collegamento__r.PO_Pop_2_di_riferimento2__r.Name,Account.Name,CreatedDate
                    from Case where ID =:iPSM.Caso__c];
        
        EOF_EAI_Service_Log__c slA = new EOF_EAI_Service_Log__c();
        slA.RecordTypeId = Schema.SObjectType.EOF_EAI_Service_log__c.getRecordTypeInfosByName().get('PSM WS OUT Attivazione').getRecordtypeid();
        slA.Caso__c = originalCase.id;
        slA.Notify__c = iPSM.id;
        slA.EOF_ID_Notifica__c = iPSM.Name;
        slA.OF_SA_Azione__c =PO_FATT_WS_PSM_Notify_Utils.AZIONE_ATTIVAZIONE;
        slA.EOF_Data_Notifica__c = iPSM.EOF_Data_notifica__c;
        slA.EOF_Richiesta_Notifica__c=
            'NOTE_ORDINE: ' + cpsm.EOF_Note_Interne__c  + '\n' +
            'PM_DI_RIFERIMENTO: ' + cpsm.PO_Nome_E_Cognome_PM__c  + '\n' +
            //'ESITO_FATTIBILITA: '+ cpsm.PO_Case_Collegamento__r.PO_Esito_collegamento__c  + '\n' +
            'ESITO_FATTIBILITA: ' +  PO_FATT_WS_PSM_Notify_Utils.getEsitoFattibilita(new EOF_Notify__c(Caso__r=cpsm))  + '\n' +  //da portare in sviluppo
            'ACCOUNT: ' + PO_FATT_WS_PSM_Notify_Utils.getAccount(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +  //fix del 01.06
            'TIPO_DI_CONTRATTO: ' + PO_FATT_WS_PSM_Notify_Utils.getTipoDiContratto(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +  //fix del 01.06
            'TIPO_DI_PERCORSO: ' + PO_FATT_WS_PSM_Notify_Utils.getTipoDiPercorso(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
            'TIPO_DI_COLLEGAMENTO: ' + PO_FATT_WS_PSM_Notify_Utils.getTipoCollegamento(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
            'PRIME_CONTRACTOR: ' + cpsm.PO_Prime_Contractor__c  + '\n' +
            'FIBRE_RICHIESTE: ' + cpsm.PO_Numero_fibre_richieste__c + '\n' +
            'RICHIEDENTE: ' + cpsm.Contact.Name  + '\n' +
            'CODICE_ISTAT_SEDE_1: ' + cpsm.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c + '\n' +
            'DENOMIN_SEDE_1: ' + cpsm.PO_Sito__c + '\n' +
            'NOME_VIA_SEDE_1: ' + cpsm.PO_Indirizzo_collegamento__c + '\n' +
            'COMUNE_SEDE_1: ' + cpsm.PO_Nome_Comune__c + '\n' +
            'CIVICO_SEDE_1: ' + cpsm.PO_Civico__c + '\n' +
            //'CODICE_ISTAT_SEDE_2: '+ cpsm.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c + '\n' +
            'CODICE_ISTAT_SEDE_2: N.A. \n' +
            'DENOMIN_SEDE_2: ' + cpsm.PO_Sito_partenza__c + '\n' +
            'NOME_VIA_SEDE_2: ' + cpsm.PO_Indirizzo_collegamento_partenza__c + '\n' +
            'COMUNE_SEDE_2: ' + cpsm.PO_Nome_Comune3__c + '\n' +
            'CIVICO_SEDE_2: ' + cpsm.PO_Civico_partenza__c + '\n' +
            //'CODICE_ISTAT_SEDE_3: '+ cpsm.PO_Case_Collegamento__r.PO_Comune2__r.OF_CodiceIstat__c + '\n' +
            'CODICE_ISTAT_SEDE_3: N.A. \n' +
            'DENOMIN_SEDE_3: ' + cpsm.PO_Sito_3__c + '\n' +
            'NOME_VIA_SEDE_3: ' + cpsm.PO_indirizzo_collegamento_3__c + '\n' +
            'COMUNE_SEDE_3: ' + cpsm.PO_Nome_Comune4__c + '\n' +
            'CIVICO_SEDE_3: ' + cpsm.PO_Civico_3__c + '\n' +
            'LUNGHEZZA_DROP_FL_2_LEASE: ' + PO_FATT_WS_PSM_Notify_Utils.getLungDropFlLease2(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
            'CAVO_TRATTA_SECONDA_VIA: ' + cpsm.PO_Case_Collegamento__r.PO_BB_2_via_interessato__c  + '\n' +
            'ID_CIRCUITO_PRIMA_TRATTA: ' + PO_FATT_WS_PSM_Notify_Utils.getIdCircuitoTratta1(cpsm.id)  + '\n' +
            'ID_CIRCUITO_SECONDA_TRATTA: ' + PO_FATT_WS_PSM_Notify_Utils.getIdCircuitoTratta2(cpsm.id)  + '\n' +
            'CODICE_ORDINE: ' + cpsm.casenumber  + '\n' +
            'ID_NOTIFICA: ' + iPSM.id  + '\n' +
            'DATA_NOTIFICA: ' + PO_FATT_WS_PSM_Notify_Utils.dateToString(iPSM.EOF_Data_Notifica__c)  + '\n' +
            'AZIONE: ' + PO_FATT_WS_PSM_Notify_Utils.AZIONE_ATTIVAZIONE  + '\n' +
            'FATTIBILITA_CREATA_DA: ' + cpsm.PO_Case_Collegamento__r.LastModifiedBy.Name  + '\n' +
            //'DATA_ORDINE: '+ PO_FATT_WS_PSM_Notify_Utils.dateToString(cpsm.PO_Case_Collegamento__r.OF_Order__r.CreatedDate)  + '\n' +
            'DATA_ORDINE: ' + PO_FATT_WS_PSM_Notify_Utils.dateToString(cpsm.CreatedDate)  + '\n' + //01.06
            'DISPONIBILITA_RETE: ' + PO_FATT_WS_PSM_Notify_Utils.dateYMToString(cpsm.PO_Case_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) + '\n' +
            'BB_1_INTERESSATO: ' + cpsm.PO_Case_Collegamento__r.PO_BB_1_interessato__c  + '\n' +
            'BB_2_INTERESSATO: ' + cpsm.PO_Case_Collegamento__r.PO_BB_2_interessato__c  + '\n' +
            'POP_DI_RIFERIMENTO_1: ' + cpsm.PO_Case_Collegamento__r.PO_Pop_1_di_riferimento2__r.Name + '\n' +
            'POP_DI_RIFERIMENTO_2: ' + cpsm.PO_Case_Collegamento__r.PO_Pop_2_di_riferimento2__r.Name + '\n' +
            'DROP_FL_1: ' + cpsm.PO_Case_Collegamento__r.PO_Drop_FL_1__c  + '\n' +
            'DROP_FL_2: ' + cpsm.PO_Case_Collegamento__r.PO_Drop_FL_2__c  + '\n' +
            'LUNGHEZZA_DROP_FL_LEASE: ' + PO_FATT_WS_PSM_Notify_Utils.getLungDropFlLease(new EOF_Notify__c(Caso__r=cpsm)) + '\n' +
            'POSA_1_NUOVO_CAVO: ' + cpsm.PO_Case_Collegamento__r.PO_Posa_1_via_nuovo_Drop__c  + '\n' +
            'POSA_2_NUOVO_CAVO: ' + cpsm.PO_Case_Collegamento__r.PO_Posa_2_via_nuovo_Drop__c + '\n' +
            'TEMPI_DI_ATTIVAZIONE_MESI: ' + cpsm.PO_Case_Collegamento__r.PO_Tempi_di_attivazione_mesi__c  + '\n' +
            'CAVO_TRATTA_PRIMA_VIA: ' + string.valueof(cpsm.PO_Case_Collegamento__r.PO_BB_1_via_interessato__c)  + '\n' +
            'LUNGHEZZA_DROP_FL: ' + cpsm.PO_Case_Collegamento__r.PO_Lunghezza_m__c  + '\n' +
            'LUNGHEZZA_DROP_FL_2: ' + cpsm.PO_Case_Collegamento__r.PO_Lunghezza_m2__c + '\n' +
            'NOTE_FATTIBILITA: ' + cpsm.PO_Case_Collegamento__r.PO_Note_fattibilit__c + '\n' +
            'NOTE: ' + cpsm.PO_Case_Collegamento__r.PO_Note_Network_Creation__c  + '\n' +
            'DATA_ATTIVAZIONE_RICHIESTA_CLIENTE: ' + string.valueof(PO_FATT_WS_PSM_Notify_Utils.stringToDateNoTime(cpsm.PO_Data_Attivazione_Richiesta__c))  + '\n' +
            'NOTE_COLLEGAMENTO: ' + 'Note Fattibilità: ' + cpsm.PO_Case_Collegamento__r.PO_Note_fattibilit__c + 'Note: ' + cpsm.PO_Case_Collegamento__r.PO_Note_Network_Creation__c + '\n' +
            'DATA_ORDINE_COMPLETATO: ' + PO_FATT_WS_PSM_Notify_Utils.getDataOrdineCompletato(iPSM.Caso__c) + '\n' +
            'ID_COLLEGAMENTO: ' + cpsm.PO_Case_Collegamento__r.CaseNumber + '\n';
        insert slA;
        
        List<Attachment> attachList = [Select id, ParentId, Name, ContentType, BodyLength, Body, OwnerId, CreatedDate, CreatedById,
                                       CreatedBy.Name, LastModifiedDate,LastModifiedById,LastModifiedBy.Name, Description
                                       from Attachment where ParentId=:cpsm.PO_Case_Collegamento__c];
        system.debug('insert attach');
        //Allego il file al Log
        if ((attachList != null) && (attachList.size() > 0)) {insert PO_FATT_WS_PSM_Notify_Utils.attachingFileOutbound(attachList,slA.id);}
        system.debug('dopo attach');
    }

}