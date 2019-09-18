@isTest
    public class OF_SyncCaseInviato_step2_Sched_Test {
    
        public static testMethod void test1()
         {
             
             SchedulableContext SC;
             
             OF_SyncCaseInviato_step2_Sched SBA1= new OF_SyncCaseInviato_step2_Sched();
              
             SBA1.execute(SC);
             
             
              String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
                Account acc = new Account();
                acc.Lastname = 'TestAccount';
                acc.Phone = '0000';
                acc.EOF_Phone_2__c = '0000';
                acc.EOF_Provincia__c = 'Milano';
                acc.EOF_Comune__c = 'Milano';
                acc.EOF_Indirizzo__c = 'Piazzale Gorini';
                acc.RecordTYpeId = AccountRecordTypeId;
                acc.EOF_Particella_Toponomastica__c = '123';
                acc.EOF_Numero_Civico__c = '7';
                acc.AccountNumber='123456';
                insert acc;
                
                Account acc1=[select id,AccountNumber,Lastname,Phone,EOF_Phone_2__c from Account];
                
                Contract contratto = new Contract();
                contratto.OF_IdContratto__c = 'TEST_TIS_001';
                contratto.AccountId = acc.id;
                //contratto.BillingFrequency__c='Monthly';
                //contratto.ContractNumber='test';
                insert contratto;
                        
                String assetRecordTypeId = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
                Asset asset_1 = new Asset();
                asset_1.Name = 'IDR1234';
                asset_1.Status = '';
                asset_1.EOF_ID_Risorsa__c = 'IDR1234';
                asset_1.recordTypeId = assetRecordTypeId;
                asset_1.accountId = acc1.id;
                //OF_DataAttivazione2__c
                asset_1.OF_DataAttivazione2__c=datetime.now();
                
                asset_1.OF_Contract__c = contratto.id;
                insert asset_1;
                                
                String CaseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
                list<case> vlstcase =  new list<case>();
                Case c = new Case();
                //c.EOF_Account_OLO__c = accOLO.Id;
                c.Subject = 'Richiesta Attivazione';
                c.EOF_Codice_Ordine_OLO__c = '02112016_37';
                c.EOF_Data_Prevista_Attivazione__c = system.today();
                c.EOF_Orario_Appuntamento__c = DateTime.now().getTime() + '';
                c.Status = 'Espletato';
                c.EOF_Fase__c = 'Espletato OK';
                c.Type = '1';
                c.EOF_Tipologia_Servizio__c = 'test1';
                c.EOF_Codice_Operatore_WS__c = 'VF';
                c.EOF_SLA_Premium_Assurance__c ='Y';
                c.Account = acc1;
                c.AssetId = asset_1.id;
                c.OwnerId = userInfo.getUserId();
                c.RecordTypeId = CaseRecordTypeId;
                c.EOF_Id_Notifica__c = 'test_01';
                c.Origin = 'Web';
                c.Priority = 'Medium';
                c.EOF_GPON_Vincolante__c = 'Y';
                c.OLO_ORDER_CODE__c='test';
                
                insert c;
             
              Case cac=[select id from Case];
             try{
             String logRecordTypeId2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId();
             EOF_EAI_Service_Log__c log3=new EOF_EAI_Service_Log__c ();
             log3.RecordTYpeId=logRecordTypeId2;
             log3.OF_SA_Metodo__c='OLO_ActivationSetup_OpenStream';
             log3.Caso__c=cac.id;
             insert log3;
             OF_SyncCaseInviato_step2_Sched SBA3= new OF_SyncCaseInviato_step2_Sched();
             }catch(exception e){
               system.debug('e'+e);
             }
             try{
             String logRecordTypeId2 = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('OF - SA - FiberRequest').getRecordTypeId(); 
             EOF_EAI_Service_Log__c log4=new EOF_EAI_Service_Log__c ();
             log4.RecordTYpeId=logRecordTypeId2;
             log4.OF_SA_Metodo__c='OLO_DeactivationOrder';
             log4.Caso__c=cac.id;
             insert log4;
             OF_SyncCaseInviato_step2_Sched SBA4= new OF_SyncCaseInviato_step2_Sched();
             }catch(exception e){
               system.debug('e'+e);
             }
             
             try{
             String logRecordTypeId = Schema.SObjectType.EOF_EAI_Service_Log__c.getRecordTypeInfosByName().get('FiberRequest').getRecordTypeId();
             EOF_EAI_Service_Log__c log5=new EOF_EAI_Service_Log__c ();
             log5.RecordTYpeId=logRecordTypeId;
             log5.Caso__c=cac.id;
             insert log5;
             OF_SyncCaseInviato_step2_Sched SBA5= new OF_SyncCaseInviato_step2_Sched();
             }catch(exception e){
               system.debug('e'+e);
             }
           
            
         }    
    
         
             
    }