public with sharing class PO_ServiziFattDomFactory {

    private static final String rTypeNameToGetSetting = 'PO_Ordine_P2P_Attiva';

    PO_ServiziFattDomFactory() {
    }

    public static PO_ServiziFattDom getHandler(String caseRecordType) {
        if('PO_Ordine_P2P_Attiva'.equals(caseRecordType)) {
            return new PO_ServiziFattDOMOrdineHandler(rTypeNameToGetSetting);
        } else if('PO_Case_P2P_Attiva_KIT'.equals(caseRecordType))  {
            return new PO_ServiziFattDOMKitHandler(rTypeNameToGetSetting);
        } else {
            throw new InvalidParameterValueException('PO_ServiziFattDomFactory.getHandler: invalid record type developer name: ', caseRecordType);
        }
    }
}