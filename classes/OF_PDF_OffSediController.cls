public class OF_PDF_OffSediController {
    
    public boolean checkIRU {get; set;}
    public boolean checkP2P {get; set;}
    public boolean checkFibLink {get; set;}
    public boolean checkFibLease {get; set;}
    public boolean checkFibLeaseMisto {get;set;}
    public boolean checkEventoTemp {get; set;}
    public boolean checkBackhauling {get; set;} //FD 13-11-2018 - CR Backhauling
    public boolean checkBTS {get;set;} //FD 28-11-2018 - CR BTS
    public boolean checkDarkFiber {get;set;} //FD 28-01-2019 - CR DarkFiber
    
    // 24-09-2018 MM : Aggiunta booleano e lista case coll P2P Attiva
    public boolean checkP2PAtt {get;set;}
    public boolean checkP2PAttELine {get;set;} //EC 2019 06 10
    public list<Case> ColP2PAtt {get;set;} //EC guardando il codice questa variabile è utilizzata entropicamente per la lista di collegamenti generici, mentre
    public list<Case> ColP2PAttELine {get;set;} //EC 2019 06 10
    
    public list<Case> CaseKit {get;set;}
    public list<EOF_EAI_Service_Log__c> CollLog{get;set;}
  //  public list<EOF_EAI_Service_Log__c> CollLogP2PattivaELine{get;set;} //EC 2019 06 10
    public list<EOF_EAI_Service_Log__c> VlanLogs{get;set;}
    
    //CRM 24_08 INIZIO
    public boolean check1Anno {get;set;}
    public boolean check2Anni {get;set;}
    public boolean check3Anni {get;set;}
    public boolean checkAltriAnni {get;set;}
    public boolean CheckNumAnni {get;set;}
    //FINE
    
    public string strMese {get;set;}
    public string nsRifString {get;set;}
    
    public ID idquote;
    public quote q {set;get;}
    public opportunity opp {get; set;}
    
    /**Parte di XLS**/
    public blob xlsxBlob;
    public string xlsxname;
    public string header;
    public string bod;
    public String finalstr{set;get;}
    public boolean checkEmpty {get; set;}
    public ID RichiestaFattibil {get;set;}
    /*****************/ 
    
    public string NameAttachmentXLSX{get;set;}
    
    public OF_PDF_OffSediController()
    {
        idquote = ApexPages.currentPage().getParameters().get('id');
        system.debug('DG_PDF_idquote:' + idquote);
        q = [select id, name, Opportunity.name, Account.name, Account.Id, 
                    Account.BillingStreet,Account.BillingCity,
                    Account.BillingState,Account.BillingPostalCode,
                    PO_Durata_affitto__c,OpportunityId,Opportunity.PO_Richiesta_fattibilit__c,
                    PO_ContaPDF__c
             from Quote
             where id = :idquote];
        
        RichiestaFattibil = q.Opportunity.PO_Richiesta_fattibilit__c;
        
        // 2018-09-24 MM : aggiunta query per trovare elenco case collegamento legati alla richiesta a fattibilità con relativo service log di vlan e kit
        if(RichiestaFattibil != null && String.isNotBlank(RichiestaFattibil)){
            ColP2PAtt = [select id, casenumber,status, parentID,PO_Richiesta_a_fattibilit__c, PO_Tempi_di_attivazione_mesi__c, 
            			PO_Lunghezza_tratte_complessiva__c, PO_Numero_fibre_richieste__c,
                        PO_Civico__c, PO_Indirizzo_collegamento__c, PO_Prime_Contractor__c, PO_Nome_Comune__c, 
                        PO_Sito__c, PO_Durata_mesi__c, PO_Tipo_percorso__c, PO_Lunghezza_tratta_prima_via__c,
                        PO_Lunghezza_tratta_seconda_via__c, PO_Pop_1_di_riferimento2__r.name, PO_Pop_2_di_riferimento2__r.name, 
                        PO_Disponibilit_della_rete_a_partire_da__c, PO_Pop_1_di_riferimento2__r.PO_Indirizzo__c,
                        PO_Pop_2_di_riferimento2__r.PO_Indirizzo__c, PO_Nome_Comune3__c, PO_Lunghezza_tratta_prima_via_FiberLink__c, 
                        PO_Indirizzo_collegamento_partenza__c, PO_Civico_partenza__c,
                        Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                        PO_Sito_partenza__c, PO_Sito_3__c, PO_indirizzo_collegamento_3__c, PO_Nome_Comune4__c, 
                        PO_Civico_3__c, PO_Lunghezza_tratta_seconda_via_FiberLin__c,
                        Tipologia_Sede__c,SF_Ccoll_ID_Sede__c, EOF_Codice_Ordine_OLO__c
                        from case 
                        where PO_Richiesta_a_fattibilit__c =: RichiestaFattibil ];//EC 2019 05 22 aggiunti 2 campi alla query SF_Ccoll_ID_Sede__c e Tipologia_Sede__c
                        
        }
               
        system.debug('la lista di case di collegamento contiene il seguente numero di case:' + ColP2PAtt.size());
                
        if(ColP2PAtt.size()>0){
          /*	for(EOF_EAI_Service_Log__c slLoc: [select Id, Caso__c, Caso__r.Status, Caso__r.Parent.Status, Caso__r.casenumber, EOF_Codice_Ordine_OLO__c, Name,
                            PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c,PO_Offerta__c, 
                            EOF_Codice_Operatore__c, PO_Nome_Progetto__c, PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, 
                            PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c, EOF_PROFILO__c, PO_Sito__c, PO_Civico__c, 
                            Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                            PO_Nota_sito__c,EOF_STATO_ORDINE__c, OF_Id_Comune__c,Caso__r.ParentId,PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
                            
                            PO_P2PAttiva_Opzione__c,COS5_PIR__c, COS5_CIR__c, COS3_PIR__c, 
                            COS3_CIR__c, COS1_PIR__c, COS1_CIR__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, 
                            PO_PP_User_VLAN__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, 
                            PO_PP_cos_class__c, ID_Sede__c
                            
                            from EOF_EAI_Service_Log__c 
                            where caso__c IN : ColP2PAtt 
                            and (recordtype.developername ='P2P_Attiva_Collegamento' OR recordtype.developername ='P2P_Attiva_Collegamento_ELine')]){
                   if('P2P_Attiva_Collegamento'.equalsIgnoreCase(slLoc.recordtype.developername)) {
                   			system.debug('@@@@@EC 2019 06 10 eAccess');
                   			CollLog.add(slLoc);
                   			
                   }
                   else if('P2P_Attiva_Collegamento_ELine'.equalsIgnoreCase(slLoc.recordtype.developername)){
                   		   system.debug('@@@@@EC 2019 06 10 eLine');
                           CollLogP2PattivaELine.add(slLoc);
                           }
                } */
        
                CollLog = [select Id, Caso__c, Caso__r.Status, Caso__r.Parent.Status, Caso__r.casenumber, EOF_Codice_Ordine_OLO__c, Name,
                            PO_Tipo_percorso__c, PO_Indirizzo_collegamento__c, EOF_Comune__c, EOF_Stato_Richiesta__c,PO_Offerta__c, 
                            EOF_Codice_Operatore__c, PO_Nome_Progetto__c, PO_Tipo_di_collegamento__c, PO_Prime_Contractor__c, 
                            PO_Incluso_nell_offerta__c,PO_Numero_fibre_richieste__c, EOF_PROFILO__c, PO_Sito__c, PO_Civico__c, 
                            Particella_Toponomastica_1__c, Particella_Toponomastica_2__c, Particella_Toponomastica_3__c,
                            PO_Nota_sito__c,EOF_STATO_ORDINE__c, OF_Id_Comune__c,Caso__r.ParentId,PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
                            
                            PO_P2PAttiva_Opzione__c,COS5_PIR__c, COS5_CIR__c, COS3_PIR__c, 
                            COS3_CIR__c, COS1_PIR__c, COS1_CIR__c, OF_SA_MODELLO_DI_SERVIZIO_VLAN__c, 
                            PO_PP_User_VLAN__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, 
                            PO_PP_cos_class__c, ID_Sede__c, RecordType.DeveloperName
                            
                            from EOF_EAI_Service_Log__c 
                            where caso__c IN : ColP2PAtt 
                            and (recordtype.developername ='P2P_Attiva_Collegamento' OR recordtype.developername ='P2P_Attiva_Collegamento_ELine')]; //EC 2019 05 22 inseriti nuovi campi nella query: nelle ultime righe separate i campi inseriti nella query                            
          
               CaseKit = [select id, PO_P2PAttiva_Kit_Indirizzo_Consegna__c, PO_P2PAttiva_KIT_OpticalRateLimiting__c,
               					PO_PP_NomeKit__c, EOF_Identificativo_del_POP__c, PO_case_Collegamento__c 
               					from case 
               					where PO_case_Collegamento__c IN : ColP2PAtt 
               					and recordtype.developername ='PO_Case_P2P_Attiva_KIT'];             
                
               if(!CollLog.IsEmpty()){             
               system.debug('Lista di Log collegamento contiene:'+ CollLog.size());
               system.debug('@@@@EC il recordtype del coll è: ' + CollLog.get(0).RecordType.DeveloperName );
               }
               
                if(CollLog.size()>0){

                    if(CollLog.get(0).RecordType.DeveloperName =='P2P_Attiva_Collegamento'){
                           VlanLogs = [select id,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_PROFILO_VLAN__c, 
                    			OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c, EOF_SL_Riferimento__c, 
                    			EOF_SL_Riferimento__r.Caso__r.Casenumber,PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
                                PO_P2PAttiva_Kit_Consegna_VLan__c, PO_P2PAttiva_Nome_del_KIT__c, 
                                PO_P2PAttiva_Optical_Rate_Limiting__c,ID_Sede__c,EOF_PROFILO__c,PO_P2PAttiva_Opzione__c,
                                PO_PP_cos_class__c, EOF_SL_Riferimento__r.Caso__r.EOF_Codice_Ordine_OLO__c,
                                EOF_SL_Riferimento__r.ID_Sede__c //EC 2019 06 05 aggiunti alla query campi  EOF_SL_Riferimento__r.Caso__r.EOF_Codice_Ordine_OLO__c e EOF_SL_Riferimento__r.ID_Sede__c
                                from eof_eai_service_log__c 
                                where recordtype.developername ='OF_SA_Vlan' 
                                AND EOF_SL_Riferimento__c IN : CollLog];   //EC 2019 05 22 aggiunti nella query i campi PO_P2PAttiva_Optical_Rate_Limiting__c, ID_Sede__c, EOF_PROFILO__c, PO_P2PAttiva_Opzione__c, PO_PP_cos_class__c
                        
                        system.debug('lista di Vlan contiene:'+ VlanLogs);
                    }
                    else{
                        VlanLogs = [select id,OF_SA_KIT_CONSEGNA_VLAN__c,OF_SA_CUSTOMER_VLAN__c,OF_SA_PROFILO_VLAN__c, 
                                    OF_SA_MODELLO_DI_SERVIZIO_VLAN__c,OF_SA_INFORMAZIONI_VLAN__c, EOF_SL_Riferimento__c, 
                                    EOF_SL_Riferimento__r.Caso__r.Casenumber,PO_P2PAttiva_KIT_Indirizzo_Consegna__c,
                                    PO_P2PAttiva_Kit_Consegna_VLan__c, PO_P2PAttiva_Nome_del_KIT__c, 
                                    PO_P2PAttiva_Optical_Rate_Limiting__c,ID_Sede__c,EOF_PROFILO__c,PO_P2PAttiva_Opzione__c,
                                    PO_PP_cos_class__c, EOF_SL_Riferimento__r.Caso__r.EOF_Codice_Ordine_OLO__c,
                                    EOF_SL_Riferimento__r.ID_Sede__c //EC 2019 06 05 aggiunti alla query campi  EOF_SL_Riferimento__r.Caso__r.EOF_Codice_Ordine_OLO__c e EOF_SL_Riferimento__r.ID_Sede__c
                                    from eof_eai_service_log__c 
                                    where recordtype.developername ='OF_SA_Vlan_ELine' 
                                    AND EOF_SL_Riferimento__c IN : CollLog];   //EC 2019 05 22 aggiunti nella query i campi PO_P2PAttiva_Optical_Rate_Limiting__c, ID_Sede__c, EOF_PROFILO__c, PO_P2PAttiva_Opzione__c, PO_PP_cos_class__c
                        
                    }
                 
                                    
                
                }               
                       
        }        
        // 2018-09-24 MM : fine aggiunta
               
        system.debug('DG_PDF_q: ' + q);

        checkAltriAnni = true;
        //CRM 24_08 INIZIO
        FindAnnoFiberLink();
        //FINE
       
        opp = getOpportunity();
        system.debug('DG_PDF_opp: ' + opp);
        
        
        //finalstr = 'Ns. Rif.:' + opp.PO_Richiesta_fattibilit__r.casenumber + '<br/>' + 'Dettagli Collegamento e Offerta';
        //nsRifString = getNsRif(RichiestaFattibil, checkP2P, checkFibLink, checkBackhauling, checkBTS, checkDarkFiber);
        nsRifString = getNsRif(checkP2P, checkFibLink, checkBackhauling, checkBTS, checkDarkFiber,checkP2PAtt,checkP2PAttELine);        //EC 2019 06 14 aggiunti controlli su p2pAttiva e p2pAttivaEline
        finalstr = 'Ns. Rif.:' + nsRifString + '<br/>' + 'Dettagli Collegamento e Offerta';
        
        /**PRIMA TABELLA**/
            
        string str;
        //Fiber Link
        if(checkFibLink == true)
            str = Tabella1FiberLink(opp);
        //P2P
        if(checkP2P == true)
            str = Tabella1P2P(opp);
        //IRU
        if(checkIRU || checkBTS || checkBackhauling || checkDarkFiber)
            str = Tabella1IRU(opp);
        //Fiber Lease
        if(checkFibLease == true)
            str = Tabella1FiberLease(opp);
        //Fiber Lease Misto
        if(checkFibLeaseMisto == true)
            str = Tabella1FiberLeaseMisto(opp);
        //Evento Temporaneo
        if(checkEventoTemp == true)
            str = Tabella1P2P(opp);
        
        
        // 2018-09-24 MM : aggiunto check su P2P Attiva
        if(checkP2PAtt == true){
            str = Tabella1P2PAtt(opp);
        }
        //EC 2019 06 10 start P2PAttiva E-Line
        if(checkP2PAttELine == true){
            str = Tabella1P2PAttELine(opp);
        }
        //EC 2019 06 10 end P2PAttiva E-Line
        system.debug('DG_OF_CreateQuoteXLS_Controller str: ' + str);
        finalstr = finalstr + str ;
        
        /**END PRIMA TABELLA**/
        
         /**MESSAGGI**/    
        if(str == null)
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
        string str1 = '<br/><br/>Dati toponomastici<br/>' + TabellaDatiToponomastici(opp);
        system.debug('DG_OF_CreateQuoteXLS_Controller str1: ' + str1);
        finalstr = finalstr + str1;
        /**END TABELLA DATI TOPONOMASTICI**/
        
        
        /**TABELLA DATI METRICI**/
        string str2 = '<br/>Dati metrici<br/>' + TabellaDatiMetrici(opp);
        finalstr = finalstr + str2;
        /**END TABELLA DATI METRICI**/
        
        
        /**TABELLA DETTAGLIO OFFERTA**/
        if(!checkFibLease && !checkFibLeaseMisto)
        {
            string str3 = '<br/>Dettaglio offerta<br/>' + TabellaDettaglioOfferta(opp);
            finalstr = finalstr + str3;
        }
        /**END TABELLA DETTAGLIO OFFERTA**/
        
        system.debug('DG_OF_CreateQuoteXLS_Controller finalstr: ' + finalstr);
        xlsxBlob = Blob.valueOf(finalstr);
        xlsxname= q.Name + '.xls';
                
    }
    
    public Opportunity getOpportunity()
    {   
        
        opportunity opp = [select id, name, recordtype.name, RecordType.Developername, PO_Numero_Anni__c, PO_Richiesta_fattibilit__r.casenumber,PO_Richiesta_fattibilit__r.PO_Nome_Progetto__c,
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
                                     
                                        PO_Collegamento__r.Particella_Toponomastica_1__c, PO_Collegamento__r.Particella_Toponomastica_2__c, PO_Collegamento__r.Particella_Toponomastica_3__c,
                                     
                                        PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c,
                                        PO_Collegamento__r.EOF_Codice_Ordine_OLO__c,PO_Collegamento__r.SF_Ccoll_ID_Sede__c,PO_Collegamento__r.Tipologia_Sede__c, //EC 2019 05 22 aggiunti questi ultimi due campi alla query
                                    	PO_Collegamento__r.SF_Ccoll_ID_Sede_Master__c, PO_Collegamento__r.ID_Sede_Master__r.SF_Ccoll_ID_Sede__c //EC 2019 06 17 aggiunto campo di lookup
                                    from Opportunities__r   // DN modificato PO_Collegamento__r.ID_Sede_Master__c con PO_Collegamento__r.ID_Sede_Master__r.SF_Ccoll_ID_Sede__c 
                                    where PO_Incluso_nell_offerta__c = true) 
                           from Opportunity
                           where id =: q.OpportunityId];
        system.debug('DG_PDF_getOpportunity opp: ' + opp);
       
        //TotPrezzi(opp);
        
        FindOppo(opp);
        
        return opp;
    }
    
    public date getdate()
    {
        return system.today();
    }
    
    public void FindOppo(opportunity opp)
    {
        checkIRU = false;
        checkP2P = false;
        checkFibLink = false;
        checkFibLease = false;
        checkEventoTemp = false;
        checkFibLeaseMisto = false;
        checkP2PAtt = false; 
        checkDarkFiber = false;
        checkBackhauling = false;
        checkBTS = false;
        checkP2PAttELine=false; //EC 2019 06 10
        if(CollLog.size()>0){
            if(!Test.isRunningTest()){
                if(CollLog[0].recordtype.developername == 'P2P_Attiva_Collegamento_ELine'){
                    checkP2PAttELine = true;
                }
            }
        }
        if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità IRU')
        {
            checkIRU = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Backhauling')
        {
            checkBackhauling = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità BTS')
        {
            checkBTS = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità P2PBase')
        {
            checkP2P = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità DarkFiber')
        {
            checkDarkFiber = true;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Fiber Link')
        {
            checkFibLink = true;
            
            if(opp.PO_Numero_Anni__c != null)
                CheckNumAnni = true;
            else
                CheckNumAnni = false;
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Evento Temporaneo')
        {
            checkEventoTemp = true;
            if(opp.PO_Richiesta_fattibilit__r.PO_Durata_mesi__c == 1)
                strMese = 'mese';
            else
                strMese = 'mesi';
        }else if(opp.RecordType.name == 'PO Oppty Richiesta fattibilità Fiber Lease')
        {
            system.debug('OF_PDF_OffSediController_FindOppo dentro fiber lease');
            checkFibLease = true;
        }else if(opp.RecordType.name == 'PO Oppty richiesta fattibilità Misto Lease-Link per FW')
        {
            system.debug('OF_PDF_OffSediController_FindOppo dentro fiber lease misto');
            checkFibLeaseMisto = true;
        }else if(opp.RecordType.Developername =='PO_Oppty_Richiesta_fattibilit_P2P_Attiva' && !checkP2PAttELine){
            checkP2PAtt = true;
        }
        else if(opp.RecordType.Developername =='PO_Oppty_Richiesta_fattibilit_P2P_AttivaELine'){
        	checkP2PAttELine=true;
        }
    }
    //CRM 24_08 INIZIO
    public void FindAnnoFiberLink()
    {
           check1Anno = false;
           check2Anni = false;
           check3Anni = false;
           checkAltriAnni = false;
           
           
           if( q.PO_Durata_affitto__c > 3 )
           {
               checkAltriAnni = true;
           }else{
              
               if( q.PO_Durata_affitto__c == 1 )
               {
                   check1Anno = true;
               }else if( q.PO_Durata_affitto__c == 2 )
               {
                   check2Anni = true;
               }else if( q.PO_Durata_affitto__c == 3 )
               {
                   check3Anni = true;
               }
           } 
         system.debug('FindAnnoFiberLink check1Anno:'+check1Anno+'-check2Anni:'+check2Anni+'-check3Anni:'+check3Anni+'-checkAltriAnni:'+checkAltriAnni);
                   
    }
    //FINE
    
    /**Bottoni*/
    public PageReference savePDF() { 
        PageReference thePDF = Page.OF_PDF_OffSedi;
        thePDF.getParameters().put('id',q.Id);
        thePDF.setRedirect(true);
                
        quotedocument qd = new quotedocument();
        if( Test.isRunningTest())
        {
            qd.document = blob.toPdf('test');
        }else{
            qd.document = thePDF.getContentAsPDF();
        }
        qd.quoteId = q.Id;
        insert qd;
        
        if(q.PO_ContaPDF__c == null)
            q.PO_ContaPDF__c = 0;
        
        q.PO_ContaPDF__c ++;
        update q;
        
        //Modifico il file aggiungendo nel title l'estensione .pdf
        ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
        //ContDoc.Title = ContDoc.Title + '.pdf';
        ContDoc.Title = q.name + ' _ ' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '_' + q.PO_ContaPDF__c + '.pdf';
        update ContDoc;        
        
        NameAttachmentXLSX = q.name + ' _ ' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '_' + q.PO_ContaPDF__c + '.xlsx';
        
        PageReference quotePage = new PageReference('/'+ q.Id);
        quotePage.setRedirect(true);
        return null;
    }
    
    public PageReference ToReturn() {
        PageReference quotePage = new PageReference('/'+ q.Id);
        quotePage.setRedirect(true);
        return quotePage;
    }
    
    //CRM 24/08/2017 INIZIO
    public PageReference savePDF_FiberLink()
    {
        PageReference thePDF = Page.OF_PDF_FiberLink;
        thePDF.getParameters().put('id',q.Id);
        thePDF.setRedirect(true);
        
        quotedocument qd = new quotedocument();

        if( Test.isRunningTest())
        {
            qd.document = blob.toPdf('test');
        }else{
            qd.document = thePDF.getContentAsPDF();
        }        
        //qd.document = thePDF.getContentAsPDF();
        qd.quoteId = q.Id;
        insert qd;
        
        //Modifico il file aggiungendo nel title l'estensione .pdf
        ContentDocument ContDoc = [select id,title,FileExtension,FileType,createddate from ContentDocument order by createddate desc limit 1];
        //ContDoc.Title = ContDoc.Title + '.pdf';
        ContDoc.Title = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.pdf';
        update ContDoc;      
        
        NameAttachmentXLSX = q.name + '_Finale_' + system.today().day() + '_' + system.today().month() + '_' + system.today().year() + '.xlsx';
        
        PageReference quotePage = new PageReference('/'+ q.Id);
        quotePage.setRedirect(true);
        return quotePage;

    }
    //24/08/2017 FINE
    /**END Bottoni**/
    
    /**Parte di XLSX**/
    //Tabella dell'offerta totale della fiber link
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
    //Tabella dell'offerta totale dell'IRU
    public string Tabella1IRU(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Canone Manutenzione Annuo' + '\t' + opp.PO_Totale_canoni_manutenzione_scontato__c + '<br/>' 
                    + 'Corrispettivi IRU' + '\t' + opp.PO_Totale_corrispettivi_IRU_scontati__c + '<br/>'
                    + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
                    + 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';
                
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dell'offerta totale della P2P e Evento Temporaneo
    public string Tabella1P2P(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>' 
                     + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
                     + 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';
                
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1P2P 2 bod: ' + bod);
        
        return bod;
    }
    
    // 2018-09-24 MM : Aggiunta tabella dell'offerta totale per P2P Attiva
    public string Tabella1P2PAtt(opportunity opp)
    {
        system.debug('MM_OF_CreateQuoteXLS_Controller_Tabella1P2PAtt 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>' 
                     + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
                     + 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';
                
        system.debug('MM_OF_CreateQuoteXLS_Controller_Tabella1P2PAtt 2 bod: ' + bod);
        
        return bod;
    } 
    //EC 2019 06 10 Start Tabella1P2PAttELine
    public String Tabella1P2PAttELine(Opportunity opp){
    	system.debug('MM_OF_CreateQuoteXLS_Controller_Tabella1P2PAtt 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>' 
                     + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>'
                     + 'Costi Aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>';
                
        system.debug('MM_OF_CreateQuoteXLS_Controller_Tabella1P2PAtt 2 bod: ' + bod);
        
        return bod;
    
    }
    //EC 2019 06 10 end Tabella1P2PAttELine   
    
    //Tabella dell'offerta totale della Fiber Lease
    public string Tabella1FiberLease(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Totale costi aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>' 
                     + 'Totale valori medi altre coppie' + '\t' + opp.PO_Totale_scontat_valori_medi_altre_cop__c + '<br/>'
                     + 'Totale valori medi annui' + '\t' + opp.PO_Totale_valori_medi_annui_scontato__c + '<br/>'
                     + 'Totale valori fino 2030' + '\t' + opp.PO_Totale_valori_fino_2030_scontato__c + '<br/>';
                
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dell'offerta totale della Fiber Lease Misto
    public string Tabella1FiberLeaseMisto(opportunity opp)
    {
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 1 bod: ' + bod);
        
        header = 'Tipologia costo\tCosto <br/>';
        bod = header + 'Totale costi aggiuntivi' + '\t' + opp.PO_Totale_costi_aggiuntivi_scontati__c + '<br/>' 
                     + 'Totale valori medi altre coppie' + '\t' + opp.PO_Totale_scontat_valori_medi_altre_cop__c + '<br/>'
                     + 'Totale valori medi annui' + '\t' + opp.PO_Totale_valori_medi_annui_scontato__c + '<br/>'
                     + 'Totale valori fino 2030' + '\t' + opp.PO_Totale_valori_fino_2030_scontato__c + '<br/>'
                     + 'Canone Annuo' + '\t' + opp.PO_Totale_canoni_scontato__c + '<br/>' 
                     + 'Contributo di attivazione' + '\t' + opp.PO_Totale_contributi_attivazione_scontat__c + '<br/>';
                
        system.debug('DG_OF_CreateQuoteXLS_Controller_Tabella1IRU 2 bod: ' + bod);
        
        return bod;
    }
    //Tabella dati toponomastici dei collegamenti
    public string TabellaDatiToponomastici(opportunity opp)
    {
        bod = null;
        header = null;
        list<opportunity> OppCollList = opp.Opportunities__r;
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        // 2018-09-24 MM : aggiunto check su P2P Attiva
        if(checkP2P || checkEventoTemp)//EC 2019 05 22 Start Commento P2PAttiva fase 2 nuovo format PDF eAccess ed eLine || checkP2PAtt)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente <br/>';
        }
        //EC 2019 05 22 Start P2PAttiva fase 2 nuovo format PDF eAccess ed eLine
        else if(checkP2PAtt){
        	 header = 'Collegamento\tID Sede\tTipologia\tSede Cliente\tIndirizzo Cliente <br/>';
        	// header = 'Collegamento\tID Sede\tSede Cliente\tIndirizzo Cliente\tSede 1 di Terminazione\tIndirizzo Sede 1 di terminazione <br/>';
        }
        //EC 2019 05 22 end P2PAttiva fase 2 nuovo format PDF eAccess ed eLine
        else if(checkP2PAttELine){
        	header = 'Collegamento\tID Sede\tTipologia\tSede Cliente\tIndirizzo Cliente <br/>';
	        // header = 'Collegamento\tID Sede\tSede Cliente\tIndirizzo Cliente\tSede 1 di Terminazione\tIndirizzo Sede 1 di terminazione <br/>';
        }
        else
            if(checkFibLink)
            {
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione\tSede 2 di terminazione\tIndirizzo Sede 2 di terminazione <br/>';
            }else
            {
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tSede 1 di terminazione\tIndirizzo Sede 1 di terminazione <br/>';
            }
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;
            
            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' + 
                                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' + 
                                OppCol.PO_Collegamento__r.Particella_Toponomastica_1__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c;

            // 2018-09-24 MM : aggiunto check su P2P Attiva            
            if(checkP2P || checkEventoTemp) //EC 2019 05 22 Start commento P2PAttiva fase 2 nuovo format PDF eAccess ed eLine || checkP2PAtt)
            {
                StringTopon =   StringTopon + '<br/>';
            }
            //EC 2019 05 22 Start P2PAttiva fase 2 nuovo format PDF eAccess ed eLine
            else if(checkP2PAtt){
            	StringTopon = OppCol.PO_Collegamento__r.EOF_Codice_Ordine_OLO__c + '\t' + //EC 2019 06 10 -> EOF_Codice_Ordine_OLO__c al posto di casenumber
            					OppCol.PO_Collegamento__r.SF_Ccoll_ID_Sede__c + '\t' + //EC inserimento campi p2pAttiva fase2 
            				    OppCol.PO_Collegamento__r.Tipologia_Sede__c + '\t' + //EC inserimento campi p2pAttiva fase2 
                                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' + 
                                OppCol.PO_Collegamento__r.Particella_Toponomastica_1__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c
                                 + '<br/>';

            }
            //EC 2019 05 22 end P2PAttiva fase 2 nuovo format PDF eAccess ed eLine
            
            else
                if(checkFibLink)
                {
                    StringTopon =   StringTopon + '\t' + 
                                    OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' + 
                                    OppCol.PO_Collegamento__r.Particella_Toponomastica_2__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' + 
                                    OppCol.PO_Collegamento__r.PO_Sito_3__c + '\t' +
                                    OppCol.PO_Collegamento__r.Particella_Toponomastica_3__c + ' ' + OppCol.PO_Collegamento__r.PO_indirizzo_collegamento_3__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_3__c + ',' + OppCol.PO_Collegamento__r.PO_Nome_Comune4__c + 
                                    '<br/>';
                }else
                {
                    StringTopon =   StringTopon + '\t' + 
                                    OppCol.PO_Collegamento__r.PO_Sito_partenza__c + '\t' + 
                                    OppCol.PO_Collegamento__r.Particella_Toponomastica_3__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico_partenza__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune3__c + '\t' + 
                                    '<br/>';
                }
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
        
        system.debug('DG_OF_CreateQuoteXLS_Controller_TabellaDatiMetrici header: ' + header);

        // 2018-09-24 MM : aggiunto check su P2P Attiva
        
        if(checkP2P ||checkEventoTemp)//EC 2019 05 22 commentiamo per diverso pdf per nuovo format P2PAttiva fase2 eAccess e eLine || checkP2PAtt)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tPop 1 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';

        }
        //EC 2019 05 22 Start P2PAttiva fase 2 nuovo format PDF eAccess 
        else if(checkP2PAtt){
			header = 'Collegamento\tID Sede\tTipologia\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tPop 1 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';        
        }        
        ////EC 2019 05 22 end P2PAttiva fase 2 nuovo format PDF eAccess 
        
        //EC 2019 06 10 start P2P Attiva eLine ID Sede Master e POP 1 di riferimento richiesti a voce
         else if(checkP2PAttELine){
			header = 'Collegamento\tID Sede\tID Sede Master\tTipologia\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tN. Fibre Ottiche\tLunghezza 1° via\tPop 1 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';        
        }  
        //EC 2019 06 10 end P2P Attiva eLine
        
        else if(checkFibLink || checkIRU)
            {
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
            }else
                if(checkFibLease || checkFibLeaseMisto)
                {
                    header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tTipo percorso\tn. Fibre Ottiche\tLunghezza 1° via\tLunghezza 2° via\tPop 1 di riferimento\tPop 2 di riferimento\tTempi (mesi da ordine)\tDisponibilita rete dal <br/>';
                }
        
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;
            
            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' + 
                            OppCol.PO_Collegamento__r.PO_Sito__c + '\t' + 
                            OppCol.PO_Collegamento__r.Particella_Toponomastica_1__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t' + 
                            OppCol.PO_Collegamento__r.PO_Tipo_percorso__c + '\t' + 
                            OppCol.PO_Collegamento__r.PO_Numero_fibre_richieste__c + '\t';

            // 2018-09-24 MM : aggiunto check su P2P Attiva
            
            if(checkP2P ||checkEventoTemp)//EC 2019 05 22 Start commento P2PAttiva fase 2 nuovo format PDF eAccess ed eLine commento || checkP2PAtt)
            {
                StringTopon +=   //StringTopon + 
                                OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
                                OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' + 
                                OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' + 
                                string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) + 
                                '<br/>';
            }
            //EC 2019 05 22 Start P2PAttiva fase 2 nuovo format PDF eAccess ed eLine
            else if(checkP2PAtt){
            	//EC 2019 05 22 StringTopon la settiamo daccapo perché non solo aumentano le colonne ma si inserisco nel mezzo
            	StringTopon =   OppCol.PO_Collegamento__r.EOF_Codice_Ordine_OLO__c + '\t' + 
            					OppCol.PO_Collegamento__r.SF_Ccoll_ID_Sede__c + '\t' + 
            				    OppCol.PO_Collegamento__r.Tipologia_Sede__c + '\t' +
            					OppCol.PO_Collegamento__r.PO_Sito__c + '\t' + 
                           		OppCol.PO_Collegamento__r.Particella_Toponomastica_1__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t' + 
                            	OppCol.PO_Collegamento__r.PO_Tipo_percorso__c + '\t' + 
                            	OppCol.PO_Collegamento__r.PO_Numero_fibre_richieste__c + '\t' +
                            	OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
                                OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' + 
                                OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' + 
                                string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) + 
                                '<br/>';
            }
            //EC 2019 05 22 end P2PAttiva fase 2 nuovo format PDF eAccess ed eLine
            else
                if(checkFibLink || checkIRU)
                {
                    
                    StringTopon =   StringTopon + 
                                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via__c + '\t' +
                                    OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via__c + '\t' + 
                                    OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' + 
                                    string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) + 
                                    '<br/>';
                }else
                    if(checkFibLease || checkFibLeaseMisto)
                    {
                        StringTopon =   StringTopon + 
                                        OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_prima_via_FiberLink__c + '\t' +
                                        OppCol.PO_Collegamento__r.PO_Lunghezza_tratta_seconda_via_FiberLin__c + '\t' +
                                        OppCol.PO_Collegamento__r.PO_Pop_1_di_riferimento2__r.name + '\t' + 
                                        OppCol.PO_Collegamento__r.PO_Pop_2_di_riferimento2__r.name + '\t' + 
                                        OppCol.PO_Collegamento__r.PO_Tempi_di_attivazione_mesi__c + '\t' + 
                                        string.valueof(OppCol.PO_Collegamento__r.PO_Disponibilit_della_rete_a_partire_da__c) + 
                                        '<br/>';
                    }
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
        
        // 2018-09-24 MM : aggiunto check su P2P Attiva
                    
        if(checkP2P ||checkEventoTemp) //EC 2019 05 22 Start commento P2PAttiva fase 2 nuovo format PDF eAccess ed eLine || checkP2PAtt)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone (euro) Anno\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
        }
        else if(checkP2PAtt){
        	header = 'Collegamento\tID Sede\tTipologia\tSede Cliente\tIndirizzo Cliente\tCanone (euro) Anno\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
        }
        //EC 2019 06 14 Start P2PAttiva fase 2 nuovo format PDF eLine sezione Dettaglio Offerta
         else if(checkP2PAttELine){
        	header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone (euro) Anno\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
        }
        //EC 2019 06 14 end P2PAttiva fase 2 nuovo format PDF eLine sezione Dettaglio Offerta
        else
            if(checkIRU)
        {
            header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone Manutenzione (euro) Anno\tCorrispettivo IRU (euro)\tContributo Attivazione (euro)\tCosti Aggiuntivi (euro) <br/>';
        }else
            if(checkFibLink)
        {
            if(CheckNumAnni == true)
            {
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
                    'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
                    'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo di attivazione 3 anni (euro)\t'+
                    'Canone affitto '+opp.PO_Numero_Anni__c+' anni (euro/anno)\tContributo di attivazione '+opp.PO_Numero_Anni__c+' anni (euro)\tContributo aggi. '+opp.PO_Numero_Anni__c+' anni (euro)<br/>';
        
            }
            else{
                header = 'Collegamento\tSede Cliente\tIndirizzo Cliente\tCanone affitto 1 anno (euro/anno)\tContributo di attivazione 1 anno (euro)\tContributo aggi. 1 anno (euro)\t'+
                    'Canone affitto 2 anni (euro/anno)\tContributo di attivazione 2 anni (euro)\tContributo aggi. 2 anni (euro)\t'+
                    'Canone affitto 3 anni (euro/anno)\tContributo di attivazione 3 anni (euro)\tContributo di attivazione 3 anni (euro)<br/>';        
            }
        }
        system.debug('DG_OF_CreateQuoteXLS_Controller header: ' + header);
        
        //Ciclo sulle opportunity collegamento
        for(opportunity OppCol : OppCollList)
        {
            string StringTopon = null;
            
            StringTopon =   OppCol.PO_Collegamento__r.casenumber + '\t' + 
                OppCol.PO_Collegamento__r.PO_Sito__c + '\t' + 
                OppCol.PO_Collegamento__r.Particella_Toponomastica_1__c + ' ' + OppCol.PO_Collegamento__r.PO_Indirizzo_collegamento__c + ' ' + OppCol.PO_Collegamento__r.PO_Civico__c + ' ' + OppCol.PO_Collegamento__r.PO_Nome_Comune__c + '\t'; 

            // 2018-09-24 MM : aggiunto check su P2P Attiva
            
            if(checkP2P ||checkEventoTemp || checkP2PAtt)
            {
                StringTopon =   StringTopon + 
                    OppCol.PO_CanoneCollegamentoScontato__c + '\t' + 
                    OppCol.PO_ContributoAttivazCollegamScontato__c + '\t' + 
                    OppCol.PO_Costi_aggiuntivi_collegamento_scontat__c + 
                    '<br/>';
            }else
                if(checkFibLink)
            {
                if(CheckNumAnni == true)    
                {
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
                }else{
                    StringTopon =   StringTopon + 
                        OppCol.PO_Canone_annuo_Collegamento1anno_Scont2__c + '\t' + 
                        OppCol.PO_Contributo_annuo_Colleg1anno_Scontat2__c + '\t' + 
                        OppCol.PO_Costi_Aggiuntivi_Anno1_Scontati__c + '\t' + 
                        OppCol.PO_Canone_annuo_Collegamento2anno_Scont2__c + '\t' + 
                        OppCol.PO_Contributo_annuo_Colleg2anni_Scontat2__c + '\t' + 
                        OppCol.PO_Costi_Aggiuntivi_Anno2_Scontati__c + '\t' + 
                        OppCol.PO_Canone_annuo_Collegamento3anno_Scont2__c + '\t' + 
                        OppCol.PO_Contributo_annuo_Colleg3anni_Scontat2__c + '\t' + 
                        OppCol.PO_Costi_Aggiuntivi_Anno3_Scontati__c +
                        '<br/>';
                }
            }else
                if(checkIRU)
            {
                StringTopon =   StringTopon + 
                    OppCol.PO_CanoneManutenzioneCollegScontato__c + '\t' + 
                    OppCol.PO_CorrispettivoIRUCollegamentoScontato__c + '\t' + 
                    OppCol.PO_ContributoAttivazCollegamScontato__c + '\t' + 
                    OppCol.PO_Costi_aggiuntivi_collegamento_scontat__c + 
                    '<br/>';
            }
            if(bod == null)
                bod = StringTopon;
            else
                bod = bod + StringTopon;
            
        }
        return header + bod;
    }
    
    /*
    //Prendo ns_rif dagli ordini
    private String getNsRif(Id caseCollegamentoId, boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber)
    {
        List<Case> orders;
        String theNsRif = '';
        
        if(caseCollegamentoId == null)
            return theNsRif;

        if (isP2P)
        {
			orders = [SELECT id FROM Case WHERE PO_Case_Collegamento__c = :caseCollegamentoId AND RecordType.DeveloperName = 'PO_Ordine_P2P'];
        }
        else if(isFiberLink)
        {
			orders = [SELECT id FROM Case WHERE PO_Case_Collegamento__c = :caseCollegamentoId AND RecordType.DeveloperName = 'PO_Ordine_Fiber_Link'];           
        } 
        else if(isBackhauling)
        {
			orders = [SELECT id FROM Case WHERE PO_Case_Collegamento__c = :caseCollegamentoId AND RecordType.DeveloperName = 'PO_Ordine_Backhauling'];           
        } 
        else if(isBTS)
        {
			orders = [SELECT id FROM Case WHERE PO_Case_Collegamento__c = :caseCollegamentoId AND RecordType.DeveloperName = 'PO_Ordine_BTS'];
        } 
        else if(isDarkFiber)
        {
			orders = [SELECT id FROM Case WHERE PO_Case_Collegamento__c = :caseCollegamentoId AND RecordType.DeveloperName = 'PO_Ordine_DarkFiber'];
        } 
        
        if(orders != null && orders.size() > 0)
        {
            if(orders[0].NS_Rif__c != null)
            {
            	theNsRif = orders[0].NS_Rif__c;
            }
        } 

        return theNsRif;         
    }
    */
    
    //prendo ns_rif dal contratto
  @TestVisible  private String getNsRif(boolean isP2P, boolean isFiberLink, boolean isBackhauling, boolean isBTS, boolean isDarkFiber,boolean isP2PAttiva, boolean isP2PAttivaEline)
    {
        String theNsRif = '';
        String theService;
        Id theAccountId = q.Account.Id;
        
        if (isP2P)
        {
            theService = 'P2P Base';			
        }
        else if(isFiberLink)
        {
            theService = 'Fiber Link';				
        } 
        else if(isBackhauling)
        {
            theService = 'Backhauling';					
        } 
        else if(isBTS)
        {
            theService = 'BTS';				
        } 
        else if(isDarkFiber)
        {
            theService = 'Dark Fiber';					
        } 
        else if(isP2PAttiva||isP2PAttivaELine){
        	 theService = 'P2P Attiva';			
        }        
        
        List<OF_Servizio__c> servizi = [SELECT Id, Name FROM OF_Servizio__c WHERE Name = :theService];
        Id idServizio;
        if(servizi != null && servizi.size() > 0)
        {
            idServizio = servizi[0].Id;
        }
        
        Contract contratto;
        Date oggi = Date.Today();
        List<Contract> contratti = [SELECT Id, StartDate, EndDate, NS_Rif__c, OF_IdContratto__c, (SELECT Id, Name, OF_Servizio__c FROM Contratti_Servizi__r) FROM Contract where 
                                    AccountId = :theAccountId AND
                                    Status = 'Attivo' AND
                                    StartDate <= :oggi AND
                                    EndDate >= :oggi];
        
        system.debug('contratti attivi: ' + contratti);
        
        if(contratti != null && contratti.size() > 0) 
        {
            for(Contract c : contratti)
            {
                system.debug('c.Contratti_Servizi__r: ' + c.Contratti_Servizi__r);
                for(OF_ContrattoServizio__c serv : c.Contratti_Servizi__r)
                {
                    if(serv.OF_Servizio__c == idServizio) 
                    {
                        contratto = c;
                    }
                }
            }        
        }
                
        if(contratto != null)
        {
        	theNsRif = contratto.NS_Rif__c;
        }
        
        return theNsRif;
    }
}