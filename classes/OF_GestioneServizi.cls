/** Autore:             CRM 21_04_2017
    
    Descrizione Classe: In questa Classe vengono predisposti dei metodi che servono per la creazione
                        e la Cessazione dei Asset e per tutti i Processi di Creazione/Disattivazione Billing
                        element sotto gli Asset.
                        Tutti i Metodi contenuti in questa classe verranno chiamati dai seguenti processi:
                        
                        1.Trigger OF_GestioneServizi
**/
    
    
public with sharing class OF_GestioneServizi {
    
    /**/
    public static Map<ID,ID> AssociazioneOrderAsset(List<Asset> listAsset,List<Order> TriggerNew)
    {
        Map<ID,ID> assetOrder = new Map<ID,ID>();
        if( listAsset!=null && listAsset.size() > 0 )
         { 
             for( Asset ax : listAsset )
             {
                  assetOrder.put(ax.OF_OrdineID__c,ax.Id);
              }
          }
        
         List<Order> listaOrderToUpdate = new List<Order>(); 
         
         if( assetOrder!=null && assetOrder.size()>0)
         {
             for( Order or1 : TriggerNew)
             {
                 system.debug('OS_assetOrder-->'+assetOrder.get(or1.Id));
                 or1.OF_Asset__c = assetOrder.get(or1.Id); 
                 //listaOrderToUpdate.add(or1);
                 //system.debug('\n OS_Dentro il terzo for()--\n');
              }
          }
       
       return assetOrder;
     }
     
     public static Map<ID,Asset> getIDAssetAssetObj(List<Asset> listAsset)
     {
        Map<Id,Asset> idAssetAssetObj = new Map<ID,Asset>();
        
        for( Asset ass: listAsset ) idAssetAssetObj.put(ass.Id,ass);
        
        return idAssetAssetObj;
     }
     
     //Metodo utilizzato in pre-fase di Creazione BE CPE di Cessazione
     public static Map<ID,Asset> getIDAssetAssetObj(Set<ID> assid)
     {
        Map<ID,Asset> mapAsset = new Map<ID,Asset>();
        List<Asset> listAsset = [select RecordtypeId,Name,AccountId,OF_Contract__c,OF_OrdineID__c,
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
                                      OF_TipologiaApparato__c,OF_EsitoRitiroApparato__c
                               from Commercial_element_istanziati3__r )
                                  
                        from Asset 
                        where id in : assid ];
                        
        for( Asset ass : listAsset )
        {
            mapAsset.put( ass.Id , ass );
        }
        return mapAsset;
     }
        
     
     /****************************CALL METODI SERVIZI PASSIVI***********************/
     /*
     public static List<Asset> CALL_CREAZIONEASSET_SERVIZI_PASSIVI(List<Order> listaOrdini)
     {
        return OF_GestioneServiziPassivi.CreazioneAsset(listaOrdini,NULL,0);
     }
     */
     
     /**Switch logica sul campo OF_Esito_Consegna_Apparato presente nel Case**/
     /*****Istanziazione BE_CE ATTIVAZIONE*********/
      public static Map<String,List<String>> AttivazioneBECE(String EsitoConsegnaApparato,String SlaPremiumAssurance)
          {
           try{
                    List<String> BE = new List<String>();
                    List<String> CE = new List<String>();
                    
                    Map<String,List<String>> mappaCE_BE = new Map<String,List<String>>();
                    
                    /***Logica per CE: SERVIZIO FIBRA BASE
                                   BE1: CANONE
                                   BE2: CANONE PREMIUM
                                   BE3: CONTRIBUTO ATTIVAZIONE
                     ***/
                     
                    BE.add('CONTRIBUTO ATTIVAZIONE');
                    CE.add('SERVIZIO FIBRA BASE');
                    
                       if(SlaPremiumAssurance == 'N' || SlaPremiumAssurance == null || String.isBlank(SlaPremiumAssurance) ){
                            BE.add('CANONE');
                       }
                       else{
                            if(SlaPremiumAssurance == 'Y'){
                                BE.add('CANONE PREMIUM');
                                CE.add('SLA PREMIUM ASSURANCE');
                            }
                       }
                       
                    /***Logica per CE: RIBALTAMENTO IMPIANTO
                                   BE: CONTRIBUTO RIBALTAMENTO IMPIANTO
                                   
                                   CE:CPE
                                   BE:CONTRIBUTO ISTALLAZIONE
                     ***/
                     
                    if( EsitoConsegnaApparato != null && !String.isBlank(EsitoConsegnaApparato) )
                    {
                       if( EsitoConsegnaApparato == '1' || EsitoConsegnaApparato == '2')
                       {          
                            BE.add('CONTRIBUTO ISTALLAZIONE');
                            CE.add('CPE');
                            
                            if( EsitoConsegnaApparato == '2' )
                            {
                                BE.add('CONTRIBUTO RIBALTAMENTO IMPIANTO');
                                CE.add('RIBALTAMENTO IMPIANTO');
                            }
                       }
                    }
                    
                    
                       
                       system.debug('DG20 - BE: ' + BE);
                       system.debug('DG20 - CE: ' + CE);
                       mappaCE_BE.put('BE',BE);
                       mappaCE_BE.put('CE',CE);
                       
                      if(mappaCE_BE.size() > 0 ) return mappaCE_BE;
                      return null;
                      
              }catch(Exception e )
               {
                  OF_Utility.logMessage(true,'E','Classe: OF_GestioneServizi','Method: AttivazioneBECE','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
                return null;
               }
      }
      
      
      /**Istanziazione BE-CE Cessazione**/
      public static Map<String,List<String>> CessazioneBECE(String Apparato)
      {
        try{
          
                  List<String> BE = new List<String>();
                  List<String> CE = new List<String>();
                            
                  Map<String,List<String>> mappaCE_BE = new Map<String,List<String>>();
                                
                  BE.add('CONTRIBUTO DISATTIVAZIONE');
                      
                      if( Apparato != null )
                      {
                         if( Apparato == 'Y')
                         {
                           //s2.add('CONTRIBUTO DISATTIVAZIONE');
                           BE.add('CONTRIBUTO RITIRO');
                         }
                      }
                  
                  mappaCE_BE.put('BE',BE);
                  mappaCE_BE.put('CE',CE);
                  
                  if(mappaCE_BE.size() > 0 ) return mappaCE_BE;
                  return null;
          
          }catch(Exception e )
          {
              OF_Utility.logMessage(true,'E','Classe: OF_GestioneServizi','Method: CessazioneBECE','Exception : ' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage());          
              return null;
          }
                  
      }
/***********************************************************************************/
/*********************LOGICA BE-CE SERVIZI ATTIVI***********************************/
/***********************************************************************************/
}