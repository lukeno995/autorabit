@isTest
public class OF_SendRetryChangeOrder_Methods_test 
{

@testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
    }
@isTest
    public static  void  Function1()
    {
        OF_SendRetryChangeOrder_Methods Obj1=new OF_SendRetryChangeOrder_Methods();
        
        case C1=new case();
        C1.OF_Response_Da_OLO__c='NACK TECNICO';
        C1.OF_Response_Da_OM__c='RDOM1';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.EOF_Note__c='ENC1';
        C1.OF_SA_Profilo__c ='OSP1';
        insert C1;
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        Id recordid = Schema.SObjectType.OF_CommercialElementIstanziato__c .getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
        CEI.RecordTypeId=recordid;
        CEI.OF_KitConsegnaVLAN__c='KC1';
        CEI.OF_UserVLAN__c='UV1';
        CEI.OF_ServiceVLAN__c='SV1';
        CEI.OF_ProfiloVLAN__c='PV1';
        CEI.OF_ModelloDiServizioVLAN__c='MS1';
        CEI.OF_CustomerVLAN__c='CV1';
        CEI.OF_InformazioniVLAN__c='IV1';
       
        
        String caseId =c1.Id; 
        String rtypeDevName='';
        string codiceOrdineOLO='';
        
        EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
        sl.EOF_CODICE_OPERATORE__c='x';
		sl.EOF_CODICE_ORDINE_OLO__c='x';
		sl.EOF_CODICE_ORDINE_EOF__c='x';
		//sl.EOF_DATA_NOTIFICA__c='x';
		sl.EOF_ID_NOTIFICA__c='x';
		sl.EOF_STATO_ORDINE__c='x';
		sl.EOF_CODICE_MOTIVAZIONE__c='x';
		sl.EOF_MOTIVAZIONE__c='x';
		sl.EOF_GPON_Attestazione__c='x';
		sl.EOF_NOME_CLIENTE__c='x';
		sl.EOF_COGNOME_CLIENTE__c='x';
		sl.EOF_RECAPITO_TELEFONICO_CLIENTE__c='x';
		//sl.EOF_DATA_PREVISTA_ATTIVAZIONE__c='x';
		//sl.EOF_ORARIO_APPUNTAMENTO__c='x';
		sl.EOF_PIN_INTERVENTO_A_VUOTO__c='x';
		sl.EOF_NOTE__c='x';
		sl.caso__c=c1.id;
		sl.OF_SA_Direzione_Flusso__c='SF - OLO';
		sl.OF_SA_Metodo__c='OF_StatusUpdate';
        insert sl;
        
        
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
         OF_SendRetryChangeOrder_Methods.retryCalloutSFOM(caseId, rtypeDevName, codiceOrdineOLO);
         Test.StopTest();
    }
    
  /*   public static testMethod  void  Function2()
    {
        OF_SendRetryChangeOrder_Methods Obj1=new OF_SendRetryChangeOrder_Methods();
        
        case C1=new case();
        C1.OF_Response_Da_OLO__c='Test';
        C1.OF_Response_Da_OM__c='NACK TECNICO';
        C1.EOF_Codice_Ordine_OLO__c='ECOO1';
        C1.EOF_Data_Notifica__c=DateTime.now();
        C1.EOF_Id_Notifica__c='EIN1';
        C1.EOF_Id_Risorsa__c='EIR1';
        C1.OF_SA_CODICE_PROGETTO_SPECIALE__c='SCPS1';
        C1.OF_SA_Promozione__c='SPC1';
        C1.OF_SA_Cluster_Promozione__c='SCPC1';
        C1.EOF_Note__c='ENC1';
        C1.OF_SA_Profilo__c ='OSP1';
        insert C1;
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        Id recordid = Schema.SObjectType.OF_CommercialElementIstanziato__c .getRecordTypeInfosByName().get('VLAN').getRecordTypeId();
        CEI.RecordTypeId=recordid;
        CEI.OF_KitConsegnaVLAN__c='KC1';
        CEI.OF_UserVLAN__c='UV1';
        CEI.OF_ServiceVLAN__c='SV1';
        CEI.OF_ProfiloVLAN__c='PV1';
        CEI.OF_ModelloDiServizioVLAN__c='MS1';
        CEI.OF_CustomerVLAN__c='CV1';
        CEI.OF_InformazioniVLAN__c='IV1';
       
        
        String caseId =c1.Id; 
        String rtypeDevName='';
        string codiceOrdineOLO='';
        
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
         OF_SendRetryChangeOrder_Methods.retryCalloutSFOM(caseId, rtypeDevName, codiceOrdineOLO);
         Test.StopTest();
    }*/
    
    
}