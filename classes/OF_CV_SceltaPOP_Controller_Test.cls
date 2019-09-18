@isTest
public class OF_CV_SceltaPOP_Controller_Test {
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
        
        Pop__c pop1 = new Pop__c();
        pop1.Name = 'POP03';
        insert pop1;
        
        List<OF_CV_Regole_Vendita__c> lst = new List<OF_CV_Regole_Vendita__c>();
        for(Integer i = 0; i < 5; i++){
            OF_CV_Regole_Vendita__c tmp = new OF_CV_Regole_Vendita__c(Id_Regola__c='Regola'+i, Pop__c='POP01', Id_Building_BL__c = '123', Id_Scala_BL__c = '321', Codice_strada_BL__c = '321', Stato__c = '103', Comune__c='ROMA' , Codice_OLO__c='VF', isAttiva__c=true, Servizio__c='ATTIVO', Riga__c = i);
            lst.add(tmp);
        }
        insert lst;
        
        OF_ElencoComuniItaliani__c com = new OF_ElencoComuniItaliani__c();
        com.OF_Comune__c = 'ROMA';
        com.OF_Provincia__c = 'ROMA';
        com.OF_Regione__c = 'LAZIO';
        com.OF_CodiceIstat__c = '1234';
        insert com;
    }
    
    private static testmethod void testMethod1()
    {
        OF_Puntamento_Callout__c puntamento = new OF_Puntamento_Callout__c();
        puntamento.Name='OGW';
        puntamento.OF_OGW__c='OFS-SVIL-WS';
        insert puntamento;
        
        Test.setCurrentPage(Page.OF_CV_SceltaPOP);
        ApexPages.currentPage().getParameters().put('id_regola','Regola1');
        ApexPages.currentPage().getParameters().put('olo','VF');
        ApexPages.currentPage().getParameters().put('servizio_selected','ATTIVO');
        ApexPages.currentPage().getParameters().put('stato','102');
        
        test.startTest();
        
        Test.setMock(WebServiceMock.class, new OF_CV_WS_Mockupcls());	
        
        OF_CV_SceltaPOP_Controller tmp = new OF_CV_SceltaPOP_Controller();
        tmp.getStati();
        tmp.sceltaStatoRegola();
        tmp.selectedPop = new List<String>();
        for(Integer i = 5; i<7; i++){
            String Name = 'POP'+i;
            tmp.selectedPop.add(Name);
        }
        tmp.popDisponibiliList.add('POP5');
        tmp.addPop();
        tmp.removedPop.add('POP5');
        tmp.removePop();
        tmp.getPopDisponibili();
        tmp.getPopSelezionati();
        tmp.selectedComuni.add('POP02/111');
        tmp.selectedComuni.add('POP03/222');
        tmp.addComuni();
        tmp.removedComuni.add('POP03/222');
        tmp.removeComuni();
        tmp.mapIstatComune.put('231', 'Napoli');
        tmp.mapIstatComune.put('222', 'Milano');
        tmp.comuniDisponibiliList = new List<String>();
        tmp.comuniDisponibiliList.add('POP01/231');
        tmp.getComuniDisponibili();
        tmp.getComuniSelezionati();
        tmp.sceltaComune();
        tmp.sceltaBlacklist(); 
        tmp.annulla();
        tmp.tornaIndietro_POP();
        tmp.tornaIndietro_Comune();
        tmp.pop_comune_manual = 'POP009/MANUALE';
        tmp.addManualPopComune();
        tmp.regolaCompletata();
        tmp.comuniSelezionatiList.clear();
        tmp.regolaCompletata();
        tmp.id_regola = '';
        tmp.regolaCompletata();
        tmp.comuniSelezionatiList.add('POP3/123');
        tmp.regolaCompletata();
        
        test.stopTest();
    }
}