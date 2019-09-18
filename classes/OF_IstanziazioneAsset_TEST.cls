@isTest
public class OF_IstanziazioneAsset_TEST {
    
  /*  public static testMethod void CoverCode(){
    	Test.startTest();
    	OF_IstanziazioneAsset.coverCode();
    	Test.stopTest();
    }*/
    
    public static testmethod void test1(){
        
        TestDataFactory.CreateTestRecords(null,null,null);
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype where sobjecttype = 'Asset'] )
        {
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
        contract ccc = new contract();
        ccc.name='test';
        ccc.AccountId=TestDataFactory.acc.id;
        
        insert ccc;
        
        order ooo= new order();
        ooo.name='test';
        ooo.AccountId= TestDataFactory.accOLO.id;
        ooo.effectiveDate=system.today();
        ooo.status='Chiuso';
        insert ooo;
        List<order> orderList = new List<order>();
        orderList.add(ooo);
        
        case  cas = new case();
        cas.EOF_Account_OLO__c = TestDataFactory.accOLO.id;
        cas.Subject = 'Richiesta di attivazione';
        cas.EOF_Codice_Ordine_OLO__c = '02112016_37';
        cas.EOF_Data_Prevista_Attivazione__c = system.today();
        cas.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        cas.Status = 'Acquisito';
        cas.EOF_Fase__c = 'In Verifica BO';
        cas.Type = '1';
        cas.EOF_Tipologia_Servizio__c = 'test';
        cas.EOF_Codice_Operatore_WS__c = 'VF';
        cas.EOF_SLA_Premium_Assurance__c ='Y';
        cas.Account = TestDataFactory.acc;
        cas.EOF_Identificativo_del_POP__c = 'PG_01';
        cas.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        cas.EOF_Numero_Civico_WS__c = '7';
        cas.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        cas.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        cas.EOF_Recapito_Test_Linea__c = '111';
        cas.EOF_Tipologia_Apparato__c = 'test';
        cas.OwnerId = userInfo.getUserId();
        cas.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
        cas.EOF_Id_Notifica__c = 'test_01';
        cas.Origin = 'Web';
        cas.Priority = 'Medium';
        cas.EOF_GPON_Vincolante__c = 'Y';
        
        insert cas;
        
        test.startTest();
        
    
        OF_IstanziazioneAsset oia = new OF_IstanziazioneAsset();
        
        OF_IstanziazioneAsset.PO_AssetFields TTT = new OF_IstanziazioneAsset.PO_AssetFields(system.now(),'no',15,'no',true);
        
        OF_IstanziazioneAsset.CreazioneAssetFromProcess(orderList,
                                                        mpRT.get('OF_GPONPassiva'),
                                                        mpRT.get('OF_OpenStream'),
                                                        mpRT.get('Risorsa'),
                                                        mpRT.get('Fiber_Link'),
                                                        mpRT.get('Fiber_Lease'));
                                                        
        
        test.stopTest();
        
    }
    public static testmethod void test2(){
        
        TestDataFactory.CreateTestRecords(null,null,null);
        
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype where sobjecttype = 'Asset'] )
        {
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        
        contract ccc = new contract();
        ccc.name='test';
        ccc.AccountId=TestDataFactory.acc.id;
        
        insert ccc;
        
        order ooo= new order();
        ooo.name='test';
        ooo.AccountId= TestDataFactory.accOLO.id;
        ooo.effectiveDate=system.today();
        ooo.status='Chiuso';
        ooo.PO_IsFromOpportunity__c=true;
        insert ooo;
        List<order> orderList = new List<order>();
        orderList.add(ooo);
        
        case  cas = new case();
        cas.EOF_Account_OLO__c = TestDataFactory.accOLO.id;
        cas.Subject = 'Richiesta di attivazione';
        cas.EOF_Codice_Ordine_OLO__c = '02112016_37';
        cas.EOF_Data_Prevista_Attivazione__c = system.today();
        cas.EOF_Orario_Appuntamento__c = DateTime.now().getTime()+'';
        cas.Status = 'Acquisito';
        cas.EOF_Fase__c = 'In Verifica BO';
        cas.Type = '1';
        cas.EOF_Tipologia_Servizio__c = 'test';
        cas.EOF_Codice_Operatore_WS__c = 'VF';
        cas.EOF_SLA_Premium_Assurance__c ='Y';
        cas.Account = TestDataFactory.acc;
        cas.EOF_Identificativo_del_POP__c = 'PG_01';
        cas.EOF_ID_Building_WS__c = '10_054_054039_8000064301_40';
        cas.EOF_Numero_Civico_WS__c = '7';
        cas.EOF_Telefono_Referente_OLO_Onfield_Notec__c = '0123456789';
        cas.EOF_Numero_Telefonico_Principale_Linea__c = '111';
        cas.EOF_Recapito_Test_Linea__c = '111';
        cas.EOF_Tipologia_Apparato__c = 'test';
        cas.OwnerId = userInfo.getUserId();
        cas.RecordTypeId = OF_SA_GE_Utils.rtMap.get('EOF_Caso_Attivazione') ;
        cas.EOF_Id_Notifica__c = 'test_01';
        cas.Origin = 'Web';
        cas.Priority = 'Medium';
        cas.EOF_GPON_Vincolante__c = 'Y';
        
        insert cas;
        
        test.startTest();
        
    
        OF_IstanziazioneAsset oia = new OF_IstanziazioneAsset();
        
        OF_IstanziazioneAsset.PO_AssetFields TTT = new OF_IstanziazioneAsset.PO_AssetFields(system.now(),'no',15,'no',true);
        
        OF_IstanziazioneAsset.CreazioneAssetFromProcess(orderList,
                                                        mpRT.get('OF_GPONPassiva'),
                                                        mpRT.get('OF_OpenStream'),
                                                        mpRT.get('Risorsa'),
                                                        mpRT.get('Fiber_Link'),
                                                        mpRT.get('Fiber_Lease'));
        test.stopTest();
        
    }
}