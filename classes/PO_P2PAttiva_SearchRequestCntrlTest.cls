@isTest
public class PO_P2PAttiva_SearchRequestCntrlTest {
    static testMethod void testMethod1(){
        //Inizia lo scope del test
        Test.startTest();
        //Setto la vfp
        Test.setCurrentPage(Page.PO_P2PAttiva_OverviewRequest);
        //Setto l'id del childLog
        Apexpages.currentPage().getParameters().put('Codice', '12');
        Apexpages.currentPage().getParameters().put('TipoRichiesta', '123');
        Apexpages.currentPage().getParameters().put('StatoRichiesta', '123');
        Apexpages.currentPage().getParameters().put('idPop', '123');
        Apexpages.currentPage().getParameters().put('idRisorsa', '123');
        Apexpages.currentPage().getParameters().put('DataInizioFilter', '123');
        Apexpages.currentPage().getParameters().put('DataFineFilter', '123');
        Apexpages.currentPage().getParameters().put('DataInizioOStream', '123');
        Apexpages.currentPage().getParameters().put('DataFineOstream', '123');
        //Istanzio la classe da testare
        PO_P2PAttiva_SearchRequestCntrl ctrl = new PO_P2PAttiva_SearchRequestCntrl();
   		ctrl.runSearchP2PATT();
        ctrl.homePageRef();
        
        ctrl.offertaSelected = 'P2P Attiva';
        ctrl.getTipodilist();
        ctrl.getIDPoplist();
        ctrl.getStatoOrdinelist();
        ctrl.sortField1 = null;
        ctrl.sortField2 = null;
        
        
        Apexpages.currentPage().getParameters().put('Offerta', '12OpenStream');
        Apexpages.currentPage().getParameters().put('Casenumber', '123');
        Apexpages.currentPage().getParameters().put('Status', 'Attivo');
        Apexpages.currentPage().getParameters().put('DataInizioCreazione', '123');
        Apexpages.currentPage().getParameters().put('DataFineCreazione', '123');
        Apexpages.currentPage().getParameters().put('Commune', 'Test');
        Apexpages.currentPage().getParameters().put('Nome', 'AA');
        Apexpages.currentPage().getParameters().put('Tipodicollegamento', 'Richieste');
        Apexpages.currentPage().getParameters().put('PrimeContractor', 'VF');
        Apexpages.currentPage().getParameters().put('Indirizzo1', 'roma');
		Apexpages.currentPage().getParameters().put('tipodi', 'tipo1');
        Apexpages.currentPage().getParameters().put('tipodi1', 'tipo2');
        ctrl.runSearch();
        
        ctrl.StatoSelected = '';
        ctrl.getStatoilist();
        ctrl.StatoSelected = 'Richieste';
        ctrl.getStatoilist();
        ctrl.StatoSelected = 'Collegamento';
        ctrl.getStatoilist();
        ctrl.StatoSelected = 'Ordine';
        ctrl.getStatoilist();
        ctrl.Offertaselect();
        
        ctrl.offertaSelected = 'Segnalazione Provisioning';
        ctrl.getCausaleAperturaItems();
        ctrl.getDescrCausaleItems();
        ctrl.offertaSelected = 'Problema tecnico/applicativo';
        ctrl.getCausaleAperturaItems();
        ctrl.getDescrCausaleItems();
        
        ctrl.toggleSort();
        ctrl.newAtt = new List<attachment>();
        ctrl.attxlxs = new List<attachment>();
        ctrl.attlst = new List<attachment>();
        Case c = new Case();
        c.Status = 'Accettato';
        insert c;
        Case childCase = new Case();
        childCase.ParentId = c.Id;
        childCase.PO_Disponibilit_della_rete_a_partire_da__c = Date.newInstance(2018, 12, 10);
        insert childCase;
        
        Apexpages.currentPage().getParameters().put('CaseDetail', c.Id);
        for(Integer i = 0; i < 2; i++){
            Attachment a = new Attachment();
            a.Body = Blob.valueOf('ciao'+i);
            a.Name = 'att'+i+'.pdf';
            a.ParentId = c.Id;
            a.IsPrivate = false;
            ctrl.newAtt.add(a);
        }
        for(Integer i = 0; i < 2; i++){
            Attachment a = new Attachment();
            a.Body = Blob.valueOf('ciao'+i);
            a.Name = 'att'+i+'.xlsx';
            a.ParentId = c.Id;
            a.IsPrivate = false;
            ctrl.attxlxs.add(a);
        }
        for(Integer i = 0; i < 2; i++){
            Attachment a = new Attachment();
            a.Body = Blob.valueOf('ciao'+i);
            a.Name = 'att'+i+'.pdf';
            a.ParentId = c.Id;
            a.IsPrivate = false;
            ctrl.attlst.add(a);
        }
        List<Attachment> lstAll = new List<Attachment>();
        lstAll.addAll(ctrl.newAtt);
        lstAll.addAll(ctrl.attxlxs);
        lstAll.addAll(ctrl.attlst);
        insert lstAll;
        
        ctrl.redirectparentcasedetail();
        ctrl.childcasedisplayid = childCase.Id;
        ctrl.redirectchildcasedetail();
        ctrl.CaseDetail = childCase.Id;
        ctrl.EditOrderInfo();
        ctrl.next();
        ctrl.first();
        ctrl.previous();
        ctrl.last();
        ctrl.searchcases();
        
        //Fine scope del test
        Test.stopTest();
    }
}