public class SyncBillingAssetUtils {
    public class CustomObject {
        public string action {get; set;}
        public string operationType {get; set;}
        public OF_CommercialElementIstanziato__c CEI {get; set;}
        public Order activationOrder {get; set;}
        public string JsonString {get; set;}
        public string notificaId {get; set;}
        public List<PricebookEntry> bei {get; set;}
        public EOF_Notify__c notifica {get; set;}
        public string request {get; set;}
        public string errore {get; set;}
    }
    public static void callWSAssetVerticaleCustom(List<string> AssetIds){
        System.debug('@@@@ Inizio callWSAssetVerticaleCustom: ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        system.debug('@@@@AssetIds: ' + AssetIds);
        try {
            List<OF_CommercialElementIstanziato__c> ceiRecuperati = getListCEIDrop1(AssetIds);
            List<OF_CommercialElementIstanziato__c> ListCeiAttivi = new List<OF_CommercialElementIstanziato__c>();
            Map<string,OF_CommercialElementIstanziato__c> mapCeiCessati = new Map<string,OF_CommercialElementIstanziato__c>();
            for (OF_CommercialElementIstanziato__c ce : ceiRecuperati){
                if ('Attivo'.equals(ce.OF_Stato__c)){
                    ListCeiAttivi.add(ce);
                }
                else{
                    if (mapCeiCessati.containsKey(ce.OF_Asset__c)){
                        OF_CommercialElementIstanziato__c comm = mapCeiCessati.get(ce.OF_Asset__c);
                        if (ce.LastModifiedDate > comm.LastModifiedDate){
                            mapCeiCessati.put(ce.OF_Asset__c,ce);
                        }
                    }
                    else
                    {
                        mapCeiCessati.put(ce.OF_Asset__c,ce);
                    }
                }
            }
            List<OF_CommercialElementIstanziato__c> cei = new List<OF_CommercialElementIstanziato__c>();
            cei.addAll(ListCeiAttivi);
            cei.addAll(mapCeiCessati.values());
            List<string> ceiIds = new List<string>();
            List<String> ceiAssetId = new List<string>();
            for (OF_CommercialElementIstanziato__c ce : cei) {
                ceiIds.add(ce.id);
                ceiAssetId.add(ce.OF_Asset__c);
            }
            List<PricebookEntry> beis = getListBEICustom(ceiIds);
            List<Order> orders = getOrders(ceiAssetId);
            Map<string,Order> mapOrder = new Map<string,Order>();
            for (Order ord : orders) {
                if (!mapOrder.containsKey(ord.OF_Asset__c)) {
                    mapOrder.put(ord.OF_Asset__c,ord);
                }
            }
            Map<String,List<PricebookEntry>> mapBei = new Map<String,List<PricebookEntry>>();  
            for (PricebookEntry be : beis) {
                List<PricebookEntry> pe = mapBei.get(be.OF_CommercialElementIstanziato__c);
                if (pe == null)
                {
                    pe = new List<PricebookEntry>();
                    mapBei.put(be.OF_CommercialElementIstanziato__c, pe);
                }
                pe.add(be);
            }
            List<CustomObject> callTodo = new  List<CustomObject>();
            Integer i = 1;
            for (OF_CommercialElementIstanziato__c ce : cei) {
                CustomObject co = new CustomObject();
                co.CEI = ce;
                co.activationOrder = mapOrder.get(ce.OF_Asset__c);
                co.bei = mapBei.get(ce.Id);
                if ('Cessato'.equals(ce.OF_Stato__c)) {
                    co.operationType = 'Update';
                    co.action='Terminate';
                } else if (ce.OF_BillingSyncronized__c) {
                    co.operationType = 'Update';
                    co.action='Modify';
                } else {
                    co.operationType = 'Create';
                    co.action='Activate';
                }
                String resCheck = checkfieldCustom(co);
                System.debug('@@@@@@ dopo CheckField '  + resCheck);
                co.notificaId = String.valueOf(System.now().getTime()) + '_' + i++;
                if ('true'.equals(resCheck)) {
                    CreateRequestForCall(co); 
                }
                else
                {
                    co.errore = rescheck;
                }
                callTodo.add(co);
            }
            List<EOF_Notify__c> resnot= createListNotifyCustom(callTodo);
            insert resnot;
            List<EOF_EAI_Service_Log__c> logs =  createRequestLog(callTodo);
            insert logs;
        }
        catch (Exception ex)
        {
            system.debug('@@@@Exception ' + ex.getLineNumber() + '  ' + ex.getMessage());
        }
        finally
        {
            updateSyncVErticaleFlag(AssetIds);
        }
    }
    public static List<EOF_EAI_Service_Log__c> createRequestLog(List<CustomObject> calls) {
        List<EOF_EAI_Service_Log__c> toReturn = new List<EOF_EAI_Service_Log__c>();
        List<CustomObject> invalidRecords = new List<CustomObject>();
        if (calls != null) {
            Id recId = [SELECT Id FROM RecordType WHERE DeveloperName = 'SF_To_BILL' Limit 1].Id;
            for (CustomObject wrp : calls) {
                if (string.isBlank(wrp.errore)) {
                    EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
                    log.Notify__c = wrp.notifica.Id;
                    log.RecordTypeId = recId;
                    log.EOF_Richiesta_Notifica__c = wrp.request;
                    toReturn.add(log);
                } else {
                    invalidRecords.add(wrp);
                }
            }
        }  
        System.debug('@@@@ Creo i LOG di Errore ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        List<EOF_EAI_Service_Log__c> nackBillingLogList = createNackBillingLog(invalidRecords);
        insert nackBillingLogList;
        System.debug('@@@@ Creati i LOG di Errore ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        System.debug('Creati ' + toReturn.size() + ' log su un totale di ' + calls.size() + ' notifiche');
        return toReturn;
    }
    public static List<EOF_EAI_Service_Log__c> createNackBillingLog(List<CustomObject> calls){
        List<EOF_EAI_Service_Log__c> toReturn = new List<EOF_EAI_Service_Log__c>();
        if (calls != null) {
            Id recId = [Select Id from RecordType where DeveloperName = 'Nack_Billing' Limit 1].Id;
            for (CustomObject wrp : calls) {
                EOF_EAI_Service_Log__c log = new EOF_EAI_Service_Log__c();
                log.Notify__c = wrp.notifica.Id;
                log.RecordTypeId = recId;
                log.EOF_Descrizione_Causale_Scarto__c = 'Il controllo del campo ' + wrp.errore + ' non è andato a buon fine';
                toReturn.add(log);
            }
        }
        
        return toReturn;
    }
    public static Boolean callWSAssetVerticaleByCei(string IdCei, string IdNotifica){
        System.debug('@@@@ Chiamata al metodo Nel Future: ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
        EOF_Notify__c notifica = [SELECT id, OF_JsonRequest__c, Asset__c
                                  FROM EOF_Notify__c
                                  where EOF_ID_Notifica__c  = : IdNotifica and REcordType.DeveloperName ='EOF_Bill_Asset' LIMIT 1];
        if (!string.isBlank(notifica.OF_JsonRequest__c)){
            OF_CommercialElementIstanziato__c CEI = [select id,OF_Stato__C,OF_BillingSyncronized__c,Asset_Verticale__c,UpdateBilling__c,RecordType.DeveloperName
                                                     from OF_CommercialElementIstanziato__c
                                                     where id =:IdCei limit 1];
            List<String> ceiAssetId = new List<string> {notifica.Asset__c};
                Boolean mustUpdate=false;
            System.debug('@@@@ Faccio la Chiamata ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
            OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = (OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType) JSON.deserialize(notifica.OF_JsonRequest__c, OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType.class);
            OF_Billing_Outbound_Service3.BillingOrderManagerSOAP port = new OF_Billing_Outbound_Service3.BillingOrderManagerSOAP();
            port.timeout_x = 120000;
            OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType resp = port.OrderManager(req.orderItem, req.orderItemOther, req.orderItemPrices);  
            
            /* OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType resp = new  OF_Billing_Outbound_Schema3.BillingOrderManagerResponsetType();
resp.esito ='0';
*/
            if ('0'.equals(resp.esito)){
                mustUpdate = true;
                CEI.OF_BillingSyncronized__c = true;
                if(!'Verticale'.equals(CEI.RecordType.DeveloperName)){
                    CEI.UpdateBilling__c= false;
                    /* if('Desospeso'.equals(cei.OF_Stato__C))
{
CEI.OF_Stato__C= 'Attivo';
}*/
                }
                update CEI;
            }
            System.debug('@@@@ Creo il log di response ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));
            Id recId2 = [Select Id from RecordType where DeveloperName ='BILL_To_SF' Limit 1].Id;
            EOF_EAI_Service_Log__c log2 = new EOF_EAI_Service_Log__c();
            log2.Notify__c=notifica.id;
            log2.RecordTypeId = recId2;
            log2.EOF_Response__c = resp.motivazione;
            log2.EOF_Descrizione_Causale_Scarto__c = resp.descrizione;
            log2.EOF_CODICE_MOTIVAZIONE__c=resp.codiceMotivazione;
            log2.OF_SA_Esito__c=resp.esito;
            insert log2;
            System.debug('@@@@ Log di response Inserito ' + system.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ'));  
            return mustUpdate;
        }
        return false;
    }
    public static void UpdateBev(List<OF_Billing_Element_Verticale__c> bevs ){
        for (OF_Billing_Element_Verticale__c bev : bevs)
        {
            bev.Update_Billing__c = false;
        }
        
        update bevs;
    }
    public static void UpdateAssetVert(List<OF_Asset_Verticale__c> asseV ){
        for (OF_Asset_Verticale__c asse : asseV)
        {
            asse.Update_Billing__c = false;
        }
        
        update asseV;
    }
    public static void updateSyncVErticaleFlag(List<string> ids){
        List<asset> assets = [Select id,Sync_Verticali__c from Asset where Id in : ids];
        
        for (Asset asse : assets)
        {
            asse.Sync_Verticali__c = false;
        }
        
        update assets;
        
    }
    public static void updateSyncNoVErticaleFlag(List<string> ids){
        List<asset> assets = [Select id,OF_SyncNoVert__c from Asset where Id in : ids];
        
        for (Asset asse : assets)
        {
            asse.OF_SyncNoVert__c = false;
        }
        
        update assets;
        
    }
    public static List<OF_Asset_Verticale__c> getVErts(string IdAssV){
        List<OF_Asset_Verticale__c> verts = [Select id, Update_Billing__c,Asset__c
                                             from OF_Asset_Verticale__c
                                             where id = :IdAssV];
        
        return verts;
    }
    public static List<OF_Billing_Element_Verticale__c> getBEV(List<string> AssetIds){
        List<OF_Billing_Element_Verticale__c> Bev = [Select id, Update_Billing__c,Asset__c
                                                     from OF_Billing_Element_Verticale__c
                                                     where Asset__c in:AssetIds
                                                     and Update_Billing__c =true];
        
        return Bev;
    }
    public static OF_CommercialElementIstanziato__c getCeiById(string IdCei){
        OF_CommercialElementIstanziato__c cei = [select id,OF_DataAttivazione__c,OF_Stato__c,Name,
                                                 Provincia__c,Comune__c,Indirizzo__c,
                                                 OF_BillingSyncronized__c,Asset_Verticale__c,
                                                 OF_DataCessazione__c,Civico__c,Particella_Toponomastica__c,
                                                 OF_CommercialElement__r.OF_Commercial_Element_Code__c,
                                                 OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,
                                                 OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c,
                                                 OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c,
                                                 ID_GIS_Scala_Palazzina__c,ID_DB_Building__c,UI_Scala_Palazzina__c,
                                                 ID_DB_Scala_Palazzina__c,OF_CommercialElement__r.Name,
                                                 OF_Asset__c,OF_Asset__r.name,OF_Asset__r.Account.name,
                                                 OF_Asset__r.Account.AccountNumber,
                                                 OF_Asset__r.OF_DataAttivazione2__c,
                                                 OF_Asset__r.OF_Provincia__c,
                                                 OF_Asset__r.OF_Comune__c,
                                                 OF_Asset__r.Status,
                                                 OF_Asset__r.OF_Indirizzo__c,
                                                 OF_Asset__r.OF_Civico__c,
                                                 OF_Asset__r.OF_Particella_Toponomastica__c,
                                                 OF_Asset__r.EOF_ID_Risorsa__c,
                                                 OF_Asset__r.OF_Contract__c,
                                                 OF_Asset__r.recordType.name
                                                 from OF_CommercialElementIstanziato__c
                                                 where Id =: IdCei Limit 1];
        
        return cei;
    }   
    public static string checkfieldCustom(CustomObject wrp){
        OF_CommercialElementIstanziato__c cei = wrp.cei;
        string rt = cei.RecordType.DeveloperName;
        List<PricebookEntry> beis = wrp.bei;
        
        if ((wrp.action != 'Activate') && (wrp.action != 'Modify') && (wrp.action != 'Change') && (wrp.action != 'Terminate'))
        {
            return 'action';
        }
        if ((wrp.operationType != 'Create') && (wrp.operationType != 'Update'))
        {
            return 'operationType';
        }
        if (wrp.activationOrder.EffectiveDate == null)
        {
            return 'Data Ordine';
        }
        if ((wrp.activationOrder.Contract.ContractNumber == null) || (wrp.activationOrder.Contract.ContractNumber.length() > 255))
        {
            return 'Contract ContractNumber';
        }
        if ((wrp.cei.OF_Asset__r.Account.AccountNumber == null) || (wrp.cei.OF_Asset__r.Account.AccountNumber.length() > 30))
        {
            return 'Account Number';
        }
        if ((wrp.activationOrder.Contract.OF_IdContratto__c == null) || (wrp.activationOrder.Contract.OF_IdContratto__c.length() > 30))
        {
            return 'Contract OF_IdContratto__c';
        }
        if ((wrp.activationOrder.OF_IDOrdineOLO__c  == null) || (wrp.activationOrder.OF_IDOrdineOLO__c.length() > 255))
        {
            return 'Order OF_IDOrdineOLO__c';
        }
        if (wrp.activationOrder.EffectiveDate == null)
        {
            return 'Order EffectiveDate';
        }
        if ((wrp.activationOrder.OrderNumber == null) || (wrp.activationOrder.OrderNumber.length() > 120))
        {
            return 'Order Number';
        }
        if (wrp.cei.OF_Asset__r.OF_DataAttivazione2__c == null)
        {
            return 'Asset data espletamento';
        }
        if (cei.OF_DataAttivazione__c == null)
        {
            return 'Commercial element istanziato Data Attivazione';
        }
        if ('Cessato'.equals(cei.OF_Stato__c) && (cei.OF_DataCessazione__c == null))
        {
            return 'Commercial element istanziato endDate';
        }
        if ((cei.OF_CommercialElement__r.OF_Commercial_Element_Code__c == null) || (cei.OF_CommercialElement__r.OF_Commercial_Element_Code__c.length() > 255))
        {
            return 'Commercial element code';
        }
        if ((cei.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c == null) || (cei.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c.length() > 30))
        {
            return 'Servizio Code';
        }
        
        if('Verticale'.equals(rt)){
            if ((wrp.cei.Comune__c == null) || (wrp.cei.Comune__c.length() > 255))
            {
                return 'Commercial element Istanziato Comune';
            }
            if ((wrp.cei.Indirizzo__c == null) || (wrp.cei.Indirizzo__c.length() > 255))
            {
                return 'Commercial element Istanziato Indirizzo';
            }
            if ((wrp.cei.Civico__c == null) || (wrp.cei.Civico__c.length() > 255))
            {
                return 'Commercial element Istanziato Civico';
            }
            if ((wrp.cei.Particella_Toponomastica__c == null) || (wrp.cei.Particella_Toponomastica__c.length() > 255))
            {
                return 'Commercial element Istanziato particella toponomastica';
            }
            if ((cei.ID_GIS_Scala_Palazzina__c == null) || (cei.ID_GIS_Scala_Palazzina__c.length() > 255))
            {
                return 'CEI Id GIS Scala';
            }
            if ((cei.ID_DB_Scala_Palazzina__c == null) || (cei.ID_DB_Scala_Palazzina__c.length() > 255))
            {
                return 'CEI Id Scala OM';
            }
            if ((cei.UI_Scala_Palazzina__c == null) || (string.valueOf(cei.UI_Scala_Palazzina__c).length() > 255))
            {
                return 'CEI UI Scala palazzina';
            }
            if ((cei.ID_DB_Building__c == null) || (cei.ID_DB_Building__c.length() > 255))
            {
                return 'CEI Id Building';
            }
        }
        else{
            if('PO_Portalino'.equals(rt)){
                if(cei.OF_Asset__r.Accordo_Operativo__c == null || (cei.OF_Asset__r.Accordo_Operativo__c.length() > 255))
                {
                    return 'Asset Accordo Operativo';
                }
            }            
            /*if ((cei.OF_Asset__r.OF_Comune__c == null) || (cei.OF_Asset__r.OF_Comune__c.length() > 255))
            {
                return 'Asset Comune';
            }
            if ((cei.OF_Asset__r.OF_Indirizzo__c == null) || (cei.OF_Asset__r.OF_Indirizzo__c.length() > 255))
            {
                return 'Asset Indirizzo';
            }
            if ((cei.OF_Asset__r.OF_Civico__c == null) || (cei.OF_Asset__r.OF_Civico__c.length() > 255))
            {
                return 'Asset Civico';
            }
            if ((cei.OF_Asset__r.OF_Particella_Toponomastica__c == null) || (cei.OF_Asset__r.OF_Particella_Toponomastica__c.length() > 255))
            {
                return 'Asset particella toponomastica';
            }*/
            if('Sospeso'.equals(cei.OF_Stato__c) && cei.OF_DataSospensione__c == null)
            {
                return 'Commercial element Istanziato Data Di Sospensione';
            }
        }
        if (cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c == null)
        {
            return 'Servizio Inizio Validità';
        }
        if (cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c == null)
        {
            return 'Servizio Fine Validità';
        }
        if ((cei.OF_Asset__r.EOF_ID_Risorsa__c == null) || (cei.OF_Asset__r.EOF_ID_Risorsa__c.length() > 255))
        {
            return 'Asset Id Risorsa';
        }
        if('OF_INTERVENTO_DI_MANUTENZIONE'.equals(rt))
        {
            if(cei.OF_TT_Number__c== null || cei.OF_TT_Number__c.length() >30)
            {
                return 'CEI TT Number';
            }
            else
                if(cei.OLO_Comm_Code__c== null || cei.OLO_Comm_Code__c.length() >30)
            {
                return 'CEI Olo Communication Code';
            }
        }
        else if('Intervento_a_vuoto'.equals(rt))
        {
			if(cei.Descrizione_IAV__c== null || cei.Descrizione_IAV__c.length() >30)
            {
                return 'CEI Descrizione IAV';
            }
            else if(cei.Code_IAV__c== null || cei.Code_IAV__c.length() >255)
            {
                return 'CEI Code IAV';
            }
        }
        
        if(beis==null || beis.size() == 0 )
        {
            return 'Billing Element size';
        }
        else 
        {
            for (PricebookEntry cbei : beis)
            {
                if('PO_Portalino'.equals(rt) && cbei.UnitPrice == null)
                {
                    return 'BEI Unit Price';
                }
                if (cbei.OF_DataAttivazione2__c == null)
                {
                    return 'BEI StartDate';
                }
                
                if (!'Verticale'.equals(wrp.CEI.recordType.DeveloperName) && ('OF_OpenStream'.equals(wrp.CEI.OF_Asset__r.recordType.DeveloperName) || 'PO_Asset_P2P_Attiva_Collegamento'.equals(wrp.CEI.OF_Asset__r.recordType.DeveloperName)) && 'Canone'.equals(cbei.Product2.Name))
                {
                    if ((wrp.CEI.OF_Asset__r.OF_ProfiloOpenStream__c == null) || (wrp.CEI.OF_Asset__r.OF_ProfiloOpenStream__c.length() > 30))
                    {
                        return 'Asset Profilo Open Stream';
                    }
                }
                else if ((cbei.Product2.OF_BillingElement__r.OF_Billing_Element_Code__c == null) || (cbei.Product2.OF_BillingElement__r.OF_Billing_Element_Code__c.length() > 30))
                {
                    return 'Billing Element code';
                }
                if (string.valueOf(cbei.Id).length() > 30)
                {
                    return 'BEI Id';
                }
            }
            return 'true'; 
        }
    }
    public static List<EOF_Notify__c> createListNotifyCustom(List<CustomObject> calls){
        Id rt = [Select Id from RecordType where DeveloperName ='EOF_BILL_Asset' Limit 1].Id;
        List<EOF_Notify__c> notifiche = new List<EOF_Notify__c>();
        
        List<EOF_Notify__c> n = [SELECT Id, indice__c FROM EOF_Notify__c WHERE RecordType.DeveloperName = 'EOF_BILL_Asset'
                                 AND indice__c != null ORDER BY indice__c DESC LIMIT 1];
        Decimal i = 1;
        if (!n.isEmpty()) {
            i = n.get(0).indice__c + 1;
        }
        
        for (CustomObject wrp: calls) {
            EOF_Notify__c notifica = new EOF_Notify__c();
            notifica.Asset__c=wrp.cei.OF_Asset__c;
            notifica.Commercial_element_istanziato__c = wrp.Cei.Id;
            notifica.RecordTypeId=rt;
            notifica.OF_isElaborato__c = true;
            notifica.OF_Billing_Type__c=wrp.action;
            notifica.OF_JsonRequest__c = wrp.JsonString;
            notifica.OF_Billing_OperationType__c = wrp.operationType;
            notifica.EOF_ID_Notifica__c = wrp.notificaId;
            notifica.indice__c = i++;
            wrp.notifica = notifica;
            notifiche.add(notifica);
        }
        
        return notifiche;
    }
    @future(callout=true)
    public static void CallCei(string IdCei, string nId){
        Boolean b = SyncBillingAssetUtils.callWSAssetVerticaleByCei(IdCei,nId);
        if(b){
            EOF_Notify__c n = [select Asset__c,Commercial_element_istanziato__r.Asset_Verticale__c from EOF_Notify__c where EOF_ID_Notifica__c=:nId Limit 1];
            List<OF_Billing_Element_Verticale__c> bevs = getBEV(new List<string> {n.Asset__c});
            List<OF_Asset_Verticale__c> verts = getVErts(n.Commercial_element_istanziato__r.Asset_Verticale__c);    
            UpdateAssetVert(verts);
            UpdateBev(bevs);
        }
    }
    public static OF_Billing_Outbound_Schema3.OrderItemType createOrderItemTypeCustom(CustomObject wrp){
        OF_Billing_Outbound_Schema3.OrderItemType orderItem = new OF_Billing_Outbound_Schema3.OrderItemType();
        DateTime tmp = Datetime.now();
        DAte d = wrp.activationOrder.EffectiveDate;
        Datetime orderDate = DateTime.newInstance(d.year(), d.month(), d.day());
        orderItem.operationType=wrp.operationType;
        orderItem.action=wrp.action;
        orderItem.timestamp =tmp.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        orderItem.OFCodeOrder=wrp.activationOrder.OrderNumber;
        orderItem.notificaId=wrp.notificaId;
        orderItem.commercialElementIstanziato= wrp.CEI.Name;
        orderItem.orderDate = orderDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        orderItem.accountNumber = wrp.CEI.OF_Asset__r.Account.AccountNumber;
        orderItem.contractNumber=wrp.activationOrder.Contract.ContractNumber;
        orderItem.currencyCode='EUR';
        orderItem.commercialElementCode=wrp.CEI.OF_CommercialElement__r.OF_Commercial_Element_Code__c;
        orderItem.numeroBillingElement=wrp.bei.size();
        if('Verticale'.equals(wrp.cei.RecordType.DeveloperName))
        {
            orderItem.startDateCEI=wrp.CEI.OF_Asset__r.OF_DataAttivazione2__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        }
        else if('PO_Portalino'.equals(wrp.cei.RecordType.DeveloperName))
        {
            Date d1 = wrp.CEI.OF_Asset__r.Data_Avvio_Fatturazione__c;
            orderItem.startDateCEI=DateTime.newInstance(d1.year(), d1.month(), d1.day()).format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        }
        else
        {
            orderItem.startDateCEI=wrp.CEI.OF_DataAttivazione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        }
        if ('Cessato'.equals(wrp.CEI.OF_Stato__c))
        {
            orderItem.endDateCEI = wrp.cei.OF_DataCessazione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        }
        orderItem.servizioCode=wrp.cei.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c;
        orderItem.expectedDate=wrp.CEI.OF_Asset__r.OF_DataAttivazione2__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
        return orderItem;
    }
    public static OF_Billing_Outbound_Schema3.OrderItemOtherType createOrderItemOtherTypeCustom(CustomObject wrp){
        OF_Billing_Outbound_Schema3.OrderItemOtherType orderItemOther = new OF_Billing_Outbound_Schema3.OrderItemOtherType();
        if('Verticale'.equals(wrp.CEI.recordType.DeveloperName)){
            orderItemOther.city=wrp.CEI.Comune__c;
            orderItemOther.street=wrp.CEI.Indirizzo__c;
            orderItemOther.streetNumber=wrp.CEI.Civico__c;
            orderItemOther.toponymyParticle=wrp.CEI.Particella_Toponomastica__c;
            orderItemOther.idScalaPNI_GIS=wrp.cei.ID_GIS_Scala_Palazzina__c;
            orderItemOther.idScalaOM=wrp.cei.ID_DB_Scala_Palazzina__c;
            orderItemOther.idBuilding=wrp.cei.ID_DB_Building__c;
            orderItemOther.UI=string.valueOf(wrp.cei.UI_Scala_Palazzina__c);
            orderItemOther.agreementOperationCode=wrp.activationOrder.Contract.OF_IdContratto__c;
        }
        else {
            orderItemOther.city=wrp.cei.OF_Asset__r.OF_Comune__c;
            orderItemOther.street=wrp.CEI.OF_Asset__r.OF_Indirizzo__c;
            orderItemOther.streetNumber=wrp.CEI.OF_Asset__r.OF_Civico__c;
            orderItemOther.toponymyParticle=wrp.CEI.OF_Asset__r.OF_Particella_Toponomastica__c;
            if('PO_Portalino'.equals(wrp.CEI.recordType.DeveloperName)){
            orderItemOther.agreementOperationCode=wrp.CEI.OF_Asset__r.Accordo_Operativo__c;
            }
            else{
               orderItemOther.agreementOperationCode=wrp.activationOrder.Contract.OF_IdContratto__c;
            }
            //orderItemOther.idBuilding=wrp.cei.OF_Asset__r.OF_ID_Building__c;	   
            /*if('Sospeso'.equals(wrp.cei.OF_Stato__c))
{
orderItemOther.suspendDate= wrp.cei.OF_DataSospensione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
}*/
        }
        orderItemOther.operatorOrderCode=wrp.activationOrder.OF_IDOrdineOLO__c;
        Date beginDate =  wrp.Cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c;
        Date endDate =  wrp.Cei.OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c;
        orderItemOther.durataFornituraDelServizio=string.valueOf(beginDate.monthsBetween(endDate));
        orderItemOther.idRisorsa=wrp.cei.OF_Asset__r.EOF_ID_Risorsa__c;
        system.debug('@@@@@@@@@test: '+orderItemOther.city);
        return orderItemOther;
    }
    public static OF_Billing_Outbound_Schema3.orderItemPrices_element createOrderItemPrices_elementCustom(CustomObject wrp){
        OF_Billing_Outbound_Schema3.orderItemPrices_element orderItemPrices = new OF_Billing_Outbound_Schema3.orderItemPrices_element();
        List<OF_Billing_Outbound_Schema3.OrderItemPriceType> res = new List<OF_Billing_Outbound_Schema3.OrderItemPriceType>();
        for (PricebookEntry pe : wrp.bei)
        {
            OF_Billing_Outbound_Schema3.OrderItemPriceType ordItemPrice = new OF_Billing_Outbound_Schema3.OrderItemPriceType();
            
            if(pe.Quantity__c!=null)
                ordItemPrice.quantity=pe.Quantity__c.intValue();
            else
            {
                ordItemPrice.quantity=1;
            }
            ordItemPrice.price=null;
            //gestione del price per i servizi a fattibilità
            if('PO_Portalino'.equals(wrp.cei.RecordType.DeveloperName))
            {
                ordItemPrice.price=pe.UnitPrice;
            }
            if('Verticale'.equals(wrp.cei.RecordType.DeveloperName))
            {
                ordItemPrice.startDateBEI=wrp.CEI.OF_Asset__r.OF_DataAttivazione2__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
            }
            else if('PO_Portalino'.equals(wrp.cei.RecordType.DeveloperName))
            {
                Date d = wrp.CEI.OF_Asset__r.Data_Avvio_Fatturazione__c;
                ordItemPrice.startDateBEI=DateTime.newInstance(d.year(), d.month(), d.day()).format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
            }
            else
            {
                ordItemPrice.startDateBEI=wrp.CEI.OF_DataAttivazione__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
            }
            if (pe.OF_DataCessazione2__c != null)
            {
                ordItemPrice.endDateBEI=pe.OF_DataCessazione2__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS');
            }
            
            if (!'Verticale'.equals(wrp.CEI.recordType.DeveloperName) && ('OF_OpenStream'.equals(wrp.CEI.OF_Asset__r.recordType.DeveloperName) || 'PO_Asset_P2P_Attiva_Collegamento'.equals(wrp.CEI.OF_Asset__r.recordType.DeveloperName)) && 'Canone'.equals(pe.Product2.Name))
            {
                ordItemPrice.priceBookName=wrp.CEI.OF_Asset__r.OF_ProfiloOpenStream__c;
            }
            else
            {
                ordItemPrice.priceBookName=pe.Product2.OF_BillingElement__r.OF_Billing_Element_Code__c;
            }
            if('Intervento_a_vuoto'.equals(wrp.CEI.recordType.DeveloperName))
            {
                ordItemPrice.code_IAV= wrp.cei.Code_IAV__c;
                ordItemPrice.descrizioneIAV=wrp.cei.Descrizione_IAV__c;
            }
            else if ('OF_INTERVENTO_DI_MANUTENZIONE'.equals(wrp.CEI.recordType.DeveloperName))
            {
                ordItemPrice.numeroTT=wrp.cei.OF_TT_Number__c;
                ordItemPrice.codiceComunicazioneOLO=wrp.cei.OLO_Comm_Code__c;
            }
            ordItemPrice.billingElementIstanziato=string.valueOf(pe.Id);
            res.add(ordItemPrice);
            
            
        }
        orderItemPrices.orderItemPrice = res;
        return orderItemPrices;
    }
    public static List<PricebookEntry> getListBEICustom(List<string> ceiIds){
        List<PricebookEntry> bei = [select id,OF_Asset__r.OF_Contract__r.BillingFrequency__c,
                                    Product2.OF_BillingElement__r.OF_Billing_Element_Code__c,
                                    OF_Asset__r.OF_Case__r.OF_TT_Number__c,OF_DataCessazione2__c,
                                    OF_DataAttivazione2__c,Pricebook2.Name,UnitPrice,numCoppia__c,
                                    Quantity__c,Product2.Name,
                                    OF_CommercialElementIstanziato__c
                                    from PricebookEntry
                                    where OF_CommercialElementIstanziato__c in: ceiIds];
        return bei;
    }
    public static List<OF_CommercialElementIstanziato__c> getListCEIDrop1(List<string> AssetIds){
        List<OF_CommercialElementIstanziato__c> cei = [select id,OF_DataAttivazione__c,OF_Stato__c,
                                                       Name,Asset_Verticale__c,
                                                       LastModifiedDate,
                                                       RecordType.DeveloperName,
                                                       OF_BillingSyncronized__c,
                                                       Provincia__c,Comune__c,Indirizzo__c,
                                                       OF_DataCessazione__c,Civico__c,Particella_Toponomastica__c,
                                                       OF_CommercialElement__r.OF_Commercial_Element_Code__c,
                                                       OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,
                                                       OF_CommercialElement__r.OF_Servizio__r.OF_DataInizioValidita__c,
                                                       OF_CommercialElement__r.OF_Servizio__r.OF_DataFineValidita__c,
                                                       ID_GIS_Scala_Palazzina__c,ID_DB_Building__c,UI_Scala_Palazzina__c,
                                                       ID_DB_Scala_Palazzina__c,OF_CommercialElement__r.Name,
                                                       OF_Asset__c,OF_Asset__r.name,OF_Asset__r.Account.name,
                                                       OF_Asset__r.Account.AccountNumber,
                                                       OF_Asset__r.OF_DataAttivazione2__c,
                                                       OF_Asset__r.OF_Provincia__c,
                                                       OF_Asset__r.OF_Comune__c,
                                                       OF_Asset__r.Status,
                                                       OF_Asset__r.OF_Indirizzo__c,
                                                       OF_Asset__r.OF_Civico__c,
                                                       OF_Asset__r.OF_Particella_Toponomastica__c,
                                                       OF_Asset__r.EOF_ID_Risorsa__c,
                                                       OF_Asset__r.OF_Contract__c,
                                                       OF_Asset__r.recordType.name
                                                       from OF_CommercialElementIstanziato__c
                                                       where (OF_Stato__c = 'Attivo' or OF_Stato__c ='Cessato')
                                                       and OF_Asset__r.recordType.name in('Open Stream', 'GPON Passiva')
                                                       and OF_Asset__c in:AssetIds
                                                       and RecordType.DeveloperName ='Verticale'
                                                       order by CreatedDate desc];
        return cei;
    }
    public static List<Order > getOrders(List<string> AssetIds){
        List<Order > orders = [select id,
                               EffectiveDate,
                               OrderNumber,
                               OF_Asset__c,
                               OF_IDOrdineOLO__c,
                               Contract.ContractNumber,
                               Contract.OF_IdContratto__c,
                               Account.EOF_Codice_Operatore__c
                               from Order
                               where OF_Asset__c in:AssetIds
                               and Status ='Chiuso'
                               and OF_Esito__c='OK'
                               and RecordType.DeveloperName = 'OF_INORDER'];
        return orders;  
    } 
    public static List<Order > getOrdersNoVert(List<string> AssetIds){
        List<Order > orders = [select id,
                               EffectiveDate,
                               OrderNumber,
                               OF_Asset__c,
                               RecordType.DeveloperName,
                               OF_DataEsito__c,
                               OF_IDOrdineOLO__c,
                               Contract.ContractNumber,
                               Contract.OF_IdContratto__c,
                               Account.EOF_Codice_Operatore__c
                               from Order
                               where OF_Asset__c in:AssetIds
                               and Status ='Chiuso'
                               and OF_Esito__c='OK'
                               order by OF_DataEsito__c DESC ];    
        return orders;  
    } 
    public static string createRequest(OF_Billing_Outbound_Schema3.OrderItemType orderItem,OF_Billing_Outbound_Schema3.OrderItemOtherType orderItemOther, OF_Billing_Outbound_Schema3.orderItemPrices_element orderItemPrices ){
        system.debug('@@@@@@@@@@@@orderItemOther.city: '+ orderItemOther.city);
        string request ='\ntype: ' + orderItem.operationType +
            '\naction: ' + orderItem.action +
            '\ntimestamp ' + orderItem.timestamp +
            '\nOFCodeOrder ' + orderItem.OFCodeOrder +
            '\nnotificaId ' + orderItem.notificaId +
            '\ncommercialElementIstanziato ' + orderItem.commercialElementIstanziato +
            '\norderDate ' + orderItem.orderDate +
            '\naccountNumber ' + orderItem.accountNumber +
            '\ncontractNumber ' + orderItem.contractNumber +
            '\ncurrencyCode ' + 'EUR' +
            '\nnumeroBillingElement ' + orderItem.numeroBillingElement +
            '\nstartDateCEI ' + orderItem.startDateCEI +
            '\nendDateCEI ' + orderItem.endDateCEI +
            '\nservizioCode ' + orderItem.servizioCode +
            '\nexpectedDate ' + orderItem.expectedDate +
            '\ncity ' + orderItemOther.city +
            '\nstreet ' + orderItemOther.street +
            '\nstreetNumber ' + orderItemOther.streetNumber +
            '\ntoponymyParticle ' + orderItemOther.toponymyParticle +
            '\nagreementOperationCode ' + orderItemOther.agreementOperationCode +
            '\nidScalaPNI_GIS ' + orderItemOther.idScalaPNI_GIS +
            '\nidScalaOM ' + orderItemOther.idScalaOM +
            '\nidBuilding ' + orderItemOther.idBuilding +
            '\nUI ' + orderItemOther.UI +
            '\noperatorOrderCode ' + orderItemOther.operatorOrderCode +
            '\ndurataFornituraDelServizio ' + orderItemOther.durataFornituraDelServizio +
            '\nverticalOperator ' + orderItemOther.verticalOperator +
            '\nsuspendDate ' + orderItemOther.suspendDate +
            '\napparatusType ' + orderItemOther.apparatusType +
            '\nidRisorsa ' + orderItemOther.idRisorsa;
        for (OF_Billing_Outbound_Schema3.OrderItemPriceType orderType : orderItemPrices.orderItemPrice){
            request = request + '\nsourcePricetypeCode' + orderType.sourcePricetypeCode
                + '\nquantity' + orderType.quantity
                + '\nprice' + orderType.price
                + '\nbillingFrequency' + orderType.billingFrequency
                + '\nstartDateBEI' + orderType.startDateBEI
                + '\nendDateBEI' + orderType.endDateBEI
                + '\npriceBookName' + orderType.priceBookName
                + '\nbillingElementIstanziato' + orderType.billingElementIstanziato
                + '\ncode_IAV' + orderType.code_IAV
                + '\ndescrizioneIAV' + orderType.descrizioneIAV
                + '\nnumeroTT' + orderType.numeroTT
                + '\ncodiceComunicazioneOLO' + orderType.codiceComunicazioneOLO
                + '\nattivitaEseguita' + orderType.attivitaEseguita
                + '\npromotionCode' + orderType.promotionCode
                + '\npromotionTarget' + orderType.promotionTarget
                + '\nflagPromotionAchieved' + orderType.flagPromotionAchieved;
        }
        return request;
    }
    public static List<String> getListAssetId(List<OF_Billing_Element_Verticale__c> bevs){
        Set<String> res = new Set<String>();
        for (OF_Billing_Element_Verticale__c b : bevs) {
            res.add(b.Asset__c);
        }
        return new List<String>(res);
    }
    public static List<String> getListAssetId(List<Asset> assets){
        Set<String> res = new Set<String>();
        for (Asset b : assets) {
            res.add(b.Id);
        }
        return new List<String>(res);
    }
    public static void callVerticalBatch(string IdAsset){
        List<String> Ids = new List<string> {IdAsset};
            OF_SyncBillingVerticaleBatch batch = new OF_SyncBillingVerticaleBatch(Ids);
        Database.executeBatch(batch);
    }
    //metodo richiamato dal trigger
    public static void callFattibilitaBatch(string IdAsset){
        List<String> Ids = new List<string> {IdAsset};
            OF_SyncBillingFattibilitaBatch batch = new OF_SyncBillingFattibilitaBatch(Ids);
        Database.executeBatch(batch);
    }
    //metodo richiamato da OF_SyncBillingFattibilitaBatch
    public static void callWSAssetFattibilitaCustom(List<OF_CommercialElementIstanziato__c> ceis){
        List<OF_CommercialElementIstanziato__c> cei= new List<OF_CommercialElementIstanziato__c>();
        for(OF_CommercialElementIstanziato__c c : ceis)
        {
            if('PO_Portalino'.equals(c.recordType.developerName))
            {
                if(c.OF_Asset__r.Data_Avvio_Fatturazione__c!= null)
                {
                    cei.add(c);
                }
            }
            else
            {
                cei.add(c);
            }
        }
        List<string> ceiIds = new List<string>();
        List<String> ceiAssetId = new List<string>();
        for (OF_CommercialElementIstanziato__c ce : cei) {
            ceiIds.add(ce.id);
            ceiAssetId.add(ce.OF_Asset__c);
        }
        try {
            
            
            List<PricebookEntry> beis = getListBEICustom(ceiIds);
            List<Order> orders = getOrdersNoVert(ceiAssetId);
            Map<string,Order> mapOrder = new Map<string,Order>();
            for (Order ord : orders) {
                if(!mapOrder.containsKey(ord.OF_Asset__c))
                {
                    mapOrder.put(ord.OF_Asset__c,ord);
                }            
            } 
            system.debug('@@@@@@Order'+mapOrder);
            Map<String,List<PricebookEntry>> mapBei = new Map<String,List<PricebookEntry>>();
            for (PricebookEntry be : beis) {
                List<PricebookEntry> pe = mapBei.get(be.OF_CommercialElementIstanziato__c);
                if (pe == null)
                {
                    pe = new List<PricebookEntry>();
                    mapBei.put(be.OF_CommercialElementIstanziato__c, pe);
                }
                pe.add(be);
            }
            List<CustomObject> callTodo = new  List<CustomObject>();  
            Integer i = 1;
            for (OF_CommercialElementIstanziato__c ce : cei) {
                CustomObject co = new CustomObject();
                co.CEI = ce;
                co.activationOrder = mapOrder.get(ce.OF_Asset__c);
                co.bei = mapBei.get(ce.Id);    
                
                system.debug('@@@@@@CEI'+ce);
                
                system.debug('@@@@@@wrp.cei.OF_Asset__r.Account' + ce.OF_Asset__r.Account);
                if('OF_CHANGEORDER'.equals(co.activationOrder.RecordType.DeveloperName))
                {
                    co.operationType = 'Update';
                    co.action='Change';
                }
                else if ('Cessato'.equals(ce.OF_Stato__c)) {
                    co.operationType = 'Update';
                    co.action='Terminate';
                }/* else if('PO_Portalino'.equals(ce.recordType.DeveloperName) && 'Sospeso'.equals(ce.OF_Stato__c)) {
co.operationType = 'Update';
co.action='Suspend';
}
else if('Desospeso'.equals(ce.OF_Stato__c))
{
co.operationType = 'Update';
co.action='Reactivate';
}*/
                else if (ce.OF_BillingSyncronized__c) {
                    co.operationType = 'Update';
                    co.action='Modify';
                }
                else 
                {
                    co.operationType = 'Create';
                    co.action='Activate';
                }
                String resCheck = checkfieldCustom(co);       
                System.debug('@@@@@@ dopo CheckField '  + resCheck);
                co.notificaId = String.valueOf(System.now().getTime()) + '_' + i;
                i++;
                if ('true'.equals(resCheck)) { 
                    CreateRequestForCall(co);
                }
                else
                {
                    co.errore = rescheck;
                }
                callTodo.add(co);
            }
            List<EOF_Notify__c> resnot= createListNotifyCustom(callTodo);
            insert resnot;
            List<EOF_EAI_Service_Log__c> logs =  createRequestLog(callTodo);
            insert logs;
        }
        catch (Exception ex)
        {
            system.debug('@@@@Exception ' + ex.getLineNumber() + '  ' + ex.getMessage());
        }
        finally
        {
            updateSyncNoVErticaleFlag(ceiAssetId);
        }
    }
    public static void CreateRequestForCall(CustomObject co){
        OF_Billing_Outbound_Schema3.OrderItemType orderItem = createOrderItemTypeCustom(co);
        OF_Billing_Outbound_Schema3.OrderItemOtherType orderItemOther = createOrderItemOtherTypeCustom(co);
        OF_Billing_Outbound_Schema3.orderItemPrices_element orderItemPrices = createOrderItemPrices_elementCustom(co);
        co.request = createRequest(orderItem,orderItemOther,orderItemPrices);
        OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType req = new OF_Billing_Outbound_Schema3.BillingOrderManagerRequestType();
        req.orderItem = orderItem;
        req.orderItemOther = orderItemOther;
        req.orderItemPrices = orderItemPrices;    
        co.JsonString = JSON.serialize(req);  
    } 
}