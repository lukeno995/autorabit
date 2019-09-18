/** Autore:             CRM 21_04_2017
    
    Descrizione Classe: In questa Classe vengono predisposti dei metodi che servono per la creazione
                        e la Cessazione dei Asset.La Classe viene chiamata quando arriva un Case di 
                        Attivazione/Cessazione per i Servizi Passivi
**/

public class OF_GestioneServiziAttiviPassivi{
    
    
    
    /**Autore:          CRM 21_04_2017
       
       DescrizioneMetodo:
          1.Dati In Input:Lista di Contratti,ed una mappa idContratto-ListaOrder.
          2.Dati In Output: Lista di Asset
          3.Descrizione LogicaMetodo: Si itera prima nei contratti.Per ogni contratto(utilizzando l'ID Salesforce del Contract)
                                      si va a fare un estrazione nella Mappa contrOrder.Per ogni contratto,si avrà una lista di 
                                      Ordini da processare.
                                      Per ogni ordine,si va a creare un Asset che verrà poi legato all'Ordine che si sta processando.
          
          4.Descrizione Funzionale Metodo: Questo metodo è stato pensato per Creare Asset Massivi per Diversi Contratti
          5.If flusso == 0 CreazioneAsset Da Processo(Trigger su Order)
            If flusso ==1 CreazioneAsset Da ImportCSV         
     **/
    
    /***************************METODO CREAZIONEASSET******************************************************/
     public static List<Asset> CreazioneAsset(List<Order> listaOrdini,List<List<String>> listCSVAsset,Integer flusso)
      {
        	if(!OF_SA_GE_Utils.checkRtMap){
		    	OF_SA_GE_Utils.RtMap=new Map<String,String>();
		        for( Recordtype rt : [SELECT Id,DeveloperName 
		                              FROM Recordtype]){
		            OF_SA_GE_Utils.RtMap.put( rt.DeveloperName , rt.Id );
		        }
		        OF_SA_GE_Utils.checkRtMap=true;
		    }
             /**OS30 Modifica 06_04_2017 Gestione con o senza OM***
             List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
             DateTime dataswitch = listCustomSett[0].DataSwitchOM__c;
             
             //Servizi Attivi
             /*****Creazione Asset Da processo(FiberRequest)******/
                 if( flusso == 0)
                   {
                       return OF_IstanziazioneAsset.CreazioneAssetFromProcess(listaOrdini,OF_SA_GE_Utils.RtMap.get('OF_GPONPassiva'),
                                                                                          OF_SA_GE_Utils.RtMap.get('OF_OpenStream'),
                                                                                          OF_SA_GE_Utils.RtMap.get('P2P'),
                                                                                          OF_SA_GE_Utils.RtMap.get('Fiber_Link'),
                                                                                          OF_SA_GE_Utils.RtMap.get('Fiber_Lease'));
                   }
                 /******************************************************/
                 /*****Creazione Asset Da CSV(ImportCSV)****
                 if( flusso == 1)
                 {
                      // Map<String,ID> AccountOLO = OF_IstanziazioneAsset.getAccountOLO();
                       return OF_IstanziazioneAsset.CreazioneAssetFromCSV(listCSVAsset,dataswitch,listCustomSett,'Servizio Passivo');
                 }
              /******************************************/
             return null;
    }
    
    
    /**Autore:          CRM 21_04_2017
       
       DescrizioneMetodo:
          1.Dati In Input:Lista di Asset,ed una mappa idRisorsa-Order.
          2.Dati In Output: null
          3.Descrizione LogicaMetodo: Si itera nella lista dei Asset da Disattivare.Per ogni Asset,si cambia lo Status = 'Cessato',
                                      La Data di Cessazione è uguale alla data di eseguzione del processo di Disattivazione a sistema.
                                      Poi questi Asset Cessati devono essere legati all'Order aperto nel Case di Cessazione.A questo proposito
                                      Si fa un estrazione nella mappa idrisorsa,dove tengo traccia traidrisorsa e idOrder di Cessazione.
                                      
          4.Descrizione Funzionale Metodo: Questo metodo è stato per Cessare dei Asset Massivi,avendo dei Ordini di Cessazione Massivi
                                           in input.
                  
     **/
     
    /***************************METODO DISATTIVAZIONEASSET**********************************/
    public static void CessazioneAsset(List<Asset> AssetList,Map<String,Order> idrisorsa)
    
