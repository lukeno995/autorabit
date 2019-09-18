@isTest
public class OF_CV_Clona_Regola_Ctrl_Test {
    @testSetup
    public static void testSetUpData() {
        account acc = new account();
        acc.EOF_Codice_Operatore__c= 'VF';
        acc.name = 'test';        
        insert acc; 
        
        OLO_ID__c olo = new OLO_ID__c();
        olo.name = 'VF';
        olo.OF_Olo_Id__c = acc.Id;
        insert olo;         
    }
    
    static testmethod void testMethod1(){
        Test.startTest();
        List<OF_CV_Regole_Vendita__c> lst = new List<OF_CV_Regole_Vendita__c>();
        for(Integer i = 0; i < 5; i++){
            OF_CV_Regole_Vendita__c tmp = new OF_CV_Regole_Vendita__c(Id_Regola__c='Regola'+i, Codice_OLO__c='VF', isAttiva__c=true, Servizio__c='ATTIVO', Riga__c = i);
            lst.add(tmp);
        }
        insert lst;
        Test.setCurrentPage(Page.OF_CV_Clona_Regola);
        ApexPages.currentPage().getParameters().put('ruleName','Regola1');
        ApexPages.currentPage().getParameters().put('oldOlo','VF');
        ApexPages.currentPage().getParameters().put('oldServ','ATTIVO');
        
        OF_CV_Clona_Regola_Ctrl tmp = new OF_CV_Clona_Regola_Ctrl();
        tmp.operatore = 'WND';
        tmp.servizio = 'PASSIVO';
        tmp.getOptOperatori();
        tmp.getOptServizi();
        tmp.clonaRegola();
        tmp.annulla();
        tmp.servizio = '';
        tmp.clonaRegola();
        
        Test.stopTest();
    }
}