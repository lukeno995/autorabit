@isTest
public class OF_CV_ElencoRegole_Controller_Test {
    static testMethod void testMethod1(){
        Test.startTest();
        List<OF_CV_Regole_Vendita__c> lst = new List<OF_CV_Regole_Vendita__c>();
        for(Integer i = 0; i < 5; i++){
            OF_CV_Regole_Vendita__c tmp = new OF_CV_Regole_Vendita__c(Id_Regola__c='Regola'+i, Codice_OLO__c='VF', isAttiva__c=true, Servizio__c='ATTIVO', Riga__c = i);
            lst.add(tmp);
        }
        insert lst;
        Test.setCurrentPage(Page.OF_CV_ElencoRegole);
        ApexPages.currentPage().getParameters().put('olo','VF');
        ApexPages.currentPage().getParameters().put('servizio','ATTIVO');
        
        OF_CV_ElencoRegole_Controller tmp = new OF_CV_ElencoRegole_Controller();
        tmp.olo = 'VF';
        tmp.servizio = 'ATTIVO';
        tmp.creaRegola();
        tmp.clonaRegola();
        tmp.annulla();
        tmp.modificaRegola();
        tmp.valorizzaDati();
        tmp.confermaScelta();
        tmp.lstRegole.get(0).isAttiva__c = false;
        tmp.confermaScelta();
        Test.stopTest();
    }
}