@isTest
public class OF_GPONP_OLO_AsyncChecks_Test {
    @testSetup 
    public static void testSetUpData() {
        Insert new OF_Puntamento_Callout__c(Name = 'OGW',OF_OGW__c = 'Test');
        Insert new OF_Tibco_userID__c(Name = 'Tibco UserID',OF_Tibco_ID__c= 'Test');
        Insert new OF_Enable_PO_UpdateOppCase_Trigger__c(Name = 'Status',OF_Enable_Trigger__c= true);
        
    }    
    public static testMethod void OLO_AsyncActivationMethodaa(){
        Id RecordTypeIdser2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();         
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'GPON Passiva';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = 'Test'; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = '1243;235;';
        insert ce;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.EOF_ID_Building_WS__c = 'VF';
        // parentCase.OF_Response_da_SH__c = 'Test';
        parentCase.OF_SH_Token_id__c = 'Test';
        //parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        //parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Scala_Palazzina_WS__c = 'Test';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser;
        ser.EOF_NOME_CLIENTE__C = 'aa';
        insert ser;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id;  
        ser2.OF_SA_NOME_SERVIZIO__c = '1243';
        ser2.RecordtypeId = RecordTypeIdser2;
        ser2.EOF_Codice_Ordine_Olo__c = 'abc';
        ser2.OF_SA_servizi_Aggiuntivi_Log__c = ser.Id;
        insert ser2;
        
        
        EOF_Network_Inventory__c network = new EOF_Network_Inventory__c();
        network.EOF_Civico__c = 'Test';
        network.EOF_Stato_Building__c  = 110;
        insert network;
        
        Test.StartTest();
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes = null;
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        //Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        Test.StopTest();
    }
    //Id building not found
    public static testMethod void OLO_AsyncActivationMethodaa3(){
        Id RecordTypeIdser2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();         
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'GPON Passiva';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = 'Test'; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = '1243;235;';
        insert ce;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.EOF_ID_Building_WS__c = 'VF1';
        // parentCase.OF_Response_da_SH__c = 'Test';
        parentCase.OF_SH_Token_id__c = 'Test';
        //parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        //parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Scala_Palazzina_WS__c = 'Test';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser;
        ser.EOF_NOME_CLIENTE__C = 'aa';
        insert ser;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id;  
        ser2.OF_SA_NOME_SERVIZIO__c = '1243';
        ser2.RecordtypeId = RecordTypeIdser2;
        ser2.EOF_Codice_Ordine_Olo__c = 'abc';
        ser2.OF_SA_servizi_Aggiuntivi_Log__c = ser.Id;
        insert ser2;
        
        
        EOF_Network_Inventory__c network = new EOF_Network_Inventory__c();
        network.EOF_Civico__c = 'Test';
        network.EOF_Stato_Building__c  = 110;
        insert network;
        
        Test.StartTest();
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes = null;
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        //Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        Test.StopTest();
    }
    //Stato id building negativo
    public static testMethod void OLO_AsyncActivationMethodaa2(){
        Id RecordTypeIdser2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId();         
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'GPON Passiva';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = 'Test'; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = '1243;235;';
        insert ce;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.EOF_ID_Building_WS__c = 'VF2';
        // parentCase.OF_Response_da_SH__c = 'Test';
        parentCase.OF_SH_Token_id__c = 'Test';
        //parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        //parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Scala_Palazzina_WS__c = 'Test';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17'; 
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser;
        ser.EOF_NOME_CLIENTE__C = 'aa';
        insert ser;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        EOF_EAI_Service_Log__c ser2 = new EOF_EAI_Service_Log__c();
        ser2.EOF_PROFILO__c = '17';
        ser2.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser2.EOF_ID_Notifica__c = '1529661331590';
        ser2.Caso__c=parentCase.Id;  
        ser2.OF_SA_NOME_SERVIZIO__c = '1243';
        ser2.RecordtypeId = RecordTypeIdser2;
        ser2.EOF_Codice_Ordine_Olo__c = 'abc';
        ser2.OF_SA_servizi_Aggiuntivi_Log__c = ser.Id;
        insert ser2;
        
        
        EOF_Network_Inventory__c network = new EOF_Network_Inventory__c();
        network.EOF_Civico__c = 'Test';
        network.EOF_Stato_Building__c  = 110;
        insert network;
        
        Test.StartTest();
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes = null;
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        //Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        Test.StopTest();
    }
    public static testMethod void OLO_AsyncActivationMethod(){
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.EOF_ID_Building_WS__c = 'VF';
        // parentCase.OF_Response_da_SH__c = 'Test';
        parentCase.OF_SH_Token_id__c = 'Test';
        //parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        //parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Scala_Palazzina_WS__c = 'Test';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser;
        insert ser;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        EOF_Network_Inventory__c network = new EOF_Network_Inventory__c();
        network.EOF_Civico__c = 'Test';
        network.EOF_Stato_Building__c  = 110;
        insert network;
        
        Test.StartTest();
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes = null;
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        //Test.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        Test.StopTest();
    }
    public static testMethod void OLO_AsyncActivationMethoda(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        //acc.Lastname = 'TestAccount'; 
        acc.name = 'VF';     
        insert acc;
        
        OF_GPONP_GE_Utils.cliente = acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = 'IdRisorsa';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        //parentCase.EOF_Causale_Errore__c ='ID Risorsa da cessare inesistente/errato';
        //parentCase.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        Test.StartTest();
        //Test.setMock(WebServiceMock.class, new OF_CO_OLO_AsyncChecks_mock_Test ());
        //AATest.setMock(WebServiceMock.class, new OF_OM_SendToOLONew_Mock1());
        Test.setMock(WebServiceMock.class, new OF_SA_OLO_SendToOMNew_Mock1());
        
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        /* try{
OF_GPONP_OLO_AsyncChecks.OLO_AsyncDeactivationNew(parentCase.Id,ser.id);
}Catch(exception e){}*/
        Test.StopTest();
    }
    // For Checkapp
    public static testMethod void OLO_AsyncActivationMethoda1(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        //acc.Lastname = 'TestAccount'; 
        acc.name = 'test';     
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = 'IdRisorsa';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        parentCase.EOF_Data_Appuntamento__c = System.today();
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_ID_Building_WS__c = 'Test';
        //parentCase.EOF_Causale_Errore__c ='ID Risorsa da cessare inesistente/errato';
        //parentCase.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        Test.StartTest();
        //AATest.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());  
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());  
        //Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls1());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        Test.StopTest();
    }    
    // For Network 228
    public static testMethod void OLO_AsyncActivationMethoda2(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        //acc.Lastname = 'TestAccount'; 
        acc.name = 'test';     
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = 'IdRisorsa';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        parentCase.EOF_Data_Appuntamento__c = System.today();
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_ID_Building_WS__c = 'Test';
        parentCase.EOF_Scala_Palazzina_WS__c = 'Test';
        parentCase.EOF_Causale_Errore__c ='Scala non RFC/RFA';
        //parentCase.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        EOF_Network_Inventory__c network = new EOF_Network_Inventory__c();
        network.EOF_Civico__c = 'Test';
        network.EOF_Stato_Building__c  = 102;
        network.EOF_Scala_Palazzina__c = 'Test';
        network.EOF_Stato_Scala_Palazzina__c = 1;
        insert network;
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        
        
        Test.StartTest();
        //Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());     
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        Test.StopTest();
    }
    //OF_ContrattoServizio__c
    public static testMethod void OLO_AsyncActivationMethoda3(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        //acc.Lastname = 'TestAccount'; 
        acc.name = 'test';     
        insert acc;
        
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.status = 'Attivo';
        contratto.StartDate = Date.newInstance(2000,10,10);
        //contratto.EndDate = System.today()+2;
        contratto.ContractTerm = 1;
        insert contratto;
        //Test.setEndDate(contratto.Id, System.today()+2);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = asset_1.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = Date.newInstance(2001,10,10);
        parentCase.EOF_Data_Appuntamento__c = Date.newInstance(2001,10,10);
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_ID_Building_WS__c = 'Test';
        parentCase.EOF_Scala_Palazzina_WS__c = 'Test';
        parentCase.EOF_Causale_Errore__c ='Scala non RFC/RFA';
        //parentCase.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        EOF_Network_Inventory__c network = new EOF_Network_Inventory__c();
        network.EOF_Civico__c = 'Test';
        network.EOF_Stato_Building__c  = 102;
        //network.EOF_Scala_Palazzina__c = 'Test';
        network.EOF_Stato_Scala_Palazzina__c = 1;
        //network.EOF_Comune__c = 'Test';
        insert network;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        /*OF_ElencoComuniItaliani__c Ele = new OF_ElencoComuniItaliani__c();
Ele.OF_CodiceIstat__c = 'Test';
Ele.OF_Provincia__c = 'Test';
insert Ele;*/
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        
        Test.StartTest();
        //Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());     
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        Test.StopTest();
    }
    // OF_AreaGeograficaJunction__c
    public static testMethod void OLO_AsyncActivationMethoda4(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        //acc.Lastname = 'TestAccount'; 
        acc.name = 'test';     
        insert acc;
        
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.status = 'Attivo';
        contratto.StartDate = Date.newInstance(2000,10,10);
        //contratto.EndDate = System.today()+2;
        contratto.ContractTerm = 36;
        insert contratto;
        //Test.setEndDate(contratto.Id, System.today()+2);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = asset_1.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = Date.newInstance(2001,10,10);
        parentCase.EOF_Data_Appuntamento__c = Date.newInstance(2001,10,10);
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_ID_Building_WS__c = 'Test';
        parentCase.EOF_Scala_Palazzina_WS__c = 'test';
        parentCase.EOF_Causale_Errore__c ='Scala non RFC/RFA';
        parentCase.EOF_Istat_Comune__c = '001120';
        insert parentCase; 
        System.debug('@@@Comune'+parentCase.EOF_Istat_Comune__c);
        System.debug('@@@ParentCase'+parentCase);
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        ser.EOF_ID_POP__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        EOF_Network_Inventory__c ni = new EOF_Network_Inventory__c();
        ni.EOF_Civico__c = 'Test';
        ni.EOF_Stato_Building__c  = 110;
        ni.EOF_Stato_Scala_Palazzina__c = 1;
        ni.EOF_Pop__c = 'Test';
        ni.EOF_Comune__c = 'Test';
        ni.EOF_GPON_ID__c = 'Test';
        ni.EOF_ID_Building__c = parentCase.EOF_ID_Building_WS__c;
        ni.EOF_Pop__c = 'Test';
        ni.EOF_Indirizzo__c = 'Test';
        ni.EOF_Particella_Top__c = 'Test';
        ni.EOF_Provincia__c = 'Test';
        ni.EOF_Scala_Palazzina__c = 'test';
        
        insert ni;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        OF_AreaGeograficaCustom__c areageo = new OF_AreaGeograficaCustom__c ();
        areageo.OF_Istat__c = '001120';
        insert areageo;
        System.debug('@@@OF_Istat__c'+areageo.OF_Istat__c);
        System.debug('@@@areageo'+areageo);
        OF_AreaGeograficaCustom__c cus = [Select id,OF_Istat__c from OF_AreaGeograficaCustom__c where OF_Istat__c = '001120'];
        
        OF_AreaGeograficaJunction__c areageojun = new OF_AreaGeograficaJunction__c ();
        areageojun.OF_Contratto__c = contratto.Id;
        areageojun.OF_AreaGeografica__c = cus.Id;
        areageojun.Servizio__c =servizio.id;
        areageojun.OF_Comune__c = 'Milano';
        insert areageojun;
        //OF_AreaGeograficaJunction__c jun = [Select id from OF_AreaGeograficaJunction__c where OF_Comune__c = 'Milano'];
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        Test.StartTest();
        //Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());     
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        Test.StopTest();
    }    
    public static testMethod void OLO_AsyncActivationMethoda5(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        account acc = new account();
        //acc.name = 'test';
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        acc.EOF_Codice_Operatore__c= 'VF';
        insert acc;
        
        OF_GPONP_GE_Utils.cliente =  acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.status = 'Attivo';
        contratto.StartDate = Date.newInstance(2000,10,10);
        //contratto.EndDate = System.today()+2;
        contratto.ContractTerm = 36;
        insert contratto;
        //Test.setEndDate(contratto.Id, System.today()+2);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = asset_1.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = Date.newInstance(2001,10,10);
        parentCase.EOF_Data_Appuntamento__c = Date.newInstance(2001,10,10);
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_ID_Building_WS__c = 'Test';
        parentCase.EOF_Scala_Palazzina_WS__c = 'test';
        parentCase.EOF_Causale_Errore__c ='Scala non RFC/RFA';
        parentCase.EOF_Istat_Comune__c = '001120';
        insert parentCase; 
        System.debug('@@@Comune'+parentCase.EOF_Istat_Comune__c);
        System.debug('@@@ParentCase'+parentCase);
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        ser.EOF_ID_POP__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        EOF_Network_Inventory__c ni = new EOF_Network_Inventory__c();
        ni.EOF_Civico__c = 'Test';
        ni.EOF_Stato_Building__c  = 110;
        ni.EOF_Stato_Scala_Palazzina__c = 1;
        ni.EOF_Pop__c = 'Test';
        ni.EOF_Comune__c = 'Test';
        ni.EOF_GPON_ID__c = 'Test';
        ni.EOF_ID_Building__c = parentCase.EOF_ID_Building_WS__c;
        ni.EOF_Pop__c = 'Test';
        ni.EOF_Indirizzo__c = 'Test';
        ni.EOF_Particella_Top__c = 'Test';
        ni.EOF_Provincia__c = 'Test';
        ni.EOF_Scala_Palazzina__c = 'test';
        
        insert ni;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        OF_AreaGeograficaCustom__c areageo = new OF_AreaGeograficaCustom__c ();
        areageo.OF_Istat__c = '001120';
        insert areageo;
        System.debug('@@@OF_Istat__c'+areageo.OF_Istat__c);
        System.debug('@@@areageo'+areageo);
        OF_AreaGeograficaCustom__c cus = [Select id,OF_Istat__c from OF_AreaGeograficaCustom__c where OF_Istat__c = '001120'];
        
        OF_AreaGeograficaJunction__c areageojun = new OF_AreaGeograficaJunction__c ();
        areageojun.OF_Contratto__c = contratto.Id;
        areageojun.OF_AreaGeografica__c = cus.Id;
        areageojun.Servizio__c =servizio.id;
        areageojun.OF_Comune__c = 'Milano';
        insert areageojun;
        //OF_AreaGeograficaJunction__c jun = [Select id from OF_AreaGeograficaJunction__c where OF_Comune__c = 'Milano'];
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        Test.StartTest();
        
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        
        parentCase.OF_Response_da_SH__c = 'Test';
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        
        Test.StopTest();
    }    
    public static testMethod void OLO_AsyncActivationMethodb(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Lastname = 'TestAccount';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        // parentCase.OF_Response_da_SH__c = 'NACK TECNICO';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser2;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkServAgg = true;
        OF_GPONP_GE_Utils.ListServAgg =serlst;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes =null;
        
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncRescheduleNew(parentCase.Id,ser.id);
        
        Test.StopTest();
    }    
    public static testMethod void OLO_AsyncActivationMethoda6(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Cpe').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        //acc.Lastname = 'TestAccount'; 
        acc.name = 'test';     
        insert acc;
        
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.status = 'Attivo';
        contratto.StartDate = Date.newInstance(2000,10,10);
        //contratto.EndDate = System.today()+2;
        contratto.ContractTerm = 36;
        insert contratto;
        //Test.setEndDate(contratto.Id, System.today()+2);
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = asset_1.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = Date.newInstance(2001,10,10);
        parentCase.EOF_Data_Appuntamento__c = Date.newInstance(2001,10,10);
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_ID_Building_WS__c = 'Test';
        //parentCase.EOF_Scala_Palazzina_WS__c = 'test';
        parentCase.EOF_Causale_Errore__c ='Scala non RFC/RFA';
        parentCase.EOF_Istat_Comune__c = '001120';
        insert parentCase; 
        System.debug('@@@Comune'+parentCase.EOF_Istat_Comune__c);
        System.debug('@@@ParentCase'+parentCase);
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        ser.EOF_ID_POP__c = 'abc';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        EOF_Network_Inventory__c ni = new EOF_Network_Inventory__c();
        ni.EOF_Civico__c = 'Test';
        ni.EOF_Stato_Building__c  = 101;
        ni.EOF_Stato_Scala_Palazzina__c = 1;
        ni.EOF_Pop__c = 'Test';
        ni.EOF_Comune__c = 'Test';
        ni.EOF_GPON_ID__c = 'Test';
        ni.EOF_ID_Building__c = parentCase.EOF_ID_Building_WS__c;
        ni.EOF_Pop__c = 'Test';
        ni.EOF_Indirizzo__c = 'Test';
        ni.EOF_Particella_Top__c = 'Test';
        ni.EOF_Provincia__c = 'Test';
        ni.EOF_Scala_Palazzina__c = 'test';
        
        insert ni;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'GPON Passiva';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        //contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Contract__c=contratto.Id;
        contrattoServizio.OF_Servizio__c=servizio.id; 
        insert contrattoServizio;
        
        OF_AreaGeograficaCustom__c areageo = new OF_AreaGeograficaCustom__c ();
        areageo.OF_Istat__c = '001120';
        insert areageo;
        System.debug('@@@OF_Istat__c'+areageo.OF_Istat__c);
        System.debug('@@@areageo'+areageo);
        OF_AreaGeograficaCustom__c cus = [Select id,OF_Istat__c from OF_AreaGeograficaCustom__c where OF_Istat__c = '001120'];
        
        OF_AreaGeograficaJunction__c areageojun = new OF_AreaGeograficaJunction__c ();
        areageojun.OF_Contratto__c = contratto.Id;
        areageojun.OF_AreaGeografica__c = cus.Id;
        areageojun.Servizio__c =servizio.id;
        areageojun.OF_Comune__c = 'Milano';
        insert areageojun;
        //OF_AreaGeograficaJunction__c jun = [Select id from OF_AreaGeograficaJunction__c where OF_Comune__c = 'Milano'];
        
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.ListApp =serlst;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());    
        //Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls1());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        Test.StopTest();
    }
    // For 156
    public static testMethod void OLO_AsyncActivationMethodb1(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - Servizi Aggiuntivi').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Lastname = 'TestAccount';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        parentCase.EOF_Data_Appuntamento__c = System.today();
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.OF_Response_da_SH__c ='NACK TECNICO';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser2;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        ser.OF_SA_NOME_SERVIZIO__c = 'GPON Passiva';
        insert ser;
        
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        //OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkServAgg = true;
        OF_GPONP_GE_Utils.ListServAgg =serlst;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes =null;
        
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncStatusUpdateNew(parentCase.Id,ser.id);
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncRescheduleNew(parentCase.Id,ser.id);
        
        Test.StopTest();
    }    
    public static testMethod void OLO_AsyncActivationMethodc(){
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'SKY';
        acc.name = 'test';        
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'SKY';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = '4026609553558362022';
        ass.EOF_ID_Risorsa__c = '4026609553558362022';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        insert ass;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = ass.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        //parentCase.PO_Offerta__c = 'P2P Base';
        parentCase.EOF_Codice_Operatore_WS__c = 'SKY';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = '4026609553558362022';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.EOF_ID_Building_WS__c = 'SKY';
        parentCase.OF_Response_da_SH__c = 'Test';
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_Data_Prevista_Attivazione__c = Date.today().addYears(1);
        //parentCase.OF_SH_Token_id__c = 'Test';
        //parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        //parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.EOF_Causale_Errore__c = 'Scala non RFC/RFA';
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.EOF_NOME_CLIENTE__C = 'Test';
        ser.RecordtypeId =RecordTypeIdser;
        ser.EOF_CODICE_OPERATORE__c = 'SKY';
        ser.EOF_ID_Building__c ='SKY';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlst = new List<EOF_EAI_Service_Log__c>();
        serlst.add(ser);
        
        /**Catalogo commerciale**/
        Date myDate = Date.newInstance(2016,1,1);
        Date newDate = Date.newInstance(2099,12,31);
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        catalogo.Name = 'Catalogo 1';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = myDate;
        catalogo.OF_DataFineValidita__c = newDate;
        insert catalogo;
        /**END Catalogo commerciale**/
        
        /**Sevizio**/
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.Name = 'GPON Passiva';
        serv.OF_Attivo__c = true;
        serv.OF_CatalogoCommerciale__c = catalogo.Id;
        serv.OF_DataInizioValidita__c = myDate;
        serv.OF_DataFineValidita__c = newDate;
        insert serv;
        /**END Servizio**/
        
        /**Commercial Element**/
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        ce.name = 'Test'; 
        ce.OF_Servizio__c = serv.Id;
        ce.OF_DataInizioValidita__c = myDate;
        ce.OF_DataFineValidita__c = newDate;
        ce.OF_Alias__c = '1243;235;';
        insert ce;
        /**END Commercial Element Istanziato**/
        
        OF_GPONP_GE_Utils.cliente  = acc;
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.checkServAgg = true;
        OF_GPONP_GE_Utils.sLogOFSHReqANDRes = null;
        //OF_GPONP_GE_Utils.ListServAgg = serlst;
        //OF_GPONP_GE_Utils.ListSlActivationOLOSF = serlst;
        //OF_GPONP_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock ());
        OF_GPONP_OLO_AsyncChecks  olo1 = new OF_GPONP_OLO_AsyncChecks ();
        try{
            OF_GPONP_OLO_AsyncChecks.OLO_AsyncActivation(parentCase.Id,ser.id);
        }Catch(exception e){}
        Test.StopTest();
    }    
    @isTest
    public static void SyncChecksDeactivationNewTestMethodNegative(){
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.Lastname = 'TestAccount';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = AccountRecordTypeId ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        insert acc;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        contratto.Status = 'Attivo';
        contratto.StartDate = System.today();
        insert contratto;
        
        String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        Order ordine = new Order();
        ordine.OF_Asset__c = asset_1.id;
        ordine.AccountId = acc.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        insert ordine;
        
        String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
        Case c = new Case();
        c.EOF_Account_OLO__c = acc.Id;
        c.Subject = 'Richiesta Attivazione';
        c.EOF_Codice_Ordine_OLO__c = '9876543';
        c.EOF_Data_Prevista_Attivazione__c = system.today();
        c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        c.Status = 'Espletato';
        c.EOF_Fase__c = 'Espletato OK';
        c.Type = '1';
        c.EOF_Tipologia_Servizio__c = 'test1';
        c.EOF_Codice_Operatore_WS__c = 'CNN';
        c.EOF_SLA_Premium_Assurance__c ='Y';
        c.Account = acc;
        c.AssetId = asset_1.id;
        c.OwnerId = userInfo.getUserId();
        c.RecordTypeId = CaseRecordTypeId;
        c.EOF_Id_Notifica__c = 'test_01';
        c.Origin = 'Web';
        c.Priority = 'Medium';
        c.EOF_GPON_Vincolante__c = 'Y';
        c.OF_Order__c=ordine.id;
        c.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        c.PO_SA_Portale__C = true;
        c.OF_Bonifica_Locked_Row__c = true;
        insert c;
        
        OLO_ID__c oloId = new OLO_ID__c();
        oloId.Name = 'CNN';
        oloId.OF_Olo_Id__c = '0018E00000dbbWiQAI';
        insert oloId;
        
        String testStrBlw20Chars = 'TestTestTestTest';
        String testStrAbv20Chars = 'TestTestTestTestTestTest';
        String testStrAbv70Chars = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
        String testStrAbv100Chars = testStrAbv70Chars + testStrAbv70Chars;
        String testStrWithSplChars = 'TestTest�TestTest';
        
        OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest Deact = new OF_GPONP_WS_IN_OLO_Deactivation.OLO_DeactivationRequest();
        
        Deact.CODICE_OPERATORE = 'CNN';
        Deact.CODICE_ORDINE_OLO = '98765431';
        Deact.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
        Deact.ID_RISORSA = testStrAbv20Chars;
        Deact.NOME_CLIENTE = testStrBlw20Chars;
        Deact.TRACCIATO_TRASCODIFICATO = 'SI';
        Deact.CODICE_OPERATORE_SECONDARIO = 'SKY';
        Deact.NOTE = testStrBlw20Chars;
        
        Test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        
        List<OF_GPONP_WS_IN_OLO_Deactivation.APPARATO> testList_apparato = new List<OF_GPONP_WS_IN_OLO_Deactivation.APPARATO>();
        OF_GPONP_WS_IN_OLO_Deactivation.APPARATO testApparato = new OF_GPONP_WS_IN_OLO_Deactivation.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = testStrAbv100Chars;
        testList_apparato.add(testApparato);
        
        Deact.APPARATO = testList_apparato;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        testList_apparato.clear();
        testApparato = new OF_GPONP_WS_IN_OLO_Deactivation.APPARATO();
        testApparato.TIPOLOGIA_APPARATO = 'T';
        testList_apparato.add(testApparato);
        Deact.APPARATO = testList_apparato;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.COGNOME_CLIENTE = testStrAbv70Chars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.COGNOME_CLIENTE = testStrWithSplChars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.COGNOME_CLIENTE = testStrBlw20Chars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrAbv20Chars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrWithSplChars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrAbv20Chars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrWithSplChars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        Deact.CODICE_OPERATORE = 'CNN';
        Deact.CODICE_ORDINE_OLO = '98765431';
        Deact.DATA_NOTIFICA = String.valueOf(System.now()).subString(0, String.valueOf(System.now()).indexOf(' ')) + 'T' + String.valueOf(System.now()).subString(String.valueOf(System.now()).indexOf(' ')+1, String.valueOf(System.now()).length()) + '+01:00';
        Deact.ID_NOTIFICA = String.valueOf(System.now().getTime());
        Deact.ID_RISORSA = testStrAbv20Chars;
        Deact.NOME_CLIENTE = testStrBlw20Chars;
        Deact.COGNOME_CLIENTE = testStrBlw20Chars;
        Deact.RECAPITO_TELEFONICO_CLIENTE_1 = testStrBlw20Chars;
        Deact.RECAPITO_TELEFONICO_CLIENTE_2 = testStrBlw20Chars;
        Deact.TRACCIATO_TRASCODIFICATO = 'SI';
        Deact.CODICE_OPERATORE_SECONDARIO = 'SKY';
        Deact.NOTE = testStrBlw20Chars;
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_OLO_EntryChecks.SyncChecksDeactivationNew(Deact);
        Test.stopTest();
    }
    public static testMethod void OLO_AsyncDeactivationNewMethod(){
        
        OF_Tibco_userID__c tibco1 = new OF_Tibco_userID__c();
        tibco1.Name = 'Tibco UserID';
        tibco1.OF_Tibco_ID__c = '00558000001f743AAA';
        insert tibco1;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c IpCustom1= new OF_Enable_PO_UpdateOppCase_Trigger__c();
        IpCustom1.Name = 'Status';
        IpCustom1.OF_Enable_Trigger__c = true;
        insert IpCustom1; 
        
        Id RecordTypeIdasset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId(); 
        Id RecordTypeIdcase = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId(); 
        Id RecordTypeIdser1 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
        
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.Lastname = 'VF'; 
        //acc.name = 'VF';     
        insert acc;
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;
        
        Contract contratto = new Contract();
        contratto.OF_IdContratto__c = 'TEST_TIS_001';
        contratto.AccountId = acc.id;
        insert contratto;
        
        Asset ass = new Asset();
        ass.Status = 'Attivo';
        ass.name = 'oggetto';
        ass.EOF_ID_Risorsa__c = 'IdRisorsa';
        ass.AccountID = acc.Id;
        ass.RecordtypeId = RecordTypeIdasset;
        ass.OF_Contract__c = contratto.Id;
        ass.EOF_SLA_Premium_Assurance__c='Y';
        insert ass;
        
        Asset a = [Select Id,Name,recordtype.developername,Status,EOF_ID_Risorsa__c,AccountId From Asset WHERE Name = 'oggetto'];
        
        Order ordine = new Order();
        ordine.AccountId = acc.id;
        ordine.ContractId= contratto.id;
        ordine.EffectiveDate = date.today();
        ordine.status = 'Aperto';
        ordine.OF_IDRisorsa__c='IdRisorsa';
        ordine.OF_SlaPremiumAssurance__c='Y';
        insert ordine;
        
        case parentCase = new Case();
        parentCase.accountId = acc.Id;
        parentCase.Status='Acquisito';
        parentCase.AssetId = a.id;
        parentCase.EOF_Fase__c='In Verifica BO';
        parentCase.EOF_Codice_Operatore_WS__c = 'VF';
        parentCase.PO_Nome_Progetto__c='test';
        parentCase.EOF_Account_OLO__c = acc.Id;
        parentCase.EOF_Id_Risorsa__c = 'IdRisorsa';
        parentCase.RecordtypeId = RecordTypeIdcase;
        parentCase.OF_Response_Da_OLO__c = 'ACK';
        parentCase.PO_SA_Portale__c = false;
        parentCase.OF_SH_Token_id__c = 'Test';
        parentCase.EOF_DATA_PREVISTA_ATTIVAZIONE__C = System.today();
        parentCase.EOF_Data_Appuntamento__c = System.today()+1;
        parentCase.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        parentCase.OF_Bonifica_Locked_Row__c = false;
        parentCase.OF_Order__c=ordine.id;
        parentCase.OF_IDContratto__c=contratto.id;
        insert parentCase;        
        
        EOF_EAI_Service_Log__c ser = new EOF_EAI_Service_Log__c();
        ser.EOF_PROFILO__c = '17';
        ser.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c = 'Test';
        ser.EOF_ID_Notifica__c = '1529661331590';
        ser.Caso__c=parentCase.Id;  
        ser.RecordtypeId =RecordTypeIdser1;
        ser.EOF_Codice_Ordine_Olo__c = 'abc';
        //ser.EOF_NOME_CLIENTE__C ='Test';
        ser.EOF_COGNOME_CLIENTE__c = 'Test1';
        insert ser;
        List<EOF_EAI_Service_Log__c> serlist = new List<EOF_EAI_Service_Log__c>();
        serlist.add(ser);
        
        Case_AssetRecordType__c ccus=new Case_AssetRecordType__c();
        ccus.Name='test1';
        ccus.caseDevName__c='EOF_Caso_Attivazione_OPENSTREAM_CeD';
        ccus.assetDevName__c='P2P';
        ccus.beAttivazioneList__c='Canone premium,Contributo Attivazione,Contributo Consegna e istallazione,Canone,Contributo Consegna TV BOX';
        insert ccus;
        
        
        Ce_CeiRecordType__c cer=new Ce_CeiRecordType__c();
        cer.name='testcer1';
        cer.ceName__c='VLAN1';
        cer.ceiDevName__c='CPE_Passivi';
        
        insert cer;
        
        OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
        Date inizio = Date.newInstance(2016,1,1);
        Date fine = Date.newInstance(2099,12,31);
        catalogo.name = 'Catalogo_Test';
        catalogo.OF_Attivo__c = true;
        catalogo.OF_DataInizioValidita__c = inizio;
        catalogo.OF_DataFineValidita__c = fine;
        insert catalogo;
        
        
        OF_Servizio__c servizio = new OF_Servizio__c();
        servizio.name = 'Open Stream CD';
        // servizio.name = 'GPON';
        Date inizio2 = Date.newInstance(2016,1,1);
        Date fine2 = Date.newInstance(2099,12,31);
        servizio.OF_Attivo__c = true;
        servizio.OF_DataInizioValidita__c = inizio2;
        servizio.OF_DataFineValidita__c = fine2;
        servizio.OF_CatalogoCommerciale__c = catalogo.id;
        servizio.OF_Servizio_Code__c='123';
        
        insert servizio;
        
        OF_ContrattoServizio__c contrattoServizio=new OF_ContrattoServizio__c();
        contrattoServizio.OF_Contract__c=ordine.ContractId;
        contrattoServizio.OF_Servizio__c=servizio.id;
        
        insert contrattoServizio;
        
        OF_CommercialElement__c ce = new OF_CommercialElement__c();
        
        Date inizio1 = Date.newInstance(2016,1,1);
        Date fine1 = Date.newInstance(2099,12,31);
        ce.name = 'VLAN1';
        ce.OF_Attivo__c = true;
        ce.OF_DataInizioValidita__c = inizio1;
        ce.OF_DataFineValidita__c = fine1;
        ce.OF_Servizio__c = servizio.id;
        
        insert ce;
        
        
        
        OF_CommercialElementIstanziato__c CEI=new OF_CommercialElementIstanziato__c();
        String ComRecordTypeId = Schema.SObjectType.OF_CommercialElementIstanziato__c.getRecordTypeInfosByName().get('CPE').getRecordTypeId();
        //CEI.Name='Test';
        CEI.OF_Asset__c=a.id;
        CEI.OF_Stato__c='Attivo';
        CEI.RecordTypeId=ComRecordTypeId;
        CEI.OF_Case__c=parentCase.id;
        CEI.OF_EsitoConsegnaApparato__c='2';
        CEI.OF_CommercialElement__c=ce.id;
        CEI.OF_TipologiaApparato__c='1ONTVFX-1.10096378-123185280-LVRRST52R21G273B-';
        //CEI.OF_CommercialElement__c=CE.id;
        insert CEI;
        
        
        OF_ServizioBillingElement__c sb1=new OF_ServizioBillingElement__c();
        sb1.OF_Servizio__c=servizio.id;
        
        insert sb1;
        
        OF_Listino__c lr1=new OF_Listino__c();
        Date ini11 = Date.newInstance(2099,1,31);
        Date fin11= Date.newInstance(2099,1,3);
        lr1.OF_DataFineValidita__c=ini11;
        lr1.OF_DataInizioValidita__c=fin11;
        lr1.OF_ServizioBillingElement__c=sb1.Id;
        
        insert lr1;
        
        
        
        
        OF_BillingElement__c bec2=new OF_BillingElement__c();
        bec2.Name='Canone premium';
        Date ini123 = Date.newInstance(2099,1,31);
        Date fin123= Date.newInstance(2099,1,3);
        bec2.OF_DataFineValidita__c=ini123;
        bec2.OF_DataInizioValidita__c=fin123;
        bec2.OF_CommercialElement__c=ce.id;
        bec2.OF_Attivo__c=true;
        
        insert bec2;
        
        
        
        system.debug('billingintest:'+bec2);
        system.debug('billingintest for query field0:'+bec2.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec2.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec2.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec3=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone premium'];
        
        bec2=bec3;
        
        update bec2;
        
        
        
        system.debug('billingintest1:'+bec2);
        
        system.debug('billingintest2:'+bec2.OF_Attivo__c);
        system.debug('billingintest3:'+bec2.OF_Servizio__c);
        system.debug('billingintest4:'+bec2.name);
        system.debug('billingintest for query field3test:'+bec2.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        
        
        OF_BillingElement__c bec=new OF_BillingElement__c();
        bec.Name='Contributo Attivazione';
        Date ini12 = Date.newInstance(2099,1,31);
        Date fin12= Date.newInstance(2099,1,3);
        bec.OF_DataFineValidita__c=ini12;
        bec.OF_DataInizioValidita__c=fin12;
        bec.OF_CommercialElement__c=ce.id;
        bec.OF_Attivo__c=true;
        
        insert bec;
        
        
        
        system.debug('billingintest:'+bec);
        system.debug('billingintest for query field0:'+bec.OF_Servizio__c);
        system.debug('billingintest for query field1:'+bec.OF_CommercialElement__c);
        system.debug('billingintest for query field2:'+bec.OF_CommercialElement__r.OF_Servizio__c);
        system.debug('billingintest for query field3:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        OF_BillingElement__c bec1=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Attivazione'];
        
        bec=bec1;
        
        update bec;
        
        
        system.debug('billingintest1:'+bec);
        
        system.debug('billingintest2:'+bec.OF_Attivo__c);
        system.debug('billingintest3:'+bec.OF_Servizio__c);
        system.debug('billingintest4:'+bec.name);
        system.debug('billingintest for query field3test:'+bec.OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c);
        
        
        
        OF_BillingElement__c bec4=new OF_BillingElement__c();
        bec4.Name='Contributo Consegna e istallazione';
        Date ini1234 = Date.newInstance(2099,1,31);
        Date fin1234= Date.newInstance(2099,1,3);
        bec4.OF_DataFineValidita__c=ini1234;
        bec4.OF_DataInizioValidita__c=fin1234;
        bec4.OF_CommercialElement__c=ce.id;
        bec4.OF_Attivo__c=true;
        
        insert bec4;
        
        
        
        
        OF_BillingElement__c bec5=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna e istallazione'];
        
        bec4=bec5;
        
        update bec4;
        
        
        OF_BillingElement__c bec6=new OF_BillingElement__c();
        bec6.Name='Canone';
        Date ini12345 = Date.newInstance(2099,1,31);
        Date fin12345= Date.newInstance(2099,1,3);
        bec6.OF_DataFineValidita__c=ini12345;
        bec6.OF_DataInizioValidita__c=fin12345;
        bec6.OF_CommercialElement__c=ce.id;
        bec6.OF_Attivo__c=true;
        
        insert bec6;
        
        
        
        
        OF_BillingElement__c bec7=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Canone'];
        
        bec6=bec7;
        
        update bec6;
        
        //Contributo Consegna TV BOX
        //
        OF_BillingElement__c bec8=new OF_BillingElement__c();
        bec8.Name='Contributo Consegna TV BOX';
        Date ini123456 = Date.newInstance(2099,1,31);
        Date fin123456= Date.newInstance(2099,1,3);
        bec8.OF_DataFineValidita__c=ini123456;
        bec8.OF_DataInizioValidita__c=fin123456;
        bec8.OF_CommercialElement__c=ce.id;
        bec8.OF_Attivo__c=true;
        
        insert bec8;
        
        
        
        
        OF_BillingElement__c bec9=[select OF_Servizio__c,OF_CommercialElement__r.OF_Servizio__r.OF_Servizio_Code__c,Name,OF_DataFineValidita__c,OF_DataInizioValidita__c,OF_CommercialElement__c,OF_Attivo__c from OF_BillingElement__c where name='Contributo Consegna TV BOX'];
        
        bec8=bec9;
        
        update bec8;
        
        // Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
            
        );        
        update standardPricebook;
        
        // Re-Query for the Pricebook2 record, for debugging
        standardPricebook = [SELECT IsStandard
                             FROM Pricebook2 
                             WHERE Id = :standardPricebook.Id];
        
        // Create the Product
        Product2 testProduct = new Product2(
            Name = 'Contributo Verticale',
            IsActive = true
        );
        insert testProduct;
        
        
        
        Product2 testProduct1 = new Product2(
            Name = 'Contributo Consegna e Istallazione',
            IsActive = true
        );
        insert testProduct1;
        
        Pricebook2 customPB = new Pricebook2(Name='Contributo Consegna e Istallazione', isActive=true,OF_Master__c =true,PO_Commercial_element__c=ce.Id,ID_Prod__c=testProduct1.Id,OF_Listino__c=lr1.Id);
        
        insert customPB;
        
        // Create the PricebookEntry
        PricebookEntry testPbe1 = new PricebookEntry(
            // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=a.Id,
            IsActive = true,
            OF_Master__c =false
        );
        insert testPbe1;   
        
        PricebookEntry testPbecus = new PricebookEntry(
            // Name='Contributo Consegna e Istallazione',
            Pricebook2Id = customPB.Id,
            Product2Id = testProduct1.Id,
            UnitPrice = 100,
            OF_Asset__c=a.Id,
            IsActive = true,
            OF_Master__c =true
        );
        
        insert testPbecus; 
        
        OF_GPONP_GE_Utils.ListSlDeactivationOLOSF = serlist;
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.slOLOSF = ser;
        OF_GPONP_GE_Utils.checkApp = true;
        OF_GPONP_GE_Utils.caseOriginale = parentCase;
        OF_GPONP_GE_Utils.slSFOLO = ser;
        OF_GPONP_GE_Utils.a = a;
        Test.StartTest();
        Test.setMock(WebServiceMock.class, new OF_GPONP_OLO_AsyncChecks_Mock());
        OF_GPONP_OLO_AsyncChecks.OLO_AsyncDeactivationNew(parentCase.Id,ser.id);
        Test.StopTest();
    }
}