/** Autore:             CRM xx_xx_2017
    
    Descrizione Classe: In questa Classe vengono predisposti dei metodi che servono per l'istanziazione di
                        un Asset o per la Cessazione.
**/

public class OF_IstanziazioneAsset {
  
    
public static Map<String,Id> mappaRT = OF_IstanziazioneAsset.mapRT();  


public class PO_AssetFields
{
   public DateTime DataAttivazinePortalino{set;get;}
   public String Attenuazione{set;get;}
   public Integer LunghezzaOttica{set;get;}
   public String PosizioneRilascioCircuitoOSU{set;get;}
   //13/09/2017 Modifica
   public Boolean Rinnovabile{set;get;}
   //13/09/2017 END Modifica*/
   
    
   //Costruttore
   public PO_AssetFields(DateTime DataAttivazione , String Attenuazione , Integer Lungh ,String PosRilascioCirc, boolean Rinnovab )
   {
       this.DataAttivazinePortalino= DataAttivazione;
       this.Attenuazione = Attenuazione;
       this.LunghezzaOttica = Lungh ;
       this.PosizioneRilascioCircuitoOSU = PosRilascioCirc;
       //13/09/2017 Modifica
       this.Rinnovabile = Rinnovab;
       //13/09/2017 END Modifica*/
   }
   
    
}
            
/**Autore:              CRM xx_xx_2017
       
       DescrizioneMetodo:
          1.Dati In Input: Insieme di Dati primitivi,String,ID,DateTime
          2.Dati In Output: Asset istanziato
          3.Descrizione LogicaMetodo: Si istanzia un Asset,poi si riempiono tutti i campi di questo Asset.
                                      Nel caso della DataAttivazione,viene fatto logica sul Cruscotto(dataSwitch)
                                      che definisce se OM è attivo oppure no.
                                      
          4.Descrizione Funzionale Metodo: Questo metodo è stato pensato per Istanziare Uniformemente un Asset
                                           fornendo dei valori opportuni in Ingresso
                  
     **/            
public static Asset IstanziazioneAsset(ID Recordtype,String Name,ID AccountID,ID ContractID,ID OrdineID,String IDBuilding,
                                       String IdentificativoPOP,String GPONAttestazione,String Comune,/*ID OrderId,*/
                                       String provincia,String ParticellaToponomastica,String indirizzo,String civico,
                                       String ScalaPalazzina,String ServizioRichiesto,String IDRisorsa,
                                       String IDSplitterSecondario,String PosizioneSplitterSecondario,
                                       /*DateTime dataSwitch,*/ String ProgettoSpeciale, String idCaseAttivazione ,
                                       String Profilo,String Promozione,String PromozioneCluster,String TipologiaApparato,
                                       String CodiceProgettoSpeciale , String idServizio , ID CasoIDToExtra ,/* String ServRichiesto,*/
                                       String tipoProcesso ,DateTime DataAttivazioneExtra , String SlaPremium,
                                       OF_IstanziazioneAsset.PO_AssetFields param/*DateTime DataAttivazinePortalino,
                                       String Attenuazione,Number LunghezzaOttica ,String PosizioneRilascioCircuitoOSU */)
   {
        try{
                    
                     Asset ass = new Asset();
                     ass.RecordtypeId = Recordtype;
                     ass.Name = Name;
                     ass.AccountId = AccountID;
                     ass.OF_Contract__c = ContractID;
                     ass.OF_OrdineID__c = OrdineID;
                     ass.Status = 'Attivo';
                     ass.OF_ID_Building__c = IDBuilding;
                     ass.OF_Identificativo_del_POP__c = IdentificativoPOP;
                     ass.OF_GPON_Attestazione__c = GPONAttestazione;
                     ass.OF_Comune__c = Comune;
                     
                     //passivo
                     if(OM_GW_GE_Utils.slSFOLO!=null){
                         ass.OF_DataAttivazione2__c  = OM_GW_GE_Utils.slSFOLO.EOF_Data_espletamento_ordine__c;
                     }
                     //attivo
                     if(OF_SA_GE_Utils.slSFOLO!=null){
                         ass.OF_DataAttivazione2__c  = OF_SA_GE_Utils.slSFOLO.EOF_Data_espletamento_ordine__c;
                     }
                     //FINE
                     //ass.OF_DataAttivazione__c = Date.today();
                     //ass.OF_Data__c = Date.today();
                     ass.OF_Data__c = DataAttivazioneExtra;
                     ass.OF_Provincia__c = provincia;
                     ass.OF_Particella_Toponomastica__c = ParticellaToponomastica;
                     ass.OF_Indirizzo__c = indirizzo;
                     ass.OF_Civico__c = civico;
                     
                     ass.OF_Scala_Palazzina__c = ScalaPalazzina;
                     ass.OF_ServizioRichiesto__c = ServizioRichiesto;
                     ass.EOF_ID_Risorsa__c = IDRisorsa;
                     ass.EOF_ID_Splitter_Secondario__c = IDSplitterSecondario;
                     ass.EOF_Posizione_Splitter_Secondario__c = PosizioneSplitterSecondario;
                     //DG 22/05/2017 aggiunto campo
                     ass.OF_ProgettoSpeciale__c = ProgettoSpeciale;
                     ass.OF_IDCaseAttivazione__c = idCaseAttivazione;
                     
                     /**CAMPI LOGICA LISTINI**/
                    ass.OF_ProfiloOpenStream__c = Profilo;
                    ass.OF_Promozione__c = Promozione;
                    ass.OF_ClusterPromozione__c = PromozioneCluster;
                    ass.OF_TipologiaApparato__c = TipologiaApparato;
                    ass.OF_CodiceProgettoSpeciale__c = CodiceProgettoSpeciale;
                    
                    ass.OF_IDServizio__c = idServizio;
                    ass.OF_Case__c = CasoIDToExtra;
                    //03/10/2017 Modifica CRM - tolto il campo doppione OF_ServizioRichiesto__c
                    //ass.OF_ServizioRichiesto__c = ServRichiesto;
                    
                    ass.OF_TipoDiProcesso__c = tipoProcesso;
                    ass.EOF_SLA_Premium_Assurance__c=SlaPremium;
                    
                     /*--------Portalino---------*/
                     if( param != null )
                     {
                     ass.OF_DataAttivazione2__c = param.DataAttivazinePortalino;
                     ass.PO_Attenuazione__c = param.Attenuazione;
                     ass.PO_LunghezzaOttica__c = param.LunghezzaOttica;
                     ass.PO_PosizioneRilascioCircuitoOSU__c = param.PosizioneRilascioCircuitoOSU;
                     //13/09/2017 Modifica
                     ass.OF_Rinnovabile__c = param.Rinnovabile;
                     //13/09/2017 END Modifica*/
                        if( mappaRT.get('Fiber_Lease') == Recordtype )
                        {
                            ass.OF_DataScadenza__c = ass.OF_DataAttivazione2__c.date().addYears( 30 );
                        }
                        if( mappaRT.get('P2P') == Recordtype )
                        {
                            ass.OF_DataScadenza__c = ass.OF_DataAttivazione2__c.date().addYears( 15 );
                        }
                        
                     }
                     /*--------------------------*/
                    
                    return ass;  
            }catch(Exception e){
                     OF_Utility.logMessage(true,'E',
                     'Classe: OF_InstanziazioneAsset',
                     'Method: IstanziazioneAsset',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );        
                return null;
            }
  } 
       
