@isTest
    public class OF_SyncCaseInviato_step1_Sched_Test {
    
        public static testMethod void test1()
         {
             DateTime dt = System.now().addSeconds(15);
             String nextFireTime = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
             System.schedule('SYNC_STEP2', nextFireTime, new OF_SyncCaseInviato_step2_Sched());
             
             SchedulableContext SC;
             
             OF_SyncCaseInviato_step1_Sched SBA1= new OF_SyncCaseInviato_step1_Sched();
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
       
        
             OF_SyncCaseInviato_step1_Sched SBA2= new OF_SyncCaseInviato_step1_Sched();   
            
                       
         }
        
        
    }