public class OF_AttivazManualeBEController {

    //Riempimento ListBox
    public List<selectoption> listBE = new List<selectoption>();
    
    //Dati per il costruttore
    public Asset ass{public get;public set;}
    public PriceBookEntry BEToInsert {public get;public set;}
    public list<pricebookentry> PBEPresenti = new list<pricebookentry>();
    public list<OF_Listino__c> Listini = new list<OF_Listino__c>();
    map<id,OF_Listino__c> ListiniMap = new map<id,OF_Listino__c>();
    public map<id, string> ProductEsist = new map<id, string>();
    public Set<String> setProdEsist = new Set<String>();
    
    public set<id> ListiniID = new set<id>();
    
    //Nomi dei recordtype dell'asset
    public static string servattivi = 'Open Stream';
    public static string servpassivi = 'GPON Passiva';
    public static string servintavuoto = 'Intervento a vuoto';
    public static string servverticale = 'Verticale';
    
    //Dati per la creazione della pricebookentry
    public product2 prod = new product2();
    public list<pricebook2> pricebList = new list<pricebook2>();
    public order ord = new order();
    
    //Dati per la creazione del commercial element istanziato
    list<OF_CommercialElementIStanziato__c> CommEleIst = new list<OF_CommercialElementIStanziato__c>();
    map<string,id> CommElemName = new map<string,id>();
    public OF_CommercialELement__c cmx1 {public get;public set;}
     
    //Valore selezionato nella listBox
    public String BEIst{get;set;}
    
    //Id dell'asset di partenza
    public id idAsset;
    
    //Booleano che serve per disabilitare il bottone del salvataggio se non ci sono BE da istanziare
    public boolean savecheck{get;set;}
    
    //Costruttore
    public OF_AttivazManualeBEController(){
         //Get id dell'asset di partenza
         idAsset = ApexPages.currentPage().getParameters().get('id');
         system.debug('DG_OF_AttivazManualeBEController - idAsset: ' + idAsset);
         
         savecheck = false;
        
         //Query sull'asset considerato
         ass = [select id, name, recordtype.name, OF_Contract__c, EOF_ID_Risorsa__c, OF_TipoDiProcesso__c,OF_OrdineID__c, OF_IDCaseAttivazione__c from asset where id =: idAsset];
         system.debug('DG_OF_AttivazManualeBEController - ass: ' + ass);
         
         //Vengono selezionati tutti i listini che hanno il contratto presente sull'asset (solo i BE che fanno parte di un listino possono essere istanziati)
         Listini = [select id, name, OF_ListinoDefault__c from OF_Listino__c where OF_IDContract__c =: ass.OF_Contract__c and OF_Attivo__c = true];
         system.debug('DG_OF_AttivazManualeBEController - Listini: ' + Listini);
         
         if(Listini.size() == 0){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Listini attivi configurati per il contratto: ' + ass.OF_Contract__c);
             ApexPages.addMessage(myMsg);
             savecheck = true;
             return;
         }
         
         for(OF_Listino__c lis : Listini){
            ListiniID.add(lis.id);
            ListiniMap.put(lis.id, lis);
         }
         system.debug('DG_OF_AttivazManualeBEController - ListiniID: ' + ListiniID);
         
         //Pricebookentry già associate al caso
         PBEPresenti = [select id, name, Product2Id, Product2.name, Pricebook2Id, Pricebook2.name from pricebookentry where OF_Asset__c =: idAsset];
         system.debug('DG_OF_AttivazManualeBEController - PBEPresenti: ' + PBEPresenti);
         
         for(pricebookentry pbe : PBEPresenti){
            ProductEsist.put(pbe.Product2.id, pbe.Product2.name);
            setProdEsist.add(pbe.Product2.name);
         }
         system.debug('DG_OF_AttivazManualeBEController - ProductEsist: ' + ProductEsist);
         
         //Set dei name dei product già associati all'asset
         //Se un product è già associato all'asset quelli con lo stesso nome (associati a listini diversi) non saranno visualizzati nella selectoption
         system.debug('DG_OF_AttivazManualeBEController - setProdEsist: ' + setProdEsist);
         system.debug('DG_OF_AttivazManualeBEController - ProductEsist.values(): ' + ProductEsist.values());
            
         //Billing Element che verrà istanziato
         BEToInsert = new PriceBookEntry();
    }
    
