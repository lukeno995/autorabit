@isTest
public class OF_NotifyKOTEST {
    
    //inserimento di Account, order e case collegati tra loro. Ritorna il case da legare alla notifica
    public static case InsertDati()
    {
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        account OLO = new account(
            Name = 'Wind',
            EOF_Codice_Operatore__c = 'WN',
            Type = 'OLO',
            Industry = 'Telecommunications',
            RecordTYpeId = oloAccountRecordTypeId
        );
        insert OLO;
        
        order ord = new order(
            AccountId = OLO.id,
            status = 'aperto',
            EffectiveDate = system.today(),
        	OF_CodiceKO__c = 'B0',
            OF_DescrizioneKO__c = 'test',
            OF_IDSplitterSecondario__c = 'Test', 
            OF_PosizioneSplitterSecondario__c = 'Test'
        );
        insert ord;
        
        case cas = new case(
            OF_Order__c = ord.id
        );
        insert cas;
		return cas;
    }
    
    //Cessazione KO
    public static testmethod void Metodo1()
    {
        case cas = InsertDati();
                
        string RTNotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di cessazione KO').getRecordTypeId(); 
        EOF_Notify__c no = new EOF_Notify__c(
        	caso__c = cas.id,
            RecordtypeId = RTNotify,
            EOF_Stato_Richiesta__c = 'KO'
        );
        insert no;
    }
    
    //Acquisizione KO
    public static testmethod void Metodo2()
    {
        case cas = InsertDati();
                
        string RTNotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di acquisizione KO').getRecordTypeId(); 
        EOF_Notify__c no = new EOF_Notify__c(
        	caso__c = cas.id,
            RecordtypeId = RTNotify,
            EOF_Stato_Richiesta__c = 'KO'
        );
        insert no;
    }
    
    //Espletamento
    public static testmethod void Metodo3()
    {
        case cas = InsertDati();
                
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        string RTNotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId(); 
        EOF_Notify__c no = new EOF_Notify__c(
        	caso__c = cas.id,
            RecordtypeId = RTNotify,
            EOF_Data_Notifica__c = system.now()
        );
        insert no;
        
        EOF_Notify__c no1 = new EOF_Notify__c(
        	caso__c = cas.id,
            RecordtypeId = RTNotify,
            EOF_Data_Notifica__c = system.now(),
            EOF_ID_Risorsa__c = 'test'
        );
        insert no1;
        
        no.EOF_ID_Risorsa__c = 'test1';
        update no;
    }
    
    //Espletamento in errore
    public static testmethod void Metodo4()
    {
        case cas = InsertDati();
                
        Test.setMock(WebServiceMock.class, new NotifyServiceMockupcls());
        
        string RTNotify = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('Notifica di espletamento').getRecordTypeId(); 
        EOF_Notify__c no = new EOF_Notify__c(
        	caso__c = cas.id,
            RecordtypeId = RTNotify,
            EOF_Data_Notifica__c = system.now()
        );
        insert no;
        
        account acc = [select id from account where type = 'OLO' limit 1];
        
        string RTAsset = Schema.SObjectType.Asset.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
        asset ass = new asset(
            RecordtypeId = RTAsset,
            Status = 'Attivo',
            EOF_ID_Risorsa__c = 'test',
            name = 'test',
            AccountID = acc.id
        );
        insert ass;
        
        try{
        	no.EOF_ID_Risorsa__c = 'test';
        	update no;
        }catch(Exception ex)
        {
            String err2 = 'Esiste già un Asset a sistema con questo ID Risorsa:: ';
            boolean expectedExceptionThrown = ex.getMessage().contains(err2) ? true : false;
        }
    }
}