    //----------------------da richiamare in cessazione
    {
        try{
               list<Asset> AssetToUpdate = new list<Asset>();
               for(Asset ass : AssetList )
               {
           			//check per passivi
                     if( OM_GW_GE_Utils.slSFOLO!=null )
                     {
	                     ass.OF_DataCessazione2__c = OM_GW_GE_Utils.slSFOLO.EOF_Data_Notifica__c;
                     }
                     //o attivi
                     else{
                     	ass.OF_DataCessazione2__c = OF_SA_GE_Utils.slSFOLO.EOF_Data_Notifica__c;
                     }
                     //FINE
                     ass.status = 'Cessato';
                     ass.OF_OrdineId__c = idrisorsa.get(ass.EOF_ID_Risorsa__c).Id;
                     AssetToUpdate.add(ass);
                }
                
                if( (AssetToUpdate.size() > 0) && (AssetToUpdate != null) ){
                    update AssetToUpdate;
                }
                
                return;
                
           }catch(Exception e)
           {
            OF_Utility.logMessage(true,'E',
                     'Classe: OF_GestioneServiziPassivi',
                     'Method: DisattivazioneAssets',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );            
                return;
           }
     }
     
     
     
          /**1. Metodo istanziazione BE-CE ServiziAttivi
               (Quando arriva una richiesta di Attivazione e successivamente si passa in 'Espletato OK')
           **/
           
           
          public static Map<String,List<String>> getControlli1(String EsitoConsegnaApparato,String SlaPremiumAssurance)
          {
           try{
                  /**Questa Lista contiene per ogni CE,i relativi BE da istanziare**/
                  /*Map<String,List<String>> s1 = new Map<String,List<String>>();*/
                  /**Attivazione**/
                  List<String> BEIstanziazione = new List<String>();
                  List<String> CEIstanziazione = new List<String>();
                  
                  Map<String,List<String>> ListaBE_CE = new Map<String,List<String>>(); 
                 
                  
                  CEIstanziazione.add('SERVIZIO FIBRA BASE');
                  BEIstanziazione.add('CONTRIBUTO ATTIVAZIONE');
                  
                  
                  if(SlaPremiumAssurance == 'N' || SlaPremiumAssurance == null || String.isBlank(SlaPremiumAssurance) )
                  {
                         BEIstanziazione.add('CANONE');
                  }
                  else if(SlaPremiumAssurance == 'Y')
                  {
                         BEIstanziazione.add('CANONE PREMIUM');
                         CEIstanziazione.add('SLA PREMIUM ASSURANCE');
                  }
                  
                  if( EsitoConsegnaApparato == '1' ||
                      EsitoConsegnaApparato == '2' )
                  {
                         CEIstanziazione.add('CPE');
                         BEIstanziazione.add('CONTRIBUTO ISTALLAZIONE');
                         
                         if( EsitoConsegnaApparato == '2' )
                         {
                              CEIstanziazione.add('RIBALTAMENTO IMPIANTO');
                              BEIstanziazione.add('CONTRIBUTO RIBALTAMENTO IMPIANTO');
                         }      
                   
                   }
               ListaBE_CE.put('BE',BEIstanziazione);
               ListaBE_CE.put('CE',CEIstanziazione);
               
               return ListaBE_CE;
                  
              }catch(Exception e ) 
               {
                  OF_Utility.logMessage(true,'E',
                     'Classe: OF_UtilitiesCreazioneAsset',
                     'Method: getControlli1',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );          
                return null;
               }

    
          }
          
          /**Metodo istanziazione CE-BE quando arriva una richiesta di Espletamento**/
          public static Map<String,List<String>> getControlli2(String apparato)
          {
                List<String> BEIstanziati = new List<String>();
                List<String> CEIstanziati = new List<String>();
                
                Map<String,List<String>> ListaBE_CE = new Map<String,List<String>>();
                
                BEIstanziati.add('CONTRIBUTO DISATTIVAZIONE');
                
                if( apparato != null && !String.isBlank(apparato))
                {
                    CEIstanziati.add('CPE');
                    BEIstanziati.add('CONTRIBUTO ISTALLAZIONE');
                }
                
                ListaBE_CE.put('BE',BEIstanziati);
                ListaBE_CE.put('CE',CEIstanziati);
                
                return ListaBE_CE;
          }
          
     
    
