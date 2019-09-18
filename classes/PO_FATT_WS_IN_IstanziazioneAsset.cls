/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to PSM/Remedy
* SI:           doc. "Specifiche di Interfaccia SalesForce – PSM/Remedy"
* Clone della classe OF_IstanziazioneAsset
*/ 

public class PO_FATT_WS_IN_IstanziazioneAsset { 	
      
    public static Map<String,Id> mappaRT = PO_FATT_WS_IN_IstanziazioneAsset.mapRT();   
    
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
           this.LunghezzaOttica = Lungh;
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
                                           String tipoProcesso ,DateTime DataAttivazioneExtra , OF_IstanziazioneAsset.PO_AssetFields param/*DateTime DataAttivazinePortalino,
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
                            ass.OF_DataScadenza__c = ass.OF_DataAttivazione2__c.date().addYears(30);
                        }
                        if( mappaRT.get('P2P') == Recordtype )
                        {
                            ass.OF_DataScadenza__c = ass.OF_DataAttivazione2__c.date().addYears(15);
                        }                            
                     }                      
                    return ass;

            }catch(Exception e){
                     OF_Utility.logMessage(true,'E',
                     'Classe: PO_FATT_WS_IN_InstanziazioneAsset',
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
                                               Chiuso OK per i Servizi Attivi
                      
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
                                   }
                                   else if(o.isFiberLease__c == true){
                                       RecordTypeId = RecordType_AssetFiberLease;
                                       servizio = 'Fiber Lease';
                                   }
                                   else{
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
                              }
                               
                              System.debug('$$$$_RecordTypeId :'+RecordTypeId);
    
                              Asset ass = PO_FATT_WS_IN_IstanziazioneAsset.IstanziazioneAsset
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
                                  o.OF_PosizioneSplitterSecondario__c,
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
                                  //03/10/2017 Modifica CRM - tolto il campo doppione OF_ServizioRichiesto__c
                                  //null,
                                  null,
                                  null,
                                  obj
                                      
                                  );
                               listAsset.add(ass);
                           }
                   }
                   
                   System.debug('@@@-ListAsset size: '+listAsset.size());
                   
					if(listAsset.size() > 0){
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
				            		t=OF_Utility.logMessageNew2(x+'_'+listAsset[0].recordtypeId,'E','PO_FATT_WS_IN_IstanziazioneAsset','CreazioneAssetFromProcess',(x+1), e);
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
                  
               }
               catch(Exception e)
               {
               
                OF_Utility.logMessage(true,'E',
                         'Classe: OF_InstanziazioneAsset',
                         'Method: CreazioneAssetFromProcess',
                         'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                          );          
                    return null;
               }      
            
        }        
      
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
      
        public static Map<String,Id> mapRT()
        { 
            Map<String,Id> mpRT = new Map<String,Id>();
            for( RecordType rt : [SELECT Id,DeveloperName FROM Recordtype where sobjecttype = 'Asset'] )
            {
                mpRT.put( rt.DeveloperName , rt.Id );
            }
            return mpRT;
        }

}