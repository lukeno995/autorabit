@isTest
public class CQS_Util_Test
{
    static testmethod void Method1() {
        
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'Sì';  
        cqs.CQS_ISP_POS__c = 'Sì';       
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'Sì';    
        cqs.CQS_ISP_DURC_regolare__c ='Sì';
        cqs.CQS_ISP_Attivita_Imprese_autorizzate_OF__c = 'Sì';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'No';     
        cqs.CQS_ISP_Presenza_prog_cartografie_enti__c = 'No';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'Sì';
        
        cqs.CQS_ISP_Accantieramento_conforme__c ='No';
        cqs.CQS_ISP_Esposizione_Cartello__c ='No';
        cqs.CQS_ISP_RispettoCodice_SegnaleticaStrada__c ='No';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c ='No';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c ='No';
        cqs.CQS_ISP_assicurata_viabilita__c ='No';
        cqs.CQS_ISP_Passaggi_su_scavi_idonei__c ='No';
        cqs.CQS_ISP_Pozzetti_non_pericolosi__c ='No';   
        cqs.CQS_ISP_Presenza_WC__c ='No';
        
        cqs.CQS_ISP_Presenti_autorizzati__c ='Sì';
        cqs.CQS_ISP_Tesserino_Check__c  ='Sì';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c   ='Sì';
        cqs.CQS_ISP_Addetto_PS_presente__c='Sì';         
        cqs.CQS_ISP_Addetto_Antincendio_presente__c  ='Sì';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c='Sì';         
        cqs.CQS_ISP_DPI_lavorazioni_in_quota__c  ='Sì';
        cqs.CQS_ISP_DPI_rischio_elettrico__c='Sì';           
        cqs.Presenza_Moviere_qualora_necessario__c='Sì';         
        cqs.Personale_dotato_di_quanto_richiesto__c ='Sì';
        
        cqs.CQS_ISP_Mezzi_Attrezzature_autorizati__c='No';  
        cqs.CQS_ISP_conformita_mezzi_attrezzature__c='No';  
        cqs.CQS_ISP_Documentazione_verifiche_legge__c='No'; 
        cqs.CQS_ISP_Marcatura_CE__c='No';   
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c ='No';
        cqs.CQS_ISP_attrezzature_sollevamento__c='No';
        
        cqs.Cassetta_primo_soccorso_conforme__c ='No';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c ='No';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c='Sì' ;
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c='No';      
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='N/A';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
    }
    static testmethod void Method2(){
        
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'No';  
        cqs.CQS_ISP_POS__c = 'No';       
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'No';    
        cqs.CQS_ISP_DURC_regolare__c ='No';
        cqs.CQS_ISP_Attivita_Imprese_autorizzate_OF__c = 'No';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'Sì';     
        cqs.CQS_ISP_Presenza_prog_cartografie_enti__c = 'Sì';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'No';
        
        cqs.CQS_ISP_Accantieramento_conforme__c ='Sì';
        cqs.CQS_ISP_Esposizione_Cartello__c ='Sì';
        cqs.CQS_ISP_RispettoCodice_SegnaleticaStrada__c ='Sì';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c ='Sì';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c ='Sì';
        cqs.CQS_ISP_assicurata_viabilita__c ='Sì';
        cqs.CQS_ISP_Passaggi_su_scavi_idonei__c ='Sì';
        cqs.CQS_ISP_Pozzetti_non_pericolosi__c ='Sì';   
        cqs.CQS_ISP_Presenza_WC__c ='Sì';
        
        cqs.CQS_ISP_Presenti_autorizzati__c ='No';
        cqs.CQS_ISP_Tesserino_Check__c  ='No';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c   ='No';
        cqs.CQS_ISP_Addetto_PS_presente__c='No';         
        cqs.CQS_ISP_Addetto_Antincendio_presente__c  ='No';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c='No';         
        cqs.CQS_ISP_DPI_lavorazioni_in_quota__c  ='No';
        cqs.CQS_ISP_DPI_rischio_elettrico__c='No';           
        cqs.Presenza_Moviere_qualora_necessario__c='No';         
        cqs.Personale_dotato_di_quanto_richiesto__c ='No';
        
        cqs.CQS_ISP_Mezzi_Attrezzature_autorizati__c='Sì';  
        cqs.CQS_ISP_conformita_mezzi_attrezzature__c='Sì';  
        cqs.CQS_ISP_Documentazione_verifiche_legge__c='Sì'; 
        cqs.CQS_ISP_Marcatura_CE__c='Sì';   
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c ='Sì';
        cqs.CQS_ISP_attrezzature_sollevamento__c='Sì';
        
        cqs.Cassetta_primo_soccorso_conforme__c ='Sì';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c ='Sì';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c='No' ;
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c='Sì';      
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='Sì';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
    }
    static testmethod void Method3(){
        
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'N/A';  
        cqs.CQS_ISP_POS__c = 'N/A';       
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'N/A';    
        cqs.CQS_ISP_DURC_regolare__c ='N/A';
        cqs.CQS_ISP_Attivita_Imprese_autorizzate_OF__c = 'N/A';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'N/A';     
        cqs.CQS_ISP_Presenza_prog_cartografie_enti__c = 'N/A';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'N/A';
        
        cqs.CQS_ISP_Accantieramento_conforme__c ='N/A';
        cqs.CQS_ISP_Esposizione_Cartello__c ='N/A';
        cqs.CQS_ISP_RispettoCodice_SegnaleticaStrada__c ='N/A';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c ='N/A';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c ='N/A';
        cqs.CQS_ISP_assicurata_viabilita__c ='N/A';
        cqs.CQS_ISP_Passaggi_su_scavi_idonei__c ='N/A';
        cqs.CQS_ISP_Pozzetti_non_pericolosi__c ='N/A';   
        cqs.CQS_ISP_Presenza_WC__c ='N/A';
        
        cqs.CQS_ISP_Presenti_autorizzati__c ='N/A';
        cqs.CQS_ISP_Tesserino_Check__c  ='N/A';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c   ='N/A';
        cqs.CQS_ISP_Addetto_PS_presente__c='N/A';         
        cqs.CQS_ISP_Addetto_Antincendio_presente__c  ='N/A';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c='N/A';         
        cqs.CQS_ISP_DPI_lavorazioni_in_quota__c  ='N/A';
        cqs.CQS_ISP_DPI_rischio_elettrico__c='N/A';           
        cqs.Presenza_Moviere_qualora_necessario__c='N/A';         
        cqs.Personale_dotato_di_quanto_richiesto__c ='N/A';
        
        cqs.CQS_ISP_Mezzi_Attrezzature_autorizati__c='N/A';  
        cqs.CQS_ISP_conformita_mezzi_attrezzature__c='N/A';  
        cqs.CQS_ISP_Documentazione_verifiche_legge__c='N/A'; 
        cqs.CQS_ISP_Marcatura_CE__c='N/A';   
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c ='N/A';
        cqs.CQS_ISP_attrezzature_sollevamento__c='N/A';
        
        cqs.Cassetta_primo_soccorso_conforme__c ='N/A';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c ='N/A';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c='N/A' ;
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c='N/A';      
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
        
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'OF_CQS_City_Manager' LIMIT 1];
        User usr = new User();
        usr.Alias = 'standt';
        usr.Email='standarduser@testorg.com';
        usr.EmailEncodingKey='UTF-8';
        usr.LastName='Testing';
        usr.LanguageLocaleKey='en_US'; 
        usr.LocaleSidKey='en_US';
        usr.ProfileId = profileId.id;
        usr.TimeZoneSidKey='America/Los_Angeles';
        usr.UserName=String.valueOf(system.Now()).remove('-').remove(' ').remove(':')+'standarduser9@testorg.com';
        insert usr;
        Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
        projen.CQS_junc_progetto__c = pro.Id;
        projen.CQS_junc_user__c = usr.id;
        insert projen;
        
        OF_CQS_Evento__c even = new OF_CQS_Evento__c();
        even.OF_CQS_Impresa_Mandataria__c = anag.Id;
        even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
        even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
        even.OF_CQS_Data_Evento__c = System.today();
        even.OF_CQS_Rispetto_Procedura__c = 'No';
        even.OF_CQS_Diffida__c  = FALSE;
        even.CQS_Ev_Progetto__c=pro.id;
        //even.Skip_Email__c=true;
        even.OF_CQS_Inadempienze_Operative__c = FALSE;
        even.recordtypeid=RecordTypeIdevent;
        even.OF_CQS_Richiesta_Danni__c  = true;
        insert even;
        
