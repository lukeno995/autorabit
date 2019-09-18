public without sharing class OLO_ActivationP2PUtils {

    public static final String CONTRATTO_P2P_ATTIVA = 'P2P Attiva';
    public static final String CONTRATTO_P2P_BASE = 'P2P Base';
    public static final String COLLEGAMENTO_P2P_PASSIVA = 'P2P Passiva';
    public static final String COLLEGAMENTO_E_ACCESS = 'E-Access';
    public static final String COLLEGAMENTO_E_LINE = 'E-Line';
    public static final String SEDE_MASTER = 'Master';
    public static final String SEDE_SATELLITE = 'Satellite';
    public static final String MODELLO_MONO = 'MonoCOS';
    public static final String MODELLO_MULTI = 'MultiCOS';

    private static OLO_Activation_P2PSchema.Header_Request header;
    private static OLO_Activation_P2PSchema.Fattibilita fattibilita;
    private static OLO_Activation_P2PSchema.Create_P2P_Request_element rqst;
    private static Set<Id> set_collegmId = new Set<Id>();
    
    private static final Map<String,String> map_esitoCrmToDom = new Map<String,String>();
    static {
        map_esitoCrmToDom.put('SI On Net', 'SI - ON Net');
        map_esitoCrmToDom.put('SI in FTTH', 'SI - in FTTH');
        map_esitoCrmToDom.put('SI Inf. OP', 'SI - TIM');
        map_esitoCrmToDom.put('SI Inf. Esistente', 'SI - Inf. Esist.');
        map_esitoCrmToDom.put('SI Scavo', 'SI - Scavo');
        map_esitoCrmToDom.put('SI Inf. + Scavo', 'SI - Inf.+ Scavo');
        map_esitoCrmToDom.put('KO', 'KO');
    }

    public static OLO_Activation_P2PSchema.Create_P2P_Request_element createActivationRqst(Map<Id,Id> map_CollIdOrdId, Id idNotify) {
    	system.debug('@@@@EC appena chiamato OLO_Activation_P2PSchema.Create_P2P_Request_element createActivationRqst  ');
    	system.debug('@@@@EC OLO_Activation_P2PSchema.Create_P2P_Request_element createActivationRqst parametri passati map_CollIdOrdId: ' + map_CollIdOrdId + ', idNotify: ' + idNotify);
        set_collegmId = map_CollIdOrdId.keySet();
        rqst = new OLO_Activation_P2PSchema.Create_P2P_Request_element();         
        rqst.header = createHeader(idNotify);
        System.debug('##### OLO_ActivationP2PUtils.createActivationRqst - HEADER: ' + rqst.header);

        Case caseFatt = getFattibilita(map_CollIdOrdId.keySet());
        system.debug('@@@@EC OLO_Activation_P2PSchema.Create_P2P_Request_element createActivationRqst caseFatt appena tornato: ' + caseFatt);
        if (caseFatt == null) {
            return null;
        }         
        System.debug('##### OLO_ActivationP2PUtils.createActivationRqst - caseFatt ID: ' + caseFatt.id);

        rqst.fattibilita = createFattibilita(caseFatt, map_CollIdOrdId);
        System.debug('##### OLO_ActivationP2PUtils.createActivationRqst - FATTIBILITA\': ' + rqst.fattibilita);        
        return rqst;

    }

    private static Case getFattibilita(Set<Id> setIdCollCases) {
    	system.debug('@@@@@EC metodo getFattibilita. come parametro passato un set di id dei case di collegamento. setIdCollCases: ' + setIdCollCases);
        List<Id> collIds = new List<Id>();
        collIds.addAll(setIdCollCases);
        Id caseId = collIds[0];
		system.debug('@@@@@EC metodo getFattibilita. Id caseId = collIds[0] - Id caseId: ' + caseId);

        List<Case> collCase = [SELECT ParentId from Case WHERE Id =: caseId];
        if(!collCase.isEmpty()) {
            System.debug('@@@@@ getFattibilita -- [SELECT ParentId from Case WHERE Id = ]: ' + caseId);
            System.debug('@@@@@ getFattibilita -- list collegamenti: ' + collCase.size());
        }        

        List<Case> deCase = null;
        if (!collCase.isEmpty()) {
            deCase = [SELECT Id, CreatedDate, EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore_WS__c, CreatedBy.Name,
            PO_Offerta__c FROM Case where Id =: collCase[0].ParentId];
             if(!collCase.isEmpty()) {
                System.debug('@@@@@ getFattibilita -- [SELECT Id, CreatedDate, EOF_Codice_Ordine_OLO__c,EOF_Codice_Operatore_WS__c,' +
                        ' CreatedBy.Name, PO_Offerta__c FROM Case where Id =: ' + collCase[0].ParentId);
                System.debug('@@@@@ getFattibilita -- list deCase: ' + collCase.size());
            }
        } 
        
        if(deCase == null || deCase.isEmpty()) {
            return null;
        }

        return deCase[0];
    }

    private static OLO_Activation_P2PSchema.Header_Request createHeader(Id idNotify) {
    
        header = new OLO_Activation_P2PSchema.Header_Request();
        header.TIPO_RICHIESTA = 'Attivazione'; //  header.TIPO_RICHIESTA = srvLog.OF_SA_Azione__c
        header.DATA_CREAZIONE = System.now();
        header.ID_NOTIFICA = idNotify;
        
        return header;
    }

    public static OLO_Activation_P2PSchema.Fattibilita createFattibilita(Case caseFatt, Map<Id,Id> map_collIdOrdineId) {
    	system.debug('@@@@EC - appena dentro. OLO_Activation_P2PSchema.Fattibilita createFattibilita. caseFatt: ' + caseFatt);
	   	system.debug('@@@@EC - appena dentro. OLO_Activation_P2PSchema.Fattibilita createFattibilita. map_collIdOrdineId: ' + map_collIdOrdineId);
        if(caseFatt == null) {
	    	system.debug('@@@@EC - OLO_Activation_P2PSchema.Fattibilita createFattibilita. dentro if(caseFatt == null) infatti caseFatt ' + caseFatt);
            return new OLO_Activation_P2PSchema.Fattibilita();
        }
        fattibilita = new OLO_Activation_P2PSchema.Fattibilita();
        system.debug('@@@@EC - OLO_Activation_P2PSchema.Fattibilita createFattibilita.  fuori IF. fattibilita 1 ');
        Map<Case,Case> map_collCaseOrdineCase = null;

        fattibilita.DATA_FATTIBILITA = caseFatt.CreatedDate.date();
        fattibilita.ID_FATTIBILITA = caseFatt.EOF_Codice_Ordine_OLO__c;
        fattibilita.CODICE_OPERATORE = caseFatt.EOF_Codice_Operatore_WS__c;
        fattibilita.FATTIBILITA_CREATA_DA = caseFatt.CreatedBy.Name;
        fattibilita.TIPO_CONTRATTO = caseFatt.PO_Offerta__c; // 'P2P Base' o 'P2P Attiva'
        fattibilita.NOTE = '';
        system.debug('@@@@EC - OLO_Activation_P2PSchema.Fattibilita createFattibilita.  fuori IF. fattibilita 2 fattibilita: ' + fattibilita);
        map_collCaseOrdineCase = buildCollOrdineCaseMap(map_collIdOrdineId);

        fattibilita.ORDINE =  createOrdine(map_collIdOrdineId, map_collCaseOrdineCase);
		system.debug('@@@@EC - OLO_Activation_P2PSchema.Fattibilita createFattibilita.  fuori IF. fattibilita 3. fattibilita: ' + fattibilita);
        if(CONTRATTO_P2P_ATTIVA.equalsIgnoreCase(fattibilita.TIPO_CONTRATTO)) {
            fattibilita.SubInput4 = createKit(map_collCaseOrdineCase.keySet());
			system.debug('@@@@EC - OLO_Activation_P2PSchema.Fattibilita createFattibilita.  fuori IF. fattibilita 4 contratto p2pAttiva. fattibilita.SubInput4:  ' + fattibilita.SubInput4);                
        }
		system.debug('@@@@EC - OLO_Activation_P2PSchema.Fattibilita createFattibilita.  fuori IF. fattibilita 5 alla fine prima di tornare: ' + fattibilita);
        return fattibilita;
        
    }

    public static List<OLO_Activation_P2PSchema.ORDINE_element> createOrdine(Map<Id,Id> map_collIdOrdineId, Map<Case,Case> map_collCaseOrdineCase) {
        OLO_Activation_P2PSchema.ORDINE_element ordine = null ;
        List<OLO_Activation_P2PSchema.ORDINE_element> lOrdine = new List<OLO_Activation_P2PSchema.ORDINE_element>();

        OLO_Activation_P2PSchema.SEDE sede =null;  
        List<OLO_Activation_P2PSchema.SEDE> list_sede = null;  
        List<OLO_Activation_P2PSchema.APPARATI> list_apparati = null;  
  
        Map<Id, Case> map_collegmIdCaseKit = getKitConsegna(map_collCaseOrdineCase.keySet()); 
        Map<Id, RequestWrap> map_idCollegmWrappedData = getCollegmIdToPOPAndElencoComuni(map_collCaseOrdineCase.keySet());
        Map<Id, List<OLO_Activation_P2PSchema.VLAN>> map_idCollegmVlans = createVlanMap(map_collIdOrdineId.keySet());
        Case master = findMaster(map_collCaseOrdineCase.keySet());

        System.debug('##### createOrdine: iterazione su map_collCaseOrdineCase.keySet() #####');
        for(Case coll : map_collCaseOrdineCase.keySet()) {
            
            ordine = new OLO_Activation_P2PSchema.ORDINE_element();
            sede = new OLO_Activation_P2PSchema.SEDE(); // subinput1
            list_sede = new List<OLO_Activation_P2PSchema.SEDE>();

            list_apparati = new List<OLO_Activation_P2PSchema.APPARATI>();

            // Prendo questi campi dal case ordine
            ordine.AZIONE = 'Attivazione'; // OF_SA_Azione__c
            ordine.ID_ORDINE = map_collCaseOrdineCase.get(coll).EOF_Codice_Ordine_OLO__c ;
            ordine.DATA_ORDINE = map_collCaseOrdineCase.get(coll).CreatedDate.date();

            if(CONTRATTO_P2P_BASE.equalsIgnoreCase(fattibilita.TIPO_CONTRATTO)) {
                 ordine.TIPO_COLLEGAMENTO = COLLEGAMENTO_P2P_PASSIVA;
            } else if(CONTRATTO_P2P_ATTIVA.equalsIgnoreCase(fattibilita.TIPO_CONTRATTO) 
                && COLLEGAMENTO_E_ACCESS.equals(coll.PO_Tipo_di_collegamento__c)) {
                ordine.TIPO_COLLEGAMENTO = COLLEGAMENTO_E_ACCESS;
            } else {
                ordine.TIPO_COLLEGAMENTO = COLLEGAMENTO_E_LINE;
            }

            // Prendo questi campi dal case collegamento
            sede.ID_SEDE = CONTRATTO_P2P_BASE.equalsIgnoreCase(fattibilita.TIPO_CONTRATTO) ? coll.casenumber : coll.SF_Ccoll_ID_Sede__c;
            sede.NOME_SEDE = coll.PO_Sito__c;
            // e-line 
            if(COLLEGAMENTO_E_LINE.equals(coll.PO_Tipo_di_collegamento__c)) {
                sede.TIPOLOGIA_SEDE = coll.tipologia_sede__c;
                if(SEDE_SATELLITE.equals(coll.tipologia_sede__c)) {
                    sede.ID_SEDE_MASTER = master.SF_Ccoll_ID_Sede__c;
                }
                if(SEDE_MASTER.equals(coll.tipologia_sede__c)) {
                    // campo valorizzato solo sulla request perchè obbligatorio per il DOM
                    sede.ID_SEDE_MASTER = sede.ID_SEDE;
                    sede.OPTICAL_RATE_LIMITING = coll.PO_P2PAttiva_KIT_OpticalRateLimiting__c;
                }
            }
            sede.SERVICE_ATTRIBUTE = coll.service_attribute__c;

            String partTopos = coll.Particella_Toponomastica_1__c == null ?
                '' : coll.Particella_Toponomastica_1__c;
            sede.INDIRIZZO = partTopos + ' ' + coll.PO_Indirizzo_collegamento__c;

            sede.CIVICO = coll.PO_Civico__c;
            sede.COMUNE = coll.PO_Nome_Comune__c;
            
            sede.PROVINCIA = (map_idCollegmWrappedData.get(coll.Id)).getComuni().OF_Provincia__c;                     
            sede.CODICE_ISTAT = (map_idCollegmWrappedData.get(coll.Id)).getComuni().OF_CodiceIstat__c;
            sede.POP_RACCOLTA = (map_idCollegmWrappedData.get(coll.Id)).getPop().Name;

            sede.ID_BUILDING = '';
            // e-access
            sede.TIPOLOGIA_CPE = coll.Tipologia_CPE__c;
            sede.TIPOLOGIA_ALIMENTAZIONE = coll.Tipologia_Alimentazione__c;
            sede.INTERFACCIA_CPE = coll.Interfaccia_CPE__c;
            sede.TRAFFIC_LOAD_BALANCING = coll.Traffic_Load_Balancing__c;
            // e-access
            //sede.INTERFACCIA_LATO_CLIENTE = ''; // non obbligatorio -- manca api name su specifiche
            sede.ID_COLLEGAMENTO = coll.EOF_Codice_Ordine_OLO__c;

            if(CONTRATTO_P2P_ATTIVA.equalsIgnoreCase(fattibilita.TIPO_CONTRATTO)
                && COLLEGAMENTO_E_ACCESS.equals(coll.PO_Tipo_di_collegamento__c)) {
                sede.NOME_KIT_CONSEGNA = map_collegmIdCaseKit.get(coll.Id).PO_PP_NomeKit__c;
                sede.POP_CONSEGNA = map_collegmIdCaseKit.get(coll.Id).EOF_Identificativo_del_POP__c; 
            }               

            /* sede.DISTANZA_STIMATA = '';  // da chiarire

            sede.LUNGHEZZA_DROP_FL_LEASE = ''; // Informazione non gestita per P2P Base e Attiva.
                                               // Lunghezza in metri del drop 1. Presente solo per i servizi Fibe Lease. 
            
            sede.LUNGHEZZA_DROP_FL2_LEASE = ''; // Come sopra
            */

            sede.BB1_INTERESSATO = String.valueOf(coll.PO_BB_1_interessato__c);
            sede.BB2_INTERESSATO = String.valueOf(coll.PO_BB_2_interessato__c);
            sede.POSA_1_NUOVO_CAVO = String.valueOf(coll.PO_Posa_1_via_nuovo_Drop__c); 

            sede.POSA_2_NUOVO_CAVO =  String.valueOf(coll.PO_Posa_2_via_nuovo_Drop__c);
            sede.CAVO_TRATTA_PRIMA_VIA =  String.valueOf(coll.PO_BB_1_via_interessato__c);
            sede.CAVO_TRATTA_SECONDA_VIA = String.valueOf(coll.PO_BB_2_via_interessato__c);
            sede.DROP_FL1 =  String.valueOf(coll.PO_Drop_FL_1__c);
            sede.LUNGHEZZA_DROP_FL1 = String.valueOf(coll.PO_Lunghezza_m__c);
            sede.DROP_FL2 = String.valueOf(coll.PO_Drop_FL_2__c);
            sede.LUNGHEZZA_DROP_FL2 = String.valueOf(coll.PO_Lunghezza_m2__c);
            sede.DATA_PREVISTA_ATTIVAZIONE = coll.EOF_Data_Prevista_Attivazione__c;
            sede.DISPONIBILITA_RETE = coll.PO_Disponibilit_della_rete_a_partire_da__c;
            sede.NOME_REFERENTE = coll.Owner.Name;
                
            try {
                sede.DATA_ATTIVAZIONE_RICHIESTA_CLIENTE = Date.valueOf(coll.PO_Data_Attivazione_Richiesta__c);
            } catch (Exception e) {
                sede.DATA_ATTIVAZIONE_RICHIESTA_CLIENTE = null;
            }
            sede.PM_DI_RIFERIMENTO = coll.PO_Nome_E_Cognome_PM__c;
            sede.NUMERO_TELEFONICO_PM = coll.PO_Numero_Telefonico_PM__c;
            sede.PRIME_CONTRACTOR = coll.PO_Prime_Contractor__c;
            sede.NUMERO_FIBRE_RICHIESTE = coll.PO_Numero_fibre_richieste__c;

            sede.TIPO_PERCORSO = coll.PO_Tipo_percorso__c;
            sede.ESITO_FATTIBILITA = formatEsitoCollegamento(coll.PO_Esito_collegamento__c);
            sede.NOTE = coll.PO_Note_collegamento__c != null ? coll.PO_Note_collegamento__c.abbreviate(255) :
                coll.PO_Note_collegamento__c;
            
            if(CONTRATTO_P2P_ATTIVA.equalsIgnoreCase(fattibilita.TIPO_CONTRATTO)) {
                sede.SubInput2 = map_idCollegmVlans.get(coll.Id);   
                sede.SubInput3 = createApparati(coll);        
            }           

            list_sede.add(sede);
            ordine.SubInput1 = list_sede;
            lOrdine.add(ordine);
            System.debug('##### added ordine to list: ' + ordine);
            System.debug('##### lOrdine.size: ' + lOrdine.size());
        }
        return lOrdine;    

    }

    @testVisible
    private static Case findMaster(Set<Case> collegamenti) {
        Id masterId = null;
        for(Case c : collegamenti) {
            if(c.id_sede_master__c != null) {
                masterId = c.id_sede_master__c;
                break;
            }
        }
        Case master = new Case();
        if(masterId != null) {
            master = [SELECT SF_Ccoll_ID_Sede__c FROM CASE WHERE id =: masterId];
        }
        return master;
    }

    public static Map<Id,Case> getKitConsegna(Set<Case> collegamenti) {
        Map<Id,Case> map_collegmIdKitCase = new Map<Id,Case>();

        Set<Id> kitIds = new Set<Id>();
        for(Case c : collegamenti) {
            if(c.PO_KIT_Consegna_VLAN__c != null) {
                kitIds.add(c.PO_KIT_Consegna_VLAN__c);
            } else if(c.kit_in_condivisione__c != null) {
                kitIds.add(c.kit_in_condivisione__c);
            }
            
        }          
        List<Case> list_kitConsegna = [SELECT EOF_Identificativo_del_POP__c, PO_PP_NomeKit__c 
                FROM Case
                WHERE Id IN : kitIds];

        for(Case coll : collegamenti) {
            for(Case kit : list_kitConsegna) {
                if(kit.Id == coll.PO_KIT_Consegna_VLAN__c || kit.Id == coll.kit_in_condivisione__c ) {
                    map_collegmIdKitCase.put(coll.Id, kit);
                }
            }            
        }
        return map_collegmIdKitCase;

    }

    public static Map<Id, RequestWrap> getCollegmIdToPOPAndElencoComuni(Set<Case> collegamenti) {
        Map<Id, RequestWrap> map_collegmIdToWrapped = new Map<Id, RequestWrap>();
        RequestWrap wrapped = null;
        List<Id> list_po_comune = new List<Id>();
        List<Id> list_idPop = new List<Id>();

        // Recupero Info
        for(Case c : collegamenti) {
            if(c.PO_Comune2__c != null) {
                list_po_comune.add(c.PO_Comune2__c);
            }
            if(c.PO_Pop_1_di_riferimento2__c != null) {
                list_idPop.add(c.PO_Pop_1_di_riferimento2__c);
            }          
        }

        List<OF_ElencoComuniItaliani__c> list_Comuni = new List<OF_ElencoComuniItaliani__c>();
        if (list_po_comune != null) {
            list_Comuni = [SELECT Id, OF_CodiceIstat__c, OF_Provincia__c
                FROM OF_ElencoComuniItaliani__c WHERE Id in : list_po_comune];
        }

        // name = pop raccolta
        List<POP__c> list_pop = [SELECT Id, Name FROM POP__c WHERE Id in : list_idPop]; 

        // Costruzione return
        for(Case c : collegamenti) {
            wrapped = new RequestWrap();
            for(OF_ElencoComuniItaliani__c comune : list_Comuni) {
                if(comune.Id == c.PO_Comune2__c) {
                    wrapped.setComuni(comune);
                }
            } 
            for(POP__c pop : list_pop) {
                if(pop.Id == c.PO_Pop_1_di_riferimento2__c) {
                    wrapped.setPop(pop);
                }
            }
            map_collegmIdToWrapped.put(c.Id, wrapped);
        }

        return map_collegmIdToWrapped;
    }

    public static String formatEsitoCollegamento(String esito) {
        return map_esitoCrmToDom.get(esito);      
    }

    public static Map<Id, List<OLO_Activation_P2PSchema.VLAN>> createVlanMap(Set<Id> set_collegmId) {
        System.debug('##### createVlanMap ##### START');
        // VLAN presente solo per p2p attiva
        Map<Id, List<OLO_Activation_P2PSchema.VLAN>>  map_collegmID_VlanSchema = new Map<Id, List<OLO_Activation_P2PSchema.VLAN>>();
        List<OLO_Activation_P2PSchema.VLAN> list_vlanRqst = null;
        OLO_Activation_P2PSchema.VLAN vlanRqst = null; // subinput2
        OLO_Activation_P2PSchema.COS cos = null;

        List<EOF_VLAN__c> list_vlan =  [SELECT Caso__c, PO_Modello_di_Servizio__c, PO_COS_Remarking__c, PO_DHCP_Option82__c, 
            PO_Profilo__c, PO_Opzione__c, PO_Velocita_di_Banda__c, PO_KIT_di_consegna_VLAN__c,PO_COS_Class__c, PO_COS1_CIR__c, PO_COS1_PIR__c, 
            PO_COS3_CIR__c, PO_COS3_PIR__c, PO_COS5_CIR__c, PO_COS5_PIR__c
            FROM EOF_VLAN__c 
            WHERE Caso__c IN: set_collegmId];

        // per recuperare velocità di banda che ho sul collegamento associato alla vlan
        Map<Id,Case> map_id_caseColl = new  Map<Id,Case>();
        for(Case c : [SELECT OF_SA_Profilo__c FROM Case WHERE id IN : set_collegmId]) {
            map_id_caseColl.put(c.id, c);
        }

        if(!list_vlan.isEmpty()) {
            System.debug('@@@@@ createVlan -- [SELECT Id, OF_ModelloDiServizioVLAN__c, OF_UserVLAN__c,  PO_PP_Cos_remarking__c, PO_PP_DHCP_Option82__c, OF_Profilo__c,' +
                ' OF_ProfiloVLAN__c FROM OF_CommercialElementIstanziato__c WHERE OF_SA_VLAN__c IN: ] ' + set_collegmId);
        }        
        for(EOF_VLAN__c vl : list_vlan) {
            vlanRqst = new OLO_Activation_P2PSchema.VLAN();
            list_vlanRqst = new List<OLO_Activation_P2PSchema.VLAN>();

            vlanRqst.MODELLO_SERVIZIO = formatModelloServizio(vl.PO_Modello_di_Servizio__c);
            vlanRqst.COS_REMARKING = vl.PO_COS_Remarking__c; // irrivelante per fase 1
            vlanRqst.DHCP_OPTION82 = vl.PO_DHCP_Option82__c; // come sopra
            vlanRqst.SVLAN_TRASLATION = ''; // non ancora definito
            vlanRqst.PROFILO = vl.PO_Profilo__c;
            vlanRqst.OPZIONE = vl.PO_Opzione__c;
            vlanRqst.VELOCITA_DI_BANDA = map_id_caseColl.get(vl.caso__c).OF_SA_Profilo__c;

            vlanRqst.SubInput5 = new List<OLO_Activation_P2PSchema.COS>();
            String[] cosClassValues = new String[]{}; 
            String cosClass= vl.PO_COS_Class__c != null ?  
                vl.PO_COS_Class__c.replace(' ', '') : vl.PO_COS_Class__c;
            if(cosClass != null) {
                cosClassValues = cosClass.split('-');
            }            
            System.debug('@@@ cosClass ' + cosClass);
            System.debug('@@@ cosClassValues ' + cosClassValues);

            if(!cosClassValues.isEmpty()){
                vlanRqst.USER_VLAN = getUserVlan(cosClassValues);
            }

            for (String s : cosClassValues) {
                cos = new OLO_Activation_P2PSchema.COS();
                cos.SERVIZI_UTENTE = s;
                vlanRqst.SubInput5.add(cos); 
            }  
            list_vlanRqst.add(vlanRqst);
            map_collegmID_VlanSchema.put(vl.Caso__c, list_vlanRqst);
            
        }
        return map_collegmID_VlanSchema;

    }

    /*  Id user all’interno della VLAN
        Valori ammissibili:
        •	835
        •	935
        •	837

        Note:
        - 835 per il COS0
        - 935 per il COS1
        - 837 per il COS5
        - 835 per COS0,COS5
        - 835 per COS0,COS1,COS5 */


    @testVisible
    private static String getUserVlan(String[] cosClassValues) {
        System.debug('#### getUserVlan - cosClassValues: ' + cosClassValues);
        String cosClass = '';
        if(cosClassValues.size() == 3) {
            cosClass = cosClassValues[0] + cosClassValues[1] + cosClassValues[2];
            if(cosClass.contains('COS0') && cosClass.contains('COS1') &&  cosClass.contains('COS5')) {
                return '835';
            }            
        }
        if(cosClassValues.size() == 2) {
            cosClass = cosClassValues[0] + cosClassValues[1];
            if(cosClass.contains('COS0') &&  cosClass.contains('COS5')) {
                return '835';
            }            
        } 
        if (cosClassValues.size() == 1) {
            cosClass = cosClassValues[0];
            if(cosClass.contains('COS0')) {
                return '835';
            }
            if(cosClass.contains('COS1')) {
                return '935';
            }
            if(cosClass.contains('COS5')) {
                return '837';
            } 
        }       
        return null;
    }

    @testVisible
    private static String formatModelloServizio(String modello) {
        if(String.isBlank(modello)) {
            return modello;
        } 
        if (modello.toLowerCase().contains('mono')) {
            return MODELLO_MONO;
        }
        if(modello.toLowerCase().contains('multi')) {
            return MODELLO_MULTI;
        } 
        return modello;
    }

    private static List<OLO_Activation_P2PSchema.APPARATI> createApparati(Case collegamento) {
        OLO_Activation_P2PSchema.APPARATI apparato = new OLO_Activation_P2PSchema.APPARATI();
        List<OLO_Activation_P2PSchema.APPARATI> list_apparati = new List<OLO_Activation_P2PSchema.APPARATI>();
        apparato.NOME_CPE_CLIENTE = collegamento.EOF_Codice_Ordine_OLO__c;
        list_apparati.add(apparato);
        return list_apparati;
    }

    private static List<OLO_Activation_P2PSchema.KIT> createKit(Set<Case>  set_coll) {
        System.debug('##### OLO.ActivationP2PUtils.createKit ##### START');
        List<OLO_Activation_P2PSchema.KIT> list_Kit = new List<OLO_Activation_P2PSchema.KIT>();
        
        List<Id> list_idKit = new List<Id>();
        for(Case c : set_coll) {
            if(c.PO_KIT_Consegna_VLAN__c != null) {
                list_idKit.add(c.PO_KIT_Consegna_VLAN__c);
            }
            System.debug('@@@@@@ PO_KIT_Consegna_VLAN__c: ' + c.PO_KIT_Consegna_VLAN__c);
        }         

        System.debug('##### OLO.ActivationP2PUtils.createKit -- list id kit: ' + list_idKit);

        List<Case> list_case = [SELECT Id, EOF_Codice_Ordine_OLO__c, PO_PP_NomeKit__c, EOF_Identificativo_del_POP__c,  
                                PO_P2PAttiva_Kit_Indirizzo_Consegna__c, PO_P2PAttiva_KIT_OpticalRateLimiting__c, service_attribute__c
                                FROM Case WHERE Id in : list_idKit];

        if(!list_case.isEmpty()) {
                System.debug('@@@@@ createKit -- [SELECT Id, EOF_Codice_Ordine_OLO__c, PO_PP_NomeKit__c, EOF_Identificativo_del_POP__c,' +
                            ' PO_P2PAttiva_Kit_Indirizzo_Consegna__c, PO_P2PAttiva_KIT_OpticalRateLimiting__c ' +
                             ' FROM Case WHERE Id in : ] ' + list_idKit);
                System.debug('@@@@@ createKit -- list deCase: ' + list_case.size());
        }
        System.debug('##### OLO.ActivationP2PUtils.createKit -- list kit: ' + list_case);

        // Cerco nei log il codice operatore non presente sul case
        List<EOF_EAI_Service_Log__c> list_log = [SELECT Caso__c, EOF_Codice_Operatore__c, Name FROM EOF_EAI_Service_Log__c
                                WHERE Caso__c in : list_idKit];

        if(!list_log.isEmpty()) {
                System.debug('@@@@@ createKit -- [[SELECT Caso__c, EOF_Codice_Operatore__c, Name FROM EOF_EAI_Service_Log__c ' +
                             ' WHERE Caso__c in : ] ' + list_idKit);
                System.debug('@@@@@ createKit -- list deCase: ' + list_idKit.size());
        }

        System.debug('##### OLO.ActivationP2PUtils.createKit -- list log: ' + list_log);

        OLO_Activation_P2PSchema.KIT c_kit = null;
        for(Case c : list_case) {
            c_kit = new OLO_Activation_P2PSchema.KIT();
            c_kit.AZIONE = 'Attivazione';
            c_kit.POP_CONSEGNA = c.EOF_Identificativo_del_POP__c;
            c_kit.INDIRIZZO_CONSEGNA = c.PO_P2PAttiva_Kit_Indirizzo_Consegna__c;
            c_kit.OPTICAL_RATE_LIMITING = c.PO_P2PAttiva_KIT_OpticalRateLimiting__c;
            c_kit.NOTE = ''; // non specificato dove recuperare
            c_kit.SERVICE_ATTRIBUTE = c.service_attribute__c;

            for(EOF_EAI_Service_Log__c log : list_log) {
                if(log.Caso__c == c.Id ) {
                    c_kit.ID_ORDINE_KIT = log.EOF_Codice_Operatore__c + log.Name.replace('LOG-', '_');
                    c_kit.NOME_KIT_CONSEGNA = formatNomeKitConsegna(log.EOF_Codice_Operatore__c, c.PO_PP_NomeKit__c);
                }
            }
            
            System.debug('##### createKit -  kit element : ' + c_kit);
            list_Kit.add(c_kit);          
        }
        System.debug('##### OLO.ActivationP2PUtils.createKit -- list kit: ' + list_Kit);
        return list_Kit;
    }

    @testVisible
    private static String formatNomeKitConsegna(String codiceOperatore, String nomeKit) {
        String[] splitted = new String[0];
        if (nomeKit != null) {
            splitted = nomeKit.split('_');
        }        
        if(splitted.size() >= 3) {
            return codiceOperatore + '_' + splitted[1] + '_' + splitted[2];
        } else {
            return nomeKit;
        }
    }

    public static void updateCodeOLOKit(Map<Id,Id> map_collIdOrdineId) {

        Set<Case> set_coll = buildCollOrdineCaseMap(map_collIdOrdineId).keySet();
        
        List<Id> list_idKit = new List<Id>();
        for(Case c : set_coll) {
            if(c.PO_KIT_Consegna_VLAN__c != null) {
                list_idKit.add(c.PO_KIT_Consegna_VLAN__c);
            }
            System.debug('@@@@@@ PO_KIT_Consegna_VLAN__c: ' + c.PO_KIT_Consegna_VLAN__c);
        }

        List<Case> list_case = [SELECT Id, EOF_Codice_Ordine_OLO__c, PO_PP_NomeKit__c, EOF_Identificativo_del_POP__c,  
                                PO_P2PAttiva_Kit_Indirizzo_Consegna__c, PO_P2PAttiva_KIT_OpticalRateLimiting__c 
                                FROM Case WHERE Id in : list_idKit];
        List<EOF_EAI_Service_Log__c> list_log = [SELECT Caso__c, EOF_Codice_Operatore__c, Name FROM EOF_EAI_Service_Log__c
                                WHERE Caso__c in : list_idKit];

        OLO_Activation_P2PSchema.KIT c_kit = null;
        for(Case c : list_case) {
            for(EOF_EAI_Service_Log__c log : list_log) {
                if(log.Caso__c == c.Id ) {
                    c.EOF_Codice_Ordine_OLO__c = log.EOF_Codice_Operatore__c + log.Name.replace('LOG-', '_');
                }
            }
        }
        update list_case;

    }
    
    @testVisible
    private static Map<Case,Case>  buildCollOrdineCaseMap(Map<Id,Id> map_collIdOrdineId) {
        System.debug('##### OLO.ActivationP2PUtils.getCollOrdineCaseMap: costruzione mappa tra case collegamento e case ordine #####');
        List<Id> list_collegId = new List<Id>();
        list_collegId.addAll(map_collIdOrdineId.keySet());
        List<Id> list_OrdineId = map_collIdOrdineId.values();

        System.debug('##### getCollOrdineCaseMap - id cases collegamento: ' + list_collegId);
        List<Case> collegamenti = [SELECT id, CaseNumber, PO_Sito__c, PO_Indirizzo_collegamento__c, Particella_Toponomastica_1__c,
                     PO_Civico__c,  PO_Nome_Comune__c, PO_Comune2__c, PO_Pop_1_di_riferimento2__c, EOF_Identificativo_del_POP__c,
                     EOF_Codice_Ordine_OLO__c, PO_BB_1_interessato__c , PO_BB_2_interessato__c, PO_Posa_1_via_nuovo_Drop__c, 
                     PO_Posa_2_via_nuovo_Drop__c, PO_BB_1_via_interessato__c, PO_BB_2_via_interessato__c, PO_Drop_FL_1__c, PO_Lunghezza_m__c,
                     PO_Drop_FL_2__c, PO_Lunghezza_m2__c, EOF_Data_Prevista_Attivazione__c, PO_Disponibilit_della_rete_a_partire_da__c,
                     Owner.Name, PO_PP_NomeKit__c , PO_Data_Attivazione_Richiesta__c, PO_Nome_E_Cognome_PM__c, PO_Numero_Telefonico_PM__c,
                     PO_Prime_Contractor__c, PO_Numero_fibre_richieste__c, PO_Tipo_percorso__c, PO_Esito_collegamento__c, PO_Note_collegamento__c, 
                     PO_KIT_Consegna_VLAN__c, kit_in_condivisione__c, Tipologia_CPE__c, Tipologia_Alimentazione__c, Interfaccia_CPE__c, service_attribute__c, 
                     Traffic_Load_Balancing__c, tipologia_sede__c, id_sede_master__c, OF_SA_Profilo__c, PO_Tipo_di_collegamento__c,
                     PO_P2PAttiva_KIT_OpticalRateLimiting__c, SF_Ccoll_ID_Sede__c
                     FROM Case WHERE Id in: list_collegId];
  
        System.debug('##### getCollOrdineCaseMap - id cases ordine: ' + list_OrdineId);
        List<Case> ordini = [SELECT Id, ParentId, PO_Case_Collegamento__c, EOF_Codice_Ordine_OLO__c, CreatedDate, 
                        PO_Tipologia_Offerta_ordine__c FROM Case WHERE Id in: list_OrdineId];
        
        Map<Case,Case> map_collCase_OrdineCase = new Map<Case,Case>();
        for(Case coll : collegamenti) {
            for(Case ord : ordini) {
                if(coll.Id == ord.ParentId) {
                    System.debug('Filling map_collCase_OrdineCase - key.Id / values.Id: ' + coll.Id + ' / ' + ord.Id);
                    map_collCase_OrdineCase.put(coll, ord);
                }
            }
        }

        return map_collCase_OrdineCase;
    }

    public class RequestWrap {
        OF_ElencoComuniItaliani__c comuni = new OF_ElencoComuniItaliani__c();
        POP__c pop = new POP__c();
        String nomeKitConsegna = '';

        public OF_ElencoComuniItaliani__c getComuni() {
            return comuni;
        }

        public void setComuni(OF_ElencoComuniItaliani__c comuni) {
            this.comuni = comuni;
        }

        public String getNomeKitConsegna() {
            return nomeKitConsegna;
        }

        public void setNomeKitConsegna(String nomeKitConsegna) {
            this.nomeKitConsegna = nomeKitConsegna;
        }

        public POP__c getPop() {
            return pop;
        }

        public void setPop(POP__c pop) {
            this.pop = pop;
        }

    }
    
    // vedi PO_ServiziFattibilita_Controller invioPSM
    public static Id createIdNotifica(String caseId) {
        eof_notify__c notifyy = new eof_notify__c();
        
		notifyy.RecordTypeId = Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('DOM Notifica di Attivazione')
            .getRecordTypeId();
		notifyy.EOF_Data_Notifica__c = system.now();
        System.debug('##### OLO_ActivationP2PUtils.createIdNotifica -- before insert -- notifyy: ' + notifyy);
        // eof_inviata = true serve a non far partire una callout innescata dal trigger su eof_notify
		notifyy.EOF_Inviata__c = true;
        notifyy.Caso__c = caseId;
        insert notifyy;

        System.debug('##### OLO_ActivationP2PUtils.createIdNotifica -- after insert -- notifyy id: ' + notifyy.Id);

        return notifyy.Id;
    }

    // vedi PO_ServiziFattibilita_Controller invioPSM
    public static EOF_EAI_Service_Log__c writeLog(OLO_Activation_P2PSchema.Create_P2P_Request_element rqst,
            OLO_Activation_P2PSchema.Create_Response rspnse) {
        
        System.debug('##### OLO_ActivationP2PUtils.writeLog #####');

        List<Case> fatt = [SELECT Id FROM Case WHERE EOF_Codice_Ordine_OLO__c =: rqst.fattibilita.ID_FATTIBILITA];
        List<String> list_idOrdine = new List<String>();

        for(OLO_Activation_P2PSchema.ORDINE_element o : rqst.fattibilita.ORDINE) {
            list_idOrdine.add(o.ID_ORDINE);
        }
        List<Case> l_caseOrdine =  [SELECT Id,EOF_Codice_Ordine_OLO__c
            FROM Case WHERE EOF_Codice_Ordine_OLO__c =: list_idOrdine]; 

        System.debug('##### OLO_ActivationP2PUtils.writeLog case fattibilità list: ' + fatt);
        Id domWsAttivazioneRType = Schema.SObjectType.EOF_EAI_Service_log__c.getRecordTypeInfosByName()
            .get('DOM WS OUT Attivazione').getRecordtypeid();
        
        // Verifico che non esista gia un log per questa request
        List<EOF_EAI_Service_Log__c> list_sLog = null;
        if(!fatt.isEmpty()){
            list_sLog = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE Caso__c =: fatt[0].Id 
                        AND RecordTypeId =: domWsAttivazioneRType];
        }  

        if(list_sLog != null && !list_sLog.isEmpty()) {
            return list_sLog[0];
        }

        EOF_EAI_Service_Log__c sLog = new EOF_EAI_Service_Log__c();       		
         if(!fatt.isEmpty()){
            sLog.Caso__c = fatt[0].id;
            System.debug('##### OLO_ActivationP2PUtils.writeLogsLog -- sLog.Caso__c: ' + fatt[0].Id);
        }            
		
        sLog.RecordTypeId = domWsAttivazioneRType;
		sLog.OF_SA_Azione__c =PO_FATT_WS_PSM_Notify_Utils.AZIONE_ATTIVAZIONE;	
        sLog.EOF_Richiesta_Notifica__c = String.valueOf(rqst);
        sLog.EOF_TIpo_comunicazione_String__c = 'SFDC -> DOM';
        sLog.EOF_Codice_Ordine_OLO__c = rqst.fattibilita.ID_FATTIBILITA;
        sLog.EOF_Data_Notifica__c = rqst.header.DATA_CREAZIONE; 
        
        List<EOF_Notify__c> l_notify = [SELECT Name, Caso__c FROM EOF_Notify__c WHERE Id =: rqst.header.ID_NOTIFICA];
        if(!l_notify.isEmpty()) {
            sLog.EOF_ID_Notifica__c = l_notify[0].Name;
            sLog.Notify__c = l_notify[0].Id;
            sLog.Caso__c = l_notify[0].Caso__c;
        }

        System.debug('##### OLO_ActivationP2PUtils.writeLog -- log before insert: ' + sLog);		
		insert sLog;
        System.debug('##### OLO_ActivationP2PUtils.writeLog -- log after insert -- sLog.Id ' + sLog.Id);

        List<OLO_Activation_P2PSchema.ORDINE_element> ordineCases = rqst.fattibilita.ORDINE;
        List<EOF_Notify__c> ordineNotifys = new List<EOF_Notify__c>();
        List<EOF_EAI_Service_Log__c> ordineLogs = new List<EOF_EAI_Service_Log__c>(); 
        
        for(OLO_Activation_P2PSchema.ORDINE_element ord : ordineCases) {           
            EOF_Notify__c ordNotfy = new EOF_Notify__c();
            ordNotfy.RecordTypeId =Schema.SObjectType.EOF_Notify__c.getRecordTypeInfosByName().get('DOM Notifica di Attivazione')
                .getRecordTypeId();
            ordNotfy.EOF_Data_Notifica__c = system.now(); 
            for(Case c : l_caseOrdine) {
                if(c.EOF_Codice_Ordine_OLO__c == ord.ID_ORDINE) {
                    ordNotfy.Caso__c = c.id;
                }
            }   
            ordNotfy.EOF_Inviata__c = true;
            ordineNotifys.add(ordNotfy);
        }
        insert ordineNotifys;
        System.debug('##### Inserite notifiche degli ordini: ' + ordineNotifys);

        for(EOF_Notify__c notfy : ordineNotifys) {
            EOF_EAI_Service_Log__c ordLog = new EOF_EAI_Service_Log__c();
            ordLog.RecordTypeId = domWsAttivazioneRType;
		    ordLog.EOF_TIpo_comunicazione_String__c = 'SFDC -> DOM';
            ordLog.Caso__c = notfy.Caso__c;
		    ordLog.Notify__c = notfy.id;
		    ordLog.EOF_ID_Notifica__c = notfy.name;
            ordLog.EOF_Codice_Ordine_OLO__c = notfy.EOF_Codice_Ordine_OLO__c;
		    ordLog.OF_SA_Azione__c =PO_FATT_WS_PSM_Notify_Utils.AZIONE_ATTIVAZIONE;
		    ordLog.EOF_Data_Notifica__c = notfy.EOF_Data_notifica__c;
            ordineLogs.add(ordLog);

            System.debug('##### writeLog ActivationP2P elemento notify: ' +  notfy);
        }      

        insert ordineLogs;    
        System.debug('##### Inseriti log degli ordini: ' + ordineLogs);    

        return sLog;
    } 

    public static EOF_EAI_Service_Log__c writeResponseLog(OLO_Activation_P2PSchema.Create_P2P_Request_element rqst,
            OLO_Activation_P2PSchema.Create_Response response) {
            
        System.debug('##### OLO_ActivationP2PUtils.writeResponseLog -- START -- params:  request - response: ' + 
            rqst + ' - ' + response);

        EOF_EAI_Service_Log__c responseLog = new EOF_EAI_Service_Log__c();
        Id domWsAttivazioneRType = Schema.SObjectType.EOF_EAI_Service_log__c.getRecordTypeInfosByName().get('DOM WS OUT ACK NACK')
            .getRecordtypeid();
        responseLog.RecordTypeId = domWsAttivazioneRType;   
        responseLog.EOF_Stato_Richiesta__c = response.ESITO == '0' ? 'ACK' : 'NACK';
        responseLog.EOF_Tipo_Comunicazione_String__c = 'DOM -> SFDC';
        if(response.ESITO == '1') {
            responseLog.EOF_Codice_Errore__c = response.CODICE_MOTIVAZIONE;
            responseLog.EOF_Causale_Errore__c = response.MOTIVAZIONE;
            responseLog.EOF_Response__c = String.valueOf(response);
        } else {
            responseLog.EOF_Richiesta_Notifica__c = 'Esito:' + response.ESITO;
        }

        List<Case> l_fatt = [SELECT Id FROM Case WHERE EOF_Codice_Ordine_OLO__c =: rqst.fattibilita.ID_FATTIBILITA];
        List<EOF_Notify__c> l_notify = [SELECT Name FROM EOF_Notify__c WHERE Id =: rqst.header.ID_NOTIFICA];

        if(!l_fatt.isEmpty()) {
            responseLog.Caso__c = l_fatt[0].Id;
            responseLog.EOF_Codice_Ordine_OLO__c = rqst.fattibilita.ID_FATTIBILITA;
            
            List<EOF_EAI_Service_Log__c> l_log = [SELECT Id FROM EOF_EAI_Service_Log__c WHERE Caso__c =: l_fatt[0].Id
                AND RecordTypeId =: domWsAttivazioneRType];
            if(!l_log.isEmpty()) {
                responseLog.EOF_SL_Riferimento__c = l_log[0].Id;
            }
        }
        if(!l_notify.isEmpty()) {
            responseLog.Notify__c = l_notify[0].Id;
            responseLog.EOF_ID_Notifica__c = l_notify[0].Name;
        }
        insert responseLog;
        return responseLog;

    }

}