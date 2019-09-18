global class PO_MassiveImport_Batch implements Database.Batchable<String>,Database.Stateful{ 
    global String csvfile;
    global String[] splittedCSV; 
    global String rtName;
    global Case parentCaseObj;
    global String accId;
    global Integer countComuni;
    global List<Case> caseToUpload;
    global List<String> junkCases;
    global Map<String, OF_ElencoComuniItaliani__c> mapComuni;
    
    global PO_MassiveImport_Batch(String csvFileBody, String rtName, Case parentCaseObj, String accId, Integer countComuni){
        this.csvfile = csvFileBody;
        this.rtName = rtName;
        this.parentCaseObj = parentCaseObj;
        this.accId = accId;
        this.countComuni = countComuni;
        this.caseToUpload = new List<Case>();
        this.junkCases = new List<String>();
        List<OF_ElencoComuniItaliani__c> listComuni = [SELECT id,OF_Comune__c, OF_Ripartizionegeografica__c 
                                                       FROM OF_ElencoComuniItaliani__c];
        this.mapComuni = new Map<String, OF_ElencoComuniItaliani__c>();
        
        for(OF_ElencoComuniItaliani__c tmp : listComuni){
            mapComuni.put(tmp.OF_Comune__c, tmp);
        }
        
    }
    
    global Iterable<String> start(Database.BatchableContext BC){
        splittedCSV = csvfile.split('\n'); 
        splittedCSV.remove(0);
        return splittedCSV;
    }
    
    global void execute(Database.BatchableContext BC, String[] scope){  
        try{
            if(countComuni == 3){//Evento temporaneo o fiberlink
                recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
                recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
                
                //TODO AA Controllare il tipo richiesta 
                for (Integer i=0;i<scope.size();i++){
                    String errorString = '';
                    List<String> inputvalues = new List<String>();
                    inputvalues = scope[i].split(',');
                    
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
                            c.PO_Assegnazione_Area_Geografica__c = PO_ImportaCollegamentiMassivo.getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
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
                            c.PO_Assegnazione_Area_Geografica__c = PO_ImportaCollegamentiMassivo.getAreaGeografica(tmpComune2.OF_Ripartizionegeografica__c);
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
                            c.PO_Assegnazione_Area_Geografica__c = PO_ImportaCollegamentiMassivo.getAreaGeografica(tmpComune3.OF_Ripartizionegeografica__c);
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
                        scope[i] = errorString + ',' + scope[i];
                        junkCases.add(scope[i]);
                    }else{
                        caseToUpload.add(c);
                    }
                }
            }else if(countComuni == 2){// 2 comuni fiberlease o iru
                //parentCaseObj = [select id,PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Note_Modifica_Offerta__c,casenumber,status,CreatedDate from case where id=:testcase.id];
                //Iterate through every line and create a Case record for each row
                recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
                recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
                
                //TODO AA Controllare il tipo richiesta
                for (Integer i=0;i<scope.size();i++){
                    String errorString = '';
                    List<String> inputvalues = new List<String>();
                    inputvalues = scope[i].split(',');
                    
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
                    if(rtName.equalsIgnoreCase('fiberlease'))
                    {
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
                    }
                    else if(rtName.equalsIgnoreCase('iru'))
                    {
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
                    if(rtName.equalsIgnoreCase('fiberlease'))
                    {
                        if(inputvalues[2] != null && String.isNotBlank(inputvalues[2]) ){
                            if(inputvalues[2].equalsIgnoreCase('1') || inputvalues[2].equalsIgnoreCase('2') || inputvalues[2].equalsIgnoreCase('4') ){
                                c.PO_Numero_fibre_richieste__c = inputvalues[2];
                            }else{
                                errorString = errorString + 'Valore campo Numero fibre richieste non ammesso.';
                            }
                        }else{
                            errorString = errorString + 'Campo Numero fibre richieste obbligatorio.';
                        }
                    }
                    else if(rtName.equalsIgnoreCase('iru'))
                    {
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
                    if(rtName.equalsIgnoreCase('fiberlease'))
                    {
                        if(inputvalues[3] != null && String.isNotBlank(inputvalues[3]) ){
                            if(inputvalues[3].equalsIgnoreCase('Singola via') || inputvalues[3].equalsIgnoreCase('Doppia via diversificata') ){
                                c.PO_Tipo_percorso__c = inputvalues[3];
                            }else{
                                errorString = errorString + 'Valore campo Tipo percorso non ammesso.';
                            }
                        }else{
                            errorString = errorString + 'Campo Tipo percorso obbligatorio.';
                        }
                    }
                    else if(rtName.equalsIgnoreCase('iru'))
                    {
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
                            c.PO_Assegnazione_Area_Geografica__c = PO_ImportaCollegamentiMassivo.getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
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
                            c.PO_Assegnazione_Area_Geografica__c = PO_ImportaCollegamentiMassivo.getAreaGeografica(tmpComune2.OF_Ripartizionegeografica__c);
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
                        scope[i] = errorString + ',' +scope[i];
                        junkCases.add(scope[i]);
                    }else{
                        caseToUpload.add(c);
                    }
                }
            }else{//1 COmune, p2pbase
                recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
            
                List<OF_ElencoComuniItaliani__c> listComuni = [SELECT id,OF_Comune__c, OF_Ripartizionegeografica__c 
                                                                FROM OF_ElencoComuniItaliani__c
                                                            ];
                Map<String, OF_ElencoComuniItaliani__c> mapComuni = new Map<String, OF_ElencoComuniItaliani__c>();

                for(OF_ElencoComuniItaliani__c tmp : listComuni){
                    mapComuni.put(tmp.OF_Comune__c, tmp);
                }
                for (Integer i=0;i<scope.size();i++){
                    String errorString = '';
                    List<String> inputvalues = new List<String>();
                    inputvalues = scope[i].split(',');

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
                            c.PO_Assegnazione_Area_Geografica__c = PO_ImportaCollegamentiMassivo.getAreaGeografica(tmpComune.OF_Ripartizionegeografica__c);
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
                        scope[i] = errorString + ',' +scope[i];
                        junkCases.add(scope[i]);
                    }else{
                        caseToUpload.add(c);
                    }
                }
            }
        }catch(Exception e){
            String userEmail = UserInfo.getUserEmail();
            if(userEmail != null && String.isNotBlank(userEmail)){
                String subject = 'File inserito non valido!';
                String textBody = 'Il file inserito per l\'import massivo non è valido.';
                List<String> toAddresses = new List<string> {userEmail};
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject(subject);
                email.setToAddresses(toAddresses);
                email.setPlainTextBody(textBody);
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            }
            System.abortJob(bc.getJobId());
        }
    }  
    
    global void finish(Database.BatchableContext BC){
        String userEmail = UserInfo.getUserEmail();
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
            if(userEmail != null && String.isNotBlank(userEmail)){
                String subject = 'File records discarded massive import';
                String textBody = 'Ciao, in allegato il file avente gli scarti dell\'import massivo.';
                List<String> toAddresses = new List<string> {userEmail};
                Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
                    csvAttc.setFileName(attach.Name);
                    csvAttc.setBody(attach.Body);
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setSubject(subject);
                    email.setToAddresses(toAddresses);
                    email.setPlainTextBody(textBody);
                    email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            }
            //return 'KO-'+attach.Id;
        }else{
            System.debug('****** AA - Sto inserendo i casi ');
            insert caseToUpload;
            if(userEmail != null && String.isNotBlank(userEmail)){
                String subject = 'Success import massivo';
                String textBody = 'Ciao, l\'import dei collegamenti del case numero ' + parentCaseObj.CaseNumber + ' e\' stato completato.';
                List<String> toAddresses = new List<string> {userEmail};
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject(subject);
                email.setToAddresses(toAddresses);
                email.setPlainTextBody(textBody);
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            }
            //return 'OK';
        }
    }
}