     /**Autore:              CRM xx_xx_2017
       
     DescrizioneMetodo:
          1.Dati In Input: listaOrdini
          2.Dati In Output: Lista di Asset
          3.Descrizione LogicaMetodo: Si itera su tutti gli Ordini contenuti nella lista,e si istanzia per ogni Order
                                      un Asset Attivo
          4.Descrizione Funzionale Metodo: Questo metodo è stato pensato per Istanziare degli Asset sotto L'Ordine 
                                           Chiuso OK per i Servizi Attivis
                  
    **/
    public static List<Asset> CreazioneAssetFromProcess(List<Order> listaOrdini,
                                                        ID RecordType_AssetPassivi,
                                                        ID RecordType_AssetAttivi,
                                                        ID RecordType_AssetPortalino,
                                                        ID RecordType_AssetFiberLink,
                                                        ID RecordType_AssetFiberLease)
    {
        try{
              //20/09/2017 Modifica portalino campo rinnovabile sull'asset
              map<id, contract> MapOrderContract = OrderContract(listaOrdini);
              //END 20/09/2017
              
              System.debug('Sono nel metodo CreazioneAssetFromProcess');

              List<Asset> listAsset = new List<Asset>();
              
              System.debug('*++++SIZE listaOrdini '+listaOrdini.size());

              if( listaOrdini.size() > 0 )
              {
                       for(Order o : listaOrdini)
                       {
                        /**Chiamo il metodo IstanziazioneAsset/classeOF_IstanziazioneAsset**/
                        
                        /**OSCRM 19_05_2017,Switch tra 'Servizi Attivi' e 'Servizi Passivi'.
                           Si controlla il valore del campo OF_TipologiaDiServizio__c nell'Ordine
                           
                           1. Se OF_TipologiaDiServizio__c = 'Attivo' => si passa RecordType_AssetAttivo
                           2. Se OF_TipologiaDiServizio__c = 'Passivo' => si passa RecordType_AssetPassivo
                           3. Se la checkbox PO_IsFromOpportunity__c = true 
                              and
                              Se la checkbox isFiberLink = true 
                              
                              => si passa RecordType_AssetFiberLink
 s
                              Se la checkbox isFiberLink = false
                              => si passa RecordType_AssetPortalino
                           **/
                           
                           //DG 13/06/2017 - aggiunto il campo servizio da popolare sull'asset
                           
                           System.debug('***OF_TipologiaDiServizio__c: '+o.OF_TipologiaDiServizio__c);

                           ID RecordTypeId;
                           string servizio;
                           //13/09/2017 Modifica
                           boolean Rinnovabile = false;
                           //13/09/2017 END Modifica*/
                           OF_IstanziazioneAsset.PO_AssetFields obj=null;
                           String SlaPremium;
                           if(String.isNotBlank(o.OF_SlaPremiumAssurance__c)){
                           		SlaPremium=o.OF_SlaPremiumAssurance__c;
                           }
                           else{
                           		SlaPremium='N';
                           }
                           if( o.OF_TipologiaDiServizio__c == 'Attivo')
                           {
                               RecordTypeId = RecordType_AssetAttivi;
                               servizio = 'Open Stream';
                           }
                           if( o.OF_TipologiaDiServizio__c == 'Passivo')
                           {
                               RecordTypeId = RecordType_AssetPassivi;
                               servizio = 'GPON Passiva';
                           }
                           
                           System.debug('----PO_IsFromOpportunity__c: '+o.PO_IsFromOpportunity__c);

                           //Creazione Asset da Portalino
                           if( o.PO_IsFromOpportunity__c == true )
                           {
                               if( o.isFiberLink__c == true)
                               {
                                   RecordTypeId = RecordType_AssetFiberLink;
                                   servizio = 'Fiber Link';
                               }else if(o.isFiberLease__c == true){
                                   RecordTypeId = RecordType_AssetFiberLease;
                                   servizio = 'Fiber Lease';
                               }else{
                                   RecordTypeId = RecordType_AssetPortalino;
                                   servizio = 'P2P';
                               }
                               //13/09/2017 Modifica
                               if(MapOrderContract.get(o.id) != null)
                               {
                                   Rinnovabile = MapOrderContract.get(o.id).OF_Rinnovabile__c;
                               }
                               //13/09/2017 END Modifica*/
                               
                               obj = new OF_IstanziazioneAsset.PO_AssetFields(o.PO_DataAttivazioneOrdine__c,
                                                                              o.PO_Attenuazione__c , 
                                                                              Integer.valueOf(o.PO_LunghezzaOttica__c),
                                                                              o.PO_PosizioneRilascioCircuitoOSU__c/*13/09/2017 Modifica*/,
                                                                              Rinnovabile
                                                                              );
                                                                               
                                                                               /*
                                                                               o.PO_DataEspletamentoOrdine__c ,
                                                                               o.PO_Attenuazione__c, 
                                                                               o.PO_LunghezzaOttica__c,
                                                                               o.PO_PosizioneRilascioCircuitoOSU__c
                                                                               );
                                                                               */
                           }
                           
                          System.debug('$$$$_RecordTypeId :'+RecordTypeId);

                          Asset ass = OF_IstanziazioneAsset.IstanziazioneAsset
                                   (
                                   RecordTypeId,
                                   o.OF_IDRisorsa__c,
                                   o.AccountId,
                                   o.ContractId,
                                   o.Id,
                                   o.OF_IDBuilding__c,
                                   o.OF_IdentificativoDelPOP__c,
                                   o.OF_GPONAttestazione__c,
                                   o.OF_Comune__c,/*o.Id,*/
                                   o.OF_Provincia__c,
                                   o.OF_ParticellaToponomastica__c,
                                   o.OF_Indirizzo__c,
                                   o.OF_Civico__c,
                                   o.OF_ScalaPalazzina__c,
                                   servizio,
                                   o.OF_IDRisorsa__c,
                                   o.OF_IDSplitterSecondario__c,
                                   o.OF_PosizioneSplitterSecondario__c,/*
                                   dataswitch,*/
                                   o.OF_ProgettoSpeciale__c,
                                   o.OF_IDCaso__c,
                                   //14/07/2017 utilizzato il nuovo campo.
                                   //OF_ProfiloOpenStream__c è il valore non decodificato
                                   //OF_Profilo__c è il valore decodificato in base al custom setting OF_CodificaProfiloListini__c
                                   o.OF_ProfiloOpenStream__c,
                                   //o.OF_Profilo__c,
                                   o.OF_Promozione__c,
                                   o.OF_ClusterPromozione__c,
                                   o.OF_TipologiaApparato__c,
                                   o.OF_CodiceProgettoSpeciale__c,
                                   o.OF_IDServizio__c,
                                   null,
                                   null,
                                   null,
                                   SlaPremium,
                                   obj
                                   
                                   );
                          listAsset.add(ass);
                         }
               }
               
               System.debug('@@@-ListAsset size: '+listAsset.size());
               
               if( listAsset.size() > 0 ){
               	 boolean inserito=false;
               	 boolean templog=false;
            	Templog__c t = new Templog__c();
               	 for(integer x=0; x<50; x++){
		            try{
		            	insert listAsset;
		            	inserito=true;
		            }
		            catch(exception e){
		            	if(!templog){
		            		t=OF_Utility.logMessageNew2(x+'_'+listAsset[0].recordtypeId,'E','OF_IstanziazioneAsset','CreazioneAssetFromProcess',(x+1), e);
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
               }

               return listAsset;
               /*
               set<id> assid = new set<id>();
               for( Asset ass : listAsset) assid.add(ass.Id);
               
               
               
               
               return [select RecordtypeId,Name,AccountId,OF_Contract__c,OF_OrdineID__c,
                              Status,OF_ID_Building__c,OF_Identificativo_del_POP__c,OF_GPON_Attestazione__c,
                              OF_Comune__c,OF_DataAttivazione__c,OF_Data__c,OF_Provincia__c,
                              OF_Particella_Toponomastica__c,OF_Indirizzo__c,OF_Civico__c,
                              OF_Scala_Palazzina__c,OF_ServizioRichiesto__c,EOF_ID_Risorsa__c,
                              EOF_ID_Splitter_Secondario__c,EOF_Posizione_Splitter_Secondario__c,
                              OF_ProgettoSpeciale__c,OF_IDCaseAttivazione__c,OF_ProfiloOpenStream__c,
                              OF_Promozione__c,OF_ClusterPromozione__c,OF_TipologiaApparato__c,OF_CodiceProgettoSpeciale__c,
                              OF_IDServizio__c,
                              
                              (select id,OF_CommercialElementName__c,OF_Asset__c, OF_Stato__c, recordtype.name, 
                                      OF_Nome_Servizio__c, OF_ESITOSERVIZIO__c, OF_EsitoConsegnaApparato__c, 
                                      OF_Profilo__c, OF_Promozione__c, OF_CodiceProgettoSpeciale__c, OF_ClusterPromozione__c, 
                                      OF_TipologiaApparato__c 
                               from Commercial_element_istanziati3__r )
                                  
                        from Asset 
                        where id in : assid];
             */  
           }catch(Exception e)
           {
           
            OF_Utility.logMessage(true,'E',
                     'Classe: OF_InstanziazioneAsset',
                     'Method: CreazioneAssetFromProcess',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                return null;
           }
   
        
    }
    
    /**Autore:              CRM xx_xx_2017
       
     DescrizioneMetodo:
          1.Dati In Input: lista di liste di Stringhe
          2.Dati In Output: Lista di Asset
          3.Descrizione LogicaMetodo: Per ogni riga della lista,si itera internamente sulle Stringhe contenute,creando 
                                      degli Asset che prendono le informazioni dal CSV
          4.Descrizione Funzionale Metodo: Questo metodo è stato pensato per Istanziare degli Asset in fase di caricamento
                                           CSV
    **/
    /* Alessandro commento 1
    public static List<Asset> CreazioneAssetFromCSV(List<List<String>> listCSVAsset,DateTime dataswitch,List<OF_Configurazioni__c> listCustomSett,ID RecordTypeID , Integer TipologiaExtra)
    {
        OF_IstanziazioneAsset obj = new OF_IstanziazioneAsset();
        return obj.CreazioneAssetFromCSV_ServizioExtra( listCSVAsset,listCustomSett,RecordTypeID , TipologiaExtra );
    }
    Fine */
    
    /**Metodi per ottimizzare**/
    
    /**Metodo 1 : Questo metodo associa all'Asset Padre l'asset Extra che si sta caricando da CSV.
                  Viene chiamato nei due metodi:
                  1.CreazioneAssetFromCSV_Intervento_a_Vuoto
                  2.CreazioneAssetFromCSV_Verticale
    
    **/
    public void AssociazioneAssetPadreAssetFigli(  Map<ID,List<Asset>> IDAssetFatherAsset , Asset assetFiglio , ID assetPadreID )
    {
        if( IDAssetFatherAsset.containsKey(assetPadreID))
        {
                                  
             List<Asset> listAssets = new List<Asset>();
             listAssets = IDAssetFatherAsset.get(assetPadreID);
             listAssets.add(assetFiglio);
             IDAssetFatherAsset.put(assetPadreID,listAssets);
                                  
         }else{
                        
              List<Asset> listAssets = new List<Asset>();
              listAssets.add(assetFiglio);
              IDAssetFatherAsset.put(assetPadreID,listAssets );
                        
          }
    } 
    
    //31/07/2017 DG commentato per deploy
    /**Creazione Asset From CSV**/
    /**********ottimizzato******/
   /*Il seguente metodo effettua le seguenti Operazioni
  1.Crea un Servizio Extra ( Asset con Tipologia "Intervento a Vuoto" 
                                 o con Tipologia "Verticale" )
                                
  2.
    2a.Associa Il Servizio "Intervento a vuoto" al Caso indicato nel.CSV ed
       anche successivamente all'asset padre(l'asset esistentea sistema e legato al caso)
    
    2b.Associa Il Servizio "Verticale" all'asset con idRisorsa indicato nel file
    
  3.Crea i BE/CE per ogni Servizio Extra che si sta caricando(seguendo le logiche dei Listini)
  */
  
  /*
     if( TipologiaServizio == 0) Intervento a vuoto
     if( TipologiaServizio ==1 ) Verticale
  */
   /* Alessandro commento 2
   public  List<Asset> CreazioneAssetFromCSV_ServizioExtra( List<List<String>> listCSVAsset,
                                                            List<OF_Configurazioni__c> listCustomSett,
                                                            ID RecordTypeID , Integer TipologiaServizio)
   {
        try{
            
            //PARAM1(Parametri in Comune  VERTICALE - INTERVENTO A VUOTO
             Integer NomeServizioExtra = (Integer)listCustomSett[0].OF_ServizioExtraName__c;
             OF_UtilityServiziImport obj = new OF_UtilityServiziImport();
             List<Asset> listAsset = new List<Asset>();
             Map<ID,List<Asset>> IDAssetFatherAsset = new Map<ID,List<Asset>>();
             
             Map<Id,Map<Id,PriceBook2>> mappaListiniPriceBookEntry = new Map<Id,Map<Id,PriceBook2>>();
             Map<Id,Set<Id>> mappaContrIDListini = new Map<Id,Set<Id>>();
             Set<ID> totalListini = new Set<ID>();
             Set<ID> ContractId = new Set<ID>();

             //PARAM2(Verticale)
             Set<ID> IdRisorsa = new Set<ID>();
             Map<String,Asset> mappaAsset = new Map<String,Asset>();
             Map<ID,Recordtype> mpR = OF_UtilityServiziImport.getRecordTypeMap();
             //Struttura Map<Colonna_Operatore,Asset> perchè l'asset non è ancora stato inserito a sistema.
             //Poi si costruisce un altra struttura che tiene traccia tra Map<IDAsset,Colonna_Operatore>
             Map<String,List<Asset>> mp1 = new Map<String,List<Asset>>();
             Map<id,String> mp2 = new Map<id,String>();
             
             //PARAM3(Intervento a vuoto)
             Map<ID,Asset> IDCaseAsset = new Map<ID,Asset>();
             Set<ID> CaseId = new Set<ID>();
             Map<ID,Case> mappaCase = new Map<ID,Case>();
             Map<id,Asset> mapidAsset = new Map<id,Asset>();
             String tipoProcess = '';
             
             //INTERVENTO A VUOTO
             if( TipologiaServizio == 0)
             {
                 CaseId = OF_UtilityServiziImport.getCasesetID(listCSVAsset);
                 mappaCase = OF_UtilityServiziImport.getCaseList(CaseId);
                 ContractId = OF_UtilityServiziImport.getContractID( mappaCase.values() ); 
             }
             
             //VERTICALE
             if(TipologiaServizio == 1 )
             {
                 IdRisorsa = OF_UtilityServiziImport.getIDRisorsasetID(listCSVAsset);
                 mappaAsset = OF_UtilityServiziImport.getIDRisorsaList( idRisorsa );
                 ContractId = OF_UtilityServiziImport.getContractID_verticali( mappaAsset.values() );
             }
             
             //OPERAZIONI IN COMUNE
             mappaContrIDListini = OF_UtilityServiziImport.getContractListini(ContractId);
             totalListini = OF_UtilityServiziImport.getTotalListini(mappaContrIDListini);
             system.debug('OSCRM totalListini:'+totalListini);
             mappaListiniPriceBookEntry = obj.getMappaListinoProdPriceBook(totalListini);
            
            //--------------------INTERVENTO A VUOTO
            if( TipologiaServizio == 0 ) ProcessCSV_Intervento_a_Vuoto( listCSVAsset , mappaCase , obj , tipoProcess , RecordTypeID , NomeServizioExtra ,
                                                                        listCustomSett , IDAssetFatherAsset , listAsset );
            //----------------------VERTICALE
            if( TipologiaServizio == 1 ) ProcessCSV_Verticale( listCSVAsset , mappaAsset , obj , RecordTypeID , mpR , NomeServizioExtra ,
                                                               listCustomSett , IDAssetFatherAsset , listAsset ,mp1);
            
            
            /----------------------/Creazione CE 
            obj.createCEExtra( listAsset );
            
            //--------------------Associazione ASSET FIGLIO - ASSET PADRE 
            OF_UtilityServiziImport.setChildrenAssetExtra(IDAssetFatherAsset);
            
            //----------------------CREAZIONE STRUTTURA ASSET - PRICEBOOKENTRY
            //Creazione mappa idAsset - Set<ID> listini
                Map<ID,Set<ID>> assetListini = OF_UtilityServiziImport.getAssetListini(listAsset,mappaContrIDListini);
                system.debug('OSCRM assetListini : '+assetListini );
                //Creazione mappa IdAsset - PriceBookEntry
                Map<ID,Map<ID,PriceBook2>> assetPriceBookEntry = OF_UtilityServiziImport.getAssetPriceBookEntry( assetListini , mappaListiniPriceBookEntry );
                system.debug('OSCRM assetPriceBookEntry:'+assetPriceBookEntry);
            
            //-----------------CREAZIONE PRICEBOOKENTRY INTERVENTO A VUOTO
            if( TipologiaServizio == 0 )
            {
               for( Asset ass : listAsset )
               {
                 mapidAsset.put( ass.Id , ass );
               }
              obj.createPriceBookEntry_Extra( assetPriceBookEntry , mapidAsset , null , 0 );
            }
            
            //------------------------CREAZIONE PRICEBOOKENTRY VERTICALE
            if( TipologiaServizio == 1 )
            {
                for( String str : mp1.keyset())
                {
                    List<Asset> listaAsset = mp1.get(str);
                    
                    for( Asset ass : listaAsset)
                    {
                         mp2.put( ass.id,str);
                    }           
                }
                
                for( Asset ass : listAsset )
                {
                 mapidAsset.put( ass.Id , ass );
                }
            //------------------------CREAZIONE PRICEBOOKENTRY
            obj.createPriceBookEntry_Extra( assetPriceBookEntry , mapidAsset , mp2 , 1 );
            
            }
            
            return listAsset;
            
           }catch(Exception e)
           {
            system.debug('OSCRM ERRORE:'+e);
                        
            OF_Utility.logMessage(true,'E',
                     'Classe: OF_InstanziazioneAsset',
                     'Method: CreazioneAssetFromCSV_Intervento_a_Vuoto',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                return null;
           }
  }
  fine */
  /**************METODO 1******/
  /*   Alessandro commento 3
  public void ProcessCSV_Intervento_a_Vuoto( 
                                             List<List<String>> listCSVAsset ,  Map<ID,Case> mappaCase, 
                                             OF_UtilityServiziImport obj , String tipoProcess , ID  RecordTypeID , 
                                             Integer NomeServizioExtra , List<OF_Configurazioni__c> listCustomSett , 
                                             Map<ID,List<Asset>> IDAssetFatherAsset , List<Asset> listAsset
                                            )
  {
     for( Integer index = 0 ; index < listCSVAsset.size() ; index++)
     {
           List<String> StringAsset = listCSVAsset.get(index);
           system.debug('OSCRM StringAsset : '+StringAsset);
           //Chiamo il metodo IstanziazioneAsset/classeOF_IstanziazioneAsset
           if( mappaCase!=null && mappaCase.size()>0)
           {
               if( !String.isBlank( StringAsset[0] ) )
               {
                     Case c = mappaCase.get( Id.valueOf( StringAsset[0] ) );
                     if( StringAsset[2] == 'Assurance')tipoProcess = 'Assurance';
                     if( StringAsset[2] == 'Provisioning')tipoProcess = 'Provisioning';
                    
                     DateTime dataAttivazione = obj.StringToDateTime( StringAsset[1]);
                     if(  c!=null )
                     {
                      Asset ass = OF_IstanziazioneAsset.IstanziazioneAsset(
                                 RecordTypeID,
                                 'Extra'+NomeServizioExtra,
                                  c.EOF_Account_OLO__c,
                                  c.OF_IDContratto__c,
                                  null,
                                  c.EOF_ID_Building_WS__c,
                                  c.EOF_Identificativo_del_POP__c,
                                  c.EOF_GPON_Attestazione__c,
                                  c.EOF_Comune_WS__c,
                                  c.EOF_Provincia_WS__c,
                                  c.EOF_Particella_Toponomastica_WS__c,
                                  c.EOF_Indirizzo_WS__c,
                                  c.EOF_Numero_Civico_WS__c,
                                  c.EOF_Scala_Palazzina_WS__c,
                                  c.Asset.OF_ServizioRichiesto__c,
                                  c.EOF_Id_Risorsa__c,
                                  '','','','','','','','','','',c.Id,
                                  //c.OF_Servizio__c,
                                  tipoProcess,
                                  dataAttivazione,
                                  null
                                   );
                                  
                                  listAsset.add(ass);
                                 
                                  NomeServizioExtra++;
                                  
                                  if( c.AssetID != NULL){
                                  AssociazioneAssetPadreAssetFigli( IDAssetFatherAsset , ass , c.AssetID );
                                  system.debug('OSCRM 30_06 OF_IstanziazioneAsset.CreazioneAssetFromCSV_Intervento_a_Vuoto : IDAssetFatherAsset(BEFORE INSERT):'+IDAssetFatherAsset );
                                   
                                  }
                                  
                            }else{
                                //Creazione Scarto
                            }
                         
                         }else{
                            //Creazione Scarto
                         }
                    }
                }
               listCustomSett[0].OF_ServizioExtraName__c = NomeServizioExtra;
               update listCustomSett[0];
               
               system.debug('OSCRM OF_IstanziazioneAsset.CreazioneAssetFromCSV__listAsset:'+listAsset);
               if( listAsset.size() > 0 ) insert listAsset; 
 
 }
 Fine   */
  /*************METODO2********/
  /* /* Alessandro commento 4
  public void ProcessCSV_Verticale(          List<List<String>> listCSVAsset ,  Map<String,Asset> mappaAsset, 
                                             OF_UtilityServiziImport obj ,// String tipoProcess  
                                             ID  RecordTypeID , Map<ID,Recordtype> mpR, 
                                             Integer NomeServizioExtra , List<OF_Configurazioni__c> listCustomSett , 
                                             Map<ID,List<Asset>> IDAssetFatherAsset , List<Asset> listAsset ,              
                                             Map<String,List<Asset>> mp1

                                   )
  {
        system.debug('OSCRM OF_IstanziazioneAsset.CreazioneAssetFromCSV_Verticale : listCSVAsset:'+ listCSVAsset );
        for( Integer index = 0 ; index < listCSVAsset.size() ; index++)
         {
                   List<String> StringAsset = listCSVAsset.get(index);
                   system.debug('OSCRM StringAsset : '+StringAsset);
                   //Chiamo il metodo IstanziazioneAsset/classeOF_IstanziazioneAsset              
                       
                  if( mappaAsset!=null && mappaAsset.size()>0)
                   {
                       if( !String.isBlank( StringAsset[0] ) )
                       {
                          Asset ass = mappaAsset.get( StringAsset[0] );
                          
                          system.debug('OSCRM OF_IstanziazioneAsset.CreazioneAssetFromCSV_Verticale ass:'+ ass );
                          DateTime dataAttivazione = obj.StringToDateTime( StringAsset[1]);
                          
                          String recordtypeName = mpR.get(ass.RecordtypeId).Name;
                          system.debug('OSCRM OF_IstanziazioneAsset.CreazioneAssetFromCSV_Verticale recordtypeName:'+ recordtypeName );
                          if(  ass != null )
                           {
                           
                           Asset asse = OF_IstanziazioneAsset.IstanziazioneAsset(
                                 RecordTypeID,
                                 'Extra'+NomeServizioExtra,
                                  ass.AccountId,
                                  ass.OF_Contract__c,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  StringAsset[2],
                                  ass.OF_ServizioRichiesto__c,
                                  ass.EOF_ID_Risorsa__c,
                                  '','','','','','','','','','',null,
                                  //recordtypeName,
                                  //tipoProcess
                                  null,
                                  dataAttivazione,
                                  null
                                   );
                              
                                 String key = StringAsset[3];
                                 if( mp1.containsKey( key ))
                                 {
                                       List<Asset> lass = new List<Asset>();
                                       lass = mp1.get(key);
                                       lass.add(asse);
                                       mp1.put(key,lass);
                             
                                 }else{
                                       List<Asset> lass = new List<Asset>();
                                       lass.add(asse);
                                       mp1.put(key,lass );
                        
                                 }
                                  system.debug('OSCRM OF_IstanziazioneAsset.CreazioneAssetFromCSV_Verticale : asse : '+asse );
                                  listAsset.add(asse);
                                  NomeServizioExtra++;
                                  
                                  //AssetPadre - n Asset Extra
                                  AssociazioneAssetPadreAssetFigli( IDAssetFatherAsset , asse , ass.Id );
                                  system.debug('OSCRM 30_06 OF_IstanziazioneAsset.CreazioneAssetFromCSV_Verticale : IDAssetFatherAsset(BEFORE INSERT):'+IDAssetFatherAsset );
                          }
                    }
                }
          }
           
           system.debug('OSCRM 05_07 OF_Istanziazione.CreazioneAssetFromCSV mp1 : '+mp1);
         
           
           listCustomSett[0].OF_ServizioExtraName__c = NomeServizioExtra;
           update listCustomSett[0];
           
           system.debug('OSCRM OF_IstanziazioneAsset.CreazioneAssetFromCSV__listAsset:'+listAsset);
           if( listAsset.size() > 0 ) insert listAsset;
           
  }
  Fine */
  
  
    //20/09/2017 Modifica rinnovabile - Creo una mappa tra id ordine e contract
    public static map<id, contract> OrderContract(list<order> orders)
    {
        map<id, Contract> mappa = new map<id, Contract>();
        
        set<id> ids = new set<id>();
        for(order o : orders)
        {
            ids.add(o.ContractId);
        }
        
        map<id, contract> contracts = new map<id, contract>([select id, OF_Rinnovabile__c from contract where id IN: ids]);
        
        for(order ord : orders)
        {
            mappa.put(ord.id, contracts.get(ord.ContractId));
        }
            
        return mappa;
    }
    //END 20/09/2017
  
   public static Map<String,Id> mapRT()
    { 
        Map<String,Id> mpRT = new Map<String,Id>();
        for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype where sobjecttype = 'Asset'] )
        {
            mpRT.put( rt.DeveloperName , rt.Id );
        }
        return mpRT;
    }
   /* public static void coverCode(){
    	Integer a=1;
    	
		a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	a=a;
    	
    }*/
}