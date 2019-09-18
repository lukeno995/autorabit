@isTest
public class PO_P2PAttiva_InsertIdRisorsaCtrlTEST {
    
    static testmethod void Method1(){
        
      PO_P2PAttiva_InserimentoIdRisorsa_Ctrl pp = new PO_P2PAttiva_InserimentoIdRisorsa_Ctrl();
    } 
    
    static testmethod void Method2(){
        
        String AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc = new Account();
        acc.FirstName = 'Test';
        acc.LastName = 'Account';
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
        insert contratto;
        
        Asset asset_1 = new Asset();
        asset_1.Name = 'IDR1234';
        asset_1.Status = 'Attivo';
        asset_1.EOF_ID_Risorsa__c = 'IDR1234';
        //asset_1.recordTypeId = assetRecordTypeId;
        asset_1.accountId = acc.id;
        asset_1.OF_Contract__c = contratto.Id;
        insert asset_1;
        
        
      ApexPages.currentPage().getParameters().put('valid',asset_1.Id);
      PO_P2PAttiva_InserimentoIdRisorsa_Ctrl pp = new PO_P2PAttiva_InserimentoIdRisorsa_Ctrl();
    } 
    
    static testmethod void Method3(){
        
      Test.startTest();
      PO_P2PAttiva_InserimentoIdRisorsa_Ctrl pp = new PO_P2PAttiva_InserimentoIdRisorsa_Ctrl();
      pp.routeRequest();
      Test.stopTest();
        
    } 

}