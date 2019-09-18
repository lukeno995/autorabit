@isTest
public class TestDataFactory {
    
    public static user u {get;set;}
    public static user u2 {get;set;}
    public static EOF_Notify__c objEOF {get;set;}
    public static EOF_Notify__c objEOF2 {get;set;}
    public static EOF_Notify__c objEOF3 {get;set;}
    public static EOF_Notify__c objEOF4 {get;set;}
    public static EOF_Notify__c objEOF5 {get;set;}
    public static EOF_Notify__c objEOF6 {get;set;}
    public static EOF_Notify__c objEOF7 {get;set;}
    public static EOF_Notify__c objEOF8 {get;set;}  
   	
    //EC - 2018_04_12
    public static EOF_Notify__c notifyPSM {get;set;}  
    //STOP EC - 2018_04_12
    
    public static case c{get;set;}
    public static case c1 {get;set;}
    public static case c2 {get;set;}
    public static case c3 {get;set;}
    public static case c4 {get;set;}
    public static case c5 {get;set;}
    public static case c6 {get;set;}
    public static case c7 {get;set;}
    public static case c8 {get;set;}
    public static case cpo1{get;set;}
   // public static case cpsm{get;set;} usare il case di attivazione (case c)
    public static account accOLO {get;set;}
    public static account accOLO2 {get;set;}
    public static account acc {get;set;}
    public static EOF_EAI_Service_Log__c sa {get;set;}
    public static EOF_EAI_Service_Log__c cpe {get;set;}
    public static EOF_EAI_Service_Log__c TTlog {get;set;}
    public static EOF_EAI_Service_Log__c PoTTlog {get;set;}
    public static List<EOF_EAI_Service_Log__c> ESlog {get;set;}
    public static list<Asset> ast {get;set;}
    public static asset a{get;set;}
    public static list <Case> cList {get;set;}
    //Start EC 
    public Static order o {get;set;}
    public Static order o2 {get;set;}
    public Static Case oCase {get;set;}
    public Static Case oCase1 {get;set;}
    public Static Case oCase1Coll {get;set;}
    public Static Case oCaseColl {get;set;}
    public Static Case oCase1Ord {get;set;}
    public Static Case oCaseOrd {get;set;}
    public Static OF_CommercialElementIstanziato__c Vlan{get;set;}
    public Static OF_CommercialElementIstanziato__c Vlan2{get;set;}
    public Static OF_CommercialElement__c ce {get;set;}
    public Static EOF_EAI_Service_Log__c slFatt1{get;set;}
    public Static EOF_EAI_Service_Log__c slFatt{get;set;}
    public Static EOF_EAI_Service_Log__c sl{get;set;}
    public Static EOF_EAI_Service_Log__c slOrd{get;set;}
    public Static EOF_EAI_Service_Log__c sl1{get;set;}
    public Static EOF_EAI_Service_Log__c slOrd1{get;set;}
    public Static EOF_EAI_Service_Log__c slkIT{get;set;}
    public Static EOF_EAI_Service_Log__c slkIT2{get;set;}
    public Static EOF_EAI_Service_Log__c slkIT3{get;set;}
    public Static EOF_EAI_Service_Log__c slkIT4{get;set;}
    public Static OF_CatalogoCommerciale__c cat {get;set;}
    public Static OF_Servizio__c serv {get;set;}
    //End EC
    
    public static void CreateTestRecords (String caso,string log, string notifica){
        
        // profile creation
        OF_SA_GE_Utils.rtMap=new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
        }
        
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        
        Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
        // end profile creation
        
        // OLO Account creation
        list<Account> aco = new list<Account>();
        
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO');
        
        accOLO2 = new Account();
        accOLO2.Name = 'Tiscali';
        accOLO2.EOF_Codice_Operatore__c = 'TIS';
        accOLO2.Type = 'OLO';
        accOLO2.Industry = 'Telecommunications';
        accOLO2.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO');  
        
        aco.add(accOLO);
        aco.add(accOLO2);
        insert aco;        
        // end OLO account creation
        
        //user creation
        
        list<User> usr = new list<User>();
        
        u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        usr.add(u);
        
        
        u2 = new User();
        String orgId1 = UserInfo.getOrganizationId();
        String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt1 = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName1 = orgId1 + dateString1 + randomInt1;
        u2.Alias = 'standt1';
        u2.country = 'United Kingdom';
        u2.email = uniqueName1 + '@test' + orgId1 + '.org';
        u2.EmailEncodingKey='UTF-8';
        u2.LastName='Testing';
        u2.LanguageLocaleKey='en_US';
        u2.LocaleSidKey='en_US';
        u2.ProfileId = p1.Id;
        u2.TimeZoneSidKey='America/Los_Angeles';
        u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';
        usr.add(u2);

        // end user creation
        
        insert usr;
                
        // Person Account creation
        List<Account> acp = new list<Account>();
        
        acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('PersonAccount')  ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        acp.add(acc);
        insert acp;
        // end Person account creation
        
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today(), OF_TT_TuttoSuTTM__c=false, OF_TT_CodOpOLOSuTTM__c='VF');
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;
		
       OF_CodificaProfiloListini__c codifica2 = new OF_CodificaProfiloListini__c();
       //codifica.CD_ListinoCanoneName__c = 'ListinoCanoneName';
       codifica2.OF_ProfiloCommerciale__c = 'P2PATTIVA_1G';
       codifica2.OF_ListinoCanoneName__c ='P2PATTIVA_1G';
       codifica2.Name = '1G';
       codifica2.IsPortalValid__c = true;
       codifica2.servizio__c='P2P Attiva';
       codifica2.CosType__c='MONO_COS';
       
       insert codifica2;
        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        
        // case creation
        cList = new list<Case> ();
        
        if(caso == 'EOF Caso - Attivazione'){
            c = new case();
            c.EOF_Account_OLO__c = accOLO.id;
            c.Subject = 'Richiesta di attivazione';
            c.EOF_Codice_Ordine_OLO__c = '02112016_37';
            c.EOF_Data_Prevista_Attivazione__c = system.today();
            c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c.Status = 'Acquisito';
            c.EOF_Fase__c = 'In Verifica BO';
            c.Type = '1';
            c.EOF_Tipologia_Servizio__c = 'test';
            c.EOF_Codice_Operatore_WS__c = 'VF';
            c.EOF_SLA_Premium_Assurance__c ='Y';
            c.Account = acc;
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c.EOF_Numero_Civico_WS__c = '7';
            c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c.EOF_Recapito_Test_Linea__c = '111';
            c.EOF_Tipologia_Apparato__c = 'test';
            c.OwnerId = userInfo.getUserId();
            c.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c.EOF_Id_Notifica__c = 'test_01';
            c.Origin = 'Web';
            c.Priority = 'Medium';
            c.EOF_GPON_Vincolante__c = 'Y';
            c.EOF_Order_Manager__c = true;            
            cList.add(c);
            
            c4 = new case ();
            c4.EOF_Account_OLO__c = accOLO.id;
            c4.Subject = 'Richiesta di attivazione';
            c4.EOF_Codice_Ordine_OLO__c = '02112016_38';
            c4.EOF_Data_Prevista_Attivazione__c = system.today();
            c4.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c4.Status = 'Sospeso';
            c4.EOF_Fase__c = 'In Verifica BO';
            c4.Type = '1';
            c4.EOF_Tipologia_Servizio__c = 'test';
            c4.EOF_Codice_Operatore_WS__c = 'VF';
            c4.EOF_SLA_Premium_Assurance__c ='Y';
            c4.Account = acc;
            c4.EOF_Identificativo_del_POP__c = 'PG_01';
            c4.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c4.EOF_Numero_Civico_WS__c = '7';
            c4.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c4.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c4.EOF_Recapito_Test_Linea__c = '111';
            c4.EOF_Tipologia_Apparato__c = 'test';
            c4.OwnerId = userInfo.getUserId();
            c4.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c4.EOF_Id_Notifica__c = 'test_02';
            c4.Origin = 'Web';
            c4.Priority = 'Medium';
            c4.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c4);
            
            c6 = new case();
            c6.EOF_Account_OLO__c = accOLO.id;
            c6.Subject = 'Richiesta di attivazione';
            c6.EOF_Codice_Ordine_OLO__c = '02112016_36';
            c6.EOF_Data_Prevista_Attivazione__c = system.today();
            c6.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c6.Status = 'Accettato';
            c6.EOF_Fase__c = 'In Verifica BO';
            c6.Type = '1';
            c6.EOF_Tipologia_Servizio__c = 'test';
            c6.EOF_Codice_Operatore_WS__c = 'VF';
            c6.EOF_SLA_Premium_Assurance__c ='Y';
            c6.Account = acc;
            c6.EOF_Identificativo_del_POP__c = 'PG_01';
            c6.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c6.EOF_Numero_Civico_WS__c = '7';
            c6.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c6.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c6.EOF_Recapito_Test_Linea__c = '111';
            c6.EOF_Tipologia_Apparato__c = 'test';
            c6.OwnerId = userInfo.getUserId();
            c6.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c6.EOF_Id_Notifica__c = 'test_02';
            c6.Origin = 'Web';
            c6.Priority = 'Medium';
            c6.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c6);
            
            c7 = new case();
            c7.EOF_Account_OLO__c = accOLO.id;
            c7.Subject = 'Richiesta di attivazione';
            c7.EOF_Codice_Ordine_OLO__c = '02112016_39';
            c7.EOF_Data_Prevista_Attivazione__c = system.today();
            c7.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c7.Status = 'Espletato';
            c7.EOF_Fase__c = 'In Verifica BO';
            c7.Type = '1';
            c7.EOF_Tipologia_Servizio__c = 'test';
            c7.EOF_Codice_Operatore_WS__c = 'VF';
            c7.EOF_SLA_Premium_Assurance__c ='Y';
            c7.Account = acc;
            c7.EOF_Identificativo_del_POP__c = 'PG_01';
            c7.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c7.EOF_Numero_Civico_WS__c = '7';
            c7.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c7.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c7.EOF_Recapito_Test_Linea__c = '111';
            c7.EOF_Tipologia_Apparato__c = 'test';
            c7.OwnerId = userInfo.getUserId();
            c7.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c7.EOF_Id_Notifica__c = 'test_02';
            c7.Origin = 'Web';
            c7.Priority = 'Medium';
            c7.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c7);
            
        }
        
        if(caso == 'EOF Caso - Cessazione'){
            c3 = new case();
            c3.EOF_Account_OLO__c = accOLO.id;
            c3.Subject = 'Richiesta di attivazione';
            c3.EOF_Codice_Ordine_OLO__c = '02112016_37';
            c3.EOF_Data_Prevista_Attivazione__c = system.today();
            c3.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c3.Status = 'Acquisito';
            c3.EOF_Fase__c = 'In Verifica BO';
            c3.Type = '1';
            c3.EOF_Tipologia_Servizio__c = 'test';
            c3.EOF_Codice_Operatore_WS__c = 'VF';
            c3.EOF_SLA_Premium_Assurance__c ='Y';
            c3.Account = acc;
            c3.EOF_Identificativo_del_POP__c = 'PG_01';
            c3.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c3.EOF_Numero_Civico_WS__c = '7';
            c3.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c3.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c3.EOF_Recapito_Test_Linea__c = '111';
            c3.EOF_Tipologia_Apparato__c = 'test';
            c3.OwnerId = userInfo.getUserId();
            c3.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Cessazione') ;
            c3.EOF_Id_Notifica__c = 'test_01';
            c3.Origin = 'Web';
            c3.Priority = 'Medium';
            c3.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c3);
        }
        
        if(caso == 'EOF_Caso_Attivazione_OPENSTREAM_CeD'){
            c1 = new case();
            c1.EOF_Account_OLO__c = accOLO2.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Accettato';
            c1.EOF_FASE__C = 'NA';
            c1.EOF_ID_Building_WS__c ='Test';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='EOF_Caso_Attivazione_OPENSTREAM_CeD' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione_OPENSTREAM_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            cList.add(c1);
        }
        
        if(caso == 'EOF_SP_Caso_Attivazione_CeD'){
            c1 = new case();
            c1.EOF_Account_OLO__c = accOLO2.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='TIS';
            c1.EOF_Contact__c = null;
            c1.status = 'Accettato';
            c1.EOF_FASE__C = 'NA';
            c1.EOF_ID_Building_WS__c ='Test';
            c1.RecordTypeId =[Select id from RecordType where DeveloperName ='EOF_SP_Caso_Attivazione_CeD' LIMIT 1].get(0).id;// OF_SA_GE_Utils.rtMap.get('EOF_SP_Caso_Attivazione_CeD');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            cList.add(c1);
        }
        
        if(caso == 'EOF_Caso_Attivazione_OPENSTREAM'){
            c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='VF';
            c1.EOF_Contact__c = null;
            c1.status = 'Accettato';
            c1.EOF_FASE__C = 'NA';
            c1.EOF_ID_Building_WS__c ='Test';
            c1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_Attivazione');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            cList.add(c1);
                        
        }
        
        if(caso == 'EOF_Caso_Cessazione_OPENSTREAM'){
            c2 = new case();
            c2.EOF_Codice_Ordine_olo__c ='Test';
            c2.EOF_Account_OLO__c = accOLO.id;
            c2.EOF_Contact__c = null;
            c2.status = 'Ricevuto';
            c2.EOF_FASE__C = 'NA';
            c2.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_Cessazione') ;
            
            cList.add(c2);
        }
        
        if(caso == 'EOF_Caso_Cessazione_OPENSTREAM_CD'){
            c2 = new case();
            c2.EOF_Codice_Ordine_olo__c ='Test';
            c2.EOF_Account_OLO__c = accOLO.id;
            c2.EOF_Contact__c = null;
            c2.status = 'Ricevuto';
            c2.EOF_FASE__C = 'NA';
            c2.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Cessazione_OPENSTREAM_CD') ;
            
            cList.add(c2);
        }
        
        if(caso == 'EOF_SP_Caso_Cessazione_CeD'){
            c2 = new case();
            c2.EOF_Codice_Ordine_olo__c ='Test';
            c2.EOF_Account_OLO__c = accOLO.id;
            c2.EOF_Contact__c = null;
            c2.status = 'Ricevuto';
            c2.EOF_FASE__C = 'NA';
            c2.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_SP_Caso_Cessazione_CeD') ;
            
            cList.add(c2);
        }
        
        if(caso == 'Trouble Ticket'){
            c5 = new case();
            c5.EOF_Account_OLO__c = accOLO.Id;
            c5.Subject = 'Richiesta Risoluzione Guasto';
            c5.EOF_ID_Risorsa__c = 'test';
            c5.EOF_Codice_Ordine_OLO__c = '02112016_37';
            c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
            c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c5.Status = null;
            c5.EOF_Fase__c = null;
            c5.Type = '1';
            c5.EOF_Tipologia_Servizio__c = 'test';
            c5.EOF_Codice_Operatore_WS__c = 'VF';
            c5.EOF_SLA_Premium_Assurance__c ='N';
            c5.Account = acc;
            c5.EOF_Identificativo_del_POP__c = 'PG_01';
            c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c5.EOF_Numero_Civico_WS__c = '7';
            c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c5.EOF_Recapito_Test_Linea__c = '111';
            c5.EOF_Tipologia_Apparato__c = 'test';
            c5.OwnerId = u2.Id;
            c5.RecordTypeId = OF_SA_GE_Utils.rtMap.get('Trouble_Ticket');
            c5.EOF_Id_Notifica__c = 'test_01';
            c5.Origin = 'Web';
            c5.Priority = 'Medium';
            c5.EOF_GPON_Vincolante__c = 'Y';
            c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
            c5.EOF_Codice_comunicazione_olo__c='testalo';
            c5.EOF_Categoria_Guasto__C='Disservizio';
            
            cList.add(c5);
            
        }
        if(caso =='PO_Ordine_Fiber_Lease'){
            cpo1 = new case();
            cpo1.EOF_Account_OLO__c = accOLO.id;
            cpo1.Subject = 'Richiesta di attivazione';
            cpo1.EOF_Codice_Ordine_OLO__c = '02112016_39P';
            cpo1.EOF_Data_Prevista_Attivazione__c = system.today();
            cpo1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            cpo1.Status = 'Espletato';
            cpo1.EOF_Fase__c = 'In Verifica BO';
            cpo1.Type = '1';
            cpo1.EOF_Tipologia_Servizio__c = 'test';
            cpo1.EOF_Codice_Operatore_WS__c = 'VF';
            cpo1.EOF_SLA_Premium_Assurance__c ='Y';
            cpo1.Account = acc;
            cpo1.EOF_Identificativo_del_POP__c = 'PG_01';
            cpo1.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            cpo1.EOF_Numero_Civico_WS__c = '7';
            cpo1.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            cpo1.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            cpo1.EOF_Recapito_Test_Linea__c = '111';
            cpo1.EOF_Tipologia_Apparato__c = 'test';
            cpo1.OwnerId = userInfo.getUserId();
            cpo1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            cpo1.EOF_Id_Notifica__c = 'test_02';
            cpo1.Origin = 'Web';
            cpo1.Priority = 'Medium';
            cpo1.EOF_GPON_Vincolante__c = 'Y';
            
			cList.add(cpo1);
            
        }
        
        
        
        /*if(caso == 'SN_Social_Request'){
            c8 = new case();
			c8.status = 'Inviato';
            c8.SN_Argomento__c= '';
            c8.SN_StatoApprovazione__c='';
            c8.SN_Soluzione__c='';
            c8.SN_Fine_lavorazione_Social__c =false;
            c8.SN_IsRetweet__c= false;
            c8.SN_NoteSocial__c='';
            c8.SN_Note_Assurance__c='';
			c8.SN_Note_Creation__c='';
            c8.SN_NuovoPost__c=true;
            c8.SN_Provincia__c='';
            c8.SN_Social_Reason__c='';
            c8.SN_Social_Subreason__c='';
            
            cList.add(c8);            
        }*/
        
        insert cList;
        // end case creation
        
        // notify creation
        list<EOF_Notify__c> noti = new list<EOF_Notify__c>();
        
        if(notifica =='Notifica di accettazione'){
            objEOF = new EOF_Notify__c();
            String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
            objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF.EOF_ID_Notifica__c = 'Test';
            objEOF.EOF_Stato_Richiesta__c = 'OK';
            objEOF.EOF_Codice_Operatore__c = 'VF';
            objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF.EOF_Data_Notifica__c = system.now();
            objEOF.EOF_Note__c = 'Test Note';
            objEOF.EOF_Inviata__c = false;
            objEOF.Caso__c = cList[0].id;
            objEOF.RecordTypeId = NotifyRecordTypeId;
            
            noti.add(objEOF);
            
        }
        
        if(notifica =='Notifica di acquisizione'){
            objEOF2 = new EOF_Notify__c();
            String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
            objEOF2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF2.EOF_ID_Notifica__c = 'Test Id';
            objEOF2.EOF_Stato_Richiesta__c = 'OK';
            objEOF2.EOF_Codice_Operatore__c = 'VF';
            objEOF2.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF2.EOF_Data_Notifica__c = system.now();
            objEOF2.EOF_Note__c = 'Test Note';
            objEOF2.EOF_Inviata__c = false;
            objEOF2.Caso__c = cList[0].id;
            objEOF2.RecordTYpeId = NotifyRecordTypeId1;
            
            noti.add(objEOF2);
        }
        
        if(notifica =='Notifica di espletamento'){
            objEOF3 = new EOF_Notify__c();
            String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
            objEOF3.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF3.EOF_ID_Notifica__c = 'Test Id';
            objEOF3.EOF_Stato_Richiesta__c = 'OK';
            objEOF3.EOF_Codice_Operatore__c = 'VF';
            objEOF3.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF3.EOF_Data_Notifica__c = system.now();
            objEOF3.EOF_Note__c = 'Test Note';
            objEOF3.EOF_Inviata__c = false;
            objEOF3.Caso__c = cList[0].id;
            objEOF3.RecordTypeId = NotifyRecordTypeId2;
            
            noti.add(objEOF3);
            
        }
        
        if(notifica =='Notifica di rimodulazione DAC'){
            objEOF4 = new EOF_Notify__c();
            String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
            objEOF4.RecordTypeId = NotifyRecordTypeId3;
            objEOF4.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF4.EOF_ID_Notifica__c = 'Test Id';
            objEOF4.EOF_Stato_Richiesta__c = 'OK';
            objEOF4.EOF_Codice_Operatore__c = 'VF';
            objEOF4.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF4.EOF_Data_Notifica__c = system.now();
            objEOF4.EOF_Note__c = 'Test Note';
            objEOF4.EOF_Inviata__c = false;
            objEOF4.Caso__c = cList[0].id;
            
            noti.add(objEOF4);
        }
        
        if(notifica =='Notifica di sospensione'){
            objEOF5 = new EOF_Notify__c();
            String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
            objEOF5.RecordTypeId = NotifyRecordTypeId4;
            objEOF5.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF5.EOF_ID_Notifica__c = 'Test Id';
            objEOF5.EOF_Stato_Richiesta__c = 'OK';
            objEOF5.EOF_Codice_Operatore__c = 'VF';
            objEOF5.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF5.EOF_Data_Notifica__c = system.now();
            objEOF5.EOF_Note__c = 'Test Note';
            objEOF5.EOF_Inviata__c = false;
            objEOF5.Caso__c = cList[0].id;
            
            noti.add(objEOF5);
        }
        
        if(notifica =='Notifica di desospensione'){
            objEOF6 = new EOF_Notify__c ();
            String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
            objEOF6.RecordTypeId = NotifyRecordTypeId5;
            objEOF6.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF6.EOF_ID_Notifica__c = 'Test Id';
            objEOF6.EOF_Stato_Richiesta__c = 'OK';
            objEOF6.EOF_Codice_Operatore__c = 'VF';
            objEOF6.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF6.EOF_Data_Notifica__c = system.now();
            objEOF6.EOF_Note__c = 'Test Note';
            objEOF6.EOF_Inviata__c = false;
            objEOF6.Caso__c = cList[0].id;
            
            noti.add(objEOF6);
        }
        
        if(notifica =='Notifica di cessazione'){
            objEOF7 = new EOF_Notify__c ();
            String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
            objEOF7.RecordTypeId = NotifyRecordTypeId6;
            objEOF7.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF7.EOF_ID_Notifica__c = 'Test Id';
            objEOF7.EOF_Stato_Richiesta__c = 'OK';
            objEOF7.EOF_Codice_Operatore__c = 'VF';
            objEOF7.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF7.EOF_Data_Notifica__c = system.now();
            objEOF7.EOF_Note__c = 'Test Note';
            objEOF7.EOF_Inviata__c = false;
            objEOF7.Caso__c = cList[0].id;
            
            noti.add(objEOF7);
        }
        
        if(notifica =='Notifica di annullamento'){
            objEOF8 = new EOF_Notify__c();
            String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId();
            objEOF8.RecordTypeId = NotifyRecordTypeId7;
            objEOF8.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF8.EOF_ID_Notifica__c = 'Test Id';
            objEOF8.EOF_Stato_Richiesta__c = 'OK';
            objEOF8.EOF_Codice_Operatore__c = 'VF';
            objEOF8.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF8.EOF_Data_Notifica__c = system.now();
            objEOF8.EOF_Note__c = 'Test Note';
            objEOF8.EOF_Inviata__c = false;
            objEOF8.Caso__c = cList[0].id;
            
            noti.add(objEOF8);
        }
        //EC - 2018_04_12
        
        if(notifica =='PSM_Notifica_di_Attivazione'){
        notifyPSM = new EOF_Notify__c();
        
	//	notifyPSM.LUNGHEZZA_DROP_FL_2_LEASE= 2;		//TODO creare campo su NOTIFICA
		notifyPSM.Caso__r.PO_Cavo_esistente_2_via_m_NC__c= 2;	//Cavoesistente2°via(m)NC???
	//	notifyPSM.ID_CIRCUITO_PRIMA_TRATTA= 'TEST20321561';	//TODO creare campo su NOTIFICA
	//	notifyPSM.EOF_Codice_Ordine_OLO__c;
		notifyPSM.EOF_ID_Notifica__c= 'TEST000000';
		//notifyPSM.DATA_ORDINE_COMPLETATO= system.today();	//TODO creare campo su NOTIFICA
		notifyPSM.EOF_Data_Notifica__c= system.today();
	//	notifyPSM.AZIONE='0';//Ilcampo è su EOF_EAI_Service_Log__c non su EOF_Notify__c	
		//notifyPSM.FATTIBILITA_CREATA_DA= 'TEST';	//TODO creare campo su NOTIFICA
		notifyPSM.Caso__r.PO_Data_Attivazione_Richiesta__c= String.valueOf(system.today());
		notifyPSM.Caso__r.PO_Data_Attivazione_Ordine__c= system.today();
		//notifyPSM.DATA_ATTIVAZIONE_RICHIESTA_CLIENTE= system.today();	//TODO creare campo su NOTIFICA
		//su case ci sono PO_Data_Attivazione_Richiesta__c e PO_Data_Attivazione_Ordine__c è la prima???
		//notifyPSM.DATA_ORDINE= system.today();	//TODO creare campo su NOTIFICA
		//notifyPSM.NOTE_ORDINE= 'TEST';	//TODO creare campo su NOTIFICA
		//notifyPSM.PM_DI_RIFERIMENTO= 'TEST';	//TODO creare campo su NOTIFICA
		//notifyPSM.ESITO_FATTIBILITA= 'SI - Scavo';	//TODO creare campo su NOTIFICA
		notifyPSM.Caso__r.EOF_Account_OLO__r.Name= 'TEST';
		//notifyPSM.TIPO_DI_CONTRATTO= 'Fiber Lease';
		notifyPSM.Caso__r.PO_Tipo_percorso__c= 'Diversificato';
		notifyPSM.Caso__r.PO_Tipo_di_collegamento__c= 'IP Dual Homing';
		notifyPSM.Caso__r.PO_Prime_Contractor__c= 'TEST';
		//notifyPSM.FIBRE_RICHIESTE= '5';	//TODO creare campo su NOTIFICA
		//notifyPSM.RICHIEDENTE= 'TEST';	//TODO creare campo su NOTIFICA
		//notifyPSM.DISPONIBILITA_RETE= 'TEST';	//TODO creare campo su NOTIFICA
		notifyPSM.Caso__r.PO_BB_1_via_interessato__c= 2;
		notifyPSM.Caso__r.PO_BB_2_via_interessato__c= 2;
		//notifyPSM.POP_DI_RIFERIMENTO_1= 'PG_01';
		//notifyPSM.POP_DI_RIFERIMENTO_2= 'PG_01';	
		notifyPSM.Caso__r.PO_Drop_FL_1__c= TRUE;//Y
		notifyPSM.Caso__r.PO_Drop_FL_2__c= TRUE;//Y
		//notifyPSM.POSA_1_NUOVO_CAVO= 2;
		//notifyPSM.POSA_2_NUOVO_CAVO= 2;	
		notifyPSM.Caso__r.PO_Cavo_esistente_1_via_m_NC__c= 2;
		notifyPSM.EOF_ID_Risorsa__c= '561156156156';
		notifyPSM.Motivo_Rifiuto_Sospensione_Annullamento__c= '';
		notifyPSM.Caso__r.PO_Lunghezza_m__c= 2;
		notifyPSM.Caso__r.PO_Lunghezza_m2__c= 2;
//		notifyPSM.ID_CIRCUITO_SECONDA_TRATTA= '0032115611654';
//		notifyPSM.NOTE_COLLEGAMENTO= 'TEST_note TEST';
//		notifyPSM.ID_COLLEGAMENTO= '164651843165484651654198';
		//notifyPSM.Sedi= NULL;
		//notifyPSM.Attachment= NULL;            
             
        noti.add(notifyPSM);
        }
        
        if(notifica =='PSM_Notifica_di_Cessazione'){
         //	notifyPSM.ID_CIRCUITO_PRIMA_TRATTA= 'TEST20321561';	//TODO creare campo su NOTIFICA
         // notifyPSM.EOF_Codice_Ordine_OLO__c;   
         	notifyPSM.EOF_ID_Notifica__c= 'TEST000000';
        //notifyPSM.DATA_ORDINE_COMPLETATO= system.today();	//TODO creare campo su NOTIFICA
          	notifyPSM.EOF_Data_Notifica__c= system.today();
         //	notifyPSM.AZIONE='0';//Ilcampo è su EOF_EAI_Service_Log__c non su EOF_Notify__c
         // notifyPSM.NOTE_ORDINE= 'TEST';	//TODO creare campo su NOTIFICA
            notifyPSM.Caso__r.EOF_Account_OLO__r.Name='TEST';
         // notifyPSM.ID_CIRCUITO_SECONDA_TRATTA= '0032115611654';
            notifyPSM.EOF_ID_Risorsa__c='test5465465416464';                                                                                         
			
            noti.add(notifyPSM);            
        }
        if(notifica =='PSM_Notifica_di_Annullamento'){
		 // notifyPSM.EOF_Codice_Ordine_OLO__c;
		    notifyPSM.EOF_ID_Notifica__c= 'TEST000000'; 
        //	notifyPSM.DATA_ORDINE_COMPLETATO= system.today();	//TODO creare campo su NOTIFICA
       	//  notifyPSM.AZIONE='0';//Ilcampo è su EOF_EAI_Service_Log__c non su EOF_Notify__c
     	 // notifyPSM.NOTE_ORDINE= 'TEST';	//TODO creare campo su NOTIFICA		
     	    notifyPSM.Caso__r.EOF_Account_OLO__r.Name='TEST';
            notifyPSM.Motivo_Rifiuto_Sospensione_Annullamento__c='test ci ripenso';
        }
        
        //StopEC - 2018_04_12

        if(notifica =='All'){
            
            objEOF = new EOF_Notify__c();
            String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
            objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF.EOF_ID_Notifica__c = 'Test';
            objEOF.EOF_Stato_Richiesta__c = 'OK';
            objEOF.EOF_Codice_Operatore__c = 'VF';
            objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF.EOF_Data_Notifica__c = system.now();
            objEOF.EOF_Note__c = 'Test Note';
            objEOF.EOF_Inviata__c = false;
            objEOF.Caso__c = cList[0].id;
            objEOF.RecordTypeId = NotifyRecordTypeId;
            
            noti.add(objEOF);
            
            objEOF2 = new EOF_Notify__c();
            String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
            objEOF2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF2.EOF_ID_Notifica__c = 'Test Id';
            objEOF2.EOF_Stato_Richiesta__c = 'OK';
            objEOF2.EOF_Codice_Operatore__c = 'VF';
            objEOF2.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF2.EOF_Data_Notifica__c = system.now();
            objEOF2.EOF_Note__c = 'Test Note';
            objEOF2.EOF_Inviata__c = false;
            objEOF2.Caso__c = cList[0].id;
            objEOF2.RecordTYpeId = NotifyRecordTypeId1;
            
            noti.add(objEOF2);

            objEOF3 = new EOF_Notify__c();
            String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
            objEOF3.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF3.EOF_ID_Notifica__c = 'Test Id';
            objEOF3.EOF_Stato_Richiesta__c = 'OK';
            objEOF3.EOF_Codice_Operatore__c = 'VF';
            objEOF3.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF3.EOF_Data_Notifica__c = system.now();
            objEOF3.EOF_Note__c = 'Test Note';
            objEOF3.EOF_Inviata__c = false;
            objEOF3.Caso__c = cList[0].id;
            objEOF3.RecordTypeId = NotifyRecordTypeId2;
            
            noti.add(objEOF3);

            objEOF4 = new EOF_Notify__c();
            String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
            objEOF4.RecordTypeId = NotifyRecordTypeId3;
            objEOF4.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF4.EOF_ID_Notifica__c = 'Test Id';
            objEOF4.EOF_Stato_Richiesta__c = 'OK';
            objEOF4.EOF_Codice_Operatore__c = 'VF';
            objEOF4.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF4.EOF_Data_Notifica__c = system.now();
            objEOF4.EOF_Note__c = 'Test Note';
            objEOF4.EOF_Inviata__c = false;
            objEOF4.Caso__c = cList[0].id;
            
            noti.add(objEOF4);

            objEOF5 = new EOF_Notify__c();
            String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
            objEOF5.RecordTypeId = NotifyRecordTypeId4;
            objEOF5.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF5.EOF_ID_Notifica__c = 'Test Id';
            objEOF5.EOF_Stato_Richiesta__c = 'OK';
            objEOF5.EOF_Codice_Operatore__c = 'VF';
            objEOF5.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF5.EOF_Data_Notifica__c = system.now();
            objEOF5.EOF_Note__c = 'Test Note';
            objEOF5.EOF_Inviata__c = false;
            objEOF5.Caso__c = cList[0].id;
            
            noti.add(objEOF5);
            
            objEOF6 = new EOF_Notify__c ();
            String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
            objEOF6.RecordTypeId = NotifyRecordTypeId5;
            objEOF6.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF6.EOF_ID_Notifica__c = 'Test Id';
            objEOF6.EOF_Stato_Richiesta__c = 'OK';
            objEOF6.EOF_Codice_Operatore__c = 'VF';
            objEOF6.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF6.EOF_Data_Notifica__c = system.now();
            objEOF6.EOF_Note__c = 'Test Note';
            objEOF6.EOF_Inviata__c = false;
            objEOF6.Caso__c = cList[0].id;
            
            noti.add(objEOF6);

            objEOF7 = new EOF_Notify__c ();
            String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
            objEOF7.RecordTypeId = NotifyRecordTypeId6;
            objEOF7.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF7.EOF_ID_Notifica__c = 'Test Id';
            objEOF7.EOF_Stato_Richiesta__c = 'OK';
            objEOF7.EOF_Codice_Operatore__c = 'VF';
            objEOF7.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF7.EOF_Data_Notifica__c = system.now();
            objEOF7.EOF_Note__c = 'Test Note';
            objEOF7.EOF_Inviata__c = false;
            objEOF7.Caso__c = cList[0].id;
            
            noti.add(objEOF7);

            objEOF8 = new EOF_Notify__c();
            String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId();
            objEOF8.RecordTypeId = NotifyRecordTypeId7;
            objEOF8.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF8.EOF_ID_Notifica__c = 'Test Id';
            objEOF8.EOF_Stato_Richiesta__c = 'OK';
            objEOF8.EOF_Codice_Operatore__c = 'VF';
            objEOF8.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF8.EOF_Data_Notifica__c = system.now();
            objEOF8.EOF_Note__c = 'Test Note';
            objEOF8.EOF_Inviata__c = false;
            objEOF8.Caso__c = cList[0].id;
            
            noti.add(objEOF8);
            
        }        
        insert noti;
        // end notify creation
        
        // service log creation
        ESlog = new list<EOF_EAI_Service_Log__c>();
        
        //added by Yogesh to for log = PO_SA_CD_Log_OpenStreamRequest - 16-01-19
        if(log =='PO_SA_CD_Log_OpenStreamRequest'){
            EOF_EAI_Service_Log__c eaiLog = new EOF_EAI_Service_Log__c();
            eaiLog.Caso__c  = cList[0].Id;
            eaiLog.EOF_ID_Notifica__c = 'test_01';
            eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
            eaiLog.recordTypeId = OF_SA_GE_Utils.rtMap.get('FiberRequest');
            
            ESlog.add(eaiLog);
            
            EOF_EAI_Service_Log__c eaiLog2 = new EOF_EAI_Service_Log__c();
            eaiLog2.Caso__c  = cList[0].Id;
            eaiLog2.EOF_ID_Notifica__c = 'test_02';
            eaiLog2.EOF_Codice_Ordine_OLO__c = '02112016_38';
            eaiLog2.recordTypeId = OF_SA_GE_Utils.rtMap.get('FiberRequest');
            
            ESlog.add(eaiLog2);
            
        }
        
        //enddd
    
        
        if(log =='FiberRequest'){
            EOF_EAI_Service_Log__c eaiLog = new EOF_EAI_Service_Log__c();
            eaiLog.Caso__c  = cList[0].Id;
            eaiLog.EOF_ID_Notifica__c = 'test_01';
            eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
            eaiLog.recordTypeId = OF_SA_GE_Utils.rtMap.get('FiberRequest');
            
            ESlog.add(eaiLog);
            
            EOF_EAI_Service_Log__c eaiLog2 = new EOF_EAI_Service_Log__c();
            eaiLog2.Caso__c  = cList[0].Id;
            eaiLog2.EOF_ID_Notifica__c = 'test_02';
            eaiLog2.EOF_Codice_Ordine_OLO__c = '02112016_38';
            eaiLog2.recordTypeId = OF_SA_GE_Utils.rtMap.get('FiberRequest');
            
            ESlog.add(eaiLog2);
            
        }
        
        if(log =='OF - SA - FiberRequest'){
            EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
            eaiLog3.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            eaiLog3.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            eaiLog3.EOF_ID_Notifica__c ='';
            eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
            eaiLog3.recordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_FiberRequest');
            
            ESlog.add(eaiLog3);
            
            EOF_EAI_Service_Log__c eaiLog4 = new EOF_EAI_Service_Log__c();
            eaiLog4.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            eaiLog4.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            eaiLog4.EOF_ID_Notifica__c ='0123';
            eaiLog4.EOF_STATO_ORDINE__c ='Acquisito';
            eaiLog4.recordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_FiberRequest');
            
            ESlog.add(eaiLog4);            
        }
        
        if(log =='PO - SA - FiberRequest'){    
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
            sl.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl.EOF_ID_Notifica__c ='';
            sl.EOF_STATO_ORDINE__c ='Acquisito';
            sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
            
            ESlog.add(sl);
            
            EOF_EAI_Service_Log__c sl1 = new EOF_EAI_Service_Log__c();
            sl1.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl1.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl1.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl1.EOF_ID_Notifica__c ='012';
            sl1.EOF_STATO_ORDINE__c ='Acquisito';
            sl1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
            sl1.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl1);
            
        }

        if(log=='PO - SA - FiberRequest2'){
            EOF_EAI_Service_Log__c sl1 = new EOF_EAI_Service_Log__c();
            sl1.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl1.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl1.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl1.EOF_ID_Notifica__c ='012';
            sl1.EOF_STATO_ORDINE__c ='Acquisito';
            sl1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
            sl1.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl1);

            EOF_EAI_Service_Log__c sl2 = new EOF_EAI_Service_Log__c();
            sl2.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl2.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl2.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl2.EOF_ID_Notifica__c ='12345';
            sl2.EOF_STATO_ORDINE__c ='Acquisito';
            sl2.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwerty';
            sl2.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl2);


            EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
            sl3.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Vlan'); 
            sl3.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl3.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl3.EOF_ID_Notifica__c ='12345';
            sl3.EOF_STATO_ORDINE__c ='Acquisito';
            sl3.OF_SA_VLan_Log__c=sl3.id;
            sl3.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl3);

            EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
            sl4.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cpe'); 
            sl4.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl4.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl4.EOF_ID_Notifica__c ='12345';
            sl4.EOF_STATO_ORDINE__c ='Acquisito';
            sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
            sl4.EOF_Stato_Richiesta__c='Inserita Portale';
            sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            sl4.EOF_Tipo_Comunicazione_String__c='CPE';
            
            ESlog.add(sl4);
            
            EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
            sl5 = new EOF_EAI_Service_Log__c();
            sl5.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
            sl5.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl5.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
            sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
            sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';
            
            ESlog.add(sl5);
            
            
        }
        
        if(log =='OF - SA - Vlan'){    
            EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
            sv.recordtypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Vlan');
            sv.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sv.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sv.OF_SA_VLan_Log__c=sv.id;       
            
            ESlog.add(sv);
        }
        
        if(log =='OF - SA - Servizi Aggiuntivi'){
            sa = new EOF_EAI_Service_Log__c();
            sa.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
            sa.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sa.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sa.OF_SA_Servizi_Aggiuntivi_Log__c=sa.id;
            sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            sa.OF_SA_NOME_SERVIZIO__c ='Modem';
            
            ESlog.add(sa);
        }    

        if(log =='OF - SA - Cpe'){
            cpe = new EOF_EAI_Service_Log__c();
            cpe.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Cpe');
            cpe.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            cpe.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            cpe.OF_SA_Servizi_Aggiuntivi_Log__c=cpe.id;
            cpe.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            
            ESlog.add(cpe);
        }    

        
        if(log =='OLO->SF - ActivationRequest'){
            EOF_EAI_Service_Log__c fr = new EOF_EAI_Service_Log__c ();
            fr.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            fr.EOF_Codice_Ordine_OLo__C = 'Test';
            
            ESlog.add(fr);
            
            EOF_EAI_Service_Log__c fr1 = new EOF_EAI_Service_Log__C ();
            fr1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
            fr1.EOF_Codice_Ordine_OLo__C = 'Test';
            
            ESlog.add(fr1);
            
        }
        
        if(log == 'TroubleTicketRequest') {
            
            TTlog = new EOF_EAI_Service_Log__c ();
            
            TTlog.recordtypeId=OF_SA_GE_Utils.rtMap.get('TroubleTicketRequest');            
            TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;                   
            TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
            TTlog.EOF_Tipo_Comunicazione__c = '1';
            TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
            TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;                 
            TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
            TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
            TTlog.EOF_Categoria_Guasto__c ='';
            TTlog.EOF_ID_Risorsa__c ='';
            TTlog.EOF_Causale_Apertura__c ='';
            TTlog.EOF_Nome_Cliente__c ='';
            TTlog.EOF_COgnome_CLiente__c ='';
            TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';
            TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
            TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
            TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
            TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
            TTlog.EOF_Verifica_apparato_cliente__c ='';
            TTlog.EOF_Descrizione_Problema__c ='';
            TTlog.EOF_NOTE__c ='';
            TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
            TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
            TTlog.EOF_Causale_Desospensione__c ='';
            TTlog.EOF_Referente_desospensione__c ='';
            TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
            TTlog.EOF_Data_Ora_Desospensione__c = system.today();
            TTlog.EOF_NOTE_CLIENTE__c ='';
            TTlog.EOF_Intervento_Congiunto__c ='';
            TTlog.EOF_Data_Ora_Scarto__c = system.today();
            TTlog.EOF_Data_Ora_Creazione__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
            TTlog.Causale_Scarto__c ='';
            TTlog.EOF_Descrizione_Causale_Scarto__c ='';
            TTlog.Causale_Sospensione__c ='';
            TTlog.Descrizione_Evento_Risoluzione__c ='';
            TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
            TTlog.EOF_Tec_Eof__c ='';
            TTlog.EOF_Tel_Tec_Eof__c ='';
            TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
            TTlog.EOF_STATO_ORDINE__c='';
            
            ESlog.add(TTlog);
            
        }
        
        if(log == 'PO - TT - TroubleTicketRequest'){
            PoTTlog = new EOF_EAI_Service_Log__c();
            
            PoTTlog.recordtypeId=OF_SA_GE_Utils.rtMap.get('PO_TT_TroubleTicketRequest');
            PoTTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
            PoTTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
            PoTTlog.EOF_Tipo_Comunicazione__c = '1';
            PoTTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
            PoTTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
            PoTTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
            PoTTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
            PoTTlog.EOF_Categoria_Guasto__c ='';
            PoTTlog.EOF_ID_Risorsa__c ='';
            PoTTlog.EOF_Causale_Apertura__c ='';
            PoTTlog.EOF_Nome_Cliente__c ='';
			PoTTlog.EOF_COgnome_CLiente__c ='';
            PoTTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';
            PoTTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
            PoTTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
            PoTTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
            PoTTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
            PoTTlog.EOF_Verifica_apparato_cliente__c ='';
            PoTTlog.EOF_Descrizione_Problema__c ='';
            PoTTlog.EOF_NOTE__c ='';
            PoTTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
            PoTTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.now();
            PoTTlog.EOF_Causale_Desospensione__c ='';
            PoTTlog.EOF_Referente_desospensione__c ='';
            PoTTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
            PoTTlog.EOF_Data_Ora_Desospensione__c = system.today();
            PoTTlog.EOF_NOTE_CLIENTE__c ='';
            PoTTlog.EOF_Intervento_Congiunto__c ='';
            PoTTlog.EOF_Data_Ora_Scarto__c = system.today();
            PoTTlog.EOF_Data_Ora_Creazione__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
            PoTTlog.Causale_Scarto__c ='';
            PoTTlog.EOF_Descrizione_Causale_Scarto__c ='';
            PoTTlog.Causale_Sospensione__c ='';
            PoTTlog.Descrizione_Evento_Risoluzione__c ='';
            PoTTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
            PoTTlog.EOF_Tec_Eof__c ='';
            PoTTlog.EOF_Tel_Tec_Eof__c ='';
            PoTTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
            PoTTlog.EOF_STATO_ORDINE__c='';
            
            
            ESlog.add(PoTTlog);
        }
        
        insert ESlog;
        // end service log creation
        
        // asset creation
        ast = new list<Asset>();
        
                
        a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='risorsa';
        a.name='Test';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        
        ast.add(a);
        
        Asset a1 = new Asset();
        a1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_OpenStream');
        a1.status='Attivo';
        a1.EOF_ID_Risorsa__c='risorsa';
        a1.name='Test';
        a1.accountId=accOlo.id;
        a1.EOF_OLO__c='VF';
        
        ast.add(a1);
        
        insert ast;
        // end asset creation
    }
    
     public static void CreateTestRecordsPSM (String caso, String casoPo, String log, String notifica){
        
        // profile creation
        OF_SA_GE_Utils.rtMap=new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
        }
        
        Profile p = [SELECT Id FROM Profile WHERE Name='EOF Utente Back Office'];
        
        Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
        // end profile creation
        
        // OLO Account creation
        list<Account> aco = new list<Account>();
        
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        
        aco.add(accOLO);
        insert aco;        
        // end OLO account creation
        
        //user creation
        
        list<User> usr = new list<User>();
        
        u = new User();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        usr.add(u);
        
        
        u2 = new User();
        String orgId1 = UserInfo.getOrganizationId();
        String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt1 = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName1 = orgId1 + dateString1 + randomInt1;
        u2.Alias = 'standt1';
        u2.country = 'United Kingdom';
        u2.email = uniqueName1 + '@test' + orgId1 + '.org';
        u2.EmailEncodingKey='UTF-8';
        u2.LastName='Testing';
        u2.LanguageLocaleKey='en_US';
        u2.LocaleSidKey='en_US';
        u2.ProfileId = p1.Id;
        u2.TimeZoneSidKey='America/Los_Angeles';
        u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';
        usr.add(u2);

        // end user creation
        
        insert usr;
                
        // Person Account creation
        List<Account> acp = new list<Account>();
        
        acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('PersonAccount')  ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        acp.add(acc);
        insert acp;
        // end Person account creation
        
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01');
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        
        
        // case creation
        cList = new list<Case> ();
        
        if(caso == 'EOF Caso - Attivazione'){
            c = new case();
            c.EOF_Account_OLO__c = accOLO.id;
            c.Subject = 'Richiesta di attivazione';
            c.EOF_Codice_Ordine_OLO__c = 'Test_02112016_37';
            c.EOF_Data_Prevista_Attivazione__c = system.today();
            c.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c.Status = 'Acquisito';
            c.EOF_Fase__c = 'In Verifica BO';
            c.Type = '1';
            c.EOF_Tipologia_Servizio__c = 'test';
            c.EOF_Codice_Operatore_WS__c = 'VF';
            c.EOF_SLA_Premium_Assurance__c ='Y';
            c.Account = acc;
            c.EOF_Identificativo_del_POP__c = 'PG_01';
            c.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c.EOF_Numero_Civico_WS__c = '7';
            c.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c.EOF_Recapito_Test_Linea__c = '111';
            c.EOF_Tipologia_Apparato__c = 'test';
            c.OwnerId = userInfo.getUserId();
            c.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c.EOF_Id_Notifica__c = 'test_01';
            c.Origin = 'Web';
            c.Priority = 'Medium';
            c.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c);
            
            c4 = new case ();
            c4.EOF_Account_OLO__c = accOLO.id;
            c4.Subject = 'Richiesta di attivazione';
            c4.EOF_Codice_Ordine_OLO__c = 'Test_02112016_38';
            c4.EOF_Data_Prevista_Attivazione__c = system.today();
            c4.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c4.Status = 'Sospeso';
            c4.EOF_Fase__c = 'In Verifica BO';
            c4.Type = '1';
            c4.EOF_Tipologia_Servizio__c = 'test';
            c4.EOF_Codice_Operatore_WS__c = 'VF';
            c4.EOF_SLA_Premium_Assurance__c ='Y';
            c4.Account = acc;
            c4.EOF_Identificativo_del_POP__c = 'PG_01';
            c4.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c4.EOF_Numero_Civico_WS__c = '7';
            c4.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c4.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c4.EOF_Recapito_Test_Linea__c = '111';
            c4.EOF_Tipologia_Apparato__c = 'test';
            c4.OwnerId = userInfo.getUserId();
            c4.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c4.EOF_Id_Notifica__c = 'test_02';
            c4.Origin = 'Web';
            c4.Priority = 'Medium';
            c4.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c4);
            
            c6 = new case();
            c6.EOF_Account_OLO__c = accOLO.id;
            c6.Subject = 'Richiesta di attivazione';
            c6.EOF_Codice_Ordine_OLO__c = 'Test_02112016_36';
            c6.EOF_Data_Prevista_Attivazione__c = system.today();
            c6.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c6.Status = 'Accettato';
            c6.EOF_Fase__c = 'In Verifica BO';
            c6.Type = '1';
            c6.EOF_Tipologia_Servizio__c = 'test';
            c6.EOF_Codice_Operatore_WS__c = 'VF';
            c6.EOF_SLA_Premium_Assurance__c ='Y';
            c6.Account = acc;
            c6.EOF_Identificativo_del_POP__c = 'PG_01';
            c6.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c6.EOF_Numero_Civico_WS__c = '7';
            c6.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c6.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c6.EOF_Recapito_Test_Linea__c = '111';
            c6.EOF_Tipologia_Apparato__c = 'test';
            c6.OwnerId = userInfo.getUserId();
            c6.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c6.EOF_Id_Notifica__c = 'test_02';
            c6.Origin = 'Web';
            c6.Priority = 'Medium';
            c6.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c6);
            
            c7 = new case();
            c7.EOF_Account_OLO__c = accOLO.id;
            c7.Subject = 'Richiesta di attivazione';
            c7.EOF_Codice_Ordine_OLO__c = 'Test_02112016_39';
            c7.EOF_Data_Prevista_Attivazione__c = system.today();
            c7.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c7.Status = 'Espletato';
            c7.EOF_Fase__c = 'In Verifica BO';
            c7.Type = '1';
            c7.EOF_Tipologia_Servizio__c = 'test';
            c7.EOF_Codice_Operatore_WS__c = 'VF';
            c7.EOF_SLA_Premium_Assurance__c ='Y';
            c7.Account = acc;
            c7.EOF_Identificativo_del_POP__c = 'PG_01';
            c7.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c7.EOF_Numero_Civico_WS__c = '7';
            c7.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c7.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c7.EOF_Recapito_Test_Linea__c = '111';
            c7.EOF_Tipologia_Apparato__c = 'test';
            c7.OwnerId = userInfo.getUserId();
            c7.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            c7.EOF_Id_Notifica__c = 'test_02';
            c7.Origin = 'Web';
            c7.Priority = 'Medium';
            c7.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c7);
            
        }
        
        if(caso == 'EOF Caso - Cessazione'){
            c3 = new case();
            c3.EOF_Account_OLO__c = accOLO.id;
            c3.Subject = 'Richiesta di cessazione';
            c3.EOF_Codice_Ordine_OLO__c = 'Test_02112016_37p';
            c3.EOF_Data_Prevista_Attivazione__c = system.today();
            c3.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c3.Status = 'Acquisito';
            c3.EOF_Fase__c = 'In Verifica BO';
            c3.Type = '1';
            c3.EOF_Tipologia_Servizio__c = 'test';
            c3.EOF_Codice_Operatore_WS__c = 'VF';
            c3.EOF_SLA_Premium_Assurance__c ='Y';
            c3.Account = acc;
            c3.EOF_Identificativo_del_POP__c = 'PG_01';
            c3.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c3.EOF_Numero_Civico_WS__c = '7';
            c3.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c3.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c3.EOF_Recapito_Test_Linea__c = '111';
            c3.EOF_Tipologia_Apparato__c = 'test';
            c3.OwnerId = userInfo.getUserId();
            c3.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Cessazione') ;
            c3.EOF_Id_Notifica__c = 'test_01';
            c3.Origin = 'Web';
            c3.Priority = 'Medium';
            c3.EOF_GPON_Vincolante__c = 'Y';
            
            cList.add(c3);
            
        }
        
        if(caso == 'EOF_Caso_Attivazione_OPENSTREAM'){
            c1 = new case();
            c1.EOF_Account_OLO__c = accOLO.id;
            c1.EOF_Codice_Ordine_OLO__c = 'Test';
            c1.EOF_Codice_Operatore_WS__c ='VF';
            c1.EOF_Contact__c = null;
            c1.status = 'Accettato';
            c1.EOF_FASE__C = 'NA';
            c1.EOF_ID_Building_WS__c ='Test';
            c1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_Attivazione');
            c1.EOF_DATA_NOTIFICA__c=system.now();
            c1.EOF_Data_Prevista_Attivazione__c=system.today();
            cList.add(c1);
                        
        }
        
        if(caso == 'EOF_Caso_Cessazione_OPENSTREAM'){
            c2 = new case();
            c2.EOF_Codice_Ordine_olo__c ='Test';
            c2.EOF_Account_OLO__c = accOLO.id;
            c2.EOF_Contact__c = null;
            c2.status = 'Ricevuto';
            c2.EOF_FASE__C = 'NA';
            c2.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_Cessazione') ;
            
            cList.add(c2);
        }
        
        if(caso == 'Trouble Ticket'){
            c5 = new case();
            c5.EOF_Account_OLO__c = accOLO.Id;
            c5.Subject = 'Richiesta Risoluzione Guasto';
            c5.EOF_ID_Risorsa__c = 'test';
            c5.EOF_Codice_Ordine_OLO__c = 'Test_02112016_37T';
            c5.EOF_Data_Ora_Inizio_Guasto__c = system.today();
            c5.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            c5.Status = null;
            c5.EOF_Fase__c = null;
            c5.Type = '1';
            c5.EOF_Tipologia_Servizio__c = 'test';
            c5.EOF_Codice_Operatore_WS__c = 'VF';
            c5.EOF_SLA_Premium_Assurance__c ='N';
            c5.Account = acc;
            c5.EOF_Identificativo_del_POP__c = 'PG_01';
            c5.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            c5.EOF_Numero_Civico_WS__c = '7';
            c5.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            c5.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            c5.EOF_Recapito_Test_Linea__c = '111';
            c5.EOF_Tipologia_Apparato__c = 'test';
            c5.OwnerId = u2.Id;
            c5.RecordTypeId = OF_SA_GE_Utils.rtMap.get('Trouble_Ticket');
            c5.EOF_Id_Notifica__c = 'test_01';
            c5.Origin = 'Web';
            c5.Priority = 'Medium';
            c5.EOF_GPON_Vincolante__c = 'Y';
            c5.EOF_Descrizione_Intervento_Risoluzione__c= null;
            c5.EOF_Codice_comunicazione_olo__c='testalo';
            c5.EOF_Categoria_Guasto__C='Disservizio';
            
            cList.add(c5);
            
        }
        if(casoPo =='PO_Ordine_Fiber_Lease'){
            cpo1 = new case();
            cpo1.EOF_Account_OLO__c = accOLO.id;
            cpo1.Subject = 'Richiesta di attivazione';
            cpo1.EOF_Codice_Ordine_OLO__c = 'Test_02112016_39O';
            cpo1.EOF_Data_Prevista_Attivazione__c = system.today();
            cpo1.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
            cpo1.Status = 'Espletato';
            cpo1.EOF_Fase__c = 'In Verifica BO';
            cpo1.Type = '1';
            cpo1.EOF_Tipologia_Servizio__c = 'test';
            cpo1.EOF_Codice_Operatore_WS__c = 'VF';
            cpo1.EOF_SLA_Premium_Assurance__c ='Y';
            cpo1.Account = acc;
            cpo1.EOF_Identificativo_del_POP__c = 'PG_01';
            cpo1.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
            cpo1.EOF_Numero_Civico_WS__c = '7';
            cpo1.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
            cpo1.EOF_Numero_Telefonico_Principale_Linea__c = '111';
            cpo1.EOF_Recapito_Test_Linea__c = '111';
            cpo1.EOF_Tipologia_Apparato__c = 'test';
            cpo1.OwnerId = userInfo.getUserId();
            cpo1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
            cpo1.EOF_Id_Notifica__c = 'test_02';
            cpo1.Origin = 'Web';
            cpo1.Priority = 'Medium';
            cpo1.EOF_GPON_Vincolante__c = 'Y';
            
			cList.add(cpo1);
            
        }
        
        
        
       /* if(caso == 'SN_Social_Request'){
            c8 = new case();
			c8.status = 'Inviato';
            c8.SN_Argomento__c= '';
            c8.SN_StatoApprovazione__c='';
            c8.SN_Soluzione__c='';
            c8.SN_Fine_lavorazione_Social__c =false;
            c8.SN_IsRetweet__c= false;
            c8.SN_NoteSocial__c='';
            c8.SN_Note_Assurance__c='';
			c8.SN_Note_Creation__c='';
            c8.SN_NuovoPost__c=true;
            c8.SN_Provincia__c='';
            c8.SN_Social_Reason__c='';
            c8.SN_Social_Subreason__c='';
            
            cList.add(c8);            
        }*/
        
        insert cList;
        // end case creation
        
        // notify creation
        list<EOF_Notify__c> noti = new list<EOF_Notify__c>();
        
        if(notifica =='Notifica di accettazione'){
            objEOF = new EOF_Notify__c();
            String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
            objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF.EOF_ID_Notifica__c = 'Test';
            objEOF.EOF_Stato_Richiesta__c = 'OK';
            objEOF.EOF_Codice_Operatore__c = 'VF';
            objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF.EOF_Data_Notifica__c = system.now();
            objEOF.EOF_Note__c = 'Test Note';
            objEOF.EOF_Inviata__c = false;
            objEOF.Caso__c = cList[0].id;
            objEOF.RecordTypeId = NotifyRecordTypeId;
            
            noti.add(objEOF);
            
        }
        
        if(notifica =='Notifica di acquisizione'){
            objEOF2 = new EOF_Notify__c();
            String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
            objEOF2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF2.EOF_ID_Notifica__c = 'Test Id';
            objEOF2.EOF_Stato_Richiesta__c = 'OK';
            objEOF2.EOF_Codice_Operatore__c = 'VF';
            objEOF2.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF2.EOF_Data_Notifica__c = system.now();
            objEOF2.EOF_Note__c = 'Test Note';
            objEOF2.EOF_Inviata__c = false;
            objEOF2.Caso__c = cList[0].id;
            objEOF2.RecordTYpeId = NotifyRecordTypeId1;
            
            noti.add(objEOF2);
        }
        
        if(notifica =='Notifica di espletamento'){
            objEOF3 = new EOF_Notify__c();
            String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
            objEOF3.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF3.EOF_ID_Notifica__c = 'Test Id';
            objEOF3.EOF_Stato_Richiesta__c = 'OK';
            objEOF3.EOF_Codice_Operatore__c = 'VF';
            objEOF3.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF3.EOF_Data_Notifica__c = system.now();
            objEOF3.EOF_Note__c = 'Test Note';
            objEOF3.EOF_Inviata__c = false;
            objEOF3.Caso__c = cList[0].id;
            objEOF3.RecordTypeId = NotifyRecordTypeId2;
            
            noti.add(objEOF3);
            
        }
        
        if(notifica =='Notifica di rimodulazione DAC'){
            objEOF4 = new EOF_Notify__c();
            String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
            objEOF4.RecordTypeId = NotifyRecordTypeId3;
            objEOF4.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF4.EOF_ID_Notifica__c = 'Test Id';
            objEOF4.EOF_Stato_Richiesta__c = 'OK';
            objEOF4.EOF_Codice_Operatore__c = 'VF';
            objEOF4.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF4.EOF_Data_Notifica__c = system.now();
            objEOF4.EOF_Note__c = 'Test Note';
            objEOF4.EOF_Inviata__c = false;
            objEOF4.Caso__c = cList[0].id;
            
            noti.add(objEOF4);
        }
        
        if(notifica =='Notifica di sospensione'){
            objEOF5 = new EOF_Notify__c();
            String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
            objEOF5.RecordTypeId = NotifyRecordTypeId4;
            objEOF5.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF5.EOF_ID_Notifica__c = 'Test Id';
            objEOF5.EOF_Stato_Richiesta__c = 'OK';
            objEOF5.EOF_Codice_Operatore__c = 'VF';
            objEOF5.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF5.EOF_Data_Notifica__c = system.now();
            objEOF5.EOF_Note__c = 'Test Note';
            objEOF5.EOF_Inviata__c = false;
            objEOF5.Caso__c = cList[0].id;
            
            noti.add(objEOF5);
        }
        
        if(notifica =='Notifica di desospensione'){
            objEOF6 = new EOF_Notify__c ();
            String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
            objEOF6.RecordTypeId = NotifyRecordTypeId5;
            objEOF6.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF6.EOF_ID_Notifica__c = 'Test Id';
            objEOF6.EOF_Stato_Richiesta__c = 'OK';
            objEOF6.EOF_Codice_Operatore__c = 'VF';
            objEOF6.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF6.EOF_Data_Notifica__c = system.now();
            objEOF6.EOF_Note__c = 'Test Note';
            objEOF6.EOF_Inviata__c = false;
            objEOF6.Caso__c = cList[0].id;
            
            noti.add(objEOF6);
        }
        
        if(notifica =='Notifica di cessazione'){
            objEOF7 = new EOF_Notify__c ();
            String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
            objEOF7.RecordTypeId = NotifyRecordTypeId6;
            objEOF7.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF7.EOF_ID_Notifica__c = 'Test Id';
            objEOF7.EOF_Stato_Richiesta__c = 'OK';
            objEOF7.EOF_Codice_Operatore__c = 'VF';
            objEOF7.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF7.EOF_Data_Notifica__c = system.now();
            objEOF7.EOF_Note__c = 'Test Note';
            objEOF7.EOF_Inviata__c = false;
            objEOF7.Caso__c = cList[0].id;
            
            noti.add(objEOF7);
        }
        
        if(notifica =='Notifica di annullamento'){
            objEOF8 = new EOF_Notify__c();
            String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId();
            objEOF8.RecordTypeId = NotifyRecordTypeId7;
            objEOF8.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF8.EOF_ID_Notifica__c = 'Test Id';
            objEOF8.EOF_Stato_Richiesta__c = 'OK';
            objEOF8.EOF_Codice_Operatore__c = 'VF';
            objEOF8.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF8.EOF_Data_Notifica__c = system.now();
            objEOF8.EOF_Note__c = 'Test Note';
            objEOF8.EOF_Inviata__c = false;
            objEOF8.Caso__c = cList[0].id;
            
            noti.add(objEOF8);
        }
        //EC - 2018_04_12
        
        if(notifica =='PSM_Notifica_di_Attivazione'){
        notifyPSM = new EOF_Notify__c();
        
	//	notifyPSM.LUNGHEZZA_DROP_FL_2_LEASE= 2;		//TODO creare campo su NOTIFICA
	//	notifyPSM.Caso__r.PO_Cavo_esistente_2_via_m_NC__c= 2;	//Cavoesistente2°via(m)NC???
	//	notifyPSM.ID_CIRCUITO_PRIMA_TRATTA= 'TEST20321561';	//TODO creare campo su NOTIFICA
	//	notifyPSM.EOF_Codice_Ordine_OLO__c;
        notifyPSM.Caso__c= c.id;
		notifyPSM.EOF_ID_Notifica__c= 'TEST000000';
		//notifyPSM.DATA_ORDINE_COMPLETATO= system.today();	//TODO creare campo su NOTIFICA
		notifyPSM.EOF_Data_Notifica__c= system.today();
	//	notifyPSM.AZIONE='0';//Ilcampo è su EOF_EAI_Service_Log__c non su EOF_Notify__c	
		//notifyPSM.FATTIBILITA_CREATA_DA= 'TEST';	//TODO creare campo su NOTIFICA
	//	notifyPSM.Caso__r.PO_Data_Attivazione_Richiesta__c= String.valueOf(system.today());
	//	notifyPSM.Caso__r.PO_Data_Attivazione_Ordine__c= system.today();
		//notifyPSM.DATA_ATTIVAZIONE_RICHIESTA_CLIENTE= system.today();	//TODO creare campo su NOTIFICA
		//su case ci sono PO_Data_Attivazione_Richiesta__c e PO_Data_Attivazione_Ordine__c è la prima???
		//notifyPSM.DATA_ORDINE= system.today();	//TODO creare campo su NOTIFICA
		//notifyPSM.NOTE_ORDINE= 'TEST';	//TODO creare campo su NOTIFICA
		//notifyPSM.PM_DI_RIFERIMENTO= 'TEST';	//TODO creare campo su NOTIFICA
		//notifyPSM.ESITO_FATTIBILITA= 'SI - Scavo';	//TODO creare campo su NOTIFICA
		//notifyPSM.Caso__r.EOF_Account_OLO__r.Name= 'TEST';
		//notifyPSM.TIPO_DI_CONTRATTO= 'Fiber Lease';
	//	notifyPSM.Caso__r.PO_Tipo_percorso__c= 'Diversificato';
	//	notifyPSM.Caso__r.PO_Tipo_di_collegamento__c= 'IP Dual Homing';
	//	notifyPSM.Caso__r.PO_Prime_Contractor__c= 'TEST';
		//notifyPSM.FIBRE_RICHIESTE= '5';	//TODO creare campo su NOTIFICA
		//notifyPSM.RICHIEDENTE= 'TEST';	//TODO creare campo su NOTIFICA
		//notifyPSM.DISPONIBILITA_RETE= 'TEST';	//TODO creare campo su NOTIFICA
	//	notifyPSM.Caso__r.PO_BB_1_via_interessato__c= 2;
	//	notifyPSM.Caso__r.PO_BB_2_via_interessato__c= 2;
		//notifyPSM.POP_DI_RIFERIMENTO_1= 'PG_01';
		//notifyPSM.POP_DI_RIFERIMENTO_2= 'PG_01';	
	//	notifyPSM.Caso__r.PO_Drop_FL_1__c= TRUE;//Y
	//	notifyPSM.Caso__r.PO_Drop_FL_2__c= TRUE;//Y
		//notifyPSM.POSA_1_NUOVO_CAVO= 2;
		//notifyPSM.POSA_2_NUOVO_CAVO= 2;	
	//	notifyPSM.Caso__r.PO_Cavo_esistente_1_via_m_NC__c= 2;
		notifyPSM.EOF_ID_Risorsa__c= '561156156156';
	//	notifyPSM.Motivo_Rifiuto_Sospensione_Annullamento__c= '';
	//	notifyPSM.Caso__r.PO_Lunghezza_m__c= 2;
	//	notifyPSM.Caso__r.PO_Lunghezza_m2__c= 2;
	//	notifyPSM.ID_CIRCUITO_SECONDA_TRATTA= '0032115611654';
	//	notifyPSM.NOTE_COLLEGAMENTO= 'TEST_note TEST';
	//	notifyPSM.ID_COLLEGAMENTO= '164651843165484651654198';
		//notifyPSM.Sedi= NULL;
		//notifyPSM.Attachment= NULL;            
             
        noti.add(notifyPSM);
        }
        
        if(notifica =='PSM_Notifica_di_Cessazione'){
         //	notifyPSM.ID_CIRCUITO_PRIMA_TRATTA= 'TEST20321561';	//TODO creare campo su NOTIFICA
         // notifyPSM.EOF_Codice_Ordine_OLO__c;   
         	notifyPSM.EOF_ID_Notifica__c= 'TEST000000';
        //notifyPSM.DATA_ORDINE_COMPLETATO= system.today();	//TODO creare campo su NOTIFICA
          	notifyPSM.EOF_Data_Notifica__c= system.today();
         //	notifyPSM.AZIONE='0';//Ilcampo è su EOF_EAI_Service_Log__c non su EOF_Notify__c
         // notifyPSM.NOTE_ORDINE= 'TEST';	//TODO creare campo su NOTIFICA
         //   notifyPSM.Caso__r.EOF_Account_OLO__r.Name='TEST';
         // notifyPSM.ID_CIRCUITO_SECONDA_TRATTA= '0032115611654';
            notifyPSM.EOF_ID_Risorsa__c='test5465465416464';                                                                                         
			
            noti.add(notifyPSM);            
        }
        if(notifica =='PSM_Notifica_di_Annullamento'){
		 // notifyPSM.EOF_Codice_Ordine_OLO__c;
		    notifyPSM.EOF_ID_Notifica__c= 'TEST000000'; 
        //	notifyPSM.DATA_ORDINE_COMPLETATO= system.today();	//TODO creare campo su NOTIFICA
       	//  notifyPSM.AZIONE='0';//Ilcampo è su EOF_EAI_Service_Log__c non su EOF_Notify__c
     	 // notifyPSM.NOTE_ORDINE= 'TEST';	//TODO creare campo su NOTIFICA		
     	//  notifyPSM.Caso__r.EOF_Account_OLO__r.Name='TEST';
            notifyPSM.Motivo_Rifiuto_Sospensione_Annullamento__c='test ci ripenso';
        }
        
        //StopEC - 2018_04_12

        if(notifica =='All'){
            
            objEOF = new EOF_Notify__c();
            String NotifyRecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di accettazione').getRecordTypeId();
            objEOF.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF.EOF_ID_Notifica__c = 'Test';
            objEOF.EOF_Stato_Richiesta__c = 'OK';
            objEOF.EOF_Codice_Operatore__c = 'VF';
            objEOF.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF.EOF_Data_Notifica__c = system.now();
            objEOF.EOF_Note__c = 'Test Note';
            objEOF.EOF_Inviata__c = false;
            objEOF.Caso__c = cList[0].id;
            objEOF.RecordTypeId = NotifyRecordTypeId;
            
            noti.add(objEOF);
            
            objEOF2 = new EOF_Notify__c();
            String NotifyRecordTypeId1 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione').getRecordTypeId();
            objEOF2.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF2.EOF_ID_Notifica__c = 'Test Id';
            objEOF2.EOF_Stato_Richiesta__c = 'OK';
            objEOF2.EOF_Codice_Operatore__c = 'VF';
            objEOF2.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF2.EOF_Data_Notifica__c = system.now();
            objEOF2.EOF_Note__c = 'Test Note';
            objEOF2.EOF_Inviata__c = false;
            objEOF2.Caso__c = cList[0].id;
            objEOF2.RecordTYpeId = NotifyRecordTypeId1;
            
            noti.add(objEOF2);

            objEOF3 = new EOF_Notify__c();
            String NotifyRecordTypeId2 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId();
            objEOF3.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF3.EOF_ID_Notifica__c = 'Test Id';
            objEOF3.EOF_Stato_Richiesta__c = 'OK';
            objEOF3.EOF_Codice_Operatore__c = 'VF';
            objEOF3.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF3.EOF_Data_Notifica__c = system.now();
            objEOF3.EOF_Note__c = 'Test Note';
            objEOF3.EOF_Inviata__c = false;
            objEOF3.Caso__c = cList[0].id;
            objEOF3.RecordTypeId = NotifyRecordTypeId2;
            
            noti.add(objEOF3);

            objEOF4 = new EOF_Notify__c();
            String NotifyRecordTypeId3 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di rimodulazione DAC').getRecordTypeId();
            objEOF4.RecordTypeId = NotifyRecordTypeId3;
            objEOF4.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF4.EOF_ID_Notifica__c = 'Test Id';
            objEOF4.EOF_Stato_Richiesta__c = 'OK';
            objEOF4.EOF_Codice_Operatore__c = 'VF';
            objEOF4.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF4.EOF_Data_Notifica__c = system.now();
            objEOF4.EOF_Note__c = 'Test Note';
            objEOF4.EOF_Inviata__c = false;
            objEOF4.Caso__c = cList[0].id;
            
            noti.add(objEOF4);

            objEOF5 = new EOF_Notify__c();
            String NotifyRecordTypeId4 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di sospensione').getRecordTypeId();
            objEOF5.RecordTypeId = NotifyRecordTypeId4;
            objEOF5.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF5.EOF_ID_Notifica__c = 'Test Id';
            objEOF5.EOF_Stato_Richiesta__c = 'OK';
            objEOF5.EOF_Codice_Operatore__c = 'VF';
            objEOF5.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF5.EOF_Data_Notifica__c = system.now();
            objEOF5.EOF_Note__c = 'Test Note';
            objEOF5.EOF_Inviata__c = false;
            objEOF5.Caso__c = cList[0].id;
            
            noti.add(objEOF5);
            
            objEOF6 = new EOF_Notify__c ();
            String NotifyRecordTypeId5 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di desospensione').getRecordTypeId();
            objEOF6.RecordTypeId = NotifyRecordTypeId5;
            objEOF6.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF6.EOF_ID_Notifica__c = 'Test Id';
            objEOF6.EOF_Stato_Richiesta__c = 'OK';
            objEOF6.EOF_Codice_Operatore__c = 'VF';
            objEOF6.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF6.EOF_Data_Notifica__c = system.now();
            objEOF6.EOF_Note__c = 'Test Note';
            objEOF6.EOF_Inviata__c = false;
            objEOF6.Caso__c = cList[0].id;
            
            noti.add(objEOF6);

            objEOF7 = new EOF_Notify__c ();
            String NotifyRecordTypeId6 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione').getRecordTypeId();
            objEOF7.RecordTypeId = NotifyRecordTypeId6;
            objEOF7.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF7.EOF_ID_Notifica__c = 'Test Id';
            objEOF7.EOF_Stato_Richiesta__c = 'OK';
            objEOF7.EOF_Codice_Operatore__c = 'VF';
            objEOF7.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF7.EOF_Data_Notifica__c = system.now();
            objEOF7.EOF_Note__c = 'Test Note';
            objEOF7.EOF_Inviata__c = false;
            objEOF7.Caso__c = cList[0].id;
            
            noti.add(objEOF7);

            objEOF8 = new EOF_Notify__c();
            String NotifyRecordTypeId7 = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di annullamento').getRecordTypeId();
            objEOF8.RecordTypeId = NotifyRecordTypeId7;
            objEOF8.EOF_Codice_Ordine_EOF__c = 'Test_VF_1234';
            objEOF8.EOF_ID_Notifica__c = 'Test Id';
            objEOF8.EOF_Stato_Richiesta__c = 'OK';
            objEOF8.EOF_Codice_Operatore__c = 'VF';
            objEOF8.EOF_GPON_Attestazione__c = 'Test Gpon';
            objEOF8.EOF_Data_Notifica__c = system.now();
            objEOF8.EOF_Note__c = 'Test Note';
            objEOF8.EOF_Inviata__c = false;
            objEOF8.Caso__c = cList[0].id;
            
            noti.add(objEOF8);
            
        }        
        insert noti;
        // end notify creation
        
        // service log creation
        ESlog = new list<EOF_EAI_Service_Log__c>();
        
        if(log =='FiberRequest'){
            EOF_EAI_Service_Log__c eaiLog = new EOF_EAI_Service_Log__c();
            eaiLog.Caso__c  = cList[0].Id;
            eaiLog.EOF_ID_Notifica__c = 'test_01';
            eaiLog.EOF_Codice_Ordine_OLO__c = '02112016_37';
            eaiLog.recordTypeId = OF_SA_GE_Utils.rtMap.get('FiberRequest');
            
            ESlog.add(eaiLog);
            
            EOF_EAI_Service_Log__c eaiLog2 = new EOF_EAI_Service_Log__c();
            eaiLog2.Caso__c  = cList[0].Id;
            eaiLog2.EOF_ID_Notifica__c = 'test_02';
            eaiLog2.EOF_Codice_Ordine_OLO__c = '02112016_38';
            eaiLog2.recordTypeId = OF_SA_GE_Utils.rtMap.get('FiberRequest');
            
            ESlog.add(eaiLog2);
            
        }
        
        if(log =='OF - SA - FiberRequest'){
            EOF_EAI_Service_Log__c eaiLog3 = new EOF_EAI_Service_Log__c();
            eaiLog3.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            eaiLog3.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            eaiLog3.EOF_ID_Notifica__c ='';
            eaiLog3.EOF_STATO_ORDINE__c ='Acquisito';
            eaiLog3.recordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_FiberRequest');
            
            ESlog.add(eaiLog3);
            
            EOF_EAI_Service_Log__c eaiLog4 = new EOF_EAI_Service_Log__c();
            eaiLog4.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            eaiLog4.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            eaiLog4.EOF_ID_Notifica__c ='0123';
            eaiLog4.EOF_STATO_ORDINE__c ='Acquisito';
            eaiLog4.recordTypeId = OF_SA_GE_Utils.rtMap.get('OF_SA_FiberRequest');
            
            ESlog.add(eaiLog4);            
        }
        
        if(log =='PO - SA - FiberRequest'){    
            EOF_EAI_Service_Log__c sl = new EOF_EAI_Service_Log__c();
            sl.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl.EOF_ID_Notifica__c ='';
            sl.EOF_STATO_ORDINE__c ='Acquisito';
            sl.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
            
            ESlog.add(sl);
            
            EOF_EAI_Service_Log__c sl1 = new EOF_EAI_Service_Log__c();
            sl1.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl1.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl1.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl1.EOF_ID_Notifica__c ='012';
            sl1.EOF_STATO_ORDINE__c ='Acquisito';
            sl1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
            sl1.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl1);
            
        }

        if(log=='PO - SA - FiberRequest2'){
            EOF_EAI_Service_Log__c sl1 = new EOF_EAI_Service_Log__c();
            sl1.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl1.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl1.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl1.EOF_ID_Notifica__c ='012';
            sl1.EOF_STATO_ORDINE__c ='Acquisito';
            sl1.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwer';
            sl1.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl1);

            EOF_EAI_Service_Log__c sl2 = new EOF_EAI_Service_Log__c();
            sl2.RecordTypeId=OF_SA_GE_Utils.rtMap.get('PO_SA_FiberRequest'); 
            sl2.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl2.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl2.EOF_ID_Notifica__c ='12345';
            sl2.EOF_STATO_ORDINE__c ='Acquisito';
            sl2.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c='qwerty';
            sl2.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl2);


            EOF_EAI_Service_Log__c sl3 = new EOF_EAI_Service_Log__c();
            sl3.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Vlan'); 
            sl3.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl3.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl3.EOF_ID_Notifica__c ='12345';
            sl3.EOF_STATO_ORDINE__c ='Acquisito';
            sl3.OF_SA_VLan_Log__c=sl3.id;
            sl3.EOF_Stato_Richiesta__c='Inserita Portale';
            
            ESlog.add(sl3);

            EOF_EAI_Service_Log__c sl4 = new EOF_EAI_Service_Log__c();
            sl4.RecordTypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Cpe'); 
            sl4.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl4.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl4.EOF_ID_Notifica__c ='12345';
            sl4.EOF_STATO_ORDINE__c ='Acquisito';
            sl4.OF_SA_Servizi_Aggiuntivi_Log__c=sl4.id;
            sl4.EOF_Stato_Richiesta__c='Inserita Portale';
            sl4.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            sl4.EOF_Tipo_Comunicazione_String__c='CPE';
            
            ESlog.add(sl4);
            
            EOF_EAI_Service_Log__c sl5 = new EOF_EAI_Service_Log__c();
            sl5 = new EOF_EAI_Service_Log__c();
            sl5.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
            sl5.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sl5.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sl5.OF_SA_Servizi_Aggiuntivi_Log__c=sl5.id;
            sl5.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            sl5.OF_SA_NOME_SERVIZIO__c ='Modem';
            sl5.EOF_Tipo_Comunicazione_String__c='SERVIZIO AGGIUNTIVO';
            
            ESlog.add(sl5);
            
            
        }
        
        if(log =='OF - SA - Vlan'){    
            EOF_EAI_Service_Log__c sv = new EOF_EAI_Service_Log__c();
            sv.recordtypeId=OF_SA_GE_Utils.rtMap.get('OF_SA_Vlan');
            sv.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sv.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sv.OF_SA_VLan_Log__c=sv.id;       
            
            ESlog.add(sv);
        }
        
        if(log =='OF - SA - Servizi Aggiuntivi'){
            sa = new EOF_EAI_Service_Log__c();
            sa.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Servizi_Aggiuntivi');
            sa.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            sa.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            sa.OF_SA_Servizi_Aggiuntivi_Log__c=sa.id;
            sa.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            sa.OF_SA_NOME_SERVIZIO__c ='Modem';
            
            ESlog.add(sa);
        }    

        if(log =='OF - SA - Cpe'){
            cpe = new EOF_EAI_Service_Log__c();
            cpe.recordtypeId= OF_SA_GE_Utils.rtMap.get('OF_SA_Cpe');
            cpe.EOF_Codice_Ordine_OLO__c =cList[0].EOF_Codice_Ordine_OLO__c;
            cpe.EOF_Data_Notifica__c= cList[0].EOF_Data_Notifica__c;
            cpe.OF_SA_Servizi_Aggiuntivi_Log__c=cpe.id;
            cpe.OF_SA_INFORMAZIONI_SERVIZIO__c='213';
            
            ESlog.add(cpe);
        }    

        
        if(log =='OLO->SF - ActivationRequest'){
            EOF_EAI_Service_Log__c fr = new EOF_EAI_Service_Log__c ();
            fr.eof_tipo_comunicazione_String__c='OLO->SF - ActivationRequest';
            fr.EOF_Codice_Ordine_OLo__C = 'Test';
            
            ESlog.add(fr);
            
            EOF_EAI_Service_Log__c fr1 = new EOF_EAI_Service_Log__C ();
            fr1.eof_tipo_comunicazione_String__c='OLO->SF - ACK - ActivationRequest';
            fr1.EOF_Codice_Ordine_OLo__C = 'Test';
            
            ESlog.add(fr1);
            
        }
        
        if(log == 'TroubleTicketRequest') {
            
            TTlog = new EOF_EAI_Service_Log__c ();
            
            TTlog.recordtypeId=OF_SA_GE_Utils.rtMap.get('TroubleTicketRequest');            
            TTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;                   
            TTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
            TTlog.EOF_Tipo_Comunicazione__c = '1';
            TTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
            TTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;                 
            TTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';       
            TTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
            TTlog.EOF_Categoria_Guasto__c ='';
            TTlog.EOF_ID_Risorsa__c ='';
            TTlog.EOF_Causale_Apertura__c ='';
            TTlog.EOF_Nome_Cliente__c ='';
            TTlog.EOF_COgnome_CLiente__c ='';
            TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';
            TTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
            TTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
            TTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
            TTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
            TTlog.EOF_Verifica_apparato_cliente__c ='';
            TTlog.EOF_Descrizione_Problema__c ='';
            TTlog.EOF_NOTE__c ='';
            TTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
            TTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.today();
            TTlog.EOF_Causale_Desospensione__c ='';
            TTlog.EOF_Referente_desospensione__c ='';
            TTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
            TTlog.EOF_Data_Ora_Desospensione__c = system.today();
            TTlog.EOF_NOTE_CLIENTE__c ='';
            TTlog.EOF_Intervento_Congiunto__c ='';
            TTlog.EOF_Data_Ora_Scarto__c = system.today();
            TTlog.EOF_Data_Ora_Creazione__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
            TTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
            TTlog.Causale_Scarto__c ='';
            TTlog.EOF_Descrizione_Causale_Scarto__c ='';
            TTlog.Causale_Sospensione__c ='';
            TTlog.Descrizione_Evento_Risoluzione__c ='';
            TTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
            TTlog.EOF_Tec_Eof__c ='';
            TTlog.EOF_Tel_Tec_Eof__c ='';
            TTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
            TTlog.EOF_STATO_ORDINE__c='';
            
            ESlog.add(TTlog);
            
        }
        
        if(log == 'PO - TT - TroubleTicketRequest'){
            PoTTlog = new EOF_EAI_Service_Log__c();
            
            PoTTlog.recordtypeId=OF_SA_GE_Utils.rtMap.get('PO_TT_TroubleTicketRequest');
            PoTTlog.EOF_Codice_Comunicazione_OLO__c = cList[0].EOF_CODICE_COMUNICAZIONE_OLO__c;
            PoTTlog.EOF_Codice_Operatore__c = cList[0].EOF_Codice_Operatore_WS__c;
            PoTTlog.EOF_Tipo_Comunicazione__c = '1';
            PoTTlog.EOF_Data_Notifica__c = cList[0].EOF_Data_Notifica__c;
            PoTTlog.EOF_ID_Notifica__c = cList[0].EOF_ID_NOTIFICA__c;
            PoTTlog.EOF_Richiesta_Notifica__c = 'Richiesta Risoluzione Guasto';
            PoTTlog.EOF_Data_Ora_Inizio_Guasto__c = system.today();
            PoTTlog.EOF_Categoria_Guasto__c ='';
            PoTTlog.EOF_ID_Risorsa__c ='';
            PoTTlog.EOF_Causale_Apertura__c ='';
            PoTTlog.EOF_Nome_Cliente__c ='';
			PoTTlog.EOF_COgnome_CLiente__c ='';
            PoTTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c ='';
            PoTTlog.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c ='';
            PoTTlog.EOF_NOME_REFERENTE_TECNICO_OLO__c ='';
            PoTTlog.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c ='';
            PoTTlog.EOF_EMAIL_REFERENTE_TECNICO_OLO__c ='';
            PoTTlog.EOF_Verifica_apparato_cliente__c ='';
            PoTTlog.EOF_Descrizione_Problema__c ='';
            PoTTlog.EOF_NOTE__c ='';
            PoTTlog.EOF_CAUSALE_RICHIESTA_ANNULLAMENTO__c ='';
            PoTTlog.EOF_Data_Ora_Richiesta_Annullamento__c = system.now();
            PoTTlog.EOF_Causale_Desospensione__c ='';
            PoTTlog.EOF_Referente_desospensione__c ='';
            PoTTlog.EOF_Data_Ora_Autoripristinato__c = system.today();
            PoTTlog.EOF_Data_Ora_Desospensione__c = system.today();
            PoTTlog.EOF_NOTE_CLIENTE__c ='';
            PoTTlog.EOF_Intervento_Congiunto__c ='';
            PoTTlog.EOF_Data_Ora_Scarto__c = system.today();
            PoTTlog.EOF_Data_Ora_Creazione__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Sospensione__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Desospensione__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Annullamento__c = system.today();
            PoTTlog.EOF_Data_Ora_Notifica_Chiusura__c = system.today();
            PoTTlog.Causale_Scarto__c ='';
            PoTTlog.EOF_Descrizione_Causale_Scarto__c ='';
            PoTTlog.Causale_Sospensione__c ='';
            PoTTlog.Descrizione_Evento_Risoluzione__c ='';
            PoTTlog.EOF_Rischedulazione_Appuntamento__c = system.today();
            PoTTlog.EOF_Tec_Eof__c ='';
            PoTTlog.EOF_Tel_Tec_Eof__c ='';
            PoTTlog.EOF_Data_Ora_Intervento_Congiunto__c = system.today();
            PoTTlog.EOF_STATO_ORDINE__c='';
            
            
            ESlog.add(PoTTlog);
        }
        
        insert ESlog;
        // end service log creation
        
        // asset creation
        ast = new list<Asset>();
        
                
        a = new Asset();
        a.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_GPONPassiva');
        a.status='Attivo';
        a.EOF_ID_Risorsa__c='risorsa';
        a.name='Test';
        a.accountId=accOlo.id;
        a.EOF_OLO__c='VF';
        
        ast.add(a);
        
        Asset a1 = new Asset();
        a1.RecordTypeId = OF_SA_GE_Utils.rtMap.get('OF_OpenStream');
        a1.status='Attivo';
        a1.EOF_ID_Risorsa__c='risorsa';
        a1.name='Test';
        a1.accountId=accOlo.id;
        a1.EOF_OLO__c='VF';
        
        ast.add(a1);
        
        insert ast;
        // end asset creation
    }
    
    //
    public static User CreateUserData(String name, String role, String profName,String cntID) {
        User user = new User(LastName = name,
                             Email = 'abc@atos.com',
                           
                             Username =  name + profName + 'abc@atos.com',
                             CompanyName = 'TEST',
                             Title = 'title',
                             Alias = 'alias',
                             TimeZoneSidKey = 'America/Los_Angeles',
                             EmailEncodingKey = 'UTF-8',
                             LanguageLocaleKey = 'en_US',
                             LocaleSidKey = 'en_US',
                             UserRoleId = [SELECT Id FROM UserRole WHERE Name=:role].Id,
                             ContactId=cntID,
                             ProfileId = [SELECT Id FROM Profile WHERE Name=:profName ].Id);
        return user;
    }
    /*
    public static void CreateTestRecordsP2PAtt (){
        
        // profile creation
        OF_SA_GE_Utils.rtMap=new map<String,String>();
        for(recordtype rt : [select id,developername from recordtype]){
            OF_SA_GE_Utils.rtMap.put(rt.developername,rt.id);
        }
        
        Profile pParComSupUser = [SELECT Id FROM Profile WHERE Name='Partner Community Super User'];
        Profile pParComUser = [SELECT Id FROM Profile WHERE Name='Partner Community User'];
        UserRole pParComSupUserRole = [SELECT Id,Name FROM UserRole where Name='tiscali Partner User'];
        
        
        Profile p1 = [SELECT id FROM Profile WHERE Name ='System Administrator'];
        // end profile creation
        
        // OLO Account creation
        list<Account> aco = new list<Account>();
        
        accOLO = new Account();
        accOLO.Name = 'Vodafone';
        accOLO.EOF_Codice_Operatore__c = 'VF';
        accOLO.Type = 'OLO';
        accOLO.Industry = 'Telecommunications';
        accOLO.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('OLO') ;
        
        aco.add(accOLO);
        insert aco;        
        // end OLO account creation
        
        //user creation
        
        Contact cnt = new Contact();
        cnt.AccountId=accOLO.id;
        cnt.Email='cnt@test.it';
        cnt.PO_Super_User__c=true;
        cnt.PO_Servizi_a_fattibilit__c=true;
        cnt.PO_P2P_Attiva__c=true;
        cnt.LastName='TESTTEST';
            
        insert cnt;
        
        list<User> usr = new list<User>();
        // public static User CreateUserData(String name, String role, String profName)
       	User u = CreateUserData('TEST','tiscali Partner User','Partner Community Super User', cnt.id);
        /*String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        u.Alias = 'standt1';
        u.country = 'United Kingdom';
        u.email = uniqueName + '@test' + orgId + '.org';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        u.ProfileId = pParComSupUser.Id;
        u.UserRoleId=  pParComSupUserRole.Id;
        u.ContactId=cnt.id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName = uniqueName + '@test' + orgId + '.org';
        insert u;
		*/
    /*
        u.ContactId=cnt.id;
        usr.add(u);
        //insert usr;
       
        
        u2 = new User();
        String orgId1 = UserInfo.getOrganizationId();
        String dateString1 = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt1 = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName1 = orgId1 + dateString1 + randomInt1;
        u2.Alias = 'standt1';
        u2.country = 'United Kingdom';
        u2.email = uniqueName1 + '@test' + orgId1 + '.org';
        u2.EmailEncodingKey='UTF-8';
        u2.LastName='Testing';
        u2.LanguageLocaleKey='en_US';
        u2.LocaleSidKey='en_US';
        u2.ProfileId = p1.Id;
        u2.TimeZoneSidKey='America/Los_Angeles';
        u2.UserName = uniqueName1 + '@test' + orgId1 + '.org';
        insert u2;
        usr.add(u2);

        // end user creation
        
        //insert usr;
             
        // Person Account creation
        List<Account> acp = new list<Account>();
        
        acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
        acc.Phone = '0000';
        acc.EOF_Phone_2__c = '0000';
        acc.EOF_Provincia__c = 'Milano';
        acc.EOF_Comune__c = 'Milano';
        acc.EOF_Indirizzo__c = 'Piazzale Gorini';
        acc.RecordTYpeId = OF_SA_GE_Utils.rtMap.get('PersonAccount')  ;
        acc.EOF_Particella_Toponomastica__c = '123';
        acc.EOF_Numero_Civico__c = '7';
        
        acp.add(acc);
        insert acp;
        // end Person account creation
        
        // custom settings creation for endponints
        insert new OF_Puntamento_Callout__c(Name ='OF_Puntamento_Callout',OF_OGW__c = 'OFS-SVIL-WS');
        // end custom settings creation for endponints
        
        // custom settings creation for OM switch
        insert new OF_Configurazioni__c (Name ='listCustomSett', DataSwitchOM__c = DateTime.now(), EOF_Attiva_Check_POP_OLO__c = true, EOF_Codice_Operatore_OLO__c ='WN;VF;TIS', EOF_Pop_OM__c ='PG_01', OF_checkTrueVaiSuOM__c = true, OF_DataSwitchTTM__c =system.today(), OF_TT_TuttoSuTTM__c=false, OF_TT_CodOpOLOSuTTM__c='VF');
        // end custom settings creation for OM switch
        
        // custom settings creation for OLO ID
        insert new OLO_ID__c (Name ='VF', OF_Olo_Id__c = accOLO.id);
        // end custom settings creation for OLO ID
        
        // custom settings creation for trigger PO_UpdateOppCase
        OF_Tibco_userID__c tibco=new OF_Tibco_userID__c();
        tibco.OF_Tibco_ID__c='00558000001f743AAA';
        tibco.name='Tibco UserID';
        insert tibco;

        
        OF_Enable_PO_UpdateOppCase_Trigger__c abilitaTrig =new OF_Enable_PO_UpdateOppCase_Trigger__c();
        abilitaTrig.name='Status';
        abilitaTrig.OF_Enable_Trigger__c=true;
        insert abilitaTrig;        
        // end custom settings creation for trigger PO_UpdateOppCase
        // 
        Profile prfl = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
       
        
       
        
        
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype]){
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
         List<Case> listOrderCases = new List<Case>();
         List<EOF_EAI_Service_Log__c> SlogToInsert = new List<EOF_EAI_Service_Log__c>();
         Group codaSupportoVendite = [Select Id from Group where DeveloperName='PO_Coda_Ordini_Fattibilita']; 
         Case oCase = new Case();
         oCase.Status='Accettato';
         oCase.EOF_Codice_Operatore_WS__c='TIS';
         oCase.AccountId=accOLO.id;
         oCase.EOF_Codice_Ordine_OLO__c='Test_9808980';
         oCase.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase.OwnerId=u.id;
         oCase.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         oCase.PO_Nome_Progetto__c='TEST Nome Progetto';
        
         insert oCase; 
        
         Case oCaseColl = new Case();
         oCaseColl.Status='Accettato';
         oCaseColl.parentid=oCase.id;
         oCaseColl.EOF_Codice_Operatore_WS__c='TIS';
         oCaseColl.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCaseColl.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCaseColl.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCaseColl.OwnerId=u.id;
         oCaseColl.PO_Tipo_percorso__c='SINGOLA VIA';
         oCaseColl.PO_Richiesta_a_fattibilit__c=oCase.id;
         oCaseColl.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         insert oCaseColl;
         List <Case> caseToOrder = new List<Case>();
         caseToOrder.add(oCaseColl);
         Case oCaseOrd = new Case();
         oCaseOrd.Status='Accettato';
         oCaseOrd.EOF_Codice_Operatore_WS__c='TIS';
         oCaseOrd.ParentId=oCaseColl.id;
         oCaseOrd.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCaseOrd.PO_Nome_E_Cognome_PM__c='TEST';
         oCaseOrd.PO_Case_Collegamento__c=oCaseColl.id;
         oCaseOrd.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCaseOrd.OwnerId=u.id;
         oCaseOrd.PO_Richiesta_a_fattibilit__c=oCase.id;
         oCaseOrd.RecordTypeId=mpRT.get('PO_Ordine_P2P_Attiva');
         insert oCaseOrd;
        
        
        
        EOF_EAI_Service_Log__c slFatt= new EOF_EAI_Service_Log__c();
        slFatt.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slFatt.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slFatt.EOF_Stato_Richiesta__c='Accettato';
        slFatt.PO_Offerta__c='P2P Attiva';
        slFatt.PO_Offerta_Inoltrata__c=false; //true
        slFatt.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        
        
        insert slFatt;
        
        EOF_EAI_Service_Log__c slkIT2= new EOF_EAI_Service_Log__c();
        slkIT2.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT2.EOF_ID_Pop__c='Pop 2';
        slkIT2.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        slkIT2.EOF_SL_Riferimento__c=slFatt.id;
        insert slkIT2;
        
        EOF_EAI_Service_Log__c slkIT= new EOF_EAI_Service_Log__c();
        slkIT.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT.EOF_ID_Pop__c='Pop 1';
        slkIT.PO_P2PAttiva_Optical_Rate_Limiting__c='1 GB'; //10 GB
        slkIT.EOF_SL_Riferimento__c=slFatt.id;
        insert slkIT;
        
        EOF_EAI_Service_Log__c sl= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl.Caso__c = oCaseColl.id;
        sl.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl.EOF_SL_Riferimento__c=slFatt.id;
        sl.EOF_Codice_Ordine_OLO__c = 'Test_9808980';
        sl.PO_Tipo_percorso__c='Singola Via';
        sl.PO_Indirizzo_collegamento__c='via test';
        sl.EOF_Comune__c='Roma';
        sl.EOF_Stato_Richiesta__c='Accettato';
        sl.PO_Offerta__c='P2P Attiva';
        sl.EOF_Codice_Operatore__c='TIS';
        sl.PO_Nome_Progetto__c= oCase.PO_Nome_Progetto__c;
        sl.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl.PO_Prime_Contractor__c='TEST';
        sl.PO_Incluso_nell_offerta__c=true;
        sl.PO_Numero_fibre_richieste__c='2';
        sl.EOF_PROFILO__c='1';
        sl.PO_Sito__c='test';
        sl.PO_Civico__c='12';
      /*  sl.OF_PP_KIT_Log__c=slkIT.id;
        sl.PO_Nota_sito__c='Nota Sito';
        sl.EOF_STATO_ORDINE__c='Accettato';
        sl.OF_SA_USER_VLAN__C='1111';
        sl.OF_SA_SERVICE_VLAN__C='sVlan';
        sl.OF_SA_PROFILO_VLAN__c='COS 0';
        sl.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sl.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';*/
   /*     
        insert sl;
        
        
        EOF_EAI_Service_Log__c sVlan1 = new EOF_EAI_Service_Log__c();
       
        sVlan1.EOF_SL_Riferimento__c=sl.id;
        sVlan1.OF_PP_KIT_Log__c=slkIT.id;
        sVlan1.PO_Nota_sito__c='Nota Sito';
        sVlan1.EOF_STATO_ORDINE__c='Accettato';
        sVlan1.OF_SA_USER_VLAN__C='1111';
        sVlan1.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan1.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan1.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan1.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan1.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        insert sVlan1;
        
        EOF_EAI_Service_Log__c slOrd= new EOF_EAI_Service_Log__c();
        slOrd.PO_Nome_Progetto__c=oCase.PO_Nome_Progetto__c;
        slOrd.EOF_Codice_Ordine_OLO__c='Test_9808980';
        slOrd.EOF_Stato_Richiesta__c='Accettato';
        slOrd.PO_Offerta__c='P2P Attiva';
        slOrd.Caso__c=oCaseOrd.id;
        slOrd.EOF_STATO_ORDINE__c='Accettato';
        slOrd.PO_Prime_Contractor__c='TEST';
        slOrd.EOF_SL_Riferimento__c=sl.id;
        slOrd.EOF_NOTE__c='Note';
        slOrd.Note_Sospensione_Operatore__c='TEST';
        slOrd.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
 
       // insert slOrd;
        SlogToInsert.add(slOrd);
        
        /**/
    /*
       Case oCase1 = new Case();
         oCase1.Status='Accettato';
         oCase1.AccountId=accOLO.id;
         oCase1.EOF_Codice_Ordine_OLO__c='Test_9808980a';
         oCase1.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase1.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase1.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase1.OwnerId=u.id;
         oCase1.RecordTypeId=mpRT.get('PO_Richiesta_a_servizio_a_fattibilit');
         oCase1.PO_Nome_Progetto__c='TEST Nome Progetto';
         oCase1.EOF_Codice_Operatore_WS__c='TIS';
        
         insert oCase1; 
        
         Case oCase1Coll = new Case();
         oCase1Coll.Status='Accettato';
         oCase1Coll.parentid=oCase1.id;
         oCase1Coll.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase1Coll.PO_Nome_E_Cognome_PM__c='TEST';                            
         oCase1Coll.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase1Coll.OwnerId=u.id;
         oCase1Coll.PO_Richiesta_a_fattibilit__c=oCase1.id;
		 oCase1Coll.PO_Tipo_percorso__c='DOPPIA VIA';
         oCase1Coll.RecordTypeId=mpRT.get('PO_Collegamento_P2P_Attiva');
         oCase1Coll.EOF_Codice_Operatore_WS__c='TIS';
         insert oCase1Coll;
        
         caseToOrder.add(oCase1Coll);
         Case oCase1Ord = new Case();
         oCase1Ord.Status='Accettato';
         oCase1Ord.ParentId=oCase1Coll.id;
         oCase1Ord.PO_Data_Attivazione_Richiesta__c=String.valueOf(System.now());
         oCase1Ord.PO_Nome_E_Cognome_PM__c='TEST';
         oCase1Ord.PO_Case_Collegamento__c=oCase1Coll.id;
         oCase1Ord.PO_Numero_Telefonico_PM__c='3546468484848468464';
         oCase1Ord.OwnerId=u.id;
         oCase1Ord.PO_Richiesta_a_fattibilit__c=oCase1.id;
         oCase1Ord.RecordTypeId=mpRT.get('PO_Ordine_P2P_Attiva');
         oCase1Ord.EOF_Codice_Operatore_WS__c='TIS';
         insert oCase1Ord;
        
        
        
        EOF_EAI_Service_Log__c slFatt1= new EOF_EAI_Service_Log__c();
        slFatt1.PO_Nome_Progetto__c=oCase1.PO_Nome_Progetto__c;
        slFatt1.EOF_Codice_Ordine_OLO__c='Test_9808980a';
        slFatt1.EOF_Stato_Richiesta__c='Accettato';
        slFatt1.PO_Offerta__c='P2P Attiva';
        slFatt1.PO_Offerta_Inoltrata__c=false; //true
        slFatt1.RecordTypeId=mpRT.get('PO_P2PAttiva_Request');
        
        
        insert slFatt1;
        EOF_EAI_Service_Log__c slkIT3= new EOF_EAI_Service_Log__c();
        slkIT3.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT3.EOF_ID_Pop__c='Pop 2';
        slkIT3.PO_P2PAttiva_Optical_Rate_Limiting__c='10 GB'; //1 GB
        slkIT3.EOF_SL_Riferimento__c=slFatt1.id;
        insert slkIT3;
        
        EOF_EAI_Service_Log__c slkIT4= new EOF_EAI_Service_Log__c();
        slkIT4.PO_P2PAttiva_KIT_Indirizzo_Consegna__c = 'via TEST KIT';
        slkIT4.EOF_ID_Pop__c='Pop 1';
        slkIT4.PO_P2PAttiva_Optical_Rate_Limiting__c='1 GB'; //10 GB
        slkIT4.EOF_SL_Riferimento__c=slFatt1.id;
        insert slkIT4;
        
        EOF_EAI_Service_Log__c sl1= new EOF_EAI_Service_Log__c(); //sl Collegamento
        sl1.Caso__c = oCase1Coll.id;
        sl1.RecordTypeId=mpRT.get('P2P_Attiva_Collegamento');
        sl1.EOF_SL_Riferimento__c=slFatt1.id;
        sl1.EOF_Codice_Ordine_OLO__c = 'Test_9808980a';
        sl1.PO_Tipo_percorso__c='Doppia Via';
        sl1.PO_Indirizzo_collegamento__c='via test';
        sl1.EOF_Comune__c='Roma';
        sl1.EOF_Stato_Richiesta__c='Accettato';
        sl1.PO_Offerta__c='P2P Attiva';
        sl1.EOF_Codice_Operatore__c='TIS';
        sl1.PO_Nome_Progetto__c= oCase1.PO_Nome_Progetto__c;
        sl1.PO_Tipo_di_collegamento__c='Point-to-Point';
        sl1.PO_Prime_Contractor__c='TEST';
        sl1.PO_Incluso_nell_offerta__c=true;
        sl1.PO_Numero_fibre_richieste__c='2+2';
        sl1.EOF_PROFILO__c='1';
        sl1.PO_Sito__c='test';
        sl1.PO_Civico__c='12';
               
        insert sl1;
        
        EOF_EAI_Service_Log__c sVlan = new EOF_EAI_Service_Log__c();
       
        sVlan.EOF_SL_Riferimento__c=sl1.id;
        sVlan.OF_PP_KIT_Log__c=slkIT4.id;
        sVlan.PO_Nota_sito__c='Nota Sito';
        sVlan.EOF_STATO_ORDINE__c='Accettato';
        sVlan.OF_SA_USER_VLAN__C='1111';
        sVlan.OF_SA_SERVICE_VLAN__C='sVlan';
        sVlan.OF_SA_PROFILO_VLAN__c='COS 0';
        sVlan.OF_SA_CUSTOMER_VLAN__c='CvLan';
        sVlan.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c='modServLan';
        sVlan.OF_SA_INFORMAZIONI_VLAN__c='Info Vlan';
        insert sVlan;
        
        EOF_EAI_Service_Log__c slOrd1= new EOF_EAI_Service_Log__c();
        slOrd1.PO_Nome_Progetto__c=oCase1.PO_Nome_Progetto__c;
        slOrd1.EOF_Codice_Ordine_OLO__c='Test_9808980a';
        slOrd1.EOF_Stato_Richiesta__c='Accettato';
        slOrd1.PO_Offerta__c='P2P Attiva';
        slOrd1.Caso__c=oCase1Ord.id;
        slOrd1.EOF_STATO_ORDINE__c='Accettato';
        slOrd1.PO_Prime_Contractor__c='TEST';
        slOrd1.EOF_SL_Riferimento__c=sl1.id;
        slOrd1.EOF_NOTE__c='Note';
        slOrd1.Note_Sospensione_Operatore__c='TEST';
        slOrd1.RecordTypeId=mpRT.get('PO_P2P_Attiva_Ordine');
        SlogToInsert.add(slOrd1);
        insert SlogToInsert;
        
        OF_CatalogoCommerciale__c cat = new OF_CatalogoCommerciale__c();
        cat.name='Catalogo test';
        cat.OF_Attivo__c=true;
        cat.OF_DataInizioValidita__c=System.today().addDays(-10);
        cat.OF_DataFineValidita__c=System.today().addDays(100);
        insert cat;
        
        OF_Servizio__c serv = new OF_Servizio__c();
        serv.OF_Attivo__c=true;
        serv.OF_DataInizioValidita__c=System.today().addDays(-10);
        serv.OF_DataFineValidita__c=System.today().addDays(100);
        serv.OF_CatalogoCommerciale__c= cat.id;
        insert serv;
        
        
         OF_CommercialElement__c ce = new OF_CommercialElement__c();
       	 ce.OF_DataFineValidita__c=System.today().addDays(100);
         ce.OF_DataInizioValidita__c=System.today().addDays(-10);
         ce.OF_Servizio__c=serv.id;
 		 insert ce;
 
         List<OF_CommercialElementIstanziato__c> VlanToBind = new List<OF_CommercialElementIstanziato__c>();
         
         OF_CommercialElementIstanziato__c Vlan = new OF_CommercialElementIstanziato__c();
         Vlan.recordtypeId= mpRT.get('SVLAN');
         Vlan.OF_KITCONSEGNAVLAN__C='TEST';
         Vlan.OF_USERVLAN__C='TEST';
         Vlan.OF_SERVICEVLAN__C='TEST';
         Vlan.OF_PROFILOVLAN__C='TEST';
         Vlan.OF_CUSTOMERVLAN__C='TEST';
         Vlan.OF_MODELLODISERVIZIOVLAN__C='TEST';
         Vlan.OF_INFORMAZIONIVLAN__C='TEST';
         Vlan.OF_Case__c= oCaseColl.id;
         Vlan.OF_SA_VLAN__c= sVlan1.id;
         Vlan.OF_CommercialElement__c=ce.id;
         
         
                                                                      
         OF_CommercialElementIstanziato__c Vlan2 = new OF_CommercialElementIstanziato__c();
         Vlan2.recordtypeId= mpRT.get('OF_VLAN');
         Vlan2.OF_KITCONSEGNAVLAN__C='TEST';
         Vlan2.OF_USERVLAN__C='TEST';
         Vlan2.OF_SERVICEVLAN__C='TEST';
         Vlan2.OF_PROFILOVLAN__C='TEST';
         Vlan2.OF_CUSTOMERVLAN__C='TEST';
         Vlan2.OF_MODELLODISERVIZIOVLAN__C='TEST';
         Vlan2.OF_INFORMAZIONIVLAN__C='TEST';
         Vlan2.OF_Case__c= oCase1Coll.id;
         Vlan2.OF_SA_VLAN__c= sVlan.id;
         Vlan2.OF_CommercialElement__c=ce.id;
                
         Opportunity opp = new Opportunity();
         opp.Name='Opp TEST';
         opp.StageName='Prospecting';
         opp.CloseDate=System.today().addDays(30);
         opp.PO_Richiesta_fattibilit__c=oCase.id;
         insert opp;
        
        Opportunity opp1 = new Opportunity();
         opp1.Name='Opp TEST';
         opp1.StageName='Prospecting';
         opp1.CloseDate=System.today().addDays(30);
         opp1.PO_Richiesta_fattibilit__c=oCase1.id;
         insert opp1;
         //insert slOrd1;
        /**/
    /*
        List<order> ordList = new List<Order>();
        order o = new order();
        o.recordtypeID = mpRT.get('OF_INORDER');
        o.EffectiveDate = Date.newInstance(2016,1,1);
        o.Status = 'Aperto';
        o.AccountId = accOLO.id;//acc.id;
        o.OF_TipologiaDiServizio__c='Attivo';
        o.PO_IsFromOpportunity__c=true;
        o.Name ='test1';
        o.OF_CaseNome__c=oCase.CaseNumber;
        o.OF_IDOrdineEOF__c=oCase.Codice_Ordine_EOF__c;
       // o.OF_CaseNome__c=oCase.id;
       // o.OF_CaseNome__c = caseFormula.get(o.OF_CaseID__c).casenumber;
       //o.OF_IDOrdineEOF__c = caseFormula.get(o.OF_CaseID__c).Codice_Ordine_EOF__c;
        insert o;
        ordList.add(o);
        
        order o2 = new order();
        o2.recordtypeID = mpRT.get('OF_INORDER');
        o2.EffectiveDate = Date.newInstance(2016,1,1);
        o2.Status = 'Aperto';
        o2.AccountId = accOLO.id;//acc.id;
        o2.OF_TipologiaDiServizio__c='Passivo';
        o2.PO_IsFromOpportunity__c=true;
        o2.Name ='test2';
        o2.OF_CaseNome__c=oCase1.id;
        insert o2;
        ordList.add(o2);
    	createAttachment(oCaseColl.id,u.id);
    }
    
     public static Attachment createAttachment(Id ParentId,Id UserId)
    {	Blob b = Blob.valueOf('Test Data');
        Attachment attach = new Attachment( Body = b, 
            							  ContentType = 'application/pdf',	
                                          Name = 'Sample Attachment',
                                          OwnerId = UserId,
                                          ParentId = ParentId
            										
        											);
        return attach;
    }
*/
}