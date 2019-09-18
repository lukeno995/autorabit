public class OF_AreaGeograficaCSV{

   /*****************************************************************************************************************/
   /*****************************************************Parte CSV***************************************************/
   
   public Blob csvFileBody{get;set;}
   public String csvAsString{get;set;}
   public String[] csvFileLines{get;set;}
   
   public Map<String,String> codiciIstat{get;set;}
   
   List<OF_ElencoComuniItaliani__c> listaData = new List<OF_ElencoComuniItaliani__c>();
          
          
   
   public String[] istat = new String[]{};
   
   public String ist{get;set;}
   public String erroreMsg='I seguenti codici Istat non sono presenti a sistema:\n';
   
   public String Servizio1{get;set;}

   Set<String> test = new Set<String>();
   List<string> conditions = new List<string>();
   
   
   boolean erroreImportCSV;
   
      /*******************FINE PARTE CSV*************************/

 
   List<OF_AreaGeograficaCustom__c> elencoComuni;
   List<OF_AreaGeograficaJunction__c> elencoJunction;
  
   public Contract contr;
   
   public OF_AreaGeograficaCSV() {
       elencoComuni = new List<OF_AreaGeograficaCustom__c>();
       elencoJunction = new List<OF_AreaGeograficaJunction__c>();
       Id id = ApexPages.currentPage().getParameters().get('id');
     
       contr = [SELECT Id,AccountId FROM Contract WHERE Id = : id];
       csvFileLines = new String[]{};
       codiciIstat = new Map<String,String>();
             
    }
    
    /**modifica 07/03/2017**/
    public List<selectoption> listServizi = new List<selectoption>();
    public String Servizio{get;set;}
    public Map<String,String> mapServizi = new Map<String,String>();
    /***fine__modifica***/
   
 
   public void importCSVFile()
   {
         codiciIstat.clear();
         string strWHERE;
         strWhere = ' WHERE OF_CodiceIstat__c IN (';

         try{
                system.debug('Stringa_CSV>>'+csvFileBody.toString());
                csvAsString = csvFileBody.toString();
                csvFileLines = csvAsString.split('\n');
          
                system.debug('Size()-->'+csvFileLines.size()+'\nContenuto>>'+csvFileLines);
                String x;
                conditions.clear();
                for(Integer i=1;i<csvFileLines.size();i++)
                {
                    String[] csvRecordData = csvFileLines[i].split(',');
                    system.debug('csvRecordData-->'+csvRecordData);
                    x='\''+csvRecordData[0].trim()+'\'';
          
                    if( i == csvFileLines.size()-1 )
                    {
                        strWhere =  strWhere + x.trim()+')';
                    }else
                    {
                        strWhere =  strWhere + x.trim()+',';    
                    }      
          
                    codiciIstat.put(csvRecordData[0].trim(),csvRecordData[0].trim());
                    conditions.add(x.trim());         
                }
          
                system.debug('Where-->'+strWhere);
                system.debug('x finale-->'+x);
                system.debug('Conditions-->'+conditions);
         String query = 'SELECT OF_CodiceIstat__c,OF_Comune__c,OF_Provincia__c,OF_Regione__c FROM OF_ElencoComuniItaliani__c '+strWhere;
         listaData = Database.query(query);
         system.debug('listaData>>'+listaData);   
         erroreImportCSV = false;  
         
      }catch(Exception ex)
      {
       system.debug('Errore__>>'+ex);
       String msg = '';
       msg = 'E\' necessario indicare il file CSV ed il servizio \n'+ex.getMessage();
       ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,msg);
       ApexPages.addMessage(errorMessage);
       erroreImportCSV = true;
      }
   }
   
   public PageReference BackToContract()
   {
     if( contr != null )
     {
        PageReference pg = new PageReference('/'+contr.Id);
        pg.setRedirect(true);
        return pg;
     }
     return null;
   }
   
   /*Questo metodo sarà uguale identico a quello utilizzato per il Save 
     nel caso delle Picklist**/
   public PageReference SaveData()
   {
      /**Richiamo la funzione di importCSVFile().Questa funzione fa il check sui dati di arrivo dal Excel**/
      system.debug('---Before importCSVFile()-----\n');
      importCSVFile();
      if(erroreImportCSV  == true)return null;
      
      if( erroreImportCSV == false )
      {
        if( Servizio1 == '--Select Servizio--' )
         {
         String msg3 = '';
         msg3 = 'E\' necessario indicare il file CSV ed il servizio \n';
         ApexPages.Message errorMessage3 = new ApexPages.Message(ApexPages.severity.ERROR,msg3);
         ApexPages.addMessage(errorMessage3);
         return null;
         }
       }
       
      PageReference pg = new PageReference('/'+contr.Id);
      pg.setRedirect(true);
      try
      {
            system.debug('istat>>>'+istat);
            system.debug('listaData-->'+listaData);
            system.debug('codiciIstat__>>'+codiciIstat);
            system.debug('orla_listaData:'+listaData);
             
             /**Check a sistema chechCon lo Stesso OLO**/
             List<String> ComuniSelez = new List<String>();
             Map<String,String> mapComuneIstat = new Map<String,String>();
             Map<String,String> mapComuneRegione = new Map<String,String>();
             Map<String,String> mapComuneProvincia = new Map<String,String>();
             /*******************************************/
             
             for(OF_ElencoComuniItaliani__c ofc : listaData)
             {
                      ComuniSelez.add(ofc.OF_Comune__c);
                      mapComuneIstat.put(ofc.OF_Comune__c,ofc.OF_CodiceIstat__c);
                      mapComuneRegione.put(ofc.OF_Comune__c,ofc.OF_Regione__c);
                      mapComuneProvincia.put(ofc.OF_Comune__c,ofc.OF_Provincia__c);
             }
             
             boolean flag1=checkAreeOLO_CSV(ComuniSelez);
 
             if(flag1==true) return null;
             /**Fine Check a sistema*********************/
             
           
             
             
            /**Controllo per evitare di inserire ogni volta i Comuni lista delle aree geografiche che ci sono già **/
            List<OF_AreaGeograficaCustom__c> li = [SELECT OF_Istat__c,OF_Regione__c,OF_Comune__c,OF_Provincia__c,Id 
                                                   FROM OF_AreaGeograficaCustom__c
                                                   WHERE OF_Comune__c IN : ComuniSelez ];
            system.debug('orlando_li>>>'+li);
            Map<String,String> ComuniEsistenti = new Map<String,String>();
            if( li != null)
            {
                 for(OF_AreaGeograficaCustom__c ef : li)
                 {
                      ComuniEsistenti.put(ef.OF_Comune__c,ef.OF_Istat__c);
                 }
            }
            system.debug('Orlando_ComuniEsistenti>>>'+ComuniEsistenti);
            OF_AreaGeograficaCustom__c obj;

            /**Aggiunta Comuni**/
     
            List<OF_AreaGeograficaCustom__c> elencoComuni = new List<OF_AreaGeograficaCustom__c>();
     
            for(String s : ComuniSelez)
                  { /**Creo solo le aree geografiche che non ci sono**/
                       if( ComuniEsistenti.get(s) == null )
                       {
                             obj = new OF_AreaGeograficaCustom__c();
                             obj.OF_Istat__c = mapComuneIstat.get(s);
                             obj.OF_Regione__c = mapComuneRegione.get(s);
                             obj.OF_Provincia__c = mapComuneProvincia.get(s);
                             obj.OF_Comune__c = s;
                             elencoComuni.add(obj);
                       }
                  }
        

             system.debug('Dentro insert...elenco_comuni'+elencoComuni);
             insert elencoComuni;
             system.debug('After insert Comuni...');
       
             List<OF_AreaGeograficaJunction__c> elencoJunction = new List<OF_AreaGeograficaJunction__c>();
             OF_AreaGeograficaJunction__c obj1;
       
             for(OF_AreaGeograficaCustom__c cv : elencoComuni )
             {
                       obj1 = new  OF_AreaGeograficaJunction__c();
                       obj1.OF_Contratto__c = contr.Id;
                       obj1.OF_AreaGeografica__c = cv.Id;
                       obj1.Name = cv.OF_Istat__c;
                       obj1.OF_Regione__c = cv.OF_Regione__c;
                       obj1.OF_Provincia__c = cv.OF_Provincia__c;
                       obj1.OF_Comune__c = cv.OF_Comune__c;
                   if(!String.isBlank(Servizio1))
                   {
                       obj1.Servizio__c =Servizio1;
                   }
                      elencoJunction.add(obj1);
             }
        
             OF_AreaGeograficaJunction__c obj2;
        
             if( li != null)
             {
               for(OF_AreaGeograficaCustom__c cv1 : li)
               {
                        obj2 = new  OF_AreaGeograficaJunction__c();
                        obj2.OF_Contratto__c = contr.Id;
                        obj2.OF_AreaGeografica__c = cv1.Id;
                        obj2.Name = cv1.OF_Istat__c;
                        obj2.OF_Regione__c = cv1.OF_Regione__c;
                        obj2.OF_Provincia__c = cv1.OF_Provincia__c;
                        obj2.OF_Comune__c = cv1.OF_Comune__c;
                    if(!String.isBlank(Servizio1))
                    {
                        obj2.Servizio__c = Servizio1;
                    }
                        elencoJunction.add(obj2);
                }
             }
    
            if(elencoJunction.size() > 0 )insert elencoJunction;
            system.debug('Orlando_ElencoJunction>>>'+elencoJunction);
            system.debug('AfterINSERT__ID_Records>>'+elencoComuni);
      
            String msg1 = 'Record inseriti correttamente \n';
            ApexPages.Message errorMessage6 = new ApexPages.Message(ApexPages.severity.INFO,msg1);
            ApexPages.addMessage(errorMessage6);
            return null;
      
    
             }catch(Exception e){
                 ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'An error has occured while saving data');
                 ApexPages.addMessage(errorMessage);
             }
          
         return pg;
  
    }/**Chiusura metodo SaveData()**/


  public List<OF_AreaGeograficaJunction__c> getListaComuniOLO1(List<String> comuniSelezionati)
   {
        List<OF_AreaGeograficaJunction__c> ContrattiStessoOLOANDComuni = new List<OF_AreaGeograficaJunction__c>();
        system.debug('mapCom:'+comuniSelezionati);
        if(comuniSelezionati.size()>0)
        {
     
         ContrattiStessoOLOANDComuni = [SELECT id,Name,OF_Contratto__r.AccountId,OF_AreaGeografica__r.OF_Istat__c,
                                    OF_AreaGeografica__r.OF_Comune__c,Servizio__r.Name
                                    FROM OF_AreaGeograficaJunction__c 
         WHERE OF_AreaGeografica__r.OF_Comune__c IN : comuniSelezionati AND OF_Contratto__r.AccountId = : contr.AccountId AND Servizio__c =: Servizio1];
         
         }
       return ContrattiStessoOLOANDComuni;
   }/**Chiusura metodo getListaComuniOLO1**/
      
 public boolean checkAreeOLO_CSV(List<String> Comuni)
 {
       List<OF_AreaGeograficaJunction__c> ContrattiStessoOLOANDComuni1 = getListaComuniOLO1(Comuni); 
     
       String comuniDup = '';
       String msgDaVisualizzare = '';
       String strServizio= '';
       system.debug('ContrattiStessoOLOANDComuni>>>'+ContrattiStessoOLOANDComuni1);
           if( ContrattiStessoOLOANDComuni1 != null && ContrattiStessoOLOANDComuni1.size() > 0 )
           {
                for( OF_AreaGeograficaJunction__c x : ContrattiStessoOLOANDComuni1 )
                {
                  comuniDup +=x.OF_AreaGeografica__r.OF_Istat__c + '-';
                  strServizio = x.Servizio__r.Name;
                }
                msgDaVisualizzare = 'Per questo OLO e per questo servizio ' + strServizio + '  i seguenti ISTAT :' + comuniDup +'\n sono già stati coperti';
                          
                ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,msgDaVisualizzare);
                ApexPages.addMessage(myMsg); 
                return true;
           }
           
       return false;
 }/**Chiusura metodo checkAreeOLO_CSV**/
 
 /**Caricamento di tutti i Servizi(Univoci),elencati in Ordine Crescente**/
 public List<selectoption> getServiziContr1()
 { 
        listServizi.clear();
        List<OF_Servizio__c> servList ;
        
        /**Modifica per prendere solo i Servizi associati a quel Contratto**/
        Set<ID> idC1 = new Set<ID>();
        List<OF_ContrattoServizio__c> listC1 =[SELECT OF_Servizio__c
                                               FROM OF_ContrattoServizio__c 
                                               WHERE OF_Contract__c = : contr.Id];
        for(OF_ContrattoServizio__c cs1 : listC1)
        {
           idC1.add(cs1.OF_Servizio__c);      
        }
        if( idC1.size() > 0 )
        {
            servList = [ SELECT Id,Name,OF_CatalogoCommerciale__r.Name FROM OF_Servizio__c WHERE Id IN : idC1];
        }
       
        listServizi.add(new selectoption('--Select Servizio--','--Select Servizio--'));
        if(servList !=null && servList .size() > 0 )
            {
               for( OF_Servizio__c a : servList )
                 {
                   String s = a.Name+'-'+a.OF_CatalogoCommerciale__r.Name;
                   listServizi.add(new selectoption(a.Id,s));
                   mapServizi.put(s,a.Id);
                 }
             return listServizi;
            }
      return null;
 }/**Chiusura metodo getServiziContr1 **/
    
}/**Chiusura classe OF_AreaGeograficaCSV**/