@isTest
public class CompilaTotaloneTest
{
   @isTest public static void CompilaTotaloneTestmethod()
    {
        // Select users for the test.
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 2];
        Id User1Id = users[0].Id;
        Id User2Id = users[1].Id;
        
        CQS_Progetto__c prog = new CQS_Progetto__c();        
        prog.CQS_Pro_Area__c = 'test';
        prog.CQS_Pro_Comune__c = 'test';
        prog.Data_Contratto__c = 'test';
        prog.CQS_Prog_Importo_Aggiudicato__c = 'test';
        prog.CQS_Pro_LDO__c = 'test';
        insert prog;
        
        Progetto_Utente_junction__c progUtJun = new Progetto_Utente_junction__c();
        progUtJun.LDO__c = 'test';
        progUtJun.CQS_junc_progetto__c = prog.Id;
        progUtJun.CQS_junc_user__c = User1Id;
        insert progUtJun;
        
        OF_CQS_Ispezione__c cqs = new OF_CQS_Ispezione__c();
        cqs.OwnerId = User1Id;
        cqs.CQS_ISP_Progetto__c = prog.Id;
        cqs.CQS_ISP_LDO__c = 'test';
        cqs.Ora_Inizio_Sopralluogo__c = 'Test'; 
        cqs.OF_CQS_Data_Ispezione__c = datetime.newInstance(2018,02,06, 12, 30, 0);
        cqs.OF_CQS_ISP_VIA__c = 'test';
        cqs.OF_CQS_ISP_Numero_Civico__c = 'test';
        cqs.OF_CQS_ISP_Comune__c = 'test';
        cqs.OF_CQS_ISP_Provincia__c = 'test';
        
        cqs.CQS_ISP_PSC__c = 'Sì';	
        cqs.CQS_ISP_POS__c = 'Sì';	 	 
        cqs.CQS_ISP_Notifica_prel_corretta_valida__c = 'Sì';	
        cqs.CQS_ISP_DURC_regolare__c = 'Sì';
        cqs.CQS_ISP_Attivita_Imprese_autorizzate_OF__c = 'Sì';
        cqs.CQS_ISP_Autorizzazione_amm_competente__c = 'No';	 
        cqs.CQS_ISP_Presenza_prog_cartografie_enti__c = 'No';
        cqs.CQS_ISP_indagini_preventive_scavo__c = 'Sì';
        
        cqs.CQS_ISP_Accantieramento_conforme__c	= 'No';
        cqs.CQS_ISP_Esposizione_Cartello__c	= 'No';
        cqs.CQS_ISP_RispettoCodice_SegnaleticaStrada__c = 'No';
        cqs.CQS_ISP_Idoneit_delimit_Cantiere_AD__c = 'No';
        cqs.CQS_ISP_Buono_stato_cartellonistica__c = 'No';
        cqs.CQS_ISP_assicurata_viabilita__c	= 'No';
        cqs.CQS_ISP_Passaggi_su_scavi_idonei__c	= 'No';
        cqs.CQS_ISP_Pozzetti_non_pericolosi__c = 'No';	
        cqs.CQS_ISP_Presenza_WC__c = 'No';
        
        cqs.CQS_ISP_Presenti_autorizzati__c	='Sì';
        cqs.CQS_ISP_Tesserino_Check__c = 'Sì';
        cqs.CQS_ISP_Preposto_Cantiere_Presente__c = 'Sì';
        cqs.CQS_ISP_Addetto_PS_presente__c = 'Sì';	 	 
        cqs.CQS_ISP_Addetto_Antincendio_presente__c = 'Sì';
        cqs.CQS_ISP_DPI_idonei_in_dotazione__c = 'Sì';		 
        cqs.CQS_ISP_DPI_lavorazioni_in_quota__c = 'Sì';
        cqs.CQS_ISP_DPI_rischio_elettrico__c = 'Sì';		 	 
        cqs.Presenza_Moviere_qualora_necessario__c = 'Sì';	 	 
        cqs.Personale_dotato_di_quanto_richiesto__c = 'Sì';
        
        cqs.CQS_ISP_Mezzi_Attrezzature_autorizati__c = 'No';	
        cqs.CQS_ISP_conformita_mezzi_attrezzature__c = 'No';	
        cqs.CQS_ISP_Documentazione_verifiche_legge__c = 'No';	
        cqs.CQS_ISP_Marcatura_CE__c = 'No';
        cqs.CQS_ISP_Documentazione_noli_a_freddo__c = 'No';
        cqs.CQS_ISP_attrezzature_sollevamento__c = 'No';
        
        cqs.Cassetta_primo_soccorso_conforme__c = 'No';
        cqs.CQS_Estintore_con_cartellino_e_revisione__c = 'No';
        
        cqs.Autorizzazioni_ENEL_prossimit_E_Distrib__c = 'Sì';
        cqs.CQS_ISP_Presenza_Profili_E_Distrib__c = 'No';	 	 
        cqs.CQS_ISP_Dotazione_DPI_3_Cat_eDist__c = 'No';
        cqs.CQS_ISP_Punteggio_Totale__c = 0;
        cqs.CQS_Punteggio_Tot_Max_Isp__c = 0;        
        insert cqs;
        CQS_Utils.updateTrigger = true;
        update cqs;
    }        
}