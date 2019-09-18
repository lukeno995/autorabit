public without sharing abstract class zzActivationBaseRequest {

    public static final String ATTIVAZIONE = 'Attivazione';
    public static final String COLLEGAMENTO_P2P_PASSIVA = 'P2P Passiva';

    protected Set<Id> collIDs;
    protected Map<Id, Case> map_collIDs_obj;
    
    protected OLO_Activation_P2PSchema.Create_P2P_Request_element request;
    protected OLO_Activation_P2PSchema.Header_Request header;
    protected OLO_Activation_P2PSchema.Fattibilita rqstFattibilita;
    
    protected String tipoRichiesta = ATTIVAZIONE;
    protected Id notifyId;

    public zzActivationBaseRequest(){}

    public zzActivationBaseRequest(Map<Id, Case> map_collIDs_obj) {
        this(map_collIDs_obj.keySet());
        this.map_collIDs_obj = map_collIDs_obj;
    }

    // se si usa questo costruttore riempire la mappa map_collIDs_obj usando il metodo fillCollIDsObj
    // o usando i setter
    public zzActivationBaseRequest(Set<Id> collIDs) {
        this.collIDs = collIDs;
        request = new OLO_Activation_P2PSchema.Create_P2P_Request_element();
        header = new OLO_Activation_P2PSchema.Header_Request();
        rqstFattibilita = new OLO_Activation_P2PSchema.Fattibilita();

        request.header = header;
        request.fattibilita = rqstFattibilita;
    }

    public Map<Id, Case> fillCollIDsObj() {
        System.debug('##### ActivationBaseRequest.fillCollIDsObj: costruzione mappa tra id case collegamento e '
            + 'e oggetti collegamento #####');
        map_collIDs_obj = new Map<Id,Case>();
        List<Case> collegamenti = null;
        if(collIDs == null) {
            throw new InvalidParameterValueException('fillCollIDsObj', 'The set IDs must not be null.');
        }
        System.debug('##### fillCollIDsObj - id cases collegamento: ' + collIDs);
        // in base al tipo di servizio (P2P Base, E-Access, E-Line, Housing) alcuni campi non saranno vuoti
        collegamenti = [SELECT CaseNumber, PO_Sito__c, PO_Indirizzo_collegamento__c, Particella_Toponomastica_1__c,
            PO_Civico__c,  PO_Nome_Comune__c, PO_Comune2__c, PO_Pop_1_di_riferimento2__c, EOF_Identificativo_del_POP__c,
            EOF_Codice_Ordine_OLO__c, PO_BB_1_interessato__c , PO_BB_2_interessato__c, PO_Posa_1_via_nuovo_Drop__c, 
            PO_Posa_2_via_nuovo_Drop__c, PO_BB_1_via_interessato__c, PO_BB_2_via_interessato__c, PO_Drop_FL_1__c, PO_Lunghezza_m__c,
            PO_Drop_FL_2__c, PO_Lunghezza_m2__c, EOF_Data_Prevista_Attivazione__c, PO_Disponibilit_della_rete_a_partire_da__c,
            Owner.Name, PO_PP_NomeKit__c , PO_Data_Attivazione_Richiesta__c, PO_Nome_E_Cognome_PM__c, PO_Numero_Telefonico_PM__c,
            PO_Prime_Contractor__c, PO_Numero_fibre_richieste__c, PO_Tipo_percorso__c, PO_Esito_collegamento__c, PO_Note_collegamento__c, 
            Tipologia_CPE__c, Tipologia_Alimentazione__c, Interfaccia_CPE__c, service_attribute__c, Traffic_Load_Balancing__c,
            OF_SA_Profilo__c, PO_Tipo_di_collegamento__c, PO_P2PAttiva_KIT_OpticalRateLimiting__c, 
            // info sede
            tipologia_sede__c, SF_Ccoll_ID_Sede__c, id_sede_master__c, id_sede_master__r.SF_Ccoll_ID_Sede__c,
            // info richiesta
            parent.CreatedDate, parent.EOF_Codice_Ordine_OLO__c, parent.EOF_Codice_Operatore_WS__c, parent.CreatedBy.Name, 
            parent.PO_Offerta__c,
            // info ordine
            (SELECT ParentId, PO_Case_Collegamento__c, EOF_Codice_Ordine_OLO__c, CreatedDate, 
            PO_Tipologia_Offerta_ordine__c FROM Cases),
            // info kit consegna
            PO_KIT_Consegna_VLAN__c, PO_KIT_Consegna_VLAN__r.EOF_Identificativo_del_POP__c, PO_KIT_Consegna_VLAN__r.PO_PP_NomeKit__c, 
            kit_in_condivisione__c,kit_in_condivisione__r.EOF_Identificativo_del_POP__c, kit_in_condivisione__r.PO_PP_NomeKit__c,
            // info pop e comune
            PO_Pop_1_di_riferimento2__r.name, PO_Comune2__r.OF_CodiceIstat__c, PO_Comune2__r.OF_Provincia__c
            FROM Case WHERE Id in: collIDs];

        map_collIDs_obj.putAll(collegamenti);
        return map_collIDs_obj;
    }

    public void createRequest() {
        createHeader();
        createFattibilita();

    }

    protected void createHeader() {
        header.TIPO_RICHIESTA = tipoRichiesta;
        header.DATA_CREAZIONE = System.now();
        header.ID_NOTIFICA = notifyId;
    }

    protected virtual void createFattibilita() {
        // questi valori sono uguali in tutti i collegamenti nella mappa in quanto sono 
        // campi del case richiesta di fattibilità
        if(!map_collIDs_obj.isEmpty()) {
            rqstFattibilita.DATA_FATTIBILITA = map_collIDs_obj.values()[0].parent.CreatedDate.date();
            rqstFattibilita.ID_FATTIBILITA = map_collIDs_obj.values()[0].parent.EOF_Codice_Ordine_OLO__c;
            rqstFattibilita.CODICE_OPERATORE = map_collIDs_obj.values()[0].parent.EOF_Codice_Operatore_WS__c;
            rqstFattibilita.FATTIBILITA_CREATA_DA = map_collIDs_obj.values()[0].parent.CreatedBy.Name;
            rqstFattibilita.TIPO_CONTRATTO = map_collIDs_obj.values()[0].parent.PO_Offerta__c;
            rqstFattibilita.NOTE = '';
        }
        createOrdine();
        createKit();      
    }

    // ogni collegamento deve è associato ad un ordine (e uno solo)
    protected virtual void createOrdine() {
        OLO_Activation_P2PSchema.ORDINE_element ordine = null ;
        List<OLO_Activation_P2PSchema.ORDINE_element> list_ordine = new List<OLO_Activation_P2PSchema.ORDINE_element>();

        OLO_Activation_P2PSchema.SEDE sede =null;  
        List<OLO_Activation_P2PSchema.SEDE> list_sede = null; 
        List<OLO_Activation_P2PSchema.APPARATI> list_apparati = null;  

        for(Id cID : map_collIDs_obj.keySet()) {
            ordine = new OLO_Activation_P2PSchema.ORDINE_element();
            sede = new OLO_Activation_P2PSchema.SEDE(); // subinput1
            list_sede = new List<OLO_Activation_P2PSchema.SEDE>();
            list_apparati = new List<OLO_Activation_P2PSchema.APPARATI>();

            ordine.AZIONE = tipoRichiesta;
            ordine.ID_ORDINE = map_collIDs_obj.get(cID).cases[0].EOF_Codice_Ordine_OLO__c;
            ordine.DATA_ORDINE = map_collIDs_obj.get(cID).cases[0].CreatedDate.date();
            
            // campi dipendenti dal tipo servizio - confronta OLO_ActivationP2PUtils
            /* ordine.TIPO_COLLEGAMENTO = '';
            sede.ID_SEDE = '';
            sede.TIPOLOGIA_SEDE = '';
            sede.ID_SEDE_MASTER = '';
            sede.OPTICAL_RATE_LIMITING = '';
            sede.SERVICE_ATTRIBUTE = ''; */
            setValuesByService(cID, ordine, sede);
            sede.NOME_SEDE = map_collIDs_obj.get(cID).PO_Sito__c;
            
            findKitConsegna(cId);  // getKitConsegna
            findPOPAndComuni(); // getCollegmIdToPOPAndElencoComuni
            findVlans(); // createVlanMap
            findMaster();

            list_sede.add(sede);
            ordine.SubInput1 = list_sede;
            list_ordine.add(ordine);
        }
        rqstFattibilita.ORDINE = list_ordine;

    }

    protected abstract void setValuesByService(Id cID, OLO_Activation_P2PSchema.ORDINE_element ordine, OLO_Activation_P2PSchema.SEDE sede);

    protected virtual void createKit() {}

    protected abstract void findKitConsegna(Id collId);

    protected virtual void findPOPAndComuni() {
    }

    protected virtual void findVlans() {
    }

    protected virtual void findMaster() {
    }

    public OLO_Activation_P2PSchema.Create_P2P_Request_element getRequest() {
        return request;
    }

    public void setNotifyId(Id notifyId) {
        this.notifyId = notifyId;
    }

    public Id getNotifyId() {
        return notifyId;
    }

    public void setCollIDs(Set<Id> collIDs) {
        this.collIDs = collIDs;
    }

    public Set<Id> getcollIDs() {
        return collIDs;
    }

    public void setMap_collIDs_obj(Map<Id, Case> map_collIDs_obj) {
        this.map_collIDs_obj = map_collIDs_obj;
    }

    public Map<Id, Case> getMap_collIDs_obj() {
        return map_collIDs_obj;
    }

}