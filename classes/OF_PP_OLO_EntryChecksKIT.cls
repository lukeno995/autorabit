public class OF_PP_OLO_EntryChecksKIT {  
    
    public static case c;
    
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksStatusUpdate(OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur, EOF_EAI_Service_Log__c slPort){
        
        system.debug('8888888888888 Annullo Richiesta DENTRO PORTAL_SyncChecksStatusUpdate ');
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksStatusUpdate(sur);
        
        if(resp.esito=='0'){
            slPort.EOF_Stato_Ordine__c=OF_PP_GE_Utils.caseOriginale.status;  
        }
        else{
            slPort.EOF_MOtivazione__c=resp.motivazione;
            if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
                slPort.EOF_MOtivazione__c='Servizio Momentaneamente non disponibile';
            }
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }    
        return slPort;  
    }
    
 
    public static OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksStatusUpdate(OF_PP_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur){
       
       List<EOF_EAI_Service_Log__c> slToInsert = new List<EOF_EAI_Service_Log__c>();

        OF_PP_GE_Utils.partialTemplog('CG.1');

        if(string.isblank(sur.CODICE_OPERATORE)){
            return OF_PP_GE_Utils.syncError (sur,'A05','CODICE_OPERATORE');
        }
            
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        Boolean olo_found = false;
        
        for(Schema.PicklistEntry s : ple){
            
            if(sur.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }
        if(!olo_found){
            
             return OF_PP_GE_Utils.syncError (sur,'A06','CODICE_OPERATORE');     
        }
        system.debug('---------------> DENTRO SyncChecksStatusUpdate sur.CODICE_ORDINE_OF: ' + sur.CODICE_ORDINE_OF); 
        List<Case> cList= [select id,status,Codice_Ordine_EOF__c,EOF_Comunicazioni_con_OLO__c,EOF_Fase__c,Previous_Status__c from Case where id=:sur.CODICE_ORDINE_OF];
        
        if(cList.isEmpty()){
            return OF_PP_GE_Utils.syncError (sur,'A06','CODICE_ORDINE_OLO');
        }
        else{
            OF_PP_GE_Utils.caseOriginale=cList[0];
            OF_PP_GE_Utils.checkCaseOriginale=true;
        }
        //###################### ANNULLAMENTO
        if(sur.AZIONE=='1'){
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - AZIONE==1 ANNULLAMENTO');

            OF_PP_GE_Utils.partialTemplog('ANN.1');
            
            if(OF_PP_GE_Utils.caseOriginale.status!='Acquisito' && OF_PP_GE_Utils.caseOriginale.status!='Accettato' && OF_PP_GE_Utils.caseOriginale.status!='Sospeso' 
                && OF_PP_GE_Utils.caseOriginale.status!='Inviato' && OF_PP_GE_Utils.caseOriginale.status!='In Lavorazione' // DA RIMUOVERE!!!???
                ){
                system.debug('---------------> DENTRO SyncChecksStatusUpdate - AZIONE==1 ANNULLAMENTO : '+ OF_PP_GE_Utils.caseOriginale.status);
                return OF_PP_GE_Utils.syncError (sur,'A07','STATUS: ' + OF_PP_GE_Utils.caseOriginale.status);
            }
            
            OF_PP_GE_Utils.partialTemplog('ANN.2');
        } 
        system.debug('---------------> DENTRO SyncChecksStatusUpdate - Fuori IF annullamento');
        //###################### DESOSPENSIONE
        if(sur.AZIONE=='0'){
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - AZIONE==0 Desospensione');
      
            OF_PP_GE_Utils.partialTemplog('D.1');
            
            if(OF_PP_GE_Utils.caseOriginale.status != 'Sospeso'){
                //return OF_PP_GE_Utils.syncError (sur,'A07','STATUS: ' + OF_PP_GE_Utils.caseOriginale.status);
            }
            
            if(!string.isblank(sur.CODICE_MOTIVAZIONE)){ 
                if(sur.CODICE_MOTIVAZIONE.length()>3){
                    return OF_PP_GE_Utils.syncError (sur,'A06','CODICE MOTIVAZIONE');
                }
                if(sur.CODICE_MOTIVAZIONE.contains('')){
                    //return OF_PP_GE_Utils.syncError (sur,'B04','CODICE MOTIVAZIONE'); ---- DECOMMETNARE
                }
            }
            if(!string.isblank(sur.MOTIVAZIONE)){
                if(sur.MOTIVAZIONE.length()>255){
                    system.debug('---------------> DENTRO SyncChecksStatusUpdate - MOTIVAZIONE.length()>255');
                    return OF_PP_GE_Utils.syncError (sur,'A06','MOTIVAZIONE');
                }
                if(sur.MOTIVAZIONE.contains('')){
                    system.debug('---------------> DENTRO SyncChecksStatusUpdate -ELSE - MOTIVAZIONE.length()>255');
                   // return OF_PP_GE_Utils.syncError (sur,'B04','MOTIVAZIONE');                     ---- DECOMMENTARE
                }
            }
            OF_PP_GE_Utils.partialTemplog('D.2');
        }
        OF_PP_GE_Utils.partialTemplog('SU.1');
    
        if(!string.isblank(sur.NOTE)){
            if(sur.NOTE.length()>255){
                return OF_PP_GE_Utils.syncError (sur,'A06','NOTE');
            }
            if(sur.NOTE.contains('')){
            //  return OF_PP_GE_Utils.syncError (sur,'B04','NOTE');
            }
        } 
        
        system.debug('---------------> DENTRO SyncChecksStatusUpdate - dopo note');
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        sur.codice_ordine_of=OF_PP_GE_Utils.caseOriginale.Codice_Ordine_EOF__c;
        system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX1');
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse responseToOlo = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();       
        responseToOlo.esito='0';
        responseToOlo.motivazione='';
        //if(sur.AZIONE=='0'){
              
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX2');
            //sur.codice_ordine_of='';
            //slList.addAll(responseFromOM.get('0'));
            
            slList.add(OF_PP_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK',
                                             'Codice_operatore' => sur.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
                                             'CODICE_ORDINE_OF' => sur.CODICE_ORDINE_OLO,
                                             'Flusso' => 'SF-OLO',
                                             'Metodo' => 'OLO_StatusUpdate',
                                             'ID_notifica' => sur.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - StatusUpdate'}));
            
            EOF_EAI_Service_Log__c slToOM = new EOF_EAI_Service_Log__c();
            
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - sur: ' + sur.CODICE_ORDINE_OLO);
            
            slToOM = OF_PP_GE_Utils.OLO_CreateStatusUpdate_Log(c, sur);
            slToOM.EOF_Note__C=sur.NOTE;
           
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX3');
            
            if (slToOM == null ){
                 
                system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX3BIS - slToOM == null ');
            }
            
            slList.add(slToOM);
            
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - PRE INSERT');
            
            Insert slList;
            
            system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX4');
            
            if(sur.azione=='0'){

               // if(string.isNotBlank(OF_PP_GE_Utils.caseOriginale.Previous_Status__c)){
                    
                    OF_PP_GE_Utils.caseOriginale.Status='In Lavorazione';
                    OF_PP_GE_Utils.caseOriginale.EOF_Fase__c=OF_PP_GE_Utils.caseOriginale.Previous_Status__c;
                    system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX5');
                    OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c=OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - DE-Sospensione OLO - '+userinfo.getName()+':\n'+sur.NOTE;
                    
                /*}else{         
                   // system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX6:case ID ' + OF_PP_GE_Utils.caseOriginale.Id);
                    //CaseHistory ch = [select oldValue from CaseHistory where CaseId=:OF_PP_GE_Utils.caseOriginale.Id and Field='Status' order by createdDate desc limit 1];            
                    //OF_PP_GE_Utils.caseOriginale.Status= String.valueof(ch.oldValue);        ---- DECOMMETNARE      
                    OF_PP_GE_Utils.caseOriginale.Status='In Lavorazione';
                    OF_PP_GE_Utils.caseOriginale.EOF_Fase__c=OF_PP_GE_Utils.caseOriginale.Previous_Status__c;
                }*/
            }
            else{ // if(sur.azione=='1')
                
                OF_PP_GE_Utils.caseOriginale.Status='In Annullamento';
                OF_PP_GE_Utils.caseOriginale.EOF_Fase__c='In Annullamento';
                OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c=OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+' - Annullamento OLO - '+userinfo.getName()+':\n'+sur.NOTE;
            }
            update OF_PP_GE_Utils.caseOriginale;
            OF_PP_OLO_EntryChecksKIT.c=OF_PP_GE_Utils.caseOriginale;
        
        return  responseToOlo;    
          
    }// fine NEW!!!
    
    //STATUS UPDATE PER VLAN 
    public static OF_PP_WS_IN_OLO_Activation.VLAN_PP SyncChecksStatusUpdateVLAN(OF_PP_WS_IN_OM_ResponseUpdate.OM_StatusUpdateRequestVLAN sur){
       
        system.debug('---------------> DENTRO SyncChecksStatusUpdate sur.CODICE_ORDINE_SFDC: ' + sur.CODICE_ORDINE_SFDC); 
        system.debug('---------------> DENTRO SyncChecksStatusUpdate sur.CODICE_ORDINE_SO: ' + sur.CODICE_ORDINE_SO); 
        
        List<Case> cList= [select id, Codice_Ordine_SO__c, Codice_Ordine_SFDC__c, casenumber, status,AssetId,Codice_Ordine_EOF__c,EOF_Comunicazioni_con_OLO__c,EOF_Fase__c,Previous_Status__c 
                          from Case 
                          where Codice_Ordine_SO__c=:sur.CODICE_ORDINE_SO]; 
        
        if(cList.isEmpty()){
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','CODICE_ORDINE_SO');
        }else{
            OF_PP_GE_Utils.caseOriginale=cList[0];
            OF_PP_GE_Utils.checkCaseOriginale=true;
        }
       
        List<EOF_EAI_Service_Log__c> slToInsert = new List<EOF_EAI_Service_Log__c>();
       
        system.debug('---------------> DENTRO SyncChecksStatusUpdateVLAN sur.CODICE_ORDINE_SFDC: ' + sur.CODICE_ORDINE_SFDC); 
        //if(!test.isRunningTest()){
        if(string.isblank(sur.CODICE_OPERATORE)){
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A05','CODICE_OPERATORE');
        }
        //  }    
        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        Boolean olo_found = false;
        
        for(Schema.PicklistEntry s : ple){
            
            if(sur.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }
        }
        //controllo obbligatorieta campi da OM
        if(string.isblank(sur.CODICE_ORDINE_SFDC)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','CODICE_ORDINE_SFDC');
        }
        if(string.isblank(sur.CODICE_ORDINE_SO)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','CODICE_ORDINE_SO');
        }
        if(string.isblank(sur.DATA_NOTIFICA)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','DATA_NOTIFICA');
        }
        if(string.isblank(sur.ID_NOTIFICA)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','ID_NOTIFICA');
        }
        if(string.isblank(sur.STATO_ORDINE)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','STATO_ORDINE');
        }
        if(sur.STATO_ORDINE != '11' && sur.STATO_ORDINE != '10'){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','STATO_ORDINE');
        }
        /*
        if(string.isblank(sur.CODICE_MOTIVAZIONE) && sur.STATO_ORDINE=='11'){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','CODICE_MOTIVAZIONE');
        }
        */
        if(string.isblank(sur.CODICE_OPERATORE)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','CODICE_OPERATORE');
        }
        if(string.isblank(sur.MOTIVAZIONE) && sur.STATO_ORDINE=='11'){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','MOTIVAZIONE');
        }
        /*
        if(string.isblank(sur.SERVICE_VLAN_ID)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','SERVICE_VLAN_ID');
        }
        */
        /*
        if(string.isblank(sur.USER_VLAN)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','USER_VLAN');
        }
        */
        /*if(string.isblank(sur.COS)){ 
            return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K9','COS');
        }*/

        //fine controllo obbligatorietà
       
        if(!olo_found){
            return OF_PP_GE_Utils.syncErrorVLAN(sur,'A06','CODICE_OPERATORE');     
        }
   
        //START - Check di formato/lunghezza
        if(!string.isblank(sur.CODICE_OPERATORE)){ 
            if(sur.CODICE_OPERATORE.length()>3){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','CODICE_OPERATORE');
            }
        }
        if(!string.isblank(sur.CODICE_ORDINE_SFDC)){ 
            if(sur.CODICE_ORDINE_SFDC.length()>18){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','CODICE_ORDINE_SFDC');
            }
        }
        if(!string.isblank(sur.CODICE_ORDINE_SO)){ 
            if(sur.CODICE_ORDINE_SO.length()>18){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','CODICE_ORDINE_SO');
            }
        }
        if(!string.isblank(sur.STATO_ORDINE)){ 
            if(sur.STATO_ORDINE.length()>2){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','STATO_ORDINE');
            }
        }
        if(!string.isblank(sur.CODICE_MOTIVAZIONE)){ 
            if(sur.CODICE_MOTIVAZIONE.length()>3){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A06','CODICE MOTIVAZIONE');
            }
            if(sur.CODICE_MOTIVAZIONE.contains('')){
                //return OF_PP_GE_Utils.syncErrorVLAN (sur,'B04','CODICE MOTIVAZIONE'); ---- DECOMMENTARE
            }
        }
        if(!string.isblank(sur.MOTIVAZIONE)){
            if(sur.MOTIVAZIONE.length()>255){
                system.debug('---------------> DENTRO SyncChecksStatusUpdate - MOTIVAZIONE.length()>255');
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A06','MOTIVAZIONE');
            }
            if(sur.MOTIVAZIONE.contains('')){
                system.debug('---------------> DENTRO SyncChecksStatusUpdate -ELSE - MOTIVAZIONE.length()>255');
               // return OF_PP_GE_Utils.syncErrorVLAN (sur,'B04','MOTIVAZIONE');                     ---- DECOMMENTARE
            }
        }
        if(!string.isblank(sur.NOTE)){
            if(sur.NOTE.length()>255){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A06','NOTE');
            }
            if(sur.NOTE.contains('')){
            //  return OF_PP_GE_Utils.syncErrorVLAN (sur,'B04','NOTE');
            }
        }
        if(!string.isblank(sur.SERVICE_VLAN_ID)){ 
            if(sur.SERVICE_VLAN_ID.length()>4){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','SERVICE_VLAN_ID');
            }
        }
        if(!string.isblank(sur.USER_VLAN)){ 
            if(sur.USER_VLAN.length()>3){
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','USER_VLAN');
            }
            if(sur.USER_VLAN!='835' && sur.USER_VLAN!='935' && sur.USER_VLAN!='837' ){ 
                return OF_PP_GE_Utils.syncErrorVLAN (sur,'A_K10','USER_VLAN');
            }
        }
        //FINE - Check di formato/lunghezza
         
        system.debug('---------------> DENTRO SyncChecksStatusUpdate - dopo note');
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        
        system.debug('---------------> DENTRO SyncChecksStatusUpdate - XXXX1');
        OF_PP_WS_IN_OLO_Activation.VLAN_PP responseToOlo = new OF_PP_WS_IN_OLO_Activation.VLAN_PP();       
        responseToOlo.esito='0';
        responseToOlo.motivazione='';
    
        //Gestione dei KO provenienti da OM --------------------------------------------
            /*
            001 Richiesta di preprovisioning non ammissibile
            002 POP di consegna non congruente con KIT
            003 SVLAN ID non disponibile
            004 Errore di Rete
            */
        
        //BUG - Verificare ack/nack status update da OM 
        /*
        if (sur.CODICE_MOTIVAZIONE=='001' || sur.CODICE_MOTIVAZIONE=='002' || sur.CODICE_MOTIVAZIONE=='003' ||sur.CODICE_MOTIVAZIONE=='004'){
            system.debug('---------------> DENTRO if (sur.CODICE_MOTIVAZIONE==001)' );
            slList.add(OF_PP_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'NACK VLAN',
                            'Codice_operatore' => sur.CODICE_OPERATORE,
                            //'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
                            //'CODICE_ORDINE_OF' => sur.CODICE_ORDINE_OLO,
                            'CODICE_ORDINE_SFDC '=> sur.CODICE_ORDINE_SFDC,
                            'Flusso' => 'OM-SF',
                            'Metodo' => 'OM_SyncChecksStatusUpdateVLAN',
                            'ID_notifica' => sur.ID_NOTIFICA,
                            'Tipo Comunicazione' => 'OM->SF - NACK - StatusUpdateVlan'}));
        }else{
        */
            system.debug('---------------> sur.CODICE_MOTIVAZIONE :'+sur.CODICE_MOTIVAZIONE);
            slList.add(OF_PP_GE_Utils.create_Eai_Log(new Map<String,String>{'Type' => 'ACK VLAN',
                            'Codice_operatore' => sur.CODICE_OPERATORE,
                            //'Codice_ordine_OLO' => sur.CODICE_ORDINE_OLO,
                            //'CODICE_ORDINE_OF' => sur.CODICE_ORDINE_OLO,
                            'CODICE_ORDINE_SFDC'=> sur.CODICE_ORDINE_SFDC,
                            'CODICE_ORDINE_SO'=> sur.CODICE_ORDINE_SO,
                            'Flusso' => 'OM-SF',
                            'Metodo' => 'OM_SyncChecksStatusUpdateVLAN',
                            'ID_notifica' => sur.ID_NOTIFICA,
                            //'Tipo Comunicazione' => 'OM->SF - ACK - StatusUpdateVlan'
                            'Tipo Comunicazione' => 'SF->OM - ACK - StatusUpdateVlan'}));
        //}

        EOF_EAI_Service_Log__c slToOM = new EOF_EAI_Service_Log__c();
        slToOM = OF_PP_GE_Utils.OLO_CreateStatusUpdate_LogVLAN(c, sur);
        
        System.debug('*****slToOM*****:'+slToOM);
        
        //BUG - Mappare Codice Motivazione e EOF_MOTIVAZIONE__c -->OK
        if(!string.isBlank(sur.MOTIVAZIONE)){
            slToOM.EOF_CODICE_MOTIVAZIONE__c = sur.CODICE_MOTIVAZIONE;
            slToOM.EOF_MOTIVAZIONE__c = sur.MOTIVAZIONE;
        }
       
        slList.add(slToOM);
        try{
            Insert slList;
        }
        catch(exception e){}
        
        if(sur.STATO_ORDINE=='11')//AttPreProvCompletatoKO -->Il case va in Espletato KO
        {
            //aggiorno lo stato del CASE
            //if (sur.CODICE_MOTIVAZIONE=='001' || sur.CODICE_MOTIVAZIONE=='002' || sur.CODICE_MOTIVAZIONE=='003' ||sur.CODICE_MOTIVAZIONE=='004'){
            OF_PP_GE_Utils.caseOriginale.Status = 'Espletato KO';
            OF_PP_GE_Utils.caseOriginale.PO_PP_SVLAN__c = sur.SERVICE_VLAN_ID;
            OF_PP_GE_Utils.caseOriginale.PO_PP_UserVlan__c = sur.USER_VLAN;
            OF_PP_GE_Utils.caseOriginale.EOF_Fase__c = OF_PP_GE_Utils.caseOriginale.Previous_Status__c;
            OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c = OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+
                                                                    ' Espletamento KO '+userinfo.getName()+':\n'+sur.NOTE;
            update OF_PP_GE_Utils.caseOriginale;
        }
        else if(sur.STATO_ORDINE=='10')// AttPreProvCompletato --->Il case va in Espletato
        {
            OF_PP_GE_Utils.caseOriginale.Status = 'Espletato';
            OF_PP_GE_Utils.caseOriginale.PO_PP_SVLAN__c = sur.SERVICE_VLAN_ID;
            OF_PP_GE_Utils.caseOriginale.PO_PP_UserVlan__c = sur.USER_VLAN;
            OF_PP_GE_Utils.caseOriginale.EOF_Fase__c = OF_PP_GE_Utils.caseOriginale.Previous_Status__c;
            OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c = OF_PP_GE_Utils.caseOriginale.EOF_Comunicazioni_con_OLO__c+'\n'+ OM_GW_GE_Utils.DateToString(system.now()).left(19)+
                                                                    ' - Espletamento OK -  '+userinfo.getName()+':\n'+sur.NOTE;
            update OF_PP_GE_Utils.caseOriginale;
            PO_PP_CRMHandler.createCRMVLAN(OF_PP_GE_Utils.caseOriginale.id,OF_PP_GE_Utils.caseOriginale.AssetId) ;
        }
        
        OF_PP_OLO_EntryChecksKIT.c = OF_PP_GE_Utils.caseOriginale;
        EOF_EAI_Service_Log__c logPortaleVLAN = new EOF_EAI_Service_Log__c();
        
        //@@ Add PG - 08-11
        //Ribalto i campi del Case di VLAN sul log di portale
        logPortaleVLAN = [Select id, NAME, Caso__c, Caso__r.casenumber, recordtype.developername, EOF_Codice_Operatore__c,EOF_Data_Notifica__c, 
                            EOF_ID_Notifica__c, EOF_Tipo_Comunicazione_String__c, EOF_STATO_ORDINE__c, EOF_Stato_Richiesta__c, SVLAN__c, PO_PP_User_VLAN__c,
                            OF_PP_NomeRichiesta__c, OF_PP_NomeRichiesta_Figlio__c, CreatedDate
                            from EOF_EAI_Service_Log__c 
                            where recordType.developerName = 'PO_PP_VLAN'
                            and Caso__c =: OF_PP_GE_Utils.caseOriginale.id];
        
        logPortaleVLAN.EOF_STATO_ORDINE__c = OF_PP_GE_Utils.caseOriginale.status;
        logPortaleVLAN.PO_PP_User_VLAN__c = OF_PP_GE_Utils.caseOriginale.PO_PP_UserVlan__c;
        logPortaleVLAN.SVLAN__c = OF_PP_GE_Utils.caseOriginale.PO_PP_SVLAN__c;
        update logPortaleVLAN;
        //@@ End PG - 08-11
        
        return responseToOlo;
    }
    //FINE STATUS UPDATE PER VLAN

    //SyncChecksActivation - KIT
    public static OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksActivation(OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act){
        
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PRIMA DI resp act.CODICE_ORDINE_OLO: ' + act.CODICE_ORDINE_OLO);
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();

        //creo e inserisco il log dell'attivazione da OLO (OLO->SF - ActivationRequest)
        OF_PP_GE_Utils.slOLOSF = OF_PP_GE_Utils.create_EAI_Log(act);
        
        resp.ID_NOTIFICA=String.valueOf(Datetime.now().gettime());
        resp.ESITO='0';
                
        OF_PP_GE_Utils.OPName='Attivazione';
        OF_PP_GE_Utils.partialTemplog('ACQ.1');
        
        if(string.isblank(act.CODICE_OPERATORE)){
            return OF_PP_GE_Utils.syncError (act,'A05','CODICE_OPERATORE');
        }  

        Schema.DescribeFieldResult fieldResult =  Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        for(Schema.PicklistEntry s : ple){
            if(act.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }    
        }
        if(!olo_found){
            return OF_PP_GE_Utils.syncError (act,'A06','CODICE_OPERATORE');
        }
           /*        
        if(string.isblank(act.CODICE_ORDINE_OLO)){
            return OF_PP_GE_Utils.syncError (act,'A05','CODICE_ORDINE_OLO');
        }
      
        if(act.CODICE_ORDINE_OLO.length()>18){
            return OF_PP_GE_Utils.syncError (act,'A06','CODICE_ORDINE_OLO');
        }
        if(act.CODICE_ORDINE_OLO.contains('�')){
            return OF_PP_GE_Utils.syncError (act,'B04','CODICE_ORDINE_OLO');
        }

        if(OF_PP_GE_Utils.checkCaseOriginale){
            return OF_PP_GE_Utils.syncError (act,'A08','CODICE_ORDINE_OLO');
        }
            
        else if(act.NOME_KIT.length()>20){
            system.debug('<<<<<<<<<<<<<<<<<<<<<<< NOME KIT TROPPO LUNGO' );
            return OF_PP_GE_Utils.syncError (act,'A06','NOME_KIT');
        } */
        
        /*if(string.isblank(act.PROFILO)){
            return OF_PP_GE_Utils.syncError (act,'A05','PROFILO');
        }
        else if(act.PROFILO.length()>20){
            return OF_PP_GE_Utils.syncError (act,'A06','PROFILO');
        }
        else if(act.PROFILO.contains('�')){
            return OF_PP_GE_Utils.syncError (act,'B04','PROFILO');
        } */ 

        if(string.isblank(act.DATA_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A05','DATA_NOTIFICA');
        }
        if(test.isrunningTest()){
        if(!OF_PP_GE_Utils.checkDateTime(act.DATA_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A06','DATA_NOTIFICA');
        }
        }
        if(string.isblank(act.ID_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A05','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.length()>100){
            return OF_PP_GE_Utils.syncError (act,'A06','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.contains('�')){
            return OF_PP_GE_Utils.syncError (act,'B04','ID_NOTIFICA');
        } 
        resp.ID_NOTIFICA=act.ID_NOTIFICA;
        
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_PP_GE_Utils.partialTemplog('ACQ.2');
        // finisce qui       
      
       system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkRTMap');
       if(!OF_PP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_PP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_PP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_PP_GE_Utils.checkRTMap=true;
       }
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Case c = new Case');
        
        Group codaIngegneria_PP = [select Id 
                                    from group 
                                    where developername='Ingegneria_Pre_Provisioning'
                                    limit 1];
        
        //creo ed inserisco il case
        Case c = new Case(); 

        c.RecordTypeId=OF_PP_GE_Utils.rtMap.get('OF_PP_PreProvisioning_KITConsegna');
        c.PO_PP_NomeKit__c ='';//act.NOME_KIT;
        c.Codice_Ordine_SO__c = act.CODICE_ORDINE_SO;
        c.PO_PP_Traffico__c=act.TRAFFICO;
        c.PO_PP_Banda__c=act.BANDA;
        c.PO_PP_Interfaccia_Kit__c = act.INTERFACCIA;
        c.PO_PP_Servizi_Finali__c=act.SERVIZIFINALI;
        c.PO_PP_Posizione_ODF__c='';//act.ODF;
        c.PO_PP_Modello_Servizio__c=act.MODELLO_SERVIZIO;
        c.PO_PP_POP__c=act.IDENTIFICATIVO_DEL_POP;
        c.EOF_Id_Notifica__c = act.ID_NOTIFICA;  
        c.EOF_Data_Notifica__c = OF_PP_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        c.subject='Richiesta Attivazione KIT';
        c.status='Accettato';
        c.EOF_Codice_Operatore_WS__c=act.CODICE_OPERATORE;
        c.EOF_FASE__C='In Lavorazione';
        c.ownerId = codaIngegneria_PP.id;
        c.PO_SA_Portale__c=OF_PP_GE_Utils.PORTAL;
        c.EOF_Note__C=act.NOTE;
        
        insert c;
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> insert c:' + c.Id);
        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=c.Id;
        insert g;
         
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> insert g:' + g.Id);

        OF_PP_GE_Utils.caseOriginale=c; 
        OF_PP_GE_Utils.checkCaseOriginale=true;
        
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: ' + OF_PP_GE_Utils.checkCaseOriginale);
        
        //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - ActivationRequest) e aggiorno il sl di riferimento con l'ACK
        //system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.slOLOSF.Id: '+ OF_PP_GE_Utils.slOLOSF.Id);
        
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        
        slToUpsert.add(OF_PP_GE_Utils.create_EAI_Log(new Map<String,String>{
                                             'Type' => 'ACK',
                                             'Codice_operatore' => act.CODICE_OPERATORE,
                                             'Flusso' => 'SF-OLO',
                                             'Metodo' => 'OLO_ActivationSetup_ConsegnaKIT',
                                             'ID_notifica' => act.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - KitConsegnaRequest'
                                            ,'SL Riferimento' => OF_PP_GE_Utils.slOLOSF.Id
                                                }));
        
        OF_PP_GE_Utils.slOLOSF.EOF_Response__c='ACK';   
        OF_PP_GE_Utils.slOLOSF.Caso__c=c.Id;
        OF_PP_GE_Utils.slOLOSF.eof_Codice_Ordine_EOF__c=c.id;
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: ' +   OF_PP_GE_Utils.slOLOSF.Id);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: ' + OF_PP_GE_Utils.slOLOSF.Caso__c);
        slToUpsert.add(OF_PP_GE_Utils.slOLOSF);
        upsert slToUpsert;
        
        //OF_PP_OLO_AsyncChecks.KIT_AsyncActivation(c.Id,OF_PP_GE_Utils.slOLOSF.Id);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: ' + OF_PP_GE_Utils.slOLOSF.Caso__c);
        OF_PP_GE_Utils.EndTemplog();
        
        return  resp; 
    } 
    
    //OK
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksActivation(OF_PP_WS_IN_OLO_Activation.KIT_ActivationRequest act, EOF_EAI_Service_Log__c slPort){
        
        OF_PP_GE_Utils.PORTAL=true;
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksActivation(act);
        
        if(resp.esito=='0'){
            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESITO 0');
            slPort.EOF_Stato_Ordine__c=OF_PP_GE_Utils.caseOriginale.status;
            slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_PP_GE_Utils.caseOriginale.Id);
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now();
        }
        else{
            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESITO <> 1');
            slPort.EOF_Motivazione__c=resp.motivazione;
            if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100'){
                slPort.EOF_Motivazione__c='Servizio Momentaneamente non disponibile';
            }
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_COdice_MOtivazione__c=resp.codice_motivazione;
            slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> return slPort');
        return slPort;  
    } 
    
    //PG - 12 - 07 - PORTAL_SyncChecksActivation_SVLAN
    //Metodo richiamato nella classe PO_PP_SVLAN_AttInserita_Controller
    public static EOF_EAI_Service_Log__c PORTAL_SyncChecksActivation_SVLAN(OF_PP_WS_IN_OLO_Activation.VLAN_PP act, EOF_EAI_Service_Log__c slPort)
    {
        OF_PP_GE_Utils.PORTAL=true;
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = SyncChecksActivationSVLAN(act);
        
        if(resp.esito=='0')
        {
            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESITO 0');
            slPort.EOF_Stato_Ordine__c='ATTIVO';//OF_PP_GE_Utils.caseOriginale.status;
            //slPort.EOF_Codice_ordine_eof__c=Id.valueOf(OF_PP_GE_Utils.caseOriginale.Id);
            slPort.Caso__c=Id.valueOf(OF_PP_GE_Utils.caseOriginale.Id);
            slPort.PO_SA_Data_Inserimento_Ordine__c=system.now();
            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESITO 1');
        }
        else
        {
            slPort.EOF_MOtivazione__c=resp.motivazione;
            if(resp.codice_motivazione=='A04'||resp.codice_motivazione=='200'||resp.codice_motivazione=='100')
            {
                slPort.EOF_Motivazione__c='Servizio Momentaneamente non disponibile';
            }
            slPort.EOF_Stato_Ordine__c='error';
            slPort.EOF_Codice_Motivazione__c=resp.codice_motivazione;
            //slPort.EOF_MOtivazione__c=resp.motivazione;
        }
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> return slPort');
        return slPort;  
    } 
    
    //PG - 12 - 07 - SyncChecksActivationSVLAN
    public static OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksActivationSVLAN(OF_PP_WS_IN_OLO_Activation.VLAN_PP act){
        
        system.debug('SyncChecksActivationSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PRIMA DI resp');
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();

        //creo e inserisco il log della VLAN con recordtype (OF_PP_VLAN_ActivationRequest) e dei relativi COS
        OF_PP_GE_Utils.slOLOSF = OF_PP_GE_Utils.create_EAI_Log(act);
        //System.debug('LLLLLLLL'+OF_PP_GE_Utils.create_EAI_Log(act));
        
        resp.ID_NOTIFICA=String.valueOf(Datetime.now().gettime());
        resp.ESITO='0';
                
        OF_PP_GE_Utils.OPName='Attivazione';
        OF_PP_GE_Utils.partialTemplog('ACQ.1');
        
        if(string.isblank(act.CODICE_OPERATORE)){
            return OF_PP_GE_Utils.syncError (act,'A05','CODICE_OPERATORE');
        }   

        Schema.DescribeFieldResult fieldResult = Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        
        for(Schema.PicklistEntry s : ple){
            if(act.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }    
        }
        if(!olo_found){
            return OF_PP_GE_Utils.syncError (act,'A06','CODICE_OPERATORE');
        }
        if(string.isblank(act.DATA_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A05','DATA_NOTIFICA');
        }
        if(!OF_PP_GE_Utils.checkDateTime(act.DATA_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A06','DATA_NOTIFICA');
        }
        if(string.isblank(act.ID_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A05','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.length()>100){
            return OF_PP_GE_Utils.syncError (act,'A06','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.contains('�')){
            return OF_PP_GE_Utils.syncError (act,'B04','ID_NOTIFICA');
        }
        resp.ID_NOTIFICA=act.ID_NOTIFICA;
                
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_PP_GE_Utils.partialTemplog('ACQ.2');
        // finisce qui        

        system.debug('SyncChecksActivationSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkRTMap');
        if(!OF_PP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_PP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_PP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_PP_GE_Utils.checkRTMap=true;
        }
        system.debug('SyncChecksActivationSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Case c = new Case');
    
        //Creazione case VLAN
        Case c = new Case(); 
        //Add by PG - 09-11
        c.Codice_Ordine_SFDC__c = act.CODICE_ORDINE_SFDC;
        c.Codice_Ordine_SO__c = act.CODICE_ORDINE_SO;
        //End by PG - 09-11
        c.RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_PP_PreProvisioning_Vlan');
        c.EOF_Codice_Operatore_WS__c = act.CODICE_OPERATORE;
        c.PO_PP_POP_SVLAN__c = act.POP;
        c.PO_PP_ID_Richiesta__c = act.ID_RICHIESTA;
        c.PO_PP_SVLAN__c = act.SVLAN;
        c.PO_PP_Cos_remarking__c = act.COS_REMARKING;
        c.PO_PP_DHCP_Option82__c = act.DHCP_OPTION82;
        c.PO_PP_Cos_Class__c = act.COS_CLASS;
        c.PO_PP_Cos_Type__c = act.COS_TYPE;
        c.EOF_Id_Notifica__c = act.ID_NOTIFICA;  
        c.Codice_Ordine_SO__c=act.CODICE_ORDINE_SO;
        c.AssetId = act.ID_ASSET;
        c.EOF_Data_Notifica__c = OF_PP_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        System.debug('****c.EOF_Data_Notifica__c****:'+c.EOF_Data_Notifica__c);
        c.subject = 'Richiesta Attivazione VLAN';
        c.status = 'Accettato';
        c.EOF_Note__c = act.NOTE;
        c.EOF_FASE__C = 'NA';
        c.PO_SA_Portale__c = OF_PP_GE_Utils.PORTAL;
        insert c;
        
        /*
        //Creazione dei COS (service log)
        List<EOF_EAI_Service_Log__c> list_cos = new List<EOF_EAI_Service_Log__c>();
        
        for(Integer i=0; i<act.listaCOS.size(); i++)
        {
            EOF_EAI_Service_Log__c sl_cos = new EOF_EAI_Service_Log__c();
            sl_cos.RecordTypeId = OF_PP_GE_Utils.rtMap.get('PO_PP_COS');
            sl_cos.PO_PP_Cos_Type__c = act.listaCOS.get(i).TIPO;
            sl_cos.PO_PP_Cos_Class__c = act.listaCOS.get(i).CLASSE;
            //sl_cos.PO_PP_ID_VLAN__c = act.ID;
            list_cos.add(sl_cos);
        }
        insert list_cos;
        */
    
        /*
        //creo il record di generatore ID Servizio che poi mi andrò a querare in asincrono
        OF_Generatore_ID_Servizio__c g = new OF_Generatore_ID_Servizio__c();
        g.OF_Case_Id__c=c.Id;
        insert g;
        */
         
        //system.debug('SyncChecksActivationSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> insert g:' + g.Id);

        OF_PP_GE_Utils.caseOriginale = c; 
        OF_PP_GE_Utils.checkCaseOriginale=true;
        system.debug('SyncChecksActivationSVLAN>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: '+OF_PP_GE_Utils.checkCaseOriginale);
        
        //system.debug('VLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.slOLOSF.Id: '+ OF_PP_GE_Utils.slOLOSF.Id);
        
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        
        system.debug('VLAN>>>>>>>>>>Prima della chiamata di create_EAI_Log ACK-VLAN');
        
        //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - ActivationRequestVlan) e aggiorno il sl di riferimento con l'ACK
        slToUpsert.add(OF_PP_GE_Utils.create_EAI_Log(new Map<String,String>{
                                             'Type' => 'ACK VLAN',
                                             'Codice_operatore' => act.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => act.CODICE_ORDINE_OLO,
                                             'Flusso' => 'SF-OLO',
                                             'Metodo' => 'OLO_ActivationRequestVLAN',
                                             'ID_notifica' => act.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - ActivationRequestVlan',
                                             'SL Riferimento' => OF_PP_GE_Utils.slOLOSF.Id
                                              }));
        
        OF_PP_GE_Utils.slOLOSF.EOF_Response__c='ACK';   
        OF_PP_GE_Utils.slOLOSF.Caso__c=c.Id;
        
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.slOLOSF.Id: '+OF_PP_GE_Utils.slOLOSF.Id);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.slOLOSF: '+OF_PP_GE_Utils.slOLOSF);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: '+OF_PP_GE_Utils.slOLOSF.Caso__c);
        slToUpsert.add(OF_PP_GE_Utils.slOLOSF);
        upsert slToUpsert;
        
        //Metodo future
        OF_PP_OLO_AsyncChecks.SVLAN_AsyncActivation(c.Id, OF_PP_GE_Utils.slOLOSF.Id);
        //OF_PP_GE_Utils.EndTemplog();
        
        return resp; 
    }

    /*
    public static OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse SyncChecksStatusUpdateSVLAN(OF_PP_WS_IN_OM_ResponseUpdate.VLAN_PP act){
        
        system.debug('SyncChecksStatusUpdateSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PRIMA DI resp');
        OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse resp = new OF_PP_WS_IN_OLO_Activation.OLO_ActivationResponse();

        //creo e inserisco il log della VLAN con recorddtype (OF_PP_VLAN_ActivationRequest) e dei relativi COS
        OF_PP_GE_Utils.slOLOSF = OF_PP_GE_Utils.create_EAI_Log(act);
        System.debug('aaaaaaaaaaaa'+OF_PP_GE_Utils.create_EAI_Log(act));
        
        resp.ID_NOTIFICA=String.valueOf(Datetime.now().gettime());
        resp.ESITO='0';
                
        OF_PP_GE_Utils.OPName='Attivazione';
        OF_PP_GE_Utils.partialTemplog('ACQ.1');
        
        if(string.isblank(act.CODICE_OPERATORE)){
            return OF_PP_GE_Utils.syncError (act,'A05','CODICE_OPERATORE');
        }   

        Schema.DescribeFieldResult fieldResult = Case.EOF_Codice_Operatore_WS__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Boolean olo_found = false;
        
        for(Schema.PicklistEntry s : ple){
            if(act.CODICE_OPERATORE == s.getLabel()){
                olo_found = true;
            }    
        }
        if(!olo_found){
            return OF_PP_GE_Utils.syncError (act,'A06','CODICE_OPERATORE');
        }
        if(string.isblank(act.DATA_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A05','DATA_NOTIFICA');
        }
        if(!OF_PP_GE_Utils.checkDateTime(act.DATA_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A06','DATA_NOTIFICA');
        }
        if(string.isblank(act.ID_NOTIFICA)){
            return OF_PP_GE_Utils.syncError (act,'A05','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.length()>100){
            return OF_PP_GE_Utils.syncError (act,'A06','ID_NOTIFICA');
        }
        else if(act.ID_NOTIFICA.contains('�')){
            return OF_PP_GE_Utils.syncError (act,'B04','ID_NOTIFICA');
        }
        resp.ID_NOTIFICA=act.ID_NOTIFICA;
                
        // 14/02/2018 MM: Aggiorno il timestamp. ACQ.2 corrisponde alla fine check acquisizione.
        OF_PP_GE_Utils.partialTemplog('ACQ.2');
        // finisce qui        

        system.debug('SyncChecksStatusUpdateSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkRTMap');
        if(!OF_PP_GE_Utils.checkRTMap){
            //vado a creare la mappa dei recordtype per poi utilizzarla
            OF_PP_GE_Utils.RTMap = new  map<String,String>();
            for(recordtype rt : [select id,developername from recordtype]){
                OF_PP_GE_Utils.RTMap.put(rt.developername,rt.id);
            }
            OF_PP_GE_Utils.checkRTMap=true;
        }
        system.debug('SyncChecksStatusUpdateSVLAN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Case c = new Case');
        
        //Creazione case VLAN
        Case c = new Case(); 
        c.RecordTypeId = OF_PP_GE_Utils.rtMap.get('OF_PP_PreProvisioning_Vlan');
        c.PO_PP_POP_SVLAN__c = act.POP;
        c.PO_PP_ID_Richiesta__c = act.ID_RICHIESTA;
        c.PO_PP_SVLAN__c = act.SVLAN;
        c.PO_PP_Cos_remarking__c = act.COS_REMARKING;
        c.PO_PP_DHCP_Option82__c = act.DHCP_OPTION82;
        c.PO_PP_Cos_Class__c = act.COS_CLASS;
        c.PO_PP_Cos_Type__c = act.COS_TYPE;
        c.EOF_Id_Notifica__c = act.ID_NOTIFICA;  
        c.AssetId = act.ID_ASSET;
        c.EOF_Data_Notifica__c = OF_PP_GE_Utils.StringToDate(act.DATA_NOTIFICA);
        System.debug('°°°°°---c.EOF_Data_Notifica__c---°°°°°:'+c.EOF_Data_Notifica__c);
        c.subject = 'Richiesta Attivazione VLAN';
        c.status = 'Accettato';
        c.EOF_Note__c = act.NOTE;
        c.EOF_FASE__C = 'NA';
        c.PO_SA_Portale__c = OF_PP_GE_Utils.PORTAL;
        insert c;

        OF_PP_GE_Utils.caseOriginale = c; 
        OF_PP_GE_Utils.checkCaseOriginale=true;
        system.debug('SyncChecksStatusUpdateSVLAN>>>>>>>>>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: '+OF_PP_GE_Utils.checkCaseOriginale);
        
        //system.debug('SyncChecksStatusUpdateSVLAN ---VLAN>>>>>>>>>>>>> OF_PP_GE_Utils.slOLOSF.Id: '+ OF_PP_GE_Utils.slOLOSF.Id);
        
        List<EOF_EAI_Service_Log__c> slToUpsert = new List<EOF_EAI_Service_Log__c>();
        
        system.debug('SyncChecksStatusUpdateSVLAN -VLAN>>>>>>>>>>Prima della chiamata di create_EAI_Log ACK-VLAN');
        
        //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - ActivationRequestVlan) e aggiorno il sl di riferimento con l'ACK
        slToUpsert.add(OF_PP_GE_Utils.create_EAI_Log(new Map<String,String>{
                                             'Type' => 'ACK VLAN',
                                             'Codice_operatore' => act.CODICE_OPERATORE,
                                             'Codice_ordine_OLO' => act.CODICE_ORDINE_OLO,
                                             'Flusso' => 'SF-OLO',
                                             'Metodo' => 'OLO_ActivationRequestVLAN',
                                             'ID_notifica' => act.ID_NOTIFICA,
                                             'Tipo Comunicazione' => 'OLO->SF - ACK - ActivationRequestVlan',
                                             'SL Riferimento' => OF_PP_GE_Utils.slOLOSF.Id
                                              }));
        
        OF_PP_GE_Utils.slOLOSF.EOF_Response__c='ACK';   
        OF_PP_GE_Utils.slOLOSF.Caso__c=c.Id;
    
        system.debug('SyncChecksStatusUpdateSVLAN>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.slOLOSF.Id: '+OF_PP_GE_Utils.slOLOSF.Id);
        system.debug('SyncChecksStatusUpdateSVLAN>>>>>>>>>>>>>>>>> OF_PP_GE_Utils.checkCaseOriginale: '+OF_PP_GE_Utils.slOLOSF.Caso__c);
        slToUpsert.add(OF_PP_GE_Utils.slOLOSF);
        upsert slToUpsert;
        
        //Metodo future
        OF_PP_OLO_AsyncChecks.SVLAN_AsyncActivation(c.Id, OF_PP_GE_Utils.slOLOSF.Id);
        OF_PP_GE_Utils.EndTemplog();
        
        return resp; 
    }
    */
}