public class PO_ImportaCollegamentiMassivo {

    public static String ReadFileFiberLink(Blob contentFile, string accId, Case parentCaseObj, String rtName){
        String fileContentStr;
        List<String> filelines = new List<String>();
        

        if(contentFile == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
            return 'KO';
        }else{
            //Convert the uploaded file which is in BLOB format into a string
            fileContentStr = blobToString( contentFile,'ISO-8859-1');
            filelines = fileContentStr.split('\n');
            System.debug('*****filelines.size***:'+filelines.size());
            
            if(filelines.size() > 50){
                Database.executeBatch(new PO_MassiveImport_Batch(fileContentStr, rtName, parentCaseObj, accId, 3));
                return 'OK-BATCH';
            }else{
                //Done AA - Implementare il metodo di lettura syncrono
                return syncReadFileFiberLink(parentCaseObj, filelines, rtName, accId);
            }
		}
    }
    private static String syncReadFileFiberLink(Case parentCaseObj, List<String> filelines, String rtName, String accId){
        List<Case> caseToUpload = new List<Case>();
        List<String> junkCases = new List<String>();
        //Iterate through every line and create a Case record for each row
        try{
            recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
            recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
            
            List<OF_ElencoComuniItaliani__c> listComuni = [SELECT id,OF_Comune__c, OF_Ripartizionegeografica__c 
                                                            FROM OF_ElencoComuniItaliani__c
                                                            ];
            Map<String, OF_ElencoComuniItaliani__c> mapComuni = new Map<String, OF_ElencoComuniItaliani__c>();

            for(OF_ElencoComuniItaliani__c tmp : listComuni){
                mapComuni.put(tmp.OF_Comune__c, tmp);
            }

            for (Integer i=1;i<filelines.size();i++){
                String errorString = '';
                List<String> inputvalues = new List<String>();
                inputvalues = filelines[i].split(',');
                System.debug('***** LINEA ' + i + ' VALORI INPUTVALUES = ' + inputvalues);
                Case c = new Case();
                if(rtName.equalsIgnoreCase('fiberlink') ){
                    c.RecordTypeId = rt2.id;
                }
                else if(rtName.equalsIgnoreCase('temporaneo') ){
                    c.recordTypeId = rt3.id;
                }
                //Lego il collegamento al parentLog
                c.parentid = parentCaseObj.id;
                c.PO_Richiesta_a_fattibilit__c = parentCaseObj.id;
                c.Status = 'Bozza';
                c.accountid = accId;
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
                    if(inputvalues[1].equalsIgnoreCase('Backhauling') || inputvalues[1].equalsIgnoreCase('BTS') || inputvalues[1].equalsIgnoreCase('Point-to-Point') 
                        || inputvalues[1].equalsIgnoreCase('Housing') || inputvalues[1].equalsIgnoreCase('Anello') ){
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
                    if(inputvalues[2].equalsIgnoreCase('1') || inputvalues[2].equalsIgnoreCase('2') || inputvalues[2].equalsIgnoreCase('4') ){
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
                    if(inputvalues[3].equalsIgnoreCase('Singola via') || inputvalues[3].equalsIgnoreCase('Doppia via diversificata') ){
                        c.PO_Tipo_percorso__c = inputvalues[3];
                    }else{
                        errorString = errorString + 'Valore campo Tipo percorso non ammesso.';
                    }
                }else{
                    errorString = errorString + 'Campo Tipo percorso obbligatorio.';
                }
                //Fine colonna 3
                //Colonna 4 Comune1
                if(inputvalues[4] != null && String.isNotBlank(inputvalues[4]) ){
                    OF_ElencoComuniItaliani__c tmpComune = mapComuni.get(inputvalues[4]);
                    if( tmpComune != null && String.isNotBlank(tmpComune.Id) ){
                        c.PO_Comune2__c = tmpComune.Id;
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune1 non ammesso';
                    }
                }else{
                    errorString = errorString + 'Campo Comune1 obbligatorio.';
                }
                //Fine colonna 4
                //Colonna 5 Sito1
                if(inputvalues[5] != null && String.isNotBlank(inputvalues[5]) ){
                    if(inputvalues[5].length() <= 50){
                        c.PO_Sito__c = inputvalues[5];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito1 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Sito1 obbligatorio.';
                }
                //Fine colonna 5
                //Colonna 6 Indirizzo1
                if(inputvalues[6] != null && String.isNotBlank(inputvalues[6]) ){
                    if(inputvalues[6].length() <= 50){
                        c.PO_Indirizzo_collegamento__c = inputvalues[6];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo1 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo1 obbligatorio.';
                }
                //Fine colonna 6
                //Colonna 7 Civico1
                if(inputvalues[7] != null && String.isNotBlank(inputvalues[7]) ){
                    if(inputvalues[7].length() <= 50){
                        c.PO_Civico__c = inputvalues[7];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico1 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico1 obbligatorio.';
                }
                //Fine colonna 7
                //Colonna 8 Nota Sito1
                if(inputvalues[8] != null && String.isNotBlank(inputvalues[8]) ){
                    if(inputvalues[8].length() <= 255){
                        c.PO_Nota_sito__c = inputvalues[8];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito1 errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito1 obbligatorio.';
                }
                //Fine colonna 8
                //Colonna 9 Comune2
                if(inputvalues[9] != null && String.isNotBlank(inputvalues[9]) ){
                    OF_ElencoComuniItaliani__c tmpComune2 = mapComuni.get(inputvalues[9]);
                    if( tmpComune2 != null && String.isNotBlank( tmpComune2.Id ) ){
                        c.PO_Comune3__c = tmpComune2.Id;
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune2.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune2 non ammesso';
                    }
                }else{
                    errorString = errorString + 'Campo Comune2 obbligatorio.';
                }
                //Fine colonna 9
                //Colonna 10 Sito2
                if(inputvalues[10] != null && String.isNotBlank(inputvalues[10]) ){
                    if(inputvalues[10].length() <= 50){
                        c.PO_Sito_partenza__c = inputvalues[10];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito2 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Sito2 obbligatorio.';
                }
                //Fine colonna 10
                //Colonna 11 Indirizzo2
                if(inputvalues[11] != null && String.isNotBlank(inputvalues[11]) ){
                    if(inputvalues[11].length() <= 50){
                        c.PO_Indirizzo_collegamento_partenza__c = inputvalues[11];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo2 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo2 obbligatorio.';
                }
                //Fine colonna 11
                //Colonna 12 Civico2
                if(inputvalues[12] != null && String.isNotBlank(inputvalues[12]) ){
                    if(inputvalues[12].length() <= 255){
                        c.PO_Civico_partenza__c = inputvalues[12];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico2 errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico2 obbligatorio.';
                }
                //Fine colonna 12
                //Colonna 13 Nota Sito2
                if(inputvalues[13] != null && String.isNotBlank(inputvalues[13]) ){
                    if(inputvalues[13].length() <= 255){
                        c.PO_Nota_sito_partenza__c = inputvalues[13];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito2 errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito2 obbligatorio.';
                }
                //Fine colonna 13
                //!!!!COLONNE OPZIONALI!!!!
                //Colonna 14 Comune3
                if(inputvalues[14] != null && String.isNotBlank(inputvalues[14]) ){
                    OF_ElencoComuniItaliani__c tmpComune3 = mapComuni.get(inputvalues[14]);
                    if( tmpComune3 != null && String.isNotBlank(tmpComune3.Id) ){
                        c.PO_Comune4__c = tmpComune3.Id;
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune3.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune3 non ammesso';
                    }
                }
                //Fine colonna 14
                //Colonna 15 Sito3
                if(inputvalues[15] != null && String.isNotBlank(inputvalues[15]) ){
                    if(inputvalues[15].length() <= 50){
                        c.PO_Sito_3__c = inputvalues[15];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito3 errata(max 50)';
                    }
                }
                //Fine colonna 15
                //Colonna 16 Indirizzo3
                if(inputvalues[16] != null && String.isNotBlank(inputvalues[16]) ){
                    if(inputvalues[16].length() <= 50){
                        c.PO_indirizzo_collegamento_3__c = inputvalues[16];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo3 errata(max 50)';
                    }
                }
                //Fine colonna 16
                //Colonna 17 Civico3
                if(inputvalues[17] != null && String.isNotBlank(inputvalues[17]) ){
                    if(inputvalues[17].length() <= 255){
                        c.PO_Civico_3__c = inputvalues[17];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico3 errata(max 50)';
                    }
                }
                //Fine colonna 17
                //Colonna 18 Nota Sito3
                if(inputvalues[18] != null && String.isNotBlank(inputvalues[18]) ){
                    if(inputvalues[18].length() <= 255){
                        c.PO_Nota_sito_3__c = inputvalues[18];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito3 errata(max 255)';
                    }
                }
                //Setto il flag import massivo sul case
                c.isMassive__c = true;
                //Se ci sono stati errori scarto il case, altrimenti lo aggiungo alla lista da inserire
                if(String.isNotBlank(errorString)){
                    filelines[i] = errorString + ',' + filelines[i];
                    junkCases.add(filelines[i]);
                }else{
                    caseToUpload.add(c);
                }
            }
            if(!junkCases.isEmpty()){
                String finalString = '';
                for(String x : junkCases){
                    finalString = finalString + x;
                }
                Blob b = Blob.valueOf(finalString);
                Attachment attach = new Attachment(); //Make an attachment
                    attach.Name = 'Scarti_'+rtName+'_'+System.now()+'.csv';  
                    attach.Body = b;
                    attach.ContentType= 'text/csv'; //Signal what the file's MIME type is
                    attach.ParentID = parentCaseObj.Id;
                insert attach;
                b = null;
                /*PageReference pg = new PageReference('/servlet/servlet.FileDownload?file='+attach.Id);
                return pg;*/
                return 'KO-'+attach.Id;
            }else{
                insert caseToUpload;
                return 'OK-SYNC';
            }
        }catch(Exception e){
            return 'File-Error';
        }
    }
    
    public static String ReadFileFiberLease(Blob contentFile, string accId, Case parentCaseObj, String rtName){
        String fileContentStr;
        List<String> filelines = new List<String>();
        List<Case> caseToUpload = new List<Case>();
        List<String> junkCases = new List<String>();

        if(contentFile == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
            return 'KO';
        }else{
            //Convert the uploaded file which is in BLOB format into a string
            fileContentStr = blobToString( contentFile,'ISO-8859-1');
            filelines = fileContentStr.split('\n');
            if(filelines.size() > 50){
                Database.executeBatch(new PO_MassiveImport_Batch(fileContentStr, rtName, parentCaseObj, accId, 2));
                return 'OK-BATCH';
            }else{
                //Done AA - Implementare il metodo di lettura syncrono
                return syncReadFileFiberLease(parentCaseObj, filelines, rtName, accId);
            }
        }
    }
    private static String syncReadFileFiberLease(Case parentCaseObj, List<String> filelines, String rtName, String accId){
        List<Case> caseToUpload = new List<Case>();
        List<String> junkCases = new List<String>();
        //Iterate through every line and create a Case record for each row
        try{
        recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
        recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
        
        List<OF_ElencoComuniItaliani__c> listComuni = [SELECT id,OF_Comune__c, OF_Ripartizionegeografica__c 
                                                        FROM OF_ElencoComuniItaliani__c
                                                      ];
        Map<String, OF_ElencoComuniItaliani__c> mapComuni = new Map<String, OF_ElencoComuniItaliani__c>();

        for(OF_ElencoComuniItaliani__c tmp : listComuni){
            mapComuni.put(tmp.OF_Comune__c, tmp);
        }
        //TODO AA Controllare il tipo richiesta
        for (Integer i=1;i<filelines.size();i++){
            String errorString = '';
            List<String> inputvalues = new List<String>();
            inputvalues = filelines[i].split(',');

            Case c = new Case();
            if(rtName.equalsIgnoreCase('fiberlease') ){
                c.RecordTypeId = rt1.id;
            }
            else if(rtName.equalsIgnoreCase('iru') ){
                c.recordTypeId = rt2.id;
            }
            //Lego il collegamento al parentLog
            c.parentid = parentCaseObj.id;
            c.PO_Richiesta_a_fattibilit__c = parentCaseObj.id;
            c.Status = 'Bozza';
            c.accountid = accId;
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
            if(rtName.equalsIgnoreCase('fiberlease')){
                if(inputvalues[1] != null && String.isNotBlank(inputvalues[1]) ){
                    if(inputvalues[1].equalsIgnoreCase('SDH') || inputvalues[1].equalsIgnoreCase('DWDM') || inputvalues[1].equalsIgnoreCase('IP') 
                        || inputvalues[1].equalsIgnoreCase('Layer 2') || inputvalues[1].equalsIgnoreCase('NGN') || inputvalues[1].equalsIgnoreCase('MSAN') ){
                        c.PO_Tipo_di_collegamento__c = inputvalues[1];
                    }else{
                        errorString = errorString + 'Valore campo Tipo di collegamento non ammesso.';
                    }
                }else{
                    errorString = errorString + 'Campo Tipo di collegamento obbligatorio.';
                }
            }else if(rtName.equalsIgnoreCase('iru')){
                if(inputvalues[1] != null && String.isNotBlank(inputvalues[1]) ){
                    if(inputvalues[1].equalsIgnoreCase('BTS') || inputvalues[1].equalsIgnoreCase('Backhauling') || inputvalues[1].equalsIgnoreCase('P2P - Cliente') 
                        || inputvalues[1].equalsIgnoreCase('Dark Fiber')){
                        c.PO_Tipo_di_collegamento__c = inputvalues[1];
                    }else{
                        errorString = errorString + 'Valore campo Tipo di collegamento non ammesso.';
                    }
                }else{
                    errorString = errorString + 'Campo Tipo di collegamento obbligatorio.';
                }
            }
            //Fine colonna 1
            //Colonna 2 Numero fibre richieste
            if(rtName.equalsIgnoreCase('fiberlease')){
                if(inputvalues[2] != null && String.isNotBlank(inputvalues[2]) ){
                    if(inputvalues[2].equalsIgnoreCase('1') || inputvalues[2].equalsIgnoreCase('2') || inputvalues[2].equalsIgnoreCase('4') ){
                        c.PO_Numero_fibre_richieste__c = inputvalues[2];
                    }else{
                        errorString = errorString + 'Valore campo Numero fibre richieste non ammesso.';
                    }
                }else{
                    errorString = errorString + 'Campo Numero fibre richieste obbligatorio.';
                }
            }else if(rtName.equalsIgnoreCase('iru')){
                if(inputvalues[2] != null && String.isNotBlank(inputvalues[2]) ){
                    if(inputvalues[2].equalsIgnoreCase('2') ){
                        c.PO_Numero_fibre_richieste__c = inputvalues[2];
                    }else{
                        errorString = errorString + 'Valore campo Numero fibre richieste non ammesso.';
                    }
                }else{
                        errorString = errorString + 'Campo Numero fibre richieste obbligatorio.';
                    }
                }
                //Fine colonna 2
                //Colonna 3 Tipo percorso
                if(rtName.equalsIgnoreCase('fiberlease')){
                    if(inputvalues[3] != null && String.isNotBlank(inputvalues[3]) ){
                        if(inputvalues[3].equalsIgnoreCase('Singola via') || inputvalues[3].equalsIgnoreCase('Doppia via diversificata') ){
                            c.PO_Tipo_percorso__c = inputvalues[3];
                        }else{
                            errorString = errorString + 'Valore campo Tipo percorso non ammesso.';
                        }
                    }else{
                        errorString = errorString + 'Campo Tipo percorso obbligatorio.';
                    }
                }else if(rtName.equalsIgnoreCase('iru')){
                    if(inputvalues[3] != null && String.isNotBlank(inputvalues[3]) ){
                        if(inputvalues[3].equalsIgnoreCase('Singola via') || inputvalues[3].equalsIgnoreCase('Doppia via') ){
                            c.PO_Tipo_percorso__c = inputvalues[3];
                        }else{
                            errorString = errorString + 'Valore campo Tipo percorso non ammesso.';
                        }
                    }else{
                        errorString = errorString + 'Campo Tipo percorso obbligatorio.';
                    }
                }
                //Fine colonna 3
                //Colonna 4 Comune Partenza
                if(inputvalues[4] != null && String.isNotBlank(inputvalues[4]) ){
                    OF_ElencoComuniItaliani__c tmpComune = mapComuni.get(inputvalues[4]);
                    if( tmpComune != null && String.isNotBlank(tmpComune.Id) ){
                        c.PO_Comune2__c = tmpComune.Id;
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
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
                //Colonna 6 Indirizzo Collegamento
                if(inputvalues[6] != null && String.isNotBlank(inputvalues[6]) ){
                    if(inputvalues[6].length() <= 50){
                        c.PO_Indirizzo_collegamento__c = inputvalues[6];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo Collegamento errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo Collegamento obbligatorio.';
                }
                //Fine colonna 6
                //Colonna 7 Civico
                if(inputvalues[7] != null && String.isNotBlank(inputvalues[7]) ){
                    if(inputvalues[7].length() <= 50){
                        c.PO_Civico__c = inputvalues[7];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico obbligatorio.';
                }
                //Fine colonna 7
                //Colonna 8 Nota Sito
                if(inputvalues[8] != null && String.isNotBlank(inputvalues[8]) ){
                    if(inputvalues[8].length() <= 255){
                        c.PO_Nota_sito__c = inputvalues[8];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito obbligatorio.';
                }
                //Fine colonna 8
                //Colonna 9 Comune di destinazione
                if(inputvalues[9] != null && String.isNotBlank(inputvalues[9]) ){
                    OF_ElencoComuniItaliani__c tmpComune2 = mapComuni.get(inputvalues[9]);
                    if( tmpComune2 != null && String.isNotBlank(tmpComune2.Id) ){
                        c.PO_Comune3__c = tmpComune2.Id;
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune2.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune di destinazione non ammesso';
                    }
                }else{
                    errorString = errorString + 'Campo Comune di destinazione obbligatorio.';
                }
                //Fine colonna 9
                //Colonna 10 Sito destinazione
                if(inputvalues[10] != null && String.isNotBlank(inputvalues[10]) ){
                    if(inputvalues[10].length() <= 50){
                        c.PO_Sito_partenza__c = inputvalues[10];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito destinazione errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Sito destinazione obbligatorio.';
                }
                //Fine colonna 10
                //Colonna 11 Indirizzo destinazione
                if(inputvalues[11] != null && String.isNotBlank(inputvalues[11]) ){
                    if(inputvalues[11].length() <= 50){
                        c.PO_Indirizzo_collegamento_partenza__c = inputvalues[11];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo destinazione errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo destinazione obbligatorio.';
                }
                //Fine colonna 11
                //Colonna 12 Civico destinazione
                if(inputvalues[12] != null && String.isNotBlank(inputvalues[12]) ){
                    if(inputvalues[12].length() <= 255){
                        c.PO_Civico_partenza__c = inputvalues[12];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico destinazione errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico destinazione obbligatorio.';
                }
                //Fine colonna 12
                //Colonna 13 Nota Sito destinazione
                if(inputvalues[13] != null && String.isNotBlank(inputvalues[13]) ){
                    if(inputvalues[13].length() <= 255){
                        c.PO_Nota_sito_partenza__c = inputvalues[13];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito destinazione errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito destinazione obbligatorio.';
                }
                //Fine colonna 13
                //Setto il flag import massivo sul case
                c.isMassive__c = true;
                //Se ci sono stati errori scarto il case, altrimenti lo aggiungo alla lista da inserire
                if(String.isNotBlank(errorString)){
                    filelines[i] = errorString + ',' +filelines[i];
                    junkCases.add(filelines[i]);
                }else{
                    caseToUpload.add(c);
                }
            }
            if(!junkCases.isEmpty()){
                String finalString = '';
                for(String x : junkCases){
                    finalString = finalString + x;
                }
                Blob b = Blob.valueOf(finalString);
                Attachment attach = new Attachment(); //Make an attachment
                    attach.Name = 'Scarti_'+rtName+'_'+System.now()+'.csv';  
                    attach.Body = b;
                    attach.ContentType= 'text/csv'; //Signal what the file's MIME type is
                    attach.ParentID = parentCaseObj.Id;
                insert attach;
                b = null;
                /*PageReference pg = new PageReference('/servlet/servlet.FileDownload?file='+attach.Id);
                return pg;*/
                return 'KO-'+attach.Id;
            }else{
                insert caseToUpload;
                return 'OK-SYNC';
            }
        }catch(Exception e){
            return 'File-Error';
        }
    }

    public static String ReadP2PBase(Blob contentFile, string accId, Case parentCaseObj, String rtName){
        String fileContentStr;
        List<String> filelines = new List<String>();
        List<Case> caseToUpload = new List<Case>();
        List<String> junkCases = new List<String>();

        if(contentFile == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
            return 'KO';
        }else{
            //Convert the uploaded file which is in BLOB format into a string
            fileContentStr = blobToString( contentFile,'ISO-8859-1');
            filelines = fileContentStr.split('\n');
            if(filelines.size() > 50){
                Database.executeBatch(new PO_MassiveImport_Batch(fileContentStr, rtName, parentCaseObj, accId, 1));
                return 'OK-BATCH';
            }else{
                //Done AA - Implementare il metodo di lettura syncrono
                return syncReadP2PBase(parentCaseObj, filelines, rtName, accId);
            }
        }
    }
    private static String syncReadP2PBase(Case parentCaseObj, List<String> filelines, String rtName, String accId){
        List<Case> caseToUpload = new List<Case>();
        List<String> junkCases = new List<String>();
        //Iterate through every line and create a Case record for each row
        try{
            recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
            
            List<OF_ElencoComuniItaliani__c> listComuni = [SELECT id,OF_Comune__c, OF_Ripartizionegeografica__c 
                                                            FROM OF_ElencoComuniItaliani__c
                                                        ];
            Map<String, OF_ElencoComuniItaliani__c> mapComuni = new Map<String, OF_ElencoComuniItaliani__c>();

            for(OF_ElencoComuniItaliani__c tmp : listComuni){
                mapComuni.put(tmp.OF_Comune__c, tmp);
            }
            for (Integer i=1;i<filelines.size();i++){
                String errorString = '';
                List<String> inputvalues = new List<String>();
                inputvalues = filelines[i].split(',');

                Case c = new Case();
                c.RecordTypeId = rt1.id;
                //Lego il collegamento al parentLog
                c.parentid = parentCaseObj.id;
                c.PO_Richiesta_a_fattibilit__c = parentCaseObj.id;
                c.Status = 'Bozza';
                c.accountid = accId;
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
                    if(inputvalues[1].equalsIgnoreCase('Point-to-Point') ){
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
                    if(inputvalues[2].equalsIgnoreCase('1') || inputvalues[2].equalsIgnoreCase('2') ){
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
                    if(inputvalues[3].equalsIgnoreCase('Singola via') ){
                        c.PO_Tipo_percorso__c = inputvalues[3];
                    }else{
                        errorString = errorString + 'Valore campo Tipo percorso non ammesso.';
                    }
                }else{
                    errorString = errorString + 'Campo Tipo percorso obbligatorio.';
                }
                //Fine colonna 3
                //Colonna 4 Comune1
                if(inputvalues[4] != null && String.isNotBlank(inputvalues[4]) ){
                    OF_ElencoComuniItaliani__c tmpComune = mapComuni.get(inputvalues[4]);
                    if( tmpComune != null && String.isNotBlank(tmpComune.Id) ){
                        c.PO_Comune2__c = tmpComune.Id;
                        //Vado a vedere l'area geografica ed effettuo l'assegnazione
                        //Done AA Richiamo metodo getAreaGeografica(String areaComune);
                        c.PO_Assegnazione_Area_Geografica__c = getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
                    }else{
                        errorString = errorString + 'Valore campo Comune1 non ammesso';
                    }
                }else{
                    errorString = errorString + 'Campo Comune1 obbligatorio.';
                }
                //Fine colonna 4
                //Colonna 5 Sito1
                if(inputvalues[5] != null && String.isNotBlank(inputvalues[5]) ){
                    if(inputvalues[5].length() <= 50){
                        c.PO_Sito__c = inputvalues[5];
                    }else{
                        errorString = errorString + 'Lunghezza campo Sito1 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Sito1 obbligatorio.';
                }
                //Fine colonna 5
                //Colonna 6 Indirizzo1
                if(inputvalues[6] != null && String.isNotBlank(inputvalues[6]) ){
                    if(inputvalues[6].length() <= 50){
                        c.PO_Indirizzo_collegamento__c = inputvalues[6];
                    }else{
                        errorString = errorString + 'Lunghezza campo Indirizzo1 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Indirizzo1 obbligatorio.';
                }
                //Fine colonna 6
                //Colonna 7 Civico1
                if(inputvalues[7] != null && String.isNotBlank(inputvalues[7]) ){
                    if(inputvalues[7].length() <= 50){
                        c.PO_Civico__c = inputvalues[7];
                    }else{
                        errorString = errorString + 'Lunghezza campo Civico1 errata(max 50)';
                    }
                }else{
                    errorString = errorString + 'Campo Civico1 obbligatorio.';
                }
                //Fine colonna 7
                //Colonna 8 Nota Sito1
                if(inputvalues[8] != null && String.isNotBlank(inputvalues[8]) ){
                    if(inputvalues[8].length() <= 255){
                        c.PO_Nota_sito__c = inputvalues[8];
                    }else{
                        errorString = errorString + 'Lunghezza campo Nota Sito1 errata(max 255)';
                    }
                }else{
                    errorString = errorString + 'Campo Nota Sito1 obbligatorio.';
                }
                //Fine colonna 8
                //Setto il flag import massivo sul case
                c.isMassive__c = true;
                //Se ci sono stati errori scarto il case, altrimenti lo aggiungo alla lista da inserire
                if(String.isNotBlank(errorString)){
                    filelines[i] = errorString + ',' +filelines[i];
                    junkCases.add(filelines[i]);
                }else{
                    caseToUpload.add(c);
                }
            }
            if(!junkCases.isEmpty()){
                String finalString = '';
                for(String x : junkCases){
                    finalString = finalString + x;
                }
                Blob b = Blob.valueOf(finalString);
                Attachment attach = new Attachment(); //Make an attachment
                    attach.Name = 'Scarti_'+rtName+'_'+System.now()+'.csv';  
                    attach.Body = b;
                    attach.ContentType= 'text/csv'; //Signal what the file's MIME type is
                    attach.ParentID = parentCaseObj.Id;
                insert attach;
                b = null;
                /*PageReference pg = new PageReference('/servlet/servlet.FileDownload?file='+attach.Id);
                return pg;*/
                return 'KO-'+attach.Id;
            }else{
                insert caseToUpload;
                return 'OK-SYNC';
            }
        }catch(Exception e){
            return 'File-Error';
        }
    }

    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }
    public static String getAreaGeografica(String areaComune){
        if(areaComune != null && areaComune.equalsIgnoreCase('Nord-est')){
            return 'Nord Est';
        }else if(areaComune != null && areaComune.equalsIgnoreCase('Nord-ovest')){
            return 'Nord Ovest';
        }else if(areaComune != null && areaComune.equalsIgnoreCase('Centro')){
            return 'Centro';
        }else if(areaComune != null && areaComune.equalsIgnoreCase('Sud')){
            return 'Sud';
        }else if(areaComune != null && areaComune.equalsIgnoreCase('Isole')){
            return 'Isole';
        }else{
            return '';
        }
    }
}