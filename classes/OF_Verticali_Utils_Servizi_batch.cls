global class OF_Verticali_Utils_Servizi_batch implements Database.Batchable<sObject>,Database.Stateful 
{
    global Id CaseId;
    global string query;

    public OF_Verticali_Utils_Servizi_batch(Id idCasoInput) {
        CaseId = idCasoInput;
    }
    
    /* Metodo per la creazione degli Asset Verticali*/
    public void createAssetVerticale(List<Case> c)
    {
        System.debug('*****Dentro createAssetVerticale *****');
        
        RecordType rtAssetV = [Select id, name, SobjectType
                               from RecordType
                               where name = 'Asset Verticale' limit 1
                               ]; 

        //Query sull'ordine
        Order ord = [Select id, OF_Case__c, OF_CaseID__c, OF_IDBuilding__c, OF_ParticellaToponomastica__c,OF_IDRisorsa__c,
                     OF_Comune__c, OF_Indirizzo__c,OF_Civico__c,OF_Asset_Verticale__c, OF_Asset__r.EOF_ID_Risorsa__c
                     from Order 
                     where OF_CaseID__c =: c[0].id limit 1];
        
        //Verifico l'esistenza di un Asset Verticale con ID_GIS_SCALA_PALAZZINA restituito da OM
        List<OF_Asset_Verticale__c> listAssetV = [Select id, ID_GIS_Scala_Palazzina__c, Account__c, Account__r.name, 
                                                  Cardinalita_Scala__c
                                                  from OF_Asset_Verticale__c
                                                  /*Gestire il caso in cui il campo sul case ID_GIS_Scala_Palazzina__c sia null*/
                                                  where ID_GIS_Scala_Palazzina__c =: c[0].ID_GIS_SCALA_PALAZZINA__C];
    
        //Se la lista non è vuota bisogna creare il billing Element Verticale relativo all'OLO
        if(!listAssetV.isEmpty()){
            
            System.debug('*****listAssetV.size: *****'+listAssetV.size());
            
            //Verifico l'esistenza di un billingElementVerticale per un dato OLO
            List<OF_Billing_Element_Verticale__c> listBEvert = [Select id, ID_Risorsa__c, OLO__c, Asset_Verticale__c, Asset__c
                                                                from OF_Billing_Element_Verticale__c
                                                                where Asset_Verticale__c =: listAssetV.get(0).id
                                                                and OLO__c=: c[0].EOF_Account_OLO__c];
                                                                
            //Se la lista di BE vert è vuota creo il BE Verticale                                                   
            if(listBEvert.isEmpty()){
                
                System.debug('*****La lista di Billing Element Verticali è vuota per OLO: *****'+c[0].EOF_Account_OLO__c);
                
                createBEVerticale(c,  listAssetV.get(0),ord);
                //Aggiorno il campo Cardinalita_Scala__c ogni volta che viene creato un nuovo BE Vert
                //Indica il numero di OLO attestati sulla medesima scala
                listAssetV.get(0).Cardinalita_Scala__c = listAssetV.get(0).Cardinalita_Scala__c + 1;
                update listAssetV.get(0);
            }
        }
        //altrimenti se non esiste l'asset verticale, viene creato sia l'asset verticale che il billing Element Verticale
        else{
           System.debug('****Asset non presente....Creazione Asset!****');
            //Creo l'asset verticale con i campi restituiti da OM
            OF_Asset_Verticale__c va = new OF_Asset_Verticale__c();
            va.RecordTypeId = rtAssetV.id;
            //va.Stato__c = 'Inattivo';
            
            va.Indirizzo__c = ord.OF_Indirizzo__c;
            va.Civico__c = ord.OF_Civico__c;
            va.Comune__c = ord.OF_Comune__c;
            va.ID_DB_Building__c = ord.OF_IDBuilding__c;
            va.ID_GIS_Scala_Palazzina__c = c[0].ID_GIS_SCALA_PALAZZINA__C;
            va.Particella_Toponomastica__c = ord.OF_ParticellaToponomastica__c;
            
            if(!Test.isRunningTest())
            {
                Account openFiber = [Select id
                                    from Account
                                    where name = 'OpenFiber'];
                    
                va.Account__c = openFiber.id;
            }
            
            //START - Popolo i campi da inviare a PNI (non visibili a layout)
            va.PNI_OF_ParticellaToponomastica__c = ord.OF_ParticellaToponomastica__c;
            va.PNI_OF_Civico__c = ord.OF_Civico__c;
            va.PNI_OF_Indirizzo__c = ord.OF_Indirizzo__c;
            va.PNI_OF_IDRisorsa__c = ord.OF_IDRisorsa__c;
            va.PNI_OF_IDBuilding__c = ord.OF_IDBuilding__c;
            va.PNI_OF_Comune__c = ord.OF_Comune__c;
            //END - Popolo i campi da inviare a PNI (non visibili a layout)
            va.OF_isLavorazione__c=false;
            //Setto il campo Cardinalita_Scala__c a 1
            va.Cardinalita_Scala__c = 1;
            //Relaziono l'asset Verticale con l'asset Standard --->Relazione rimossa
            //va.Asset__c = c[0].AssetId;
            insert va;
            //Relaziono l'asset Verticale con il Case
            c[0].Asset_Verticale__c = va.id;
            //Aggiorno il case con l'id dell'Asset Verticale
            update c;
            //Relaziono l'asset Verticale all'Ordine
            ord.OF_Asset_Verticale__c = va.id;
            update ord;
            //Creo il BE Verticale
            createBEVerticale(c, va,ord);
        }
    }
    
    /* Metodo per la creazione dei Billing Element Verticali */
    public void createBEVerticale(List<Case> c, OF_Asset_Verticale__c assetVert, order ord)
    {
        System.debug('******Creazione BE Verticale in corso....******');
        
        OF_Billing_Element_Verticale__c verticalBE = new OF_Billing_Element_Verticale__c();
        //da capire il name da inserire
        verticalBE.name = 'BEV-'+ord.OF_Asset__r.EOF_ID_Risorsa__c;
        verticalBE.ID_Building__c = ord.OF_IDBuilding__c;
        verticalBE.Scala__c = c[0].OF_SCALA__c;
        verticalBE.Palazzina__c = c[0].OF_PALAZZINA__c;
        verticalBE.ID_Risorsa__c = ord.OF_Asset__r.EOF_ID_Risorsa__c;
        verticalBE.OLO__c = c[0].EOF_Account_OLO__c;
        //Relaziono il BE Verticale all'Asset Standard
        verticalBE.Asset__c = c[0].AssetId;
        verticalBE.Data_Attivazione__c = c[0].Asset.OF_DataAttivazione2__c;
        //Relaziono il BE Verticale all'Asset Verticale
        verticalBE.Asset_Verticale__c = assetVert.id;
        insert verticalBE;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        query = 'select id, casenumber, AssetId, OF_SCALA__C, OF_PALAZZINA__c, ID_GIS_SCALA_PALAZZINA__C, EOF_Account_OLO__c, Asset.OF_DataAttivazione2__c from case where id='+'\''+CaseId+'\'';
        system.debug('>>>>>>>>>>>> query: ' + query);                 
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Case> scope){
        
        createAssetVerticale(scope);
    }  
	
    global void finish(Database.BatchableContext BC){

    }
}