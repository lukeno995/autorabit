@isTest
private class PO_ImportaCollegamentiMassivo_TEST {
    public static testMethod void testMethod1(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //Test fiberlink < 50 OK TUTTI I CAMPI
            List<String> filelines = new List<String>();
            filelines.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Indirizzo1,Civico1,Nota Sito1, Comune2, Sito2, Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Indirizzo3,Civico3,Nota Sito3\n');
            filelines.add('Vodafone,BTS,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI,9,45.0704181532206 - 7.67610544977457,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI,9,45.0704181532206 - 7.67610544977457\n');            
            
            String finalString = '';
            for(String x : filelines){
                finalString = finalString + x;
            }
            Blob b = Blob.valueOf(finalString);      
            String esito = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(b, acc.Id, parentCase1, 'fiberlink');
            //FINE Test fiberlink < 50 OK TUTTI I CAMPI
            //Test fiberlink < 50 KO TUTTI I CAMPI VUOTI e tutti i valori errati
            List<String> filelines2 = new List<String>();
            filelines2.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Indirizzo1,Civico1,Nota Sito1, Comune2, Sito2, Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Indirizzo3,Civico3,Nota Sito3\n');
            filelines2.add(' , , , , , , , , , , , , , , , , , , , , , , , , , , , ,\n');
            String finalString2 = '';
            for(String x : filelines2){
                finalString2 = finalString2 + x;
            }
            Blob b2 = Blob.valueOf(finalString2);      
            String esito2 = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(b2, acc.Id, parentCase1, 'temporaneo');
            List<String> filelines3 = new List<String>();
            filelines3.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Indirizzo1,Civico1,Nota Sito1, Comune2, Sito2, Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Indirizzo3,Civico3,Nota Sito3\n');
            filelines3.add('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n');
            String finalString3 = '';
            for(String x : filelines3){
                finalString3 = finalString3 + x;
            }
            Blob b3 = Blob.valueOf(finalString3);      
            String esito3 = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(b3, acc.Id, parentCase1, 'fiberlink');
            String esito4 = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(null, '', null, '');
            //FINE Test fiberlink < 50 OK TUTTI I CAMPI
            //Test FIBERLEASE & IRU < 50 OK TUTTI I CAMPI
            List<String> filelines8 = new List<String>();
            filelines8.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            filelines8.add('Vodafone,SDH,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');           
            
            String finalString8 = '';
            for(String x : filelines8){
                finalString8 = finalString8 + x;
            }
            Blob b8 = Blob.valueOf(finalString8);      
            String esito8 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b8, acc.Id, parentCase1, 'fiberlease');
            //IRU 
            List<String> filelines9 = new List<String>();
            filelines9.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            filelines9.add('Vodafone,Dark Fiber,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');
            filelines9.add(' , , , , , , , , , , , , , ,,,,,,\n'); 
            filelines9.add('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,,,,,,\n');
            String finalString9 = '';
            for(String x : filelines9){
                finalString9 = finalString9 + x;
            }
            Blob b9 = Blob.valueOf(finalString9);      
            String esito9 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b9, acc.Id, parentCase1, 'iru');
            //FIBERLEASE ERRORE
            List<String> filelines10 = new List<String>();
            filelines10.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            filelines10.add(' , , , , , , , , , , , , , ,,,,,,\n'); 
            filelines10.add('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,,,,,,\n');
            
            String finalString10 = '';
            for(String x : filelines10){
                finalString10 = finalString10 + x;
            }
            Blob b10 = Blob.valueOf(finalString10);      
            String esito10 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b10, acc.Id, parentCase1, 'fiberlease');
            String esitoNULL = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(null, '', null, '');
            
            //Fine test fiberlease
        }
        Test.stopTest();
    }
    public static testMethod void testMethod2(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST P2PBASE!!
            List<String> filelines11 = new List<String>();
            filelines11.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune1, Sito1,Indirizzo1,Civico1,Nota Sito1,\n');
            filelines11.add('Vodafone,Point-to-Point,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,\n');
            
            String finalString11 = '';
            for(String x : filelines11){
                finalString11 = finalString11 + x;
            }
            Blob b11 = Blob.valueOf(finalString11);      
            String esito11 = PO_ImportaCollegamentiMassivo.ReadP2PBase(b11, acc.Id, parentCase1, 'p2pbase');
            //p2pbase errore
            List<String> filelines12 = new List<String>();
            filelines12.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune1, Sito1,Indirizzo1,Civico1,Nota Sito1,\n');
            filelines12.add(' , , , , , , , , , , , , , ,,,,,,\n'); 
            filelines12.add('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,,,,,,\n');            
            
            String finalString12 = '';
            for(String x : filelines12){
                finalString12 = finalString12 + x;
            }
            Blob b12 = Blob.valueOf(finalString12);      
            String esito12 = PO_ImportaCollegamentiMassivo.ReadP2PBase(b12, acc.Id, parentCase1, 'p2pbase');
            String esitoNULL2 = PO_ImportaCollegamentiMassivo.ReadP2PBase(null, '', null, '');
            //FINE TEST P2PBASE
        }
        Test.stopTest();
    }
    //BATCH OK FIBERLINK
    public static testMethod void testMethodBATCHFiberLink(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Indirizzo1,Civico1,Nota Sito1, Comune2, Sito2, Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Indirizzo3,Civico3,Nota Sito3\n');
            for(Integer i=0; i<60; i++){
                fileLinesBatchOk.add('Vodafone,BTS,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI,9,45.0704181532206 - 7.67610544977457,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI,9,45.0704181532206 - 7.67610544977457\n');
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito5 = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(b5, acc.Id, parentCase1, 'fiberlink');
            String esito6 = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(b5, acc.Id, parentCase1, 'temporaneo');            
        }
        Test.stopTest();
    }
    //BATCH OK IRU
    public static testMethod void testMethodBATCHIRU(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add('Vodafone,Dark Fiber,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito5 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b5, acc.Id, parentCase1, 'iru');
        }
        Test.stopTest();
    }
    //BATCH OK FIBERLEASE
    public static testMethod void testMethodBATCHFiberLease(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add('Vodafone,SDH,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');           
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito8 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b5, acc.Id, parentCase1, 'fiberlease');
        }
        Test.stopTest();
    }
    //BATCH OK P2P BASE
    public static testMethod void testMethodBATCHP2PBase(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune1, Sito1,Indirizzo1,Civico1,Nota Sito1,\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add('Vodafone,Point-to-Point,2,Singola Via,Torino,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,\n');
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito12 = PO_ImportaCollegamentiMassivo.ReadP2PBase(b5, acc.Id, parentCase1, 'p2pbase');
        }
        Test.stopTest();
    }  
    //ERROR BATCH FIBER LEASE!
    public static testMethod void testMethodBATCHError(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add('Vodafone,sd,2,Singola,sd,1OF40814 - TORINO POP OPITEL,VIA COLOMBO  ,24,45.05711 - 7.66285,Torino,1OF60225 - TORINO CENTRO TI,VIA MERCANTINI  ,9,45.0704181532206 - 7.67610544977457,,,,,,\n');           
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito8 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b5, acc.Id, parentCase1, 'fiberlease');
        }
        Test.stopTest();
    }
    //ERROR BATCH P2P Base!
    public static testMethod void testMethodBATCHErrorp2pbase(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune1, Sito1,Indirizzo1,Civico1,Nota Sito1,\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add(' , , , ,  ,  , , , ,\n');
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito8 = PO_ImportaCollegamentiMassivo.ReadP2PBase(b5, acc.Id, parentCase1, 'p2pbase');
        }
        Test.stopTest();
    }
    //ERROR BATCH IRU!
    public static testMethod void testMethodBATCHErrorIRU(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso, Comune Destinazione, Sito Destinazione,Indirizzo Destinazione,Civico,Nota Destinazione,Comune Partenza, Sito Partenza,Indirizzo Partenza,Civico Partenza,Nota Sito Partenza,,,,,,\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add(' , , , , , , , , , , , , , , , , ,,\n');           
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito8 = PO_ImportaCollegamentiMassivo.ReadFileFiberLease(b5, acc.Id, parentCase1, 'iru');
        }
        Test.stopTest();
    }
    //ERROR BATCH FIBERLINK!
    public static testMethod void testMethodBATCHErrorFIBERLINK(){
        Profile prfl = [SELECT Id FROM Profile WHERE Name='PO System Administrator'];
        UserRole Ur = [Select ID FROM UserRole where Name = 'PO Supporto Vendite'];
        User thisUser = new User(Alias = 'standt1', Email='unitTestMail11@atos.net', 
                                 EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = prfl.Id,UserRoleID=Ur.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='testmail11@po.net',isactive=true);
        insert thisUser ;
        
        Test.startTest();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.case; 
        Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId7 = CaseRecordTypeInfo.get('PO Richiesta a servizio a fattibilità').getRecordTypeId();
        
        Schema.DescribeSObjectResult accSchema = Schema.SObjectType.account; 
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = accSchema.getRecordTypeInfosByName(); 
        Id rId8 = AccRecordTypeInfo.get('Cliente Business').getRecordTypeId();
        
        System.runAs (thisUser){ 
            Parametri_Fattibilita__c paramFat = new Parametri_Fattibilita__c();
            paramFat.Name='Default';
            paramFat.Fascia1__c = 1;
            insert paramFat; 
            
            account acc = new account();
            acc.RecordTypeId = rId8 ;
            acc.name = 'test';        
            insert acc;
            
            case parentCase1 = new Case();
            parentCase1.accountId = acc.Id;
            parentCase1.OwnerID = userinfo.getUserId();
            parentCase1.Status = 'Acquisito';
            parentCase1.EOF_Fase__c = 'In Verifica BO';
            parentCase1.RecordTypeId = rtId7;
            parentCase1.PO_Offerta__c = 'Fiber Link';
            parentCase1.PO_Nome_Progetto__c = 'test';
            insert parentCase1;
            
            OF_ElencoComuniItaliani__c comune1 = new OF_ElencoComuniItaliani__c (OF_CodiceIstat__c= 'TestID' ,OF_Comune__c = 'Torino', OF_Ripartizionegeografica__c = 'Centro');
            insert comune1;
            
            //TEST BATCH!!! 
            //List<String> filelines9 = new List<String>();
            List<String> fileLinesBatchOk = new List<String>();
            fileLinesBatchOk.add('Prime Contractor,Tipo di collegamento,Numero fibre richieste,Tipo percorso,Comune1,Sito1,Indirizzo1,Civico1,Nota Sito1, Comune2, Sito2, Indirizzo2,Civico2,Nota Sito2,Comune3,Sito3,Indirizzo3,Civico3,Nota Sito3\n');
            for(Integer i=0; i<52; i++){
                fileLinesBatchOk.add(' , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,\n');
            }
            //FINE TEST BATCH
            String finalStringBatchOk = '';
            for(String x : fileLinesBatchOk){
                finalStringBatchOk = finalStringBatchOk + x;
            }
            Blob b5 = Blob.valueOf(finalStringBatchOk);
            String esito5 = PO_ImportaCollegamentiMassivo.ReadFileFiberLink(b5, acc.Id, parentCase1, 'fiberlink');
        }
        Test.stopTest();
    }
}