    //Metodo che ritorna il nome del servizio a partire dal recordtype dell'asset
    public static string serviziorichiestoCE(asset ass){
        if(ass.RecordType.name == servpassivi){return 'GPON Passiva';
        }else if(ass.RecordType.name == servattivi){return 'Open Stream';
        }else if(ass.RecordType.name == servintavuoto){return 'Extra';
        }else if(ass.RecordType.name == servverticale){ return 'Extra';
        }
        return null;
    }
    
    //Popolamento della listbox
    public List<selectoption> getBE()
    {
        listBE.clear();
        //Gestione servizi attivi e passivi - il filtro va fatto sul servizio. Il recordtype dell'asset corrisponde al servizio a catalogo
        if((ass.RecordType.name == servattivi) || (ass.RecordType.name == servpassivi)) {
            List<product2> agrRes = [select id, name, OF_Servizio__c, OF_ListinoCustom__c from product2 where OF_ListinoCustom__c IN: ListiniID and OF_Servizio__c =: ass.RecordType.name ORDER BY name];
            system.debug('DG_OF_AttivazManualeBEController - agrRes: ' + agrRes);
            
            listBE.add(new selectoption('--Seleziona Billing Element--','--Seleziona Billing Element--'));
            
            if( agrRes != null && agrRes.size()>0)
            {
                for( product2 a : agrRes )
                {
                    system.debug('DG_OF_AttivazManualeBEController - a.name: ' + a.name);
                    //system.debug('DG_OF_AttivazManualeBEController - setProdEsist: ' + setProdEsist);
                    //Se il product non è già presente sotto l'asset lo aggiungo nella select option
                    if(ProductEsist.get(a.id) == null && !setProdEsist.contains(a.name)){
                        String x = (String)a.get('Name');
                        //Inserito l'id perchè in fase di salvataggio viene preso questo ID per fare delle query
                        listBE.add(new selectoption(a.id,x + ' --- Listino: ' + ListiniMap.get(a.OF_ListinoCustom__c).name));
                    }
                }
                system.debug('DG_OF_AttivazManualeBEController - listBE: ' + listBE);
                if(listBE.size() > 1){
                    return listBE;
                }else{
                     system.debug('DG_OF_AttivazManualeBEController - agrRes.size(): ' + agrRes.size());
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Billing Element da associare!');
                    ApexPages.addMessage(myMsg);
                    savecheck = true;
                    return listBE;
                }
            }else{
                system.debug('DG_OF_AttivazManualeBEController - agrRes.size(): ' + agrRes.size());
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Billing Element da istanziare!');
                ApexPages.addMessage(myMsg);
                savecheck = true;
                return listBE;
            }
        }//Gestione servizi extra Intervento a Vuoto - il filtro va fatto sul commercial element. Il recordtype dell'asset corrisponde al commercial element a catalogo
        else if(ass.RecordType.name == servverticale) {
            List<product2> agrRes = [select id, name, OF_Servizio__c, OF_ListinoCustom__c from product2 where OF_ListinoCustom__c IN: ListiniID and OF_CommercialElement__c =: ass.RecordType.name ORDER BY name desc];
            system.debug('DG_OF_AttivazManualeBEController - agrRes: ' + agrRes);
            
            listBE.add(new selectoption('--Seleziona Billing Element--','--Seleziona Billing Element--'));
          
            if( agrRes != null && agrRes.size()>0)
            {
                for( product2 a : agrRes )
                {
                    //Se il product non è già presente sotto l'asset lo aggiungo nella select option
                    if(ProductEsist.get(a.id) == null  && !setProdEsist.contains(a.name)){
                        String x = (String)a.get('Name');
                        //Inserito l'id perchè in fase di salvataggio viene preso questo ID per fare delle query
                        listBE.add(new selectoption(a.id,x + ' --- Listino: ' + ListiniMap.get(a.OF_ListinoCustom__c).name));
                    }
                }
                system.debug('DG_OF_AttivazManualeBEController - listBE: ' + listBE);
                if(listBE.size() > 1){
                    return listBE;
                }else{
                    system.debug('DG_OF_AttivazManualeBEController - agrRes.size(): ' + agrRes.size());
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Billing Element da istanziare!');
                    ApexPages.addMessage(myMsg);
                    savecheck = true;
                    return listBE;
                }
            }else{
                system.debug('DG_OF_AttivazManualeBEController - agrRes.size(): ' + agrRes.size());
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Billing Element da istanziare!');
                ApexPages.addMessage(myMsg);
                savecheck = true;
                return listBE;
            }
        }//Gestione servizi extra Intervento a Vuoto - il filtro va fatto sul commercial element. Il recordtype dell'asset corrisponde al commercial element a catalogo
        else if(ass.RecordType.name == servintavuoto){  
            List<product2> agrRes = [select id, name, OF_Servizio__c, OF_ListinoCustom__c from product2 where OF_ListinoCustom__c IN: ListiniID and OF_CommercialElement__c =: ass.RecordType.name ORDER BY name desc];
            system.debug('DG_OF_AttivazManualeBEController - agrRes: ' + agrRes);
            
            listBE.add(new selectoption('--Seleziona Billing Element--','--Seleziona Billing Element--'));
          
            if( agrRes != null && agrRes.size()>0)
            {
                for( product2 a : agrRes )
                {
                    //Se il product non è già presente sotto l'asset lo aggiungo nella select option
                    //Filtraggio sul tipo di processo presente sull'asset --> OF_TipoDiProcesso__c è un campo obbligatorio dell'asset di tipo intervento a vuoto, quindi non potrà mai essere = null
                    if(ProductEsist.get(a.id) == null && a.name.contains(ass.OF_TipoDiProcesso__c)){
                        String x = (String)a.get('Name');
                        //Inserito l'id perchè in fase di salvataggio viene preso questo ID per fare delle query
                        listBE.add(new selectoption(a.id,x + ' --- Listino: ' + ListiniMap.get(a.OF_ListinoCustom__c).name));
                    }
                }
                system.debug('DG_OF_AttivazManualeBEController - listBE: ' + listBE);
                if(listBE.size() > 1){
                    return listBE;
                }else{
                    system.debug('DG_OF_AttivazManualeBEController - agrRes.size(): ' + agrRes.size());
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Billing Element da istanziare!');
                    ApexPages.addMessage(myMsg);
                    savecheck = true;
                    return listBE;
                }
            }
            else{
                system.debug('DG_OF_AttivazManualeBEController - agrRes.size(): ' + agrRes.size());
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Non ci sono Billing Element da istanziare!');
                ApexPages.addMessage(myMsg);
                savecheck = true;
                return listBE;
            }
        }
        return listBE;
    } 
    
    
    //Creazione pricebookentry e Commercial Element
    public void creazionePBE(){
        system.debug('DG_BEIst:'+BEIst);
        prod = [select id, name, OF_ListinoCustom__c, OF_Servizio__c, OF_CommercialElement__c from product2 where id =: BEIst];
        system.debug('DG_OF_AttivazManualeBEController - prod: ' + prod);
        
        /***START COMMERCIAL ELEMENT ISTANZIATO***/
        //Lista dei commercial element sotto l'asset
        CommEleIst = [select id, OF_CommercialElement__c, OF_CommercialElementName__c from OF_CommercialElementIStanziato__c where OF_Asset__c =: idAsset];
        system.debug('DG_OF_AttivazManualeBEController - CommEleIst: ' + CommEleIst);
        
        if(CommEleIst.size() > 0){
            for(OF_CommercialElementIStanziato__c cex : CommEleIst){
                CommElemName.put(cex.OF_CommercialElementName__c, cex.id);
            }
            system.debug('DG_OF_AttivazManualeBEController - CommElemName: ' + CommElemName);
        }
        
        //Prendo il commercial element a catalogo per popolare la lookup sul commercial element istanziato
        //cmx1 = [select id, name from OF_CommercialElement__c where name =: prod.OF_CommercialElement__c and OF_Servizio__r.name =: serviziorichiestoCE(ass) limit 1];
        if( prod.OF_Servizio__c == serviziorichiestoCE(ass) )
        {
        cmx1 = [select id, name from OF_CommercialElement__c where name =: prod.OF_CommercialElement__c /*and prod.OF_Servizio__c =: serviziorichiestoCE(ass)*/ limit 1];
        }
        system.debug('DG_OF_AttivazManualeBEController - cmx1: ' + cmx1);
        
        list<OF_CommercialElementIstanziato__c> commList = new list<OF_CommercialElementIstanziato__c>();
        
        //Creo un commercial element istanziato solo se non è già presente
        if(prod != null){
            system.debug('OSCRM CommElemName:'+CommElemName );
            system.debug('OSCRM prod.OF_CommercialElement__c:'+prod.OF_CommercialElement__c );
            if(!CommElemName.keyset().contains(prod.OF_CommercialElement__c)){
                OF_CommercialElementIstanziato__c comm = new OF_CommercialElementIstanziato__c();
                comm.OF_CommercialElement__c = cmx1.id;
                comm.OF_Asset__c = idAsset;
                comm.OF_Case__c = ass.OF_IDCaseAttivazione__c;
                comm.OF_IDRisorsa__c = ass.EOF_ID_Risorsa__c;
                comm.RecordTypeID = OF_AttivazManualeCEController.RecordTypeCE(cmx1.name);
                //Quali campi devo popolare????
                comm.OF_DataAttivazione__c = BEToInsert.OF_DataAttivazione2__c;
                comm.OF_stato__c = 'Attivo';
                
                commList.add(comm);
                system.debug('DG_OF_AttivazManualeBEController - Comm: ' + Comm);
            }
        }
        if(commList.size() > 0)
            insert commList;
            
        system.debug('DG_OF_AttivazManualeBEController - commList: ' + commList);
        
        /***END COMMERCIAL ELEMENT ISTANZIATO***/
        
        /***START BILLING ELEMENT ISTANZIATO***/
        if(prod != null){
            pricebList = [select id, name, OF_Listino__c from pricebook2 where OF_Listino__c =: prod.OF_ListinoCustom__c];
            system.debug('DG_OF_AttivazManualeBEController - pricebList: ' + pricebList);
        }
        
        //Nel caso di asset extra non è presente l'ordine associato --> aggiunta condizione (ass.OF_OrdineID__c != null)
        if((idAsset != null) && (ass.OF_OrdineID__c != null)/* (ass.RecordType.name != servintavuoto) && (ass.RecordType.name != servverticale)*/){
            //VERIFICARE! Le pricebookEntry saranno sempre legate all'ordine di attivazione?
            //Se non è così quale logica implementare?
            ord = [select id from order where OF_Asset__c =: idAsset and OF_Type__c = 'INORDER'];
            system.debug('DG_OF_AttivazManualeBEController - ord: ' + ord);
            
        }
        
        if(pricebList.size() > 0){
            system.debug('DG_OF_AttivazManualeBEController - dentro secondo if - BEToInsert: ' + BEToInsert);
            //Clono la pricebookentry
            pricebook2 pbClone = pricebList[0].clone();
            insert pbClone;
            system.debug('DG_OF_AttivazManualeBEController - pbClone: ' + pbClone);
            //Inserisco la PriceBookEntry
            BEToInsert.Pricebook2Id = pbClone.id;
            BEToInsert.UnitPrice = -9999;
            BEToInsert.Product2Id = prod.id;
            BEToInsert.OF_Order__c = ord.id;
            BEToInsert.OF_Asset__c = idAsset;
            //Nel caso in cui ci sia già il Commercial element istanziato prendo quello
            //Se non è già presente prendo quello appena inserito
            if(CommElemName.get(prod.OF_CommercialElement__c) != null){
                system.debug('DG_OF_AttivazManualeBEController dentro if');
                BEToInsert.OF_CommercialElementIstanziato__c = CommElemName.get(prod.OF_CommercialElement__c);
            }else{
                system.debug('DG_OF_AttivazManualeBEController dentro else');
                BEToInsert.OF_CommercialElementIstanziato__c = commList[0].id;
            }
            insert BEToInsert;
        }
        /***END BILLING ELEMENT ISTANZIATO***/
    }
    
    //Salvataggio dei dati nel database
    public PageReference save() {
        
        if(BEIst != '--Seleziona Billing Element--' && BEIst != null){
            
            creazionePBE();    
        
            PageReference pg = new PageReference('/' + idAsset);
            pg.setRedirect(true);
            return pg;
        }
        else if(BEIst == '--Seleziona Billing Element--'){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Billing Element: You must enter a value');
            ApexPages.addMessage(myMsg);
            return null;
        }else
            return null;
    }
    
    public PageReference toReturn() {
        system.debug('DG_OF_AttivazManualeBEController - toReturn');
        PageReference pg = new PageReference('/'+idAsset);
        pg.setRedirect(true);
        return pg;
    }
    
}