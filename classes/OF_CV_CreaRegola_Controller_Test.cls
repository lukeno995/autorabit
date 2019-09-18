@isTest
public class OF_CV_CreaRegola_Controller_Test {
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
    //OLO_ID__c
    static testMethod void testMethod1(){
        OF_CV_CreaRegola_Controller tmp = new OF_CV_CreaRegola_Controller();
        tmp.servizi = new List<Case>();
        tmp.getOptOperatori();
        tmp.getOptServizi();
        tmp.getStati();
        tmp.sceltaPop();
        tmp.annulla();
    }
}