    public static void CessazioneBE(List<Asset> listaAsset,Map<String,Order> idrisorsa)
    {
          
       try{
                /**OS30 Modifica 06_04_2017 Gestione con o senza OM***/
                List<OF_Configurazioni__c> listCustomSett = OF_Configurazioni__c.getAll().values();
                DateTime dataswitch = listCustomSett[0].DataSwitchOM__c;
                           
                Set<ID> idAsset = new Set<ID>();
                List<PriceBookEntry> listPriceNonActive = new List<PriceBookEntry>();
                list<Asset> AssetToUpdate = new list<Asset>();
             
                for( Asset ass : listaAsset )
                {
                      idAsset.add(ass.Id);
                      ass.OF_OrdineId__c = idrisorsa.get(ass.EOF_ID_Risorsa__c).Id;
                      AssetToUpdate.add(ass);
                }
                          
                  List<PriceBookEntry> listPriceBookEntry = [SELECT Id,IsActive,OF_DataDiCessazione__c,Pricebook2Id, 
                                                                    OF_DataCessazione2__c,OF_Asset__c,OF_Asset__r.Recordtype.developername
                                                             FROM PriceBookEntry WHERE OF_Asset__c IN : idAsset];
                  
                  if( listPriceBookEntry != null && listPriceBookEntry.size() > 0 )
                  {
                      for(PriceBookEntry prE : listPriceBookEntry)
                        {
                          prE.isActive = false;
                         //START Modifica CRM 06/04/2017 DG modifica data di cessazione pricebookentry per gestione senza OM
                            /*DG 28/04/2017 Commentato per nuova gestione date --> Process Builder: Data Attivazione Cessazione Asset e BillingElement
                            prE.OF_DataDiCessazione__c = system.today();
                            prE.OF_DataCessazione2__c = system.now();//idrisorsa.get(ass.EOF_ID_Risorsa__c).ClosedDate;
                            */
                          //END Modifica 
                          //CRM MODIFICA 07_11_2017
                          //controllo se passivo

                          if(prE.OF_Asset__r.Recordtype.developername == 'OF_GPONPassiva'){
                              if( OM_GW_GE_Utils.slOrig.EOF_Tipo_comunicazione__c == '11' )
                              {
                                 PrE.OF_DataCessazione2__c = OM_GW_GE_Utils.slOrig.EOF_Data_Notifica__c;   
                              }
                          }
                          //o attivo
                          if(prE.OF_Asset__r.Recordtype.developername == 'OF_OpenStream'){
                                 PrE.OF_DataCessazione2__c = OF_SA_GE_Utils.slOLOSF.EOF_Data_Notifica__c;   
                          }
                          //FINE
                          listPriceNonActive.add(prE);
                         }
                   }
                  if( AssetToUpdate != null && AssetToUpdate.size() > 0 ) update AssetToUpdate;
                  
                  if( listPriceNonActive != null && listPriceNonActive.size() > 0 ){
                  	 boolean inserito=false;	
                  	 boolean templog=false;
            		Templog__c t = new Templog__c();
		            for(integer x=0; x<50; x++){
			            try{
                  	 		update listPriceNonActive;
              	 			inserito=true; 
	            		}
	            		catch(exception e){
	            			if(!templog){
			            		t=OF_Utility.logMessageNew2(listPriceNonActive[0].Pricebook2Id,'E','OF_GestioneServiziAttiviPassivi','CessazioneBE',(x+1), e);
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
                  return;
                }catch( Exception e )
                {
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_GestioneServiziAttiviPassivi',
                     'Method: CessazioneBE',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                
                }
            
      }
      
      public static void CessazioneCE(List<Asset> listaAsset,Map<String,Order> idrisorsa)
      {
          try{
                Set<ID> idAsset = new Set<ID>();
                List<OF_CommercialElementIstanziato__c> listCENonActive = new List<OF_CommercialElementIstanziato__c>();
                list<Asset> AssetToUpdate = new list<Asset>();
             
                for( Asset ass : listaAsset )
                {
                      idAsset.add(ass.Id);
                      ass.OF_OrdineId__c = idrisorsa.get(ass.EOF_ID_Risorsa__c).Id;
                      AssetToUpdate.add(ass);
                }
                        
                  List<OF_CommercialElementIstanziato__c> listCommercialElementIstanziato = [SELECT Id,OF_Stato__c
                                                                                             FROM OF_CommercialElementIstanziato__c 
                                                                                             WHERE OF_Asset__c IN : idAsset];
                system.debug('é**** OF_GEstioneServiziAttiviPassivi lista di CEI ' + listCommercialElementIstanziato);
               if( listCommercialElementIstanziato != null && listCommercialElementIstanziato.size() > 0 )
               {
                   for(OF_CommercialElementIstanziato__c CE : listCommercialElementIstanziato)
                   {
                       CE.OF_Stato__c = 'Cessato';
                       //CRM MODIFICA 07_11_2017
                       if( OM_GW_GE_Utils.slSFOLO!=null) 
                       {
	                       CE.OF_DataCessazione__c = OM_GW_GE_Utils.slSFOLO.EOF_Data_Notifica__c;
                       }
                       else{
                       		CE.OF_DataCessazione__c = OF_SA_GE_Utils.slSFOLO.EOF_Data_Notifica__c;
                       }
                       //
                       listCENonActive.add(CE);
                   }
               }
              system.debug('***** list di CEI cessati ' + listCENonActive);
              if( AssetToUpdate != null && AssetToUpdate.size() > 0 ) update AssetToUpdate;
              if( listCENonActive != null && listCENonActive.size() > 0 ) update listCENonActive;
              return;
            
                }catch( Exception e )
                {
                    OF_Utility.logMessage(true,'E',
                     'Classe: OF_GestioneServiziAttiviPassivi',
                     'Method: CessazioneCE',
                     'Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );           
                
                }
            
       }
                      
    
    
    
    
    
}