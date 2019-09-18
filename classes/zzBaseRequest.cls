public without sharing virtual class zzBaseRequest {

    public static final String ATTIVAZIONE = 'Attivazione';

    protected Case fattibilita;
    protected List<Case> list_cCollegamento;
    protected List<Case> list_cOrdine;
    protected Map<Id,Id> map_collIdsOrdineIds;
    protected Map<Case,Case> map_collIdsOrdineCases;
    protected Map<Id,List<Case>> map_collIdsCollOrdinePair;
    
    protected OLO_Activation_P2PSchema.Create_P2P_Request_element request;
    protected OLO_Activation_P2PSchema.Header_Request header;
    protected OLO_Activation_P2PSchema.Fattibilita rqstFattibilita;
    
    protected String tipoRichiesta = ATTIVAZIONE;
    protected Id notifyId;

    public zzBaseRequest(Case fattibilita, Map<Id,Id> map_collIdsOrdineIds) {
        this.fattibilita = fattibilita;
        this.map_collIdsOrdineIds = map_collIdsOrdineIds;
        this.map_collIdsCollOrdinePair = fillCollOrdinePair(map_collIdsOrdineIds);
        request = new OLO_Activation_P2PSchema.Create_P2P_Request_element();
        header = new OLO_Activation_P2PSchema.Header_Request();
        rqstFattibilita = new OLO_Activation_P2PSchema.Fattibilita();

        request.header = header;
        request.fattibilita = rqstFattibilita;
    }

    private Map<Id,List<Case>> fillCollOrdinePair(Map<Id,Id> map_collIdsOrdineIds) {
        return null;
    }

    public virtual void createRequest() {
        createHeader();
        createFattibilita();

    }

    protected void createHeader() {
        header.TIPO_RICHIESTA = tipoRichiesta;
        header.DATA_CREAZIONE = System.now();
        header.ID_NOTIFICA = notifyId;
    }

    protected virtual void createFattibilita() {
        createOrdine();
        createKit();      
    }

    protected virtual void createOrdine() {
        findKitConsegna();
        findPOPAndComuni();
        findVlans();
        findMaster();
    }

    protected virtual void createKit() {}

    protected virtual void findKitConsegna() {
    }
    

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

}