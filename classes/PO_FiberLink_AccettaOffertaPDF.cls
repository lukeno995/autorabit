public without sharing class PO_FiberLink_AccettaOffertaPDF  {
    
    public boolean checkFibLink {get; set;}
    public boolean check1Anno {get;set;}
    public boolean check2Anni {get;set;}
    public boolean check3Anni {get;set;}
    public boolean checkAltriAnni {get;set;}
    public boolean CheckNumAnni {get;set;}
    public boolean invia {get;set;}
    public string strMese {get;set;}
    public String idquote;
    public quote q {set;get;}
    public Opportunity pdfOpp {get; set;}
    public list<opportunity> oppCostiColl {get; set;}
    public opportunity opp1 {get; set;}
    public list<case> caseLst {get; set;}
    public list<case> ordercaselst {get;set;}
    public list<case> ChildCases {get;set;}
    public String finalstr{set;get;}
    //campi per la creazion del pdf
    public decimal Totale_Canone_Anno1_Scontato {set;get;}
    public decimal TotaleContributiAttivaAnno1Scontati {set;get;}
    public decimal TotaleCostiAggiuntiviAnno1Scontat {set;get;}
    public decimal Totale_Canone_Anno2_Scontato {set;get;}
    public decimal TotaleContributiAttivaAnno2Scontati {set;get;}
    public decimal TotaleCostiAggiuntiviAnno2Scontat {set;get;}
    public decimal Totale_Canone_Anno3_Scontato {set;get;}
    public decimal TotaleContributiAttivaAnno3Scontati {set;get;}
    public decimal TotaleCostiAggiuntiviAnno3Scontat {set;get;}
    
    public decimal Totale_Canone_AnnoAA_Scontato {set;get;}
    public decimal TotaleContributiAttivaAnnoAAScontati {set;get;}
    public decimal TotaleCostiAggiuntiviAnnoAAScontat {set;get;}
    
    public string casenum     {set;get;}
    
    
    public decimal Canone     {set;get;}
    public decimal Contributo     {set;get;}
    public decimal Aggiuntivo     {set;get;}
    public string idOpptot     {set;get;}
    
    public string accName     {set;get;}
    public string BillStreet     {set;get;}
    public string BillCity     {set;get;}
    public string BillState     {set;get;}
    public string BillPostalCode     {set;get;}
    public string nomePrj {set;get;}
    public string valOfferta  {set;get;}
    public string terms {set;get;}
    public string collCasenum {set;get;}
    public string csColl {set;get;}
    
    

    public date getdate()
    {
        return system.today();
    }
    
    public Opportunity getOpportunity()
    {
        idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);

        q = [select id, name, Opportunity.name, account.name,
             Account.BillingStreet,Account.BillingCity,
             Account.BillingState,Account.BillingPostalCode,
             PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
             PO_ContaPDF__c
             from Quote
             where id = :idquote];
             
            accName        = q.Account.Name;
            BillStreet     = q.Account.BillingStreet;
            BillCity       = q.Account.BillingCity;
            BillState      = q.Account.BillingState;
            BillPostalCode = q.Account.BillingPostalCode;
                
         opp1 = [select id,PO_Collegamento__c,name, recordtype.name, PO_Numero_Anni__c, PO_Richiesta_fattibilit__r.casenumber,PO_Richiesta_fattibilit__r.PO_Nome_Progetto__c,
                            PO_Special_Terms__c,PO_oppty_validit_offerta__c,PO_Note__c,PO_Richiesta_fattibilit__r.PO_Durata_mesi__c,
                            PO_Totale_Canone_Anno1_Scontato__c,PO_TotaleContributiAttivaAnno1Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontat__c,
                            PO_Totale_Canone_Anno2_Scontato__c,PO_TotaleContributiAttivaAnno2Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontati__c,
                            PO_Totale_Canone_Anno3_Scontato__c,PO_TotaleContributiAttivaAnno3Scontati__c,PO_TotaleCostiAggiuntiviAnno3Scontat__c,
                            PO_Totale_Canone_Altri_Anni_Scontato__c,PO_TotContributiAttivaAltriAnniScontati__c,PO_TotaleCostiAggiuntiviAltriAnnoScontat__c,
                            PO_Totale_canoni_scontato__c,PO_Totale_canoni_manutenzione_scontato__c,PO_Totale_corrispettivi_IRU_scontati__c,
                            PO_Totale_contributi_attivazione_scontat__c,PO_Totale_costi_aggiuntivi_scontati__c,PO_Offerta_totale__r.PO_ScontoCanone_annuo_Collegameno_1anno__c,
                            PO_Totale_scontat_valori_medi_altre_cop__c,PO_Totale_valori_medi_annui_scontato__c,PO_Totale_valori_fino_2030_scontato__c
                            ,PO_Canone_annuo_Collegamento1anno_Scont2__c
                            ,PO_Contributo_annuo_Colleg1anno_Scontat2__c
                            ,PO_Costi_Aggiuntivi_Anno1_Scontati__c
                            ,PO_Canone_annuo_Collegamento2anno_Scont2__c
                            ,PO_Contributo_annuo_Colleg2anni_Scontat2__c
                            ,PO_Costi_Aggiuntivi_Anno2_Scontati__c
                            ,PO_Canone_annuo_Collegamento3anno_Scont2__c
                            ,PO_Contributo_annuo_Colleg3anni_Scontat2__c
                            ,PO_Costi_Aggiuntivi_Anno3_Scontati__c
                            ,PO_Canone_annuo_altri_anni_Scontato2__c
                            ,PO_Contributo_Attivaz_altri_anni_Scont2__c
                            ,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c
                            ,PO_Totale_Canone_Altri_Anni__c 
                            ,PO_Totale_Contributi_Attiva_Altri_Anni__c 
                            ,PO_Totale_Costi_Aggiuntivi_Altri_Anni__c
                        from Opportunity
                            where id =: q.OpportunityId];
       
        idOpptot= q.OpportunityId;
        
      //  list<case> idCaseColl = [select  id,CaseNumber from case where id in (select PO_Collegamento__c from Opportunity  where PO_Offerta_totale__r.id=:q.OpportunityId  and PO_Incluso_nell_offerta__c = true)];
        
        //system.debug('#### idCaseColl:'+  idCaseColl.id);
        
            oppCostiColl = [select PO_Offerta_totale__c, PO_ParentCase__c,PO_Collegamento__r.CaseNumber,PO_Collegamento__c, PO_Costi_Aggiuntivi_Anno2_Scontati__c,PO_Canone_annuo_Collegamento3anno_Scont2__c,
                            
                            PO_Contributo_annuo_Colleg3anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno3_Scontati__c,PO_Collegamento__r.PO_Sito__c,PO_Collegamento__r.Particella_Toponomastica_1__c,
                            PO_Collegamento__r.PO_Indirizzo_collegamento__c, PO_Collegamento__r.PO_Nome_Comune__c,PO_Collegamento__r.PO_Civico__c,PO_Contributo_annuo_Colleg2anni_Scontat2__c,
                            PO_Canone_annuo_Collegamento1anno_Scont2__c,PO_Contributo_annuo_Colleg1anno_Scontat2__c,PO_Costi_Aggiuntivi_Anno1_Scontati__c,PO_Canone_annuo_Collegamento2anno_Scont2__c
                            ,PO_Canone_annuo_altri_anni_Scontato2__c,PO_Contributo_Attivaz_altri_anni_Scont2__c,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c,
                            
                            PO_Sconto_Canone_annuo_altriAnni__c, PO_Sconto_ContributoAttivazione_altriAnn__c, PO_Sconto_Costi_Aggiuntivi_Altri_Anni_1__c,
                            PO_Canone_annuo_AltriAnni__c, PO_Contributo_attivazione_altri_anni__c, PO_Costi_Aggiuntivi_Altri_Anni__c

                          ,PO_Totale_Canone_Altri_Anni__c 
                            ,PO_Totale_Contributi_Attiva_Altri_Anni__c 
                            ,PO_Totale_Costi_Aggiuntivi_Altri_Anni__c
                            
                            from Opportunity  
                            where PO_Offerta_totale__r.id=:q.OpportunityId
                            and PO_Incluso_nell_offerta__c = true];
                            
        system.debug('#### PO_Contributo_annuo_Colleg1anno_Scontat2__c:'+  oppCostiColl[0].PO_Contributo_annuo_Colleg1anno_Scontat2__c);
        


        return opp1;
    }

    public PO_FiberLink_AccettaOffertaPDF(){

         string numanni = ApexPages.currentPage().getParameters().get('durata');
         system.debug('#### ' + numanni);
         Canone     =0;
         Contributo =0;
         Aggiuntivo =0;
         

      
      
        checkFibLink=true;
        
        //getdate();
        pdfOpp = getOpportunity();
        Totale_Canone_Anno1_Scontato=pdfOpp.PO_Totale_Canone_Anno1_Scontato__c;
        TotaleContributiAttivaAnno1Scontati = pdfOpp.PO_TotaleContributiAttivaAnno1Scontati__c;
        TotaleCostiAggiuntiviAnno1Scontat = pdfOpp.PO_TotaleCostiAggiuntiviAnno1Scontat__c;
        
        Totale_Canone_Anno2_Scontato = pdfOpp.PO_Totale_Canone_Anno2_Scontato__c;
        TotaleContributiAttivaAnno2Scontati = pdfOpp.PO_TotaleContributiAttivaAnno2Scontati__c;
        TotaleCostiAggiuntiviAnno2Scontat = pdfOpp.PO_TotaleCostiAggiuntiviAnno1Scontat__c;
        
        Totale_Canone_Anno3_Scontato=pdfOpp.PO_Totale_Canone_Anno3_Scontato__c;
        TotaleContributiAttivaAnno3Scontati=pdfOpp.PO_TotaleContributiAttivaAnno3Scontati__c;
        TotaleCostiAggiuntiviAnno3Scontat=pdfOpp.PO_TotaleCostiAggiuntiviAnno3Scontat__c;
     

        Totale_Canone_AnnoAA_Scontato        = pdfOpp.PO_Totale_Canone_Altri_Anni_Scontato__c;
        TotaleContributiAttivaAnnoAAScontati = pdfOpp.PO_TotContributiAttivaAltriAnniScontati__c;
        TotaleCostiAggiuntiviAnnoAAScontat   = pdfOpp.PO_TotaleCostiAggiuntiviAltriAnnoScontat__c;
        

        
        casenum = pdfOpp.PO_Richiesta_fattibilit__r.casenumber;
        nomePrj = pdfOpp.PO_Richiesta_fattibilit__r.PO_Nome_Progetto__c;
        valOfferta = pdfOpp.PO_oppty_validit_offerta__c;
        terms= pdfOpp.PO_Special_Terms__c;
        system.debug('#### pdfOpp.PO_Collegamento__c:'+  pdfOpp.id);
        system.debug('#### pdfOpp.id:'+ pdfOpp);
        


        caseLst = new list<case>();
        caseLst = [select id,PO_Tempi_di_attivazione_mesi__c, PO_Lunghezza_tratte_complessiva__c,
                   PO_Numero_fibre_richieste__c, PO_Civico__c, PO_Indirizzo_collegamento__c,
                   PO_Prime_Contractor__c, PO_Nome_Comune__c,PO_Sito__c,
                   casenumber,PO_Durata_mesi__c,PO_Tipo_percorso__c,Particella_Toponomastica_1__c,Particella_Toponomastica_2__c,Particella_Toponomastica_3__c,
                   PO_Lunghezza_tratta_prima_via__c,PO_Lunghezza_tratta_seconda_via__c,
                   PO_Pop_1_di_riferimento2__r.name,PO_Pop_2_di_riferimento2__r.name,PO_Disponibilit_della_rete_a_partire_da__c,
                   PO_Pop_1_di_riferimento2__r.PO_Indirizzo__c,PO_Pop_2_di_riferimento2__r.PO_Indirizzo__c,
                   PO_Nome_Comune3__c,PO_Lunghezza_tratta_prima_via_FiberLink__c,
                   PO_Indirizzo_collegamento_partenza__c,PO_Civico_partenza__c,PO_Sito_partenza__c,
                   PO_Sito_3__c,PO_indirizzo_collegamento_3__c,PO_Nome_Comune4__c,PO_Civico_3__c,
                   PO_Lunghezza_tratta_seconda_via_FiberLin__c
                   from case
                   where id in (select PO_Collegamento__c from Opportunity  
                                where PO_Offerta_totale__r.id=:q.OpportunityId  
                                and PO_Incluso_nell_offerta__c = true)];
         
        if( integer.valueof(numanni) == 1 ){
            check1Anno = true;
            system.debug('#### numanni: ' + numanni);
        }
        else if(integer.valueof(numanni) == 2 ){
            system.debug('#### numanni: ' + numanni);
            check2Anni = true;
        }
        else if( integer.valueof(numanni) == 3 ){
            system.debug('#### numanni: ' + numanni);
            check3Anni = true;
        }   
    
        else if( integer.valueof(numanni) > 3 ){
            system.debug('#### numanni: ' + numanni);
            checkAltriAnni =true;
            CheckNumAnni=true;
            
        }   
    
            //system.debug('#### PO_Collegamento__r.casenumber: ' + caseLst[0].casenumber);
    }
}