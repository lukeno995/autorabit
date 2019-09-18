public class PO_PP_Buttons_Controller {
    
    public Case originalCase{get;set;}
    public String title{get;set;}
    public String CaseId{get;set;}
    public String idNotify{get;set;}
    public String urlRedir{get;set;}
    public String perform{get;set;}
    public final Case c{get;set;}
    public boolean mostraNotePerOLO{get;set;}
    public boolean mostraNoteInterneOrdine{get;set;}
    public boolean mostraNoteInterneNetworkCreation{get;set;}
    public boolean erroreAssegnazione{get;set;}
    public boolean collegamentoFattibilita{get;set;}
    public boolean ordineFattibilita{get;set;}
    public boolean richiestaFattibilita{get;set;}
    public boolean mostraNoteOperatore{get;set;}
    public boolean mostraNoteTecFatToNetCre{get;set;}
    public boolean mostraNoteTecFatToRefFat{get;set;}
    public boolean mostraNoteSupVenToRefFat{get;set;}
    public boolean mostraNoteRefFatToSupVen{get;set;}
    public boolean mostraNoteRefFatToTecFat{get;set;}
    public boolean mostraNoteNetCreToTecFat{get;set;}    
    // usate per la gestione dei tasti del kit
    public boolean mostraModifica{get;set;}
    public boolean mostraAnnulla{get;set;}
    public boolean mostraPrendiInCarico{get;set;} 
    public boolean mostraSospendi{get;set;} 
    public boolean mostraInviaDelivery{get;set;}
    public boolean mostraInviaIng{get;set;}
    public boolean mostraEspletatoOK{get;set;}
    public boolean mostraNomeKit{get;set;}
    public boolean mostraEspletatoKO{get;set;} 
    public boolean nomeKitObb {get;set;} 
    //fine
    public static ID createAssetId{get;set;}
    public String ruoloDiPartenza{get;set;}
   // public String checkEsiti{get;set;} 
    
    public boolean viewPopUpPSM {get;set;}
    public boolean viewErrorFilePopUpPSM{get;set;}
    
    public PO_PP_Buttons_Controller(ApexPages.StandardController stdController){ 
        
        originalCase = (Case)stdController.getRecord();
        
        //CRM Modifica 31_08_2017 Aggiunta dei due campi 1.PO_BB_1_interessato__c 2.PO_Posa_1_nuovo_Drop__c nella query
        //AS modifica aggiunti campi Owner.Id,Owner.Type
        system.debug('CRM 03_08_2017 PO_ServiziFattibilita_Controller originalCase:'+originalCase);
        
        originalCase=[select Id, PO_PP_NomeKit__c,recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name, 
                    EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c, 
                    PO_Richiesta_a_fattibilit__c, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c, 
                    PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c, 
                    PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c, 
                    PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c, 
                    EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c, 
                    OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c, 
                    OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c, 
                    EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c, 
                    PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c,Contact.Email
                    ,PO_PP_Posizione_ODF__c ,Contact.name,CaseNumber
                    from Case 
                    where Id=:ApexPages.currentPage().getParameters().get('Id')]; 
         
         erroreAssegnazione=false;
         collegamentoFattibilita=false;
         ordineFattibilita=false;
         richiestaFattibilita=false;
         mostraNomeKit=false;
         
         mostraNotePerOLO=  false;
         mostraNoteInterneOrdine=false;
         mostraNoteTecFatToNetCre=false;
         mostraNoteInterneNetworkCreation=false;
         mostraNoteOperatore=false;
         mostraNoteTecFatToRefFat=false;
         mostraNoteTecFatToNetCre=false;
         mostraNoteSupVenToRefFat=false;
         mostraNoteRefFatToSupVen=false;
         mostraNoteRefFatToTecFat=false;
         mostraNoteNetCreToTecFat=false;
         nomeKitObb=false;
         
         //AA 04/09/2018 - Aggiunta condizione per P2PAttiva per mostrare le note come da richiesta
         if(originalCase.recordType.DeveloperName.contains('KIT') || originalCase.recordType.DeveloperName.contains('P2P_Attiva')){
            ordineFattibilita=true;
                mostraNoteInterneOrdine=true;
            if(ApexPages.currentPage().getParameters().get('OLO')=='true'){
                mostraNotePerOLO=true;
             }
         }
         else{
            richiestaFattibilita=true;
         } 
         
    boolVisibiltaTasti();
     //this.setViewPopUpPSM();
     //this.setViewErrorFilePopUpPSM();    
     
      if(ApexPages.currentPage().getParameters().get('Oper')=='EspOK'){
            mostraNomeKit=true;
       }
    }
    
    public void boolVisibiltaTasti(){
    
             /*
        PRENDI IN CARICO : if owner = coda && (userinfo.getuserid==membro della coda || userinfo.getuserid==system administrator) && status!=sospeso e status finali
        MODIFICA E SOSPENDI: if owner!=coda e (status !=sospeso e status finali)
        INVIA AL DELIVERY e ESPLETAMENTO KO: if if owner!=coda e (status !=sospeso e status finali) e fase = in lavorazione ingegneria
            INVIA A INGEGNERIA: if owner!=coda e (status !=sospeso e status finali) e fase = in lavorazione delivery
        ESPLETAMENTO OK: if owner!=coda e (status !=sospeso e status finali) e fase = in lavorazione ingegneria e gia passato per delivery.
            */
    
        //inizilizzo la visibilita
        mostraModifica          = false;
        mostraPrendiInCarico    = false; 
        mostraSospendi          = false; 
        mostraInviaDelivery     = false;
        mostraInviaIng          = false;
        mostraEspletatoOK       = false;
        mostraEspletatoKO       = false; 

        // List<GroupMember> gMemberList=[select UserOrGroupId from GroupMember where GroupId =:userinfo.getUserId()]; //esisite l'utente nella coda
        List<User> gAdminList=[select name,Profile.Name from User where Id =:userinfo.getUserId()]; //esisite l'utente admin
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> visibilita originalCase.Owner.Type : ' + originalCase.Owner.Type  + ' - originalCase.status: '  +originalCase.status);
        
        if (originalCase.Owner.Type!='Queue' && 
               
                originalCase.Status!='Sospeso' &&
                originalCase.Status!='Chiuso' 
                && originalCase.Status!='Espletato' 
                && originalCase.Status!='Espletato KO' 
            ){
                mostraSospendi    =  true;
                mostraModifica    =  true;
            }
    
        if (originalCase.Owner.Type=='Queue' && (UserInQueueGET()  || gAdminList[0].Profile.Name =='System Administrator') &&
            
                originalCase.Status!='Sospeso' 
                && originalCase.Status!='Chiuso' 
                && originalCase.Status!='Espletato' 
                && originalCase.Status!='Espletato KO' 
            ){
                mostraPrendiInCarico    =  true;
            }
        
        if (originalCase.Owner.Type!='Queue' && originalCase.EOF_FAse__c== 'In Lavorazione Ingegneria' &&
            originalCase.Status!='Sospeso' 
                && originalCase.Status!='Chiuso' 
                && originalCase.Status!='Espletato' 
                && originalCase.Status!='Espletato KO' ){
            
                mostraInviaDelivery    =  true;
                mostraEspletatoKO    =  true;
                }
                
        if (originalCase.Owner.Type!='Queue' && originalCase.EOF_FAse__c== 'In Lavorazione Ingegneria' &&
            originalCase.Status!='Sospeso' 
                && originalCase.Status!='Chiuso' 
                && originalCase.Status!='Espletato' 
                && originalCase.Status!='Espletato KO' ){
            
                    mostraEspletatoOK    =  true;
                }
                
            if (originalCase.Owner.Type!='Queue' &&  originalCase.EOF_FAse__c== 'In Lavorazione Delivery' &&
                originalCase.Status!='Sospeso' 
                     && originalCase.Status!='Chiuso' 
                && originalCase.Status!='Espletato' 
                && originalCase.Status!='Espletato KO'  ){
                        
                        mostraInviaIng    =  true;
                    }
                    
            if (originalCase.Owner.Type!='Queue' &&  originalCase.Status=='In Annullamento'){
                        mostraAnnulla     =  true;
                        mostraInviaIng    = false;
                        mostraEspletatoOK = false; 
                        mostraInviaDelivery = false;
                        mostraEspletatoKO = false; 
                        mostraPrendiInCarico = false; 
                        mostraSospendi    =  false;
                        mostraModifica    =  false;
                    }
            if ( originalCase.Status=='Annullato'){
                        mostraAnnulla     =  false;
                        mostraInviaIng    = false;
                        mostraEspletatoOK = false; 
                        mostraInviaDelivery = false;
                        mostraEspletatoKO = false; 
                        mostraPrendiInCarico = false; 
                        mostraSospendi    =  false;
                        mostraModifica    =  false;
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
            Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe(); 
             
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
        }catch(Exception e){
            System.debug(e);
        }
        return objectName;
    }
    
    public boolean UserInQueueGET(){
        System.debug('@@@@ originalCase.Owner.Type=' + originalCase.Owner.Type);
        if(originalCase.Owner.Type=='Queue'){ // se owner è una queue
            Set<id> UserIdSet = new Set<Id>();
            string OwnerGroupId = originalCase.Owner.Id; //Owner.Id ne prendo l'id
            List<GroupMember> gMemberList=[select UserOrGroupId from GroupMember where GroupId =:OwnerGroupId]; //estraggo i membri della coda
            
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
        return false;//altriment no
    }

    public Boolean UserInQueue{get{
        return UserInQueueGET();
    }}
    
    //AS END

    public void chiudiCaso(){
        
        originalCase.Status = 'Chiuso';
        originalCase.EOF_Fase__c = 'Chiuso';
        update originalCase;
    }
    
    public void espletamento(){
        
        originalCase.Status='Espletato';
        originalCase.EOF_Fase__c='Espletato';
        originalCase.OF_AggiornoOrdine__c = true;
        update originalCase;
        PO_PP_CRMHandler.createCRMKIT(originalCase.id) ;
    }
    
    public void Espletamento_KO(){
        
        originalCase.Status='Espletato KO';
        originalCase.EOF_Fase__c='Espletato KO';

        update originalCase;
    }
    
    public void sospendi(){
        system.debug('PO_PP_Buttons_Controller sospendi');
        if(ordineFattibilita){
            originalCase.EOF_Data_Ora_Sospensione__c=system.now();
            originalCase.Previous_Status__c=originalCase.EOF_Fase__c;
            originalCase.Status='Sospeso';
            originalCase.EOF_Fase__c='Sospeso';
            
        }
        if(collegamentoFattibilita){
            originalCase.EOF_Data_Ora_Sospensione__c=system.now();
            originalCase.Previous_Status__c=originalCase.EOF_Fase__c;
            originalCase.Status='Sospeso';
            originalCase.EOF_Fase__c='Sospeso OF';
        }
        update originalCase;
        
        //invio mail
       
        List<EOF_EAI_Service_Log__c> slToEmail=[select id,name, eof_stato_ordine__C,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c, EOF_Comunicazioni_con_OLO__c,Caso__r.CaseNumber
        from EOF_EAI_Service_Log__c 
        where  Caso__r.id =:originalCase.Id
        and RecordType.DeveloperName ='OF_PP_KIT_ActivationRequest' limit 1 ];
        
    	String subject = 'Sospensione della richiesta: '+ slToEmail[0].name;
		String textBody = 'Salve ,\n la presente per informare che  la sua richiesta ha bisogno di chiarimenti: ' +  slToEmail[0].name + ' \n Distinti Saluti \n OpenFiber.';
		List<String> toAddresses = new List<string> {originalCase.Contact.Email};
		
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
		email.setSubject(subject);
		email.setToAddresses(toAddresses);
		email.setPlainTextBody(textBody);
		//email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttcOld,csvAttcNew});
        
        //Commento inserito - PG - Bypass TestClass
        if(!test.isRunningTest()){
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
        //fine invio email
    }

    public void annulla(){
        //System.debug('PO_ServiziFattibilita_Controller annulla');
        originalCase.Status='Annullato';
        originalCase.EOF_Fase__c='Annullato';
        update originalCase;
    }
    
    //PG
    public PageReference modifica()
    {
        System.debug('PO_PP_Buttons_Controller modifica');
        PageReference pg = new PageReference('/PO_PP_EditFieldsCaseKit');
        pg.getParameters().put('id_case_kit',originalCase.id);

        return pg;
    }


    public void PrendiInCarico(){

        string actFase=originalCase.EOF_Fase__c;
        if (actFase == 'In Lavorazione'){
            originalCase.EOF_Fase__c ='In Lavorazione Ingegneria';
        }
        
        if(actFase =='Inviato a Delivery'){
            originalCase.EOF_Fase__c ='In Lavorazione Delivery';
        }
        
        if(actFase=='In Lavorazione Delivery'){
            originalCase.EOF_Fase__c ='In Lavorazione Ingegneria';
        }

        IF (originalCase.Status != 'In Annullamento' ){
            originalCase.Status='In Lavorazione';
        }
        originalCase.OwnerId=userinfo.getUserId();
        update originalCase; 
    }

      public void InviaIngegneria(){
        system.debug('PO_PP_Buttons_Controller InviaAdIngegneria');
        originalCase.Status='In Lavorazione';
        originalCase.EOF_Fase__c='In Lavorazione Ingegneria';  // AS campbiato da In Lavorazione Delivery a In Attesa Presa In Carico Delivery
        originalCase.ownerId = originalCase.PO_Owner_Originario__c;
        //Database.DMLOptions dmo = new Database.DMLOptions();
        //dmo.assignmentRuleHeader.useDefaultRule = true;
        //originalCase.setOptions(dmo); 
        update originalCase;
    }
    
    public void InviaAlDelivery(){
        system.debug('PO_PP_Buttons_Controller InviaAlDelivery');

        Group codaDel_PP = [select Id 
            		                from group 
            		                where developername='Delivery_Pre_Provisioning'
            		                limit 1];
        
        originalCase.PO_Owner_Originario__c=userinfo.getUserId();
        originalCase.Status='In Lavorazione';
        originalCase.EOF_Fase__c='Inviato a Delivery';  // AS campbiato da In Lavorazione Delivery a In Attesa Presa In Carico Delivery
        originalCase.ownerId = codaDel_PP.id;
        //Database.DMLOptions dmo = new Database.DMLOptions();
        //dmo.assignmentRuleHeader.useDefaultRule = true;
        //originalCase.setOptions(dmo); 
        update originalCase;
    }

    public void inserisciNote(){
        
        system.debug('>>>>>>>>> inserisciNote :oper: ' + ApexPages.currentPage().getParameters().get('Oper')) ;
        
        if(ApexPages.currentPage().getParameters().get('Oper')=='Ann'){
            
            if(!String.isBlank(originalCase.EOF_Note_Operatore__c)){
                
                if(String.isBlank(originalCase.EOF_Note_Interne__c)){
                    originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Annullamento - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                else{
                    originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Annullamento - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                
                originalCase.EOF_Note_Operatore__c='';
            }
            
            annulla();  
            
            
        }//fine
        //PP  invio ad ingeneria dal delivery 
        if(ApexPages.currentPage().getParameters().get('Oper')=='ING'){
            if(!String.isBlank(originalCase.EOF_Note_Operatore__c)){
                if(String.isBlank(originalCase.EOF_Note_Interne__c)){
                    originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Invia ad Ing - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                else{
                    originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Invia al Ing - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                originalCase.EOF_Note_Operatore__c='';
            }
            InviaIngegneria();   
        }//fine

        if(ApexPages.currentPage().getParameters().get('Oper')=='Del'){
            if(!String.isBlank(originalCase.EOF_Note_Operatore__c)){
                if(String.isBlank(originalCase.EOF_Note_Interne__c)){
                    originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Invia al Del - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                else{
                    originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Invia al Del - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                originalCase.EOF_Note_Operatore__c='';
            }
            InviaAlDelivery();
        }
        if(ApexPages.currentPage().getParameters().get('Oper')=='EspOK'){
                 
            system.debug('>>>>>>>>> ESPOK : vaolore nome ki: ' + originalCase.PO_PP_NomeKit__c) ;
            mostraNomeKit=true;
            if(String.isBlank(originalCase.PO_PP_NomeKit__c)){
                nomeKitObb=true; 
            }
            //if(String.isBlank(originalCase.PO_PP_Posizione_ODF__c)){
            
            //}	
            if (nomeKitObb==false){
                if(!String.isBlank(originalCase.EOF_Note_Operatore__c)){
                    if(String.isBlank(originalCase.EOF_Note_Interne__c)){
                        originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento OK - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                    }
                    else{
                        originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento OK - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                    }
                    originalCase.EOF_Note_Operatore__c='';
                }
                if(!String.isBlank(originalCase.EOF_Note__c)){
                    if(String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)){
                        originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento OK - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
                    }
                    else{
                        originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento OK - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
                    }
                    originalCase.EOF_Note__c='';
                }
                //ribalto la nota sul campo del LOG:
                List<EOF_EAI_Service_Log__c> slToUpdate=[select id,name, Nome_del_KIT__c,eof_stato_ordine__C,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c, EOF_Comunicazioni_con_OLO__c,Caso__r.CaseNumber
                                    from EOF_EAI_Service_Log__c 
                                    where  Caso__r.id =:originalCase.Id
                                    and RecordType.DeveloperName ='OF_PP_KIT_ActivationRequest'];
                slToUpdate[0].EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c;
                slToUpdate[0].eof_stato_ordine__C='Espletato';
                slToUpdate[0].Nome_del_KIT__c=originalCase.PO_PP_NomeKit__c;
                
                update slToUpdate;
                originalCase.PO_PP_NomeKit__c=originalCase.PO_PP_NomeKit__c;
                originalCase.PO_PP_Posizione_ODF__c=originalCase.PO_PP_Posizione_ODF__c;
                originalCase.EOF_ID_Risorsa__c = originalCase.PO_PP_NomeKit__c;
                espletamento();
            }
        }
        if(ApexPages.currentPage().getParameters().get('Oper')=='EspKO'){
            if(!String.isBlank(originalCase.EOF_Note_Operatore__c)){
                if(String.isBlank(originalCase.EOF_Note_Interne__c)){
                    originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento KO - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                else{
                    originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento KO - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                originalCase.EOF_Note_Operatore__c='';
            }
            if(!String.isBlank(originalCase.EOF_Note__c)){
                if(String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)){
                    originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento KO - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
                }
                else{
                    originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Espletamento KO - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
                }
                originalCase.EOF_Note__c='';
            }
                 //ribalto la nota sul campo del LOG:
            List<EOF_EAI_Service_Log__c> slToUpdate=[select id,name, eof_stato_ordine__C,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c, EOF_Comunicazioni_con_OLO__c,Caso__r.CaseNumber
                                from EOF_EAI_Service_Log__c 
                                where  Caso__r.id =:originalCase.Id
                                and RecordType.DeveloperName ='OF_PP_KIT_ActivationRequest'];
            system.debug('XXXXXXXXXXXXXXXXXXX >>>>>> SERVICE LOG PRESENTE slToUpdate[0].id ' + slToUpdate[0].id);
            slToUpdate[0].EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c;
            slToUpdate[0].eof_stato_ordine__C='Espletato KO';
            update slToUpdate;
            Espletamento_KO();
        }
        if(ApexPages.currentPage().getParameters().get('Oper')=='Sos'){
            if(!String.isBlank(originalCase.EOF_Note_Operatore__c)){
                if(String.isBlank(originalCase.EOF_Note_Interne__c)){
                    originalCase.EOF_Note_Interne__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Sospensione OF - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                else{
                    originalCase.EOF_Note_Interne__c=originalCase.EOF_Note_Interne__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Sospensione OF - '+userinfo.getName()+':\n'+originalCase.EOF_Note_Operatore__c;
                }
                originalCase.EOF_Note_Operatore__c='';
            }
            if(!String.isBlank(originalCase.EOF_Note__c)){
                if(String.isBlank(originalCase.EOF_Comunicazioni_con_OLO__c)){
                    originalCase.EOF_Comunicazioni_con_OLO__c=OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Sospensione OF - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
                }
                else{
                    originalCase.EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Sospensione OF - '+userinfo.getName()+':\n'+originalCase.EOF_Note__c;
                }
                originalCase.EOF_Note__c='';
            }
            
            //ribalto la nota sul campo del LOG:
            List<EOF_EAI_Service_Log__c> slToUpdate=[select id,name, eof_stato_ordine__C,EOF_CODICE_MOTIVAZIONE__c,EOF_MOTIVAZIONE__c, EOF_Comunicazioni_con_OLO__c,Caso__r.CaseNumber
                                from EOF_EAI_Service_Log__c 
                                where  Caso__r.id =:originalCase.Id
                                and RecordType.DeveloperName ='OF_PP_KIT_ActivationRequest'];
            slToUpdate[0].EOF_Comunicazioni_con_OLO__c=originalCase.EOF_Comunicazioni_con_OLO__c;
            slToUpdate[0].eof_stato_ordine__C='Sospeso';
            update slToUpdate;
            //FINE - ribalto la nota sul campo del LOG:
            
            sospendi();
        }
       
        /* 06-11-2018  Rajani added */
        String Contactemail = originalCase.contact.email;
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        
        OrgWideEmailAddress[] owea = [select Id 
                                      from OrgWideEmailAddress 
                                      where DisplayName  = 'Open Fiber'];
        
        message.toAddresses = new String[] {Contactemail};
        //message.toAddresses = new String[] {''};
        if ( owea.size() > 0 ) {
            message.setOrgWideEmailAddressId(owea.get(0).Id);
        }
        message.optOutPolicy = 'FILTER';
        string reportmail = '';
        if(ApexPages.currentPage().getParameters().get('Oper')=='EspOK'){
            message.subject = 'Richiesta ' + originalCase.casenumber + ' Espletata OK';
            reportmail += 'Gentile'+ '&nbsp;&nbsp;&nbsp;' + originalCase.Contact.Name + '<br/>';
            reportmail += 'la sua richiesta '+  originalCase.casenumber +' è stata espletata correttamente.'+ '<br/><br/><br/><br/><br/>';
            reportmail += 'Saluti'+ '<br/>';
            reportmail += 'Team di Open Fiber'+ '<br/><br/><br/>';
            reportmail += 'Questo indirizzo email non è presidiato, si prega di non rispondere all’email. ';
            message.setHTMLBody(reportmail);
            //message.setTemplateID(templateId.Id); 
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            //Add - ByPass TestClass - PG
            if(!Test.isRunningTest())
            {
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                if (results[0].success) {
                    System.debug('The email was sent successfully.');
                } else {
                    System.debug('The email failed to send: ' + results[0].errors[0].message);
                }
            }
            //End - ByPass TestClass - PG
        }
        else if(ApexPages.currentPage().getParameters().get('Oper')=='EspKO'){
            message.subject =  'Richiesta ' + originalCase.casenumber + ' Espletata KO';
            reportmail += 'Gentile'+ '&nbsp;&nbsp;&nbsp;' + originalCase.Contact.Name + '<br/>';
            reportmail += 'la sua richiesta '+  originalCase.casenumber +' non è andata a buon fine .'+ '<br/><br/><br/><br/><br/>';
            reportmail += 'Saluti'+ '<br/>';
            reportmail += 'Team di Open Fiber'+ '<br/><br/><br/>';
            reportmail += 'Questo indirizzo email non è presidiato, si prega di non rispondere all’email. ';
            message.setHTMLBody(reportmail);
            //message.setTemplateID(templateId.Id); 
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            
            //Add - ByPass TestClass - PG
            if(!Test.isRunningTest())
            {
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                if (results[0].success) {
                    System.debug('The email was sent successfully.');
                } else {
                    System.debug('The email failed to send: ' + results[0].errors[0].message);
                }  
            }
            //End - ByPass TestClass - PG
        }
        /* 06-11-2018  Rajani added */
    }
}