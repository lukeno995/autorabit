@isTest
public class OF_CV_Home_Controller_Test {
    
    static testMethod void testMethod1(){
        List<OF_CV_Regole_Vendita__c> lst = new List<OF_CV_Regole_Vendita__c>();
        for(Integer i = 0; i < 5; i++){
            OF_CV_Regole_Vendita__c tmp = new OF_CV_Regole_Vendita__c(Id_Regola__c='Regola'+i, Codice_OLO__c='VF', isAttiva__c=true, Servizio__c='ATTIVO');
            lst.add(tmp);
        }
        insert lst;
        OF_CV_Home_Controller tmp = new OF_CV_Home_Controller();
        tmp.operatore_selected = 'VF';
        tmp.stato_selected = 'ATTIVO';
        tmp.visualizzaRegole();
        tmp.creaNuovaRegola();
        tmp.valorizzaDati();
    }
    
    static testMethod void testMethod2(){
        OF_CV_Home_Controller tmp = new OF_CV_Home_Controller();
        tmp.visualizzaRegole();
    }
    
    static testMethod void test_estraiVendibilita(){
        
        Test.setCurrentPage(Page.OF_CV_Home);
        ApexPages.currentPage().getParameters().put('olo','VF');
        ApexPages.currentPage().getParameters().put('servizio','ATTIVO');

        Test.startTest();
        OF_CV_Home_Controller contr = new OF_CV_Home_Controller();
        PageReference p = contr.estraiVendibilita();
        Test.stopTest();
    }
}