        TEMPLOG__c tem = new TEMPLOG__c();
        tem.Class__c = 'Test';
        insert tem;
        List<Id> evIdList = new List<Id>();
        Map<Id,Id> mapEvProg = new Map<Id,Id>();
        Set<Id> SetProgetti = new Set<Id>(); 
        evIDList.add(even.id);
        mapEvProg.put(even.id,even.CQS_ev_Progetto__c);
        SetProgetti.add(even.CQS_ev_Progetto__c);
        CQS_Utils.inviaMail(evIdList, mapEvProg, setProgetti); 
    }
    static testmethod void Method4(){
        CQS_Utils.wrapperEmail WE=new CQS_Utils.wrapperEmail();
        
    }
    static testmethod void Method5(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'N/A';  
        cqs.CQS_ISP_POS__c = 'N/A';       
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'N/A';    
        cqs.CQS_IspS_Presenza_riferimenti_emergenza__c='N/A';
        cqs.CQS_IspS_Subappalto_autorizzato_OF__c= 'N/A';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'N/A';     
        cqs.CQS_IspS_Presenza_cartografie_enti__c= 'N/A';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'N/A';
        
        cqs.CQS_IspS_Accantieramento_conforme_a_PSC__c ='N/A';
        cqs.CQS_ISP_Esposizione_Cartello__c ='N/A';
        cqs.CQS_IspS_Segnaletica_stradale_suff__c ='N/A';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c ='N/A';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c ='N/A';
        cqs.CQS_IspS_Viabilit_come_ordinanza__c ='N/A';
        cqs.CQS_IspS_Protezione_scavi_in_minitrincea__c ='N/A';
        cqs.CQS_IspS_Protezione_scavi_trad_pozzetti__c ='N/A';   
        cqs.CQS_IspS_Utilizzo_DPC_rischi_particolari__c ='N/A';
        
        cqs.CQS_ISP_Presenti_autorizzati__c ='N/A';
        cqs.CQS_ISP_Tesserino_Check__c  ='N/A';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c   ='N/A';
        cqs.CQS_IspS_Addetto_primo_soccorso_presente__c='N/A';         
        cqs.CQS_ISP_Addetto_Antincendio_presente__c  ='N/A';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c='N/A';         
        cqs.CQS_IspS_DPI_3_categoria_utilizzati_OK__c  ='N/A';
        cqs.CQS_ISP_DPI_rischio_elettrico__c='N/A';           
        cqs.Presenza_Moviere_qualora_necessario__c='N/A';         
        cqs.CQS_IspS_Formazione_HS_conforme_mansione__c ='N/A';
        
        cqs.CQS_IspS_Autorizzati_e_presenti_nel_POS__c='N/A';  
        cqs.CQS_IspS_Sono_in_buono_stato__c='N/A';  
        cqs.CQS_IspS_Libretti_rev_mezzi_presenti__c='N/A'; 
        cqs.CQS_ISP_Marcatura_CE__c='N/A';   
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c ='N/A';
        cqs.CQS_ISP_attrezzature_sollevamento__c='N/A';
        
        cqs.Cassetta_primo_soccorso_conforme__c ='N/A';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c ='N/A';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c='N/A' ;
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c='N/A';      
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
        CQS_Utils.calcolaPunteggio2(cqs);
        
        
    }
    static testmethod void Method6(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'No';  
        cqs.CQS_ISP_POS__c = 'No';       
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'No';    
        cqs.CQS_IspS_Presenza_riferimenti_emergenza__c='No';
        cqs.CQS_IspS_Subappalto_autorizzato_OF__c= 'No';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'No';     
        cqs.CQS_IspS_Presenza_cartografie_enti__c= 'No';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'No';
        
        cqs.CQS_IspS_Accantieramento_conforme_a_PSC__c ='No';
        cqs.CQS_ISP_Esposizione_Cartello__c ='No';
        cqs.CQS_IspS_Segnaletica_stradale_suff__c ='No';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c ='No';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c ='No';
        cqs.CQS_IspS_Viabilit_come_ordinanza__c ='No';
        cqs.CQS_IspS_Protezione_scavi_in_minitrincea__c ='No';
        cqs.CQS_IspS_Protezione_scavi_trad_pozzetti__c ='No';   
        cqs.CQS_IspS_Utilizzo_DPC_rischi_particolari__c ='No';
        
        cqs.CQS_ISP_Presenti_autorizzati__c ='No';
        cqs.CQS_ISP_Tesserino_Check__c  ='No';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c   ='No';
        cqs.CQS_IspS_Addetto_primo_soccorso_presente__c='No';         
        cqs.CQS_ISP_Addetto_Antincendio_presente__c  ='No';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c='No';         
        cqs.CQS_IspS_DPI_3_categoria_utilizzati_OK__c  ='No';
        cqs.CQS_ISP_DPI_rischio_elettrico__c='No';           
        cqs.Presenza_Moviere_qualora_necessario__c='No';         
        cqs.CQS_IspS_Formazione_HS_conforme_mansione__c ='No';
        
        cqs.CQS_IspS_Autorizzati_e_presenti_nel_POS__c='No';  
        cqs.CQS_IspS_Sono_in_buono_stato__c='No';  
        cqs.CQS_IspS_Libretti_rev_mezzi_presenti__c='No'; 
        cqs.CQS_ISP_Marcatura_CE__c='No';   
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c ='No';
        cqs.CQS_ISP_attrezzature_sollevamento__c='No';
        
        cqs.Cassetta_primo_soccorso_conforme__c ='No';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c ='No';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c='No' ;
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c='No';      
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
        CQS_Utils.calcolaPunteggio2(cqs);
        
        
    }
    static testmethod void Method7(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'Sì';  
        cqs.CQS_ISP_POS__c = 'Sì';       
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'Sì';    
        cqs.CQS_IspS_Presenza_riferimenti_emergenza__c='N/A';
        cqs.CQS_IspS_Subappalto_autorizzato_OF__c= 'N/A';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'Sì';     
        cqs.CQS_IspS_Presenza_cartografie_enti__c= 'N/A';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'Sì';
        
        cqs.CQS_IspS_Accantieramento_conforme_a_PSC__c ='N/A';
        cqs.CQS_ISP_Esposizione_Cartello__c ='Sì';
        cqs.CQS_IspS_Segnaletica_stradale_suff__c ='N/A';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c ='Sì';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c ='Sì';
        cqs.CQS_IspS_Viabilit_come_ordinanza__c ='N/A';
        cqs.CQS_IspS_Protezione_scavi_in_minitrincea__c ='N/A';
        cqs.CQS_IspS_Protezione_scavi_trad_pozzetti__c ='N/A';   
        cqs.CQS_IspS_Utilizzo_DPC_rischi_particolari__c ='N/A';
        
        cqs.CQS_ISP_Presenti_autorizzati__c ='N/A';
        cqs.CQS_ISP_Tesserino_Check__c  ='Sì';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c   ='N/A';
        cqs.CQS_IspS_Addetto_primo_soccorso_presente__c='N/A';         
        cqs.CQS_ISP_Addetto_Antincendio_presente__c  ='N/A';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c='N/A';         
        cqs.CQS_IspS_DPI_3_categoria_utilizzati_OK__c  ='N/A';
        cqs.CQS_ISP_DPI_rischio_elettrico__c='N/A';           
        cqs.Presenza_Moviere_qualora_necessario__c='N/A';         
        cqs.CQS_IspS_Formazione_HS_conforme_mansione__c ='N/A';
        
        cqs.CQS_IspS_Autorizzati_e_presenti_nel_POS__c='N/A';  
        cqs.CQS_IspS_Sono_in_buono_stato__c='N/A';  
        cqs.CQS_IspS_Libretti_rev_mezzi_presenti__c='N/A'; 
        cqs.CQS_ISP_Marcatura_CE__c='Sì';   
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c ='Sì';
        cqs.CQS_ISP_attrezzature_sollevamento__c='Sì';
        
        cqs.Cassetta_primo_soccorso_conforme__c ='Sì';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c ='Sì';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c='N/A' ;
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c='Sì';      
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='Sì';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
        CQS_Utils.calcolaPunteggio2(cqs);
        
        
    }
    static testmethod void Method8(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_IspQ_Presenza_planimetrie_entige__c = 'N/A';  
        cqs.CQS_IspQ_Presenza_planimetrie_georadar__c= 'N/A';       
        cqs.CQS_IspQ_Presenza_Progetto_lancio_noDig__c = 'N/A';    
        cqs.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='N/A';
        cqs.CQS_IspQ_Permessi_rilasciati_con_deroghe__c= 'N/A';
        cqs.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c = 'N/A';     
        cqs.Evidenze_comunicazioni_propriet_cliente__c= 'N/A';
        cqs.CQS_IspQ_Apposizione_cartelli_cantiereOK__c = 'N/A';
        
        cqs.CQS_IspQ_AreaCantiere_del_stoc_materiali__c ='N/A';
        cqs.CQS_IspQ_Conformita_stoccaggio_materiali__c='N/A';
        
        cqs.CQS_IspQ_Tracciato_conf_prog_aut__c='N/A';
        
        cqs.CQS_IspQ_Sottoservizi_segnalati_asfalto__c ='N/A';
        cqs.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='N/A';
        cqs.CQS_IspQ_DPI_previsti_indossati__c ='N/A';
        cqs.CQS_IspQ_Scavo_netto_lineare__c ='N/A';
        cqs.CQS_IspQ_Profondita_scavo_conforme__c='N/A';
        cqs.CQS_IspQ_Larghezza_scavo_conforme__c ='N/A';   
        cqs.CQS_IspQ_Fondo_scavo_pulito__c ='N/A';
        
        cqs.CQS_IspQ_segnalatore_30cm_piano_calp__c='N/A';
        cqs.CQS_IspQ_Cambi_Bruschi_evitati__c  ='N/A';
        cqs.CQS_IspQ_SupAppoggio_pozzetto_OK__c  ='N/A';
        cqs.CQS_IspQ_Chiusino_compl_piano_calpestio__c='N/A';         
        cqs.CQS_IspQ_Pozzetto_conf_sp_tecniche__c ='N/A';
        cqs.CQS_IspQ_Chiusino_conf_sp_tecniche__c='N/A';         
        cqs.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c  ='N/A';
        cqs.CQS_IspQ_Corretta_fratturazione_pozzetto__c='N/A';           
        cqs.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c='N/A';         
        cqs.CQS_IspQ_Malta_sigilla_ingr_monotubi__c ='N/A';
        
        cqs.CQS_IspQ_tubi_posati_conformi_NT__c='N/A';  
        cqs.CQS_IspQ_N_tubi_posati_conformi_progetto__c='N/A';  
        cqs.CQS_IspQ_Ingresso_al_building_posaOK__c='N/A'; 
        cqs.CQS_IspQ_Ingresso_building_esecuzione_OK__c='N/A';   
        cqs.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='N/A';
        cqs.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='N/A';
        
        cqs.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c ='N/A';
        cqs.CQS_IspQ_Mat_riempimento_conforme_spec__c ='N/A';
        
        cqs.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='N/A' ;
        cqs.CQS_IspQ_Corretta_cilindr_rullo_compr__c='N/A'; 
        cqs.CQS_IspQ_Stendimento_idonea_graniglia__c='N/A';
        cqs.CQS_IspQ_Mat_trasp_discarica_autorizz__c='N/A';
        cqs.CQS_IspQ_gestione_compilazione_FIR_OK__c='N/A';
        cqs.CQS_Isp_Gest_comp_registro_car_scar_OK__c='N/A';
        cqs.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='N/A' ;  
        cqs.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='N/A' ; 
        cqs.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='N/A' ; 
        cqs.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='N/A';
        cqs.CQS_IspQ_Scarifica_idonea_largh_prof__c='N/A';
        cqs.CQS_IspQ_Manto_stradale_ripristinato_OK__c='N/A';
        cqs.CQS_IspQ_Manto_usura_ripristinato_OK__c='N/A';
        cqs.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='N/A';
        cqs.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='N/A';
        cqs.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='N/A';
        cqs.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='N/A';
        cqs.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='N/A';
        cqs.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='N/A';
        cqs.CQS_IspQ_Mat_conformi_spec_tec_OF__c='N/A';
        cqs.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='N/A';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='N/A';
        cqs.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='N/A';
        cqs.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='N/A';
        cqs.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='N/A';
        cqs.Minitubi_non_usati_chiusi_idonei_tappi__c='N/A';
        cqs.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='N/A';
        cqs.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='N/A';
        cqs.CQS_IspQ_Basamento_PFS__c='N/A';
        cqs.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='N/A';
        cqs.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c ='N/A';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='N/A';
        cqs.CQS_IspQ_Etichette_identificative_cavo1__c ='N/A';
        cqs.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='N/A';
        cqs.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='N/A' ;
        
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
        CQS_Utils.calcolaPunteggio3(cqs);
        
        
    }
    static testmethod void Method9(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_IspQ_Presenza_planimetrie_entige__c = 'No';  
        cqs.CQS_IspQ_Presenza_planimetrie_georadar__c='No';       
        cqs.CQS_IspQ_Presenza_Progetto_lancio_noDig__c = 'No';    
        cqs.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='No';
        cqs.CQS_IspQ_Permessi_rilasciati_con_deroghe__c= 'No';
        cqs.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c = 'No';     
        cqs.Evidenze_comunicazioni_propriet_cliente__c= 'No';
        cqs.CQS_IspQ_Apposizione_cartelli_cantiereOK__c = 'No';
        
        cqs.CQS_IspQ_AreaCantiere_del_stoc_materiali__c ='No';
        cqs.CQS_IspQ_Conformita_stoccaggio_materiali__c='No';
        
        cqs.CQS_IspQ_Tracciato_conf_prog_aut__c='No';
        
        cqs.CQS_IspQ_Sottoservizi_segnalati_asfalto__c ='No';
        cqs.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='No';
        cqs.CQS_IspQ_DPI_previsti_indossati__c ='No';
        cqs.CQS_IspQ_Scavo_netto_lineare__c ='No';
        cqs.CQS_IspQ_Profondita_scavo_conforme__c='No';
        cqs.CQS_IspQ_Larghezza_scavo_conforme__c ='No';   
        cqs.CQS_IspQ_Fondo_scavo_pulito__c ='No';
        
        cqs.CQS_IspQ_segnalatore_30cm_piano_calp__c='No';
        cqs.CQS_IspQ_Cambi_Bruschi_evitati__c  ='No';
        cqs.CQS_IspQ_SupAppoggio_pozzetto_OK__c  ='No';
        cqs.CQS_IspQ_Chiusino_compl_piano_calpestio__c='No';         
        cqs.CQS_IspQ_Pozzetto_conf_sp_tecniche__c ='No';
        cqs.CQS_IspQ_Chiusino_conf_sp_tecniche__c='No';         
        cqs.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c  ='No';
        cqs.CQS_IspQ_Corretta_fratturazione_pozzetto__c='No';           
        cqs.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c='No';         
        cqs.CQS_IspQ_Malta_sigilla_ingr_monotubi__c ='No';
        
        cqs.CQS_IspQ_tubi_posati_conformi_NT__c='No';  
        cqs.CQS_IspQ_N_tubi_posati_conformi_progetto__c='No';  
        cqs.CQS_IspQ_Ingresso_al_building_posaOK__c='No'; 
        cqs.CQS_IspQ_Ingresso_building_esecuzione_OK__c='No';   
        cqs.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='No';
        cqs.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='No';
        
        cqs.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c ='No';
        cqs.CQS_IspQ_Mat_riempimento_conforme_spec__c ='No';
        
        cqs.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='No' ;
        cqs.CQS_IspQ_Corretta_cilindr_rullo_compr__c='No'; 
        cqs.CQS_IspQ_Stendimento_idonea_graniglia__c='No';
        cqs.CQS_IspQ_Mat_trasp_discarica_autorizz__c='No';
        cqs.CQS_IspQ_gestione_compilazione_FIR_OK__c='No';
        cqs.CQS_Isp_Gest_comp_registro_car_scar_OK__c='No';
        cqs.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='No' ;  
        cqs.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='No' ; 
        cqs.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='No' ; 
        cqs.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='No';
        cqs.CQS_IspQ_Scarifica_idonea_largh_prof__c='No';
        cqs.CQS_IspQ_Manto_stradale_ripristinato_OK__c='No';
        cqs.CQS_IspQ_Manto_usura_ripristinato_OK__c='No';
        cqs.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='No';
        cqs.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='No';
        cqs.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='No';
        cqs.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='No';
        cqs.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='No';
        cqs.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='No';
        cqs.CQS_IspQ_Mat_conformi_spec_tec_OF__c='No';
        cqs.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='No';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='No';
        cqs.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='No';
        cqs.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='No';
        cqs.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='No';
        cqs.Minitubi_non_usati_chiusi_idonei_tappi__c='No';
        cqs.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='No';
        cqs.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='No';
        cqs.CQS_IspQ_Basamento_PFS__c='No';
        cqs.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='No';
        cqs.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c ='No';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='No';
        cqs.CQS_IspQ_Etichette_identificative_cavo1__c ='No';
        cqs.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='No';
        cqs.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='No' ;
        
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
        CQS_Utils.calcolaPunteggio3(cqs);
        
        
    }
    static testmethod void Method10(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        //	List<CQS_Progetto__c> proList = new List<CQS_Progetto__c>();
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        //        proList.add(pro);
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        
        
        cqs.CQS_IspQ_Presenza_planimetrie_entige__c = 'Si';  
        cqs.CQS_IspQ_Presenza_planimetrie_georadar__c='Si';       
        cqs.CQS_IspQ_Presenza_Progetto_lancio_NoDig__c ='Si';    
        cqs.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='Si';
        cqs.CQS_IspQ_Permessi_rilasciati_con_deroghe__c='Si';
        cqs.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c ='Si';     
        cqs.Evidenze_comunicazioni_propriet_cliente__c='Si';
        cqs.CQS_IspQ_Apposizione_cartelli_cantiereOK__c ='Si';
        
        cqs.CQS_IspQ_AreaCantiere_del_stoc_materiali__c ='Si';
        cqs.CQS_IspQ_Conformita_stoccaggio_materiali__c='Si';
        cqs.CQS_IspQ_Tracciato_conf_prog_aut__c='Si';
        cqs.CQS_IspQ_Sottoservizi_segnalati_asfalto__c ='Si';
        cqs.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='Si';
        cqs.CQS_IspQ_DPI_previsti_indossati__c ='Si';
        cqs.CQS_IspQ_Scavo_netto_lineare__c ='Si';
        cqs.CQS_IspQ_Profondita_scavo_conforme__c='Si';
        cqs.CQS_IspQ_Larghezza_scavo_conforme__c ='Si';   
        cqs.CQS_IspQ_Fondo_scavo_pulito__c ='Si';
        
        cqs.CQS_IspQ_segnalatore_30cm_piaNo_calp__c='Si';
        cqs.CQS_IspQ_Cambi_Bruschi_evitati__c  ='Si';
        cqs.CQS_IspQ_SupAppoggio_pozzetto_OK__c  ='Si';
        cqs.CQS_IspQ_ChiusiNo_compl_piaNo_calpestio__c='Si';         
        cqs.CQS_IspQ_Pozzetto_conf_sp_tecniche__c ='Si';
        cqs.CQS_IspQ_ChiusiNo_conf_sp_tecniche__c='Si';         
        cqs.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c  ='Si';
        cqs.CQS_IspQ_Corretta_fratturazione_pozzetto__c='Si';           
        cqs.CQS_IspQ_Rientro_moNotubo_pozzetto_OK__c='Si';         
        cqs.CQS_IspQ_Malta_sigilla_ingr_moNotubi__c ='Si';
        
        cqs.CQS_IspQ_tubi_posati_conformi_NT__c='Si';  
        cqs.CQS_IspQ_N_tubi_posati_conformi_progetto__c='Si';  
        cqs.CQS_IspQ_Ingresso_al_building_posaOK__c='Si'; 
        cqs.CQS_IspQ_Ingresso_building_esecuzione_OK__c='Si';   
        cqs.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='Si';
        cqs.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='Si';
        
        cqs.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c ='Si';
        cqs.CQS_IspQ_Mat_riempimento_conforme_spec__c ='Si';
        
        cqs.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='Si' ;
        cqs.CQS_IspQ_Corretta_cilindr_rullo_compr__c='Si'; 
        cqs.CQS_IspQ_Stendimento_idonea_graniglia__c='Si';
        cqs.CQS_IspQ_Mat_trasp_discarica_autorizz__c='Si';
        cqs.CQS_IspQ_gestione_compilazione_FIR_OK__c='Si';
        cqs.CQS_Isp_Gest_comp_registro_car_scar_OK__c='Si';
        cqs.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='Si' ;  
        cqs.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='Si' ; 
        cqs.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='Si' ; 
        cqs.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='Si';
        cqs.CQS_IspQ_Scarifica_idonea_largh_prof__c='Si';
        cqs.CQS_IspQ_Manto_stradale_ripristinato_OK__c='Si';
        cqs.CQS_IspQ_Manto_usura_ripristinato_OK__c='Si';
        cqs.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='Si';
        cqs.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='Si';
        cqs.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='Si';
        cqs.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='Si';
        cqs.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='Si';
        cqs.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='Si';
        cqs.CQS_IspQ_Mat_conformi_spec_tec_OF__c='Si';
        cqs.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='Si';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='Si';
        cqs.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='Si';
        cqs.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='Si';
        cqs.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='Si';
        cqs.Minitubi_Non_usati_chiusi_idonei_tappi__c='Si';
        cqs.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='Si';
        cqs.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='Si';
        cqs.CQS_IspQ_Basamento_PFS__c='Si';
        cqs.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='Si';
        cqs.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c ='Si';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='Si';
        cqs.CQS_IspQ_Etichette_identificative_cavo1__c ='Si';
        cqs.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='Si';
        cqs.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='Si' ;
        
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        insert cqs;
        
        CQS_Utils.calcolaPunteggio3(cqs);
        
        
    }
    static testmethod void Method11(){
        List<OF_CQS_Ispezione__c> cqsList = new List<OF_CQS_Ispezione__c>();
        OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
        anag.CQS_Check_Affidataria__c = true;
        insert anag;
        
        List<CQS_Progetto__c> proList = new List<CQS_Progetto__c>();
        List<Id> proListId = new List<Id>();
        CQS_Progetto__c pro = new CQS_Progetto__c();
        pro.CQS_Pro_Area__c = 'Test';
        pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
        insert pro;
        proList.add(pro);
        proListId.add(pro.id);
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_CAP__c = '';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        
        
        cqs.CQS_IspQ_Presenza_planimetrie_entige__c = 'Si';  
        cqs.CQS_IspQ_Presenza_planimetrie_georadar__c='Si';       
        cqs.CQS_IspQ_Presenza_Progetto_lancio_NoDig__c ='Si';    
        cqs.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='Si';
        cqs.CQS_IspQ_Permessi_rilasciati_con_deroghe__c='Si';
        cqs.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c ='Si';     
        cqs.Evidenze_comunicazioni_propriet_cliente__c='Si';
        cqs.CQS_IspQ_Apposizione_cartelli_cantiereOK__c ='Si';
        
        cqs.CQS_IspQ_AreaCantiere_del_stoc_materiali__c ='Si';
        cqs.CQS_IspQ_Conformita_stoccaggio_materiali__c='Si';
        cqs.CQS_IspQ_Tracciato_conf_prog_aut__c='Si';
        cqs.CQS_IspQ_Sottoservizi_segnalati_asfalto__c ='Si';
        cqs.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='Si';
        cqs.CQS_IspQ_DPI_previsti_indossati__c ='Si';
        cqs.CQS_IspQ_Scavo_netto_lineare__c ='Si';
        cqs.CQS_IspQ_Profondita_scavo_conforme__c='Si';
        cqs.CQS_IspQ_Larghezza_scavo_conforme__c ='Si';   
        cqs.CQS_IspQ_Fondo_scavo_pulito__c ='Si';
        
        cqs.CQS_IspQ_segnalatore_30cm_piaNo_calp__c='Si';
        cqs.CQS_IspQ_Cambi_Bruschi_evitati__c  ='Si';
        cqs.CQS_IspQ_SupAppoggio_pozzetto_OK__c  ='Si';
        cqs.CQS_IspQ_ChiusiNo_compl_piaNo_calpestio__c='Si';         
        cqs.CQS_IspQ_Pozzetto_conf_sp_tecniche__c ='Si';
        cqs.CQS_IspQ_ChiusiNo_conf_sp_tecniche__c='Si';         
        cqs.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c  ='Si';
        cqs.CQS_IspQ_Corretta_fratturazione_pozzetto__c='Si';           
        cqs.CQS_IspQ_Rientro_moNotubo_pozzetto_OK__c='Si';         
        cqs.CQS_IspQ_Malta_sigilla_ingr_moNotubi__c ='Si';
        
        cqs.CQS_IspQ_tubi_posati_conformi_NT__c='Si';  
        cqs.CQS_IspQ_N_tubi_posati_conformi_progetto__c='Si';  
        cqs.CQS_IspQ_Ingresso_al_building_posaOK__c='Si'; 
        cqs.CQS_IspQ_Ingresso_building_esecuzione_OK__c='Si';   
        cqs.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='Si';
        cqs.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='Si';
        
        cqs.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c ='Si';
        cqs.CQS_IspQ_Mat_riempimento_conforme_spec__c ='Si';
        
        cqs.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='Si' ;
        cqs.CQS_IspQ_Corretta_cilindr_rullo_compr__c='Si'; 
        cqs.CQS_IspQ_Stendimento_idonea_graniglia__c='Si';
        cqs.CQS_IspQ_Mat_trasp_discarica_autorizz__c='Si';
        cqs.CQS_IspQ_gestione_compilazione_FIR_OK__c='Si';
        cqs.CQS_Isp_Gest_comp_registro_car_scar_OK__c='Si';
        cqs.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='Si' ;  
        cqs.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='Si' ; 
        cqs.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='Si' ; 
        cqs.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='Si';
        cqs.CQS_IspQ_Scarifica_idonea_largh_prof__c='Si';
        cqs.CQS_IspQ_Manto_stradale_ripristinato_OK__c='Si';
        cqs.CQS_IspQ_Manto_usura_ripristinato_OK__c='Si';
        cqs.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='Si';
        cqs.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='Si';
        cqs.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='Si';
        cqs.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='Si';
        cqs.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='Si';
        cqs.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='Si';
        cqs.CQS_IspQ_Mat_conformi_spec_tec_OF__c='Si';
        cqs.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='Si';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='Si';
        cqs.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='Si';
        cqs.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='Si';
        cqs.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='Si';
        cqs.Minitubi_Non_usati_chiusi_idonei_tappi__c='Si';
        cqs.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='Si';
        cqs.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='Si';
        cqs.CQS_IspQ_Basamento_PFS__c='Si';
        cqs.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='Si';
        cqs.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c ='Si';
        cqs.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='Si';
        cqs.CQS_IspQ_Etichette_identificative_cavo1__c ='Si';
        cqs.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='Si';
        cqs.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='Si' ;
        
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c='No';
        
        cqs.OF_CQS_Data_Ispezione__c =system.today()-1;
        cqs.CQS_ISP_Progetto__c=pro.id;
        //cqsList.add(cqs);
        //insert cqsList; 
        Set<Id> uRoleId = new Set<Id>();
        Id cmIDRole = [Select id, Name, DeveloperName from UserRole where DeveloperName LIKE '%City_Manager%' Limit 1].id;
        For(UserRole uRo: [Select id, Name, DeveloperName from UserRole where DeveloperName LIKE '%CQS%' OR DeveloperName  Like '%HS%']){
            uRoleId.add(uRo.id);
            
        }
        
        insert cqs;
        test.startTest();
        CQS_Utils.getAboveUsers(uRoleId);
        CQS_Utils.getUserRoleSup(cmIDRole);
        CQS_Utils.getUtSup(uRoleId);
        CQS_Utils.getUtSupId(uRoleId);
        CQS_Utils.getUListPro(proListId);
        
        test.stopTest();
        
    }
    static testmethod void Method12(){
        
        List<CQS_Progetto__c> proList = new List<CQS_Progetto__c>();
        List<Id> proListId = new List<Id>();
        
        Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Bad Practice').getRecordTypeId();
        Id RecordTypeIdeventDann = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Danneggiamento a Terzi').getRecordTypeId();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u2 = new User(Alias = 'nUser1a', Email='newuser1a@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing1a', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='newuser1a@testorg.com');
        
        System.runAs(u2) {
            
            
            List<OF_CQS_Evento__c> evenList = new List<OF_CQS_Evento__c>();
            Set<Id> evenListId = new Set<Id>();
            
            
            //cqsList.add(cqs);
            //insert cqsList; 
            Set<Id> uRoleId = new Set<Id>();
            Id cmIDRole = [Select id, Name, DeveloperName from UserRole where DeveloperName LIKE '%City_Manager%' Limit 1].id;
            For(UserRole uRo: [Select id, Name, DeveloperName from UserRole where DeveloperName LIKE '%CQS%' OR DeveloperName  Like '%HS%']){
                uRoleId.add(uRo.id);
                
            }
            
            
            UserRole ur4 = new UserRole();
            ur4.Name = 'RE';
            insert ur4;
            UserRole ur3 = new UserRole();
            ur3.Name = 'HSE';
            ur3.ParentRoleId = ur4.Id;
            insert ur3;
            UserRole r2 = new UserRole();
            r2.Name = 'Area Manager';
            r2.ParentRoleId = ur3.Id;
            insert r2;
            UserRole r = new UserRole();
            r.Name = 'City Manager Centro';
            r.ParentRoleId = r2.Id;
            insert r; 
            
            List<Id> UserListId = new List<Id>();
            Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
            // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
            User usr4 = new User();
            usr4.Alias = 'standt';
            usr4.Email='standarduser@testorg.com';
            usr4.EmailEncodingKey='UTF-8';
            usr4.LastName='Testing';
            usr4.LanguageLocaleKey='en_US'; 
            usr4.LocaleSidKey='en_US';
            usr4.ProfileId = profileId.id;
            usr4.TimeZoneSidKey='America/Los_Angeles';
            usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr4.UserRoleId = ur4.id;
            insert usr4;
            User usr3 = new User();
            usr3.Alias = 'standt';
            usr3.Email='standarduser@testorg.com';
            usr3.EmailEncodingKey='UTF-8';
            usr3.LastName='Testing';
            usr3.LanguageLocaleKey='en_US'; 
            usr3.LocaleSidKey='en_US';
            usr3.ProfileId = profileId.id;
            usr3.TimeZoneSidKey='America/Los_Angeles';
            usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr3.UserRoleId = ur3.id;
            insert usr3;
            User usr2 = new User();
            usr2.Alias = 'standt';
            usr2.Email='standarduser@testorg.com';
            usr2.EmailEncodingKey='UTF-8';
            usr2.LastName='Testing';
            usr2.LanguageLocaleKey='en_US'; 
            usr2.LocaleSidKey='en_US';
            usr2.ProfileId = profileId.id;
            usr2.TimeZoneSidKey='America/Los_Angeles';
            usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr2.UserRoleId = r2.id;
            insert usr2;
            User usr = new User();
            usr.Alias = 'standt';
            usr.Email='standarduser@testorg.com';
            usr.EmailEncodingKey='UTF-8';
            usr.LastName='Testing';
            usr.LanguageLocaleKey='en_US'; 
            usr.LocaleSidKey='en_US';
            usr.ProfileId = profileId.id;
            usr.TimeZoneSidKey='America/Los_Angeles';
            usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr.UserRoleId = r.id;
            insert usr;
            
            
            UserListId.add(usr.id);
            UserListId.add(usr2.id);
            UserListId.add(usr3.id);
            UserListId.add(usr4.id);
            //  system.runAs(usr){
            OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
            anag.CQS_Check_Affidataria__c = true;
            anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
            anag.Name = 'AMTECO';
            insert anag;
            
            CQS_Progetto__c pro = new CQS_Progetto__c();
            pro.CQS_Pro_Area__c = 'Test';
            pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
            insert pro;
            proList.add(pro);
            proListId.add(pro.id);
            
            Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
            projen.CQS_junc_progetto__c = pro.Id;
            projen.CQS_junc_user__c = usr.id;
            insert projen;
            
            
            List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
            OF_CQS_Evento__c even = new OF_CQS_Evento__c();
            even.OF_CQS_Impresa_Mandataria__c = anag.Id;
            even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
            even.CQS_Ev_Progetto__c = pro.Id;
            even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
            even.OF_CQS_Data_Evento__c = System.today();
            even.OF_CQS_Rispetto_Procedura__c = 'Sì';
            even.OF_CQS_Diffida__c  = FALSE;
            even.OF_CQS_Inadempienze_Operative__c = FALSE;
            even.CQS_Indice_Gravita_Taglio_Danneggiamento__c='A - Alta';
            even.OwnerId = usr.id;
            //even.RecordTypeId = rtId;
            //even.recordtypeid= rtype[0].id;
            even.recordtypeid=RecordTypeIdevent;
            even.OF_CQS_Richiesta_Danni__c  = true;
            even.OF_CQS_Stato_Pratica__c = 'Inserita';
            eL.add(even);
            evenList.add(even);
            evenListId.add(even.id);
            
            insert eL;
            
            Attachment attach=new Attachment();     
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId = even.id;
            insert attach;
            
            CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
            prog.CQS_Praj_Progetto__c = pro.Id;
            prog.CQS_Paj_Email_Affidataria__c = 'test@gmail.com';
            prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
            insert prog;
            
            ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a Terzi');
            ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
            String statoPratica = 'test';
            String searchTerm = 'test';
            
            
            
            test.startTest();
            CQS_Utils.getAboveUsers(uRoleId);
            CQS_Utils.getUserRoleSup(cmIDRole);
            CQS_Utils.getUtSup(uRoleId);
            CQS_Utils.getUtSupId(uRoleId);
            CQS_Utils.getUListPro(proListId);
            CQS_Utils.inviaMail3(evenListId);
            
            test.stopTest();
        }
        
    }
   
    static testmethod void Method13(){
            
            /* list<RecordType> rtype = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'OF_CQS_Evento__c' and RecordType.DeveloperName= 'developerName'];*/
            
            Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Danneggiamento a Terzi').getRecordTypeId();
            
            UserRole ur4 = new UserRole();
            ur4.Name = 'RE';
            insert ur4;
            UserRole ur3 = new UserRole();
            ur3.Name = 'HSE';
            ur3.ParentRoleId = ur4.Id;
            insert ur3;
            UserRole r2 = new UserRole();
            r2.Name = 'Area Manager';
            r2.ParentRoleId = ur3.Id;
            insert r2;
            UserRole r = new UserRole();
            r.Name = 'City Manager Centro';
            r.ParentRoleId = r2.Id;
            insert r; 
            
            Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
            // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
              List<Id> UserListId = new List<Id>();
           
            
            User usr4 = new User();
            usr4.Alias = 'standt';
            usr4.Email='standarduser@testorg.com';
            usr4.EmailEncodingKey='UTF-8';
            usr4.LastName='Testing';
            usr4.LanguageLocaleKey='en_US'; 
            usr4.LocaleSidKey='en_US';
            usr4.ProfileId = profileId.id;
            usr4.TimeZoneSidKey='America/Los_Angeles';
            usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr4.UserRoleId = ur4.id;
            insert usr4;
            User usr3 = new User();
            usr3.Alias = 'standt';
            usr3.Email='standarduser@testorg.com';
            usr3.EmailEncodingKey='UTF-8';
            usr3.LastName='Testing';
            usr3.LanguageLocaleKey='en_US'; 
            usr3.LocaleSidKey='en_US';
            usr3.ProfileId = profileId.id;
            usr3.TimeZoneSidKey='America/Los_Angeles';
            usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr3.UserRoleId = ur3.id;
            insert usr3;
            User usr2 = new User();
            usr2.Alias = 'standt';
            usr2.Email='standarduser@testorg.com';
            usr2.EmailEncodingKey='UTF-8';
            usr2.LastName='Testing';
            usr2.LanguageLocaleKey='en_US'; 
            usr2.LocaleSidKey='en_US';
            usr2.ProfileId = profileId.id;
            usr2.TimeZoneSidKey='America/Los_Angeles';
            usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr2.UserRoleId = r2.id;
            insert usr2;
            User usr = new User();
            usr.Alias = 'standt';
            usr.Email='standarduser@testorg.com';
            usr.EmailEncodingKey='UTF-8';
            usr.LastName='Testing';
            usr.LanguageLocaleKey='en_US'; 
            usr.LocaleSidKey='en_US';
            usr.ProfileId = profileId.id;
            usr.TimeZoneSidKey='America/Los_Angeles';
            usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr.UserRoleId = r.id;
            insert usr;
            
            UserListId.add(usr.id);
            UserListId.add(usr2.id);
            UserListId.add(usr3.id);
            UserListId.add(usr4.id);
            
        	List<OF_CQS_Evento__c> evenList = new List<OF_CQS_Evento__c>();
            Set<Id> evenListId = new Set<Id>();
         
            system.runAs(usr){
                OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
                anag.CQS_Check_Affidataria__c = true;
                anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
                anag.Name = 'AMTECO';
                insert anag;
                
                CQS_Progetto__c pro = new CQS_Progetto__c();
                pro.CQS_Pro_Area__c = 'Test';
                pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
                insert pro;
                Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
                projen.CQS_junc_progetto__c = pro.Id;
                projen.CQS_junc_user__c = usr.id;
                insert projen;
                
                List<OF_CQS_Evento__c> eL = new List<OF_CQS_Evento__c>();
                OF_CQS_Evento__c even = new OF_CQS_Evento__c();
                even.OF_CQS_Impresa_Mandataria__c = anag.Id;
                even.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
                even.CQS_Ev_Progetto__c = pro.Id;
                even.CQS_Ev_Lettera_D_Ordine__c = 'Test';
                even.OF_CQS_Data_Evento__c = System.today();
                even.OF_CQS_Rispetto_Procedura__c = 'Sì';
                even.OF_CQS_Diffida__c  = FALSE;
                even.OF_CQS_Inadempienze_Operative__c = FALSE;
                even.CQS_Indice_Gravita_Taglio_Danneggiamento__c='A - Alta';
                even.OwnerId = usr.id;
                //even.RecordTypeId = rtId;
                //even.recordtypeid= rtype[0].id;
                even.recordtypeid=RecordTypeIdevent;
                even.OF_CQS_Richiesta_Danni__c  = true;
                even.OF_CQS_Stato_Pratica__c = 'Inserita';
                
                OF_CQS_Evento__c even2 = new OF_CQS_Evento__c();
                even2.OF_CQS_Impresa_Mandataria__c = anag.Id;
                even2.OF_CQS_Impresa_Esecutrice_Eventi__c = anag.id;
                even2.CQS_Ev_Progetto__c = pro.Id;
                even2.CQS_Ev_Lettera_D_Ordine__c = 'Test';
                even2.OF_CQS_Data_Evento__c = System.today();
                even2.OF_CQS_Rispetto_Procedura__c = 'Sì';
                even2.OF_CQS_Diffida__c  = FALSE;
                even2.OF_CQS_Inadempienze_Operative__c = FALSE;
                even2.CQS_Indice_Gravita_Taglio_Danneggiamento__c='L - Lieve';
                even2.OwnerId = usr.id;
                //even2.RecordTypeId = rtId;
                //even2.recordtypeid= rtype[0].id;
                even2.recordtypeid=RecordTypeIdevent;
                even2.OF_CQS_Richiesta_Danni__c  = true;
                even2.OF_CQS_Stato_Pratica__c = 'Inserita';
                
                eL.add(even);
                eL.add(even2);
                insert eL;
                evenListId.add(even.Id);
                evenListId.add(even2.Id);
               
                CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
                prog.CQS_Praj_Progetto__c = pro.Id;
                prog.CQS_Paj_Email_Affidataria__c = 'test@gmail.com';
                prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
                insert prog;
                
                ApexPages.currentPage().getParameters().put('optScelta','Danneggiamento a Terzi');
                ApexPages.CurrentPage().getParameters().put('/apex/CQS_DanneggiamentoAterzi' ,'test');
                String statoPratica = 'test';
                String searchTerm = 'test';
                
                
                
                test.startTest();
                CQS_Utils.inviaMail3(evenListId);
                test.stopTest();
                
            }
        }
	static testmethod void calcolaPunteggio(){
   List<OF_CQS_Ispezione__c> ispList = new List<OF_CQS_Ispezione__c>();
   
		  //Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Danneggiamento a Terzi').getRecordTypeId();
           Id RecordTypeIdevent =[Select id,DeveloperName from RecordType where SobjectType='OF_CQS_Ispezione__c' and DeveloperName = 'CQS_Ispezioni_Qualita'].id;
			
            UserRole ur4 = new UserRole();
            ur4.Name = 'RE';
            insert ur4;
            UserRole ur3 = new UserRole();
            ur3.Name = 'HSE';
            ur3.ParentRoleId = ur4.Id;
            insert ur3;
            UserRole r2 = new UserRole();
            r2.Name = 'Area Manager';
            r2.ParentRoleId = ur3.Id;
            insert r2;
            UserRole r = new UserRole();
            r.Name = 'City Manager Centro';
            r.ParentRoleId = r2.Id;
            insert r; 
            
            Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
            // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
              List<Id> UserListId = new List<Id>();
           
            
            User usr4 = new User();
            usr4.Alias = 'standt';
            usr4.Email='standarduser@testorg.com';
            usr4.EmailEncodingKey='UTF-8';
            usr4.LastName='Testing';
            usr4.LanguageLocaleKey='en_US'; 
            usr4.LocaleSidKey='en_US';
            usr4.ProfileId = profileId.id;
            usr4.TimeZoneSidKey='America/Los_Angeles';
            usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr4.UserRoleId = ur4.id;
            insert usr4;
            User usr3 = new User();
            usr3.Alias = 'standt';
            usr3.Email='standarduser@testorg.com';
            usr3.EmailEncodingKey='UTF-8';
            usr3.LastName='Testing';
            usr3.LanguageLocaleKey='en_US'; 
            usr3.LocaleSidKey='en_US';
            usr3.ProfileId = profileId.id;
            usr3.TimeZoneSidKey='America/Los_Angeles';
            usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr3.UserRoleId = ur3.id;
            insert usr3;
            User usr2 = new User();
            usr2.Alias = 'standt';
            usr2.Email='standarduser@testorg.com';
            usr2.EmailEncodingKey='UTF-8';
            usr2.LastName='Testing';
            usr2.LanguageLocaleKey='en_US'; 
            usr2.LocaleSidKey='en_US';
            usr2.ProfileId = profileId.id;
            usr2.TimeZoneSidKey='America/Los_Angeles';
            usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr2.UserRoleId = r2.id;
            insert usr2;
            User usr = new User();
            usr.Alias = 'standt';
            usr.Email='standarduser@testorg.com';
            usr.EmailEncodingKey='UTF-8';
            usr.LastName='Testing';
            usr.LanguageLocaleKey='en_US'; 
            usr.LocaleSidKey='en_US';
            usr.ProfileId = profileId.id;
            usr.TimeZoneSidKey='America/Los_Angeles';
            usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr.UserRoleId = r.id;
            insert usr;
            
            UserListId.add(usr.id);
            UserListId.add(usr2.id);
            UserListId.add(usr3.id);
            UserListId.add(usr4.id);
            
        	
            system.runAs(usr){
                OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
                anag.CQS_Check_Affidataria__c = true;
                anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
                anag.Name = 'AMTECO';
                insert anag;
                
                CQS_Progetto__c pro = new CQS_Progetto__c();
                pro.CQS_Pro_Area__c = 'Test';
                pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
                insert pro;
                Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
                projen.CQS_junc_progetto__c = pro.Id;
                projen.CQS_junc_user__c = usr.id;
                insert projen;
				
				 
                CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
                prog.CQS_Paj_Email_Affidataria__c = 'test@gmail.com';
                prog.CQS_Praj_Progetto__c = pro.Id;
                prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
                insert prog;
		
        
		
        OF_CQS_Ispezione__c isp = new OF_CQS_Ispezione__c();
        isp.CQS_ISP_LDO__c = '111111111';
		isp.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp.RecordTypeId=RecordTypeIdevent;
        //isp.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp.OF_CQS_ISP_Lotto__c='Test';
        isp.OF_CQS_ISP_VIA__c = 'test';
         isp.OF_CQS_ISP_CAP__c = '';
        isp.OF_CQS_ISP_Comune__c = 'test';
        isp.OF_CQS_ISP_Provincia__c = 'test';
		isp.OF_CQS_ISP_Numero_Civico__c='12';
		isp.OF_CQS_ISP_Area_Cavo__c='12';
        isp.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp.CQS_ISP_Autorizzazione_Scavo__c= True;
		isp.CQS_ISP_Scavo_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Infrastrutture__c= True;
		isp.CQS_ISP_Infrastrutture_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Posa_cavi__c= True;
		isp.CQS_ISP_Posa_Cavi_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Ripristini__c= True;
		isp.CQS_ISP_Ripristini_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Verticale__c= True;
		isp.CQS_ISP_Verticale_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Giunzione__c= True;
		isp.CQS_ISP_Giunzione_inEsecuzione__c= True;
		isp.CQS_ISP_Opere_Site_Preparation_POP__c= True;
		isp.CQS_ISP_Opere_Site_Preparation_inEsec__c= True;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp.Cqs_Isp_Autorizzato__c= 'Sì';
		isp.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp.CQS_Isp_Autorizzato2__c = 'Sì';
		isp.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp.CQS_ISP_Autorizzato3__c = 'Sì';
		
		//End sez. Lavoratori
		
		//Start Sez Documentazione
		isp.CQS_IspQ_Presenza_planimetrie_entige__c= 'Si';
		isp.CQS_IspQ_Presenza_planimetrie_georadar__c='Si';
		isp.CQS_IspQ_Presenza_Progetto_lancio_noDig__c='Si';
		isp.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='Si';
		isp.CQS_IspQ_Permessi_rilasciati_con_deroghe__c='Si';
		isp.CQS_IspQ_Schede_tec_conf_DT_rapp_prova__c='Si';
		isp.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c='Si';
		isp.CQS_IspQ_Agg_GIS_completo_corretto__c='Si';
		isp.CQS_IspQ_contabilita_lavori_xSistInfOK__c='Si';
		isp.Evidenze_comunicazioni_propriet_cliente__c='Si';
		//End Sez Documentazione
		
		//Start Sez Organizzazione del cantiere
		
		isp.CQS_IspQ_Apposizione_cartelli_cantiereOK__c='Si';
		isp.CQS_IspQ_AreaCantiere_del_stoc_materiali__c='Si';
		isp.CQS_IspQ_Conformita_stoccaggio_materiali__c='Si';
		isp.CQS_IspQ_Tracciato_conf_prog_aut__c='Si';
		isp.CQS_IspQ_Sottoservizi_segnalati_asfalto__c='Si';
		isp.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='Si';
		isp.CQS_IspQ_DPI_previsti_indossati__c='Si';

		//END Sez Organizzazione del cantiere
		
		//Start Sez Scavi
		isp.CQS_IspQ_Scavo_netto_lineare__c='Si';
		isp.CQS_IspQ_Profondita_scavo_conforme__c='Si';
		isp.CQS_IspQ_Larghezza_scavo_conforme__c='Si';
		isp.CQS_IspQ_Fondo_scavo_pulito__c='Si';
		isp.CQS_IspQ_segnalatore_30cm_piano_calp__c='Si';
		isp.CQS_IspQ_Cambi_Bruschi_evitati__c='Si';
		//End Sez Scavi
		
		//Start Sez Infrastrutture
		isp.CQS_IspQ_SupAppoggio_pozzetto_OK__c='Si';
		isp.CQS_IspQ_Chiusino_compl_piano_calpestio__c='Si';
		isp.CQS_IspQ_Pozzetto_conf_sp_tecniche__c='Si';
		isp.CQS_IspQ_Chiusino_conf_sp_tecniche__c='Si';
		isp.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c='Si';
		isp.CQS_IspQ_Corretta_fratturazione_pozzetto__c='Si';
		isp.CQS_IspQ_Ingresso_minitu_pozz_prot_mono__c='Si';
		isp.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c='Si';
		isp.CQS_IspQ_Malta_sigilla_ingr_monotubi__c='Si';
		isp.CQS_IspQ_tubi_posati_conformi_NT__c='Si';
		isp.CQS_IspQ_N_tubi_posati_conformi_progetto__c='Si';
		isp.CQS_IspQ_Ingresso_al_building_posaOK__c='Si';
		isp.CQS_IspQ_Ingresso_building_esecuzione_OK__c='Si';
		isp.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='Si';
		//End Sez Infrastrutture
		
		//Start sez Ripristini provvisori
		isp.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='Si';
		isp.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c='Si';
		isp.CQS_IspQ_Mat_riempimento_conforme_spec__c='Si';
		isp.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='Si';
		isp.CQS_IspQ_Corretta_cilindr_rullo_compr__c='Si';
		isp.CQS_IspQ_Stendimento_idonea_graniglia__c='Si';
		//End sez Ripristini provvisori
		
		//Start sez Gestione Rifiuti
		isp.CQS_IspQ_Mat_trasp_discarica_autorizz__c='Si';
		isp.CQS_IspQ_gestione_compilazione_FIR_OK__c='Si';
		isp.CQS_Isp_Gest_comp_registro_car_scar_OK__c='Si';
		isp.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='Si';
		isp.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='Si';
		isp.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='Si';
		isp.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='Si';
		//End Sez Gestione Rifiuti
		
		//Start Sez Ripristino definitivo
		isp.CQS_IspQ_Scarifica_idonea_largh_prof__c='Si';
		isp.CQS_IspQ_Manto_stradale_ripristinato_OK__c='Si';
		isp.CQS_IspQ_Manto_usura_ripristinato_OK__c='Si';
		isp.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='Si';
		isp.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='Si';
		isp.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='Si';
		isp.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='Si';
		//End Sez. Ripristino definitivo
		
		//Start sez Materiali
		isp.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='Si';
		isp.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='Si';
		isp.CQS_IspQ_Mat_conformi_spec_tec_OF__c='Si';
		//End Sez. Materiali
		
		//Start sez. Muffola PFP
		isp.CQS_IspQ_SupAppoggio_pozzetto_OK2__c='Si';
		isp.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='Si';
		isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='Si';
		isp.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='Si';
		isp.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='Si';
		isp.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='Si';
		isp.Minitubi_non_usati_chiusi_idonei_tappi__c='Si';
		isp.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='Si';
		isp.CQS_IspQ_Tenuta_pneum_apressione_muff__c='Si';
		//End Sez. Muffola PFP
		
		//Start Sez Armadi
		isp.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='Si';
		isp.CQS_IspQ_Basamento_PFS__c='Si';
		isp.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='Si';
		isp.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c='Si';
		isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='Si';
		isp.CQS_IspQ_Etichette_identificative_cavo1__c='Si';
		isp.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='Si';
		//End Sez Armadi
		
		//Start sez Armadi PTE/PTA
		isp.CQS_IspQ_Caratteristiche_PTE_previste_NT__c='Si';
		isp.CQS_IspQ_PTE_correttamente_staffato__c='Si';
		isp.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='Si';
		isp.CQS_IspQ_Etichette_identificative_cavo2__c='Si';

		//End Sez Armadi PTE/PTA
		
		//START SEZ Gestione Rifiuti a Lavorazioni Concluse
		isp.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='Si';
		//END SEZ Gestione Rifiuti a Lavorazioni Concluse
		
        //cqsList.add(cqs);
        //insert cqsList; 
        insert isp;
		
		 OF_CQS_Ispezione__c isp2 = new OF_CQS_Ispezione__c();
        isp2.CQS_ISP_LDO__c = '111111111';
		isp2.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp2.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp2.RecordTypeId=RecordTypeIdevent;
        //isp2.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp2.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp2.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp2.OF_CQS_ISP_Lotto__c='Test';
        isp2.OF_CQS_ISP_VIA__c = 'test';
         isp2.OF_CQS_ISP_CAP__c = '';
        isp2.OF_CQS_ISP_Comune__c = 'test';
        isp2.OF_CQS_ISP_Provincia__c = 'test';
		isp2.OF_CQS_ISP_Numero_Civico__c='12';
		isp2.OF_CQS_ISP_Area_Cavo__c='12';
        isp2.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp2.CQS_ISP_Autorizzazione_Scavo__c= True;
		isp2.CQS_ISP_Scavo_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Infrastrutture__c= True;
		isp2.CQS_ISP_Infrastrutture_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Posa_cavi__c= True;
		isp2.CQS_ISP_Posa_Cavi_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Ripristini__c= True;
		isp2.CQS_ISP_Ripristini_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Verticale__c= True;
		isp2.CQS_ISP_Verticale_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Giunzione__c= True;
		isp2.CQS_ISP_Giunzione_inEsecuzione__c= True;
		isp2.CQS_ISP_Opere_Site_Preparation_POP__c= True;
		isp2.CQS_ISP_Opere_Site_Preparation_inEsec__c= True;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp2.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp2.Cqs_Isp_Autorizzato__c= 'Sì';
		isp2.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp2.CQS_Isp_Autorizzato2__c = 'Sì';
		isp2.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp2.CQS_ISP_Autorizzato3__c = 'Sì';
		
		//End sez. Lavoratori
		
		//Start Sez Documentazione
		isp2.CQS_IspQ_Presenza_planimetrie_entige__c= 'No';
		isp2.CQS_IspQ_Presenza_planimetrie_georadar__c='No';
		isp2.CQS_IspQ_Presenza_Progetto_lancio_noDig__c='No';
		isp2.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='No';
		isp2.CQS_IspQ_Permessi_rilasciati_con_deroghe__c='No';
		isp2.CQS_IspQ_Schede_tec_conf_DT_rapp_prova__c='No';
		isp2.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c='No';
		isp2.CQS_IspQ_Agg_GIS_completo_corretto__c='No';
		isp2.CQS_IspQ_contabilita_lavori_xSistInfOK__c='No';
		isp2.Evidenze_comunicazioni_propriet_cliente__c='No';
		//End Sez Documentazione
		
		//Start Sez Organizzazione del cantiere
		
		isp2.CQS_IspQ_Apposizione_cartelli_cantiereOK__c='No';
		isp2.CQS_IspQ_AreaCantiere_del_stoc_materiali__c='No';
		isp2.CQS_IspQ_Conformita_stoccaggio_materiali__c='No';
		isp2.CQS_IspQ_Tracciato_conf_prog_aut__c='No';
		isp2.CQS_IspQ_Sottoservizi_segnalati_asfalto__c='No';
		isp2.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='No';
		isp2.CQS_IspQ_DPI_previsti_indossati__c='No';

		//END Sez Organizzazione del cantiere
		
		//Start Sez Scavi
		isp2.CQS_IspQ_Scavo_netto_lineare__c='No';
		isp2.CQS_IspQ_Profondita_scavo_conforme__c='No';
		isp2.CQS_IspQ_Larghezza_scavo_conforme__c='No';
		isp2.CQS_IspQ_Fondo_scavo_pulito__c='No';
		isp2.CQS_IspQ_segnalatore_30cm_piano_calp__c='No';
		isp2.CQS_IspQ_Cambi_Bruschi_evitati__c='No';
		//End Sez Scavi
		
		//Start Sez Infrastrutture
		isp2.CQS_IspQ_SupAppoggio_pozzetto_OK__c='No';
		isp2.CQS_IspQ_Chiusino_compl_piano_calpestio__c='No';
		isp2.CQS_IspQ_Pozzetto_conf_sp_tecniche__c='No';
		isp2.CQS_IspQ_Chiusino_conf_sp_tecniche__c='No';
		isp2.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c='No';
		isp2.CQS_IspQ_Corretta_fratturazione_pozzetto__c='No';
		isp2.CQS_IspQ_Ingresso_minitu_pozz_prot_mono__c='No';
		isp2.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c='No';
		isp2.CQS_IspQ_Malta_sigilla_ingr_monotubi__c='No';
		isp2.CQS_IspQ_tubi_posati_conformi_NT__c='No';
		isp2.CQS_IspQ_N_tubi_posati_conformi_progetto__c='No';
		isp2.CQS_IspQ_Ingresso_al_building_posaOK__c='No';
		isp2.CQS_IspQ_Ingresso_building_esecuzione_OK__c='No';
		isp2.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='No';
		//End Sez Infrastrutture
		
		//Start sez Ripristini provvisori
		isp2.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='No';
		isp2.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c='No';
		isp2.CQS_IspQ_Mat_riempimento_conforme_spec__c='No';
		isp2.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='No';
		isp2.CQS_IspQ_Corretta_cilindr_rullo_compr__c='No';
		isp2.CQS_IspQ_Stendimento_idonea_graniglia__c='No';
		//End sez Ripristini provvisori
		
		//Start sez Gestione Rifiuti
		isp2.CQS_IspQ_Mat_trasp_discarica_autorizz__c='No';
		isp2.CQS_IspQ_gestione_compilazione_FIR_OK__c='No';
		isp2.CQS_Isp_Gest_comp_registro_car_scar_OK__c='No';
		isp2.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='No';
		isp2.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='No';
		isp2.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='No';
		isp2.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='No';
		//End Sez Gestione Rifiuti
		
		//Start Sez Ripristino definitivo
		isp2.CQS_IspQ_Scarifica_idonea_largh_prof__c='No';
		isp2.CQS_IspQ_Manto_stradale_ripristinato_OK__c='No';
		isp2.CQS_IspQ_Manto_usura_ripristinato_OK__c='No';
		isp2.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='No';
		isp2.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='No';
		isp2.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='No';
		isp2.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='No';
		//End Sez. Ripristino definitivo
		
		//Start sez Materiali
		isp2.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='No';
		isp2.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='No';
		isp2.CQS_IspQ_Mat_conformi_spec_tec_OF__c='No';
		//End Sez. Materiali
		
		//Start sez. Muffola PFP
		isp2.CQS_IspQ_SupAppoggio_pozzetto_OK2__c='No';
		isp2.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='No';
		isp2.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='No';
		isp2.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='No';
		isp2.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='No';
		isp2.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='No';
		isp2.Minitubi_non_usati_chiusi_idonei_tappi__c='No';
		isp2.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='No';
		isp2.CQS_IspQ_Tenuta_pneum_apressione_muff__c='No';
		//End Sez. Muffola PFP
		
		//Start Sez Armadi
		isp2.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='No';
		isp2.CQS_IspQ_Basamento_PFS__c='No';
		isp2.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='No';
		isp2.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c='No';
		isp2.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='No';
		isp2.CQS_IspQ_Etichette_identificative_cavo1__c='No';
		isp2.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='No';
		//End Sez Armadi
		
		//Start sez Armadi PTE/PTA
		isp2.CQS_IspQ_Caratteristiche_PTE_previste_NT__c='No';
		isp2.CQS_IspQ_PTE_correttamente_staffato__c='No';
		isp2.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='No';
		isp2.CQS_IspQ_Etichette_identificative_cavo2__c='No';

		//End Sez Armadi PTE/PTA
		
		//START SEZ Gestione Rifiuti a Lavorazioni Concluse
		isp2.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='No';
		//END SEZ Gestione Rifiuti a Lavorazioni Concluse
		
		insert isp2;

		//Si No N/A

 		OF_CQS_Ispezione__c isp3 = new OF_CQS_Ispezione__c();
        isp3.CQS_ISP_LDO__c = '111111111';
		isp3.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp3.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp3.RecordTypeId=RecordTypeIdevent;
        //isp3.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp3.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp3.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp3.OF_CQS_ISP_Lotto__c='Test';
        isp3.OF_CQS_ISP_VIA__c = 'test';
         isp3.OF_CQS_ISP_CAP__c = '';
        isp3.OF_CQS_ISP_Comune__c = 'test';
        isp3.OF_CQS_ISP_Provincia__c = 'test';
		isp3.OF_CQS_ISP_Numero_Civico__c='12';
		isp3.OF_CQS_ISP_Area_Cavo__c='12';
        isp3.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp3.CQS_ISP_Autorizzazione_Scavo__c= True;
		isp3.CQS_ISP_Scavo_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Infrastrutture__c= True;
		isp3.CQS_ISP_Infrastrutture_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Posa_cavi__c= True;
		isp3.CQS_ISP_Posa_Cavi_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Ripristini__c= True;
		isp3.CQS_ISP_Ripristini_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Verticale__c= True;
		isp3.CQS_ISP_Verticale_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Giunzione__c= True;
		isp3.CQS_ISP_Giunzione_inEsecuzione__c= True;
		isp3.CQS_ISP_Opere_Site_Preparation_POP__c= True;
		isp3.CQS_ISP_Opere_Site_Preparation_inEsec__c= True;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		
		//End sez. Lavoratori
		
		//Start Sez Documentazione
		isp3.CQS_IspQ_Presenza_planimetrie_entige__c='N/A';
		isp3.CQS_IspQ_Presenza_planimetrie_georadar__c='N/A';
		isp3.CQS_IspQ_Presenza_Progetto_lancio_noDig__c='N/A';
		isp3.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='N/A';
		isp3.CQS_IspQ_Permessi_rilasciati_con_deroghe__c='N/A';
		isp3.CQS_IspQ_Schede_tec_conf_DT_rapp_prova__c='N/A';
		isp3.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c='N/A';
		isp3.CQS_IspQ_Agg_GIS_completo_corretto__c='N/A';
		isp3.CQS_IspQ_contabilita_lavori_xSistInfOK__c='N/A';
		isp3.Evidenze_comunicazioni_propriet_cliente__c='N/A';
		//End Sez Documentazione
		
		//Start Sez Organizzazione del cantiere
		
		isp3.CQS_IspQ_Apposizione_cartelli_cantiereOK__c='N/A';
		isp3.CQS_IspQ_AreaCantiere_del_stoc_materiali__c='N/A';
		isp3.CQS_IspQ_Conformita_stoccaggio_materiali__c='N/A';
		isp3.CQS_IspQ_Tracciato_conf_prog_aut__c='N/A';
		isp3.CQS_IspQ_Sottoservizi_segnalati_asfalto__c='N/A';
		isp3.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='N/A';
		isp3.CQS_IspQ_DPI_previsti_indossati__c='N/A';

		//END Sez Organizzazione del cantiere
		
		//Start Sez Scavi
		isp3.CQS_IspQ_Scavo_netto_lineare__c='N/A';
		isp3.CQS_IspQ_Profondita_scavo_conforme__c='N/A';
		isp3.CQS_IspQ_Larghezza_scavo_conforme__c='N/A';
		isp3.CQS_IspQ_Fondo_scavo_pulito__c='N/A';
		isp3.CQS_IspQ_segnalatore_30cm_piano_calp__c='N/A';
		isp3.CQS_IspQ_Cambi_Bruschi_evitati__c='N/A';
		//End Sez Scavi
		
		//Start Sez Infrastrutture
		isp3.CQS_IspQ_SupAppoggio_pozzetto_OK__c='N/A';
		isp3.CQS_IspQ_Chiusino_compl_piano_calpestio__c='N/A';
		isp3.CQS_IspQ_Pozzetto_conf_sp_tecniche__c='N/A';
		isp3.CQS_IspQ_Chiusino_conf_sp_tecniche__c='N/A';
		isp3.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c='N/A';
		isp3.CQS_IspQ_Corretta_fratturazione_pozzetto__c='N/A';
		isp3.CQS_IspQ_Ingresso_minitu_pozz_prot_mono__c='N/A';
		isp3.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c='N/A';
		isp3.CQS_IspQ_Malta_sigilla_ingr_monotubi__c='N/A';
		isp3.CQS_IspQ_tubi_posati_conformi_NT__c='N/A';
		isp3.CQS_IspQ_N_tubi_posati_conformi_progetto__c='N/A';
		isp3.CQS_IspQ_Ingresso_al_building_posaOK__c='N/A';
		isp3.CQS_IspQ_Ingresso_building_esecuzione_OK__c='N/A';
		isp3.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='N/A';
		//End Sez Infrastrutture
		
		//Start sez Ripristini provvisori
		isp3.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='N/A';
		isp3.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c='N/A';
		isp3.CQS_IspQ_Mat_riempimento_conforme_spec__c='N/A';
		isp3.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='N/A';
		isp3.CQS_IspQ_Corretta_cilindr_rullo_compr__c='N/A';
		isp3.CQS_IspQ_Stendimento_idonea_graniglia__c='N/A';
		//End sez Ripristini provvisori
		
		//Start sez Gestione Rifiuti
		isp3.CQS_IspQ_Mat_trasp_discarica_autorizz__c='N/A';
		isp3.CQS_IspQ_gestione_compilazione_FIR_OK__c='N/A';
		isp3.CQS_Isp_Gest_comp_registro_car_scar_OK__c='N/A';
		isp3.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='N/A';
		isp3.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='N/A';
		isp3.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='N/A';
		isp3.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='N/A';
		//End Sez Gestione Rifiuti
		
		//Start Sez Ripristino definitivo
		isp3.CQS_IspQ_Scarifica_idonea_largh_prof__c='N/A';
		isp3.CQS_IspQ_Manto_stradale_ripristinato_OK__c='N/A';
		isp3.CQS_IspQ_Manto_usura_ripristinato_OK__c='N/A';
		isp3.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='N/A';
		isp3.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='N/A';
		isp3.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='N/A';
		isp3.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='N/A';
		//End Sez. Ripristino definitivo
		
		//Start sez Materiali
		isp3.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='N/A';
		isp3.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='N/A';
		isp3.CQS_IspQ_Mat_conformi_spec_tec_OF__c='N/A';
		//End Sez. Materiali
		
		//Start sez. Muffola PFP
		isp3.CQS_IspQ_SupAppoggio_pozzetto_OK2__c='N/A';
		isp3.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='N/A';
		isp3.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='N/A';
		isp3.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='N/A';
		isp3.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='N/A';
		isp3.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='N/A';
		isp3.Minitubi_non_usati_chiusi_idonei_tappi__c='N/A';
		isp3.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='N/A';
		isp3.CQS_IspQ_Tenuta_pneum_apressione_muff__c='N/A';
		//End Sez. Muffola PFP
		
		//Start Sez Armadi
		isp3.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='N/A';
		isp3.CQS_IspQ_Basamento_PFS__c='N/A';
		isp3.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='N/A';
		isp3.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c='N/A';
		isp3.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='N/A';
		isp3.CQS_IspQ_Etichette_identificative_cavo1__c='N/A';
		isp3.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='N/A';
		//End Sez Armadi
		
		//Start sez Armadi PTE/PTA
		isp3.CQS_IspQ_Caratteristiche_PTE_previste_NT__c='N/A';
		isp3.CQS_IspQ_PTE_correttamente_staffato__c='N/A';
		isp3.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='N/A';
		isp3.CQS_IspQ_Etichette_identificative_cavo2__c='N/A';

		//End Sez Armadi PTE/PTA
		
		//START SEZ Gestione Rifiuti a Lavorazioni Concluse
		isp3.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='N/A';
		//END SEZ Gestione Rifiuti a Lavorazioni Concluse
		
		insert isp3;
		
		//Si No N/A

 		OF_CQS_Ispezione__c isp4 = new OF_CQS_Ispezione__c();
        isp4.CQS_ISP_LDO__c = '111111111';
		isp4.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp4.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp4.RecordTypeId=RecordTypeIdevent;
        //isp4.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp4.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp4.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp4.OF_CQS_ISP_Lotto__c='Test';
        isp4.OF_CQS_ISP_VIA__c = 'test';
         isp4.OF_CQS_ISP_CAP__c = '';
        isp4.OF_CQS_ISP_Comune__c = 'test';
        isp4.OF_CQS_ISP_Provincia__c = 'test';
		isp4.OF_CQS_ISP_Numero_Civico__c='12';
		isp4.OF_CQS_ISP_Area_Cavo__c='12';
        isp4.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp4.CQS_ISP_Autorizzazione_Scavo__c= false;
		isp4.CQS_ISP_Scavo_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Infrastrutture__c= false;
		isp4.CQS_ISP_Infrastrutture_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Posa_cavi__c= false;
		isp4.CQS_ISP_Posa_Cavi_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Ripristini__c= false;
		isp4.CQS_ISP_Ripristini_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Verticale__c= false;
		isp4.CQS_ISP_Verticale_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Giunzione__c= false;
		isp4.CQS_ISP_Giunzione_inEsecuzione__c= false;
		isp4.CQS_ISP_Opere_Site_Preparation_POP__c= false;
		isp4.CQS_ISP_Opere_Site_Preparation_inEsec__c= false;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp4.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp4.Cqs_Isp_Autorizzato__c= 'No';
		isp4.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp4.CQS_Isp_Autorizzato2__c = 'No';
		isp4.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp4.CQS_ISP_Autorizzato3__c = 'No';
		
		//End sez. Lavoratori
		
		//Start Sez Documentazione
		isp4.CQS_IspQ_Presenza_planimetrie_entige__c= 'No';
		isp4.CQS_IspQ_Presenza_planimetrie_georadar__c='No';
		isp4.CQS_IspQ_Presenza_Progetto_lancio_noDig__c='No';
		isp4.CQS_IspQ_Prog_aggiornato_x_lavorazioni__c='No';
		isp4.CQS_IspQ_Permessi_rilasciati_con_deroghe__c='No';
		isp4.CQS_IspQ_Schede_tec_conf_DT_rapp_prova__c='No';
		isp4.CQS_IspQ_NotPrel_xmesso_enti_CartelloCar__c='No';
		isp4.CQS_IspQ_Agg_GIS_completo_corretto__c='No';
		isp4.CQS_IspQ_contabilita_lavori_xSistInfOK__c='No';
		isp4.Evidenze_comunicazioni_propriet_cliente__c='No';
		//End Sez Documentazione
		
		//Start Sez Organizzazione del cantiere
		
		isp4.CQS_IspQ_Apposizione_cartelli_cantiereOK__c='No';
		isp4.CQS_IspQ_AreaCantiere_del_stoc_materiali__c='No';
		isp4.CQS_IspQ_Conformita_stoccaggio_materiali__c='No';
		isp4.CQS_IspQ_Tracciato_conf_prog_aut__c='No';
		isp4.CQS_IspQ_Sottoservizi_segnalati_asfalto__c='No';
		isp4.CQS_IspQ_Att_Conf_No_Segn_Var_DLL__c='No';
		isp4.CQS_IspQ_DPI_previsti_indossati__c='No';

		//END Sez Organizzazione del cantiere
		
		//Start Sez Scavi
		isp4.CQS_IspQ_Scavo_netto_lineare__c='No';
		isp4.CQS_IspQ_Profondita_scavo_conforme__c='No';
		isp4.CQS_IspQ_Larghezza_scavo_conforme__c='No';
		isp4.CQS_IspQ_Fondo_scavo_pulito__c='No';
		isp4.CQS_IspQ_segnalatore_30cm_piano_calp__c='No';
		isp4.CQS_IspQ_Cambi_Bruschi_evitati__c='No';
		//End Sez Scavi
		
		//Start Sez Infrastrutture
		isp4.CQS_IspQ_SupAppoggio_pozzetto_OK__c='No';
		isp4.CQS_IspQ_Chiusino_compl_piano_calpestio__c='No';
		isp4.CQS_IspQ_Pozzetto_conf_sp_tecniche__c='No';
		isp4.CQS_IspQ_Chiusino_conf_sp_tecniche__c='No';
		isp4.CQS_IspQ_Scavo_man_discesa_tubi_pozzetto__c='No';
		isp4.CQS_IspQ_Corretta_fratturazione_pozzetto__c='No';
		isp4.CQS_IspQ_Ingresso_minitu_pozz_prot_mono__c='No';
		isp4.CQS_IspQ_Rientro_monotubo_pozzetto_OK__c='No';
		isp4.CQS_IspQ_Malta_sigilla_ingr_monotubi__c='No';
		isp4.CQS_IspQ_tubi_posati_conformi_NT__c='No';
		isp4.CQS_IspQ_N_tubi_posati_conformi_progetto__c='No';
		isp4.CQS_IspQ_Ingresso_al_building_posaOK__c='No';
		isp4.CQS_IspQ_Ingresso_building_esecuzione_OK__c='No';
		isp4.CQS_IspQ_Esec_foro_muro_perim_edificioOK__c='No';
		//End Sez Infrastrutture
		
		//Start sez Ripristini provvisori
		isp4.CQS_IspQ_Ripr_1_2tempo_conf_NT_Istr_Prog__c='No';
		isp4.CQS_IspQ_No_diff_quota_p_strad_riem_sc__c='No';
		isp4.CQS_IspQ_Mat_riempimento_conforme_spec__c='No';
		isp4.CQS_IspQ_Posa_opera_conglom_mezzo_vibrof__c='No';
		isp4.CQS_IspQ_Corretta_cilindr_rullo_compr__c='No';
		isp4.CQS_IspQ_Stendimento_idonea_graniglia__c='No';
		//End sez Ripristini provvisori
		
		//Start sez Gestione Rifiuti
		isp4.CQS_IspQ_Mat_trasp_discarica_autorizz__c='No';
		isp4.CQS_IspQ_gestione_compilazione_FIR_OK__c='No';
		isp4.CQS_Isp_Gest_comp_registro_car_scar_OK__c='No';
		isp4.CQS_IspQ_Identif_tipi_rifiuti_presenti__c='No';
		isp4.CQS_IspQ_Iscr_Albo_Gest_Ambientali_MUD__c='No';
		isp4.CQS_IspQ_Pres_lic_autotrasp_conto_3i__c='No';
		isp4.CQS_IspQ_Pulizia_ok_postLav_NT_Istr__c='No';
		//End Sez Gestione Rifiuti
		
		//Start Sez Ripristino definitivo
		isp4.CQS_IspQ_Scarifica_idonea_largh_prof__c='No';
		isp4.CQS_IspQ_Manto_stradale_ripristinato_OK__c='No';
		isp4.CQS_IspQ_Manto_usura_ripristinato_OK__c='No';
		isp4.CQS_IspQ_Eseguita_sabbiatura_manto_usura__c='No';
		isp4.CQS_IspQ_Riutilizzo_elementi_pavim_prees__c='No';
		isp4.CQS_IspQ_Ripr_segnaletica_orizz_vert__c='No';
		isp4.CQS_IspQ_Opere_finitura_pavimentazioneOK__c='No';
		//End Sez. Ripristino definitivo
		
		//Start sez Materiali
		isp4.CQS_IspQ_Marcatura_chiusini_NT_Istr_Prog__c='No';
		isp4.CQS_IspQ_Verifica_tipo_CLS_riempimenti__c='No';
		isp4.CQS_IspQ_Mat_conformi_spec_tec_OF__c='No';
		//End Sez. Materiali
		
		//Start sez. Muffola PFP
		isp4.CQS_IspQ_SupAppoggio_pozzetto_OK2__c='No';
		isp4.CQS_IspQ_UbiInstal_Muffola_StaffOK__c='No';
		isp4.CQS_IspQ_TAG_RFID_BARCODE_su_elementi1__c='No';
		isp4.CQS_IspQ_Tenuta_pneumatica_muffola_OK__c='No';
		isp4.CQS_IspQ_Sistem_spl_fibre_mod_giun__c='No';
		isp4.CQS_IspQ_Rispetto_NT_scorte_minicavo__c='No';
		isp4.Minitubi_non_usati_chiusi_idonei_tappi__c='No';
		isp4.CQS_IspQ_Minitubi_posati_in_modo_idoneo__c='No';
		isp4.CQS_IspQ_Tenuta_pneum_apressione_muff__c='No';
		//End Sez. Muffola PFP
		
		//Start Sez Armadi
		isp4.CQS_IspQ_Caratteristiche_PFS_previste_NT__c='No';
		isp4.CQS_IspQ_Basamento_PFS__c='No';
		isp4.CQS_IspQ_Posiz_PFS_conf_NT_prog_prescr__c='No';
		isp4.CQS_IspQ_Risp_NT_ingr_tub_nel_basamento__c='No';
		isp4.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='No';
		isp4.CQS_IspQ_Etichette_identificative_cavo1__c='No';
		isp4.CQS_IspQ_Sist_cavi_tubetti_ingr_arm_OK__c='No';
		//End Sez Armadi
		
		//Start sez Armadi PTE/PTA
		isp4.CQS_IspQ_Caratteristiche_PTE_previste_NT__c='No';
		isp4.CQS_IspQ_PTE_correttamente_staffato__c='No';
		isp4.CQS_IspQ_TAG_RFID_BARCODE_su_elementi2__c='No';
		isp4.CQS_IspQ_Etichette_identificative_cavo2__c='No';

		//End Sez Armadi PTE/PTA
		
		//START SEZ Gestione Rifiuti a Lavorazioni Concluse
		isp4.CQS_IspQ_Pulizia_post_lav_NT_Istr_OK_LT__c='No';
		//END SEZ Gestione Rifiuti a Lavorazioni Concluse
		
		insert isp4;

		 Test.startTest();
		
		CQS_Utils.calcolaPunteggio(isp);
		CQS_Utils.calcolaPunteggio(isp2);
		CQS_Utils.calcolaPunteggio(isp3);
		CQS_Utils.calcolaPunteggio(isp4);
	  
        Test.stopTest();
		
 }
   
}
	static testmethod void calcolaPunteggioIspOldRT(){
   	List<OF_CQS_Ispezione__c> ispList = new List<OF_CQS_Ispezione__c>();
   
		  //Id RecordTypeIdevent = Schema.SObjectType.OF_CQS_Evento__c.getRecordTypeInfosByName().get('Danneggiamento a Terzi').getRecordTypeId();
           Id RecordTypeIdevent =[Select id,DeveloperName from RecordType where SobjectType='OF_CQS_Ispezione__c' and DeveloperName = 'OF_CQS_Ispezioni_DL'].id;
		   String s='Sì';
		   String n='No';
		   String na = 'N/A';
			
            UserRole ur4 = new UserRole();
            ur4.Name = 'RE';
            insert ur4;
            UserRole ur3 = new UserRole();
            ur3.Name = 'HSE';
            ur3.ParentRoleId = ur4.Id;
            insert ur3;
            UserRole r2 = new UserRole();
            r2.Name = 'Area Manager';
            r2.ParentRoleId = ur3.Id;
            insert r2;
            UserRole r = new UserRole();
            r.Name = 'City Manager Centro';
            r.ParentRoleId = r2.Id;
            insert r; 
            
            Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
            // UserRole r= [select id, ParentRoleId from UserRole where Name='City Manager Centro' LIMIT 1];
              List<Id> UserListId = new List<Id>();
           
            
            User usr4 = new User();
            usr4.Alias = 'standt';
            usr4.Email='standarduser@testorg.com';
            usr4.EmailEncodingKey='UTF-8';
            usr4.LastName='Testing';
            usr4.LanguageLocaleKey='en_US'; 
            usr4.LocaleSidKey='en_US';
            usr4.ProfileId = profileId.id;
            usr4.TimeZoneSidKey='America/Los_Angeles';
            usr4.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr4.UserRoleId = ur4.id;
            insert usr4;
            User usr3 = new User();
            usr3.Alias = 'standt';
            usr3.Email='standarduser@testorg.com';
            usr3.EmailEncodingKey='UTF-8';
            usr3.LastName='Testing';
            usr3.LanguageLocaleKey='en_US'; 
            usr3.LocaleSidKey='en_US';
            usr3.ProfileId = profileId.id;
            usr3.TimeZoneSidKey='America/Los_Angeles';
            usr3.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr3.UserRoleId = ur3.id;
            insert usr3;
            User usr2 = new User();
            usr2.Alias = 'standt';
            usr2.Email='standarduser@testorg.com';
            usr2.EmailEncodingKey='UTF-8';
            usr2.LastName='Testing';
            usr2.LanguageLocaleKey='en_US'; 
            usr2.LocaleSidKey='en_US';
            usr2.ProfileId = profileId.id;
            usr2.TimeZoneSidKey='America/Los_Angeles';
            usr2.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr2.UserRoleId = r2.id;
            insert usr2;
            User usr = new User();
            usr.Alias = 'standt';
            usr.Email='standarduser@testorg.com';
            usr.EmailEncodingKey='UTF-8';
            usr.LastName='Testing';
            usr.LanguageLocaleKey='en_US'; 
            usr.LocaleSidKey='en_US';
            usr.ProfileId = profileId.id;
            usr.TimeZoneSidKey='America/Los_Angeles';
            usr.UserName=String.valueOf(system.now().gettime())+'@testorg.com';
            usr.UserRoleId = r.id;
            insert usr;
            
            UserListId.add(usr.id);
            UserListId.add(usr2.id);
            UserListId.add(usr3.id);
            UserListId.add(usr4.id);
            
        	
            system.runAs(usr){
                OF_CQS_Anagrafica__c anag = new OF_CQS_Anagrafica__c();
                anag.CQS_Check_Affidataria__c = true;
                anag.OF_CQS_Indirizzo_Email__c = 'test@gmail.com';
                anag.Name = 'AMTECO';
                insert anag;
                
                CQS_Progetto__c pro = new CQS_Progetto__c();
                pro.CQS_Pro_Area__c = 'Test';
                pro.CQS_Pro_Impresa_Affidataria__c = anag.Id;
                insert pro;
                Progetto_Utente_junction__c projen = new Progetto_Utente_junction__c();
                projen.CQS_junc_progetto__c = pro.Id;
                projen.CQS_junc_user__c = usr.id;
                insert projen;
				
				 
                CQS_Prog_An_junc__c prog = new CQS_Prog_An_junc__c();
                prog.CQS_Praj_Progetto__c = pro.Id;
                prog.CQS_Paj_Email_Affidataria__c = 'test@gmail.com';
                prog.CQS_Praj_Ragione_Sociale__c = anag.Id;
                insert prog;
		
        
		
        OF_CQS_Ispezione__c isp = new OF_CQS_Ispezione__c();
        isp.CQS_ISP_LDO__c = '111111111';
		isp.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp.RecordTypeId=RecordTypeIdevent;
        //isp.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp.OF_CQS_ISP_Lotto__c='Test';
        isp.OF_CQS_ISP_VIA__c = 'test';
         isp.OF_CQS_ISP_CAP__c = '';
        isp.OF_CQS_ISP_Comune__c = 'test';
        isp.OF_CQS_ISP_Provincia__c = 'test';
		isp.OF_CQS_ISP_Numero_Civico__c='12';
		isp.OF_CQS_ISP_Area_Cavo__c='12';
        isp.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp.CQS_ISP_Autorizzazione_Scavo__c= True;
		isp.CQS_ISP_Scavo_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Infrastrutture__c= True;
		isp.CQS_ISP_Infrastrutture_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Posa_cavi__c= True;
		isp.CQS_ISP_Posa_Cavi_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Ripristini__c= True;
		isp.CQS_ISP_Ripristini_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Verticale__c= True;
		isp.CQS_ISP_Verticale_inEsecuzione__c= True;
		isp.CQS_ISP_Autorizzazione_Giunzione__c= True;
		isp.CQS_ISP_Giunzione_inEsecuzione__c= True;
		isp.CQS_ISP_Opere_Site_Preparation_POP__c= True;
		isp.CQS_ISP_Opere_Site_Preparation_inEsec__c= True;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp.Cqs_Isp_Autorizzato__c= 'Sì';
		isp.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp.CQS_Isp_Autorizzato2__c = 'Sì';
		isp.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp.CQS_ISP_Autorizzato3__c = 'Sì';
		
		//End sez. Lavoratori
		
		

		isp.CQS_ISP_PSC__c =s;
		isp.CQS_ISP_POS__c =s;
		isp.CQS_ISP_Notifica_prel_corretta_valida__c =s;
		isp.CQS_ISP_DURC_regolare__c =s;
		isp.CQS_ISP_Attivita_Imprese_autorizzate_OF__c =s;
		isp.CQS_ISP_Autorizzazione_amm_competente__c =s;
		isp.CQS_ISP_Presenza_prog_cartografie_enti__c =s;
		isp.CQS_ISP_indagini_preventive_scavo__c =s;
		isp.CQS_ISP_Accantieramento_conforme__c =s;
		isp.CQS_ISP_Esposizione_Cartello__c =s;
		isp.CQS_ISP_RispettoCodice_SegnaleticaStrada__c =s;
		isp.CQS_ISP_Idoneit_delimit_Cantiere_AD__c =s;
		isp.CQS_ISP_Buono_stato_cartellonistica__c =s;
		isp.CQS_ISP_assicurata_viabilita__c =s;
		isp.CQS_ISP_Passaggi_su_scavi_idonei__c =s;
		isp.CQS_ISP_Pozzetti_non_pericolosi__c =s;
		isp.CQS_ISP_Presenza_WC__c =s;
		isp.CQS_ISP_Presenti_autorizzati__c  =s;
		isp.CQS_ISP_Tesserino_Check__c =s;
		isp.CQS_ISP_Preposto_Cantiere_Presente__c =s;
		isp.CQS_ISP_Addetto_PS_presente__c =s;
		isp.CQS_ISP_Addetto_Antincendio_presente__c =s;
		isp.CQS_ISP_DPI_idonei_in_dotazione__c =s;
		isp.CQS_ISP_DPI_lavorazioni_in_quota__c =s;
		isp.CQS_ISP_DPI_rischio_elettrico__c =s;
		isp.Presenza_Moviere_qualora_necessario__c =s;
		isp.Personale_dotato_di_quanto_richiesto__c =s;
		isp.CQS_ISP_Mezzi_Attrezzature_autorizati__c  =s;
		isp.CQS_ISP_conformita_mezzi_attrezzature__c =s;
		isp.CQS_ISP_Documentazione_verifiche_legge__c =s;
		isp.CQS_ISP_Marcatura_CE__c =s;
		isp.CQS_ISP_Documentazione_noli_a_freddo__c =s;
		isp.CQS_ISP_attrezzature_sollevamento__c =s;
		isp.Cassetta_primo_soccorso_conforme__c  =s;
		isp.CQS_Estintore_con_cartellino_e_revisione__c =s;
		isp.Autorizzazioni_ENEL_prossimit_E_Distrib__c  =s;
		isp.CQS_ISP_Presenza_Profili_E_Distrib__c =s;
        isp.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c=s;
		
        insert isp;
		
		OF_CQS_Ispezione__c isp2 = new OF_CQS_Ispezione__c();
        isp2.CQS_ISP_LDO__c = '111111111';
		isp2.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp2.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp2.RecordTypeId=RecordTypeIdevent;
        //isp2.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp2.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp2.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp2.OF_CQS_ISP_Lotto__c='Test';
        isp2.OF_CQS_ISP_VIA__c = 'test';
         isp2.OF_CQS_ISP_CAP__c = '';
        isp2.OF_CQS_ISP_Comune__c = 'test';
        isp2.OF_CQS_ISP_Provincia__c = 'test';
		isp2.OF_CQS_ISP_Numero_Civico__c='12';
		isp2.OF_CQS_ISP_Area_Cavo__c='12';
        isp2.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp2.CQS_ISP_Autorizzazione_Scavo__c= True;
		isp2.CQS_ISP_Scavo_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Infrastrutture__c= True;
		isp2.CQS_ISP_Infrastrutture_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Posa_cavi__c= True;
		isp2.CQS_ISP_Posa_Cavi_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Ripristini__c= True;
		isp2.CQS_ISP_Ripristini_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Verticale__c= True;
		isp2.CQS_ISP_Verticale_inEsecuzione__c= True;
		isp2.CQS_ISP_Autorizzazione_Giunzione__c= True;
		isp2.CQS_ISP_Giunzione_inEsecuzione__c= True;
		isp2.CQS_ISP_Opere_Site_Preparation_POP__c= True;
		isp2.CQS_ISP_Opere_Site_Preparation_inEsec__c= True;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp2.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp2.Cqs_Isp_Autorizzato__c= s;
		isp2.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp2.CQS_Isp_Autorizzato2__c = s;
		isp2.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp2.CQS_ISP_Autorizzato3__c = s;
		
		//End sez. Lavoratori
		
		isp2.CQS_ISP_PSC__c =n;
		isp2.CQS_ISP_POS__c =n;
		isp2.CQS_ISP_Notifica_prel_corretta_valida__c =n;
		isp2.CQS_ISP_DURC_regolare__c =n;
		isp2.CQS_ISP_Attivita_Imprese_autorizzate_OF__c =n;
		isp2.CQS_ISP_Autorizzazione_amm_competente__c =n;
		isp2.CQS_ISP_Presenza_prog_cartografie_enti__c =n;
		isp2.CQS_ISP_indagini_preventive_scavo__c =n;
		isp2.CQS_ISP_Accantieramento_conforme__c =n;
		isp2.CQS_ISP_Esposizione_Cartello__c =n;
		isp2.CQS_ISP_RispettoCodice_SegnaleticaStrada__c =n;
		isp2.CQS_ISP_Idoneit_delimit_Cantiere_AD__c =n;
		isp2.CQS_ISP_Buono_stato_cartellonistica__c =n;
		isp2.CQS_ISP_assicurata_viabilita__c =n;
		isp2.CQS_ISP_Passaggi_su_scavi_idonei__c =n;
		isp2.CQS_ISP_Pozzetti_non_pericolosi__c =n;
		isp2.CQS_ISP_Presenza_WC__c =n;
		isp2.CQS_ISP_Presenti_autorizzati__c  =n;
		isp2.CQS_ISP_Tesserino_Check__c =n;
		isp2.CQS_ISP_Preposto_Cantiere_Presente__c =n;
		isp2.CQS_ISP_Addetto_PS_presente__c =n;
		isp2.CQS_ISP_Addetto_Antincendio_presente__c =n;
		isp2.CQS_ISP_DPI_idonei_in_dotazione__c =n;
		isp2.CQS_ISP_DPI_lavorazioni_in_quota__c =n;
		isp2.CQS_ISP_DPI_rischio_elettrico__c =n;
		isp2.Presenza_Moviere_qualora_necessario__c =n;
		isp2.Personale_dotato_di_quanto_richiesto__c =n;
		isp2.CQS_ISP_Mezzi_Attrezzature_autorizati__c  =n;
		isp2.CQS_ISP_conformita_mezzi_attrezzature__c =n;
		isp2.CQS_ISP_Documentazione_verifiche_legge__c =n;
		isp2.CQS_ISP_Marcatura_CE__c =n;
		isp2.CQS_ISP_Documentazione_noli_a_freddo__c =n;
		isp2.CQS_ISP_attrezzature_sollevamento__c =n;
		isp2.Cassetta_primo_soccorso_conforme__c  =n;
		isp2.CQS_Estintore_con_cartellino_e_revisione__c =n;
		isp2.Autorizzazioni_ENEL_prossimit_E_Distrib__c  =n;
		isp2.CQS_ISP_Presenza_Profili_E_Distrib__c =n;
		isp2.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c=n;
                
		insert isp2;

		//Si No N/A

		OF_CQS_Ispezione__c isp3 = new OF_CQS_Ispezione__c();
        isp3.CQS_ISP_LDO__c = '111111111';
		isp3.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp3.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp3.RecordTypeId=RecordTypeIdevent;
        //isp3.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp3.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp3.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp3.OF_CQS_ISP_Lotto__c='Test';
        isp3.OF_CQS_ISP_VIA__c = 'test';
         isp3.OF_CQS_ISP_CAP__c = '';
        isp3.OF_CQS_ISP_Comune__c = 'test';
        isp3.OF_CQS_ISP_Provincia__c = 'test';
		isp3.OF_CQS_ISP_Numero_Civico__c='12';
		isp3.OF_CQS_ISP_Area_Cavo__c='12';
        isp3.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp3.CQS_ISP_Autorizzazione_Scavo__c= True;
		isp3.CQS_ISP_Scavo_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Infrastrutture__c= True;
		isp3.CQS_ISP_Infrastrutture_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Posa_cavi__c= True;
		isp3.CQS_ISP_Posa_Cavi_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Ripristini__c= True;
		isp3.CQS_ISP_Ripristini_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Verticale__c= True;
		isp3.CQS_ISP_Verticale_inEsecuzione__c= True;
		isp3.CQS_ISP_Autorizzazione_Giunzione__c= True;
		isp3.CQS_ISP_Giunzione_inEsecuzione__c= True;
		isp3.CQS_ISP_Opere_Site_Preparation_POP__c= True;
		isp3.CQS_ISP_Opere_Site_Preparation_inEsec__c= True;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp3.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp3.Cqs_Isp_Autorizzato__c= s;
		isp3.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp3.CQS_Isp_Autorizzato2__c = s;
		isp3.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp3.CQS_ISP_Autorizzato3__c = s;
		
		//End sez. Lavoratori
		
		isp3.CQS_ISP_PSC__c =na;
		isp3.CQS_ISP_POS__c =na;
		isp3.CQS_ISP_Notifica_prel_corretta_valida__c =na;
		isp3.CQS_ISP_DURC_regolare__c =na;
		isp3.CQS_ISP_Attivita_Imprese_autorizzate_OF__c =na;
		isp3.CQS_ISP_Autorizzazione_amm_competente__c =na;
		isp3.CQS_ISP_Presenza_prog_cartografie_enti__c =na;
		isp3.CQS_ISP_indagini_preventive_scavo__c =na;
		isp3.CQS_ISP_Accantieramento_conforme__c =na;
		isp3.CQS_ISP_Esposizione_Cartello__c =na;
		isp3.CQS_ISP_RispettoCodice_SegnaleticaStrada__c =na;
		isp3.CQS_ISP_Idoneit_delimit_Cantiere_AD__c =na;
		isp3.CQS_ISP_Buono_stato_cartellonistica__c =na;
		isp3.CQS_ISP_assicurata_viabilita__c =na;
		isp3.CQS_ISP_Passaggi_su_scavi_idonei__c =na;
		isp3.CQS_ISP_Pozzetti_non_pericolosi__c =na;
		isp3.CQS_ISP_Presenza_WC__c =na;
		isp3.CQS_ISP_Presenti_autorizzati__c  =na;
		isp3.CQS_ISP_Tesserino_Check__c =na;
		isp3.CQS_ISP_Preposto_Cantiere_Presente__c =na;
		isp3.CQS_ISP_Addetto_PS_presente__c =na;
		isp3.CQS_ISP_Addetto_Antincendio_presente__c =na;
		isp3.CQS_ISP_DPI_idonei_in_dotazione__c =na;
		isp3.CQS_ISP_DPI_lavorazioni_in_quota__c =na;
		isp3.CQS_ISP_DPI_rischio_elettrico__c =na;
		isp3.Presenza_Moviere_qualora_necessario__c =na;
		isp3.Personale_dotato_di_quanto_richiesto__c =na;
		isp3.CQS_ISP_Mezzi_Attrezzature_autorizati__c  =na;
		isp3.CQS_ISP_conformita_mezzi_attrezzature__c =na;
		isp3.CQS_ISP_Documentazione_verifiche_legge__c =na;
		isp3.CQS_ISP_Marcatura_CE__c =na;
		isp3.CQS_ISP_Documentazione_noli_a_freddo__c =na;
		isp3.CQS_ISP_attrezzature_sollevamento__c =na;
		isp3.Cassetta_primo_soccorso_conforme__c  =na;
		isp3.CQS_Estintore_con_cartellino_e_revisione__c =na;
		isp3.Autorizzazioni_ENEL_prossimit_E_Distrib__c  =na;
		isp3.CQS_ISP_Presenza_Profili_E_Distrib__c =na;
        isp3.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c=na;
		
		insert isp3;
		
		//Si No N/A

		OF_CQS_Ispezione__c isp4 = new OF_CQS_Ispezione__c();
        isp4.CQS_ISP_LDO__c = '111111111';
		isp4.OF_CQS_Impresa_Mandataria__c=anag.id;
		isp4.OF_CQS_Impresa_Ispezionata__c=anag.id;
		
		isp4.RecordTypeId=RecordTypeIdevent;
        //isp4.Ora_Inizio_Sopralluogo__c = 'Test'; 
        isp4.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018, 3, 15, 12, 30, 0);
		//isp4.OF_CQS_Data_Ispezione__c =system.today()-1;
		
		isp4.OF_CQS_ISP_Lotto__c='Test';
        isp4.OF_CQS_ISP_VIA__c = 'test';
         isp4.OF_CQS_ISP_CAP__c = '';
        isp4.OF_CQS_ISP_Comune__c = 'test';
        isp4.OF_CQS_ISP_Provincia__c = 'test';
		isp4.OF_CQS_ISP_Numero_Civico__c='12';
		isp4.OF_CQS_ISP_Area_Cavo__c='12';
        isp4.CQS_ISP_Progetto__c=pro.id;
		
		//start sez lavorazioni
		
		isp4.CQS_ISP_Autorizzazione_Scavo__c= false;
		isp4.CQS_ISP_Scavo_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Infrastrutture__c= false;
		isp4.CQS_ISP_Infrastrutture_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Posa_cavi__c= false;
		isp4.CQS_ISP_Posa_Cavi_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Ripristini__c= false;
		isp4.CQS_ISP_Ripristini_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Verticale__c= false;
		isp4.CQS_ISP_Verticale_inEsecuzione__c= false;
		isp4.CQS_ISP_Autorizzazione_Giunzione__c= false;
		isp4.CQS_ISP_Giunzione_inEsecuzione__c= false;
		isp4.CQS_ISP_Opere_Site_Preparation_POP__c= false;
		isp4.CQS_ISP_Opere_Site_Preparation_inEsec__c= false;
		
		//end sez lavorazioni
		
		//Start sez Lavoratori
		
		isp4.CQS_ISP_Nome_Cognome__c='Mario Rossi';
		isp4.Cqs_Isp_Autorizzato__c= n;
		isp4.CQS_Isp_Nome_Cognome2__c = 'Pinco Pallo';
		isp4.CQS_Isp_Autorizzato2__c = n;
		isp4.CQS_ISP_Nome_Cognome3__c = 'Test';
		isp4.CQS_ISP_Autorizzato3__c = n;
		
		//End sez. Lavoratori
		
		isp4.CQS_ISP_PSC__c =s;
		isp4.CQS_ISP_POS__c =s;
		isp4.CQS_ISP_Notifica_prel_corretta_valida__c =s;
		isp4.CQS_ISP_DURC_regolare__c =s;
		isp4.CQS_ISP_Attivita_Imprese_autorizzate_OF__c =s;
		isp4.CQS_ISP_Autorizzazione_amm_competente__c =s;
		isp4.CQS_ISP_Presenza_prog_cartografie_enti__c =s;
		isp4.CQS_ISP_indagini_preventive_scavo__c =s;
		isp4.CQS_ISP_Accantieramento_conforme__c =s;
		isp4.CQS_ISP_Esposizione_Cartello__c =s;
		isp4.CQS_ISP_RispettoCodice_SegnaleticaStrada__c =s;
		isp4.CQS_ISP_Idoneit_delimit_Cantiere_AD__c =s;
		isp4.CQS_ISP_Buono_stato_cartellonistica__c =s;
		isp4.CQS_ISP_assicurata_viabilita__c =s;
		isp4.CQS_ISP_Passaggi_su_scavi_idonei__c =s;
		isp4.CQS_ISP_Pozzetti_non_pericolosi__c =s;
		isp4.CQS_ISP_Presenza_WC__c =s;
		isp4.CQS_ISP_Presenti_autorizzati__c  =s;
		isp4.CQS_ISP_Tesserino_Check__c =s;
		isp4.CQS_ISP_Preposto_Cantiere_Presente__c =s;
		isp4.CQS_ISP_Addetto_PS_presente__c =s;
		isp4.CQS_ISP_Addetto_Antincendio_presente__c =s;
		isp4.CQS_ISP_DPI_idonei_in_dotazione__c =s;
		isp4.CQS_ISP_DPI_lavorazioni_in_quota__c =s;
		isp4.CQS_ISP_DPI_rischio_elettrico__c =s;
		isp4.Presenza_Moviere_qualora_necessario__c =s;
		isp4.Personale_dotato_di_quanto_richiesto__c =s;
		isp4.CQS_ISP_Mezzi_Attrezzature_autorizati__c  =s;
		isp4.CQS_ISP_conformita_mezzi_attrezzature__c =s;
		isp4.CQS_ISP_Documentazione_verifiche_legge__c =s;
		isp4.CQS_ISP_Marcatura_CE__c =s;
		isp4.CQS_ISP_Documentazione_noli_a_freddo__c =s;
		isp4.CQS_ISP_attrezzature_sollevamento__c =s;
		isp4.Cassetta_primo_soccorso_conforme__c  =s;
		isp4.CQS_Estintore_con_cartellino_e_revisione__c =s;
		isp4.Autorizzazioni_ENEL_prossimit_E_Distrib__c  =s;
		isp4.CQS_ISP_Presenza_Profili_E_Distrib__c =s;
        isp4.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c=s;
		
		insert isp4;

		 Test.startTest();
		
		CQS_Utils.calcolaPunteggio(isp);
		CQS_Utils.calcolaPunteggio(isp2);
		CQS_Utils.calcolaPunteggio(isp3);
		CQS_Utils.calcolaPunteggio(isp4);
	  
        Test.stopTest();
            }	
 }

    
}