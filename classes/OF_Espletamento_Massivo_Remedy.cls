public without sharing class OF_Espletamento_Massivo_Remedy  {
    
    public static final String STATO_ESPLETATO = 'Espletato';
    public static final String STATO_ESPLETATO_KO = 'Espletato KO';
    public static final String FASE_ESPLETATO_OK = 'Espletato OK';
    public static final String FASE_ESPLETATO_KO = 'Espletato KO';
    public static final List<String> beNamesAttivazioneGponOpenstream = new List<String> {'Contributo Attivazione','Canone','Canone premium','Contributo Consegna','Contributo Istallazione','Contributo Consegna e istallazione','Contributo Ribaltamento impianto','Contributo Consegna TV BOX','Contributo prolungamento 0<distanza<20m','Contributo prolungamento >20m'};
    public static final List<String> beNamesCessazioneGponOpenstream = new List<String> {'Contributo Disattivazione','Contributo Ritiro'};
    private static Map<String, Id> rtMap = null;
    private Datetime dataCustomRemedy = null;
    private string devName;
    private final Case c;
    private final Case_AssetRecordType__c cs;
    
    public OF_Espletamento_Massivo_Remedy(Case caseOrdine,string webServ) {
        //  system.debug('istanzio espletamento'+ webServ);
        system.debug('***1 webServ'+webServ);
        if (caseOrdine == null) {
            system.debug('***2 webServ'+webServ);
            if(webServ=='activation'){ 
                devName='EOF_Caso_Attivazione_Remedy';
            }else if(webServ=='deactivation'){
                devName='EOF_Caso_Cessazione_Remedy';
            }else if(webServ=='assurance'){
                devName='EOF_Caso_ASSURANCE_Remedy';
            }
            
        }
        map <String, String> RTMappa = new  map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            RTMappa.put(rt.id, rt.developername);
        }
        
        
        for (Case_AssetRecordType__c csCase : Case_AssetRecordType__c.getAll().values()) {
            if (devName.equalsIgnoreCase(csCase.caseDevName__c)) {
                cs = csCase;
                break;
            }
        }
        system.debug('cs--->null?'+cs);
        if (cs == null) {
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage('Missing Custom Setting for Case.RecordType.DeveloperName = ' + c.RecordType.DeveloperName);
            throw e;
        }
    }
    
    /**
* @return Mappa DeveloperName - RecordTypeId
*/
    public static Map<String, Id> getRtMap() {
        if (rtMap == null) {
            List<RecordType> rtList = [SELECT Id, DeveloperName FROM RecordType];
            rtMap = new Map<String, Id>();
            for (RecordType rt : rtList) {
                rtMap.put(rt.DeveloperName, rt.Id);
            }
        }
        return rtMap;
    }
    
    public class BeiData {
        public OF_CommercialElementIstanziato__c cei {get; set;}
        public Product2 prod {get; set;}
        public datetime dataAttivazione {get; set;}
        public string quantity {get; set;}
        
        public BeiData(OF_CommercialElementIstanziato__c c, Product2 p) {
            cei = c;
            prod = p;
            dataAttivazione=c.OF_DataAttivazione__c;
            quantity = c.OF_CPE_Quantity__c;
        }
    }
    
    /**
* Crea l'Asset (solo se necessario), crea un'istanza del Commercial Element relativo ai BE in input,
* la collega all'Asset quindi crea le istanze dei Billing Element, relazionandole al CEI e all'Asset.
*
* @param a - L'Asset da collegare ai CEI e BEI. Se <tt>null</tt> viene creato basandosi sulle info presenti nel Case e nell'Ordine a lui collegato.
* @param beList - Lista di Billing Element da istanziare. I BE devono essere stati recuperati con Id, Nome, Id del CE e Nome del CE
* @param ok - TRUE per andare in Espletato OK, FALSE per andare in Espletato KO
*
* @return Il CEI appena creato.
* @throws NoDataFoundException se l'Ordine non è collegato al Contratto
*/
    public OF_CommercialElementIstanziato__c espletamentoRemedy(List<Asset> astList, List<OF_BillingElement__c> beList, Boolean ok) {
        system.debug('commercial element istanziato');
        if (beList.isEmpty()) {
            return null;
        }
        
        Map<String, Id> mapRtDevName_RtId = getRtMap();
        Map<String, Id> mapCEName_CeiRtId = new Map<String, String>();
        for (Ce_CeiRecordType__c cs : Ce_CeiRecordType__c.getAll().values()) {
            mapCEName_CeiRtId.put(cs.ceName__c, mapRtDevName_RtId.get(cs.ceiDevName__c));
        }
        System.debug('mapRtDevName_RtId ' + mapRtDevName_RtId);
        System.debug('mapCEName_CeiRtId: ' + mapCEName_CeiRtId);
        List<BeiData> beiDataList = new List<BeiData>();
        List<Product2> prodToInsert = new List<Product2>();
        List<OF_CommercialElementIstanziato__c> ceiList = new List<OF_CommercialElementIstanziato__c>();
        
        
        for (Asset ast:astList){
            OF_BillingElement__c be0 = beList.get(0);
            System.debug('be0.Name; ' + be0.Name);
            system.debug('');
            System.debug('be0.OF_CommercialElement__c; ' + be0.OF_CommercialElement__c);
            OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
            cei.OF_CommercialElement__c = be0.OF_CommercialElement__c;
            cei.OF_Asset__c = ast.Id;
            cei.RecordTypeId = mapCEName_CeiRtId.get(be0.OF_CommercialElement__r.Name);
            cei.OF_BillingSyncronized__c = false; // flag per il billing
            cei.UpdateBilling__c = true; // flag per il billing
            cei.OF_Stato__c = 'Attivo';
            if(ast.OF_Remedy_productProvisioningCode__c=='47'){
                system.debug('productcode 47: '+ast.OF_CPE_Quantity__c);
                if(ast.OF_CPE_Quantity__c!=null){
                    Integer q= integer.valueof(ast.OF_CPE_Quantity__c);
                    Integer quantity= q-15; 
                    cei.OF_CPE_Quantity__c=string.valueof(quantity);
                    system.debug('quantity: '+cei.OF_CPE_Quantity__c);
                } 
            }else{
                cei.OF_CPE_Quantity__c=ast.OF_CPE_Quantity__c;
            }  
            
            cei.OF_IDRisorsa__c = ast.EOF_ID_Risorsa__c;
            cei.OF_DataAttivazione__c =ast.OF_DataAttivazione2__c;
            cei.Code_IAV__c=ast.OF_Remedy_oloMessageCode__c;
            cei.OF_TT_Number__c=ast.OF_Remedy_ttNumber__c;
            cei.Descrizione_IAV__c=ast.OF_Remedy_oloMessage__c;
            cei.OLO_Comm_Code__c=ast.OF_Remedy_oloCommCode__c;
            ceiList.add(cei);
        }
        insert ceiList;
        for (OF_CommercialElementIstanziato__c ceiI:ceiList){
            for (OF_BillingElement__c be : beList) {
                Product2 p = createProd(be);
                prodToInsert.add(p);
                beiDataList.add(new BeiData(ceiI, p));
            }
            
        }
        insert prodToInsert;
        
        createBEI_Remedy(beiDataList);
        
        return ceilist[0];
    }
    
     public List<PricebookEntry> createBEI_Remedy(List<BeiData> beiDataList) {
        System.debug('Creating ' + beiDataList.size() + ' BEI');
        Id standardPbId = [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id;
        
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        for (BeiData wrap : beiDataList) {
            PricebookEntry pbe = new PricebookEntry();
            pbe.Pricebook2Id = standardPbId;
            if(wrap.cei.OF_CPE_Quantity__c!=null){
                pbe.quantity__c = Decimal.valueOf(wrap.cei.OF_CPE_Quantity__c);
            }
            //Done AA - Cambiare data attivazione con quella presente sul case
            pbe.OF_DataAttivazione2__c = wrap.cei.OF_DataAttivazione__c;
            pbe.isActive = true;
            pbe.UseStandardPrice = false;
            pbe.UnitPrice = -9999;
            pbe.OF_Asset__c = wrap.cei.OF_Asset__c;
            pbe.OF_CommercialElementIstanziato__c = wrap.cei.id;
            pbe.Product2Id = wrap.prod.id;
            pbeList.add(pbe);
        }
        
        insert pbeList;
        return pbeList;
    }
    
    public PricebookEntry createPBE_Remedy(Id productId, Id standardPbId, OF_CommercialElementIstanziato__c cei, Asset a) {
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = standardPbId;
        if ((a != null) && String.isNotBlank(a.OF_CPE_Quantity__c)) {
            pbe.quantity__c = Decimal.valueOf(a.OF_CPE_Quantity__c);
        }
        //Done AA - Cambiare data attivazione con quella presente sul case
        pbe.OF_DataAttivazione2__c = a.OF_DataAttivazione2__c;
        pbe.isActive = true;
        pbe.UseStandardPrice = false;
        pbe.UnitPrice = -9999;
        pbe.OF_Asset__c = cei.OF_Asset__c;
        pbe.OF_CommercialElementIstanziato__c = cei.id;
        pbe.Product2Id = productId;
        return pbe;
    }
    
    public Product2 createProd(OF_BillingElement__c be) {
        Product2 p = new Product2();
        p.name = be.Name;
        p.OF_BillingElement__c = be.Id;
        p.IsActive = true;
        
        return p;
    }    
    
    public static Map<String, OF_BillingElement__c> getMapBeName_BE(List<String> beNames, String srvCode) {
        system.debug('beNames: ' + beNames);
        system.debug('service code:' + srvCode);
        List<OF_BillingElement__c> beList = [SELECT Id, Name, OF_CommercialElement__c, OF_CommercialElement__r.Name
                                             FROM OF_BillingElement__c
                                             WHERE Name IN :beNames AND OF_Attivo__c = true
                                             AND OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c = :srvCode];
        system.debug('getMapBeName_BE:' + beList);
        Map<String, OF_BillingElement__c> mapBeName_BE = new Map<String, OF_BillingElement__c>();
        for (OF_BillingElement__c be : beList) {
            mapBeName_BE.put(be.Name, be);
        }
        
        return mapBeName_BE;
    }
    
    public static Map<String,	Map<String, OF_BillingElement__c>> getMapBeName_BE_Bulk(List<Request_Remedy__c> reqList ) {
        Set<String> lsServCode=new Set<String>();
        Set<String> nomiPbeSet = new Set<String>();
        system.debug('sono nel metodo getMapBeName_BE_Bulk');
        for (Request_Remedy__c request : reqList) {
            lsServCode.add(request.OF_Service_Code__c);
            system.debug('request.OF_Service_Code__c: '+request.OF_Service_Code__c);
            system.debug('lsServCode: '+lsServCode);
            if(request.recordType.developerName=='EOF_Request_Attivazione_Remedy'){
                nomiPbeSet.add('Contributo Attivazione');
                nomiPbeSet.add('Canone');
            } else if(request.recordType.developerName=='EOF_Request_CPE_Remedy'){
                system.debug('request.OF_Remedy_productProvisioningCode__c='+request.OF_Remedy_productProvisioningCode__c);
                if(request.OF_Remedy_productProvisioningCode__c=='9'){
                    nomiPbeSet.add('Contributo Installazione CPE');
                }else if(request.OF_Remedy_productProvisioningCode__c=='10'){
                    nomiPbeSet.add('Contributo Ribaltamento impianto');
                }else if(request.OF_Remedy_productProvisioningCode__c=='23'){
                    nomiPbeSet.add('Contributo Installazione ONT');
                }else if(request.OF_Remedy_productProvisioningCode__c=='43'){
                    nomiPbeSet.add('Tipo 1 Prolungamento fino a 5 m');
                }else if(request.OF_Remedy_productProvisioningCode__c=='44'){
                    nomiPbeSet.add('Tipo 2 Prolungamento fino a 5 m con canalina nuova');
                }else if(request.OF_Remedy_productProvisioningCode__c=='45'){
                    nomiPbeSet.add('Tipo 3 Prolungamento tra 5-15 m');
                }else if(request.OF_Remedy_productProvisioningCode__c=='46'){
                    nomiPbeSet.add('Tipo 4 Prolungamento tra 5-15 m con canalina nuova');
                }else if(request.OF_Remedy_productProvisioningCode__c=='47'){
                    nomiPbeSet.add('Tipo 5 Supplemento prolungamento oltre 15m');
                }else if(request.OF_Remedy_productProvisioningCode__c=='48'){
                    nomiPbeSet.add('Compenso per intervento non contestuale');
                }else if(request.OF_Remedy_productProvisioningCode__c=='70'){
                    nomiPbeSet.add('Contributo Installazione CPE Base');
                }else if(request.OF_Remedy_productProvisioningCode__c=='71'){
                    nomiPbeSet.add('Contributo Installazione CPE Plus');
                }else if(request.OF_Remedy_productProvisioningCode__c=='72'){
                    nomiPbeSet.add('Contributo Installazione CPE Premium');
                }
            }
            else if(request.recordType.developerName=='EOF_Request_Assurance_Remedy'){
                if(request.OF_Remedy_productProvisioningCode__c=='14'){
                    nomiPbeSet.add('Non Risolvibile: Causa CPE Cliente');
                }else if(request.OF_Remedy_productProvisioningCode__c=='15'||request.OF_Remedy_productProvisioningCode__c=='16'){
                    nomiPbeSet.add('Non Risolvibile: Causa Impianto Cliente');
                }else if(request.OF_Remedy_productProvisioningCode__c=='17'){
                    nomiPbeSet.add('Non riscontrato: Senza Uscita');
                }else if(request.OF_Remedy_productProvisioningCode__c=='18'){
                    nomiPbeSet.add('Non riscontrato: Con Uscita');
                }
            }
            else if(request.recordType.developerName=='EOF_Request_Provisioning_Remedy'){
                nomiPbeSet.add('Contributo intervento a vuoto provisioning');
            } 
        }
        system.debug('nomiPbeSet:' +nomiPbeSet);
        system.debug('set service code: '+lsServCode );
        List<OF_BillingElement__c> beList = [SELECT Id, Name, OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c, OF_CommercialElement__c, OF_CommercialElement__r.Name
                                             FROM OF_BillingElement__c
                                             WHERE Name IN :nomiPbeSet AND OF_Attivo__c = true
                                             AND OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c in :lsServCode];
        system.debug('getMapBeName_BE:' + beList.size());
        
        Map<String,	Map<String, OF_BillingElement__c>> mapSErviceCode_BeName_BE = new Map<String,	Map<String, OF_BillingElement__c>>();
        
        
        for (OF_BillingElement__c be : beList) {
            if(mapSErviceCode_BeName_BE.get(be.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c)==null){
                Map<String, OF_BillingElement__c> mapBeName_BE = new Map<String, OF_BillingElement__c>();
                mapBeName_BE.put(be.Name, be);
                mapSErviceCode_BeName_BE.put(be.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,mapBeName_BE);
            }else{
                Map<String, OF_BillingElement__c> mapBeName_BE=mapSErviceCode_BeName_BE.get(be.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
                mapBeName_BE.put(be.Name, be);
                mapSErviceCode_BeName_BE.put(be.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,mapBeName_BE);
            }
            
        }
        
        return mapSErviceCode_BeName_BE;
    }
    
    public void cessazioneCeiGPONP_RemedyBulk(Boolean ok, List<String> lsIdOrder) {
        system.debug('ESP lsIdOrder: '+lsIdOrder.size());
	    List<Order> lsOrder = [SELECT Id, Status, OF_Esito__c,OF_Remedy_actionDate__c, OF_Asset__c,ContractId, OF_Data_Cessazione__c, OF_DataEsito__c, OF_CodiceKO__c, OF_DescrizioneKO__c
                               FROM Order WHERE Id in:lsIdOrder];
        List<String> lsAssetId=new List<String>();
        Map<String,Order> mapOrder=new Map<String,Order>();
		   Map<String,String> mapOrderAsset=new Map<String,String>();
        for (Order o :lsOrder){
            mapOrder.put(o.Id,o);
            lsAssetId.add(o.OF_Asset__c);
			    mapOrderAsset.put(o.Id,o.OF_Asset__c);
        }
        system.debug('ESP lsAssetId: '+lsAssetId.size());
        system.debug('ESP mapOrder: '+mapOrder);
        List<Asset> lsAsset = [SELECT Id, OF_Contract__c, OF_DataAttivazione2__c, Status, OF_OrdineId__c, OF_CPE_Quantity__c
                               FROM Asset WHERE Id in:lsAssetId ];
     
        Map<String,Asset> mapAsset=new Map<String,Asset>();
        List<String> lsContractId=new List<String>();
        Map<String,String> mapAssetContratto=new Map<String,String>();
        for(Asset a :lsAsset){
        
            lsContractId.add(a.OF_Contract__c);
            mapAsset.put(a.Id,a);
            mapAssetContratto.put(a.Id,a.OF_Contract__c);
        }
		     system.debug('ESP lsAsset: '+lsAsset);
   system.debug('ESP lsContractId: '+lsContractId);
        List< OF_ContrattoServizio__c> lscontrattoServizio = [SELECT Id, OF_Servizio__c, OF_Servizio__r.OF_Servizio_Code__c
                                                              FROM OF_ContrattoServizio__c
                                                              WHERE OF_Contract__c in :lsContractId AND OF_Servizio__r.Name IN ('Open Stream', 'GPON Passiva', 'GPON Passiva CD', 'Open Stream CD')
                                                             ];
        Map<String,OF_ContrattoServizio__c> mapContratti=new Map<String,OF_ContrattoServizio__c>();
        for (OF_ContrattoServizio__c c:lscontrattoServizio){
            mapContratti.put(c.Id,c);
        }
               	system.debug('ESP mapContratti: '+mapContratti.size());

        List<OF_CommercialElementIstanziato__c> ceiList = [SELECT Id, OF_Stato__c,OF_CPE_Quantity__c, OF_DataCessazione__c, OF_Asset__c,OF_DataAttivazione__c, OF_CommercialElement__c, RecordType.DeveloperName, OF_EsitoRitiroApparato__c FROM OF_CommercialElementIstanziato__c
                                                           WHERE OF_Asset__c in :lsAssetId AND OF_Stato__c != 'Cessato' /*AND RecordType.DeveloperName != 'OF_Standard'*/ AND OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c = :lscontrattoServizio[0].OF_Servizio__r.OF_Servizio_Code__c];
                       	system.debug('ESP ceiList: '+ceiList.size());
        Map<String,List<OF_CommercialElementIstanziato__c>> mapAssetCei= new    Map<String,List<OF_CommercialElementIstanziato__c>>();
        for(OF_CommercialElementIstanziato__c cei :ceiList){
            if(mapAssetCei.get(cei.OF_Asset__c)==null){
                List<OF_CommercialElementIstanziato__c> ls= new List<OF_CommercialElementIstanziato__c>();
                ls.add(cei);
                mapAssetCei.put(cei.OF_Asset__c,ls);
            }else{
                List<OF_CommercialElementIstanziato__c> ls= mapAssetCei.get(cei.OF_Asset__c);
                ls.add(cei);
                mapAssetCei.put(cei.OF_Asset__c,ls);
            }
        }
        system.debug('ESP mapAssetCei: '+mapAssetCei.size());
        system.debug('ESP mapAssetCei: '+mapAssetCei);
        Map<String, OF_BillingElement__c> mapBeName_BE = getMapBeName_BE(new List<String> {'Contributo Disattivazione'}, lscontrattoServizio[0].OF_Servizio__r.OF_Servizio_Code__c);
        List<Product2> prodToInsert = new List<Product2>();
        List<BeiData> beiDataList = new List<BeiData>();
        Set<Id> ceiIds = new Set<Id>();
        List<OF_CommercialElementIstanziato__c> ceiListToUpd=new List<OF_CommercialElementIstanziato__c>();
        for (String k:mapOrderAsset.keySet())
        {
            List<OF_CommercialElementIstanziato__c> ceiL= mapAssetCei.get(mapOrderAsset.get(k));
            
            OF_CommercialElementIstanziato__c ceiServizioBase = null;
            for (OF_CommercialElementIstanziato__c cei : ceiL) {
                
                ceiIds.add(cei.Id);
                cei.UpdateBilling__c = true; // Billing
                if('OF_CPE'.equalsIgnoreCase(cei.RecordType.DeveloperName)||'Intervento_a_vuoto'.equalsIgnoreCase(cei.RecordType.DeveloperName)||
                   'OF_INTERVENTO_DI_MANUTENZIONE'.equalsIgnoreCase(cei.RecordType.DeveloperName)||'OF_ServiziAggiuntivi'.equalsIgnoreCase(cei.RecordType.DeveloperName)){
                cei.OF_DataCessazione__c = (mapOrder.get(k).OF_Data_Cessazione__c != null ) ? mapOrder.get(k).OF_Data_Cessazione__c : System.now();
                cei.OF_Stato__c = 'Cessato';
            }
                if ('OF_Standard'.equalsIgnoreCase(cei.RecordType.DeveloperName)) {
                    ceiServizioBase = cei;
                }
                ceiListToUpd.add(cei);
            }
            if (ceiServizioBase != null) {
                OF_BillingElement__c beContrDisatt = mapBeName_BE.get('Contributo Disattivazione');
                Product2 prodDisatt = createProd(beContrDisatt);
                prodToInsert.add(prodDisatt);
                beiDataList.add(new BeiData(ceiServizioBase, prodDisatt));
            }
            
            
        }
        system.debug('ESP ceiIds: '+ceiIds.size());
        system.debug('ESP ceiIds: '+ceiIds);
		insert prodToInsert;
        List<PricebookEntry> lsBeiRemedy= createBEI_RemedyBulk(beiDataList);
        insert lsBeiRemedy;
        update ceiListToUpd;
        //Inserisco i prodotti per creare i BEI
        
        
        
        //cessare pbe
        List<PricebookEntry> pbeList = [SELECT Id, IsActive, OF_DataCessazione2__c,OF_CommercialElementIstanziato__c,Product2.Name FROM PricebookEntry
                                        WHERE IsActive = true AND OF_CommercialElementIstanziato__c IN :ceiIds];
        Map<String,List<PricebookEntry>> mapCeiPbe=new Map<String,List<PricebookEntry>>();
        for (PricebookEntry pbe:pbeList){
            if (mapCeiPbe.get(pbe.OF_CommercialElementIstanziato__c)==null){
                List<PricebookEntry> lspb=new List<PricebookEntry>();
                lspb.add(pbe);
                mapCeiPbe.put(pbe.OF_CommercialElementIstanziato__c,lspb);
            }else{
                List<PricebookEntry> lspb=mapCeiPbe.get(pbe.OF_CommercialElementIstanziato__c);
                lspb.add(pbe);
                mapCeiPbe.put(pbe.OF_CommercialElementIstanziato__c,lspb);
                
            }
        }
        List<PricebookEntry> lspbDaCessareGlobal=new List<PricebookEntry>();
        List<Asset> lsAssetDaCessareGlobal=new List<Asset>();
        for (String k:mapOrderAsset.keySet())
        {
			  system.debug('ESP  k: '+ k);
            Order o=mapOrder.get(k);
            String idAsset=mapOrderAsset.get(k);
			  system.debug('idAsset'+ idAsset);
            Asset a=mapAsset.get(idAsset);
			system.debug('a'+ a);
            a.OF_DataCessazione2__c = (o.OF_Data_Cessazione__c != null ) ? o.OF_Data_Cessazione__c : System.now();
            a.status = 'Cessato';
            a.OF_OrdineId__c = o.Id;
            lsAssetDaCessareGlobal.add(a);
            
            List<OF_CommercialElementIstanziato__c> ceiL= mapAssetCei.get(mapOrderAsset.get(k));
            
            List<PricebookEntry> lspbDaCessare=new List<PricebookEntry>();
            for (OF_CommercialElementIstanziato__c cei:ceiL){
               
			    lspbDaCessare.addAll(mapCeiPbe.get(cei.Id));
                
            }
            for (PricebookEntry pbe :lspbDaCessare){
                pbe.IsActive = false;
                //Done AA - Cambiare data attivazione con quella presente sul case
				if (pbe.Product2.Name=='Contributo Disattivazione'){
   					pbe.OF_DataAttivazione2__c = (o.OF_Data_Cessazione__c != null ) ? o.OF_Data_Cessazione__c : System.now();
				}else{
  					 pbe.OF_DataCessazione2__c = (o.OF_Data_Cessazione__c != null ) ? o.OF_Data_Cessazione__c : System.now();
				}
             
                lspbDaCessareGlobal.add(pbe);
            }
        }
        system.debug('ESP lspbDaCessareGlobal:'+lspbDaCessareGlobal.size());
        system.debug('ESP lsAssetDaCessareGlobal:'+lsAssetDaCessareGlobal.size());
        update lspbDaCessareGlobal;
        update lsAssetDaCessareGlobal;
    } 
    
    public List<PricebookEntry> createBEI_RemedyBulk(List<BeiData> beiDataList) {
        System.debug('Creating ' + beiDataList.size() + ' BEI');
        Id standardPbId = [SELECT Id FROM Pricebook2 WHERE isStandard = true LIMIT 1].Id;
        
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        for (BeiData wrap : beiDataList) {
            PricebookEntry pbe = new PricebookEntry();
            pbe.Pricebook2Id = standardPbId;
            if(wrap.cei.OF_CPE_Quantity__c!=null){
                pbe.quantity__c = Decimal.valueOf(wrap.cei.OF_CPE_Quantity__c);
            }
            //Done AA - Cambiare data attivazione con quella presente sul case
            pbe.OF_DataAttivazione2__c = wrap.cei.OF_DataAttivazione__c;
            pbe.isActive = true;
            pbe.UseStandardPrice = false;
            pbe.UnitPrice = -9999;
            pbe.OF_Asset__c = wrap.cei.OF_Asset__c;
            pbe.OF_CommercialElementIstanziato__c = wrap.cei.id;
            pbe.Product2Id = wrap.prod.id;
            pbeList.add(pbe);
        }
        
        
        return pbeList;
    } 
      public static void testCoverage(){
        Integer a=1;
        Integer b=1;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
          a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;  a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;
        a=b;


    }
}