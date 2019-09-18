public class PO_P2PAtt_RegistrationCntrl {
    public EOF_EAI_Service_Log__c childLog{get;set;}
    public EOF_EAI_Service_Log__c parentLog{get;set;}
    public Boolean parentLogExists{get;set;}
    public Boolean attachmentExists{get;set;}
    public string recordOfferta{get;set;}
    public string fileName{get;set;}
    public blob filebody{get;set;}
    public case childCase{get;set;}
    public boolean viewError{get;set;}
    public boolean viewProfilo{get;set;}
    public string profiloCommerciale{get;set;}
    public string verifyProfilo{get;set;}
    Map<String,Id> rtMap{get;set;}
    public String tipoColl{get;set;}
    public List<SelectOption> opt{get; set;}
    public String optScelta{get; set;}
    public List<String> tipiCollegamento {get; set;}
    public String apageCkey{get;set;}
    public ApexPages.StandardSetController stdCntrlr {get; set;}
    public OF_ElencoComuniItaliani__c OF_ElencoComuniItalianiobj{get;set;}
    @TestVisible public List<addAdressClass> listValueOfTextBox { get;set;} //EC 2018 - 07 - 26 PO_P2PAttiva_OverviewRequest.vfp
    public String urlPage{get;set;}
    public String NomeProgetto{get;set;}
    public String tipoPercorso{get;set;}
    public List<String> uploadedFileNames{get;set;}    
	public String idVLAN  {get;set;}
    
    public boolean vLanNoMax {get;set;} // EC 2018 - 09 - 18
    public List<EOF_EAI_Service_Log__c> listNephewVLAN{get;set;} // EC 2018 - 09 - 18
    public Boolean showVLAN{get;set;} //EC 2018 - 09 - 18
    public Static String urlTotPass{get;set;} //EC 2018 - 09 - 18	//=sostituito con  apageCkey
    
    //ApexPages.StandardSetController controller	//stdCntrlr=controller;
    public PO_P2PAtt_RegistrationCntrl(){
        
        showVLAN = false; //EC 2018 - 09 - 18	
        uploadedFileNames = new List<String>();
        apageCkey = ApexPages.CurrentPage().getUrl();
        scegliTipoCollegamento();
        system.debug('@@@@@@@@@@EC Url: ' + apageCkey);
        
        List<recordtype> rtList=[select Id,developerName from recordtype]; 
        rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            rtMap.put(rt.developerName, rt.Id); 
        } 
        
        recordOfferta = 'P2P Attiva';
        if (ApexPages.currentPage().getParameters().get('parentId') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('parentId')) ){// esiste il parentLog quindi lo recupero
            parentLogExists = true;
            parentLog = [SELECT Name,CreatedDate, Id,EOF_Comune__c, EOF_SL_Riferimento__c,OF_SA_VLan_Log__c,OF_SA_USER_VLAN__c, EOF_TIPOLOGIA_APPARATO__c,EOF_TIPOLOGIA_SERVIZIO__c,EOF_Stato_Richiesta__c,
                         EOF_SLA_PREMIUM_ASSURANCE__c, EOF_SLA_DATE__c, OF_SA_Servizi_Aggiuntivi_Log__c,OF_SA_SERVICE_VLAN__c,
                         EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,	EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,
                         EOF_PROFILO__c,EOF_NOTE__c, EOF_NOTE_CLIENTE__c, Nome_del_KIT__c,EOF_ID_Risorsa__c,PO_PP_ID_RichiestaVLAN__c, 
                         EOF_INDIRIZZO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,
                         EOF_Data_Provisioning_Servizio__c,OF_SA_CUSTOMER_VLAN__c,EOF_COLLEGAMENTO_P2P__c,PO_Nome_Progetto__c, 
                         ownerId 
                         FROM EOF_EAI_Service_Log__c 
                         WHERE Id = :ApexPages.currentPage().getParameters().get('parentId')];
        }else{//non esiste il parentLog
            parentLogExists = false;
            parentLog = new EOF_EAI_Service_Log__c();
        }
        if (ApexPages.currentPage().getParameters().get('cLogId') != null && String.isNotBlank(ApexPages.currentPage().getParameters().get('cLogId')) ){
            
            
            
            //EC start 2018 - 09 - 18
            String childLogId = ApexPages.currentPage().getParameters().get('cLogId');
            if ( childLogId != null && String.isNotBlank(childLogId)){
                childLog = [SELECT Id, EOF_Codice_Ordine_OLO__c, Name, PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c, EOF_SL_Riferimento__c,
                            PO_Prime_Contractor__c, PO_Numero_fibre_richieste__c, PO_Sito__c, PO_Civico__c, PO_Nota_sito__c, CreatedDate, EOF_SL_Riferimento__r.EOF_Codice_Ordine_OLO__c,
                            PO_Tipo_di_collegamento__c, EOF_PROFILO__c,OF_Id_Comune__c
                            
                            FROM EOF_EAI_Service_Log__c
                            WHERE Id = :childLogId];
                listNephewVLAN = [SELECT Id, RecordType.DeveloperName, OF_SA_KIT_CONSEGNA_VLAN__c, OF_SA_SERVICE_VLAN__c, OF_SA_CUSTOMER_VLAN__c, OF_SA_INFORMAZIONI_VLAN__c, 
                                  OF_SA_USER_VLAN__c, OF_SA_PROFILO_VLAN__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c
                                  FROM EOF_EAI_Service_Log__c
                                  WHERE EOF_SL_Riferimento__c = :childLogId];
                if (listNephewVLAN != null && listNephewVLAN.size() > 0){
                    showVLAN = true;
                    
                    
                }
                vLanNoMax=listNephewVLAN.size() < 3?true:false;
                if(!String.isBlank(childLog.OF_Id_Comune__c)){
	            	OF_ElencoComuniItaliani__c eci =[SELECT OF_Comune__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c WHERE Id = :childLog.OF_Id_Comune__c];
	            	searchTerm=eci.OF_Comune__c+' '+eci.OF_Regione__c;
	            }
            }
        }
        else{
            childLog = new EOF_EAI_Service_Log__c();
            tipoPercorso = childLog.PO_Tipo_percorso__c;
        }
        
        //EC end 2018 - 09 - 18
        
    }
   
    public void scegliTipoCollegamento(){
        apageCkey = ApexPages.CurrentPage().getUrl();
        system.debug('nel metodo scegliTipoCollegamento la stringa apageCkey è così popolata: ' + apageCkey);
        tipiCollegamento = new List<String>();    
        opt= new List<SelectOption>();
        if(apageCkey.contains('/PO_P2PAttiva')){
            opt.add(new SelectOption('Point-to-Point','Point-to-Point'));                
        }
        else{
            opt.add(new SelectOption('Backhauling','Backhauling'));
            opt.add(new SelectOption('BTS','BTS'));
            opt.add(new SelectOption('Point-to-Point','Point-to-Point'));
            opt.add(new SelectOption('Housing','Housing'));
            opt.add(new SelectOption('Anello','Anello'));
            opt.add(new SelectOption('BACKBONE','BACKBONE'));
            opt.add(new SelectOption('P2P - Cliente','P2P - Cliente'));
            opt.add(new SelectOption('Dark Fiber','Dark Fiber'));
            opt.add(new SelectOption('SDH','SDH'));
            opt.add(new SelectOption('DWDM','DWDM'));
            opt.add(new SelectOption('IP','IP'));
            opt.add(new SelectOption('Layer 2','Layer 2'));
            opt.add(new SelectOption('NGN','NGN'));
            opt.add(new SelectOption('MSAN','MSAN'));
            opt.add(new SelectOption('None','None'));
        }
        
        listvalueOfTextBox = new List<addAdressClass>();          //EC 2018 - 07 - 26 PO_P2PAttiva_OverviewRequest.vfp
    }
    
    /*EC 2018 - 08 - 31 metodo per dipendenza tra tipo percorso e Numero Fibre Richieste. 
singola via  Numero fibre 1 e 2

doppia via 		//		1,2 e 2+2		*/
    
    public List<SelectOption> getNumeroFibre(String tipoPercorso){
        List<SelectOption> numerofibreoptions = new List<SelectOption>();
        
        if(tipoPercorso=='Singola Via'){
            numerofibreoptions.add(new SelectOption('1','1'));
            numerofibreoptions.add(new SelectOption('2','2'));
        }
        else if(tipoPercorso=='Doppia Via'){
            numerofibreoptions.add(new SelectOption('1','1'));
            numerofibreoptions.add(new SelectOption('2','2')); 
            numerofibreoptions.add(new SelectOption('2+2','2+2')); 
        }
        return numerofibreoptions; 
    }
    //end EC 2018 - 08 - 31
    
    public PageReference upload() {
        
        attachmentExists = false;
        try {
            //Check sulla dimensione del file
            if(fileBody == null){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Select a file'));
                return null; 
            }else if(fileBody.size()>6291500){
                fileBody = null;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'File size must be <= 6MB'));
                return null;
            }else{//Se la dimensione è <= 6MB procedo
                if(childLog.Id == null || String.isBlank(childLog.Id)){
                    insert childLog;
                }
                attachment a = new attachment();
                a.OwnerId = UserInfo.getUserId();
                a.ParentId = childLog.id; // the record the file is attached to
                a.IsPrivate = true;
                a.name = fileName;
                a.body = fileBody;
                fileBody = null;
                insert a;
                attachmentExists = true;
                uploadedFileNames.add(fileName);
            }
        }catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            return null;
        } 
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        //return new pagereference ('/apex/OF_ChildCase?id='+ChildCase.id);
        return null;
        
    }
    
    public Pagereference SaveParentChildLogInfo(){
        //TODO AA
        //Salvare il parentLog, con le info contenute nella prima pagina (Inserimento richiesta Es. Nome progetto, tipologia ecc)
        //TODO 2 AA
        //Salvare il childLog, con le info contenute nella pagina di creazione del collegamento
        //TODO 3 AA 
        //Aggiungere l'allegato al child log if(attachmentExists)
        try{
            urlPage= ApexPages.CurrentPage().getUrl();
            //Recupero il campo NomeProgetto dall'url
            NomeProgetto = Apexpages.currentPage().getParameters().get('Nome');
            //Recupero le info sull'utente loggato
            User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
            //Vado a verificare se esiste già il parentLog, altrimenti lo inserisco
            /*if(String.isBlank(parentLog.Id)){//Non è stato ancora inserito
parentLog.RecordTypeId=rtMap.get('PO_P2PAttiva_Request');
parentLog.EOF_Tipo_Comunicazione_String__c = 'Ordine di Attivazione';
parentLog.EOF_Stato_Richiesta__c='Bozza Portale';
parentLog.EOF_STATO_ORDINE__c ='Bozza Portale';
parentLog.EOF_Codice_Operatore__c=attuale.Account.EOF_Codice_Operatore__c;
parentLog.PO_Nome_Progetto__c=NomeProgetto;
parentLog.PO_Offerta__c = recordOfferta;
//Faccio insert e subito dopo update, perchè al posto di LOG - inserisco il codice operatore OLO(Necessario?)
insert parentLog;
parentLog.EOF_Codice_Ordine_OLO__c= parentLog.Name.replace('LOG-',parentLog.EOF_Codice_Operatore__c+'_');
update parentLog;
}*/
            //Dopo aver sicuramente il log padre, vado a creare il childLog (Log di bozza del collegamento inserito)
            childLog.RecordTypeId = rtMap.get('P2P_Attiva_Collegamento');
            childLog.PO_Offerta__c = recordOfferta;
            childLog.PO_Tipo_di_collegamento__c = optScelta;
            childLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
            childLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
            childLog.EOF_Codice_Operatore__c = attuale.Account.EOF_Codice_Operatore__c;
            childLog.EOF_Comune__c =  [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
            childLog.OF_Id_Comune__c = selectedIdComune;
            childLog.EOF_SL_Riferimento__c = parentLog.Id;
            childLog.PO_Nome_Progetto__c = NomeProgetto;
            upsert childLog;
            childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
            update childLog;
            //Vado al riepilogo della richiesta
            PageReference pg = new PageReference ('/PO_P2PAtt_RiepReq_ElCo');
            pg.getParameters().put('parentId', parentLog.id); 
            pg.getParameters().put('cLogId', childLog.id); 
            pg.setRedirect(true);
            return pg;
        }catch(Exception e){
            System.debug('ERRORE IN PO_P2PAtt_RegistrationCntrl ' + e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
    }
    
    /*
EC 2018 - 09 - 18 start
metodo che salva le info del childlog e dirotta verso l'inserimento VLAN
copiato il metodo SaveParentChildLogInfo
*/
    
    public Pagereference SaveParentChildLogInfoAndRedirect(){
        //TODO AA
        //Salvare il parentLog, con le info contenute nella prima pagina (Inserimento richiesta Es. Nome progetto, tipologia ecc)
        //TODO 2 AA
        //Salvare il childLog, con le info contenute nella pagina di creazione del collegamento
        //TODO 3 AA 
        //Aggiungere l'allegato al child log if(attachmentExists)
        try{
            urlPage= ApexPages.CurrentPage().getUrl();
            //Recupero il campo NomeProgetto dall'url
            NomeProgetto = Apexpages.currentPage().getParameters().get('Nome');
            //Recupero le info sull'utente loggato
            User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
            
            //Dopo aver sicuramente il log padre, vado a creare il childLog (Log di bozza del collegamento inserito)
            childLog.RecordTypeId = rtMap.get('P2P_Attiva_Collegamento');
            childLog.PO_Offerta__c = recordOfferta;
            childLog.PO_Tipo_di_collegamento__c = optScelta;
            childLog.EOF_Stato_Richiesta__c = 'Bozza Portale';
            childLog.EOF_STATO_ORDINE__c = 'Bozza Portale';
            childLog.EOF_Codice_Operatore__c = attuale.Account.EOF_Codice_Operatore__c;
            childLog.EOF_Comune__c =  [SELECT OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE Id = :selectedIdComune].OF_Comune__c;
            childLog.OF_Id_Comune__c = selectedIdComune;
            childLog.EOF_SL_Riferimento__c = parentLog.Id;
            childLog.PO_Nome_Progetto__c = NomeProgetto;
            upsert childLog;
            childLog.EOF_Codice_Ordine_OLO__c= [SELECT Id,Name FROM EOF_EAI_Service_Log__c WHERE Id = :childLog.Id].Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
            update childLog;
            
        }catch(Exception e){
            System.debug('ERRORE IN PO_P2PAtt_RegistrationCntrl ' + e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Servizio momentaneamente non disponibile'));
            return null;
        }
        PageReference pg = new PageReference ('/PO_P2PAttiva_InserisciVLAN');
        //pg.getParameters().put('urlPrec',apageCkey);
        pg.getParameters().put('from','ReqPg');
        pg.getParameters().put('parentId', parentLog.id);
        pg.getParameters().put('cLogId', childLog.id);
        pg.getParameters().put('Mode','ins');
        pg.setRedirect(true);
        
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@EC pageReference è ' + pg);
        return pg;
    }
    public PageReference modificaVLAN (){     
        PageReference pg = new PageReference('/PO_P2PAttiva_InserisciVLAN');
        pg.getParameters().put('cLogId', childLog.Id);
        pg.getParameters().put('IdVLAN', idVLAN);
        pg.getParameters().put('Mode','mod');
        return pg;
    }

    public PageReference cessaVLAN (){
        EOF_EAI_Service_Log__c sl = [select id from EOF_EAI_Service_Log__c where id=:idVLAN];
        delete sl;
        PageReference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('cLogId', childLog.EOF_SL_Riferimento__c);
        return pg;    
    }
    //EC end 2018 - 09 - 18
    
    public PageReference runSearchProfilo() {
        
        String TextProfilo = Apexpages.currentPage().getParameters().get('TextProfilo');  
        OF_CodificaProfiloListini__c objListino = OF_CodificaProfiloListini__c.getValues(TextProfilo);
        If(objListino != null && objListino.IsPortalValid__c==true){
            profiloCommerciale=(string)objListino.OF_ProfiloCommerciale__c; 
        }else{
            profiloCommerciale= 'N/A';  		
        }
        //profiloCommerciale ='TEST 2 TEST';
        viewError=false;
        viewProfilo=true;
        return null;
    }
    
    public Pagereference deleteChildAlone(){
        if(childLog != null && String.isNotBlank(childLog.Id)){
            if (attachmentExists){
                delete [SELECT Id FROM Attachment WHERE ParentId = :childLog.Id];
            }
            delete childLog;
        }
        pagereference pg = new pagereference ('/PO_P2PAtt_RiepReq_ElCo');
        pg.getParameters().put('parentId', parentLog.Id);
        pg.setRedirect(true);
        return pg;
    }
    
    public String searchTerm {get; set;}
    public String selectedIdComune {get; set;}
    // JS Remoting action called when searching
    @RemoteAction
    public static List<OF_ElencoComuniItaliani__c> searchComune(String searchTerm) {
        // System.debug('Comune Name is: '+searchTerm );
        List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm) + '%\'  order by OF_Comune__c ASC ' );
        // System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
        return AreaGeograficaJunction;
        
    }
    
    @TestVisible public class addAdressClass{		//EC 2018 - 07 - 26 PO_P2PAttiva_OverviewRequest.vfp
        public string ContactNamelable{get;set;}
        public string ContactNameValue{get;set;}
        public string ContactNamelable1{get;set;}
        public string ContactNameValue1{get;set;}
        
        public addAdressClass(String ContactNamelable,String ContactNamelable1){
            this.ContactNamelable = ContactNamelable;
            this.ContactNamelable1 = ContactNamelable1;
        }
    }
    
    /*
EC 2018 - 09 - 18
metodo PageReference di insert vlan copiato da PO_P2PAttiva_EditLogInfoCntrl,
rimanda alla pagina di inserimento VLAN PO_P2PAttiva_InserisciVLAN

*/
    
    public PageReference insertNewVLAN(){
        PageReference pg = new PageReference('/PO_P2PAttiva_InserisciVLAN');
        pg.getParameters().put('cLogId', childLog.Id);
        pg.getParameters().put('Mode','ins');
        return pg;
    }
    
    
    ///////////////////////////////////////////////
    /*if(String.isBlank(childLog.id)){

User attuale=[select Id,Account.EOF_Codice_Operatore__c from user where Id=:userinfo.getUserId()];
system.debug('lo user è ' + attuale);
childLog.RecordTypeId=rtMap.get('PO_P2PAttiva_Request');
childLog.PO_Tipo_di_collegamento__c=optScelta;
system.debug('PO_Tipo_di_collegamento è valorizzato con optScelta, che è ' + optScelta);
childLog.EOF_Stato_Richiesta__c='Bozza Portale';
childLog.EOF_STATO_ORDINE__c ='Bozza Portale';
childLog.EOF_Codice_Operatore__c=attuale.Account.EOF_Codice_Operatore__c;
childLog.PO_Nome_Progetto__c=NomeProgetto;
system.debug('NomeProgetto è ' + NomeProgetto);
insert childLog;
system.debug('il childLog appena inserito è ' + childLog);
// String codOrdOLO=childLog.Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
// childLog.EOF_Codice_Ordine_OLO__c=codOrdOLO;
childLog =[select id, RecordTypeId,EOF_Tipo_Comunicazione_String__c, PO_SA_Data_Inserimento_Ordine__c, CreatedDate, PO_Tipo_di_collegamento__c, EOF_Stato_Richiesta__c, EOF_Codice_Operatore__c, Name from EOF_EAI_Service_Log__c where id=:childLog.Id];
childLog.EOF_Codice_Ordine_OLO__c= childLog.Name.replace('LOG-',childLog.EOF_Codice_Operatore__c+'_');
String s1='Bozza Portale';
if(s1.contains(childLog.EOF_Codice_Ordine_OLO__c)){
childLog.EOF_Stato_Richiesta__c=s1;
}
childLog.PO_SA_Data_Inserimento_Ordine__c=datetime.now();
if(urlPage.contains('P2PattAttivazione')){
childLog.EOF_Tipo_Comunicazione_String__c='Ordine di Attivazione';
}
else if(urlPage.contains('P2PattCessazione')){
childLog.EOF_Tipo_Comunicazione_String__c='Ordine di Cessazione';    
}
update childLog;
system.debug('dopo l\'update nella creazione childLog vale ' + childLog);
system.debug('tipo comunicazione è stato valorizzato in uno degli if e vale:' + childLog.EOF_Tipo_Comunicazione_String__c);

}else{
update childLog;
system.debug('dopo l\'update childLog vale ' + childLog);
}
//pagereference pg = new pagereference ('/apex/PO_P2PAttiva_OverviewRequest?id='+childLog.id);
PageReference pg = new PageReference ('/PO_P2PAtt_RiepReq_ElCo');
pg.getParameters().put('id', childLog.id); 
System.debug('al momento del salvataggio viene richiamato il metodo SaveParentChildLogInfo che oltre a fare l\'insert o l\'update del childLog dirotta verso questa pagina: ' +pg);
pg.setRedirect(true);
return pg;*/
    
    /*
system.debug('abbiamo appena chiamato il metodo SaveParentChildLogInfo');
//To do Crea metodo con searchLogBoolean al posto di searchCaseBoolean 
searchLogBoolean=false;
stageName=false;
parentfile=false;
Ordine = false;
newAtt.clear();
attxlxs.clear();
attlst.clear();
string parentid = '';
String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
system.debug('testParentIdSave'+testParentIdSave);
//  try{
system.debug('siamo nel try del metodo SaveParentChildLogInfo, di seguito il comune');
OF_ElencoComuniItaliani__c ag = new OF_ElencoComuniItaliani__c();
OF_ElencoComuniItaliani__c ag1 = new OF_ElencoComuniItaliani__c();
OF_ElencoComuniItaliani__c ag2 = new OF_ElencoComuniItaliani__c();
system.debug('selectedIdComune====='+selectedIdComune);
if(selectedIdComune != null && selectedIdComune != '' &&  selectedIdComune != 'Inserisci qui il nome comune' )
{
ag = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune limit 1];
System.debug('Comune 1 Name--->'+ag.OF_Comune__c);
}
if(selectedIdComune1 != null && selectedIdComune1 != '' &&  selectedIdComune1 != 'Inserisci qui il nome comune' )
{
ag1 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune1 limit 1];
System.debug('Comune 2 Name--->'+ag1.OF_Comune__c);
}

if(selectedIdComune2 != null && selectedIdComune2 != '' &&  selectedIdComune2 != 'Inserisci qui il nome comune' )
{
ag2 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune2 limit 1];
System.debug('Comune 3 Name--->'+ag2.OF_Comune__c);
}
if(ag != null)
system.debug('nell\'if del comune diverso da null');    
{
if(String.isBlank(P2PAttivaLog.EOF_Comune__c))
{
//       try
//      {
P2PAttivaLog.EOF_Comune__c = ag.id;

////    }
//    catch(exception e)
//  {
//        system.debug('error==='+e.getStackTraceString());
//     }
}
}

string logId = '';

if(P2PAttivaLogPadre != null && P2PAttivaLogPadre.id != null)
{
system.debug('nell\'if del P2PAttivaLogPadre diverso da null');  
// parentid  = P2PAttivaLogPadre.id;
parentid  = testParentIdSave;
system.debug('Saving P2PAttivaLogPadre'+P2PAttivaLogPadre.id);

}
if(parentlogobj != null && parentlogobj.id != null)
{
parentid  = parentlogobj.id;
}
if(childLog.id != null)
{
system.debug('nell\'if del childLogID diverso da null'); 
update childLog;

System.debug('Commune Name--->'+ childLog.EOF_Comune__c);
logId = childLog.id;

parentid  = childLog.EOF_SL_Riferimento__c;
system.debug('nell\'if del childLogID diverso da null la string parentid vale: ' + parentid);
}
if(childLogObj.id != null)
{
system.debug('nell\'if del childLogObj.ID diverso da null assegnamo il valore del comune al campo childLogObj.EOF_Comune__c che vale:  ' + childLogObj.EOF_Comune__c );
//if(childLogObj.PO_Comune2__c == null)
childLogObj.EOF_Comune__c =selectedIdComune;
if( selectedIdComune1 != ''){
if(selectedIdComune1.contains('a0D')){
childLogObj.EOF_Comune__c =selectedIdComune1;
}
}
if( selectedIdComune2 != ''){
if(selectedIdComune1.contains('a0D')){
childLogObj.EOF_Comune__c =selectedIdComune2;
}
}
update childLogObj;
logId = childLogObj.id;
parentid  = childLogObj.EOF_SL_Riferimento__c;
}

displayLog = [select Name,CreatedDate, Id,EOF_Comune__c, EOF_SL_Riferimento__c,OF_SA_VLan_Log__c,OF_SA_USER_VLAN__c, EOF_TIPOLOGIA_APPARATO__c,EOF_TIPOLOGIA_SERVIZIO__c,EOF_Stato_Richiesta__c,
EOF_SLA_PREMIUM_ASSURANCE__c, EOF_SLA_DATE__c, OF_SA_Servizi_Aggiuntivi_Log__c,OF_SA_SERVICE_VLAN__c,
EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,	EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,
EOF_PROFILO__c,EOF_NOTE__c, EOF_NOTE_CLIENTE__c, Nome_del_KIT__c,EOF_ID_Risorsa__c,PO_PP_ID_RichiestaVLAN__c, EOF_INDIRIZZO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_Data_Provisioning_Servizio__c,OF_SA_CUSTOMER_VLAN__c,EOF_COLLEGAMENTO_P2P__c,PO_Nome_Progetto__c, ownerId from EOF_EAI_Service_Log__c where id =:logId];
system.debug('Updated childLog--->'+childLog);
comune = displayLog.EOF_Comune__c;
System.debug('displayLog :' + displayLog);

//}

parentlogobj = [select Name,CreatedDate, Id,EOF_Comune__c, EOF_SL_Riferimento__c,OF_SA_VLan_Log__c,OF_SA_USER_VLAN__c, EOF_TIPOLOGIA_APPARATO__c,EOF_TIPOLOGIA_SERVIZIO__c,EOF_Stato_Richiesta__c,
EOF_SLA_PREMIUM_ASSURANCE__c, EOF_SLA_DATE__c, OF_SA_Servizi_Aggiuntivi_Log__c,OF_SA_SERVICE_VLAN__c,
EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,	EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,
EOF_PROFILO__c,EOF_NOTE__c, EOF_NOTE_CLIENTE__c, Nome_del_KIT__c,EOF_ID_Risorsa__c,PO_PP_ID_RichiestaVLAN__c, EOF_INDIRIZZO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_Data_Provisioning_Servizio__c,OF_SA_CUSTOMER_VLAN__c,EOF_COLLEGAMENTO_P2P__c,PO_Nome_Progetto__c, ownerId from EOF_EAI_Service_Log__c where Id=:parentid Limit 1];
System.debug('parentlogobj :' + parentlogobj);

list<EOF_EAI_Service_Log__c> childLogList = [select Name,CreatedDate, Id,EOF_Comune__c, EOF_SL_Riferimento__c,OF_SA_VLan_Log__c,OF_SA_USER_VLAN__c, EOF_TIPOLOGIA_APPARATO__c,EOF_TIPOLOGIA_SERVIZIO__c,EOF_Stato_Richiesta__c,
EOF_SLA_PREMIUM_ASSURANCE__c, EOF_SLA_DATE__c, OF_SA_Servizi_Aggiuntivi_Log__c,OF_SA_SERVICE_VLAN__c,
EOF_RECAPITO_TELEFONICO_CLIENTE__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,	EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,OF_SA_PROFILO_VLAN__c,OF_SA_PROFILO_VLAN_PL__c,
EOF_PROFILO__c,EOF_NOTE__c, EOF_NOTE_CLIENTE__c, Nome_del_KIT__c,EOF_ID_Risorsa__c,PO_PP_ID_RichiestaVLAN__c, EOF_INDIRIZZO__c,EOF_EMAIL_REFERENTE_TECNICO_OLO__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_Data_Provisioning_Servizio__c,OF_SA_CUSTOMER_VLAN__c,EOF_COLLEGAMENTO_P2P__c,PO_Nome_Progetto__c, ownerId from EOF_EAI_Service_Log__c where EOF_SL_Riferimento__c=:parentlogobj.id
order by name ASC];
System.debug('la lista childLogList conta' + childLogList.size() + ' childLog è così popolata :' + childLogList);

parentLog = parentlogobj; //as parentcase
if(parentlogobj.EOF_Stato_Richiesta__c=='Bozza')
{

caseobjbuttoncheck=true; //as  caseobjbuttoncheck

}


childLogs = childLogList;
// childLogs.sort();
//  return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentlogobj.id);
//  return new pagereference ('/apex/PO_P2PAttiva_OverviewRequest?id='+parentlogobj.id);
*/
    
    
    
    /*     

public String transformDate(String dateToFormat)
{
if (!dateToFormat.equals(''))
{
string formattedDate;
List<string> holder = dateToFormat.split('/');
// handles alternate ('-') date divider
if (holder.size() == 1) { holder = dateToFormat.split('-'); }
// allows date parts to be entered without leading '0'
if (holder[0].length() == 1) { holder[0] = '0' + holder[0]; }
if (holder[1].length() == 1) { holder[1] = '0' + holder[1]; }
formattedDate = holder[0] + '-' + holder[1] + '-' + holder[2];
return formattedDate;
}
return '';
}


// runs the search with parameters passed via Javascript


//PG - FIX - 3-05 - END


//EC TO DO creare un metodo come searchCases ma per searchLog


//EC -start 2018 - 07 - 05
public pagereference ServizioP2PAttiva(){
pagereference pr = new pagereference('/apex/PO_P2PAttiva_InsertNewRequest');
pr.setRedirect(true);
return pr;
}

public pagereference P2PAttivaList(){
return new pageReference('/PO_P2P_Attivo_DisplayRequest');
}

// END EC 2018-07-05

//PREPROV
public pagereference ServizioKit()
{   
Nome='';
parentCase = new Case();
PrntCaseID='';
system.debug('accId===='+accId);
parentCase.accountid = accId;
parentCase.Status = 'Bozza';
invia = true;
recordtype rt = [select id from recordtype 
where sobjectType ='case' 
and developername='OF_PP_PreProvisioning_KITConsegna'];

parentCase.RecordTypeId = rt.id;
system.debug('show7===='+show7);
system.debug('recordOfferta===='+recordOfferta);
if(show7 == true)
{
//parentCase.PO_Offerta__c = recordOfferta;
parentCase.PO_Offerta__c = 'KIT';
}

insert parentCase;
prntCaseID=parentCase.Id;
system.debug('KitParent===='+PrntCaseID);
pagereference pr = new pagereference('/apex/PO_PP_InserimentoKit?id='+ParentCase.id );
//pr.setRedirect(true);
return pr;
}


public pagereference Fiberlease()
{
system.debug('the value the show2'+show2);
parentCase = new Case();
PrntCaseID='';
parentCase.accountid = accId;
parentCase.Status = 'Bozza';
invia = true;
recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];

parentCase.RecordTypeId = rt.id;
if(show2 == true)
{
parentCase.PO_Offerta__c = 'Fiber Lease';
}

insert parentCase;

prntCaseID=parentCase.Id;
system.debug('the value of parentcase in fiberlease'+parentCase.PO_Offerta__c );

pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id);

return pr;
}
public pagereference Fiberlink()
{
PrntCaseID='';
parentCase = new Case();
parentCase.accountid = accId;
parentCase.Status = 'Bozza';
invia = true;
recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];
parentCase.RecordTypeId = rt.id;
if(show3 == true)
{
parentCase.PO_Offerta__c = 'Fiber Link';
}

insert parentCase;
prntCaseID=parentCase.Id;
system.debug('Fibrelink===='+PrntCaseID);
pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+parentCase.id);
return pr;
}
public pagereference IRU()
{

parentCase = new Case();
parentCase.accountid = accId;
parentCase.Status = 'Bozza';
invia = true;
recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];

parentCase.RecordTypeId = rt.id;
if(show4 == true)
{
parentCase.PO_Offerta__c = 'IRU';
}

insert parentCase;

pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id);
pr.setredirect(false);
return pr;
}
public pagereference MistoFiber()
{

parentCase = new Case();
parentCase.accountid = accId;
parentCase.Status = 'Bozza';
invia = true;
recordtype rt = [select id from recordtype where sobjectType ='case' and developername='PO_Richiesta_a_servizio_a_fattibilit'];

parentCase.RecordTypeId = rt.id;
if(show5 == true)
{
parentCase.PO_Offerta__c = 'Evento Temporaneo';
}

insert parentCase;
System.debug('parentCase'+parentCase);
pagereference pr = new pagereference('/apex/PO_FeasibilityService1?id='+ParentCase.id);
return pr;
}

public pagereference ServizioOpenStream(){
pagereference pr = new pagereference('/apex/PO_OpenStreamService_InsertNewRequest');
pr.setRedirect(true);
return pr;
}

// AS START
public pagereference ServizioTT(){
return new pagereference('/PO_TT_InsertNewRequest');
}

public pagereference TTList(){
return new pageReference('/PO_TT_DisplayRequest');
}

// AS END

// AM START
//Azione='Provisioning'
//FIX PG - 19-04
public pagereference ServizioTP(){

PageReference ref = new pagereference('/PO_TP_InsertNewRequest');
ref.getParameters().put('azione', 'Provisioning');
return ref;
}

//Azione='Provisioning'
public pagereference TPList(){

PageReference ref = new pageReference('/PO_TP_DisplayRequest');
ref.getParameters().put('azione', 'Provisioning');
return ref;
}


// AM END
// AM START

//Azione='Incident'
public pagereference Incident(){

PageReference ref = new pagereference('/PO_TP_InsertNewRequest');
ref.getParameters().put('azione', 'Incident');
return ref;
}

//Azione='Incident'
public pagereference IncidentList(){

PageReference ref = new pageReference('/PO_TP_DisplayRequest');
ref.getParameters().put('azione', 'Incident');
return ref;
}


// AM END
// EC Start saveParentLogNew 2018 - 07 - 24 
public pagereference saveParentLogNew()
{
P2PAttivaLogPadre = new EOF_EAI_Service_Log__c();


recordtype rt = [select id from recordtype where sobjectType ='EOF_EAI_Service_Log__c' and developername='PO_P2PAttiva_Request'];

P2PAttivaLogPadre.RecordTypeId = rt.id;
P2PAttivaLogPadre.EOF_Stato_Richiesta__c = 'Bozza';
//     P2PAttivaLogPadre.Origin = 'Portalino';

insert P2PAttivaLogPadre;
P2PAttLog = [SELECT ID, Name, EOF_Stato_Richiesta__c FROM EOF_EAI_Service_Log__c WHERE ID =: P2PAttivaLogPadre.Id];
System.debug('parentCaseNew'+P2PAttivaLogPadre);

pagereference pgref = new pagereference('/apex/PO_Index');
return pgref;

}

//EC end 2018 - 07 - 24
//
//        
public pagereference saveparentCaseNew()
{
parentCaseNew = new Case();


recordtype rt = [select id from recordtype where sobjectType ='case' and developername='OF_SA_Attivazione'];

parentCaseNew.RecordTypeId = rt.id;
parentCaseNew.Status = 'Bozza';
parentCaseNew.Origin = 'Portalino';

insert parentCaseNew;
openstreamcase = [SELECT ID, Casenumber FROM case WHERE ID =: parentcaseNew.Id];
System.debug('parentCaseNew'+parentCaseNew);

pagereference pgref = new pagereference('/apex/PO_Index');
return pgref;

}
public Attachment attachment
{
get
{
if(attachment==null)
attachment = new Attachment();
return attachment;
}
set;
}

public pagereference childCase()
{
newAtt.clear();
attxlxs.clear();
attlst.clear();
system.debug('recid====='+parentCase);
system.debug('recid====='+parentcaseobj);
Attachment.clear();
string recid = '';
ID rectypeId=[select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
Case testParent=new Case();
//system.debug('parentcase inside childcase method'+parentcase.id);
String testParentId= apexpages.currentpage().getparameters().get('id');
system.debug('ParentChild'+testParentId);
if(TestParentID!= null){
testParent=[select Id,PO_Nome_Progetto__c,ownerId  from Case where id=:testparentID];

}



if(parentCase != null && parentCase.id != null)
{
if(parentCase.PO_Nome_Progetto__c ==''||parentCase.PO_Nome_Progetto__c == null){
parentCase.PO_Nome_Progetto__c =Nome ;
offertEvento = parentCase.PO_Offerta__c;
}
system.debug('inside the childcase condiytion'+parentCase.PO_Nome_Progetto__c);

system.debug('inside the childcase condiytion'+testParentId);
recid =  parentCase.id;
if(parentcase.OwnerId!=rectypeID){
parentCase.OwnerId = UserInfo.getUserId();
update parentCase;
}
}
else if(parentcaseobj != null && parentcaseobj.id != null)
{
recid =  parentcaseobj.id;
offertEvento = parentcaseobj.PO_Offerta__c;
if(parentcaseobj.OwnerId!=rectypeID){
parentcaseobj.OwnerId = UserInfo.getUserId();

update parentcaseobj;
}
}
else if(testcase != null && testcase.id != null)
{
if( testcase.PO_Nome_Progetto__c == ''||  testcase.PO_Nome_Progetto__c == null){
testcase.PO_Nome_Progetto__c =Nome ;

}
recid =  testcase.id;
testcase.OwnerId = UserInfo.getUserId();
update testcase;
Nome = '';
system.debug('testcase'+testcase);
}

if(testParent != null && testParent .id != null)
{
if( testParent .PO_Nome_Progetto__c== ''||testParent .PO_Nome_Progetto__c==null){
testParent .PO_Nome_Progetto__c =Nome ;
offertEvento = testcase.PO_Offerta__c;
}
recid =  testParent .id;
update testParent ;
Nome = '';
system.debug('testParent '+testParent );
}
system.debug('recid====='+recid);
case caseupdate = [select id,casenumber,PO_Offerta__c,PO_Nome_Progetto__c,OwnerId from case where id=:recid];
// caseupdate.PO_Nome_Progetto__c = testCase.PO_Nome_Progetto__c;
// update caseupdate;



recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
recordtype rt4 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
recordtype rt5 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P_Attiva']; // EC add recordType 'PO_Collegamento_P2P_Attiva' 2018 - 07 - 13
// selectedIdComune

case pcase = [select id,PO_Offerta__c,PO_Nome_Progetto__c,ownerId from case where id=:caseupdate.id limit 1];
system.debug('Parent Case--------->'+pcase);
string serviceType = pcase.PO_Offerta__c;
system.debug('serviceType-------->'+serviceType);

//if P2P Attiva ed è ancora una bozza creare un Log, altrimenti quando in 


if(serviceType == 'Fiber Link')
{
if(pcase != null)
{
update pcase;
}
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
ChildCase = new Case();
ChildCase.ParentId = pcase.id;
ChildCase.accountid = accId;
ChildCase.PO_Richiesta_a_fattibilit__c = recid;
ChildCase.RecordTypeId = rt2.id;
ChildCase.Status = 'Bozza';
//ChildCase.Contact.id = usr.Contact.id;
insert childCase;
pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
return pr;

}

if(serviceType == 'Fiber Lease')
{  system.debug('serviceType22-------->'+serviceType);
if(pcase != null)
{
update pcase;
}
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
ChildCase = new Case();
ChildCase.ParentId =  pcase.id;
ChildCase.accountid = accId;
ChildCase.PO_Richiesta_a_fattibilit__c =  recid ;
childCase.RecordTypeId = rt1.id;
ChildCase.Status = 'Bozza';
//ChildCase.Contact.id = usr.Contact.id;
insert childCase;
pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
return pr;


}
if(serviceType == 'P2P Base')
{   system.debug('serviceType33-------->'+serviceType);
if(pcase != null)
{
update pcase;
}
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
ChildCase = new Case();
ChildCase.ParentId = pcase.id;
ChildCase.accountid = accId;
ChildCase.PO_Richiesta_a_fattibilit__c =recid ;
childCase.RecordTypeId = rt3.id;
ChildCase.Status = 'Bozza';
//ChildCase.Contact.id = usr.Contact.id;
insert childCase;
pagereference pr = new pagereference('/apex/PO_P2PBaseNew?parentid='+pcase.id);
return pr;
}
if(serviceType == 'IRU')
{
//update parentCase;
if(pcase != null)
{
update pcase;
}
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
ChildCase = new Case();
ChildCase.ParentId = recid;
ChildCase.accountid = accId;
ChildCase.PO_Richiesta_a_fattibilit__c = recid;
childCase.RecordTypeId = rt4.id;
ChildCase.Status = 'Bozza';

insert childCase;
pagereference pr = new pagereference('/apex/PO_IRU_FiberLease_Child?parentid='+pcase.id);
return pr;
//ChildCase.Contact.id = PO_IRU_FiberLease_Childusr.Contact.id;

}
if(serviceType == 'Evento Temporaneo')
{
//update parentCase;
if(pcase != null)
{
update pcase;
}
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
ChildCase = new Case();
ChildCase.ParentId = recid;
ChildCase.accountid = accId;
ChildCase.PO_Richiesta_a_fattibilit__c = recid;
childCase.RecordTypeId = rt5.id;
ChildCase.Status = 'Bozza';
//ChildCase.Contact.id = usr.Contact.id;
insert childCase;
pagereference pr = new pagereference('/apex/PO_Fiberlink_Evento_ChildCase?parentid='+pcase.id);
return pr;

}

try{
ChildCase.Status = 'Bozza';
insert ChildCase;
}catch(exception e){
system.debug('getMessage error==>'+ e.getMessage() +'getStackTraceString error'+ e.getStackTraceString());

}
system.debug('Service Type--->'+serviceType);
system.debug('ChildCase--->'+ChildCase);
pagereference pr = new pagereference('/apex/OF_ChildCase?parentid='+pcase.id);
return pr;
}
*/
    //EC start SaveParentChildLogInfo 2018 - 07 - 24
    
    /*

//EC end SaveParentChildLogInfo 2018 - 07 - 24
public Pagereference SaveParentChildCaseInfo()
{
P2PAttivaLog = new EOF_EAI_Service_Log__c();	
searchCaseBoolean=false;
searchLogBoolean=false;
stageName=false;
parentfile=false;
Ordine = false;
newAtt.clear();
attxlxs.clear();
attlst.clear();
string parentid = '';
String testParentIdSave= apexpages.currentpage().getparameters().get('parentid');
system.debug('testParentIdSave'+testParentIdSave);
try{
OF_ElencoComuniItaliani__c ag = new OF_ElencoComuniItaliani__c();
OF_ElencoComuniItaliani__c ag1 = new OF_ElencoComuniItaliani__c();
OF_ElencoComuniItaliani__c ag2 = new OF_ElencoComuniItaliani__c();
system.debug('selectedIdComune====='+selectedIdComune);
if(selectedIdComune != null && selectedIdComune != '' &&  selectedIdComune != 'Inserisci qui il nome comune' )
{
ag = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune limit 1];
System.debug('Commune Name--->'+ag.OF_Comune__c);
}
if(selectedIdComune1 != null && selectedIdComune1 != '' &&  selectedIdComune1 != 'Inserisci qui il nome comune' )
{
ag1 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune1 limit 1];
System.debug('Commune Name--->'+ag1.OF_Comune__c);
}

if(selectedIdComune2 != null && selectedIdComune2 != '' &&  selectedIdComune2 != 'Inserisci qui il nome comune' )
{
ag2 = [SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where id =: selectedIdComune2 limit 1];
System.debug('Commune Name--->'+ag2.OF_Comune__c);
}
if(ag != null)
{
if(ChildCase.PO_Comune2__c == null )
{
try
{
ChildCase.PO_Comune2__c = ag.id;
}
catch(exception e)
{
system.debug('error==='+e.getStackTraceString());
}
}
}
if(ag1 != null)
{
if(ChildCase.PO_Comune3__c == null )
{
try
{
ChildCase.PO_Comune3__c = ag1.id;
}
catch(exception e)
{
system.debug('error==='+e.getStackTraceString());
}
}
}

if(ag2 != null)
{
if(ChildCase.PO_Comune4__c== null )
{
try
{
ChildCase.PO_Comune4__c= ag2.id;
System.debug('Commune Name--->'+ ChildCase.PO_Comune4__c);
}
catch(exception e)
{
system.debug('error==='+e.getStackTraceString());
}
}
}
string caseid = '';

if(parentCase != null && parentCase.id != null)
{
// parentid  = parentCase.id;
parentid  = testParentIdSave;
system.debug('Saving ChildCase'+ParentCase.id);

}
if(parentcaseobj != null && parentcaseobj.id != null)
{
parentid  = parentcaseobj.id;
}
if(childCase.id != null)
{
update childCase;
System.debug('Commune Name--->'+ ChildCase.PO_Comune4__c);
caseid = childCase.id;
parentid  = childCase.parentid;
}
if(childCaseObj.id != null)
{
//if(childCaseObj.PO_Comune2__c == null)
childCaseObj.PO_Comune2__c =selectedIdComune;
if( selectedIdComune1 != ''){
if(selectedIdComune1.contains('a0D')){
childCaseObj.PO_Comune3__c =selectedIdComune1;
}
}
if( selectedIdComune2 != ''){
if(selectedIdComune1.contains('a0D')){
childCaseObj.PO_Comune4__c =selectedIdComune2;
}
}
update childCaseObj;
caseid = childCaseObj.id;
parentid  = childCaseObj.parentid;
}

displayCase = [select id, casenumber ,parentid,PO_Comune2__c,PO_Durata_mesi__c,PO_Comune2__r.id,PO_Comune2__r.OF_Comune__c from case where id =:caseid];
system.debug('Updated ChildCase--->'+ChildCase);
comune = displayCase.PO_Comune2__r.OF_Comune__c;

}
catch(exception e){
system.debug('Error Message-->'+e.getStackTraceString());
}

parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c  , Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:parentid Limit 1];

list<Case> childcaseList = [SELECT Case.Parent.casenumber,PO_Durata_mesi__c,PO_IndrizoCal__c,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Nome_Comune__c, po_comune2__c,PO_Comune2__r.OF_Comune__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Richiesta_a_fattibilit__r.casenumber,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c, Priority,Previous_Status__c, CreatedDate, CreatedById , PO_Offerta__c,OwnerId
from case where parentId=:parentCaseObj.id
order by casenumber ASC];

parentcase = parentCaseObj;
if(parentcaseobj.status=='Bozza')
{

caseobjbuttoncheck=true;

}


ChildCases = childcaseList;
// ChildCases.sort();
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);

}
public Pagereference AddAttachment()
{
return new pagereference ('/apex/Po_AddAttachment?id='+ChildCase.id);
}
*/
    
    /*
public pagereference DeleteParentCase()
{
system.debug('deleted parentCase=========='+parentCase);
delete parentCase;

return new pagereference('/apex/po_index');
}
public list<case> getsortingCases()
{   System.debug('insideSortigCases'+sortCases) ;
System.debug('recordOfferta==>'+recordOfferta) ;
String recOff=ApexPages.currentPage().getParameters().get('recordOfferta');
System.debug('pageparameter'+recOff) ;
if(recordOfferta==null)
{
recordOfferta=recOff;
}

if(recordOfferta!= null){
set<id> parentcases = new set<id>();

for(case cas : [select id,parentid,PO_Nome_Progetto__c,parent.PO_Offerta__c,PO_Tipologia_Offerta__c,OwnerId from case where ContactId =:usr.contact.id AND PO_Tipologia_Offerta__c=:recordOfferta])
{
//if(cas.parent.PO_Offerta__c == 'P2P Base')
parentcases.add(cas.parentid);
}
for(case cas : [select id from case where ContactId =:usr.contact.id  AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
{
parentcases.add(cas.id);
system.debug('case==='+cas);
}

string query = 'select id,casenumber,CreatedDate,PO_Offerta__c,PO_Nome_Progetto__c,Status from case where id IN :parentcases ';
query += ' Order by ' +  String.escapeSingleQuotes(sortField) + ' ' + myOrder ;

return Database.query(query);
//currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status from case where id IN :parentcases order by CreatedDate desc];
}
return SortCases;
}

public pagereference currentUserParentCases()
{
newAtt.clear();
//attxlxs.clear();
attlst.clear();
System.debug('recordOfferta==>'+recordOfferta) ;

set<id> parentcases = new set<id>();
for(case cas : [select id from case where ContactId =:usr.contact.id  AND PO_Offerta__c=:recordOfferta and recordtype.developername = 'PO_Richiesta_a_servizio_a_fattibilit'])
{
parentcases.add(cas.id);
}

currentUserCases = [select id,PO_Tipologia_Offerta__c,casenumber,CreatedDate,PO_Offerta__c,Status,PO_Nome_Progetto__c,
PO_Comune2__c from case
where id IN :parentcases
order by CreatedDate desc];
system.debug('currentUserCases====='+currentUserCases);
sortCases =getsortingCases();
system.debug('currentUserCases====='+sortCases);
return new pagereference ('/apex/Po_FeasibilityServicesRequest?recordOfferta='+recordOfferta);

}

//PREPROVISIONIG ---- INIZIO

public pagereference currentUserParentCases_PP()
{
return new pageReference('/PO_PP_DisplayRequest');
}

public pagereference kitConsegnaAttivi()
{
return new pageReference('/PO_PP_KitConsegnaAttivi');
}

//PREPROVISIONING ---- FINE


public pagereference currentUserParentCases_P2P()
{
set<id> parentcases = new set<id>();
for(case cas : [select id,parentid,parent.PO_Offerta__c from case where ContactId =:usr.contact.id])
{
if(cas.parent.PO_Offerta__c == 'P2P Base')
{
parentcases.add(cas.parentid);
}
}
currentUserCases = [select id,casenumber,CreatedDate,PO_Offerta__c,Status,PO_Comune2__c from case where id IN :parentcases order by CreatedDate desc];
return new pagereference ('/apex/Po_FeasibilityServicesRequest?id='+usr.id);
}
public List<Attachment> attLink {get;set;}

public pagereference displayChildCases() {
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
string attNamenew='';
string attname='';
newAtt.clear();
attxlxs.clear();
searchCaseBoolean=false;
searchLogBoolean=false;
attlst.clear();
parentfile = false;
Ordine = false;
stagename = false;
Id parentId = ApexPages.currentPage().getParameters().get('selparent');
string prid = parentId;
system.debug('prid===='+prid);
system.debug('parentId===='+parentId);
list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
from case where (parentId=:parentId OR parentId=:prid)
order by CreatedDate ASC];
if(childcaseList.size()>0)
ChildCases = childcaseList;
//system.debug('ChildCases====='+ChildCases);
if(childcaseList.size()>0){
if(parentId !=NULL) {
parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];

// oppty = [select id,stagename,PO_Numero_Anni__c,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];

if(opp.size()>0 && !opp.isEmpty())
{
if(opp[0].PO_Prezzo_totale_scontato__c != null)
{
Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
}

if(opp[0].stagename=='Offerta presentata')
{
stagename = true;
}
}

if(parentid != null)
{

// attlst = attlstnew;
list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false AND Name LIKE '%PDF%'
ORDER BY createddate DESC limit 1];
for(attachment att : newlst )
{
attnamenew = att.Name;

if(attnamenew.contains('.pdf'))
{
newAtt.add(att);
system.debug('Attachment==='+newAtt);
}
}
list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
ORDER BY createddate DESC];
for(attachment att : attlstnew )
{

attname = att.Name;
system.debug('Attachment==='+att.Name);
// if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))

if(attname.containsIgnoreCase('.pdf'))
{
attlst.add(att);
system.debug('Attachment==='+attlst);
}
if(attname.containsIgnoreCase('.jpg'))
{
attlst.add(att);
system.debug('Attachment==='+attlst);
}

}
if(attlst.size()>1 && attlst[0].name.containsIgnoreCase('.pdf'))
{
attlst.remove(0);
}

list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC];
for(attachment att : newlstxlxs )
{
String attnamexlxs = att.Name;

if(attnamexlxs.contains('.xlsx'))
{
attxlxs.add(att);
system.debug('Attachment==='+attxlxs);
}
}

}
if(parentCaseObj.Status == 'Accettato')
{
System.debug('testdate---');
Datetime fieldDate;
Datetime attachDate;
List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC Limit 1];
for(CaseHistory ch:csh)
{
System.debug('testdate---1');

fieldDate=ch.createdDate;
}

for(Attachment ah:ash)
{
System.debug('testdate---2');
attachDate=ah.createdDate;
}
If(fieldDate<attachDate) {
System.debug('testdate---3'+fieldDate);
System.debug('testdate---3'+attachDate);
ordine=true;
}
}
if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
{
parentfile = true;
}
if( parentCaseObj.PO_isDataOrder__c ==true)
{
ordine =false;
}
}

}
if(parentId !=NULL && childcaseList.size()==0) {

parentCaseObj = [SELECT CaseNumber, PO_Numero_Anni__c,  PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
system.debug('entering========'+parentCaseObj);
ChildCases = childcaseList;
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}

system.debug('ChildCases===='+parentCaseObj.status);
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);

}

public string Indirizzo{get;set;}
public pagereference DisplayCaseInfo()
{
childcaseobj = new case();
Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
system.debug('CaseObj====='+caseId);
if(caseId !=NULL) {
childCaseObj = [SELECT CaseNumber,PO_Sito__c,PO_IndrizoCal__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Civico__c,PO_Nota_sito__c,PO_Indirizzo_collegamento__c,PO_Nome_Comune__c,PO_Incluso_nell_offerta__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Comune2__c,PO_Richiesta_a_fattibilit__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,PO_Area_Geografica__c,PO_Prime_Contractor__c,PO_Note_Sospensione_OF__c,Note_Sospensione_Operatore__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,OwnerId

from case where Id=:caseId Limit 1];
system.debug('childCaseObj====='+childCaseObj.PO_Nota_sito__c);
system.debug('childCaseObj====='+childCaseObj.PO_Incluso_nell_offerta__c);
showedit=false;
childcheck = false;
system.debug('Status====='+childCaseObj.Status);

if(childCaseObj.Status == 'Acquisito' || childCaseObj.Status == 'Sospesa'  || childCaseObj.Status == 'Bozza' || childCaseObj.Status == 'In carico al Cliente')
{
showedit= true;
system.debug('showedit======'+showedit);
}
if(childCaseObj.Status == 'Completo')
{
orderline= true;
system.debug('childcheck======'+childcheck);
}
}
system.debug('showedit2======'+showedit);
return new pagereference ('/apex/Po_FeasibilityServicesRequest3?id'+caseId);
}
public pagereference Annula()
{
Id caseId = childCaseObj.parentid;
id newid = ApexPages.currentPage().getParameters().get('id');
system.debug('caseId====='+newid);
system.debug('caseId====='+caseId);
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+caseId);

}
public pagereference ParentAnnula()
{
update ParentCaseObj;
Id caseId = ParentCaseObj.id;
system.debug('caseId====='+caseId);
return new pagereference ('/apex/PO_FeasibilityService1?id'+ParentCaseObj.id);
}

public pagereference InviaRichiesta()
{
parentCaseObj.Status = 'Acquisito';
//parentCaseObj.EOF_Fase__c = 'In Lavorazione Supporto Vendite'; //AS patch inizial Phase
parentCaseObj.EOF_Fase__c = 'In Attesa Presa In Carico Supporto Vendite';
parentCaseObj.OwnerId = [select id from Group where developerName ='PO_Coda_Servizi_a_fattibilit'].id;
update parentCaseObj;
list<case> statusupdate = new list<case>();
for(case cs : ChildCases)
{
cs.status = 'Acquisito';
statusupdate.add(cs);
}
update statusupdate;
//EC 2018 - 07 - 13 aggiungiamo l'if relativo a se il servizio di fattibilità è P2P Attiva (bisogna infatti creare il case solo in questo momento)

if(ApexPages.CurrentPage().getParameters().containsKey('/apex/PO_P2PAttiva')){

}

invia = false;
return null;
}

public pagereference EditCaseInfo()
{    selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
system.debug('CaseObj====='+caseId);
if(caseId !=NULL) {
childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
PO_Prime_Contractor__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,parent.PO_Offerta__c,PO_Area_Geografica__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
from case where Id=:CaseDetail Limit 1];

system.debug('childCaseObj====='+childCaseObj.PO_Offerta__c);
offertEvento =  childCaseObj.PO_Tipologia_Offerta__c;
// ordercasedisplaydatePO_Data_Attivazione_Ordine_date = childCaseObj.PO_Data_Attivazione_Ordine__c;

}
if(childCaseObj.parent.PO_Offerta__c == 'Fiber Link' || childCaseObj.parent.PO_Offerta__c == 'Evento Temporaneo')
{
return new pagereference ('/apex/PO_Fiberlink_Evento_EditCase?id='+caseId);
}
if(childCaseObj.parent.PO_Offerta__c == 'IRU' || childCaseObj.parent.PO_Offerta__c == 'Fiber Lease')
{
return new pagereference ('/apex/PO_IRU_FiberLease_Edit?id='+caseId);
}
return new pagereference ('/apex/Po_FeasibilityServicesRequest4?id='+caseId);

}
public string cliente {get;set;}
public string cliente1 {get;set;}
public string cliente2 {get;set;}
public pagereference EditOrderInfo()
{
Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
system.debug('CaseObj====='+caseId);
if(caseId !=NULL) {
childCaseObj = [SELECT CaseNumber,PO_Durata_mesi__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.parentid,PO_Data_Attivazione_Ordine__c,PO_Tipologia_Offerta_ordine__c,EOF_Comunicazioni_con_OLO__c,PO_IndrizoCal__c,PO_Civico__c,PO_Nota_sito__c, PO_Tipo_di_collegamento__c,PO_Sito_partenza__c,PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Nota_sito_partenza__c,
PO_Prime_Contractor__c,PO_Sito__c,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,PO_Area_Geografica__c,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c,PO_Richiesta_a_fattibilit__r.PO_Tipologia_Offerta__c,PO_Tipologia_Offerta__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,PO_Indirizzo_collegamento__c ,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
from case where Id=:CaseDetail Limit 1];

system.debug('childCaseObj====='+childCaseObj.PO_Offerta__c);
offertEvento =  childCaseObj.PO_Tipologia_Offerta__c;
cliente = childCaseObj.PO_Indirizzo_collegamento__c + ','+ childCaseObj.PO_Civico__c + ',' +childCaseObj.PO_Nome_Comune__c;
if(childCaseObj.PO_Nome_Comune3__c != null){
cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c+' '+childCaseObj.PO_Civico_partenza__c +','+ childCaseObj.PO_Nome_Comune3__c ;
}
if(childCaseObj.PO_Nome_Comune3__c == null){
cliente1 = childCaseObj.PO_Indirizzo_collegamento_partenza__c+' '+childCaseObj.PO_Civico_partenza__c ;
}
String collegamento = childCaseObj.PO_indirizzo_collegamento_3__c;
string civico = childCaseObj.PO_Civico_3__c;
string comune = childCaseObj.PO_Nome_Comune4__c ;
if(childCaseObj.PO_indirizzo_collegamento_3__c== null)
{
collegamento ='';
}
if(childCaseObj.PO_Civico_3__c== null)
{
civico ='';
}
if(childCaseObj.PO_Nome_Comune4__c == null)
{
comune ='';
}

cliente2 = collegamento +' '+civico +','+comune ;

if(childCaseObj.PO_Nome_Comune4__c == null)
{
cliente2 = collegamento +' '+civico ;
}

if(childcaseobj.PO_Data_Attivazione_Ordine__c!= null)
{
Integer d = childcaseobj.PO_Data_Attivazione_Ordine__c.day();
Integer mo = childcaseobj.PO_Data_Attivazione_Ordine__c.month();
Integer yr = childcaseobj.PO_Data_Attivazione_Ordine__c.year();

DateTime DT = DateTime.newInstance(yr, mo, d);
//DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
system.debug('childDate====='+DT);
ordercasedispayordinedate = DT.format('dd/MM/yyyy');
system.debug('childDate====='+childDate);
}
}
orderatt = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId AND IsPrivate = false
ORDER BY createddate DESC];
return new pagereference ('/apex/Po_FeasibilityServicesRequest8?id='+caseId);
}

//EC to do 2018 - 07 - 24 creare un metodo per il Log
public pagereference DetailPage()
{

if(searchCaseboolean==false){

return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+childCaseObj.PO_Case_Collegamento__r.parentid);
}
else
{
system.debug('Boolean'+searchCaseBoolean);
return new PageReference ('/apex/PO_Index');
}
}

//EC To do 2018 - 07 - 24 crea un metodo SaveLogInfo
public pagereference SaveCaseInfo()
{
Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
if(caseId != null)
{
childCaseObj = [SELECT CaseNumber,PO_Sito__c,PO_Case_Collegamento__r.parentid,PO_Case_Collegamento__c,PO_Indirizzo_collegamento__c,PO_Civico__c,PO_Nome_Comune__c,Note_Sospensione_Operatore__c,
PO_Data_Attivazione_Richiesta__c,PO_Prime_Contractor__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,PO_Richiesta_a_fattibilit__r.PO_Offerta__c,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,PO_Area_Geografica__c,PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
from case where Id=:caseid Limit 1];

// system.debug(' childCaseObj.status========>'+ childCaseObj.status);
}
//system.debug(' childCaseObj.status========>'+ childCaseObj.status);
// system.debug(' childCaseObj.status========>'+ childCaseObj.Previous_Status__c);
update childCaseObj;
if(childCaseObj.Previous_Status__c != null)
{
childCaseObj.status = childCaseObj.Previous_Status__c;
}
update childCaseObj;
showedit = false;
// system.debug('Case to be updated new======'+childCaseObj);
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+childCaseObj.parentid);
}

public pagereference OpportunityStageNameUpdate()
{
if(parentcaseobj.PO_Offerta__c =='Fiber Lease')
{
ordine = true;
//parentfile = false;
}

list<opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
where id in : opp limit 1
];


if(opplst.size()>0 && !opplst.isEmpty())
{

if(opplst[0].stagename == 'Offerta presentata')
{
opplst[0].StageName = 'Offerta accettata';
update opplst[0];
}

}
if(parentCaseObj != null)
{
if( opplst[0].StageName != null)
{
parentCaseObj.Status = 'Accettato';
parentCaseObj.OwnerId = UserInfo.getUserId();
}

update parentCaseObj;
list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,PO_Comune2__c,status,casenumber,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
recordtype.id,recordtype.developerName,OwnerId from case where parentid=:parentCaseObj.id and PO_Incluso_nell_offerta__c = true];

system.debug('childcaselst======='+parentCaseObj.PO_Durata_affitto__c);
if(parentCaseObj.PO_Durata_affitto__c == null && parentCaseObj.PO_Offerta__c == 'Fiber Link')
{
ApexPages.addMessage(
new ApexPages.Message(ApexPages.Severity.error,'Inserire il numero di anni di affitto di interesse, cliccando su Modifica.'));

}

else
{
if(childcaselst.size()>0)
{
OrderCreation(childcaselst);
parentfile = true;
stagename = false;

// PO_ServiziFattibilita_Controller.OrderCreation(childcaselst);
}
}

}
return null;
}
public list<case> getorderCases()
{
try
{
if(ChildCases.size()>0)
ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN : ChildCases];

system.debug('ordercaselst======='+ordercaselst);
system.debug('ChildCases======='+ChildCases);
}
catch(exception e)
{
system.debug('error======='+e.getStackTraceString());
}
return ordercaselst;
}

public list<Opportunity> getparentOppty()
{
try
{
String id=apexpages.currentpage().getparameters().get('id') ;
if(id!='' || id!=null){
parentOpptylst = [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c from Opportunity where PO_Richiesta_fattibilit__c =:id];
}
}
catch(exception e)
{
system.debug('error======='+e.getStackTraceString());
}
return parentOpptylst ;
}

public string recid {get;set;}
public pagereference collegmentaDate()
{
//ordine = true;
system.debug('i am in method collegmentaDate');
string id =apexpages.currentPage().getParameters().get('recid');
system.debug('id========'+id);
ordercasedit = [select id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,PO_Nome_E_Cognome_PM__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c  from case where id=:id];
date d = date.today();
if(ordercasedit.PO_Tempi_di_attivazione_mesi__c != null)
{
Integer intConvertedValue = ordercasedit.PO_Tempi_di_attivazione_mesi__c.intValue();

date checkdate_In_PO_ModalController = d.addmonths(intConvertedValue );
stringdate_In_PO_ModalController =  string.valueOf(checkdate_In_PO_ModalController );
}
else
{
stringdate_In_PO_ModalController =  string.valueOf(d );
}
return new pagereference('/apex/PO_ModalController?id'+ordercasedit.id);
}
public pagereference collegmentaDateEdit()
{
//ordine = true;
string id =apexpages.currentPage().getParameters().get('editid');
system.debug('id========'+id);

ordercasedit = [select id,OwnerId,PO_Data_Attivazione_Richiesta__c, casenumber,PO_Numero_Telefonico_PM__c,PO_Nome_E_Cognome_PM__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.id,PO_Tempi_di_attivazione_mesi__c  from case where id=:id];

System.debug('@@@ordercasedit'+ ordercasedit);
return new pagereference('/apex/PO_ModalController?id'+ordercasedit.id);
}
public pagereference SaveOrderCase()
{
//Ordine=true;
system.debug('htmldate===='+date4);
str = date4.replace('/', '-');
system.debug('the value in the str'+str);

try
{
ordercasedit.PO_Data_Attivazione_Richiesta__c = date4;
//ordercasedit.PO_Data_Attivazione_Richiesta__c = str;
update ordercasedit;
}
catch(exception e)
{
system.debug('error date fiels======>'+e.getStackTraceString());
}
//   update ordercaselst;
case parencs = [select id,parentid,OwnerId from case where id=:ordercasedit.PO_Case_Collegamento__c];
system.debug('parentid========'+parencs.parentid);
return new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+parencs.parentid);
}

public pagereference orderAnnula()
{
case parencs = [select id,parentid,OwnerId from case where id=:ordercasedit.PO_Case_Collegamento__c];
system.debug('parentid========'+parencs.parentid);
return new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+parencs.parentid);
}
public string textarea {get;set;}
public pagereference OpportunityStageNameUpdate2()
{

inlineshow = true;
list<opportunity> opplst = [select id,name,createdby.id,stagename,PO_Richiesta_fattibilit__c from opportunity
where id in : opp limit 1];
system.debug('entering============'+opplst[0].stagename);
if(opplst.size()>0 && !opplst.isEmpty())
{

if(opplst[0].stagename == 'Offerta presentata')
{
opplst[0].StageName = 'Richiesta nuova proposta';
update opplst[0];
}

}
if(parentCaseObj != null)
{
if( opplst[0].StageName != null)
{
parentCaseObj.Status = 'In lavorazione';
parentCaseObj.EOF_Fase__c = 'Richiesta modifica offerta da Cliente';
parentCaseObj.OwnerId = opplst[0].createdby.id;
}
update parentCaseObj;


}


if(ChildCases.size()>0)
{
update ChildCases;
list<case> mylist = new list<case>();
list<case> ChildCaseslist =  [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.id,PO_Nome_Comune__c
from case where id In :ChildCases ];
for(case cs : ChildCaseslist)
{
if(cs.PO_Incluso_nell_offerta__c == true)
{
cs.Status = 'Completato';
mylist.add(cs);
}
else
{
cs.Status = 'Annullato';
mylist.add(cs);
}
}
if(mylist.size()>0)
{
update mylist;
ChildCases = mylist;

}

}
//  stagename = false;
//ChildcaseRedirect =true;

// return null;
//return ApexPages.currentPage();

return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}


public pagereference OpportunityStageNameUpdate4()
{
inlineshow = false;
update ChildCases;
stagename = false;
return null;
}

public pagereference OpportunityStageNameUpdate3()
{
list<opportunity> opplst = [select id,name,stagename,PO_Richiesta_fattibilit__c from opportunity
where id in : opp limit 1
];
if(opplst.size()>0 && !opplst.isEmpty())
{

if(opplst[0].stagename == 'Offerta presentata')
{
opplst[0].StageName = 'Offerta rifiutata';
update opplst[0];
}

}
if(parentCaseObj != null)
{
if( opplst[0].StageName != null)
{
parentCaseObj.Status = opplst[0].StageName;
parentCaseObj.OwnerId = UserInfo.getUserId();
}
update parentCaseObj;
}
stagename = false;
return null;
}

public string textarea1 {get;set;}

public pagereference OpportunityStageNameUpdate3a()
{
inlineshow = true;
list<opportunity> opplst = [select id,name,stagename,PO_Richiesta_fattibilit__c from opportunity
where id in : opp limit 1];
case parentcase = [select id,casenumber,PO_Note_rifiuto_offerta__c,OwnerId from case where id=:parentCaseObj.id];
parentcase.PO_Note_rifiuto_offerta__c = textarea1;
update parentcase;
system.debug('Parent textarea===='+parentcase.PO_Note_rifiuto_offerta__c);

system.debug('parentCaseObj===='+parentcase);
if(opplst.size()>0 && !opplst.isEmpty())
{

if(opplst[0].stagename == 'Offerta presentata')
{
opplst[0].StageName = 'Offerta rifiutata';
update opplst[0];
}
}
stagename = false;
return null;
}


public pageReference StausUpdate()
{
Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');

if(caseId != null)
{
childCaseObj = [SELECT CaseNumber,PO_Data_Attivazione_Richiesta__c,PO_Nome_E_Cognome_PM__c,PO_Numero_Telefonico_PM__c,PO_Richiesta_a_fattibilit__c,PO_Comune2__c,Previous_Status__c,PO_Richiesta_a_fattibilit__r.casenumber,Id, ParentId, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,PO_Area_Geografica__c,PO_Prime_Contractor__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Siti_da_collegare__c,PO_Nome_sito__c,PO_Note_collegamento__c,OwnerId
from case where Id=:caseid Limit 1];
childCaseObj.status = childCaseObj.Previous_Status__c;
showedit = true;
system.debug('Old Status========>'+ childCaseObj.status);
}

update childCaseObj;
return null;
}
public pageReference Home(){
return new pagereference('https://servattivi-servattivi.cs84.force.com/partnercommunity');
}
public Pagereference saveContactInformation(){
try
{
update contactObj;
}
catch(exception e)
{
system.debug('Error Message======'+e.getStackTraceString());
}
return null;
}

public void ParentDataOrderUpdation()
{
childcserec = [select id,status,PO_Comune2__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
recordtype.id,recordtype.developerName,PO_Case_Collegamento__r.parent.PO_isDataOrder__c,OwnerId from case where id IN : ordercaselst
and PO_Data_Attivazione_Richiesta__c != null and PO_Nome_E_Cognome_PM__c != null and
PO_Numero_Telefonico_PM__c != null ];
system.debug('order lsist size===='+ordercaselst.size());
system.debug('childcserec size===='+childcserec.size());
if(ordercaselst.size() == childcserec.size())
{
parentCaseObj.PO_isDataOrder__c = true;
update parentCaseObj;
ParentOrderCheck = true;
if(childcserec.size()>0)
{
OrderCreation(childcserec);
}
ordine = false;
}
else
{
string msg1 = 'Cliccare su “Completa Ordine” per ciascun ordine in elenco, per inserire i dati necessari \n';
string msg2 = 'L’ordine sarà lavorato solo se saranno inseriti i dati richiesti per tutti gli ordini \n';
string message = msg1 + msg2 ;
ApexPages.addMessage(
new ApexPages.Message(ApexPages.Severity.info,message));
}
}

@TestVisible public class addAdressClass{
public string ContactNamelable{get;set;}
public string ContactNameValue{get;set;}
public string ContactNamelable1{get;set;}
public string ContactNameValue1{get;set;}

public addAdressClass(String ContactNamelable,String ContactNamelable1){
this.ContactNamelable = ContactNamelable;
this.ContactNamelable1 = ContactNamelable1;
}
}
*/
    // Instance fields
    
    /*
@RemoteAction
public static List<OF_ElencoComuniItaliani__c> searchComune1(String searchTerm1) {
// System.debug('Comune Name is: '+searchTerm );
List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm1) + '%\'  order by OF_Comune__c ASC ' );
// System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
return AreaGeograficaJunction;
}
@RemoteAction
public static List<OF_ElencoComuniItaliani__c> searchComune2(String searchTerm2) {
// System.debug('Comune Name is: '+searchTerm );
List<OF_ElencoComuniItaliani__c> AreaGeograficaJunction = Database.query('SELECT Id,OF_Regione__c,OF_Comune__c FROM OF_ElencoComuniItaliani__c where OF_Comune__c  like \'' + String.escapeSingleQuotes(searchTerm2) + '%\'  order by OF_Comune__c ASC ' );
// System.debug('AreaGeograficaJunction: '+AreaGeograficaJunction );
return AreaGeograficaJunction;

}


public PageReference backtochild() {
id parentid = apexpages.currentPage().getparameters().get('id');

return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
}
public static List<Case>  OrderCreation (List<Case> CaseFromPortal){

list<RecordType> RList =[select id, developerName from recordType];
MAp<String,String> checkRType = new MAp<String,String>();
for(recordType RT : RList){
checkRType.Put( rt.Id,rt.developerName);
}
if(checkRType.get(CaseFromPortal[0].recordtypeId).contains('Collegamento')){
system.debug('@@@@@ 01');
OF_UtilitiesManageOrderFromCase obju = new OF_UtilitiesManageOrderFromCase();
list<Case> CaseToOrder =[select status,PO_IndrizoCal__c,PO_Case_Collegamento__r.PO_Incluso_nell_offerta__c, EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
PO_Numero_fibre_richieste__c,PO_Comune3__c,PO_sito_3__c ,PO_Nota_sito_3__c ,PO_Comune4__c,PO_indirizzo_collegamento_3__C ,PO_civico_3__c ,PO_Drop_FL_1__c, AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
PO_Tipo_percorso__c,PO_Comune2__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,PO_Sito_partenza__c,PO_Civico_partenza__c, PO_Indirizzo_collegamento_partenza__c, PO_Nota_sito_partenza__c, PO_Civico__c,
recordtype.id,recordtype.developerName,PO_Richiesta_a_fattibilit__c,OwnerId from case where id IN: CaseFromPortal];

List<Case> caseToInsert = new List<Case>();
MAp<String,String> rtMap = new MAp<String,String>();
for(recordType RT : RList){
rtMap.Put(rt.developerName, rt.Id);
}
for( case cOld : CaseToOrder){
system.debug('@@@@@ 02');
case c= new case();
c.status='Accettato';
c.EOF_Fase__c='Bozza';
c.PO_Case_Collegamento__c=cOld.Id;
c.PO_Tipo_di_collegamento__c=cOld.PO_Tipo_di_collegamento__c;
c.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
c.AccountId=cOld.AccountId;
c.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
c.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
c.PO_Comune2__c =cOld.PO_Comune2__c;
c.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
c.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
c.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
c.PO_Sito__c=cOld.PO_Sito__c;
c.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
c.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;
c.PO_Sito_partenza__c= cOld.PO_Sito_partenza__c;
c.PO_Civico_partenza__c= cOld.PO_Civico_partenza__c;
c.PO_Indirizzo_collegamento_partenza__c= cOld.PO_Indirizzo_collegamento_partenza__c;
c.PO_Nota_sito_partenza__c= cOld.PO_Nota_sito_partenza__c;
c.PO_Civico__c= cOld.PO_Civico__c;
//28/09/2017 CRM Modifica
c.PO_Richiesta_a_fattibilit_ordine__c = cOld.PO_Richiesta_a_fattibilit__c;
//28/09/2017 END CRM

system.debug('ComuneTest==='+cOld.PO_Comune3__c );
if(cOld.RecordType.developerName=='PO_Collegamento_Fiber_link'){
if(cOld.PO_Comune3__c != null){
c.PO_Comune3__c=cOld.PO_Comune3__c;
}
if(cOld.PO_Comune4__c != null){
c.PO_Comune4__c=cOld.PO_Comune4__c;
}
c.PO_indirizzo_collegamento_3__C = COld.PO_indirizzo_collegamento_3__c;
c.PO_civico_3__c = cOld.PO_civico_3__c;
c.PO_sito_3__c = cOld.PO_sito_3__c;
c.PO_Nota_sito_3__c = cOld.PO_Nota_sito_3__c;
c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Link');
}

if(cOld.RecordType.developerName=='PO_Collegamento_Fiber_lease'){
if(cOld.PO_Comune3__c != null){
c.PO_Comune3__c=cOld.PO_Comune3__c;
}
c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Lease');

if(cOld.PO_Drop_FL_1__c == true){
case cFlink= new case();
cFlink.status='Accettato';
cFlink.EOF_Fase__c='Bozza';
cFlink.PO_Case_Collegamento__c=cOld.Id;
cFlink.PO_Tipo_di_collegamento__c='None';
cFlink.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
cFlink.AccountId=cOld.AccountId;
cFlink.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
cFlink.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
cFlink.PO_Comune2__c =cOld.PO_Comune2__c;
cFlink.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
cFlink.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
cFlink.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
cFlink.PO_Sito__c=cOld.PO_Sito__c;
cFlink.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
cFlink.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;
cFlink.PO_Sito_partenza__c= cOld.PO_Sito_partenza__c;
cFlink.PO_Civico_partenza__c= cOld.PO_Civico_partenza__c;
cFlink.PO_Indirizzo_collegamento_partenza__c= cOld.PO_Indirizzo_collegamento_partenza__c;
cFlink.PO_Nota_sito_partenza__c= cOld.PO_Nota_sito_partenza__c;
cFlink.PO_Civico__c= cOld.PO_Civico__c;
cFlink.PO_Richiesta_a_fattibilit_ordine__c = cOld.PO_Richiesta_a_fattibilit__c;
cFlink.recordTypeid=rtMap.get('PO_Ordine_Fiber_Link');

caseToInsert.add(cFlink);
}
}

if(cOld.RecordType.developerName=='PO_Collegamento_IRU'){
if(cOld.PO_Comune3__c != null){
c.PO_Comune3__c=cOld.PO_Comune3__c;
}
c.recordTypeid=rtMap.get('PO_Ordine_IRU');
}

if(cOld.RecordType.developerName=='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'){
if(cOld.PO_Comune3__c != null){
c.PO_Comune3__c=cOld.PO_Comune3__c;
}
if(cOld.PO_Comune4__c != null){
c.PO_Comune4__c=cOld.PO_Comune4__c;
}
c.PO_indirizzo_collegamento_3__C = COld.PO_indirizzo_collegamento_3__c;
c.PO_civico_3__c = cOld.PO_civico_3__c;
c.PO_sito_3__c = cOld.PO_sito_3__c;
c.PO_Nota_sito_3__c = cOld.PO_Nota_sito_3__c;
c.recordTypeid=rtMap.get('PO_Ordine_Misto_Fiber_Lease_Link_per_Fastweb');

}

if(cOld.RecordType.developerName=='PO_Collegamento_P2P'){
c.recordTypeid=rtMap.get('PO_Ordine_P2P');
}

caseToInsert.add(c);
}
insert caseToInsert;
//Chenges Alessandro
map<id, set<id>> IdMapNew = new map<id, set<id>>();
map<id, case> CaseMap = new map<id, case>();
List<OF_CommercialElementIstanziato__c> CEIToInsert = new List<OF_CommercialElementIstanziato__c>();
Map<Id,Case> caseFormula = new Map<Id,Case>([select id, casenumber,Codice_Ordine_EOF__c from case where id in: caseToInsert]);
for(Case c : caseToInsert){

system.debug('DG_OF_ManageOrderFromCase - c.status: ' + c.status + '---c.PO_Case_Collegamento__c: ' + c.PO_Case_Collegamento__c);

IdMapNew.put(c.PO_Case_Collegamento__c,new Set<ID>{c.Id});
CaseMap.put(c.id, c);

//creazione CEI
if(c.PO_Tipo_percorso__c.toUpperCase()=='DOPPIA VIA DIVERSIFICATA'){
OF_CommercialElementIstanziato__c partenza = new OF_CommercialElementIstanziato__c();
partenza.recordtypeId=rtMap.get('Tratte');
partenza.OF_CaseTratta__c=c.Id;
CEIToInsert.add(partenza);
OF_CommercialElementIstanziato__c destinazione = new OF_CommercialElementIstanziato__c();
destinazione.recordtypeId=rtMap.get('Tratte');
destinazione.OF_CaseTratta__c=c.Id;
CEIToInsert.add(destinazione);
}
else{
OF_CommercialElementIstanziato__c unico = new OF_CommercialElementIstanziato__c();
unico.recordtypeId=rtMap.get('Tratte');
unico.OF_CaseTratta__c=c.Id;
CEIToInsert.add(unico);
}
}if(!CEIToInsert.isEmpty()){
Insert CEIToInsert;
}
system.debug('@@@@@ IdMapNew= '+IdMapNew);
map<id, list<opportunity>> mappaOpp = objU.CreateMap(IdMapNew);
system.debug('@@@@@ mappaOpp= '+mappaOpp);
map<id, order> mappaCase = new map<id, order>();
list<Order> orders = new list<Order>();
//OSCRM 30_08_2017 INIZIO
map<id,case> caseCollegamento = objU.getCaseCollegamentoFields( CaseMap );
//FINE
for(id ix : mappaOpp.keyset())
{
opportunity opp = objU.FindOpportunity(ix,mappaOpp);
system.debug('DG_OF_ManageOrderFromCase - opp: ' + opp);
if(opp != null){
order o = objU.CreateOrderPO(ix, CaseMap, opp , caseCollegamento );
o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
orders.add(o);
mappaCase.put(ix, o);
}
}
system.debug('@@@@@ orders= '+orders);
system.debug('@@@@@ mappaCase= '+mappaCase);
if(orders.size() > 0) insert orders;


for(Case c : caseToInsert){
c.Of_order__c=mappaCase.get(c.id).id;
system.debug('@@@@@ case= '+c.id+' @@@@ ordine= '+c.Of_order__c);
}
update caseToInsert;
//chenges END

return caseToInsert;
}
else{

Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita'];
for(case c : CaseFromPortal){
c.EOF_fase__c='In Lavorazione Supporto Vendite';
c.OwnerId=codaSupportoVendite.Id;
}
update CaseFromPortal;
return null;
}
}

public Pagereference UpdateChildcaseInfo()
{
editchildparentCaseObj = new case();

editchildparentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:childcaseobj.parentid Limit 1];

if(childcaseobj!=null)
{
update childcaseobj;
}
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+editchildparentCaseObj.id);

}
// public attachement parentAttachment{get;set;}
public pagereference AddParentAttachment()
{
return new pagereference('/apex/PO_AddAttachment?id'+parentCaseObj.id);
}
public pagereference parentupload() {
attachment.clear();
attachment.OwnerId = UserInfo.getUserId();
attachment.ParentId = parentCaseObj.id;
//attachment.IsPrivate = true;
attachment.name = fileName;
attachment.body = fileBody;

try {
system.debug('Comming here in try==>'+attachment);
insert attachment;
ordine = true;
if(attachment.id != null)
{
newAtt = [select id,name,createddate,parentid,ownerid from attachment where id =:attachment.id];
}
system.debug('newAtt========='+newAtt);
} catch (DMLException e) {
system.debug('error======'+e.getStackTraceString());
system.debug('Comming here in catch==>'+attachment);

} finally {
system.debug('Comming here in finally==>'+attachment);
attachment.body = null;
attachment = new Attachment();
}
parentfile = false;
system.debug('attachment========='+attachment);
return new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}
public pagereference uploadCSV()
{
testcase.PO_Nome_Progetto__c = Nome;
update testcase;
system.debug('Nome======='+Nome);
system.debug('testcase======='+testcase);

try
{
parentCaseObj = [select id,PO_Numero_Anni__c,PO_Note_Modifica_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Offerta__c,casenumber,status,CreatedDate,PO_Durata_Affitto__c,OwnerId from case where id=:testcase.id];
parentCaseObj.PO_Nome_Progetto__c = Nome;
update parentCaseObj;
Nome = '';
system.debug('parentCaeObj======='+parentCaseObj);
}
catch(exception e)
{
system.debug('error message====='+e.getStackTraceString());
}
return new pagereference ('/apex/po_Uploadcsv?id'+parentCaseObj.id);
}
public Pagereference ReadFile()
{
if(contentFile== null) {
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Scegliere prima il file da importare'));
return null;
}
else{
//update parentcase;
//Convert the uploaded file which is in BLOB format into a string
searchCaseBoolean=false;
nameFile =blobToString( contentFile,'ISO-8859-1');

//Now sepatate every row of the excel file
filelines = nameFile.split('\n');

//parentCaseObj = [select id,PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Note_Modifica_Offerta__c,casenumber,status,CreatedDate from case where id=:testcase.id];
//Iterate through every line and create a Case record for each row
recordtype rt1 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_Lease'];
recordtype rt2 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Fiber_link'];
recordtype rt3 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P'];
recordtype rt4 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_IRU'];
recordtype rt5 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_Misto_Fiber_Lease_Link_per_Fastweb'];
recordtype rt6 = [select id from recordtype where sobjectType ='case' and developername='PO_Collegamento_P2P_Attiva']; //EC add new recordType PO_Collegamento_P2P_Attiva
casestoupload = new List<Case>();
for (Integer i=1;i<filelines.size();i++)
{
String[] inputvalues = new String[]{};
inputvalues = filelines[i].split(',');
OF_ElencoComuniItaliani__c comune = [select id,OF_Comune__c from OF_ElencoComuniItaliani__c where OF_Comune__c =:inputvalues[0] limit 1];
system.debug('comune name==='+inputvalues[0] );
system.debug('comune==='+comune);
Case c = new Case();
c.parentid = parentCaseObj.id;
if(parentCaseObj.PO_Offerta__c == 'P2P Base')
{
c.RecordTypeId = rt3.id;
}
if(parentCaseObj.PO_Offerta__c == 'IRU')
{
c.RecordTypeId = rt4.id;
}
if(parentCaseObj.PO_Offerta__c == 'Fiber Link')
{
c.RecordTypeId = rt2.id;
}
if(parentCaseObj.PO_Offerta__c == 'Fiber Lease')
{
c.RecordTypeId = rt1.id;
}
if(parentCaseObj.PO_Offerta__c == 'Evento Temporaneo')
{
c.RecordTypeId = rt5.id;
}
//EC inseriamo la parte relativa a P2P Attiva 2018 - 07 -13

if(parentCaseObj.PO_Offerta__c == 'P2P Attiva')
{
c.RecordTypeId = rt6.id;
}
//EC end
c.Status = 'Bozza';
c.accountid = accId;
c.PO_Richiesta_a_fattibilit__c = parentCaseobj.id;
c.PO_Comune2__c = comune.id;
c.PO_Prime_Contractor__c = inputvalues[1];
c.PO_Tipo_di_collegamento__c = inputvalues[2];
c.PO_Numero_fibre_richieste__c = inputvalues[3];
c.PO_Tipo_percorso__c = inputvalues[4];
c.PO_Sito__c = inputvalues[5];
c.PO_Indirizzo_collegamento__c = inputvalues[6];
c.PO_Civico__c = inputvalues[7];
c.PO_Nota_sito__c = inputvalues[8];
c.PO_Sito_partenza__c = inputvalues[9];
c.PO_Indirizzo_collegamento_partenza__c = inputvalues[10];
c.PO_Civico_partenza__c = inputvalues[11];
c.PO_Nota_sito_partenza__c = inputvalues[12];
casestoupload.add(c);
}
try
{
insert casestoupload;
ChildCases = [SELECT Case.Parent.casenumber,PO_IndrizoCal__c,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Nome_Comune__c,PO_Durata_mesi__c, po_comune2__c,PO_Comune2__r.OF_Comune__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Richiesta_a_fattibilit__r.casenumber,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c, Priority,Previous_Status__c, CreatedDate, CreatedById , PO_Offerta__c,OwnerId
from case where id IN :casestoupload
order by casenumber ASC ];

update ChildCases;

return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}
catch(exception e)
{
ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage());
ApexPages.addMessage(errormsg);
}
return null;
}
}
public List<Case> getuploadedCases()
{
if (casestoupload!= NULL)
if (casestoupload.size() > 0)
return casestoupload;
else
return null;
else
return null;
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

public PageReference DeleteParentChildCase()
{
Boolean isChild=False;
Case ParentCaseToshow = new Case();
String parentCasetoDelID = apexpages.currentPage().getparameters().get('id');
system.debug('Eliminia'+parentCasetoDelID);

List<Case> ChildCasetoDel = new List<Case>();
if(parentCasetoDelID!= null && parentCasetoDelID!= ''){
ChildCasetoDel=[Select id from Case where parentid=:ParentCasetoDelID];
if(ChildCasetoDel.size()>0)
{
system.debug('Eliminia Inside Child'+ChildCasetoDel);
isChild=true;
Database.delete(ChildCasetoDel,False);
}
if(!isChild){
ParentCasetoShow=[Select Id,ParentID from Case where Id=:parentCasetoDelID];
}
Database.delete(parentCasetoDelID,False);

}

return new pagereference('/apex/PO_index');

}
public  pagereference deleteChildAlone()
{
string parentCasetoDelID = '';
id idrec = apexpages.currentPage().getparameters().get('id');

if(idrec != null)
{
parentCasetoDelID = idrec;
}
else if(ChildCase != null)
{
parentCasetoDelID = ChildCase.id;
}
else if(ChildCaseobj != null)
{
parentCasetoDelID = ChildCaseobj.id;
}
system.debug('parentCasetoDelID==='+idrec);
case rectoDel = [select id,parentid from case where id=:parentCasetoDelID];
string parentrec = rectoDel.parentid;
parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:parentrec Limit 1];

system.debug('rectoDel==='+rectoDel);
Delete rectoDel;
list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Comune2__c,PO_Civico__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
Priority,Previous_Status__c,PO_IndrizoCal__c,PO_Durata_mesi__c,OwnerId, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
from case where parentId=:parentCaseObj.id
order by CreatedDate ASC];
//system.debug('ChildCases====='+ChildCases);
if(childcaseList.size()>0){
ChildCases = childcaseList;
}
if(childcaseList.size()==0 && parentCaseObj != null)
{
system.debug('entering======'+ChildCases);
ChildCases = childcaseList;
return new pageReference('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}
return new pageReference('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);

}

Public pagereference contList()
{
showcon = false;
return new pageReference('/apex/PO_ContactListPage');
}

Public pagereference EditContact()
{
return new pageReference('/apex/PO_EditContactPage');
}
//added by Alessandro 2017_09_01
public pagereference OpenStreamList(){
return new pageReference('/PO_OpenStream_DisplayRequest');
}
//added by Antonio A.(STEP SRL) 2018_05_25
public pagereference LineeAttive(){
return new pageReference('/LineeAttive');
}

//EC to do creazione metodo redirectParentLogDetail aggiungendo searchLogBoolean come searchCaseBoolean
public pagereference  redirectparentcasedetail()
{
//ParentDate=string.valueof(parentCaseobj.CreatedDate);
searchCaseBoolean=true;
//Id caseid = ApexPages.currentPage().getParameters().get('CaseDetail');
string attNamenew='';
string attname='';
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';
newAtt.clear();
attxlxs.clear();
searchCaseBoolean=false;
attlst.clear();
parentfile = false;
Ordine = false;
stagename = false;
Id parentId =  ApexPages.currentPage().getParameters().get('CaseDetail');
string prid = parentId;
system.debug('prid===='+prid);
system.debug('parentId===='+parentId);
list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.id,PO_Nome_Comune__c
from case where (parentId=:parentId OR parentId=:prid)
order by CreatedDate ASC];
system.debug('ChildCases====='+childcaseList);
if(childcaseList.size()>0)
ChildCases = childcaseList;
system.debug('ChildCases====='+ChildCases);
if(childcaseList.size()>0){


system.debug('parentId====='+parentId);
if(parentId !=NULL) {
parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,OwnerId,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c from case where id =:parentId Limit 1];


system.debug('parentCaseObj======'+parentCaseObj);
opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];


if(opp.size()>0 && !opp.isEmpty())
{
if(opp[0].PO_Prezzo_totale_scontato__c != null)
{
Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
}

if(opp[0].stagename=='Offerta presentata')
{
stagename = true;
}
}

if(parentid != null)
{
// attlst = attlstnew;
list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC limit 1];
for(attachment att : newlst )
{
attnamenew = att.Name;

if(attnamenew.contains('.pdf'))
{
newAtt.add(att);
system.debug('Attachment==='+newAtt);
}
}
list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
ORDER BY createddate DESC];
for(attachment att : attlstnew )
{
attname = att.Name;
system.debug('Attachment==='+att.Name);

if(attname.containsIgnoreCase('.pdf'))
{
attlst.add(att);
system.debug('Attachment==='+attlst);
}

}
if(attlst.size()>1)
{
attlst.remove(0);
}

list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC];
for(attachment att : newlstxlxs )
{
String attnamexlxs = att.Name;

if(attnamexlxs.contains('.xlsx'))
{
attxlxs.add(att);
system.debug('Attachment==='+attxlxs);
}
}

}
if(parentCaseObj.Status == 'Accettato')
{
System.debug('testdate---');
Datetime fieldDate;
Datetime attachDate;
List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC Limit 1];
for(CaseHistory ch:csh)
{
System.debug('testdate---1');
fieldDate=ch.createdDate;
}

for(Attachment ah:ash)
{
System.debug('testdate---2');
attachDate=ah.createdDate;
}
If(fieldDate<attachDate) {
System.debug('testdate---3'+fieldDate);
System.debug('testdate---3'+attachDate);
ordine=true;
}
}
if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
{
parentfile = true;
}
if( parentCaseObj.PO_isDataOrder__c ==true)
{
ordine =false;
}
}
}
if(parentId !=NULL && childcaseList.size()==0) {

parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
system.debug('entering========'+parentCaseObj);
ChildCases = childcaseList;
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}

system.debug('ChildCases===='+parentCaseObj.status);
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);

//  ParentDate=parentCaseobj.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
//  system.debug('CreatedDate====='+ParentDate);
//   system.debug('parentCaseObj====='+parentCaseObj);
//   pagereference redirectparentcasedetailpgref = new pagereference('/apex/Po_FeasibilityServicesRequest2?id='+caseid );
//   return  redirectparentcasedetailpgref;

}

//To do Crea metodo con searchLogBoolean al posto di searchCaseBoolean  Log e non per Case
public pagereference  redirectparentcasedetailNew()
{
//ParentDate=string.valueof(parentCaseobj.CreatedDate);
searchCaseBoolean=false;
Id caseId = ApexPages.currentPage().getParameters().get('CaseDetail');
parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:caseId Limit 1];

ParentDate=parentCaseobj.CreatedDate.format('dd/MM/yyyy HH:mm:ss');
pagereference redirectparentcasedetailpgref = new pagereference('/apex/Po_FeasibilityServicesRequest6?id='+parentCaseObj.id );
return  redirectparentcasedetailpgref;
}

//To do Crea metodo con searchLogBoolean al posto di searchCaseBoolean per il log e non per Case
public  pagereference  redirectchildcasedetail()
{


Id caseid = ApexPages.currentPage().getParameters().get('CaseDetail');
childcasedisplayobj = new case();
childoppobj = new opportunity();

childcasedisplayobj = [select id,parent.id,parent.PO_Offerta__c,PO_Sito__c,PO_Indirizzo_collegamento__c,PO_Civico__c,PO_Nome_Comune__c,PO_Sito_partenza__c ,PO_Indirizzo_collegamento_partenza__c,
PO_Civico_partenza__c,PO_Tipo_percorso__c,PO_Tipo_di_collegamento__c,PO_Numero_fibre_richieste__c,PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratta_seconda_via__c ,
PO_Pop_1_di_riferimento2__c,PO_Pop_1_di_riferimento2__r.name,PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Civico_3__c,PO_Nota_sito_3__c,PO_Nome_Comune3__c,PO_Nome_Comune4__c ,PO_Pop_2_di_riferimento2__c,PO_Pop_2_di_riferimento2__r.name,casenumber,Status,PO_Prime_Contractor__c,PO_Tempi_di_attivazione_mesi__c,
PO_Disponibilit_della_rete_a_partire_da__c,Note_Sospensione_Operatore__c,PO_Offerta__c,parent.status,OwnerId      from case  where id=:childcasedisplayid];
//childDate=childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.format('dd/MM/yyyy HH:mm:ss');
//  childDate=childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c;
if(childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c != null)
{
Integer d = childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.day();
Integer mo = childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.month();
Integer yr = childcasedisplayobj.PO_Disponibilit_della_rete_a_partire_da__c.year();

DateTime DT = DateTime.newInstance(yr, mo, d);
//DateTime dtt =  datetime.newInstanace(childDate.Year(),childDate.month().childDate.day()) ;
system.debug('childDate====='+DT);
childDate = DT.format('dd/MM/yyyy');
system.debug('childDate====='+childDate);
}
childcasedisplayattlist = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: caseId
ORDER BY createddate DESC];

System.debug('@@@@ childcasedisplayattlist' + childcasedisplayattlist );

IndirizzoCliente =childcasedisplayobj.PO_Indirizzo_collegamento__c+' '+childcasedisplayobj.PO_Civico__c+', '+childcasedisplayobj.PO_Nome_Comune__c;

if(childcasedisplayobj.PO_Nome_Comune3__c != null){
IndirizzoSede1diTerminazione = childcasedisplayobj.PO_Indirizzo_collegamento_partenza__c+' '+childcasedisplayobj.PO_Civico_partenza__c +','+ childcasedisplayobj.PO_Nome_Comune3__c ;
}
if(childcasedisplayobj.PO_Nome_Comune3__c == null){
IndirizzoSede1diTerminazione = childcasedisplayobj.PO_Indirizzo_collegamento_partenza__c+' '+childcasedisplayobj.PO_Civico_partenza__c ;
}

String collegamento = childcasedisplayobj.PO_indirizzo_collegamento_3__c;
string civico = childcasedisplayobj.PO_Civico_3__c;
string comune = childcasedisplayobj.PO_Nome_Comune4__c ;
if(childcasedisplayobj.PO_indirizzo_collegamento_3__c== null)
{
collegamento ='';
}
if(childcasedisplayobj.PO_Civico_3__c== null)
{
civico ='';
}
if(childcasedisplayobj.PO_Nome_Comune4__c == null)
{
comune ='';
}

IndirizzoSede2diTerminazione = collegamento +' '+civico +','+comune ;

if(childcasedisplayobj.PO_Nome_Comune4__c == null)
{
IndirizzoSede2diTerminazione = collegamento +' '+civico ;
}


if(childcasedisplayobj.id!=null && (childcasedisplayobj.parent.status=='In approvazione Cliente' ||childcasedisplayobj.parent.status=='Accettato' )){
try{
childoppobj= [select id,PO_Totale_contributi_attivazione__c,PO_Sconto_contributi_attivazione__c,PO_Totale_contributi_attivazione_scontat__c, PO_CanoneCollegamentoScontato__c,PO_ContributoAttivazCollegamScontato__c
,PO_Costi_aggiuntivi_collegamento_scontat__c,PO_CanoneManutenzioneCollegScontato__c,PO_CorrispettivoIRUCollegamentoScontato__c
from Opportunity where PO_Collegamento__c=:childcasedisplayobj.id limit 1 ];
system.debug('parentoppobj1====='+childoppobj.PO_CanoneCollegamentoScontato__c);

}
catch(exception e)
{

system.debug('exception'+e);
}
}

pagereference Po_FeasibilityServicesRequest7pgref = new pagereference('/apex/Po_FeasibilityServicesRequest7?id='+caseid);
return  Po_FeasibilityServicesRequest7pgref;
}

public pagereference DetailPage1()
{

string attNamenew='';
string attname='';


parentcaseobj = [select id,status,CaseNumber,PO_Durata_affitto__c,OwnerId, PO_Nome_Progetto__c,PO_Offerta__c,CreatedDate,closedDate,PO_Note_Modifica_Offerta__c from case where id=:ParentCaseDisplay.id limit 1];
list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
Priority,Previous_Status__c,PO_IndrizoCal__c,OwnerId,PO_Durata_affitto__c, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
from case where parentId=:parentcaseobj.id
order by CreatedDate ASC];
if(childcaseList.size()>0)
ChildCases = childcaseList;
list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =:  parentcaseobj.id AND IsPrivate = false
ORDER BY createddate DESC limit 1];
for(attachment att : newlst )
{
attnamenew = att.Name;

if(attnamenew.contains('.pdf'))
{
newAtt.add(att);
system.debug('Attachment==='+newAtt);
}
}
list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentcaseobj.id
ORDER BY createddate DESC];
for(attachment att : attlstnew )
{
attname = att.Name;
system.debug('Attachment==='+att.Name);

system.debug('Attachment==='+attlst);
if(attname.containsIgnoreCase('.pdf'))
{
attlst.add(att);

}

}
if(attlst.size()>1)
{
attlst.remove(0);
}

list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =:  parentcaseobj.id AND IsPrivate = false
ORDER BY createddate DESC];
for(attachment att : newlstxlxs )
{
String attnamexlxs = att.Name;

if(attnamexlxs.contains('.xlsx'))
{
attxlxs.add(att);
system.debug('Attachment==='+attxlxs);
}
}
system.debug('Boolean2'+searchCaseBoolean);
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentcaseobj.id);
}

public pagereference detailparentcase()
{
if(searchCaseboolean==false){

return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+childcasedisplayobj.parentid);
}
else
{
system.debug('Boolean1'+searchCaseBoolean);
return new PageReference ('/apex/PO_index');
}
}

public PageReference SearchCase()
{
Ricerca= true;
searchCaseboolean=true;
offertaSelected='';
OffertaCheck='';

return new PageReference ('/apex/PO_SearchRequest');
}

public PageReference homePageRef()
{

searchCaseboolean=true;
// cases.clear();
return new PageReference ('/apex/PO_Index');

}

public pagereference OpportunityStageNameUpdate5()
{

inlineshow = true;
list<opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
where id in : opp limit 1
];


if(opplst.size()>0 && !opplst.isEmpty())
{

if(opplst[0].stagename == 'Offerta presentata')
{
opplst[0].StageName = 'Offerta accettata';
update opplst[0];
}

}
if(parentCaseObj != null)
{
// if( opplst[0].StageName != null)
{
// parentCaseObj.Status = 'Accettato';
// parentCaseObj.OwnerId = UserInfo.getUserId();
// parentCaseObj.PO_Durata_affitto__c=durataaff;
//   system.debug('childcaselst======='+durataaff);
}

update parentCaseObj;
list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,PO_Comune2__c,status,casenumber,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
recordtype.id,recordtype.developerName,OwnerId from case where parentid=:parentCaseObj.id and PO_Incluso_nell_offerta__c = true];

system.debug('childcaselst======='+parentCaseObj.PO_Durata_affitto__c);
if(parentCaseObj.PO_Durata_affitto__c == null && parentCaseObj.PO_Offerta__c == 'Fiber Link')
{
ApexPages.addMessage(
new ApexPages.Message(ApexPages.Severity.error,'Inserire il numero di anni di affitto di interesse, cliccando su Modifica.'));

}

else
{
if(childcaselst.size()>0)
{
OrderCreation(childcaselst);
parentfile = true;
stagename = false;

// PO_ServiziFattibilita_Controller.OrderCreation(childcaselst);
}
}


}
// return null;
Quote qt = [select id,opportunity.PO_Richiesta_fattibilit__r.id from Quote where opportunity.PO_Richiesta_fattibilit__r.id =:parentCaseObj.id limit 1];

return savePDF_FiberLinkPortal(qt.id,parentCaseObj.PO_Durata_affitto__c);

}







public boolean checkIRU {get; set;}
public boolean checkP2P {get; set;}
public boolean checkFibLink {get; set;}
public boolean checkFibLease {get; set;}
public boolean checkFibLeaseMisto {get;set;}
public boolean checkEventoTemp {get; set;}

//CRM 24_08 INIZIO
public boolean check1Anno {get;set;}
public boolean check2Anni {get;set;}
public boolean check3Anni {get;set;}
public boolean checkAltriAnni {get;set;}
public boolean CheckNumAnni {get;set;}
//FINE

public string strMese {get;set;}

public String idquote;
public quote q {set;get;}
public opportunity opp1 {get; set;}

public blob xlsxBlob;
public string xlsxname;
public string header;
public string bod;
public String finalstr{set;get;}
public boolean checkEmpty {get; set;}
public ID RichiestaFattibil {get;set;}

public string NameAttachmentXLSX{get;set;}

//   public OF_PDF_OffSediController()
//   {
//
//  }

public Opportunity getOpportunity()
{
idquote = ApexPages.currentPage().getParameters().get('id');
system.debug('DG_PDF_idquote:' + idquote);

q = [select id, name, Opportunity.name, account.name,
Account.BillingStreet,Account.BillingCity,
Account.BillingState,Account.BillingPostalCode,
PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
PO_ContaPDF__c
from Quote
where id = :idquote];
opportunity opp1 = [select id, name, recordtype.name, PO_Numero_Anni__c, PO_Richiesta_fattibilit__r.casenumber,PO_Richiesta_fattibilit__r.PO_Nome_Progetto__c,
PO_Special_Terms__c,PO_oppty_validit_offerta__c,PO_Note__c,PO_Richiesta_fattibilit__r.PO_Durata_mesi__c,
PO_Totale_Canone_Anno1_Scontato__c,PO_TotaleContributiAttivaAnno1Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontat__c,
PO_Totale_Canone_Anno2_Scontato__c,PO_TotaleContributiAttivaAnno2Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontati__c,
PO_Totale_Canone_Anno3_Scontato__c,PO_TotaleContributiAttivaAnno3Scontati__c,PO_TotaleCostiAggiuntiviAnno3Scontat__c,
PO_Totale_Canone_Altri_Anni_Scontato__c,PO_TotContributiAttivaAltriAnniScontati__c,PO_TotaleCostiAggiuntiviAltriAnnoScontat__c,
PO_Totale_canoni_scontato__c,PO_Totale_canoni_manutenzione_scontato__c,PO_Totale_corrispettivi_IRU_scontati__c,
PO_Totale_contributi_attivazione_scontat__c,PO_Totale_costi_aggiuntivi_scontati__c,
PO_Totale_scontat_valori_medi_altre_cop__c,PO_Totale_valori_medi_annui_scontato__c,PO_Totale_valori_fino_2030_scontato__c,
(select id, name,
PO_SceltaAnno1__c,PO_SceltaAnno2__c,PO_SceltaAnno3__c,PO_SceltaAltriAnni__c,
PO_Costi_aggiuntivi_collegamento_scontat__c, PO_ContributoAttivazCollegamScontato__c, PO_CanoneCollegamentoScontato__c,
PO_CorrispettivoIRUCollegamentoScontato__c,PO_CanoneManutenzioneCollegScontato__c,
PO_Totale_costi_aggiuntivi_scontati__c, PO_Totale_contributi_attivazione_scontat__c, PO_Totale_canoni_scontato__c, PO_Totale_canoni_manutenzione_scontato__c,
PO_Canone_annuo_Collegamento1anno_Scont2__c,PO_Contributo_annuo_Colleg1anno_Scontat2__c,PO_Costi_Aggiuntivi_Anno1_Scontati__c,
PO_Canone_annuo_Collegamento2anno_Scont2__c,PO_Contributo_annuo_Colleg2anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno2_Scontati__c,
PO_Canone_annuo_Collegamento3anno_Scont2__c,PO_Contributo_annuo_Colleg3anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno3_Scontati__c,
PO_Canone_annuo_altri_anni_Scontato2__c ,PO_Contributo_Attivaz_altri_anni_Scont2__c,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c,
PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c, PO_Collegamento__r.PO_Lunghezza_tratte_complessiva__c,
PO_Collegamento__r.PO_Numero_fibre_richieste__c, PO_Collegamento__r.PO_Civico__c, PO_Collegamento__r.PO_Indirizzo_collegamento__c,
PO_Collegamento__r.PO_Prime_Contractor__c, PO_Collegamento__r.PO_Nome_Comune__c,PO_Collegamento__r.PO_Sito__c,
PO_Collegamento__r.casenumber,PO_Durata_mesi__c,PO_Collegamento__r.PO_Tipo_percorso__c,
PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c,PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c,
PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name,PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.name,PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c,
PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.PO_Indirizzo__c,PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.PO_Indirizzo__c,
PO_Collegamento__r.PO_Nome_Comune3__c,PO_Collegamento__r.PO_Lunghezza_tratta_prima_via_FiberLink__c,
PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c,PO_Collegamento__r.PO_Civico_partenza__c,PO_Collegamento__r.PO_Sito_partenza__c,
PO_Valore_totale_coppia_fino_2030_sconta__c,PO_Valore_medio_annuo_altre_coppie_scont__c,PO_Valore_medio_annuo_totale_coll_scont__c,
PO_Collegamento__r.PO_Sito_3__c,PO_Collegamento__r.PO_indirizzo_collegamento_3__c,PO_Collegamento__r.PO_Nome_Comune4__c,PO_Collegamento__r.PO_Civico_3__c,
PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c
from Opportunities__r
where PO_Incluso_nell_offerta__c = true)
from Opportunity
where id =: q.OpportunityId];
system.debug('DG_PDF_getOpportunity opp: ' + opp1);

//TotPrezzi(opp);

FindOppo(opp1);

return opp1;
}

public date getdate()
{
return system.today();
}

public void FindOppo(opportunity opp)
{
checkIRU = false;
checkP2P = false;
checkFibLink = false;
checkFibLease = false;
checkEventoTemp = false;
checkFibLeaseMisto = false;

if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità IRU')
{
checkIRU = true;
}else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità')
{
checkP2P = true;
}else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Fiber Link')
{
checkFibLink = true;

if(opp.PO_Numero_Anni__c != null)
CheckNumAnni = true;
else
CheckNumAnni = false;
}else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Evento Temporaneo')
{
checkEventoTemp = true;
if(opp.PO_Richiesta_fattibilit__r.PO_Durata_mesi__c == 1)
strMese = 'mese';
else
strMese = 'mesi';
}else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Fiber Lease')
{
system.debug('OF_PDF_OffSediController_FindOppo dentro fiber lease');
checkFibLease = true;
}else if(opp.RecordType.name == 'PO Oppty richiesta fattibilità Misto Lease-Link per FW')
{
system.debug('OF_PDF_OffSediController_FindOppo dentro fiber lease misto');
checkFibLeaseMisto = true;
}
}
//CRM 24_08 INIZIO
public void FindAnnoFiberLink()
{   system.debug('Quote Selected'+ApexPages.currentPage().getParameters().get('Duratta'));
Integer duratta=Integer.valueOF(ApexPages.currentPage().getParameters().get('Duratta'));
check1Anno = false;
check2Anni = false;
check3Anni = false;
checkAltriAnni = false;


if( duratta > 3 )
{
checkAltriAnni = true;
}else{

if( duratta == 1 )
{
check1Anno = true;
}else if( duratta == 2 )
{
check2Anni = true;
}else if( duratta == 3 )
{
check3Anni = true;
}
}
system.debug('FindAnnoFiberLink check1Anno:'+check1Anno+'-check2Anni:'+check2Anni+'-check3Anni:'+check3Anni+'-checkAltriAnni:'+checkAltriAnni);
}
//FINE

public PageReference savePDF() {
PageReference thePDF = Page.OF_PDF_OffSedi;
thePDF.getParameters().put('id',q.Id);
thePDF.setRedirect(true);

quotedocument qd = new quotedocument();
if( Test.isRunningTest())
{
qd.document = blob.toPdf('test');
}else{
qd.document = thePDF.getContentAsPDF();
}
qd.quoteId = q.Id;
insert qd;

if(q.PO_ContaPDF__c == null)
q.PO_ContaPDF__c = 0;

q.PO_ContaPDF__c ++;
update q;

//Modifico il file aggiungendo nel title l'estensione .pdf
ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
//ContDoc.Title = ContDoc.Title + '.pdf';
ContDoc.Title = q.name + ' _ ' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '_' + q.PO_ContaPDF__c + '.pdf';
update ContDoc;

NameAttachmentXLSX = q.name + ' _ ' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '_' + q.PO_ContaPDF__c + '.xlsx';

PageReference quotePage = new PageReference('/'+ q.Id);
quotePage.setRedirect(true);
return null;
}

public PageReference ToReturn() {
PageReference quotePage = new PageReference('/'+ q.Id);
quotePage.setRedirect(true);
return quotePage;
}

//CRM 24/08/2017 INIZIO
public PageReference savePDF_FiberLink()
{
idquote = ApexPages.currentPage().getParameters().get('id');
system.debug('DG_PDF_idquote:' + idquote);

q = [select id, name, Opportunity.name, account.name,
Account.BillingStreet,Account.BillingCity,
Account.BillingState,Account.BillingPostalCode,
PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
PO_ContaPDF__c
from Quote
where id = :idquote];
PageReference thePDF = Page.OF_PDF_FiberLink;
thePDF.getParameters().put('id',q.Id);

thePDF.setRedirect(true);

quotedocument qd = new quotedocument();

if( Test.isRunningTest())
{
qd.document = blob.toPdf('test');
}else{
qd.document = thePDF.getContentAsPDF();
}
//qd.document = thePDF.getContentAsPDF();
qd.quoteId = q.Id;
insert qd;

//Modifico il file aggiungendo nel title l'estensione .pdf
ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
//ContDoc.Title = ContDoc.Title + '.pdf';
ContDoc.Title = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.pdf';
update ContDoc;

NameAttachmentXLSX = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.xlsx';

PageReference quotePage = new PageReference('/'+ q.Id);
quotePage.setRedirect(true);
return quotePage;
// return new pagereference ('/apex/PO_SearchRequest');


}
//24/08/2017 FINE
public PageReference savePDF_FiberLinkPortal(id idquote,Decimal Duratta)
{
//idquote = ApexPages.currentPage().getParameters().get('id');
system.debug('DG_PDF_idquote:' + idquote);
List<quotedocument> qdList = new List<quotedocument>();
Boolean qdInserted;
q = [select id, name, Opportunity.name, account.name,
Account.BillingStreet,Account.BillingCity,
Account.BillingState,Account.BillingPostalCode,
PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
PO_ContaPDF__c
from Quote
where id = :idquote];

check1Anno = false;
check2Anni = false;
check3Anni = false;
checkAltriAnni = false;

system.debug('Duratta Selected'+ q.PO_Durata_affitto__c);
if( Duratta > 3 )
{
checkAltriAnni = true;
}else{

if( Duratta == 1 )
{
check1Anno = true;
}else if(Duratta == 2 )
{
check2Anni = true;
}else if( Duratta == 3 )
{
check3Anni = true;
}
}
system.debug('FindAnnoFiberLink check1Anno:'+check1Anno+'-check2Anni:'+check2Anni+'-check3Anni:'+check3Anni+'-checkAltriAnni:'+checkAltriAnni);


//PageReference thePDF = Page.OF_PDF_FiberLink;
PageReference thePDF = Page.PO_FiberLinkPDF;
thePDF.getParameters().put('id',q.id);
thePDF.getParameters().put('duratta',string.valueOF(Duratta));
thePDF.setRedirect(true);
system.debug('Quoteid============='+q.id);


quotedocument qd = new quotedocument();
if( Test.isRunningTest())
{
qd.document = blob.toPdf('test');
}else{
try{
qd.document = thePDF.getContent();
}
Catch(exception e)
{
system.debug('Exception'+e);
}
}
// qd.document = thePDF.getContentAsPDF();
//qd.document = blob.toPdf('test');
qd.quoteId = q.Id;
qdList.add(qd);
Database.SaveResult[] srList = Database.insert(qdList, false);
for (Database.SaveResult sr : srList) {
if (sr.isSuccess()) {
qdInserted=true;
}
}
system.debug('Quote Document============='+qd);
PageReference thePDF1 = Page.PO_FiberLinkPDF;
thePDF1.getParameters().put('id',q.Id);
//Modifico il file aggiungendo nel title l'estensione .pdf
ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
//ContDoc.Title = ContDoc.Title + '.pdf';
ContDoc.Title = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.pdf';
update ContDoc;

NameAttachmentXLSX = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.xlsx';
Quote qt = [select id,opportunity.PO_Richiesta_fattibilit__r.id from Quote where id =:q.id limit 1];
// PageReference quotePage = new PageReference('/apex/Po_FeasibilityServicesRequest2?id='+ qt.opportunity.PO_Richiesta_fattibilit__r.id);
//return quotePage;
parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:qt.opportunity.PO_Richiesta_fattibilit__r.id Limit 1];
parentCaseObj.OwnerId = UserInfo.getUserId();
update parentCaseObj;
if(qdInserted==true){
parentCaseObj.Status='Accettato';
update parentCaseObj;
}
system.debug('parentCaseObj====='+parentCaseObj);
return redirectparentcasedetailpdf(parentCaseObj.id,qd.id);
}
//Tabella dell'offerta totale della fiber link
public string Tabella1FiberLink(opportunity opp)
{
system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1FiberLink 1');


if(CheckNumAnni == true)
{
header = '\tAffitto 1 anno\tAffitto 2 Anni\tAffitto 3 Anni\tAffitto '+ opp.PO_Numero_Anni__c + 'Anni<br/>';
bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_Canone_Anno1_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno2_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno3_Scontato__c + '\t' + opp.PO_Totale_Canone_Altri_Anni_Scontato__c + '<br/>'
+ 'Contributo di attivazione' + '\t' + opp.PO_TotaleContributiAttivaAnno1Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno2Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno3Scontati__c + '\t' + opp.PO_TotContributiAttivaAltriAnniScontati__c + '<br/>'
+ 'Costi Aggiuntivi' + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontati__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno3Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAltriAnnoScontat__c + '<br/>';
}
else{
header = '\tAffitto 1 anno\tAffitto 2 Anni\tAffitto 3 Anni <br/>';
bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_Canone_Anno1_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno2_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno3_Scontato__c + '<br/>'
+ 'Contributo di attivazione' + '\t' + opp.PO_TotaleContributiAttivaAnno1Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno2Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno3Scontati__c + '<br/>'
+ 'Costi Aggiuntivi' + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontati__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno3Scontat__c + '<br/>';
}

system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1FiberLink 2 bod: ' + bod);
return bod;
}
//Tabella dell'offerta totale dell'IRU
public string Tabella1IRU(opportunity opp)
{
system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);

header = 'Tipologia costo\tCosto <br/>';
bod = header + 'Canone Manutenzione Annuo' + '\t' + opp.PO_Totale_canoni_manutenzione_scontato__c + '<br/>'
+ 'Corrispettivi IRU' + '\t' + opp.PO_Totale_corrispettivi_IRU_scontati__c + '<br/>'
+ 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
+ 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';

system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);

return bod;
}
//Tabella dell'offerta totale della P2P e Evento Temporaneo
public string Tabella1P2P(opportunity opp)
{
system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);

header = 'Tipologia costo\tCosto <br/>';
bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>'
+ 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
+ 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';

system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);

return bod;
}
//Tabella dell'offerta totale della Fiber Lease
public string Tabella1FiberLease(opportunity opp)
{
system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);

header = 'Tipologia costo\tCosto <br/>';
bod = header + 'Totale costi aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>'
+ 'Totale valori medi altre coppie' + '\t' + opp.PO_Totale_scontat_valori_medi_altre_cop__c + '<br/>'
+ 'Totale valori medi annui' + '\t' + opp.PO_Totale_valori_medi_annui_scontato__c + '<br/>'
+ 'Totale valori fino 2030' + '\t' + opp.PO_Totale_valori_fino_2030_scontato__c + '<br/>';

system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);

return bod;
}
//Tabella dell'offerta totale della Fiber Lease Misto
public string Tabella1FiberLeaseMisto(opportunity opp)
{
system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);

header = 'Tipologia costo\tCosto <br/>';
bod = header + 'Totale costi aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>'
+ 'Totale valori medi altre coppie' + '\t' + opp.PO_Totale_scontat_valori_medi_altre_cop__c + '<br/>'
+ 'Totale valori medi annui' + '\t' + opp.PO_Totale_valori_medi_annui_scontato__c + '<br/>'
+ 'Totale valori fino 2030' + '\t' + opp.PO_Totale_valori_fino_2030_scontato__c + '<br/>'
+ 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>'
+ 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>';

system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);

return bod;
}
//Tabella dati toponomastici dei collegamenti
public string TabellaDatiToponomastici(opportunity opp)
{
bod = null;
header = null;
list<opportunity> OppCollList = opp.Opportunities__r;

system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);

if(checkP2P || checkEventoTemp)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente <br/>';
}else
if(checkFibLink)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione\tSede 2 di terminazione\tIndirizzo Sede 2 di terminazione <br/>';
}else
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione <br/>';
}

system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);

//Ciclo sulle opportunity collegamento
for(opportunity OppCol : OppCollList)
{
string StringTopon = null;

StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c;

if(checkP2P || checkEventoTemp)
{
StringTopon =   StringTopon + '<br/>';
}else
if(checkFibLink)
{
StringTopon =   StringTopon + '\t' +
OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' +
OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' +
OppCol.PO_Collegamento__r.PO_Sito_3__c + '\t' +
OppCol.PO_Collegamento__r.PO_indirizzo_collegamento_3__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_3__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune4__c +
'<br/>';
}else
{
StringTopon =   StringTopon + '\t' +
OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' +
OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' +
'<br/>';
}
if(bod == null)
bod = StringTopon;
else
bod = bod + StringTopon;

}
return header + bod;
}
//Tabella dati metrici dei collegamenti
public string TabellaDatiMetrici(opportunity opp)
{
bod = null;
header = null;
list<opportunity> OppCollList = opp.Opportunities__r;

system.debug('DG_OF_CreateQuoteXLS_Controller_TabellaDatiMetrici header: ' + header);

if(checkP2P ||checkEventoTemp)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tPop 1 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';

}else if(checkFibLink || checkIRU)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
}else
if(checkFibLease || checkFibLeaseMisto)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tPop 1 di riferimento\tPop 2 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
}

system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);

//Ciclo sulle opportunity collegamento
for(opportunity OppCol : OppCollList)
{
string StringTopon = null;

StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t' +
OppCol.PO_Collegamento__r.PO_Tipo_percorso__c + '\t' +
OppCol.PO_Collegamento__r.PO_Numero_fibre_richieste__c + '\t';

if(checkP2P ||checkEventoTemp)
{
StringTopon =   StringTopon +
OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' +
OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
'<br/>';
}else
if(checkFibLink || checkIRU)
{

StringTopon =   StringTopon +
OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c + '\t' +
OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
'<br/>';
}else
if(checkFibLease || checkFibLeaseMisto)
{
StringTopon =   StringTopon +
OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via_FiberLink__c + '\t' +
OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c + '\t' +
OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' +
OppCol.PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.name + '\t' +
OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
'<br/>';
}
if(bod == null)
bod = StringTopon;
else
bod = bod + StringTopon;

}
return header + bod;
}
//Tabella Dettaglio offerta dei collegamenti
public string TabellaDettaglioOfferta(opportunity opp)
{
bod = null;
header = null;
list<opportunity> OppCollList = opp.Opportunities__r;

if(checkP2P ||checkEventoTemp)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone (euro) Anno\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
}else
if(checkIRU)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone Manutenzione (euro) Anno\tCorrispettivo IRU (euro)\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
}else
if(checkFibLink)
{
if(CheckNumAnni == true)
{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo aggi. 3 anni (euro)\t'+
'Canone affitto '+opp.PO_Numero_Anni__c+' anni (euro/anno)\tContributo di attivazione '+opp.PO_Numero_Anni__c+' anni (euro)\tContributo aggi. '+opp.PO_Numero_Anni__c+' anni (euro)<br/>';

}
else{
header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo aggi. 3 anni (euro)<br/>';
}
}
system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);

//Ciclo sulle opportunity collegamento
for(opportunity OppCol : OppCollList)
{
string StringTopon = null;

StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t';

if(checkP2P ||checkEventoTemp)
{
StringTopon =   StringTopon +
OppCol.PO_CanoneCollegamentoScontato__c + '\t' +
OppCol.PO_ContributoAttivazCollegamScontato__c + '\t' +
OppCol.PO_Costi_aggiuntivi_collegamento_scontat__c +
'<br/>';
}else
if(checkFibLink)
{
if(CheckNumAnni == true)
{
StringTopon =   StringTopon +
OppCol.PO_Canone_annuo_Collegamento1anno_Scont2__c + '\t' +
OppCol.PO_Contributo_annuo_Colleg1anno_Scontat2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Anno1_Scontati__c + '\t' +
OppCol.PO_Canone_annuo_Collegamento2anno_Scont2__c + '\t' +
OppCol.PO_Contributo_annuo_Colleg2anni_Scontat2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Anno2_Scontati__c + '\t' +
OppCol.PO_Canone_annuo_Collegamento3anno_Scont2__c + '\t' +
OppCol.PO_Contributo_annuo_Colleg3anni_Scontat2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Anno3_Scontati__c + '\t' +
OppCol.PO_Canone_annuo_altri_anni_Scontato2__c + '\t' +
OppCol.PO_Contributo_Attivaz_altri_anni_Scont2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c +
'<br/>';
}else{
StringTopon =   StringTopon +
OppCol.PO_Canone_annuo_Collegamento1anno_Scont2__c + '\t' +
OppCol.PO_Contributo_annuo_Colleg1anno_Scontat2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Anno1_Scontati__c + '\t' +
OppCol.PO_Canone_annuo_Collegamento2anno_Scont2__c + '\t' +
OppCol.PO_Contributo_annuo_Colleg2anni_Scontat2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Anno2_Scontati__c + '\t' +
OppCol.PO_Canone_annuo_Collegamento3anno_Scont2__c + '\t' +
OppCol.PO_Contributo_annuo_Colleg3anni_Scontat2__c + '\t' +
OppCol.PO_Costi_Aggiuntivi_Anno3_Scontati__c +
'<br/>';
}
}else
if(checkIRU)
{
StringTopon =   StringTopon +
OppCol.PO_CanoneManutenzioneCollegScontato__c + '\t' +
OppCol.PO_CorrispettivoIRUCollegamentoScontato__c + '\t' +
OppCol.PO_ContributoAttivazCollegamScontato__c + '\t' +
OppCol.PO_Costi_aggiuntivi_collegamento_scontat__c +
'<br/>';
}
if(bod == null)
bod = StringTopon;
else
bod = bod + StringTopon;

}
return header + bod;
}


public pagereference  redirectparentcasedetailPDF(id caseID,ID qdId)
{
selectedIdComune = '';
selectedIdComune1 = '';
selectedIdComune2 = '';

string attNamenew='';
string attname='';

newAtt.clear();
attxlxs.clear();
searchCaseBoolean=false;
attlst.clear();
parentfile = false;
Ordine = false;
stagename = false;
Id parentId = CaseId;
string prid = parentId;
system.debug('prid===='+prid);
system.debug('parentId===='+parentId);
parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:caseID Limit 1];
system.debug('parentCaseObj===='+parentCaseObj);
list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
from case where (parentId=:parentId OR parentId=:prid)
order by CreatedDate ASC];
if(childcaseList.size()>0)
ChildCases = childcaseList;
system.debug('ChildCases====='+ChildCases);
if(childcaseList.size()>0){


if(parentId !=NULL) {
parentCaseObj = [SELECT CaseNumber, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];



opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];


if(opp.size()>0 && !opp.isEmpty())
{
if(opp[0].PO_Prezzo_totale_scontato__c != null)
{
Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
}

if(opp[0].stagename=='Offerta presentata')
{
stagename = true;
}
}

if(parentid != null)
{


// attlst = attlstnew;
list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false AND Name LIKE '%PDF%'
ORDER BY createddate DESC limit 1];
for(attachment att : newlst )
{
attnamenew = att.Name;

if(attnamenew.contains('.pdf'))
{
newAtt.add(att);
system.debug('Attachment==='+newAtt);
}
}
list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
ORDER BY createddate DESC];
for(attachment att : attlstnew )
{
attname = att.Name;
system.debug('Attachment==='+att.Name);
// if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))

if(attname.containsIgnoreCase('.pdf'))
{
attlst.add(att);
system.debug('Attachment==='+attlst);
}
}
if(attlst.size()>1)
{
attlst.remove(0);
}

list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC];
for(attachment att : newlstxlxs )
{
String attnamexlxs = att.Name;

if(attnamexlxs.contains('.xlsx'))
{
attxlxs.add(att);
system.debug('Attachment==='+attxlxs);
}
}

}
if(parentCaseObj.Status == 'Accettato')
{
System.debug('testdate---');
Datetime fieldDate;
Datetime attachDate;
datetime qdDate;
List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
ORDER BY createddate DESC Limit 1];
List<QuoteDocument> qdlist=[select id,createddate from QuoteDocument where id=:qdid ORDER BY createddate DESC Limit 1];
for(CaseHistory ch:csh)
{
System.debug('testdate---1');
fieldDate=ch.createdDate;
}

for(Attachment ah:ash)
{
System.debug('testdate---2');
attachDate=ah.createdDate;
}
If(fieldDate<attachDate) {
System.debug('testdate---3'+fieldDate);
System.debug('testdate---3'+attachDate);

// ordine=true;
}

if(parentCaseObj.PO_Offerta__c == 'Fiber Link')
{
for(quoteDocument ah:qdList)
{
System.debug('testdate---2');
qdDate=ah.createdDate;
}
If(fieldDate>qdDate) {
System.debug('testdate---3'+fieldDate);
System.debug('testdate---3'+attachDate);

ordine=true;
}
}
}
if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
{
parentfile = true;
}
if( parentCaseObj.PO_isDataOrder__c ==true)
{
ordine =false;
}
}

}
if(parentId !=NULL && childcaseList.size()==0) {
parentCaseObj = [SELECT CaseNumber, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
system.debug('entering========'+parentCaseObj);
ChildCases = childcaseList;
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentCaseObj.id);
}

system.debug('OutsideLoop===='+parentId);
return new pagereference ('/apex/Po_FeasibilityServicesRequest2?id='+parentId);
}
8
public String IdScelta{get;set;}

//PG - 11-04 - SEGNALAZIONE PROVISIONING - START
public pageReference viewStatoOrdine()
{
PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
pg.getParameters().put('proc','TPVisualizza');
pg.getParameters().put('origId',IdScelta);
return pg;
}
//PG - 11-04 - SEGNALAZIONE PROVISIONING - END

//PG - 03-05 - INCIDENT MANAGEMENT - START
public pageReference viewDettaglioIncident()
{
PageReference pg = new PageReference('/PO_TP_InsertNewRequest');
pg.getParameters().put('proc','TPVisualizzaIncident');
pg.getParameters().put('origId',IdScelta);
return pg;
}
//PG - 03-05 - INCIDENT MANAGEMENT - END

public PageReference ViewCaseDettail()
{
PageReference pg = new PageReference('/PO_TT_InsertNewRequest');
pg.getParameters().put('proc','TTVisualizza');
pg.getParameters().put('origId',IdScelta);
return pg;
}

public String tipoRichiestaOP{get;set;}
public String IdInserita{get;set;}

public pageReference vediReq(){
//AA Modifica per gestione pagina dettaglio Change Order
if(tipoRichiestaOP.equalsIgnoreCase('Change Order')){
Pagereference pg = new Pagereference('/PO_CO_DetailChangeOrder');
pg.getParameters().put('idRisorsa',IdInserita);
return pg;
}
Pagereference pg = new Pagereference('/PO_OpenStreamService_InsertNewRequest');
if(tipoRIchiestaOP=='Attivazione'){
pg.getParameters().put('proc','attivazioneInoltrata');
}
if(tipoRIchiestaOP=='Cessazione'){
pg.getParameters().put('proc','cessazioneInoltrata');
}
pg.getParameters().put('origID',IdInserita);
return pg;
}

//EC - 2018 - 05 - 21 Start CHANGEORDER

public pagereference ServizioChangeOrder(){
pagereference pr = new pagereference('/apex/PO_ChangeOrder_InsertNewRequest');
pr.setRedirect(true);
return pr;
}


//EC 2018 - 05 - 21 END
//EC 2018 - 05 - 21
//public string rtAsset{get;set;}
//public List<Asset> assetViewList {get; set;}
public List<OF_CommercialElementIstanziato__c> getInfoPort(string rtAsset){
ceiViewList = [select Id, OF_Case__r.ID, OF_Case__r.EOF_CODICE_ORDINE_OLO__c,
OF_Case__r.CaseNumber, OF_Case__r.Status, OF_Case__r.EOF_Identificativo_del_POP__c,
OF_Case__r.EOF_GPON_Attestazione__c, OF_Case__r.EOF_Id_Risorsa__c, OF_Case__r.CreatedDate,
OF_Case__r.OF_SA_ID_Servizio__c, OF_Case__r.OF_SA_Profilo__c, OF_ProfiloVLAN__c,
OF_SA_CPE__c, OF_ServiceVLAN__c, OF_UserVLAN__c, OF_CustomerVLAN__c,
OF_Asset__c, OF_Asset__r.Name, OF_Asset__r.recordTypeId,
OF_Asset__r.recordtype.developerName, OF_Asset__r.OF_DataAttivazione2__c,
OF_Asset__r.OF_Stato__c, OF_Asset__r.OF_ProfiloOpenStream__c,
OF_Asset__r.OF_DataCessazione2__c
from OF_CommercialElementIstanziato__c WHERE OF_Asset__r.recordtype.developerName =: rtAsset];
return ceiViewList;
}
//EC 2018 - 05 - 22 END
*/
    //EC Start P2P Attiva as OpenStream searchProfile method
    
    
    //EC end P2P attiva as OpenStream searchProfile method
    /*


//EC Start metodo scegliTipoRichiesta P2PAttiva

public void scegliTipoReq(){
//tipiReq = new List<String>();    
requestOptions= new List<SelectOption>();
requestOptions.add(new SelectOption('ATT','Ordine di Attivazione'));
requestOptions.add(new SelectOption('CESS','Ordine di Cessazione'));
//  optScelta=SelectOption.getLabel();
}

//EC start 2018 - 07 - 17 
//in base al tipo di richiesta selezionato  inserire un parameter

public Pagereference toP2PAttiva(){
//Add parameters getParameters().put('key', 'value') 
PageReference pageRef = new PageReference('/apex/PO_P2PAttiva_Req');
System.debug('EC @@@@@@il valore di requestSelected è ' + requestSelected);
if(requestSelected=='ATT'){

pageref.getParameters().put('P2PattAttivazione','P2PattAttivazione');
system.debug('@@@@nel metodo toP2PAttiva nell\'if della richiesta di attivazione, pageRef vale ' + pageRef);

}
if(requestSelected=='Cessazione'){
pageref.getParameters().put('P2PattCessazione','P2PattCessazione');
system.debug('@@@@nel metodo toP2PAttiva nell\'if della richiesta di cessazione, pageRef vale ' + pageRef);
}

pageRef.setRedirect(true);
system.debug('@@@@nel metodo toP2PAttiva, pageRef vale alla fine ' + pageRef);
return pageref;
}
//EC end 2018 - 07 - 17

//start EC 2018 - 07 - 20 P2P Attiva metodo per la creazione del Log
public EOF_EAI_Service_Log__c creaSlP2PAttivaPadre(){
P2PAttivaLogPadre = new EOF_EAI_Service_Log__c (); 

insert P2PAttivaLogPadre;
return P2PAttivaLogPadre;


}

public EOF_EAI_Service_Log__c creaSlP2PAttivafiglio(EOF_EAI_Service_Log__c P2PAttivaLogPadre){

P2PAttivaLog = new EOF_EAI_Service_Log__c ();

insert P2PAttivaLog;
return P2PAttivaLog;

}

*/        //End EC 2018 - 07 - 20 P2P Attiva metodo per la creazione del Log
//Commented fake method on 25012019 as suggested by Pietro
  
}