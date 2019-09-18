public class OF_ManageOrderFromCase_ServiziAttivi 
{
	//Attributi
    //Mappa per il customSetting CodificaProfiloListini
    public Map <string, OF_CodificaProfiloListini__c> mapCodifica = new Map<String,OF_CodificaProfiloListini__c>();
    
    public ID idAsset{set;get;}
    
    //Costruttore
    public OF_ManageOrderFromCase_ServiziAttivi(){
        mapCodifica = OF_CodificaProfiloListini__c.getAll();
        if(!OF_SA_GE_Utils.checkRtMap){
        	OF_SA_GE_Utils.RtMap=new Map<String,String>();
	        for( Recordtype rt : [SELECT Id,DeveloperName 
	                              FROM Recordtype]){
	            OF_SA_GE_Utils.RtMap.put( rt.DeveloperName , rt.Id );
	        }
	        OF_SA_GE_Utils.checkRtMap=true;
        }
    }
    
    //Creazione Ordine
    public Id ManageOrder( Case c ){
      //try{
            
            //Attivazione
            if( c.RecordtypeId == OF_SA_GE_Utils.RtMap.get('OF_SA_Attivazione' ) ){             
                 //Creazione Ordine
                if( (c.Status == 'Acquisito' || c.Status == 'Acquisito KO') && c.OF_Order__c == null ){
                    return creazioneOrdine( c , 'OF_INORDER'); 
                }
                if( c.Status == 'Espletato' || c.Status == 'Espletato KO' || c.Status == 'Annullato'
                   || c.Status == 'Accettato KO' ){
                    return AggiornoOrdine( c );
                 }
                
            }
            if( c.RecordTypeId == OF_SA_GE_Utils.RtMap.get( 'OF_SA_Cessazione' )  ){                
                //Creazione Ordine 
                if( ( c.Status == 'Cessato KO' || c.Status == 'Acquisito' ) && c.OF_Order__c == null ){
                    return creazioneOrdine( c , 'OF_OUTORDER');
                }
                //Aggiornamento Ordine
                if( c.Status == 'Cessato' ){
                    return AggiornoOrdine( c );
                }
                
            }
            return null;
         
     }
    public Id creazioneOrdine( Case c , String recordTypeName ){
        //try{
            order o = new order();
            o.RecordTypeId = OF_SA_GE_Utils.RtMap.get( recordTypeName );
            o.AccountId = c.EOF_Account_OLO__c;
            o.EffectiveDate = system.Today();
            o.OF_CaseID__c = c.id;
            o.OF_TipologiaDiServizio__c = TipoServ(c);
            if( recordTypeName == 'OF_INORDER' )
            {
                
                if( c.Status == 'Acquisito')
                {
                    o.Status = 'Aperto';
                    //DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
                    o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                    o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
                }
                if( c.Status == 'Acquisito KO' )
                {
                    o.Status = 'Chiuso';
                    o.OF_Esito__c = 'KO';
                    o.OF_DataEsito__c = system.Today();
                    o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
                    o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c; 
                    //END 01/06/2017
                    o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
                    //05/05/2017 DG con la nuova gestione delle verifiche commerciali e contrattuali il campo formula Codice_Ordine_EOF__c non è ancora popolato, replico la formula a codice
                    //o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
                    if(c.EOF_Order_Manager__c == true)
                    {
                       o.OF_IDOrdineEOF__c = c.id;
                    }else{
                       o.OF_IDOrdineEOF__c = String.valueOf(c.Id).substring(0, 15);
                    }
                    
                    //o.OF_TipologiaDiServizio__c = TipoServ(c);
                    c.OF_Order__c = o.id;
                    //c.OF_SA_Motivazione__c = getstrDescr();
                    //c.OF_SA_Codice_Motivazione__c = getstrCodice();
                    //END 01/06/2017
                }
              //insert o;
            }
            if( recordTypeName == 'OF_OUTORDER' )
            {

                if( c.Status == 'Cessato KO' )
                {
                    o.Status = 'Chiuso';
                    o.OF_Esito__c = 'KO';
                    o.OF_DataEsito__c = system.Today();
                    o.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
                    o.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
                }else if( c.Status == 'Acquisito')
                {
                    o.Status = 'Aperto';
                }
                
                o.OF_Asset__c = c.assetId;
                o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
                o.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
                o.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
                o.OF_Apparato__c = c.EOF_Apparato__c;
                o.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
                o.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
                o.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
                o.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;
                
            }
            if(c.OF_IDContratto__c != null){
                o.ContractId = c.OF_IDContratto__c;
            }
            o.OF_CaseID__c = c.Id;
            o.OF_CaseNome__c = c.CaseNumber;
            o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
            o.OF_IDOrdineEOF__c = c.Codice_Ordine_EOF__c;
            o.OF_IDServizio__c = c.OF_SA_ID_Servizio__c;
            if(c.OF_SA_Profilo__c != null){   
                if(mapCodifica.get(c.OF_SA_Profilo__c) != null){
                    o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
                }
            }
             //OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
             o.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
             o.OF_Promozione__c = c.OF_SA_Promozione__c ;
             o.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
             o.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
             
             boolean inserito=false;
             boolean templog=false;
            Account a = new Account();	
            Templog__c t = new Templog__c(); 
            for(integer x=0; x<50; x++){
	            try{
	            	if(x==0){
		        		insert o;
		        		inserito=true; 
	            	}
	            	if(x==1){
	            		
		            	a.name=o.OF_IDOrdineOLO__c;
		            	a.type='Temp';
		            	insert a;
		            	o.OF_AccountTemporaneo__c=o.AccountId;
	            		o.OF_ContractTemporaneo__c=o.ContractId;
	            		o.AccountId=a.Id;
	            		o.contractId=null;
		            	insert o;
		            	inserito=true;
	            	}
	            	if(x>1){
	            		o.AccountId=o.OF_AccountTemporaneo__c;
	            		o.contractId=o.OF_ContractTemporaneo__c;
	            		o.OF_AccountTemporaneo__c=null;
	            		o.OF_ContractTemporaneo__c=null;
	            		insert o;
		        		inserito=true; 
	            	} 
	            } 
	            catch(exception e){ 
	            	if(!templog){
	            		t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','OF_ManageOrderFromCase_ServiziAttivi','creazioneOrdine',(x+1), e);
	            		templog=true;
	            	}
	            	else{
	            		t.OF_tentativi__c=(x+1);
	            	}
	            }
	            if(inserito==true){
	            	break;
	            }
            }
            if(templog){
	        	insert t;
	        }
        
            if( c.Status == 'Acquisito' && recordTypeName == 'OF_OUTORDER' )
            {
                //richiamo un metodo che crea i BE di Cessazione
                GestioneServiziAttiviCessazione( c , o , 1);
 				//Inserisce il cliente retail
              	insert CreateClienteRetail(  c.Id , o.OF_Asset__c );           
            }
        
        return o.Id;
     //return null;
 }
    public string TipoServ(case c){
      try{ 
        //system.debug('DG_OF_UtilitiesManageOrderFromCase - c.recordtypeid: ' + c.recordtypeid);
        //public String CasePassivoCessRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso - Cessazione
        
             if(  (c.recordtypeId == OF_SA_GE_Utils.RtMap.get('OF_SA_Attivazione')) 
                  || (c.recordtypeId == OF_SA_GE_Utils.RtMap.get('OF_SA_Cessazione')) )
             {
                  system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro attivo');
                  c.OF_Servizio__c = 'Open Stream';
                  return 'Attivo';
             }else if(    (c.recordtypeId == OF_SA_GE_Utils.RtMap.get('EOF_Caso_Attivazione')) 
                  || (c.recordtypeId == OF_SA_GE_Utils.RtMap.get('EOF_Caso_Cessazione')) )
             {
                 system.debug('DG_OF_UtilitiesManageOrderFromCase - Dentro passivo');
                 c.OF_Servizio__c = 'GPON Passiva';
                 return 'Passivo';
             }
             return null;
         }catch( Exception e )
         {
             OF_Utility.logMessage(true,'E','Classe: OF_ManageOrderFromCase',
                                        'Method: TipoServ',
                                        'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());           
              return null;
         }
    }
    
    public Id AggiornoOrdine(case c/*, order o1/*OF_CaseOrderStateModelCS__c CSCaseOrder,*/ 
                               /*Map <string, OF_CodificaProfiloListini__c> mapCodifica*/){
        system.debug('test1_OSCRM 18/10/2017 AggiornoOrdine c:'+c+' c.OF_Order__c:'+c.OF_Order__c);
        Order o1 = [SELECT Id,RecordType.Name,RecordType.Id,OF_Type__c,
                           OF_TipologiaDiServizio__c,EffectiveDate,Status,
                           OF_DataEsito__c,OF_CodiceKO__c,OF_Esito__c,
                           OF_DescrizioneKO__c,OF_IDOrdineOLO__c,OF_IDOrdineEOF__c,
                           OF_IDRisorsa__c,AccountId,OF_IDBuilding__c,OF_Asset__c,
                           OF_SlaPremiumAssurance__c,OF_Apparato__c,
                           OF_EsitoConsegnaApparato__c,OF_ProgettoSpeciale__c,OF_TipologiaApparato__c,
                           OF_PasswordApparato__c,ContractId,OF_CaseID__c,OF_CaseNome__c,
                           OF_IDServizio__c,OF_Profilo__c,OF_ProfiloOpenStream__c,OF_Promozione__c,
                           OF_CodiceProgettoSpeciale__c,OF_ClusterPromozione__c,OF_IdentificativoDelPOP__c,
                           OF_GPONAttestazione__c,OF_Comune__c,OF_Provincia__c,OF_AccountTemporaneo__c
                    FROM Order 
                    WHERE Id =: c.OF_Order__c];
        
        system.debug('test2_OSCRM 18/10/2017 AggiornoOrdine o1:'+o1);

        try{
            if( c.Status == 'Espletato' )
            {
               o1.Status = 'Chiuso';
               o1.OF_Esito__c = 'OK';
               o1.OF_DataEsito__c = system.Today();
            }else if( c.Status == 'Espletato KO')
            {
                o1.Status = 'Chiuso';
                o1.OF_Esito__c = 'KO';
                o1.OF_DataEsito__c = system.Today();
            }else if( c.Status == 'Annullato' )
            {
                o1.Status = 'Chiuso';
                o1.OF_Esito__c = 'KO';
                o1.OF_DataEsito__c = system.Today();
            }else if( c.Status == 'Accettato KO')
            {
                o1.Status = 'Chiuso';
                o1.OF_Esito__c = 'KO'; 
                o1.OF_DataEsito__c = system.Today();
            }else if( c.Status == 'Cessato')
            {
                o1.Status = 'Chiuso';
                o1.OF_Esito__c = 'OK';  
                o1.OF_DataEsito__c = system.Today();               
            }else if( c.Status == 'Cessato OK')
            {
                o1.Status = 'Chiuso';
                o1.OF_Esito__c = 'OK';
                o1.OF_DataEsito__c = system.Today();
            }
            if(c.Status != 'Cessato' && c.Status != 'Cessato OK'){
            
	            //DG aggiunti campi sull'ordine per poterli gestire a livello di asset (non saranno visibili sull'ordine)
	            o1.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c;
	            o1.OF_GPONAttestazione__c = c.EOF_GPON_Attestazione__c;
	            o1.OF_SlaPremiumAssurance__c = c.EOF_SLA_Premium_Assurance__c;
	            o1.OF_Apparato__c = c.EOF_Apparato__c;
	            o1.OF_ProgettoSpeciale__c = c.EOF_Progetto_Speciale__c;
	            o1.OF_TipologiaApparato__c = c.EOF_Tipologia_Apparato__c;
	            o1.OF_PasswordApparato__c = c.EOF_Password_Apparato__c;  
	            /*
	            if( CSCaseOrder.OF_EsitoOrder__c != null)
	                o1.OF_DataEsito__c = system.Today();
	             */
	            //31/05/2017 aggiunti campi da passare all'asset
	            //14/07/2017 modificata logica OF_profilo__c --> viene fatta una codifica presente nel custom setting OF_CodificaProfiloListini__c
	           
	            if(c.OF_SA_Profilo__c != null)
	            {
	                //27/09/2017 Modifica CRM - nel custom setting OF_CodificaProfiloListini__c viene scritto tutto il profilo e non solo le prime due lettere
	                //o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c.substring(0,2)).OF_Profilolistino__c;
	                if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
	                    o1.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
	            }
	            //OF_ProfiloOpenStream__c viene utilizzato per popolare sull'asset il campo OF_ProfiloOpenStream__c preso dal case
	            o1.OF_ProfiloOpenStream__c = c.OF_SA_Profilo__c;
	            o1.OF_Promozione__c = c.OF_SA_Promozione__c ;
	            o1.OF_CodiceProgettoSpeciale__c = c.OF_SA_CODICE_PROGETTO_SPECIALE__c ;
	            o1.OF_ClusterPromozione__c = c.OF_SA_Cluster_Promozione__c;
	            //END DG 31/05/2017
	            
	            //DG 25/05/2017 modificato il campo da cui prendere OF_EsitoConsegnaApparato__c
	            //  non più da EOF_Tipo_di_intervento_aggiuntivo__c ma da OF_Esito_Consegna_Apparato__c
	            o1.OF_EsitoConsegnaApparato__c = c.OF_Esito_Consegna_Apparato__c;
	            //END DG 25/05/2017
	            
	            //DG 01/06/2017 aggiunti i campi descrizione KO e codice KO per i servizi attivi
	            o1.OF_CodiceKO__c = c.OF_SA_Codice_Motivazione__c;
	            o1.OF_DescrizioneKO__c = c.OF_SA_Motivazione__c;
	            //END DG 01/06/2017
	             
	            //DG 23/03/2017 - Come emerso da riunione odierna i campi vanno presi dal case e non dalla network inventory
	            o1.OF_IDBuilding__c = c.EOF_ID_Building_WS__c;
	            o1.OF_IdentificativoDelPOP__c = c.EOF_Identificativo_del_POP__c;
	            o1.OF_Comune__c = c.EOF_Comune_WS__c;
	            o1.OF_Provincia__c = c.EOF_Provincia_WS__c;
	            o1.OF_ParticellaToponomastica__c = c.EOF_Particella_Toponomastica_WS__c;
	            o1.OF_Indirizzo__c = c.EOF_Indirizzo_WS__c;
	            o1.OF_Civico__c = c.EOF_Numero_Civico_WS__c;
	            o1.OF_ScalaPalazzina__c = c.EOF_Scala_Palazzina_WS__c; 
             
            }
            /* 12/07/2017 PO *
            o1.PO_Attenuazione__c = c.PO_Attenuazione__c ;
            o1.PO_LunghezzaOttica__c = c.PO_Lunghezza_Ottica__c;
            o1.PO_PosizioneRilascioCircuitoOSU__c = c.PO_Posizione_Rilascio_Circuito_OSU__c;
            if(c.PO_Data_Attivazione_Ordine__c != null)
            {
                string str = c.PO_Data_Attivazione_Ordine__c + ' 00:00:00';
                o1.PO_DataAttivazioneOrdine__c = datetime.valueOf(str);
            } 
        */
          /**Gestione Servizi Passivi**/
          if( c.Status == 'Espletato' ){
              GestioneServiziAttiviAttivazione( c , o1 );
              o1.OF_Asset__c = idAsset;
              
              //Inserisce il cliente retail
              insert CreateClienteRetail(  c.Id , idAsset );
              boolean inserito=false;
              boolean templog=false;
            Account a = new Account();	
            Templog__c t = new Templog__c();
           	 for(integer x=0; x<50; x++){
	            try{
              		if(x==0){
		        		update o1;
		    			inserito=true;
		        	}
	    			if(x==1){
		            	a.name=o1.OF_IDOrdineOLO__c;
		            	a.type='Temp';
		            	insert a;
		            	o1.OF_AccountTemporaneo__c=o1.AccountId;
		            	o1.OF_ContractTemporaneo__c=o1.contractId;
		            	o1.AccountId=a.Id;
		            	o1.contractId=null;
		            	update o1;
		            	inserito=true;
	            	}
	            	if(x>1){
	            		o1.AccountId=o1.OF_AccountTemporaneo__c;
	            		o1.contractId=o1.OF_ContractTemporaneo__c;
	            		o1.OF_AccountTemporaneo__c=null;
	            		o1.OF_ContractTemporaneo__c=null;
		        		update o1;
		    			inserito=true;
		        	}
	            }
	            catch(exception e){
	            	if(!templog){
	            		t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','OF_ManageOrderFromCase_ServiziAttivi','AggiornoOrdine',(x+1), e);
	            		templog=true;
	            	}
	            	else{
	            		t.OF_tentativi__c=(x+1);
	            	}
	            }
	            if(inserito==true){
	            	break;
	            }
            }
            if(templog){
	        	insert t;
	        }
          return idAsset;
          }
          else if(c.Status == 'Cessato'){
          	GestioneServiziAttiviCessazione( c , o1, 0 );
              
              update o1;
          }
          else{
              update o1;
          }
        /*****************************/
         return null;
       }catch( Exception e )
          {
        OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method: AggiornoOrdine','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
              return null;
        }
    }
    //Metodo che crea il Cliente Retail
    public OF_AssetCases__c CreateClienteRetail( ID CaseId , ID AssetId ){
        try{
            OF_AssetCases__c obj = new OF_AssetCases__c();
            obj.OF_Asset__c = AssetId;
            obj.OF_Caso__c = CaseId;
            
            return obj;
            
        }catch( Exception e )
        {
        	OF_Utility.logMessage(true,'E','Classe: OF_UtilitiesManageOrderFromCase','Method:CreateClienteRetail','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());         
        	return null;
        }
    }
    //Metodo che gestisce l'espletamento di un Caso di Attivazione per i Servizi Attivi
    public void GestioneServiziAttiviAttivazione( case c, order o){
     try{
         /**Strutture dati che servono per gestire il flusso in attivazione**/
         system.debug('CRM 19/10/2017 GestioneServiziPassivi');
         List<Asset> listAsset = new List<Asset>();
         Map<ID,ID> ContractIdFromOrder = new Map<ID,ID>();
         
         Map<ID,Order> mappaIDOrder = new Map<ID,Order>();
         Map<ID,Order> mappaIDOrderCessazione = new Map<ID,Order>();
         /**Strutture dati che servono per gestire il flussoin Cessazione**/
         Map<string,Order> IDRisorsa = new Map<string,Order>();
         List<Asset> AssetOrderCess = new List<Asset>();
         String TipologiaServizio = '';
         String AttivazioneAttivi = ''; //1. UPDATE_OUTORDER
         //2. INSERT_OUTORDER
         
         Map<ID,ID> ContractIdFromOrderCessazioneUpdate = new Map<ID,ID>();
         Set<ID> idAssetOpenStreamCPE = new Set<ID>();
         Map<ID,Asset> idAssetObjAssetOpenStreamCPE = new Map<ID,Asset>();
             
        /**Attivazione**/
        if( o.OF_Type__c == 'INORDER' )
        {
            if( o.ContractId != null )
            {
                /*********** step 1 ***********/
                if( o.OF_TipologiaDiServizio__c == 'Attivo')
                {
                       TipologiaServizio = 'Open Stream';
                       AttivazioneAttivi = 'UPDATE_INORDER';
                       mappaIDOrder.put(o.Id,o);
                 } 
                ContractIdFromOrder.put(o.Id,o.ContractId);
            }
        }
        if( mappaIDOrder != null && mappaIDOrder.size()>0 )
        {
            listAsset = OF_GestioneServiziAttiviPassivi.CreazioneAsset(mappaIDOrder.values() , null , 0 );
            idAsset = listAsset[0].Id;
        }
        /**Associazione Asset - Order**/
           Map<ID,ID> assetOrder = new Map<ID,ID>();
           Map<ID,ID> assetOrderCessMap = new Map<ID,ID>();
           Map<ID,Asset> idAssetObjAsset = new Map<ID,Asset>();
           
           assetOrder = OF_GestioneServizi.AssociazioneOrderAsset( listAsset ,mappaIDOrder.values());
           idAssetObjAsset = OF_GestioneServizi.getIDAssetAssetObj(listAsset);
        /**************************************************/
          if( assetOrder.size()>0 || assetOrderCessMap.size() > 0)
          {
               /*****************COMMENTATO SERVIZI OPEN-STREAM****************/
               /**/
              
               if(TipologiaServizio == 'Open Stream')
               {

                    OF_GestioneServiziAttiviNEW objAtt = new OF_GestioneServiziAttiviNEW();
                    /*
                    if( AttivazioneAttivi == 'UPDATE_INORDER')
                    {
                       
                        
                        Map<ID,Map<ID,PriceBook2>> PriceProductMap = objAtt.getMappaOrder(ContractIdFromOrderCessazioneUpdate,mappaIDOrderCessazione,assetOrderCessMap,idAssetObjAssetOpenStreamCPE,1,AttivazioneAttivi);
                        if( PriceProductMap != null && PriceProductMap.size()>0 )
                        {
                             objAtt.CreazionePriceBookEntry_AttiviCPE( PriceProductMap , assetOrderCessMap , 0,objAtt.MappaMultipleCE,false);
                        }
                    }else
                    {
                    */    
                        
                    Map<ID,Map<ID,PriceBook2>> PriceProductMap = objAtt.getMappaOrder(ContractIdFromOrder,mappaIDOrder,assetOrder,idAssetObjAsset,0,AttivazioneAttivi);
                   
                    if( PriceProductMap != null && PriceProductMap.size()> 0 )
                    {
                        objAtt.CreazionePriceBookEntry_AttiviCPE( PriceProductMap , assetOrder , 0,objAtt.MappaMultipleCE,false);
                    }
                    
                    
                  
              
                 /*******Fine Creazione PriceBookEntry******/
                }
          }
        return;
       }catch(Exception e)
       { 
        OF_Utility.logMessage(true,'E',
             'Classe: OF_GestioneServiziNEW',
             'Method: GestioneServiziPassivi',
             'Exception : ' + e.getTypeName() + ' - ' 
                            + e.getLineNumber() + ' - ' 
                            + e.getStackTraceString() 
                            + ' - ' + e.getMessage()
              );   
         return;
       } 
    }
    //Metodo che gestisce la Cessazione 
    public void GestioneServiziAttiviCessazione(  case c , order ord, Integer tipo ){
        /**Strutture dati**/
        Map<ID,ID> ContractIdFromOrderCessazione = new Map<ID,ID>();
        Map<ID,Order> mappaIDOrder = new Map<ID,Order>();
        Map<string,Order> IDRisorsa = new Map<string,Order>();
        List<Asset> AssetOrderCess = new List<Asset>();
        
        String TipologiaServizio = '';
        String CessazioneAttivi = ''; //1. UPDATE_OUTORDER
                                    //2. INSERT_OUTORDER
        /**Fine Strutture dati**/
    
		//INSERIMENTO ORDINE DI CESSAZIONE.
        //Si devono eseguire le seguenti operazioni
        //1.Cessazione di tutti i BE sotto l'asset legato a 
        //  quell'ordine di Cessazione( riporta un IDRisorsa che individua l'asset corrispondente)
        //2.Creazione BE di Cessazione
        if( tipo == 1 ){    
		    mappaIDOrder.put(ord.Id,ord);
		    if( ord.Status == 'Aperto'){
	            TipologiaServizio = 'Open Stream';
	            CessazioneAttivi = 'INSERT_OUTORDER';
		        IDRisorsa.put(ord.OF_IDRisorsa__c,ord);  
			    /***CessazioneBE***/
				AssetOrderCess = [SELECT id, status, OF_Trigger__c,OF_Contract__c,OF_OrdineID__c,EOF_ID_Risorsa__c 
			                            FROM asset 
			                            WHERE EOF_ID_Risorsa__c IN : IDRisorsa.keyset()];		      
			    if(AssetOrderCess.size() > 0 )
			    {
			        OF_GestioneServiziAttiviPassivi.CessazioneBE(AssetOrderCess,IDRisorsa);
			    }
			    //chiamare in cessato cessazione asset e CE
			    /*******************/
			       
			    /***CreazioneBE di Cessazione***/
			    Map<ID,ID> assetOrderCessazione = new Map<ID,ID>();
			    for( Asset ass : AssetOrderCess){
			         String str = ass.OF_OrdineID__c;
			         Id i = Id.valueOf(str);
			         ContractIdFromOrderCessazione.put(i,ass.OF_Contract__c);
			         assetOrderCessazione.put(i,ass.Id);
			    }
			      
			    Map<ID,Asset> idAssetObjAsset = new Map<ID,Asset>();
			    idAssetObjAsset = OF_GestioneServizi.getIDAssetAssetObj(AssetOrderCess);
			      
			    if( ContractIdFromOrderCessazione != null && ContractIdFromOrderCessazione.size() > 0 ){
			        if( TipologiaServizio == 'Open Stream' ){
			            OF_GestioneServiziAttiviNEW objAtt = new OF_GestioneServiziAttiviNEW();
			            
			            Map<ID,Map<ID,PriceBook2>> PriceProductMap = objAtt.getMappaOrder(ContractIdFromOrderCessazione,mappaIDOrder,assetOrderCessazione,idAssetObjAsset,1,CessazioneAttivi);
			            /*
			            if( PriceProductMap != null && PriceProductMap.size()> 0 )
			            {
			                objAtt.CreazionePriceBookEntry_AttiviCPE( PriceProductMap , assetOrder , 0,objAtt.MappaMultipleCE,false);
			            }*/
			           
		          }
		       }
	    	}
		}
	//AGGIORNAMENTO ORDINE DI CESSAZIONE
    //All'aggiornamento(espletamento) di un Ordine di Cessazione si devono eseguire le seguenti operazioni:
    //1.Cessazione Asset
    //2.Cessazione CE
    if( tipo == 0 ){
    	mappaIDOrder.put(ord.Id,ord);
	    system.debug('2106_ord.Status:'+ord.Status+'_ord.OF_Type__c:'+ord.OF_Type__c );
	    if(ord.Status == 'Chiuso' && ord.OF_Esito__c == 'OK' && ord.OF_Type__c == 'OUTORDER'){
	        if( ord.OF_TipologiaDiServizio__c == 'Attivo') 
	         {
	            TipologiaServizio = 'Open Stream';
	            CessazioneAttivi = 'INSERT_OUTORDER';
	         }
	         IDRisorsa.put(ord.OF_IDRisorsa__c,ord);  
	    }
	    //system.debug('DG - IDRisorsa: ' + IDRisorsa);
	    /***CessazioneBE***/
	    if(IDRisorsa.size() > 0 ){
	    	
	          AssetOrderCess = [SELECT id, status, OF_Trigger__c,OF_Contract__c,OF_OrdineID__c,EOF_ID_Risorsa__c 
	                            FROM asset 
	                            WHERE EOF_ID_Risorsa__c IN : IDRisorsa.keyset()];
	    }
	      
	    if(AssetOrderCess.size() > 0 )
	    {
	    	OF_GestioneServiziAttiviPassivi.CessazioneAsset(AssetOrderCess,IDRisorsa);
            OF_GestioneServiziAttiviPassivi.CessazioneCE( AssetOrderCess,IDRisorsa);
	    }
    }
   
    return;
    }
    

    
    

}