global class OpportunityUtilityHandler {
    public OpportunityUtilityHandler (){
    }
        
/*
    public static boolean run=true;
    public static boolean checkonce()
    {
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }

    public Static Void updatePricebook(list<opportunity> Listopp){
        Set<ID> caseIds = new Set<ID>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Opportunity opp : Listopp){
            if(opp.PO_Collegamento__c != null){
                caseIds.add(opp.PO_Collegamento__c);
                oppList.add(opp);
            }
        }
        if(oppList.isEmpty()){
            return;
        }
        List<case> caseList = [SELECT ID,PO_Listino__c,PO_Drop_FL_1__c,PO_Tipo_di_collegamento__c,PO_Tipologia_Offerta__c,
                                contact.accountid,PO_Numero_fibre_richieste__c,PO_Tipo_percorso__c,OF_SA_Profilo__c
                                FROM Case WHERE ID IN : caseIds];
        map<Id,Case> mapCase = new map<Id,Case>();
        if(caseList.isEmpty()){
            return;
        }
        for(case c:caseList){
            mapCase.put(c.Id,c);
        }
        map<String,String> RTMap = OF_Utility.getRT_DevNameId_Map();

       //verifico che tipo di opportunità stiamo gestendo
       String tipoOpp=RTMap.get(oppList[0].recordtypeid);
       if(tipoOpp=='PO_Oppty_collegamenti_P2P_Attiva'){
            //inizio sezione P2P Attiva
            Map <string, OF_CodificaProfiloListini__c> mapCodifica=OF_CodificaProfiloListini__c.getAll();

            Map<String,Pricebook2> tipoPricebookMap = new Map<String,Pricebook2>();
            for(pricebook2 pb:[SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,
                                PO_Contratto__c ,PO_Contratto__r.id,PO_Commercial_element__r.OF_Servizio__c,
                                PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__r.accountid
                                from pricebook2 where isactive = true
                                and PO_Commercial_element__r.OF_Servizio__r.Name='P2P Attiva']){
                tipoPricebookMap.put(pb.Name,pb);
            }
            // 2018-09-11 MM : aggiunta sezione contenente logica per P2P Attiva (ripresa quella di P2P Base)
            for (Opportunity opp1 : oppList){
                Case cs=mapCase.get(opp1.PO_Collegamento__c);
                String pbName;
                if(mapCodifica.get(cs.OF_SA_Profilo__c) != null){
                    pbName=mapCodifica.get(cs.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
                }
                pbName=pbName.right(pbName.length()-14);
                system.debug('@@@@ pricebookName: '+pbName);
                if(cs.PO_Tipo_percorso__c == 'Singola Via' ){
                    if(cs.PO_Numero_fibre_richieste__c=='1'){
                        opp1.Pricebook2ID = tipoPricebookMap.get('P2PATT_001_CAN_SINGMONO_'+pbName).Id;
                    }
                    else if(cs.PO_Numero_fibre_richieste__c=='2'){
                        opp1.Pricebook2ID = tipoPricebookMap.get('P2PATT_001_CAN_SINGBI_'+pbName).Id;
                    }
                }
                else if(cs.PO_Tipo_percorso__c == 'Doppia Via'){
                    if(cs.PO_Numero_fibre_richieste__c=='1'){
                        opp1.Pricebook2ID = tipoPricebookMap.get('P2PATT_001_CAN_DOPPMONO_'+pbName).Id;
                    }
                    else if(cs.PO_Numero_fibre_richieste__c=='2'){
                        opp1.Pricebook2ID = tipoPricebookMap.get('P2PATT_001_CAN_DOPPBI_'+pbName).Id;
                    }
                }
            }
            return;// fine sezione P2P Attiva
       }
 */
	/*
	   else if(tipoOpp=='PO_Oppty_collegamenti'){
	     //inizio sezione P2P Base
	     List<pricebook2> pricelist=[SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__r.accountid  from pricebook2 where (PO_Commercial_element__r.name = 'SINGOLA VIA BIFIBRA' or PO_Commercial_element__r.name = 'SINGOLA VIA MONOFIBRA') and isactive = true and Name = 'P2P Base'
	                             ORDER BY PO_Contratto__c NULLS LAST];
	     if(pricelist.isEmpty()){
	         return;
	     }
	     //fine sezione P2P Base
	   }
	   else if(tipoOpp=='PO_Oppty_IRU'){
	     //inizio sezione IRU
	     List<pricebook2> pricelistIRU=[SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name = 'IRU' and  isactive = true
	                                ORDER BY PO_Contratto__c NULLS LAST];
	     if(pricelistIRU.isEmpty()){
	         return;
	     }
	     //fine sezione IRU
	   }
	   else if(tipoOpp=='PO_Oppty_Fiber_Link'){
	     //inizio sezione Fiberlink
	     list<pricebook2> PricelistFiberlink = [SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name like '%Fiber Link Fascia%' and isactive = true
	                                        ORDER BY PO_Contratto__c NULLS LAST];
	     if(PricelistFiberlink.isEmpty()){
	         return;
	     }
	     //fine sezione Fiberlink
	   }
	   else if(tipoOpp=='PO_Oppty_Fiber_Lease'){
	     //inizio sezione FiberLease
	     list<pricebook2> PricelistFiberLease = [SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name like '%Fiber Link Misto Fascia%' and isactive = true
	                                         ORDER BY PO_Contratto__c NULLS LAST];
	     if(PricelistFiberLease.isEmpty()){
	         return;
	     }
	     //fine sezione FiberLease
	   }
	   else if(tipoOpp=='PO_Oppty_Evento_Temporaneo'){
	     //inizio sezione PricelistEvento
	     list<pricebook2> PricelistEvento = [SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name like 'Evento Temporaneo' and isactive = true and Default__c = true
	                                     ORDER BY PO_Contratto__c NULLS LAST];
	     if(PricelistEvento.isEmpty()){
	         return;
	     }
	     //fine sezione FiberLease
	   }
	    ---- fine parte nuova------
	 */
	//system.debug('--caseIds--'+caseIds);
/*
        List<pricebook2> pricelist=[SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__r.accountid  from pricebook2 where (PO_Commercial_element__r.name = 'SINGOLA VIA BIFIBRA' or PO_Commercial_element__r.name = 'SINGOLA VIA MONOFIBRA') and isactive = true and Name = 'P2P Base'
                                    ORDER BY PO_Contratto__c NULLS LAST];

        List<pricebook2> pricelistIRU=[SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name = 'IRU' and  isactive = true
                                       ORDER BY PO_Contratto__c NULLS LAST];
        list<pricebook2> PricelistFiberlink = [SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name like '%Fiber Link Fascia%' and isactive = true
                                               ORDER BY PO_Contratto__c NULLS LAST];
        list<pricebook2> PricelistEvento = [SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name like 'Evento Temporaneo' and isactive = true and Default__c = true
                                            ORDER BY PO_Contratto__c NULLS LAST];
        list<pricebook2> PricelistFiberLease = [SELECT Id,Name,PO_Commercial_element__c,Default__c,PO_Commercial_element__r.name,PO_Commercial_element__r.OF_Servizio__c,PO_Commercial_element__r.OF_Servizio__r.name,PO_Contratto__c ,PO_Contratto__r.id,PO_Contratto__r.accountid  from pricebook2 where name like '%Fiber Link Misto Fascia%' and isactive = true
                                                ORDER BY PO_Contratto__c NULLS LAST];

        //System.debug('==pricelistIRU=='+pricelistIRU);

        //27-12-2018 V1 BUGFIX P2PATTIVA Inizio
        List<OF_ContrattoServizio__c> contrattiP2Pbase = [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'P2P Base'];
        List<OF_ContrattoServizio__c> contrattiIru = [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'IRU'];
        List<OF_ContrattoServizio__c> contrattiFiberLink = [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'Fiber Link'];
        //27-12-2018 V1 BUGFIX P2PATTIVA Fine

        try
        {

            if(pricelist.size()>0 && caseList.size() >0)
            {
                for(case cs : caseList){

                    for(Opportunity opp1 : Listopp){

                        //system.debug('before updating pricebook checking contract===='+opp1.PO_Contratto__c);
                        if(cs.PO_Tipologia_Offerta__c == 'P2P Base' && cs.PO_Tipologia_Offerta__c != null && cs.PO_Tipo_percorso__c  != null )
                        {
                            for(pricebook2 p : pricelist){
                                string pricebookname = p.name;

                                if(p.PO_Commercial_element__r.name != null &&  cs.PO_Tipo_percorso__c == 'Singola Via' )
                                {
                                    //27-12-2018 V1 BUGFIX P2PATTIVA Inizio
                                    //for(OF_ContrattoServizio__c cslst : [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'P2P Base'])
                                    for(OF_ContrattoServizio__c cslst : contrattiP2PBase)
                                    //27-12-2018 V1 BUGFIX P2PATTIVA Fine
                                    {

                                        if(p.PO_Contratto__c != null)
                                        {
                                            if( cs.contact.accountid == p.PO_Contratto__r.accountid && pricebookname.contains('P2P Base') && p.PO_Commercial_element__r.OF_Servizio__r.name == 'P2P Base' && cslst.OF_Contract__c == p.PO_Contratto__c && cslst.OF_Servizio__c == p.PO_Commercial_element__r.OF_Servizio__c)
                                            {
                                                if(cslst.OF_Contract__c == p.PO_Contratto__c && cslst.OF_Servizio__c == p.PO_Commercial_element__r.OF_Servizio__c)
                                                {
                                                    if(cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }

                                                    if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA'  && opp1.Pricebook2Id == null){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                                }
                                            }
                                            else
                                            {
                                                if(cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA'&& pricebookname.contains('P2P Base') &&  opp1.Pricebook2Id == null)
                                                {
                                                    if(p.Default__c == true)
                                                    {
                                                        opp1.Pricebook2ID = p.id;
                                                    }
                                                }

                                                if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && pricebookname.contains('P2P Base')  && opp1.Pricebook2Id == null)
                                                {
                                                    if(p.Default__c == true)
                                                    {
                                                        opp1.Pricebook2ID = p.id;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if(cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA'&& pricebookname.contains('P2P Base') &&  opp1.Pricebook2Id == null)
                                            {
                                                if(p.Default__c == true)
                                                {
                                                    opp1.Pricebook2ID = p.id;
                                                }
                                            }

                                            if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && pricebookname.contains('P2P Base')  && opp1.Pricebook2Id == null)
                                            {
                                                if(p.Default__c == true)
                                                {
                                                    opp1.Pricebook2ID = p.id;
                                                }
                                            }

                                        }
                                    }


                                }
                            }

                        }
                        for(pricebook2 p : pricelistIRU)
                        {
                            string pricebookname = p.name;

                            if(cs.PO_Tipologia_Offerta__c != null && cs.PO_Tipo_percorso__c  != null  )
                            {
                                if(p.PO_Commercial_element__r.name != null )
                                {
                                    if(cs.PO_Tipologia_Offerta__c == 'IRU' && pricebookname.contains('IRU')  && p.PO_Commercial_element__r.OF_Servizio__r.name =='IRU')
                                    {
                                        //27-12-2018 V1 BUGFIX P2PATTIVA Inizio
                                        //for(OF_ContrattoServizio__c cslst : [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'IRU'])
                                        for(OF_ContrattoServizio__c cslst : contrattiIru)
                                        //27-12-2018 V1 BUGFIX P2PATTIVA Fine
                                        {
                                            if(opp1.PO_Contratto__c != null)
                                            {
                                                if(cslst.OF_Contract__c == p.PO_Contratto__c && cslst.OF_Servizio__c == p.PO_Commercial_element__r.OF_Servizio__c && cs.contact.accountid == p.PO_Contratto__r.accountid)
                                                {
                                                    system.debug('entering====iru7');

                                                    if(p.Name == 'IRU' && p.Name!= null  && opp1.Pricebook2ID == null){

                                                        system.debug('entering====iru8');
                                                        if( p.PO_Commercial_element__r.name == 'Backhauling' && cs.PO_Tipo_di_collegamento__c == 'Backhauling'){
                                                            system.debug('entering====iru10');
                                                            opp1.Pricebook2ID = p.id;
                                                        }
                                                        if( p.PO_Commercial_element__r.name == 'BTS' && cs.PO_Tipo_di_collegamento__c == 'BTS'){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                        if( p.PO_Commercial_element__r.name == 'P2P - Cliente' && cs.PO_Tipo_di_collegamento__c == 'P2P - Cliente'){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                        if( p.PO_Commercial_element__r.name == 'Dark Fiber' && cs.PO_Tipo_di_collegamento__c == 'Dark Fiber'){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                    }
                                                }
                                                else
                                                {
                                                    if(p.Name == 'IRU' && p.Name!= null && opp1.Pricebook2ID == null)
                                                    {
                                                        //system.debug('entering====iru12');
                                                        //system.debug('entering====iru13'+p.Default__c);
                                                        //system.debug('entering====iru14'+p);
                                                        if(p.Default__c == true)
                                                        {
                                                            //system.debug('entering====iru13');
                                                            if( p.PO_Commercial_element__r.name == 'Backhauling' && cs.PO_Tipo_di_collegamento__c == 'Backhauling'){
                                                                opp1.Pricebook2ID = p.id;
                                                                //system.debug('entering====iru14');

                                                            }
                                                            if( p.PO_Commercial_element__r.name == 'BTS' && cs.PO_Tipo_di_collegamento__c == 'BTS'){
                                                                opp1.Pricebook2ID = p.id;
                                                            }
                                                            if( p.PO_Commercial_element__r.name == 'P2P - Cliente' && cs.PO_Tipo_di_collegamento__c == 'P2P - Cliente'){
                                                                opp1.Pricebook2ID = p.id;
                                                                //system.debug('Entering====7');
                                                            }
                                                            if( p.PO_Commercial_element__r.name == 'Dark Fiber' && cs.PO_Tipo_di_collegamento__c == 'Dark Fiber'){
                                                                opp1.Pricebook2ID = p.id;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                //system.debug('entering====iru9');

                                                if(p.Name == 'IRU' && p.Name!= null && opp1.Pricebook2ID == null)
                                                {
                                                    //system.debug('entering====iru12');
                                                    //system.debug('entering====iru13'+p.Default__c);
                                                    //system.debug('entering====iru14'+p);
                                                    if(p.Default__c == true)
                                                    {
                                                        //system.debug('entering====iru13');
                                                        if( p.PO_Commercial_element__r.name == 'Backhauling' && cs.PO_Tipo_di_collegamento__c == 'Backhauling'){
                                                            opp1.Pricebook2ID = p.id;
                                                            //system.debug('entering====iru14');

                                                        }
                                                        if( p.PO_Commercial_element__r.name == 'BTS' && cs.PO_Tipo_di_collegamento__c == 'BTS'){
                                                            opp1.Pricebook2ID = p.id;
                                                        }
                                                        if( p.PO_Commercial_element__r.name == 'P2P - Cliente' && cs.PO_Tipo_di_collegamento__c == 'P2P - Cliente'){
                                                            opp1.Pricebook2ID = p.id;
                                                            //system.debug('Entering====7');
                                                        }
                                                        if( p.PO_Commercial_element__r.name == 'Dark Fiber' && cs.PO_Tipo_di_collegamento__c == 'Dark Fiber'){
                                                            opp1.Pricebook2ID = p.id;
                                                        }
                                                    }
                                                }
                                            }

                                        }

                                    }
                                }
                            }
                        }
                        for(pricebook2 p : PricelistFiberlink)
                        {
                            string pricebookname = p.name;

                            if(cs.PO_Tipologia_Offerta__c != null && cs.PO_Tipo_percorso__c  != null  )
                            {
                                if(p.PO_Commercial_element__r.name != null )
                                {
                                    string flink = cs.PO_Tipologia_Offerta__c + ' '+cs.PO_Listino__c;
                                    system.debug('flink======'+flink);
                                    system.debug('pricebookname======'+pricebookname);
                                    system.debug('compare======'+flink.contains(pricebookname));

                                    if(opp1.PO_Contratto__c != null && cs.PO_Tipologia_Offerta__c == 'Fiber Link' && flink.contains(pricebookname)  && p.PO_Commercial_element__r.OF_Servizio__r.name =='Fiber Link')
                                    {
                                        //27-12-2018 V1 BUGFIX P2PATTIVA Inizio
                                        //for(OF_ContrattoServizio__c cslst : [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'Fiber Link'])
                                        for(OF_ContrattoServizio__c cslst : contrattiFiberLink)
                                        //27-12-2018 V1 BUGFIX P2PATTIVA Fine
                                        {

                                            if(cslst.OF_Contract__c == p.PO_Contratto__c && cslst.OF_Servizio__c == p.PO_Commercial_element__r.OF_Servizio__c && cs.contact.accountid == p.PO_Contratto__r.accountid)
                                            {
                                                system.debug('entering====fiber link7');

                                                if(flink.contains(pricebookname) && p.Name!= null  && opp1.Pricebook2ID == null){

                                                    system.debug('entering====fiber link8');
                                                    if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                        system.debug('entering====fiber link10');
                                                        opp1.Pricebook2ID = p.id;
                                                    }
                                                    //cs.PO_Numero_fibre_richieste__c == '2' &&
                                                    if( p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                                    if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                                     if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }

                                                }
                                            }
                                            else
                                            {
                                                if(flink.contains(pricebookname) && p.Name!= null && opp1.Pricebook2ID == null)
                                                {
                                                    if(p.Default__c == true)
                                                    {
                                                        if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                            system.debug('entering====fiber link10');
                                                            opp1.Pricebook2ID = p.id;
                                                        }
                                                        //cs.PO_Numero_fibre_richieste__c == '2' &&
                                                        if(p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                        if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                         if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                                    }



                                                }

                                            }
                                        }


                                    }


                                    else
                                    {
                                        system.debug('entering====fiber link');

                                        if(flink.contains(pricebookname) && p.Name!= null && opp1.Pricebook2ID == null)
                                        {
                                            if(p.Default__c == true)
                                            {
                                                if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                    system.debug('entering====fiber link10');
                                                    opp1.Pricebook2ID = p.id;
                                                }
                                                //cs.PO_Numero_fibre_richieste__c == '2' &&
                                                system.debug('entering====fiber link12'+p.PO_Commercial_element__r.name);
                                                system.debug('entering====fiber link13'+cs.PO_Tipo_percorso__c);
                                                system.debug('entering====fiber link14'+opp1.Pricebook2Id);
                                                if( p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){
                                                      system.debug('entering====fiber link11');
                                                    opp1.Pricebook2ID = p.id;

                                                }
                                                if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }
                                                 if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                            }



                                        }

                                    }
                                }
                            }
                        }

                        for(pricebook2 p : PricelistEvento)
                        {
                            string pricebookname = p.name;

                            if(cs.PO_Tipologia_Offerta__c != null && cs.PO_Tipo_percorso__c  != null  )
                            {
                                if(p.PO_Commercial_element__r.name != null )
                                {

                                    if(cs.PO_Tipologia_Offerta__c == 'Evento Temporaneo' && cs.PO_Tipologia_Offerta__c == pricebookname && p.PO_Commercial_element__r.OF_Servizio__r.name =='Fiber Link')
                                    {

                                        if(p.Name!= null && opp1.Pricebook2ID == null)
                                        {
                                            if(p.Default__c == true)
                                            {
                                                if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                    //system.debug('entering====fiber link10');
                                                    opp1.Pricebook2ID = p.id;
                                                }
                                                if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }
                                                if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }
                                                if( p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }
                                            }
                                        }

                                    }
                                }
                            }
                        }
                        for(pricebook2 p : PricelistFiberLease)
                        {
                            string pricebookname = p.name;

                            if(cs.PO_Tipologia_Offerta__c != null && cs.PO_Tipo_percorso__c  != null && cs.PO_Drop_FL_1__c == true )
                            {
                                if(p.PO_Commercial_element__r.name != null )
                                {
                                    string flink = 'Fiber Link Misto' + ' '+cs.PO_Listino__c;
                                    //system.debug('flink======'+flink);
                                    //system.debug('pricebookname======'+pricebookname);
                                    //system.debug('compare======'+flink.contains(pricebookname));
                                    System.debug(LoggingLevel.INFO,flink.contains(pricebookname));

                                    if(opp1.PO_Contratto__c != null && cs.PO_Tipologia_Offerta__c == 'Fiber Lease' && flink.contains(pricebookname)  && p.PO_Commercial_element__r.OF_Servizio__r.name =='Fiber Link')
                                    {
                                        //27-12-2018 V1 BUGFIX P2PATTIVA Inizio
                                        //for(OF_ContrattoServizio__c cslst : [SELECT Id,Name,OF_Contract__c,OF_Servizio__c,OF_Servizio__r.name FROM OF_ContrattoServizio__c where OF_Servizio__r.Name = 'Fiber Link'])
                                        for(OF_ContrattoServizio__c cslst : contrattiFiberLink)
                                        //27-12-2018 V1 BUGFIX P2PATTIVA Fine
                                        {

                                            if(cslst.OF_Servizio__c == p.PO_Commercial_element__r.OF_Servizio__c && cs.contact.accountid == p.PO_Contratto__r.accountid)
                                            {
                                                //system.debug('entering====fiber link7');

                                                if(flink.contains(pricebookname) && p.Name!= null  && opp1.Pricebook2ID == null){

                                                    //system.debug('entering====fiber link8');
                                                    if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                        //system.debug('entering====fiber link10');
                                                        opp1.Pricebook2ID = p.id;
                                                    }
                                                    if(p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                                    if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }
                                                    if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                        opp1.Pricebook2ID = p.id;

                                                    }

                                                }
                                            }
                                            else
                                            {
                                                if(flink.contains(pricebookname) && p.Name!= null && opp1.Pricebook2ID == null)
                                                {
                                                    if(p.Default__c == true)
                                                    {
                                                        if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                            //system.debug('entering====fiber link10');
                                                            opp1.Pricebook2ID = p.id;
                                                        }
                                                        if(p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                        if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                            opp1.Pricebook2ID = p.id;

                                                        }
                                                        if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                            opp1.Pricebook2ID = p.id;

                                                        }

                                                    }



                                                }
                                            }
                                        }


                                    }


                                    else
                                    {
                                        //system.debug('entering====fiber link');

                                        if(flink.contains(pricebookname) && p.Name!= null && opp1.Pricebook2ID == null)
                                        {
                                            if(p.Default__c == true)
                                            {
                                                if( cs.PO_Numero_fibre_richieste__c == '1' && p.PO_Commercial_element__r.name == 'SINGOLA VIA MONOFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){
                                                    //system.debug('entering====fiber link10');
                                                    opp1.Pricebook2ID = p.id;
                                                }
                                                if(p.PO_Commercial_element__r.name == 'DOPPIA VIA DIVERSIFICATA' && cs.PO_Tipo_percorso__c == 'Doppia Via Diversificata' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }
                                                if(cs.PO_Numero_fibre_richieste__c == '2' && p.PO_Commercial_element__r.name == 'SINGOLA VIA BIFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }
                                                if(cs.PO_Numero_fibre_richieste__c == '4' && p.PO_Commercial_element__r.name == 'SINGOLA VIA TETRAFIBRA' && cs.PO_Tipo_percorso__c == 'Singola Via' && opp1.Pricebook2Id == null ){

                                                    opp1.Pricebook2ID = p.id;

                                                }

                                            }



                                        }

                                    }
                                }
                            }
                        }

                    }
                }
            }
            //system.debug('CRM 24_08 Listopp:'+Listopp);
        }
        catch(exception e){
            system.debug('error===='+e.getStackTraceString());}
    }
    public Static Void updateProduct(list<opportunity> OpportunityList) {

        //system.debug('CRM 22_08 --OSCRM updateProduct OpportunityList:'+OpportunityList);
        set<Id> priceBookId = new set<Id>();
        List<PricebookEntry> priceBookenrtyList = new List<PricebookEntry>();
        for( Opportunity oppObj : OpportunityList){
            if(oppObj.Pricebook2Id != null && oppObj.PO_Collegamento__c != null)
            {
                priceBookId.add(oppObj.Pricebook2Id);
            }

        }

        if(priceBookId != null)
        {
            priceBookenrtyList = [SELECT Id,Name,Pricebook2Id,Product2Id,UnitPrice,
                                  UseStandardPrice FROM PricebookEntry
                                  WHERE Pricebook2Id IN : priceBookId ];
        }
        //Start-Added by sasya on 17-08-2017
        //system.debug('OpportunityList======='+OpportunityList);
        //system.debug('priceBookId======='+priceBookId);
        //system.debug('priceBookenrtyList ======='+priceBookenrtyList );

        //End-Added by sasya on 17-08-2017

        List<OpportunityLineItem> OpportunityLineItemsList = new List<OpportunityLineItem>();
        if(priceBookenrtyList.size()>0)
        {
            for(Opportunity op :OpportunityList){
                for(PricebookEntry pricebook : priceBookenrtyList){
                    if(pricebook.Pricebook2Id == op.Pricebook2Id )
                    {
                        OpportunityLineItemsList.add(
                            new OpportunityLineItem(OpportunityId = op.Id,
                                                    PricebookEntryId = pricebook.id,
                                                    Quantity = 1,
                                                    PO_SalesPrice__c = pricebook.UnitPrice,
                                                    unitprice = pricebook.UnitPrice
                                                   )
                        );
                    }
                }
            }
        }
        //system.debug('CRM 22_08 OpportunityLineItemsList:'+OpportunityLineItemsList);
        try
        {
            if(!OpportunityLineItemsList.isEmpty()){
                database.upsert (OpportunityLineItemsList,false);
            }
        }
        catch(exception e){system.debug('error===='+e.getStackTraceString());
                          }

    }
    public static void ParentOpportunityUpdation(list<opportunity> opplst)
    {
        set<id> oppids = new set<id>();
        set<string> oppParentcaseids = new set<string>();
        for(opportunity opp : opplst)
        {
            oppids.add(opp.id);
            if(opp.PO_Richiesta_fattibilit__c != null && opp.PO_Collegamento__c == null)
            {
                oppParentcaseids.add(opp.PO_Richiesta_fattibilit__c);
            }
        }

        map<id,opportunity> childopps =  new map<id,opportunity>([select Id,PO_Collegamento__c,PO_Incluso_nell_offerta__c,PO_ParentCase__c,PO_Richiesta_fattibilit__c,
                                                                  PO_Offerta_totale__c,PO_Collegamento__r.parentid,PO_Richiesta_fattibilit__r.Id,PO_Richiesta_fattibilit__r.caseNumber,
                                                                  PriceBook2Id
                                                                  from Opportunity where PO_ParentCase__c IN : oppParentcaseids and PO_Collegamento__c != null]); //and PO_Richiesta_fattibilit__c != null


        //system.debug('CRM 23_08 OpportunityUtilityHandler.ParentOpportunityUpdation --childopps :'+childopps );
        map<id,opportunity> Updateopplst = new map<id,opportunity>();

        if( childopps.values().size() > 0)

            for(opportunity oppty : opplst)
        {

            if(oppty.PO_Richiesta_fattibilit__c != null && oppty.PO_Collegamento__c == null && oppty.Pricebook2Id == null)
            {

                for(opportunity opp : childopps.values())
                {

                    if(opp != null && (oppty.PO_Richiesta_fattibilit__c == opp.PO_ParentCase__c) )
                    {

                        opp.PO_Offerta_totale__c = oppty.id;

                        Updateopplst.put(opp.id,opp);
                    }
                }
            }
        }
        try
        {
            if(Updateopplst.values().size()>0 && !Updateopplst.values().isEmpty())
            {
                update Updateopplst.values();

            }
        }
        catch(exception e){
            system.debug('error========='+e.getStackTraceString());

        }
    }
    public Static Void CalculateOpp(list<opportunity> vlstOpp)
    {
        Map<ID, Opportunity> parentOpps = new Map<ID, Opportunity>();
        Map<id,case> casesMap = new map<id,case>();
        set<id> Oppids = new set<id>();
        set<id> caseids = new set<id>();
        for(opportunity opp : vlstOpp)
        {
            if(opp.PO_Richiesta_fattibilit__c !=null && opp.PO_Collegamento__c == null)
            {
                Oppids.add(opp.id);
                caseids.add(opp.PO_Richiesta_fattibilit__c);
            }
        }
        //SYSTEM.debug('Oppids======'+Oppids);
        parentOpps = new map<id,opportunity>([select id,name,PO_Richiesta_fattibilit__r.ID,PO_Totale_canoni__c,PO_Summary__c,PO_Totale_contributi_attivazione__c,PO_Totale_costi_aggiuntivi__c,PO_Collegamento__c from Opportunity where id IN :Oppids and PO_Richiesta_fattibilit__c != null and PO_Collegamento__c = null]);
        map<id,opportunity> vmapChildOpp = new map<id,opportunity>([select id,name,PO_Incluso_nell_offerta__c, PO_Offerta_totale__r.id,PO_ParentCase__c,PO_Collegamento__c,PO_Costi_aggiuntivi_collegamento__c,PO_CostiAggiuntiviCollegamento__c,PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c from Opportunity where PO_Offerta_totale__r.id IN :Oppids and PO_Collegamento__c != null]);
        casesMap = new map<id,case>([select id,PO_Incluso_nell_offerta__c from case where id IN :caseids and parentid != null]);
        //system.debug('vmapParentOpp===='+parentOpps.values());
        map<id,opportunity> recordstoupdate = new map<id,opportunity>();
        try
        {
            decimal val1 = 0.0;
            decimal val2 = 0.0;
            decimal val3 = 0.0;

            for(opportunity opp : vmapChildOpp.values())

            {
                opportunity oppup = parentOpps.get(opp.PO_Offerta_totale__c);
                case cs = casesMap.get(opp.PO_Collegamento__c);

                if(opp.PO_Incluso_nell_offerta__c == true)
                {
                    if(opp.PO_Canone_collegamento__c != null)
                    {
                        val1 += opp.PO_Canone_collegamento__c;
                    }

                    if(opp.PO_Contributo_attivazione_collegamento__c != null)
                    {
                        val2 += opp.PO_Contributo_attivazione_collegamento__c;
                    }
                    //01/08/2017 Modifica CRM
                    if(opp.PO_CostiAggiuntiviCollegamento__c != null)
                    {
                        val3 += opp.PO_CostiAggiuntiviCollegamento__c;
                    }


                    //if(opp.PO_Costi_aggiuntivi_collegamento__c != null)
                    //{
                    //  val3 += opp.PO_Costi_aggiuntivi_collegamento__c;
                    //}
                    // 01/08/2017 END CRM

                }
                if(val1 != null  && oppup != null)
                {
                    oppup.PO_Totale_canoni__c = val1;
                    recordstoupdate.put(oppup.id,oppup);
                }

                if(val2 != null && oppup != null)
                {
                    oppup.PO_Totale_contributi_attivazione__c = val2;
                    recordstoupdate.put(oppup.id,oppup);
                }

                if(val3 != null && oppup != null)
                {
                    oppup.PO_Totale_costi_aggiuntivi__c = val3;
                    recordstoupdate.put(oppup.id,oppup);
                }
            }
            // if(recordstoupdate.values().size()>0 )
            //    {
            //     update recordstoupdate.values();
            //    }
        }


        catch(exception e)
        {
            system.debug('Error message'+e.getStackTraceString());
            system.debug('Error message'+e.getCause());
            system.debug('Error message'+e.getTypeName());
            system.debug('Error message'+e.getMessage());
        }

    }

    @future
    public Static Void ChildCalculateOpp(set<id> vlstOppids )
    {
        List<Opportunity> parentOpps = new List<Opportunity>();
        FutureUtility.isFutureUpdate = true;


        Map<id,Opportunity> recordstoupdate = new Map<id,Opportunity>();
        parentOpps = [select id,name,PO_Richiesta_fattibilit__r.ID,
                      PO_Totale_canoni__c,PO_Summary__c,PO_Totale_contributi_attivazione__c,
                      PO_Totale_costi_aggiuntivi__c,PO_Collegamento__c,
                      PO_Totale_canoni_manutenzione__c,PO_Totale_corrispettivi_IRU__c,
                      PO_Totale_Canone_Anno1__c,PO_Totale_Contributi_Attiva_Anno1__c,PO_Totale_Costi_Aggiuntivi_Anno1__c,
                      PO_Totale_Canone_Anno2__c,PO_Totale_Contributi_Attiva_Anno2__c,PO_Totale_Costi_Aggiuntivi_Anno2__c,
                      PO_Totale_Canone_Anno3__c,PO_Totale_Contributi_Attiva_Anno3__c,PO_Totale_Costi_Aggiuntivi_Anno3__c,
                      PO_Totale_Canone_Altri_Anni__c,PO_Totale_Contributi_Attiva_Altri_Anni__c,PO_Totale_Costi_Aggiuntivi_Altri_Anni__c,
                      PO_Totale_valori_medi_annui_altre_copp__c,PO_Totale_valori_medi_annui__c,PO_Totale_valori_prime_coppie_fino_2030__c,
                      (
                          select id,name,PO_Incluso_nell_offerta__c,Recordtype.name,
                          PO_Canone_manutenzione_collegamento__c,PO_Corrispettivo_IRU__c,
                          PO_Offerta_totale__r.id,PO_ParentCase__c,
                          PO_Collegamento__c,PO_Costi_aggiuntivi_collegamento__c,PO_CostiAggiuntiviCollegamento__c,
                          PO_Canone_collegamento__c,PO_Contributo_attivazione_collegamento__c,
                          PO_Canone_annuo_1anno__c,PO_Contributo_attivazione_1anno__c,PO_Costi_Aggiuntivi_Anno1__c,
                          PO_Canone_annuo_2anni__c,PO_Contributo_attivazione_2anni__c,PO_Costi_Aggiuntivi_Anno2__c,
                          PO_Canone_annuo_3anni__c,PO_Contributo_attivazione_3anni__c,PO_Costi_Aggiuntivi_Anno3__c,
                          PO_Canone_annuo_AltriAnni__c,PO_Contributo_attivazione_altri_anni__c,PO_Costi_Aggiuntivi_Altri_Anni__c,
                          PO_Valore_medio_annuo_altre_coppie__c,PO_Valore_medio_annuo_totale__c,PO_Valore_totale_prima_coppia_fino_2030__c,
                          PO_CostiCollegamento__c
                          from Opportunities__r)

                      from Opportunity
                      where id IN : vlstOppids and PO_Richiesta_fattibilit__c != null and PO_Collegamento__c = null];

        //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp parentOpps:'+parentOpps);

        try{
            for( Opportunity parentOpp : parentOpps )
            {
                decimal val1 = null;
                decimal val2 = null;
                decimal val3 = null;
                //07/08/2017 Modifica CRM
                decimal val4 = null;
                decimal val5 = null;
                //END 07/08/2017 Modifica CRM
                //10/08/2017 Modifica CRM
                decimal val6 = null;
                decimal val7 = null;
                decimal val8 = null;
                decimal val9 = null;
                decimal val10 = null;
                decimal val11 = null;
                decimal val12 = null;
                decimal val13 = null;
                decimal val14 = null;
                decimal val15 = null;
                decimal val16 = null;
                decimal val17 = null;
                decimal val18 = null;
                decimal val19 = null;
                decimal val20 = null;
                decimal val21 = null;
                //END 10/08/2017 Modifica CRM
                List<Opportunity> ChildOpps = parentOpp.Opportunities__r;

                for( Opportunity childOpp : ChildOpps )
                {
                    //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp childOpp:'+childOpp );
                    if(childOpp.PO_Incluso_nell_offerta__c == true)
                    {
                        //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp childOpp.recordtype.name: ' + childOpp.recordtype.name );
                        //07/08/2017 Modifica CRM
                        if( (childOpp.recordtype.name == 'PO Oppty Evento Temporaneo') ||
                           (childOpp.recordtype.name == 'PO Oppty collegamenti') ||
                           (childOpp.recordtype.name == 'PO Oppty IRU') ||
                           //(childOpp.recordtype.name == 'PO Oppty Fiber Lease') ||
                           (childOpp.RecordType.name == 'PO Oppty Misto Lease-Link per FW'))
                        {

                            // NOT FIBER LEASE MISTO
                            if(childOpp.RecordType.name != 'PO Oppty Misto Lease-Link per FW')
                            {
                                //01/08/2017 Modifica CRM
                                if(childOpp.PO_CostiAggiuntiviCollegamento__c != null)
                                {
                                    if(val3 == null)
                                        val3 = 0.00;
                                    if(val3 != null)
                                        val3 += childOpp.PO_CostiAggiuntiviCollegamento__c;
                                }
                            }
                            if(childOpp.PO_Contributo_attivazione_collegamento__c != null)
                            {
                                if(val2 == null)
                                    val2 = 0.00;
                                if(val2 != null)
                                    val2 += childOpp.PO_Contributo_attivazione_collegamento__c;
                            }

                            // ONLY IRU
                            if(childOpp.recordtype.name == 'PO Oppty IRU')
                            {
                                if(childOpp.PO_Canone_manutenzione_collegamento__c != null)
                                {
                                    if(val4 == null)
                                        val4 = 0.00;
                                    if(val4 != null)
                                        val4 += childOpp.PO_Canone_manutenzione_collegamento__c;
                                }
                                if(childOpp.PO_Corrispettivo_IRU__c != null)
                                {
                                    if(val5 == null)
                                        val5 = 0.00;
                                    if(val5 != null)
                                        val5 += childOpp.PO_Corrispettivo_IRU__c;
                                }
                            }
                            // ONLY P2P & Evento Temporaneo & Misto Lease-Link per FW
                            else{
                                if(childOpp.PO_Canone_collegamento__c != null)
                                {
                                    if(val1 == null)
                                        val1 = 0.00;
                                    if(val1 != null)
                                        val1 += childOpp.PO_Canone_collegamento__c;
                                }
                            }
                        }
                        // FIBER LINK
                        if(childOpp.recordtype.name == 'PO Oppty Fiber Link')
                        {
                            //10/08/2017 Modifica CRM
                            // Anno 1
                            if(childOpp.PO_Canone_annuo_1anno__c != null)
                            {
                                if(val6 == null)
                                    val6 = 0.00;
                                if(val6 != null)
                                    val6 += childOpp.PO_Canone_annuo_1anno__c;
                            }
                            if(childOpp.PO_Contributo_attivazione_1anno__c != null)
                            {
                                if(val7 == null)
                                    val7 = 0.00;
                                if(val7 != null)
                                    val7 += childOpp.PO_Contributo_attivazione_1anno__c;
                            }
                            if(childOpp.PO_Costi_Aggiuntivi_Anno1__c != null)
                            {
                                if(val8 == null)
                                    val8 = 0.00;
                                if(val8 != null)
                                    val8 += childOpp.PO_Costi_Aggiuntivi_Anno1__c;
                            }
                            // Anno 2
                            if(childOpp.PO_Canone_annuo_2anni__c != null)
                            {
                                if(val9 == null)
                                    val9 = 0.00;
                                if(val9 != null  && childOpp.PO_Incluso_nell_offerta__c == true)
                                    val9 += childOpp.PO_Canone_annuo_2anni__c;
                            }
                            if(childOpp.PO_Contributo_attivazione_2anni__c != null)
                            {
                                if(val10 == null)
                                    val10 = 0.00;
                                if(val10 != null)
                                    val10 += childOpp.PO_Contributo_attivazione_2anni__c;
                            }
                            if(childOpp.PO_Costi_Aggiuntivi_Anno2__c != null)
                            {
                                if(val11 == null)
                                    val11 = 0.00;
                                if(val11 != null)
                                    val11 += childOpp.PO_Costi_Aggiuntivi_Anno2__c;
                            }
                            // Anno 3
                            if(childOpp.PO_Canone_annuo_3anni__c != null)
                            {
                                if(val12 == null)
                                    val12 = 0.00;
                                if(val12 != null)
                                    val12 += childOpp.PO_Canone_annuo_3anni__c;
                            }
                            if(childOpp.PO_Contributo_attivazione_3anni__c != null)
                            {
                                if(val13 == null)
                                    val13 = 0.00;
                                if(val13 != null)
                                    val13 += childOpp.PO_Contributo_attivazione_3anni__c;
                            }
                            if(childOpp.PO_Costi_Aggiuntivi_Anno3__c != null)
                            {
                                if(val14 == null)
                                    val14 = 0.00;
                                if(val14 != null)
                                    val14 += childOpp.PO_Costi_Aggiuntivi_Anno3__c;
                            }
                            // Altri Anni
                            if(childOpp.PO_Canone_annuo_AltriAnni__c != null)
                            {
                                if(val15 == null)
                                    val15 = 0.00;
                                if(val15 != null)
                                    val15 += childOpp.PO_Canone_annuo_AltriAnni__c;
                            }
                            if(childOpp.PO_Contributo_attivazione_altri_anni__c != null)
                            {
                                if(val16 == null)
                                    val16 = 0.00;
                                if(val16 != null)
                                    val16 += childOpp.PO_Contributo_attivazione_altri_anni__c;
                            }
                            if(childOpp.PO_Costi_Aggiuntivi_Altri_Anni__c != null)
                            {
                                if(val17 == null)
                                    val17 = 0.00;
                                if(val17 != null)
                                    val17 += childOpp.PO_Costi_Aggiuntivi_Altri_Anni__c;
                            }
                            //END 10/08/2017 Modifica CRM
                        }
                        //29/08/2017 Modifica CRM
                        system.debug('DG_childOpp.recordtype.name: ' + childOpp.recordtype.name);
                        if( (childOpp.recordtype.name == 'PO Oppty Fiber Lease')||
                           (childOpp.RecordType.name == 'PO Oppty Misto Lease-Link per FW'))
                        {
                            system.debug('DG_val21: ' + val21);
                            system.debug('DG_childOpp.PO_CostiCollegamento__c: ' + childOpp.PO_CostiCollegamento__c);
                            if(childOpp.PO_CostiCollegamento__c != null)
                            {
                                if(val21 == null)
                                    val21 = 0.00;
                                if(val21 != null)
                                    val21 += childOpp.PO_CostiCollegamento__c;

                                system.debug('DG_val21: ' + val21);
                            }

                            if(childOpp.PO_Valore_medio_annuo_altre_coppie__c != null)
                            {
                                if(val18 == null)
                                    val18 = 0.00;
                                if(val18 != null)
                                    val18 += childOpp.PO_Valore_medio_annuo_altre_coppie__c;
                            }
                            if(childOpp.PO_Valore_medio_annuo_totale__c != null)
                            {
                                if(val19 == null)
                                    val19 = 0.00;
                                if(val19 != null)
                                    val19 += childOpp.PO_Valore_medio_annuo_totale__c;
                            }
                            //30/08/2017 CRM
                            if(childOpp.PO_Valore_totale_prima_coppia_fino_2030__c != null)
                            {
                                if(val20 == null)
                                    val20 = 0.00;
                                if(val20 != null)
                                    val20 += childOpp.PO_Valore_totale_prima_coppia_fino_2030__c;
                            }
                        }
                        //END 29/08/2017 Modifica CRM
                        //END 07/08/2017 Modifica CRM
                    }
                }






                if(val1 != null){
                    //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp _ val1'+val1);
                    parentOpp.PO_Totale_canoni__c = val1;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }

                if(val2 != null){
                    //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp _ val2'+val2);
                    parentOpp.PO_Totale_contributi_attivazione__c = val2;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }

                if(val3 != null){
                    parentOpp.PO_Totale_costi_aggiuntivi__c = val3;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                //07/08/2017 Modifica CRM
                if(val4 != null){
                    parentOpp.PO_Totale_canoni_manutenzione__c = val4;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }

                if(val5 != null){
                    parentOpp.PO_Totale_corrispettivi_IRU__c = val5;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                //END 07/08/2017 Modifica CRM
                //10/08/2017 Modifica CRM
                if(val6 != null){

                    parentOpp.PO_Totale_Canone_Anno1__c = val6;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val7 != null){
                    parentOpp.PO_Totale_Contributi_Attiva_Anno1__c = val7;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val8 != null){
                    parentOpp.PO_Totale_Costi_Aggiuntivi_Anno1__c = val8;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val9 != null){
                    parentOpp.PO_Totale_Canone_Anno2__c = val9;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val10 != null){
                    parentOpp.PO_Totale_Contributi_Attiva_Anno2__c = val10;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val11 != null){
                    parentOpp.PO_Totale_Costi_Aggiuntivi_Anno2__c = val11;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val12 != null){
                    parentOpp.PO_Totale_Canone_Anno3__c = val12;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val13 != null){
                    parentOpp.PO_Totale_Contributi_Attiva_Anno3__c = val13;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val14 != null){
                    parentOpp.PO_Totale_Costi_Aggiuntivi_Anno3__c = val14;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val15 != null){
                    parentOpp.PO_Totale_Canone_Altri_Anni__c = val15;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val16 != null){
                    parentOpp.PO_Totale_Contributi_Attiva_Altri_Anni__c = val16;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val17 != null){
                    parentOpp.PO_Totale_Costi_Aggiuntivi_Altri_Anni__c = val17;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }

                //29/08/2017 CRM
                if(val18 != null){
                    parentOpp.PO_Totale_valori_medi_annui_altre_copp__c = val18;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                if(val19 != null){
                    parentOpp.PO_Totale_valori_medi_annui__c = val19;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                //30/08/2017 CRM
                if(val20 != null){
                    parentOpp.PO_Totale_valori_prime_coppie_fino_2030__c = val20;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                //14/09/2017 CRM
                if(val21 != null){
                    parentOpp.PO_Totale_costi_aggiuntivi__c = val21;
                    recordstoupdate.put(parentOpp.id,parentOpp);
                }
                //END 29/08/2017 CRM

                //END 10/08/2017 Modifica CRM
            }
            if(recordstoupdate.values().size()>0 )
            {
                //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp prima recordstoupdate.values(): '+recordstoupdate.values());
                update recordstoupdate.values();
                //system.debug('CRM_OpportunityUtilityHandler_ChildCalculateOpp dopo recordstoupdate.values(): '+recordstoupdate.values());
            }

        } catch(exception e)
        {
            system.debug('Error message'+e.getStackTraceString());
            system.debug('Error message'+e.getCause());
            system.debug('Error message'+e.getTypeName());
            system.debug('Error message'+e.getMessage());
        }



    }
 */
}