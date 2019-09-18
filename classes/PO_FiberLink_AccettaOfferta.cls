public without sharing class PO_FiberLink_AccettaOfferta  {
    
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
    //public opportunity opp1 {get; set;}
    public list<case> ordercaselst {get;set;}
    public list<case> ChildCases {get;set;}
    
    
    /**Parte di XLS**/
    public blob xlsxBlob;
    public string xlsxname;
    public string header;
    public string bod;
    public String finalstr{set;get;}
    public boolean checkEmpty {get; set;}
    public ID RichiestaFattibil {get;set;}
    public Case parentCaseObj {get;set;}
    public string NameAttachmentXLSX{get;set;}
    public list<attachment> attlst {get;set;}
    public list<attachment> newAtt {get;set;}
    public list<attachment> attxlxs {get;set;}
    public list<opportunity> opp{get;set;}


    public date getdate()
    {
        return system.today();
    }
    
  /*  public Opportunity getOpportunity()
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
        opportunity opp1 = [select id, name, recordtype.name, PO_Numero_Anni__c, PO_Richiesta_fattibilit__r.casenumber,PO_Richiesta_fattibilit__r.PO_Nome_Progetto__c,
                            PO_Special_Terms__c,PO_oppty_validit_offerta__c,PO_Note__c,PO_Richiesta_fattibilit__r.PO_Durata_mesi__c,
                            PO_Totale_Canone_Anno1_Scontato__c,PO_TotaleContributiAttivaAnno1Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontat__c,
                            PO_Totale_Canone_Anno2_Scontato__c,PO_TotaleContributiAttivaAnno2Scontati__c,PO_TotaleCostiAggiuntiviAnno1Scontati__c,
                            PO_Totale_Canone_Anno3_Scontato__c,PO_TotaleContributiAttivaAnno3Scontati__c,PO_TotaleCostiAggiuntiviAnno3Scontat__c,
                            PO_Totale_Canone_Altri_Anni_Scontato__c,PO_TotContributiAttivaAltriAnniScontati__c,PO_TotaleCostiAggiuntiviAltriAnnoScontat__c,
                            PO_Totale_canoni_scontato__c,PO_Totale_canoni_manutenzione_scontato__c,PO_Totale_corrispettivi_IRU_scontati__c,
                            PO_Totale_contributi_attivazione_scontat__c,PO_Totale_costi_aggiuntivi_scontati__c,
                            PO_Totale_scontat_valori_medi_altre_cop__c,PO_Totale_valori_medi_annui_scontato__c,PO_Totale_valori_fino_2030_scontato__c,
                            (select id, name,
                             PO_SceltaAnno1__c,PO_SceltaAnno2__c,PO_SceltaAnno3__c,PO_SceltaAltriAnni__c,
                             PO_Costi_aggiuntivi_collegamento_scontat__c, PO_ContributoAttivazCollegamScontato__c, PO_CanoneCollegamentoScontato__c,
                             PO_CorrispettivoIRUCollegamentoScontato__c,PO_CanoneManutenzioneCollegScontato__c,
                             PO_Totale_costi_aggiuntivi_scontati__c, PO_Totale_contributi_attivazione_scontat__c, PO_Totale_canoni_scontato__c, PO_Totale_canoni_manutenzione_scontato__c,
                             PO_Canone_annuo_Collegamento1anno_Scont2__c,PO_Contributo_annuo_Colleg1anno_Scontat2__c,PO_Costi_Aggiuntivi_Anno1_Scontati__c,
                             PO_Canone_annuo_Collegamento2anno_Scont2__c,PO_Contributo_annuo_Colleg2anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno2_Scontati__c,
                             PO_Canone_annuo_Collegamento3anno_Scont2__c,PO_Contributo_annuo_Colleg3anni_Scontat2__c,PO_Costi_Aggiuntivi_Anno3_Scontati__c,
                             PO_Canone_annuo_altri_anni_Scontato2__c ,PO_Contributo_Attivaz_altri_anni_Scont2__c,PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c,
                             PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c, PO_Collegamento__r.PO_Lunghezza_tratte_complessiva__c,
                             PO_Collegamento__r.PO_Numero_fibre_richieste__c, PO_Collegamento__r.PO_Civico__c, PO_Collegamento__r.PO_Indirizzo_collegamento__c,
                             PO_Collegamento__r.PO_Prime_Contractor__c, PO_Collegamento__r.PO_Nome_Comune__c,PO_Collegamento__r.PO_Sito__c,
                             PO_Collegamento__r.casenumber,PO_Durata_mesi__c,PO_Collegamento__r.PO_Tipo_percorso__c,
                             PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c,PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c,
                             PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name,PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.name,PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c,
                             PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.PO_Indirizzo__c,PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.PO_Indirizzo__c,
                             PO_Collegamento__r.PO_Nome_Comune3__c,PO_Collegamento__r.PO_Lunghezza_tratta_prima_via_FiberLink__c,
                             PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c,PO_Collegamento__r.PO_Civico_partenza__c,PO_Collegamento__r.PO_Sito_partenza__c,
                             PO_Valore_totale_coppia_fino_2030_sconta__c,PO_Valore_medio_annuo_altre_coppie_scont__c,PO_Valore_medio_annuo_totale_coll_scont__c,
                             PO_Collegamento__r.PO_Sito_3__c,PO_Collegamento__r.PO_indirizzo_collegamento_3__c,PO_Collegamento__r.PO_Nome_Comune4__c,PO_Collegamento__r.PO_Civico_3__c,
                             PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c
                             from Opportunities__r
                             where PO_Incluso_nell_offerta__c = true)
                            from Opportunity
                            where id =: q.OpportunityId];
        system.debug('DG_PDF_getOpportunity opp: ' + opp1);

        //TotPrezzi(opp);

       // FindOppo(opp1);

        return opp1;
    }*/
    
    

    public PO_FiberLink_AccettaOfferta(){
    
       //EC Start searchProfilo as OpenStream Method 2018 - 07 - 13
       // profiloCommerciale='';
        //getdate();
        //getOpportunity();
       // verifyProfilo = true;
       // viewError=false;
       // viewProfilo=false;

        attlst = new list<attachment>();
        newAtt = new list<attachment>();
        attxlxs = new list<attachment>();
        invia = false;
        String recordTypeName = 'PO Partner';
        string sParentId =ApexPages.currentPage().getParameters().get('parentId');
        
        string numanni =ApexPages.currentPage().getParameters().get('durata');
        
        if( integer.valueof(numanni)  > 3 )
        {
            checkAltriAnni = true;
        }else{

            if( integer.valueof(numanni)  == 1 )
            {
                
                check1Anno = true;
            }else if(integer.valueof(numanni)  == 2 )
            {
                check2Anni = true;
            }else if( integer.valueof(numanni)  == 3 )
            {
                check3Anni = true;
            }
        }
        
        
        checkFibLink=true;
        system.debug('sParentId========'+sParentId);
       

                        
                        
        if(sParentId!= null /* && sParentId.contains('500')*/)
        {
            parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,
                                    PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, 
                                    PO_Note_Modifica_Offerta__c, Subject, Status, Priority, 
                                    CreatedDate, CreatedById,PO_Offerta__c,ClosedDate,
                                    PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId,
                                    accountid
                                    from case 
                                    where Id=:sParentId Limit 1];

                                    
            system.debug('parentCaseObj========'+parentCaseObj);
            if(parentCaseObj != null)
            {
                ChildCases = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,Particella_Toponomastica_1__c,Particella_Toponomastica_2__c,Particella_Toponomastica_3__c,
                              CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                              Priority,Previous_Status__c,PO_IndrizoCal__c,OwnerId,PO_Durata_affitto__c, CreatedDate, CreatedById , PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                              from case where parentId=:parentCaseObj.id
                              order by CreatedDate ASC];
                opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Numero_Anni__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentCaseObj.id and PO_Collegamento__c = null limit 1];
                if(ChildCases.size()>0)
                {
                    ordercaselst = [select id,status,PO_Comune2__c,EOF_Comunicazioni_con_OLO__c,Note_Sospensione_Operatore__c,PO_Durata_mesi__c,PO_Case_Collegamento__r.PO_IndrizoCal__c,casenumber,PO_IndrizoCal__c,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Case_Collegamento__r.casenumber,PO_Tipo_di_collegamento__c,
                                    PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,Particella_Toponomastica_1__c,Particella_Toponomastica_2__c,Particella_Toponomastica_3__c,
                                    PO_Tipo_percorso__c,PO_Data_Attivazione_Richiesta__c,PO_Case_Collegamento__r.parent.PO_isDataOrder__c, PO_Note_collegamento__c,PO_Numero_Telefonico_PM__c, PO_Sito__c,PO_Nome_E_Cognome_PM__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                    recordtype.id,recordtype.developerName,OwnerId from case where PO_Case_Collegamento__c IN : ChildCases];

                }
                list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentCaseObj.id AND IsPrivate = false AND Name LIKE '%PDF%'
                                           ORDER BY createddate DESC limit 1];
                system.debug('newlst---'+newlst);
                for(attachment att : newlst )
                {
                    String attnamenew = att.Name;

                    if(attnamenew.contains('.pdf'))
                    {
                        newAtt.add(att);
                        system.debug('Attachment==='+newAtt);
                    }
                }

                list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentCaseObj.id
                                               ORDER BY createddate DESC];
                for(attachment att : attlstnew )
                {

                    string attname = att.Name;

                    if(attname.containsIgnoreCase('.pdf'))
                    {
                        attlst.add(att);
                    }
                }
                if(attlst.size()>1)
                {
                    attlst.remove(0);
                }

                list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentCaseObj.id AND IsPrivate = false
                                               ORDER BY createddate DESC];
                for(attachment att : newlstxlxs )
                {
                    String attnamexlxs = att.Name;

                    if(attnamexlxs.contains('.xlsx'))
                    {
                        attxlxs.add(att);
                        system.debug('Attachment==='+attxlxs);
                    }
                }

            }
        }
    

            //opp1 = getOpportunity();
            
            //string finalstr = 'Ns. Rif.:' + opp1.PO_Richiesta_fattibilit__r.casenumber + '<br/>' + 'Dettagli Collegamento e Offerta';
             
            //system.debug('#### Canone: ' + opp1.PO_Totale_Canone_Anno1_Scontato__c + ' - ID OPP : ' + opp1.id);
            //system.debug('#### finalstr' + finalstr);
           
            /**PRIMA TABELLA**/

            //string str;
            //Fiber Link
           
            //str = Tabella1FiberLink(opp1);
            
            /*system.debug('DG_OF_CreateQuoteXLS_Controller str: ' + str);
            finalstr = finalstr + str ;

            /**END PRIMA TABELLA**/

            /**MESSAGGI**/
          /*  if(str == null)
            {
                checkEmpty = true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Non ci sono dati disponibili per questa quote! Non puoi creare l\'xls.');
                ApexPages.addMessage(myMsg);
                return;
            }else
            {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Puoi creare l\'xls. <br/> L\'xls si troverà nella sezione Notes & Attachments della quote');
                ApexPages.addMessage(myMsg);
            }
            /**END MESSAGGI**/

            /**TABELLA DATI TOPONOMASTICI**/
          /*  string str1 = '<br/><br/>Dati toponomastici<br/>' + TabellaDatiToponomastici(opp1);
            system.debug('DG_OF_CreateQuoteXLS_Controller str1: ' + str1);
            finalstr = finalstr + str1;
            /**END TABELLA DATI TOPONOMASTICI**/


            /**TABELLA DATI METRICI**/
         /*   System.debug('##### DATI METRICI' );
            string str2 = '<br/>Dati metrici<br/>' + TabellaDatiMetrici(opp1);
            finalstr = finalstr + str2;
            /**END TABELLA DATI METRICI**/
        
        }    

   /* public static pagereference accetta(string casePadre,List<Opportunity> opp)
    {
        
        //Boolean inlineshow = true;
         
         Case   parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c,PO_Numero_Anni__c, Id,EOF_Fase__c,
                                ParentId, OF_Order__c, OF_Order__r.ContractId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, 
                                PO_Note_Modifica_Offerta__c,Subject, Status, Priority, CreatedDate, CreatedById ,PO_Offerta__c,Accordo_Operativo__c ,PO_Accordo_Quadro_Number__c ,
                                ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId,PO_Comune2__c,PO_Comune2__r.OF_Comune__c, 
                                PO_Comune3__c,
                                PO_Comune3__r.OF_Comune__c, 
                                PO_Comune4__c,
                                PO_Comune4__r.OF_Comune__c
                             from case where Id =:casePadre limit 1];
        
        list<opportunity> opplst = [select id,name,PO_Prezzo_totale_scontato__c,stagename,PO_Richiesta_fattibilit__c from opportunity
                                    where id in : opp limit 1
                                   ];

        if(opplst.size()>0 && !opplst.isEmpty())
        {
            

            if(opplst[0].stagename == 'Offerta presentata')
            {
                opplst[0].StageName = 'Offerta accettata';
                update opplst[0];
                
            }

        }
        if(parentCaseObj != null && opplst[0].StageName != null)
        {
             parentCaseObj.Status = 'Accettato';
             parentCaseObj.OwnerId = UserInfo.getUserId();
             parentCaseObj.PO_Durata_affitto__c=1;
            
            update parentCaseObj;
            system.debug('#### PO_Durata_affitto__c: '+parentCaseObj.PO_Durata_affitto__c);

            system.debug('##### ID Case Padre: '+parentCaseObj.id);
            list<case> childcaselst = [select id,PO_IndrizoCal__c,PO_Incluso_nell_offerta__c,PO_Comune2__c,status,casenumber,PO_Nome_Comune__c,CreatedDate,ClosedDate, parent.casenumber,EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
                                       PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
                                       PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
                                       recordtype.id,recordtype.developerName,OwnerId from case where parentid=:parentCaseObj.id and PO_Incluso_nell_offerta__c = true];

            system.debug('#### childcaselst: '+childcaselst.size());

            if(childcaselst.size()>0)
            
            {
                system.debug('#### OrderCreation: ');
               OrderCreation(childcaselst);
                //parentfile = true;
                //stagename = false;
            }


        }
        // return null;
        Quote qt = [select id, name, Opportunity.name, account.name,
             Account.BillingStreet,Account.BillingCity,
             Account.BillingState,Account.BillingPostalCode,
             PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
             PO_ContaPDF__c from Quote where opportunity.PO_Richiesta_fattibilit__r.id =:parentCaseObj.id limit 1];

        System.debug('#### Pirma di chiamare savePDF_FiberLinkPortal');
        return savePDF_FiberLinkPortal(qt,parentCaseObj.PO_Durata_affitto__c,parentCaseObj);

    }*/
    
    public static PageReference savePDF_FiberLinkPortal(Quote q,Decimal Durata,case parentCaseObj)
    {
        //idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + q.id);
        List<quotedocument> qdList = new List<quotedocument>();
        Boolean qdInserted;
       
        boolean check1Anno = false;
        boolean check2Anni = false;
        boolean check3Anni = false;
        boolean checkAltriAnni = false;

        system.debug('Duratta Selected'+ Durata);
        if( Durata > 3 )
        {
            checkAltriAnni = true;
        }else{

            if( Durata == 1 )
            {
                
                check1Anno = true;
            }else if(Durata == 2 )
            {
                check2Anni = true;
            }else if( Durata == 3 )
            {
                check3Anni = true;
            }
        }
        
         system.debug('FindAnnoFiberLink check1Anno:'+check1Anno+'-check2Anni:'+check2Anni+'-check3Anni:'+check3Anni+'-checkAltriAnni:'+checkAltriAnni);


        //PageReference thePDF = Page.OF_PDF_FiberLink;
        PageReference thePDF = Page.PO_FiberLinkPDF;
        thePDF.getParameters().put('id',q.id);
        thePDF.getParameters().put('durata',string.valueOF(Durata));
        thePDF.setRedirect(true);
        system.debug('Quoteid============='+q.id);


        quotedocument qd = new quotedocument();
        if( Test.isRunningTest())
        {
            qd.document = blob.toPdf('test');
        }else{
        try{
            qd.document = thePDF.getContent();
            }
            Catch(exception e)
            {
            system.debug('Exception'+e);
            }
        }
        // qd.document = thePDF.getContentAsPDF();
        //qd.document = blob.toPdf('test');
        qd.quoteId = q.Id;
        qdList.add(qd);
        Database.SaveResult[] srList = Database.insert(qdList, false);
       
        for (Database.SaveResult sr : srList) {
                 if (sr.isSuccess()) {
                qdInserted=true;
              }
         }
       
       system.debug('Quote Document============='+qd);
       
        PageReference thePDF1 = Page.PO_FiberLinkPDF;
        system.debug('#### Creazione PDF');
        thePDF1.getParameters().put('id',q.Id);
        //pp Modifico il file aggiungendo nel title l'estensione .pdf
        system.debug('#### Creazione PDF prima della query ContDoc');
        ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
        system.debug('#### ContentDocument dopo la query'+q.id);
        ContDoc.Title = ContDoc.Title + '.pdf';
        ContDoc.Title = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.pdf';
        update ContDoc;

        String NameAttachmentXLSX = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.xlsx';
        Quote qt = [select id,opportunity.PO_Richiesta_fattibilit__r.id from Quote where id =:q.id limit 1];
        system.debug('#### Quote dopo la query'+q.id);
        // PageReference quotePage = new PageReference('/apex/Po_FeasibilityServicesRequest2?id='+ qt.opportunity.PO_Richiesta_fattibilit__r.id);
        //return quotePage;
        /*Case parentCaseObj = [SELECT CaseNumber,PO_Numero_Anni__c,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:qt.opportunity.PO_Richiesta_fattibilit__r.id Limit 1];*/
        parentCaseObj.OwnerId = UserInfo.getUserId();
        update parentCaseObj;
        if(qdInserted==true){
        parentCaseObj.Status='Accettato';
        update parentCaseObj;
        }
        system.debug('parentCaseObj====='+parentCaseObj);
        return redirectparentcasedetailpdf(parentCaseObj,qd.id);
    }
    
    public static  pagereference  redirectparentcasedetailPDF(case parentCaseObj,ID qdId)
    {
        string selectedIdComune = '';
        string selectedIdComune1 = '';
        string selectedIdComune2 = '';
        String Prezzototale='';
        boolean stagename = false;
        boolean ordine=false;
        boolean parentfile = false;
        list<attachment> newAtt =new List<Attachment>();
        list<attachment> attlst =new List<Attachment>();
        list<attachment> attxlxs =new List<Attachment>();
        
   
        string attNamenew='';
        string attname='';

        //newAtt.clear();
        //attxlxs.clear();
        //searchCaseBoolean=false;
        //attlst.clear();
        //parentfile = false;
        //Ordine = false;
        //stagename = false;
        Id parentId = parentCaseObj.id;
        string prid = parentId;
        system.debug('prid===='+prid);
        system.debug('parentId===='+parentId);
        /*Case parentCaseObj = [SELECT CaseNumber,PO_isDataOrder__c, Id,EOF_Fase__c,ParentId,PO_Note_rifiuto_offerta__c,PO_Durata_affitto__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                         PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,OwnerId from case where Id=:caseID Limit 1];
        system.debug('parentCaseObj===='+parentCaseObj);*/
        list<Case> childcaseList = [SELECT Case.Parent.casenumber,Case.parent.PO_Offerta__c,Case.parent.CreatedDate, Case.parent.Status,
                                    CaseNumber,PO_Comune2__c,PO_Civico__c,PO_Durata_mesi__c,  Id, ParentId, Subject, Status,PO_Incluso_nell_offerta__c,PO_Tipo_percorso__c,PO_Indirizzo_collegamento__c,
                                    Priority,Previous_Status__c,PO_IndrizoCal__c, CreatedDate, CreatedById ,OwnerId, PO_Offerta__c ,PO_Richiesta_a_fattibilit__c,PO_Nome_Comune__c
                                    from case where (parentId=:parentId OR parentId=:prid)
                                    order by CreatedDate ASC];
        if(childcaseList.size()>0)
            //ChildCases = childcaseList;
        //system.debug('ChildCases====='+ChildCases);
        if(childcaseList.size()>0){


            if(parentId !=NULL) {
                parentCaseObj = [SELECT CaseNumber, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                                 PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];



              list<Opportunity> opp = [select id,stagename,PO_Prezzo_totale_scontato__c,PO_Richiesta_fattibilit__r.id, PO_Collegamento__c,(SELECT Id,Name,ParentId,ContentType from Attachments) from opportunity where PO_Richiesta_fattibilit__r.id =: parentid and PO_Collegamento__c = null limit 1];


                if(opp.size()>0 && !opp.isEmpty())
                {
                    if(opp[0].PO_Prezzo_totale_scontato__c != null)
                    {
                        Prezzototale = string.valueof(opp[0].PO_Prezzo_totale_scontato__c);
                    }

                    if(opp[0].stagename=='Offerta presentata')
                    {
                        opp[0].stagename='Offerta accettata';
                        stagename = true;
                    }
                }

                if(parentid != null)
                {


                    // attlst = attlstnew;
                    list<attachment> newlst = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false AND Name LIKE '%PDF%'
                                               ORDER BY createddate DESC limit 1];
                    for(attachment att : newlst )
                    {
                        attnamenew = att.Name;

                        if(attnamenew.contains('.pdf'))
                        {
                            newAtt.add(att);
                            system.debug('Attachment==='+newAtt);
                        }
                    }
                    list<attachment>  attlstnew = [select id,name,parentid,createddate from attachment where parentid =: parentId
                                                   ORDER BY createddate DESC];
                    for(attachment att : attlstnew )
                    {
                        attname = att.Name;
                        system.debug('Attachment==='+att.Name);
                        // if(!attname.contains('.')||attname.contains('.pdf')&&(!attnamenew.equalsIgnoreCase(attname)))

                        if(attname.containsIgnoreCase('.pdf'))
                        {
                            attlst.add(att);
                            system.debug('Attachment==='+attlst);
                        }
                    }
                    if(attlst.size()>1)
                    {
                        attlst.remove(0);
                    }

                    list<attachment> newlstxlxs = [select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                                   ORDER BY createddate DESC];
                    for(attachment att : newlstxlxs )
                    {
                        String attnamexlxs = att.Name;

                        if(attnamexlxs.contains('.xlsx'))
                        {
                            attxlxs.add(att);
                            system.debug('Attachment==='+attxlxs);
                        }
                    }

                }
                if(parentCaseObj.Status == 'Accettato')
                {
                    System.debug('testdate---');
                    Datetime fieldDate;
                    Datetime attachDate;
                    datetime qdDate;
                    List<CaseHistory> csh=[select ID,Field, CaseId, CreatedDate from CaseHistory where caseID=:parentId and field='Status' Order By CreatedDate Desc limit 1];
                    List <Attachment> ash=[select id,name,parentid,IsPrivate,createddate from attachment where parentid =: parentId AND IsPrivate = false
                                           ORDER BY createddate DESC Limit 1];
                    List<QuoteDocument> qdlist=[select id,createddate from QuoteDocument where id=:qdid ORDER BY createddate DESC Limit 1];
                    for(CaseHistory ch:csh)
                    {
                        System.debug('testdate---1');
                        fieldDate=ch.createdDate;
                    }

                    for(Attachment ah:ash)
                    {
                        System.debug('testdate---2');
                        attachDate=ah.createdDate;
                    }
                    If(fieldDate<attachDate) {
                        System.debug('testdate---3'+fieldDate);
                        System.debug('testdate---3'+attachDate);

                       // ordine=true;
                    }

                   if(parentCaseObj.PO_Offerta__c == 'Fiber Link')
                   {
                   for(quoteDocument ah:qdList)
                    {
                        System.debug('testdate---2');
                        qdDate=ah.createdDate;
                    }
                    If(fieldDate>qdDate) {
                        System.debug('testdate---3'+fieldDate);
                        System.debug('testdate---3'+attachDate);

                        ordine=true;
                    }
                   }
                }
                if(ordine == false && stageName== false && parentCaseObj.Status == 'Accettato')
                {
                    parentfile = true;
                }
                if( parentCaseObj.PO_isDataOrder__c ==true)
                {
                    ordine =false;
                }
            }

        }
        if(parentId !=NULL && childcaseList.size()==0) {
            parentCaseObj = [SELECT CaseNumber, PO_isDataOrder__c,Id, ParentId,PO_Note_rifiuto_offerta__c, PO_Note_Modifica_Offerta__c, Subject, Status, Priority, CreatedDate, CreatedById ,
                             PO_Offerta__c,ClosedDate,PO_Nome_Progetto__c,PO_Tipologia_Offerta__c,PO_Durata_Affitto__c,OwnerId from case where Id=:parentid Limit 1];
            system.debug('entering========'+parentCaseObj);
            //ChildCases = childcaseList;
           // return new pagereference ('/apex/PO_Serv_FiberLink_Richieste');
        }

        system.debug('OutsideLoop===='+parentId);
       //return new pagereference ('/apex/PO_Serv_FiberLink_Richieste');
       list<EOF_EAI_Service_Log__c> logCurrent ;
                logCurrent = [select id,caso__c
                        from EOF_EAI_Service_Log__c 
                        where Caso__c =:parentId limit 1];
    //Pagereference pg = new PageReference('/PO_P2PAtt_RiepReq_ElCo');
    Pagereference pg = new PageReference('/PO_Serv_FiberLink_Riepilogo');
    pg.getParameters().put('parentId',logCurrent[0].id);
    return pg;

    }

