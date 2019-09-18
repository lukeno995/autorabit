public without sharing virtual class PO_ServiziFattDOM extends PO_ServFatt_CRMHandler {

    public static final String ORDINE_COMMERCIAL_EL_NAME = 'Sede E-Access';
    public static final String KIT_COMMERCIAL_EL_NAME = 'KIT E-Access';

    public PO_ServiziFattDOM(String rTypeDevName) {
        super(rTypeDevName);
        System.debug('##### PO_ServiziFattDOMOrdineHandler - servizio ' + servizio);
        System.debug('##### PO_ServiziFattDOMOrdineHandler - srvData ' + srvData);
    }

    public virtual Id espletamentoOK(Case theCase) {
        return null;
    }
}