@isTest
public class PO_FATT_WS_PSM_Notify_Utils_TEST {
    
    public static testmethod void test1(){
        //PO_FATT_WS_PSM_Notify_Utils.codeCoverage(100);
        test.startTest();
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = 'Test';
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.syncErrorCodiceOrdine(psmNotify);
        PO_FATT_WS_PSM_Notify_Utils.responseACK(psmNotify);
        // Exception e=New Exception();
        PO_FATT_WS_PSM_Notify_Utils.responseWrongStatus(psmNotify);
        
        DmlException d = new DmlException();
        d.setMessage('testing');
        PO_FATT_WS_PSM_Notify_Utils.responseException(psmNotify,d);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify1 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        //psmNotify1.DATA_NOTIFICA = '';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify1);        
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify2 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify2.DATA_NOTIFICA = 'Test';
        //psmNotify2.ID_NOTIFICA='';             
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify2);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify3 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify3.DATA_NOTIFICA = 'Test';
        psmNotify3.ID_NOTIFICA='Test';
        //psmNotify3.CODICE_ORDINE='';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify3);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify4 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify4.DATA_NOTIFICA = 'Test';
        psmNotify4.ID_NOTIFICA='Test';
        psmNotify4.CODICE_ORDINE='Test';
        //psmNotify4.CODICE_NOTIFICA='';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify4);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify5 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify5.DATA_NOTIFICA = 'Test';
        psmNotify5.ID_NOTIFICA='Test';
        psmNotify5.CODICE_ORDINE='Test';
        psmNotify5.CODICE_NOTIFICA='Test';
        // psmNotify5.DATA_NOTIFICA='';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify5);
        
      
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify6 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        //psmNotify6.DATA_NOTIFICA = 'Test';
        //psmNotify6.ID_NOTIFICA='Test';
        psmNotify6.CODICE_ORDINE='Test';
        psmNotify6.CODICE_NOTIFICA='Test';
        psmNotify6.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify6.ID_NOTIFICA='Testaaaaaaaaaaaaasss';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify6);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify7 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify7.CODICE_NOTIFICA='Test';
        psmNotify7.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify7.ID_NOTIFICA='Test';
        psmNotify7.CODICE_ORDINE='TestSSSSSSSSSSSSSSSS';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify7);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify8 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify8.CODICE_NOTIFICA='Test';
        psmNotify8.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify8.ID_NOTIFICA='Test';
        psmNotify8.CODICE_ORDINE='TestS';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify8);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify9 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify9.CODICE_NOTIFICA='T';
        psmNotify9.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify9.ID_NOTIFICA='Test';
        psmNotify9.CODICE_ORDINE='TestS';
        psmNotify9.DATA_PREVISTA_ATTIVAZIONE='TestS';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify9);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify01 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify01.CODICE_NOTIFICA='T';
        psmNotify01.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify01.ID_NOTIFICA='Test';
        psmNotify01.CODICE_ORDINE='TestS';
        psmNotify01.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify01.MOTIVAZIONE_RIMODULAZIONE_DAC='tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttaaaaaa';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify01);
        
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify10 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify10.CODICE_NOTIFICA='T';
        psmNotify10.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify10.ID_NOTIFICA='Test';
        psmNotify10.CODICE_ORDINE='TestS';
        psmNotify10.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify10.MOTIVAZIONE_RIMODULAZIONE_DAC='ttttttttttttttttttttttttttttttttttttttttt';
        psmNotify10.STATO_ORDINE='ttttttttttt';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify10);
        
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify11 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify11.CODICE_NOTIFICA='T';
        psmNotify11.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify11.ID_NOTIFICA='Test';
        psmNotify11.CODICE_ORDINE='TestS';
        psmNotify11.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify11.MOTIVAZIONE_RIMODULAZIONE_DAC='ttttttttttttttttttttttttttttttttttttttttt';
        psmNotify11.STATO_ORDINE='t';
        psmNotify11.ID_RISORSA='ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify11);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify12 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify12.CODICE_NOTIFICA='T';
        psmNotify12.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify12.ID_NOTIFICA='Test';
        psmNotify12.CODICE_ORDINE='TestS';
        psmNotify12.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify12.MOTIVAZIONE_RIMODULAZIONE_DAC='ttttttttttttttttttttttttttttttttttttttttt';
        psmNotify12.STATO_ORDINE='t';
        psmNotify12.ID_RISORSA='tttt';
        psmNotify12.DATA_ESPLETAMENTO_ORDINE='tttt';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify12);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify13 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify13.CODICE_NOTIFICA='T';
        psmNotify13.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify13.ID_NOTIFICA='Test';
        psmNotify13.CODICE_ORDINE='TestS';
        psmNotify13.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify13.MOTIVAZIONE_RIMODULAZIONE_DAC='ttttttttttttttttttttttttttttttttttttttttt';
        psmNotify13.STATO_ORDINE='t';
        psmNotify13.ID_RISORSA='tttt';
        psmNotify13.DATA_ESPLETAMENTO_ORDINE='tttttttttt';
        psmNotify13.NOTE='tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttaaaaaa';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify13);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify14 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();       
        psmNotify14.CODICE_NOTIFICA='T';
        psmNotify14.DATA_NOTIFICA='ttttttttttttttttttttttttt';
        psmNotify14.ID_NOTIFICA='Test';
        psmNotify14.CODICE_ORDINE='TestS';
        psmNotify14.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify14.MOTIVAZIONE_RIMODULAZIONE_DAC='ttttttttttttttttttttttttttttttttttttttttt';
        psmNotify14.STATO_ORDINE='t';
        psmNotify14.ID_RISORSA='tttt';
        psmNotify14.DATA_ESPLETAMENTO_ORDINE='tttttttttt';
        psmNotify14.NOTE='ttttttttttttttttttttttttt';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify14);
        test.stopTest();
        
    }
    
    public static testmethod void test2(){
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        test.startTest();
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify3 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        //datetime dt=system.now();
        psmNotify3.DATA_NOTIFICA = 'sssssssssssssssssssssssss';
        psmNotify3.ID_NOTIFICA='Test';
        psmNotify3.CODICE_ORDINE='test';
        psmNotify3.CODICE_NOTIFICA='1';
        //psmNotify3.DATA_PREVISTA_ATTIVAZIONE
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify3);
        PO_FATT_WS_PSM_Notify_Utils.syncErrorDataPrevistaAttivazione(psmNotify3);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify4 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        //datetime dt=system.now();
        psmNotify4.DATA_NOTIFICA = 'sssssssssssssssssssssssss';
        psmNotify4.ID_NOTIFICA='Test';
        psmNotify4.CODICE_ORDINE='test'; 
        psmNotify4.CODICE_NOTIFICA='2';
        psmNotify3.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify4);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify5 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        // datetime dt=system.now();
        psmNotify5.DATA_NOTIFICA = 'sssssssssssssssssssssssss';
        psmNotify5.ID_NOTIFICA='Test';
        psmNotify5.CODICE_ORDINE='test';
        psmNotify5.CODICE_NOTIFICA='1';
        psmNotify5.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify5);
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify6 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        // datetime dt=system.now();
        psmNotify6.DATA_NOTIFICA = 'sssssssssssssssssssssssss';
        psmNotify6.ID_NOTIFICA='Test';
        psmNotify6.CODICE_ORDINE='test';
        psmNotify6.CODICE_NOTIFICA='2';
        psmNotify6.DATA_PREVISTA_ATTIVAZIONE='tttttttttt';
        psmNotify6.MOTIVAZIONE_RIMODULAZIONE_DAC='test';
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify6);
        
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.EOF_Notify__c; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PSM Notifica di Attivazione').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Case cs = new Case();
        cs.AccountId = acc.Id;
        cs.Status='Acquisito';
        insert cs;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = String.valueof(System.today());
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.verificaData('test');
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime('test');
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        List<Blob> blobList=New List<Blob>();
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        blobList.add(bodyBlob1);
        blobList.add(bodyBlob2);
        
        attach.body=blobList[0]; 
        attach.parentId=acc.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test';
        Attachment attach2=new Attachment(); 
        attach2.Name='Unit Test Attachment'; 
        attach2.body=blobList[1]; 
        attach2.parentId=acc.Id; 
        attach2.ContentType = 'application/pdf'; 
        attach2.IsPrivate = false; 
        attach2.Description = 'Test';
        List<Attachment> listAtt =  new List<Attachment>();
        listAtt.add(attach);
        listAtt.add(attach2);
        insert listAtt;
        PO_FATT_WS_PSM_Notify_Utils.attachingFileOutbound(listAtt, cs.ParentId);
        //insert attach;
       	List<String> nameL =  new List<String>();
        nameL.add('docx');
        nameL.add('doc');
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId,'doc'); 
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId, nameL);
        EOF_EAI_Service_Log__c  serlog = new EOF_EAI_Service_Log__c ();
        serlog.OF_SA_ACK__c = true;
        serlog.EOF_Stato_Richiesta__c = 'Test';
        serlog.EOF_Codice_Errore__c= 'Test';
        serlog.EOF_Causale_Errore__c= 'Test';
        serlog.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        insert serlog;
        PO_FATT_WS_PSM_Notify_Utils.writeLog(psmNotify,'test','test','test');
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = cs.Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = rtId;
        insert eno; 
        
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test());
        PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione(eno.Id);
        
        DateTime dt1  = System.now();
        PO_FATT_WS_PSM_Notify_Utils.dateToString(dt1);
        PO_FATT_WS_PSM_Notify_Utils.dateYMToString(dt1);
    }
    
    
    public static testmethod void test4(){
    	
    	
    	// custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
        
    	OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
    	
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
    	
        
        test.startTest();
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify3 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        //datetime dt=system.now();
        psmNotify3.DATA_NOTIFICA = 'sssssssssssssssssssssssss';
        psmNotify3.ID_NOTIFICA='Test';
        psmNotify3.CODICE_ORDINE='test';
        psmNotify3.CODICE_NOTIFICA='0';
        //psmNotify3.DATA_PREVISTA_ATTIVAZIONE
        PO_FATT_WS_PSM_Notify_Utils.syncError(psmNotify3);
        //Id RecordTypeIdnotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM_Notifica_di_Attivazione').getRecordTypeId();
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.EOF_Notify__c; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PSM Notifica di Attivazione').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Case cs = new Case();
        cs.AccountId = acc.Id;
        cs.Status='Acquisito';
        insert cs;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = String.valueof(System.today());
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.verificaData('test');
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime('test');
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        List<Blob> blobList=New List<Blob>();
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        blobList.add(bodyBlob1);
        blobList.add(bodyBlob2);
        
        attach.body=blobList[0]; 
        attach.parentId=acc.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test'; 
        //insert attach;
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId,'doc'); 
        
        EOF_EAI_Service_Log__c  serlog = new EOF_EAI_Service_Log__c ();
        serlog.OF_SA_ACK__c = true;
        serlog.EOF_Stato_Richiesta__c = 'Test';
        serlog.EOF_Codice_Errore__c= 'Test';
        serlog.EOF_Causale_Errore__c= 'Test';
        serlog.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        insert serlog;
        //PO_FATT_WS_PSM_Notify_Utils.writeLog(psmNotify,'test','test','test');
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = cs.Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = rtId;
        insert eno; 
        
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test ());
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione(eno.Id);
        // PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione(eno.Id);
        
        // Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1());
        // PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione(eno.Id);
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento('test');
    }
    
    public static testmethod void test5(){
    	
    	
    	// custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
    	
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
    	   	
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
    	
        
        test.startTest();
        
        //Id RecordTypeIdnotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM_Notifica_di_Attivazione').getRecordTypeId();
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.EOF_Notify__c; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PSM Notifica di Attivazione').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Case cs = new Case();
        cs.AccountId = acc.Id;
        cs.Status='Acquisito';
        insert cs;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = String.valueof(System.today());
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.verificaData('test');
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime('test');
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        List<Blob> blobList=New List<Blob>();
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        blobList.add(bodyBlob1);
        blobList.add(bodyBlob2);
        
        attach.body=blobList[0]; 
        attach.parentId=acc.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test'; 
        //insert attach;
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId,'doc'); 
        
        EOF_EAI_Service_Log__c  serlog = new EOF_EAI_Service_Log__c ();
        serlog.OF_SA_ACK__c = true;
        serlog.EOF_Stato_Richiesta__c = 'Test';
        serlog.EOF_Codice_Errore__c= 'Test';
        serlog.EOF_Causale_Errore__c= 'Test';
        serlog.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        insert serlog;
        //PO_FATT_WS_PSM_Notify_Utils.writeLog(psmNotify,'test','test','test');
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = cs.Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = rtId;
        insert eno; 
        
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock_Test ());
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento(eno.Id);
        // Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1());
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento(eno.Id);
    }
    
    public static testmethod void test6(){
        
        TestDataFactory.CreateTestRecords(null,null,null);
        
        
        test.startTest();
        
        //Id RecordTypeIdnotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM_Notifica_di_Attivazione').getRecordTypeId();
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.EOF_Notify__c; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PSM Notifica di Attivazione').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Case cs = new Case();
        cs.AccountId = acc.Id;
        cs.Status='Acquisito';
        insert cs;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = String.valueof(System.today());
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.verificaData('test');
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime('test');
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        List<Blob> blobList=New List<Blob>();
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        blobList.add(bodyBlob1);
        blobList.add(bodyBlob2);
        
        attach.body=blobList[0]; 
        attach.parentId=acc.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test'; 
        //insert attach;
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId,'doc'); 
        
        EOF_EAI_Service_Log__c  serlog = new EOF_EAI_Service_Log__c ();
        serlog.OF_SA_ACK__c = true;
        serlog.EOF_Stato_Richiesta__c = 'Test';
        serlog.EOF_Codice_Errore__c= 'Test';
        serlog.EOF_Causale_Errore__c= 'Test';
        serlog.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        insert serlog;
        PO_FATT_WS_PSM_Notify_Utils.writeLog(psmNotify,'test','test','test');
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = cs.Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = rtId;
        insert eno; 
        
        // Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock());
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione(eno.Id);
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1_Test());
        PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione(eno.Id);
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione('test');
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento('test');
    }
    
    public static testmethod void test7(){
        
        TestDataFactory.CreateTestRecords(null,null,null);
        
        test.startTest();
        
        
        
        //Id RecordTypeIdnotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM_Notifica_di_Attivazione').getRecordTypeId();
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.EOF_Notify__c; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PSM Notifica di Attivazione').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Case cs = new Case();
        cs.AccountId = acc.Id;
        cs.Status='Acquisito';
        insert cs;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = String.valueof(System.today());
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.verificaData('test');
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime('test');
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        List<Blob> blobList=New List<Blob>();
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        blobList.add(bodyBlob1);
        blobList.add(bodyBlob2);
        
        attach.body=blobList[0]; 
        attach.parentId=acc.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test'; 
        //insert attach;
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId,'doc'); 
        
        EOF_EAI_Service_Log__c  serlog = new EOF_EAI_Service_Log__c ();
        serlog.OF_SA_ACK__c = true;
        serlog.EOF_Stato_Richiesta__c = 'Test';
        serlog.EOF_Codice_Errore__c= 'Test';
        serlog.EOF_Causale_Errore__c= 'Test';
        serlog.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        insert serlog;
        //PO_FATT_WS_PSM_Notify_Utils.writeLog(psmNotify,'test','test','test');
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = cs.Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = rtId;
        insert eno; 
        
        // Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock());
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione(eno.Id);
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione(eno.Id);
        
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1_Test());
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione(eno.Id);
        //PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento('test');
    }
    
    public static testmethod void test8(){
        
        TestDataFactory.CreateTestRecords(null,null,null);
        
        
        test.startTest();
        
        //Id RecordTypeIdnotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM_Notifica_di_Attivazione').getRecordTypeId();
        
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.EOF_Notify__c; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = CaseRecordTypeInfo.get('PSM Notifica di Attivazione').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        
        Case cs = new Case();
        cs.AccountId = acc.Id;
        cs.Status='Acquisito';
        insert cs;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = String.valueof(System.today());
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        PO_FATT_WS_PSM_Notify_Utils.verificaData('test');
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime('test');
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        List<Blob> blobList=New List<Blob>();
        Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        blobList.add(bodyBlob1);
        blobList.add(bodyBlob2);
        
        attach.body=blobList[0]; 
        attach.parentId=acc.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test'; 
        //insert attach;
        PO_FATT_WS_PSM_Notify_Utils.attachingFile(blobList,attach.parentId,'doc'); 
        
        EOF_EAI_Service_Log__c  serlog = new EOF_EAI_Service_Log__c ();
        serlog.OF_SA_ACK__c = true;
        serlog.EOF_Stato_Richiesta__c = 'Test';
        serlog.EOF_Codice_Errore__c= 'Test';
        serlog.EOF_Causale_Errore__c= 'Test';
        serlog.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        insert serlog;
        //PO_FATT_WS_PSM_Notify_Utils.writeLog(psmNotify,'test','test','test');
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = cs.Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = rtId;
        insert eno; 
        
        // Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock());
        // PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento(eno.Id);
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1_Test());
        // PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento(eno.Id);
    }
    
    //EC - 2018 - 04 - 18 do not delete please!
    /* public static testmethod void test3(){

TestDataFactory.CreateTestRecordsPSM('EOF Caso - Attivazione','PO_Ordine_Fiber_Lease',NULL,'PSM_Notifica_di_Attivazione');

test.startTest();
//chiamiamo la classe a questa aggiungiamo dopo il punto il metodo da testare della classe chiamata in causa
//poiché il metodo è statico è sufficiente scrivere classe.metodo(parametro da passare, in questo caso una stringa);
//nel caso in cui non fosse stato un metodo NON statico avremmo dovuto scrivere:
//1. classe.metodo nomefittizio = new classe.metodo();
//2. nomefittizio.metodo(parametro da passare, in questo caso 'stringaditestgenerica')
PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Attivazione('test01');
test.stopTest();

}

public static testmethod void test3a(){

TestDataFactory.CreateTestRecordsPSM('EOF Caso - Attivazione','PO_Ordine_Fiber_Lease',NULL,'PSM_Notifica_di_Attivazione');

test.startTest();
//chiamiamo la classe a questa aggiungiamo dopo il punto il metodo da testare della classe chiamata in causa
//poiché il metodo è statico è sufficiente scrivere classe.metodo(parametro da passare, in questo caso una stringa);
//nel caso in cui non fosse stato un metodo NON statico avremmo dovuto scrivere:
//1. classe.metodo nomefittizio = new classe.metodo();
//2. nomefittizio.metodo(parametro da passare, in questo caso 'stringaditestgenerica')
PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione('test01');
test.stopTest();

}

public static testmethod void test3b(){

TestDataFactory.CreateTestRecordsPSM('EOF Caso - Attivazione','PO_Ordine_Fiber_Lease',NULL,'PSM_Notifica_di_Attivazione');

test.startTest();
//chiamiamo la classe a questa aggiungiamo dopo il punto il metodo da testare della classe chiamata in causa
//poiché il metodo è statico è sufficiente scrivere classe.metodo(parametro da passare, in questo caso una stringa);
//nel caso in cui non fosse stato un metodo NON statico avremmo dovuto scrivere:
//1. classe.metodo nomefittizio = new classe.metodo();
//2. nomefittizio.metodo(parametro da passare, in questo caso 'stringaditestgenerica')
PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento('test01');
test.stopTest();

} */
    
    public static testmethod void test9(){
        
        TestDataFactory.CreateTestRecordsPSM('EOF Caso - Attivazione','PO_Ordine_Fiber_Lease',null,null);
        
        map<string,string> rtMap= new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }        
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify no1 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        no1.DATA_NOTIFICA = '2018-05-09T12:30:00+01:00';
        no1.ID_NOTIFICA = 'Test';
        no1.CODICE_ORDINE = 'Test' ; 
        no1.CODICE_NOTIFICA = '0';        
        no1.DATA_PREVISTA_ATTIVAZIONE = '2018-05-09'; 
        no1.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        no1.STATO_ORDINE = '0';
        no1.ID_RISORSA = 'Test'; 
        no1.ID_CIRCUITO_1 = 'Test';
        no1.ID_CIRCUITO_2 = 'Test';
        no1.DATA_ESPLETAMENTO_ORDINE = '2018-05-09';
        no1.NOTE = 'Test';
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = TestDataFactory.cList[0].Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Cessazione').getRecordTypeId();
        insert eno;
        
        test.starttest();
        
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1_Test());
        PO_FATT_WS_PSM_Notify_Utils.syncError(no1);	    
        PO_FATT_WS_PSM_Notify_Utils.verificaData(no1.DATA_ESPLETAMENTO_ORDINE);
        PO_FATT_WS_PSM_Notify_Utils.verificaDateTime(no1.DATA_NOTIFICA);
        PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Cessazione(eno.id);       
        test.stopTest();
        
    }
    
    public static testmethod void test10(){
        
        TestDataFactory.CreateTestRecordsPSM('EOF Caso - Attivazione','PO_Ordine_Fiber_Lease',null,null);
        
        map<string,string> rtMap= new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            rtMap.put(rt.developername,rt.id);
        }        
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify no1 = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        no1.DATA_NOTIFICA = '2018-05-09T12:30:00+01:00';
        no1.ID_NOTIFICA = 'Test';
        no1.CODICE_ORDINE = 'Test' ; 
        no1.CODICE_NOTIFICA = '0';        
        no1.DATA_PREVISTA_ATTIVAZIONE = '2018-05-09'; 
        no1.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        no1.STATO_ORDINE = '0';
        no1.ID_RISORSA = 'Test'; 
        no1.ID_CIRCUITO_1 = 'Test';
        no1.ID_CIRCUITO_2 = 'Test';
        no1.DATA_ESPLETAMENTO_ORDINE = '2018-05-09';
        no1.NOTE = 'Test';
        
        EOF_Notify__c eno = new EOF_Notify__c();
        //eno.Name='Testeno';
        eno.Caso__c = TestDataFactory.cList[0].Id;
        eno.EOF_Codice_Ordine_EOF__c = 'Test';
        eno.Flag_Pagamento__c = '0';
        eno.Numero_Operatore__c = '1';
        eno.EOF_Tipo_di_intervento__c = 'Sbraccio';
        eno.EOF_Tipo_di_intervento_aggiuntivo__c = 'Installazione CPE';
        eno.EOF_ID_Notifica__c = 'Test';
        eno.EOF_Stato_Richiesta__c = 'OK';
        eno.EOF_Data_Notifica__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        eno.EOF_Data_Espletamento_Ordine__c = System.today();
        eno.EOF_GPON_Attestazione__c = 'Test';
        eno.EOF_Parametri_Trasmissivi_Ottici__c = 'Test';
        eno.EOF_ID_Risorsa__c = 'Test';
        eno.EOF_ID_Splitter_Secondario__c = 'Test';
        eno.EOF_Posizione_Splitter_Secondario__c = 'Test';
        eno.recordtypeid = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('PSM Notifica di Annullamento').getRecordTypeId();
        insert eno;
        
        test.starttest();
        
        Test.setMock(WebServiceMock.class, new PO_FATT_WS_PSM_Notify_Utils_mock1_Test());
        PO_FATT_WS_PSM_Notify_Utils.syncError(no1);	    
        //PO_FATT_WS_PSM_Notify_Utils.verificaData(no1.DATA_ESPLETAMENTO_ORDINE);
        //PO_FATT_WS_PSM_Notify_Utils.verificaDateTime(no1.DATA_NOTIFICA);
        PO_FATT_WS_PSM_Notify_Utils.createAckNackNotify_Annullamento(eno.id);       
        test.stopTest();
        
    }    
    
}