/*
    public string Tabella1FiberLink(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1FiberLink 1');


        if(CheckNumAnni == true)
        {
            header = '\tAffitto 1 anno\tAffitto 2 Anni\tAffitto 3 Anni\tAffitto '+ opp.PO_Numero_Anni__c + 'Anni<br/>';
            bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_Canone_Anno1_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno2_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno3_Scontato__c + '\t' + opp.PO_Totale_Canone_Altri_Anni_Scontato__c + '<br/>'
                + 'Contributo di attivazione' + '\t' + opp.PO_TotaleContributiAttivaAnno1Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno2Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno3Scontati__c + '\t' + opp.PO_TotContributiAttivaAltriAnniScontati__c + '<br/>'
                + 'Costi Aggiuntivi' + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontati__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno3Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAltriAnnoScontat__c + '<br/>';
        }
        else{
            header = '\tAffitto 1 anno\tAffitto 2 Anni\tAffitto 3 Anni <br/>';
            bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_Canone_Anno1_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno2_Scontato__c + '\t' + opp.PO_Totale_Canone_Anno3_Scontato__c + '<br/>'
                + 'Contributo di attivazione' + '\t' + opp.PO_TotaleContributiAttivaAnno1Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno2Scontati__c + '\t' + opp.PO_TotaleContributiAttivaAnno3Scontati__c + '<br/>'
                + 'Costi Aggiuntivi' + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontat__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno1Scontati__c + '\t' + opp.PO_TotaleCostiAggiuntiviAnno3Scontat__c + '<br/>';
        }

        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1FiberLink 2 bod: ' + bod);
        return bod;
    }
    
    public string TabellaDatiToponomastici(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;

        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);

        
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione\tSede 2 di terminazione\tIndirizzo Sede 2 di terminazione <br/>';
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);

        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;

            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c;


                StringTopon =   StringTopon + '\t' +
                    OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Sito_3__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_indirizzo_collegamento_3__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_3__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune4__c +
                    '<br/>';
           
           
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;

        }
        return header + bod;
    }
    
    //Tabella dati metrici dei collegamenti
    public string TabellaDatiMetrici(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;

       // system.debug('DG_OF_CreateQuoteXLS_Controller_TabellaDatiMetrici header: ' + header);

        header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';

        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;

            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Tipo_percorso__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Numero_fibre_richieste__c + '\t';

          
          
                StringTopon =   StringTopon +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c + '\t' +
                    OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' +
                    string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) +
                    '<br/>';
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;

        }
        return header + bod;
    }
    //Tabella Dettaglio offerta dei collegamenti
    public string TabellaDettaglioOfferta(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;

      
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
                    'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
                    'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo aggi. 3 anni (euro)\t'+
                    'Canone affitto '+opp.PO_Numero_Anni__c+' anni (euro/anno)\tContributo di attivazione '+opp.PO_Numero_Anni__c+' anni (euro)\tContributo aggi. '+opp.PO_Numero_Anni__c+' anni (euro)<br/>';

      
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;

            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' +
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' +
                OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t';

           
                    StringTopon =   StringTopon +
                        OppCol.PO_Canone_annuo_Collegamento1anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg1anno_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno1_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_Collegamento2anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg2anni_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno2_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_Collegamento3anno_Scont2__c + '\t' +
                        OppCol.PO_Contributo_annuo_Colleg3anni_Scontat2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Anno3_Scontati__c + '\t' +
                        OppCol.PO_Canone_annuo_altri_anni_Scontato2__c + '\t' +
                        OppCol.PO_Contributo_Attivaz_altri_anni_Scont2__c + '\t' +
                        OppCol.PO_Costi_Aggiuntivi_Altri_Anni_Scontati__c +
                        '<br/>';
                
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;

        }
        return header + bod;
    }
    */
    public static List<Case>  OrderCreation (List<Case> CaseFromPortal) {
		
		system.debug('PO_ServiziFattibilita_Controller OrderCreation');
		List<Case> caseToInsert = new List<Case>();
		
	
		/*MAp<String,String> checkRType = new MAp<String,String>();
		for (recordType RT : RList) {
			checkRType.Put( rt.Id,rt.developerName);
		}*/
		list<RecordType> RList =[select id, developerName from recordType];
		MAp<String,String> rtMap = new MAp<String,String>();
			
		for (recordType RT : RList) {
			rtMap.Put(rt.developerName, rt.Id);
		}
		system.debug('#### Record FL: ' + rtMap);
		system.debug('#### Record FL: ' + rtMap.get('PO_Ordine_Fiber_Link'));
		
		//if (rtMap.get(CaseFromPortal[0].recordtypeId).contains('Collegamento')) {
		/*	list<Case> CaseToOrder =[select status, EOF_fase__c,PO_Case_Collegamento__c,PO_Tipo_di_collegamento__c,
									 PO_Numero_fibre_richieste__c,AccountId, PO_Prime_Contractor__c, PO_Nome_sito__c, PO_Comune__c, PO_Indirizzo_sito__c,
									 PO_Tipo_percorso__c, PO_Note_collegamento__c, PO_Sito__c, PO_Nota_sito__c, PO_Indirizzo_collegamento__c,
									 recordtype.id,recordtype.developerName from case where id IN: CaseFromPortal];

			
*/
			
			for (case cOld: CaseFromPortal) {
			
			    case c= new case ();
				c.status='Accettato';
				c.EOF_Fase__c='Bozza';
				c.PO_Case_Collegamento__c=cOld.Id;
				c.PO_Tipo_di_collegamento__c=cOld.PO_Tipo_di_collegamento__c;
				c.PO_Numero_fibre_richieste__c=cOld.PO_Numero_fibre_richieste__c;
				c.AccountId=cOld.AccountId;
				c.PO_Prime_Contractor__c=cOld.PO_Prime_Contractor__c;
				c.PO_Nome_sito__c=cOld.PO_Nome_sito__c;
				c.PO_Comune__c=cOld.PO_Comune__c;
				c.PO_Indirizzo_sito__c=cOld.PO_Indirizzo_sito__c;
				c.PO_Tipo_percorso__c=cOld.PO_Tipo_percorso__c;
				c.PO_Note_collegamento__c=cOld.PO_Note_collegamento__c;
				c.PO_Sito__c=cOld.PO_Sito__c;
				c.PO_Nota_sito__c=cOld.PO_Nota_sito__c;
				c.PO_Indirizzo_collegamento__c=cOld.PO_Indirizzo_collegamento__c;
				c.recordTypeid=rtMap.get('PO_Ordine_Fiber_Link');
				caseToInsert.add(c);
			}
			
			insert caseToInsert;
			
		//}

        return caseToInsert;
	}
}