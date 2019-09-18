public class PO_Serv_DarkFiber_UploadCSV_Ctrl 
{
    public string nameFile {get; set;}
    public Blob contentFile{get;set;}
    public Id accId;
    public EOF_EAI_Service_Log__c parentLogObj;
    
    public PO_Serv_DarkFiber_UploadCSV_Ctrl()
    {
        User usr = [Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
                contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
                contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
                contact.PO_Servizio_Backhauling__c,
                contact.PO_Servizio_BTS__c,
                contact.PO_Servizio_DarkFiber__c,
                contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,
                contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c
                From User
                Where Id =:System.UserInfo.getUserId()];
        
        accId = usr.Contact.Account.Id;
        
        //string parentid = apexpages.currentpage().getparameters().get('parentid');
        string parentid = apexpages.currentpage().getparameters().get('id');
        
        system.debug('giovanni parentid: ' + parentid);
        
        parentLogObj = [SELECT  CreatedDate, CreatedById, PO_Offerta__c,
                                PO_Nome_Progetto__c, EOF_Codice_Ordine_OLO__c
                                from EOF_EAI_Service_Log__c 
                                where Id=:parentid Limit 1];
        
        system.debug('giovanni parentLogObj: ' + parentLogObj);        
    }
    
    public PO_Serv_DarkFiber_UploadCSV_Ctrl(ApexPages.StandardController stdController)
    {
        /*
        User usr = [Select Name,Profile.Name,IsActive,Contact.Account.Id ,Contact.Account.Name, contact.PO_Servizi_a_fattibilit__c,
                contact.PO_P2P_Base__c,contact.PO_Fiber_Link__c,contact.PO_IRU__c,contact.PO_Fiber_Lease__c,
                contact.PO_Misto_Fiber_Lease_Link_per_Fastweb__c,contact.PO_Servizio_Open_Stream__c,
                contact.PO_Servizio_Backhauling__c,
                contact.PO_Servizio_DarkFiber__c,
                contact.PO_Servizio_DarkFiber__c,
                contact.PO_Servizio_Trouble_Ticket__c,Contact.PO_Servizio_Ticket_Provisioning__c,
                contact.PO_Servizio_Incident_Management__c, contact.PO_Servizio_KIT__c, contact.PO_P2P_Attiva__c, contact.PO_Change_Order__c
                From User
                Where Id =:System.UserInfo.getUserId()];
        
        accId = usr.Contact.Account.Id;
        
        //string parentid = apexpages.currentpage().getparameters().get('parentid');
        string parentid = apexpages.currentpage().getparameters().get('id');
        
        system.debug('giovanni parentid: ' + parentid);
        
        parentLogObj = [SELECT  CreatedDate, CreatedById, PO_Offerta__c,
                                PO_Nome_Progetto__c
                                from EOF_EAI_Service_Log__c 
                                where Id=:parentid Limit 1];
        
        system.debug('giovanni parentLogObj: ' + parentLogObj);
        */
    }
    
    public Pagereference Annulla()
    {          
          //PageReference pageRef = new PageReference('/PO_Serv_DarkFiber_NuovaRichiesta');        
          PageReference pageRef = new PageReference('/partnercommunity'); 
          pageRef.setRedirect(true);        
          return pageRef; 
    }
    
    public static String blobToString(Blob input, String inCharset) 
    {
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        
        for(Integer i = 0; i < bytesCount; ++i)
        {            
            bytes[i] =  hex.mid(i << 1, 2);
        }
        
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }    
    
    public String ReadContent(Blob contentFile, string accId, EOF_EAI_Service_Log__c parentLogObj)
    {
        String fileContentStr;
        List<String> filelines = new List<String>();
        List<EOF_EAI_Service_Log__c> logsToUpload = new List<EOF_EAI_Service_Log__c>();
        List<String> junkLogs = new List<String>();

        if(contentFile == null) 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
            return 'KO';
        }
        else
        {
            //Convert the uploaded file which is in BLOB format into a string
            fileContentStr = blobToString( contentFile,'ISO-8859-1');
            filelines = fileContentStr.split('\n');
            /*
            if(filelines.size() > 50)
            {
                //Database.executeBatch(new PO_MassiveImport_Batch(fileContentStr, rtName, parentCaseObj, accId, 2));
                Database.executeBatch(new PO_Serv_DarkFiber_MassiveImport_Batch(fileContentStr, rtName, parentLogObj, accId, 2));                
                return 'OK-BATCH';
            }else
            {
                //Done AA - Implementare il metodo di lettura syncrono
                return syncReadFileFiberLease(parentLogObj, filelines, rtName, accId);
            }
            */
            return syncReadFileDarkFiber(parentLogObj, filelines, accId);
        }        
    }
    
    private static String syncReadFileDarkFiber(EOF_EAI_Service_Log__c parentLogObj, List<String> filelines, String accId){
        List<EOF_EAI_Service_Log__c> logsToUpload = new List<EOF_EAI_Service_Log__c>();
        List<String> junkLogs = new List<String>();
        //Iterate through every line and create a Case record for each row
        try{
            recordtype rt = [select id from recordtype where sobjectType ='EOF_EAI_Service_Log__c' and developername='PO_Log_DarkFiber_Collegamento'];           
            
            List<OF_ElencoComuniItaliani__c> listComuni = [SELECT id,OF_Comune__c, OF_Ripartizionegeografica__c 
                                                            FROM OF_ElencoComuniItaliani__c];
            Map<String, OF_ElencoComuniItaliani__c> mapComuni = new Map<String, OF_ElencoComuniItaliani__c>();

            for(OF_ElencoComuniItaliani__c tmp : listComuni){
                // CR 2019-002 (Nome comune case insensitive)
                if(String.isBlank(tmp.OF_Comune__c)) {
                    continue;
                }
                String lowerName = tmp.OF_Comune__c.toLowerCase();
                mapComuni.put(lowerName, tmp);
            }
            //TODO AA Controllare il tipo richiesta
            system.debug('giovanni filelines: ' + filelines);
            for (Integer i=1;i<filelines.size();i++){
                String errorString = '';
                List<String> inputvalues = new List<String>();
                inputvalues = filelines[i].split(',');
                
                system.debug('giovanni inputvalues: ' + inputvalues);

                EOF_EAI_Service_Log__c c = new EOF_EAI_Service_Log__c();
                /*
                if(rtName.equalsIgnoreCase('fiberlease') ){
                    c.RecordTypeId = rt1.id;
                }
                else if(rtName.equalsIgnoreCase('iru') ){
                    c.recordTypeId = rt2.id;
                }
                */
                
                system.debug('giovanni rt: ' + rt);
                system.debug('giovanni c: ' + c);
                system.debug('giovanni parentLogObj: ' + parentLogObj);
                
                c.recordTypeId = rt.id;
                
                //Lego il collegamento al parentLog
                //c.parentid = parentCaseObj.id;
                c.EOF_SL_Riferimento__c = parentLogObj.id;
                
                //c.EOF_Codice_Ordine_OLO__c = parentLogObj.EOF_Codice_Ordine_OLO__c;                
                
                //c.PO_Richiesta_a_fattibilit__c = parentCaseObj.id;
                
                //c.Status = 'Bozza';
                c.EOF_Stato_Richiesta__c = 'Bozza';
                c.EOF_STATO_ORDINE__c = 'Bozza';
                
                //c.accountid = accId;
                
                //Colonna 0 prime contractor
                if(inputvalues[0] != null && String.isNotBlank(inputvalues[0]) ){
                    if(inputvalues[0].length() <= 25){
                        c.PO_Prime_Contractor__c = inputvalues[0];
                    }else{
                        errorString = errorString + 'Lunghezza campo Prime Contractor errata(max 25)';
                    }
                }else{
                    errorString = errorString + 'Campo Prime Contractor obbligatorio.';
                }
                //Fine colonna 0
                //Colonna 1 Tipo di collegamento

                    if(inputvalues[1] != null && String.isNotBlank(inputvalues[1]) ){
                        if(inputvalues[1].equalsIgnoreCase('DarkFiber') || inputvalues[1].equalsIgnoreCase('DarkFiber') || inputvalues[1].equalsIgnoreCase('P2P - Cliente') 
                            || inputvalues[1].equalsIgnoreCase('Dark Fiber')
                            || inputvalues[1].equalsIgnoreCase('Point-to-Point')){
                            c.PO_Tipo_di_collegamento__c = inputvalues[1];
                        }else{
                            errorString = errorString + 'Valore campo Tipo di collegamento non ammesso.';
                        }
                    }else{
                        errorString = errorString + 'Campo Tipo di collegamento obbligatorio.';
                    }

                //Fine colonna 1
                //Colonna 2 Numero fibre richieste

                    if(inputvalues[2] != null && String.isNotBlank(inputvalues[2]) ){ 
                        //giovanni 03/12/2018 inizio
                        //if(inputvalues[2].equalsIgnoreCase('2') ){
                        if(inputvalues[2].equalsIgnoreCase('2') || inputvalues[2].equalsIgnoreCase('2+2')){
                        //giovanni 03/12/2018 fine
                            c.PO_Numero_fibre_richieste__c = inputvalues[2];
                        }else{
                            errorString = errorString + 'Valore campo Numero fibre richieste non ammesso.';
                        }
                    }else{
                        errorString = errorString + 'Campo Numero fibre richieste obbligatorio.';
                    }
                
                //Fine colonna 2
                //Colonna 3 Tipo percorso

                    if(inputvalues[3] != null && String.isNotBlank(inputvalues[3]) ){
                        if(inputvalues[3].equalsIgnoreCase('Singola via') || inputvalues[3].equalsIgnoreCase('Doppia via') ){
                            c.PO_Tipo_percorso__c = inputvalues[3];
                        }else{
                            errorString = errorString + 'Valore campo Tipo percorso non ammesso.';
                        }
                    }else{
                        errorString = errorString + 'Campo Tipo percorso obbligatorio.';
                    }
                
                //Fine colonna 3
                //Colonna 4 Comune Partenza
                if(inputvalues[4] != null && String.isNotBlank(inputvalues[4]) ){
                    OF_ElencoComuniItaliani__c tmpComune = mapComuni.get(inputvalues[4].toLowerCase());
                    if( tmpComune != null && String.isNotBlank(tmpComune.Id) ){
                        //c.PO_Comune2__c = tmpComune.Id;
                        
                        //c.EOF_Comune__c = tmpComune.Id;
                        c.EOF_Comune__c = tmpComune.OF_Comune__c;
                        
                        //giovanni 20112018 inizio
                        c.OF_Id_Comune__c = tmpComune.Id;
                        //giovanni 20112018 fine
                        
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        //c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune Partenza non ammesso';
                    }
                }else{
                    errorString = errorString + 'Campo Comune Partenza obbligatorio.';
                }
                //Fine colonna 4
                //Colonna 5 Sito Partenza
                if(inputvalues[5] != null && String.isNotBlank(inputvalues[5]) ){
                    if(inputvalues[5].length() <= 50){
                        c.PO_Sito__c = inputvalues[5];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito Partenza errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Sito Partenza obbligatorio.';
                }
                //Fine colonna 5
                
                //Colonna 6 Particella Toponomastica
                if(inputvalues[6] != null && String.isNotBlank(inputvalues[6]) ){
                    c.Particella_Toponomastica_1__c = inputvalues[6];
                }else{
                    errorString = errorString + 'Campo Particella Toponomastica obbligatorio.';
                }
                //Fine colonna 6                
                
                //Colonna 7 Indirizzo Collegamento
                if(inputvalues[7] != null && String.isNotBlank(inputvalues[7]) ){
                    if(inputvalues[7].length() <= 50){
                        c.PO_Indirizzo_collegamento__c = inputvalues[7];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo Collegamento errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo Collegamento obbligatorio.';
                }
                //Fine colonna 7
                //Colonna 8 Civico
                if(inputvalues[8] != null && String.isNotBlank(inputvalues[8]) ){
                    if(inputvalues[8].length() <= 10){
                        c.PO_Civico__c = inputvalues[8];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico errata(max 10)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico obbligatorio.';
                }
                //Fine colonna 8
                //Colonna 9 Nota Sito
                if(inputvalues[9] != null && String.isNotBlank(inputvalues[9]) ){
                    if(inputvalues[9].length() <= 255){
                        c.PO_Nota_sito__c = inputvalues[9];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito obbligatorio.';
                }
                //Fine colonna 9
                //Colonna 10 Comune di destinazione
                if(inputvalues[10] != null && String.isNotBlank(inputvalues[10]) ){
                    OF_ElencoComuniItaliani__c tmpComune2 = mapComuni.get(inputvalues[10].toLowerCase());
                    if( tmpComune2 != null && String.isNotBlank(tmpComune2.Id) ){
                        //c.PO_Comune3__c = tmpComune2.Id;
                        
                        //c.EOF_Comune__c = tmpComune2.Id;
                        //c.EOF_Comune__c = tmpComune2.OF_Comune__c;
                        
                        //giovanni 20112018 inizio
                        c.PO_Log_Comune_2__c = tmpComune2.OF_Comune__c;                         
                        c.PO_Log_IdComune2__c = tmpComune2.Id;
                        //giovanni 20112018 fine
                        
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        //c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune2.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune di destinazione non ammesso';
                    }
                }else{
                    errorString = errorString + 'Campo Comune di destinazione obbligatorio.';
                }
                //Fine colonna 10
                //Colonna 11 Sito destinazione
                if(inputvalues[11] != null && String.isNotBlank(inputvalues[11]) ){
                    if(inputvalues[11].length() <= 50){
                        //c.PO_Sito_partenza__c = inputvalues[11];
                        c.EOF_SITO__c = inputvalues[11];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito destinazione errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Sito destinazione obbligatorio.';
                }
                //Fine colonna 11
                
                //Colonna 12 Particella Toponomastica
                if(inputvalues[12] != null && String.isNotBlank(inputvalues[12]) ){
                    c.Particella_Toponomastica_2__c = inputvalues[12];
                }else{
                    errorString = errorString + 'Campo Particella Toponomastica obbligatorio.';
                }
                //Fine colonna 12 
                
                //Colonna 13 Indirizzo destinazione
                if(inputvalues[13] != null && String.isNotBlank(inputvalues[13]) ){
                    if(inputvalues[13].length() <= 50){
                        //c.PO_Indirizzo_collegamento_partenza__c = inputvalues[13];
                        c.EOF_INDIRIZZO__c = inputvalues[13];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo destinazione errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo destinazione obbligatorio.';
                }
                //Fine colonna 13
                //Colonna 14 Civico destinazione
                if(inputvalues[14] != null && String.isNotBlank(inputvalues[14]) ){
                    if(inputvalues[14].length() <= 10){
                        //c.PO_Civico_partenza__c = inputvalues[14];
                        c.EOF_NUMERO_CIVICO__c = inputvalues[14];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico destinazione errata(max 10)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico destinazione obbligatorio.';
                }
                //Fine colonna 14
                //Colonna 15 Nota Sito destinazione
                if(inputvalues[15] != null && String.isNotBlank(inputvalues[15]) ){
                    if(inputvalues[15].length() <= 255){
                        //c.PO_Nota_sito_partenza__c = inputvalues[15];
                        c.EOF_NOTA_SITO__c = inputvalues[15];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito destinazione errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito destinazione obbligatorio.';
                }
                //Fine colonna 15
                //Setto il flag import massivo sul case
                //c.isMassive__c = true;
                //Se ci sono stati errori scarto il case, altrimenti lo aggiungo alla lista da inserire
                if(String.isNotBlank(errorString)){
                    
                    system.debug('giovanni errorString: ' + errorString);
                    
                    filelines[i] = errorString + ',' +filelines[i];
                    junkLogs.add(filelines[i]);
                }else{
                    logsToUpload.add(c);
                }
            }
            if(!junkLogs.isEmpty()){
                String finalString = '';
                for(String x : junkLogs){
                    finalString = finalString + x;
                }
                Blob b = Blob.valueOf(finalString);
                Attachment attach = new Attachment(); //Make an attachment
                    attach.Name = 'Scarti_DarkFiber_'+System.now()+'.csv';  
                    attach.Body = b;
                    attach.ContentType= 'text/csv'; //Signal what the file's MIME type is
                    attach.ParentID = parentLogObj.Id;
                insert attach;
                b = null;
                /*PageReference pg = new PageReference('/servlet/servlet.FileDownload?file='+attach.Id);
                return pg;*/
                return 'KO-'+attach.Id;
            }else{
                System.debug('****** giovanni logsToUpload ' + logsToUpload);
                insert logsToUpload;               String theAccountName = parentLogObj.EOF_Codice_Ordine_OLO__c.substring(0,4);  
                
                System.debug('****** giovanni theAccountName ' + theAccountName);
                
                logsToUpload = [SELECT Name FROM EOF_EAI_Service_Log__c WHERE Id in :logsToUpload];
                
                for(EOF_EAI_Service_Log__c logToUpdate : logsToUpload)   {
                    System.debug('****** giovanni il name ' + logToUpdate.Name);
                    logToUpdate.EOF_Codice_Ordine_OLO__c = logToUpdate.Name.replace('LOG-', theAccountName);
                }
                update logsToUpload; 
                //giovanni 20112018 fine                
                
                return 'OK-SYNC';
            }
        }catch(Exception e){
            System.debug('****** FIBERLEASE O IRU has exception!!!!!');
            System.debug('****** giovanni exception ' + e);
            return 'File-Error';
        }
    } 
     
    
    public Pagereference ReadFile()
    {
        if(contentFile== null) 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
            return null;
        }
        else
        {
            String rtnValue = ReadContent(contentFile, accId, parentLogObj);
            System.debug('******* Parent offer = IRU && rtnValue = ' + rtnValue);
            List<String> rtnValueEsito = rtnValue.split('-');
            System.debug('******* Parent offer = IRU && rtnValueSplitted = ' + rtnValueEsito);
            if(rtnValueEsito.size() > 1){
                if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'SYNC'){
                    //return IRU();
                    PageReference pg = new PageReference('/apex/PO_Serv_DarkFiber_Richieste');                    return pg;
                }else if( rtnValueEsito[0] =='OK' && rtnValueEsito[1] == 'BATCH' ){
                    PageReference pg = new PageReference('/apex/PO_Result_Import');                    return pg;
                }else if(rtnValueEsito[0] =='File' && rtnValueEsito[1] == 'Error'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'File non valido!')); 
                    return null;
                }else{
                    PageReference pg = new PageReference('/apex/PO_JunkCases'); pg.getParameters().put('id', rtnValueEsito[1]); pg.getParameters().put('parentId', parentLogObj.Id);                     return pg;
                }
            }            
        }
        
        return null;
    }    
}