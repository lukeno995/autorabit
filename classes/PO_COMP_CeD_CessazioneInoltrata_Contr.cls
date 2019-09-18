public class PO_COMP_CeD_CessazioneInoltrata_Contr {
    
    public EOF_EAI_Service_Log__c sl{get;set;}
    public List<EOF_EAI_Service_Log__c> SlApparati{get;set;}
    public boolean Apparati{get;set;}
    
    public PO_COMP_CeD_CessazioneInoltrata_Contr(){
    	
    	apparati=false;
    	
    	List<EOF_EAI_Service_Log__c> slList=[select id,recordtype.developername,EOF_Codice_Ordine_OLO__c,EOF_Data_Notifica__c,EOF_ID_Notifica__c,EOF_NOME_REFERENTE_TECNICO_OLO__c,
                                			EOF_COGNOME_REFERENTE_TECNICO_OLO__c,EOF_Telefono_Referente_OLO_Onfield_Notec__c,EOF_TELEFONO_REFERENTE_TECNICO_OLO__c,
                                			EOF_Nome_Cliente__c,EOF_COgnome_CLiente__c,EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,EOF_RECAPITO_TELEFONICO_CLIENTE_2__c,
                                			EOF_INFORMAZIONI_LOGISTICA_APPARATI__c,EOF_DATA_PREVISTA_ATTIVAZIONE__c,EOF_ORARIO_APPUNTAMENTO__c,EOF_CODICE_PROGETTO_SPECIALE__c,
                                			EOF_PROMOZIONE__c,EOF_CLUSTER_PROMOZIONE__c,EOF_NOTE__c,EOF_ID_BUILDING__c,EOF_SCALA_PALAZZINA__c,EOF_NUMERO_TELEFONICO_PRINCIPALE_LINEA__c,
                                			EOF_RECAPITO_TEST_LINEA__c, EOF_ID_Pop__c,EOF_PROFILO__c,EOF_Email_Referente_Tecnico_OLO__c,EOF_ID_Risorsa__c,OF_SA_KIT_CONSEGNA_VLAN__c,
                                			OF_SA_USER_VLAN__c,OF_SA_SERVICE_VLAN__c,OF_SA_PROFILO_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,
                                			OF_SA_INFORMAZIONI_VLAN__c,EOF_TIPOLOGIA_APPARATO__c,OF_SA_PASSWORD_APPARATO__c,OF_SA_AZIONE_APPARATO__c, OF_SA_ESITO_RITIRO_APPARATO__c, OF_SA_CODICE_MOTIVAZIONE_RITIRO__c, OF_SA_MOTIVAZIONE_RITIRO__c, 
                                			OF_SA_ESITO_SERVIZIO__c, OF_SA_CODICE_MOTIVAZIONE_SERVIZIO__c, OF_SA_MOTIVAZIONE_SERVIZIO__c, OF_SA_NOME_SERVIZIO__c,OF_SA_INFORMAZIONI_SERVIZIO__c,EOF_Tipo_Comunicazione_String__c,EOF_STATO_ORDINE__c,EOF_GPON_Attestazione__c,
                                			EOF_Codice_Motivazione__c,EOF_Motivazione__c,PO_SA_Data_Inserimento_Ordine__c,EOF_Esito_Consegna_Apparato__c,OF_SA_ID_APPARATO_CONSEGNATO__c,OF_SA_CODICE_MOTIVAZIONE_CONSEGNA__c,OF_SA_MOTIVAZIONE_CONSEGNA__c,
                                			OF_SA_ID_APPARATO__c
                                			from EOF_EAI_Service_Log__c 
                                			where Id=:Apexpages.currentPage().getParameters().get('origId')  
                                			OR OF_SA_Cpe_Log__c=:Apexpages.currentPage().getParameters().get('origId')];
		
		if(slList.size()>1)
		{
            SlApparati=new List<EOF_EAI_Service_Log__c>();
            for(EOF_EAI_Service_Log__c slAgg : slList){
            	if(slAgg.recordtype.developername=='PO_SA_CD_Log_OpenStreamRequest'){
                    sl=slAgg;
                }
                if(slAgg.recordtype.developername=='OF_SA_Cpe'){
                    SlApparati.add(slAgg);
                    Apparati=true;
                }
            }
        }
        else{
        	sl=slList[0];
        }
    }
}