public class PO_CO_DetailChangeOrder_Controller {
	public List<EOF_EAI_Service_Log__c> SlVLAN{get;set;}
	public boolean VLAN {get;set;}
	public List<EOF_EAI_Service_Log__c> slList{get;set;} 
	public EOF_EAI_Service_Log__c slOrig{get;set;}
	public string dataNotifica{get;set;}

    public PO_CO_DetailChangeOrder_Controller() {
        String idRisorsa=ApexPages.currentPage().getParameters().get('idRisorsa');
            
        slList = [select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                    EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                    EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                    EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                    EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                    EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,OF_SA_USER_VLAN__c,OF_SA_KIT_CONSEGNA_VLAN__c,
                    OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c,
                    EOF_STATO_ORDINE__c, EOF_Causale_Errore__c 
                    from EOF_EAI_Service_Log__c where id=:idRisorsa or OF_SA_VLan_Log__c=:idRisorsa]; 

        SlVLAN=new List<EOF_EAI_Service_Log__c>();
		
	    for(EOF_EAI_Service_Log__c slAgg : slList){
	    	if(slAgg.recordtype.developername=='PO_CO_FiberRequest'){
	    		slOrig=slAgg;
	    		dataNotifica=slOrig.EOF_Data_Notifica__c.format('dd-MM-YYYY HH:mm');
	    	}
	        else if(slAgg.recordtype.developername=='OF_SA_Vlan'){
	            SlVLAN.add(slAgg);        
	            VLAN=true;
	        }
        }

    }
}