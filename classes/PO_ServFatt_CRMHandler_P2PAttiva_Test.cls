@isTest
public class PO_ServFatt_CRMHandler_P2PAttiva_Test {

	public static testMethod void testCRMHandler() {
		PO_ServFatt_DataFactory.WrapData data = PO_ServFatt_DataFactory.createP2PAttivaData();

		Case caseColleg = [SELECT Id, recordtypeid, EOF_Note_Operatore__c, Status, EOF_Note_Interne__c, EOF_Comunicazioni_con_OLO__c, recordType.Name,
						   EOF_Note__c, recordType.DeveloperName, PO_Note_fattibilit__c, PO_Assegnazione_Area_Geografica__c, EOF_Fase__c,
						   PO_Richiesta_a_fattibilit__c,PO_Richiesta_a_fattibilit__r.caseNumber, PO_Note_Network_Creation__c, PO_Note_Sospensione_OF__c, PO_Esito_collegamento__c,
						   PO_Data_Attivazione_Ordine__c, EOF_Id_Risorsa__c, PO_Note_Referente_Fattibilita__c, PO_Note_Tecnico_Fattibilita__c,
						   PO_Note_Supporto_Vendite__c, PO_BB_1_interessato__c, PO_Posa_1_nuovo_Drop__c, PO_Owner_Originario__c, PO_Drop_FL_1__c,
						   PO_Lunghezza_m__c, Owner.Id, Owner.Type, Note_Sospensione_Operatore__c, EOF_GPON_Attestazione__c, EOF_SLA_Premium_Assurance__c,
						   EOF_Apparato__c, EOF_Progetto_Speciale__c, EOF_Tipologia_Apparato__c, EOF_Password_Apparato__c, OF_SA_Profilo__c, OF_SA_Promozione__c,
						   OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Cluster_Promozione__c, OF_Esito_Consegna_Apparato__c, OF_SA_Codice_Motivazione__c,
						   OF_SA_Motivazione__c, EOF_ID_Building_WS__c, EOF_Identificativo_del_POP__c, EOF_Comune_WS__c, EOF_Provincia_WS__c,
						   EOF_Particella_Toponomastica_WS__c, EOF_Indirizzo_WS__c, EOF_Numero_Civico_WS__c, EOF_Scala_Palazzina_WS__c, PO_Attenuazione__c,
						   PO_Lunghezza_Ottica__c, PO_Posizione_Rilascio_Circuito_OSU__c, OF_Order__c,view_PopUp_PSM__c,view_error_file_PSM__c, ParentId, PO_P2P_Attiva__c,
						   isPsm__c,isClosed,EOF_Codice_Operatore_WS__c,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,PO_Costi_aggiuntivi_collegamento__c,
                           PO_Case_Collegamento__r.PO_Assegnazione_Area_Geografica__c,PO_KIT_Consegna_VLAN__c,PO_KIT_Consegna_VLAN__r.assetId,EOF_Codice_Ordine_OLO__c, AccountId,
                           OF_Order__r.ContractId, PO_Richiesta_a_fattibilit__r.PO_Offerta__c, PO_Costo_lavori_civili__c, PO_Costo_lavori_ottici__c, OF_IDContratto__c, PO_Accordo_Quadro__c, PO_Tipo_di_collegamento__c, PO_Tipologia_Offerta_ordine__c, PO_Offerta__c // RDG
                           FROM Case WHERE Id = :data.caseCollegamento.Id LIMIT 1];
        EOF_VLAN__c vlanObj = new EOF_VLAN__c();
        vlanObj.Caso__c = caseColleg.Id;
        insert vlanObj;
        
        Pricebook2 pb = new Pricebook2(
            Id = Test.getStandardPricebookId(),
			IsActive = true
		);

		update pb;

		Test.startTest();
		try {
			new PO_ServFatt_CRMHandler(null);
		} catch (InvalidParameterValueException e) {
			System.assertEquals(true, String.isNotBlank(e.getMessage()));
		}
		Opportunity oc = PO_ServFatt_OpportunityHandler.createOppChild(caseColleg);
		PO_ServFatt_CRMHandler_P2PAttiva crmh = new PO_ServFatt_CRMHandler_P2PAttiva(data.cs.caseDevName__c);
		crmh.espletamento(data.casePadre, true);
		crmh.espletamento(data.casePadre, false);
		Test.stopTest();
	}
}