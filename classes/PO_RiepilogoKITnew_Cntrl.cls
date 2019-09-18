public class PO_RiepilogoKITnew_Cntrl {
    
     public OF_CommercialElementIstanziato__c cei {get;set;}
     public EOF_EAI_Service_Log__c sl {get;set;}
    
     public String idceiKit {get;set;}
     public String idLogKit {get;set;}
     
     public String Nomekit{get;set;} 
     public String Stato{get;set;} 
     public String noteComOLO{get;set;}
     
     public String codOp{get;set;}
     public String codOperatore{get;set;}
     public String id_log_richiestaVLAN{get;set;} 
     
     public String codiceKit {get;set;}
    
     public List<OF_CommercialElementIstanziato__c> ceiListRichiesteVLAN{get;set;} //per sostituire slListRichiesteVLAN
     public List<OF_CommercialElementIstanziato__c> ceiListVLAN{get;set;} //per sostituire {!slListVlan}
     public List<EOF_EAI_Service_Log__c> log_richieste {get;set;}
    
     public List<EOF_EAI_Service_Log__c> slListRichiesteVLAN_old {get;set;}
     public List<EOF_EAI_Service_Log__c> slListVlan{get;set;}
     public List<Id> listIdRicVlan {get;set;}
     public List<Id> listIdceiVlan {get;set;}
     public Map<String,String> service_codice{get;set;}
     public boolean richiestaAttivazione{get;set;}
     public boolean confirmPage{get;set;} 
     public boolean success{get;set;}
     public boolean showAnnulla {get;set;}
     public boolean showAnnullaBtn {get;set;}
     public boolean Apparati{get;set;}
     public boolean ServiziAggiuntivi{get;set;}
     public boolean VLAN{get;set;} 
     public boolean showInsertVLAN{get;set;}
     
     public boolean idNonValido{get;set;}
     
     public boolean isAvailable{get;set;}
     
     public EOF_EAI_Service_Log__c kitLogSelected{get;set;}
     public string Codice_VLAN {get;set;}
     
     // EC start 2018 - 11 - 28
     // Costruttore
     public PO_RiepilogoKITnew_Cntrl(){
        system.debug('@@@@EC controller pagina di riepilogo con i dati di cei');
         
        idceiKit = ApexPages.currentPage().getParameters().get('ceiId');
        idLogKit = ApexPages.currentPage().getParameters().get('origId');
        system.debug('@@@@EC controller pagina di riepilogo con i dati di cei. idceiKit: ' + idceiKit);        
        richiestaAttivazione=false;
        confirmPage=false;
        
        Apparati=false;
        ServiziAggiuntivi=false;
        VLAN=false;
        
        isAvailable = false;
        
        showAnnulla = false;
        showAnnullaBtn = false;
        showInsertVLAN = false;
        
        if(ApexPages.currentPage().getParameters().get('showInsVlan') =='SI'){
            showInsertVLAN = true;
        }    
        //EC aggiunta  per isAvailable per il rerender  copiato dal controller precedente (PO_KIT_AttInserita_Controller)
        Nomekit = ApexPages.currentPage().getParameters().get('NomeKit');
        system.debug('@@@@EC controller pagina di riepilogo con i dati di cei. Nomekit: ' + Nomekit);  
        Stato = 'ATTIVO';
        String Str = apexpages.currentpage().getparameters().get('isAvailable');
        system.debug('@@@@EC controller pagina di riepilogo con i dati di cei. Str((isAvailable)) : ' + Str);  
        
        if(str == 'True'){
            isAvailable = True;
        }
        else{
            isAvailable = False;
        }  
       
        //EC 
        //cei è il commercial element istanziato kit.
        cei = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Servizio_Commerciale__c, 
                RecordType.name, RecordType.DeveloperName,RecordTypeId, 
                of_asset__c, of_asset__r.name, OF_Asset__r.account.name, 
                OF_Case__c, OF_KitConsegnaVLAN__c, PO_PP_InterfacciaKit__c,
                OF_CommercialElement__c,OF_CommercialElementName__c,
                PO_PP_Pop__c,PO_PP_Banda_Interfaccia__c,
                OF_DataAttivazione__c,PO_PP_Note__c,OF_Stato__c, OF_Case__r.Status,
               	PO_PP_Posizione_ODF__c
                from OF_CommercialElementIstanziato__c
                where id=:idceiKit];
                
        system.debug('@@@@EC controller pagina di riepilogo con i dati di cei: ' + cei);         
        service_codice= new Map<String,String>();
        for(EOF_EAI_Service_Log__c codiceVlan:[Select Name,OF_PP_NomeRichiesta_Figlio__c,OF_SA_SERVICE_VLAN__c 
                                               from EOF_EAI_Service_Log__c
                                               where RecordType.DeveloperName = 'PO_PP_VLAN'
                                               and Nome_del_KIT__c=: cei.PO_PP_Nome_KIT__c]){
            service_codice.put(codiceVlan.OF_SA_SERVICE_VLAN__c,codiceVlan.OF_PP_NomeRichiesta_Figlio__c);                  
        }
                
        ceiListRichiesteVLAN = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Servizio_Commerciale__c, 
                                RecordType.name, RecordType.DeveloperName,RecordTypeId, 
                                of_asset__c, of_asset__r.name, OF_Asset__r.account.name, 
                                OF_Case__c, OF_KitConsegnaVLAN__c, PO_PP_InterfacciaKit__c,
                                OF_CommercialElement__c,OF_CommercialElementName__c,
                                PO_PP_Pop__c,PO_PP_Banda_Interfaccia__c,
                                OF_DataAttivazione__c,PO_PP_Note__c,OF_Stato__c,
                                OF_Case__r.Status, PO_PP_POP_SVLAN__c, PO_PP_Cos_remarking__c, 
                                PO_PP_DHCP_Option82__c,OF_ServiceVLAN__c,OF_UserVLAN__c,
                                PO_PP_Cos_Type__c,PO_PP_Cos_Class__c,Of_asset__r.Status,OF_Case__r.Codice_Ordine_SO__c
                                from OF_CommercialElementIstanziato__c
                                where of_asset__c=: cei.of_asset__c
                                and RecordType.DeveloperName='SVLAN'
                                order by lastModifiedDate desc
                               /* and of_asset__r.Status='Attivo'*/];
        /*
        for(OF_CommercialElementIstanziato__c ceist:ceiListRichiesteVLAN){
            cei.
        }
        */
        showInsertVLAN = (!ceiListRichiesteVLAN.isEmpty())?true:false;
       
        listIdceiVlan = new List<ID>();
            
            for(OF_CommercialElementIstanziato__c ricV : ceiListRichiesteVLAN){
                listIdceiVlan.add(ricV.id);
            }
            System.debug('*****listIdRicVlan*****:'+listIdRicVlan);
            
            //Recupero tutte le VLAN
            
            /*     
            ceiListVLAN= [select id, PO_PP_POP_SVLAN__c, PO_PP_Cos_remarking__c, 
                            PO_PP_DHCP_Option82__c,OF_ServiceVLAN__c,OF_UserVLAN__c,
                            PO_PP_Cos_Type__c,PO_PP_Cos_Class__c
                            from OF_CommercialElementIstanziato__c
                            ];
                            
            ceiListVlan = [select id, name, OF_PP_KIT_Log__c, recordtype.developername, Nome_del_KIT__c,EOF_Codice_Operatore__c,
                            PO_PP_POP_raccolta__c, Banda_Interfaccia__c, PO_PP_cos_type__c, SVLAN__c, EOF_Note__c, CreatedDate, Codice_Ordine_SO__c,
                            PO_PP_cos_class__c, PO_PP_MultiCos_Class__c, PO_PP_cos_remarking__c, PO_PP_dhcp_Option82__c, PO_PP_User_VLAN__c, 
                            EOF_Stato_Richiesta__c, EOF_STATO_Ordine__c,OF_PP_NomeRichiesta__c,OF_PP_NomeRichiesta_Figlio__c, Caso__r.status
                            from EOF_EAI_Service_Log__c 
                            where PO_PP_ID_RichiestaVLAN__c in : listIdRicVlan
                            and RecordType.DeveloperName = 'PO_PP_VLAN'
                            order by CreatedDate desc]; */
   }
       
   
   //Metodo Copiato da PO_KIT_AttInserita_Controller
   public pageReference insertVLAN(){
        
        string selectednameKit;
    
        codOp = [SELECT Contact.account.name 
                FROM User 
                WHERE id = :userinfo.getuserid() 
                LIMIT 1].Contact.account.name;
         
        System.debug('***CodOP****:'+codOp);
                
        /*
        EOF_EAI_Service_Log__c kitLogSelected = [Select id, Nome_del_KIT__c
                                                  from EOF_EAI_Service_Log__c
                                                  where id=: sl.id
                                                  and EOF_STATO_ORDINE__c = 'Espletato'
                                                 ];*/
        List<EOF_EAI_Service_Log__c> listaLogKit= [Select id, Nome_del_KIT__c
                                                  from EOF_EAI_Service_Log__c
                                                  where id=: idLogKit
                                                  and EOF_STATO_ORDINE__c = 'Espletato'];
        
        if(!listaLogKit.isEmpty()){
            kitLogSelected=listaLogKit[0];
            selectednameKit = kitLogSelected.Nome_del_KIT__c;
        }
        else{                                                
            selectednameKit= ApexPages.currentPage().getParameters().get('NomeKit');
        }
        
        System.debug('selectednameKit: '+selectednameKit);
        
        log_richieste = new list<EOF_EAI_Service_Log__c>();

        //Query su object OF_CommercialElementIstanziato__c
        OF_CommercialElementIstanziato__c kit_selezionato = [Select id, name, PO_PP_Nome_KIT__c, PO_PP_Servizio_Commerciale__c, RecordType.name, of_asset__r.name, OF_Asset__r.account.name, OF_Case__c
                                                             from OF_CommercialElementIstanziato__c
                                                             where OF_CommercialElement__r.name = 'SERVIZIO KIT'
                                                             and OF_Asset__r.account.name =:codOp
                                                             and OF_Asset__r.status = 'Attivo'
                                                             and PO_PP_Nome_KIT__c=:selectednameKit
                                                             limit 1];
                                                             
        System.debug('***kit_selezionato.PO_PP_Nome_KIT__c***: '+kit_selezionato.PO_PP_Nome_KIT__c);
         
        if(kit_selezionato!=null)
        {
            log_richieste = [Select id,OF_PP_KIT_Log__c
                             from EOF_EAI_Service_Log__c
                             where OF_PP_KIT_Log__r.Nome_del_KIT__c =:selectednameKit
                             and recordtype.developerName = 'OF_RichiestaVLAN_LOG'
                             and EOF_stato_richiesta__c ='Bozza Portale'
                             limit 1];
            
            System.debug('***log_richieste***:'+log_richieste.size());
    
            Pagereference pg = new PageReference('/PO_PP_InserimentoSVLAN');
            
            //Se la lista contiene già una richiesta VLAN allora passo l'ID come parametro
            if(log_richieste.size()>0){
                pg.getParameters().put('richVLan','NO');
                id_log_richiestaVLAN = log_richieste.get(0).id;
                pg.getParameters().put('id_richVLAN',id_log_richiestaVLAN);
                System.debug('***ID LOG Richiesta VLAN***: '+id_log_richiestaVLAN);
                System.debug('***Richiesta VLAN presente!!***');
            }
            else{
                pg.getParameters().put('richVLan','SI');
                System.debug('***Nessuna Richiesta VLAN presente!!***');
            }
            pg.getParameters().put('nameKit',selectednameKit);
        
            if (kit_selezionato==null){
                idNonValido=true;
            }
            else{
                idNonValido=false;
                return pg;
            }
        }
        return null;
    }
    //°°°°°°°°°°°°°°//
    //EC end 2018 - 11 - 28 
}