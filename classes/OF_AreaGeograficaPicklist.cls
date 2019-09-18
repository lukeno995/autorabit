public class OF_AreaGeograficaPicklist{
    
    /**Attributi riempimento listBox**/
    public List<selectoption> listRegione = new List<selectoption>();
    public List<selectoption> listProvincia = new List<selectoption>();
    public List<selectoption> listComune = new List<selectoption>();
    public List<selectoption> listServizi = new List<selectoption>();
    
    /**Attributi contenenti i valori selezionati nelle ListBox**/
    public String Reg{get;set;}
    public String Prov{get;set;}
    public List<String> Com{get;set;}
    public String Servizio{get;set;}
    
    /**Attributi che servono per memorizzare i dati nei due oggetti Junction,e
       AreaGeografica Custom**/
   List<OF_AreaGeograficaCustom__c> elencoComuni;
   List<OF_AreaGeograficaJunction__c> elencoJunction;
   
   
   
   public Contract contr;
   
    /**Attributo che memorizza il valore precedente della Provincia.
       (Workaround,caso in cui cambio la Regione avendo selezionato una provincia,e non mi
        deve prendere il valore vecchio della Provincia**/
    public String ProvPrecedente='';
    
    /**Attributi che servono in fase di Memorizzazione dei Dati**/
    Map<String,String> mapCom = new Map<String,String>();
    Map<String,String> mapComProv = new Map<String,String>();
    Map<String,String> mapServizi = new Map<String,String>();
    
    
   
   /**Costruttore**/
   public OF_AreaGeograficaPicklist(){
   
     elencoComuni = new List<OF_AreaGeograficaCustom__c>();
     elencoJunction = new List<OF_AreaGeograficaJunction__c>();
     Id id = ApexPages.currentPage().getParameters().get('id');
     
     contr = [SELECT Id,AccountId FROM Contract WHERE Id =: id];
     system.debug('Contratto-->'+contr);
   
   }
    
   /**Funzione che serve per ritornare al contratto di partenza**/
   public PageReference toReturn()
   {
       if( contr != null )
       {
          PageReference pg = new PageReference('/'+contr.Id);
          pg.setRedirect(true);
          return pg;
       }else
       {
          return null;
       }
   }
      
   /**Questo metodo fa un check sulla selezione **/
   public boolean checkEmptyRegionComuni()
   {
       if( Reg == '--Seleziona Regione--' )
       {
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Devi selezionare una Regione!');
          ApexPages.addMessage(myMsg);
          return true;
       }
       /**Controllo che viene fatto dopo che l'utente ha selezionato Piemonte o Lombardia.Gli 
          è uscito il pop-up che lo invita a selezionare la provincia ma non la seleziona e per sbaglio 
          preme Save.
          Solo in questa casistica si fa un controllo che la Provincia sia Selezionata**/
       if( Reg == 'Piemonte' || Reg == 'Lombardia' )
       {
          if ( Prov == '--Seleziona Provincia--' )
          {
             ApexPages.Message myMsg3 = new ApexPages.Message(ApexPages.Severity.ERROR,'Devi selezionare una Provincia!');
             ApexPages.addMessage(myMsg3);
             return true;
          }
       }
       
       if( Com.size() == 0 )
       {
          ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.ERROR,'Devi selezionare almeno un Comune!');
          ApexPages.addMessage(myMsg1);
          return true;
       }
       if( Com.size() > 0 )
       {
          for( String s : Com )
          {
             if( s == '--Seleziona Comune--')
             {
               system.debug('\nDentro il caso di --Seleziona Comune--\n');
               String msg6 = 'Devi selezionare almeno un Comune!\n';
               ApexPages.Message myMsg2 = new ApexPages.Message(ApexPages.Severity.ERROR,msg6);
               ApexPages.addMessage(myMsg2);
               return true;
              }
          }
       }

      return false;
   }
        

    /**Metodo che viene chiamato al cambiamento della Regione.Serve per tenere traccia
       del valore vecchio della provincia**/
    public void setProvPrecedente()
    {
      if(Prov != null && Prov != '--Seleziona Provincia--')
      {
      this.ProvPrecedente = Prov;
      system.debug('setProvPrecedente-->'+this.ProvPrecedente);
      }
    }
    
    /**Controllo che non ci siano Contratti sotto lo stesso OLO che 
       hanno coperto la stessa Area Geografica.Si fa un check nella tabella
       OF_AreaGeograficaJunction__c per vedere se ci sono record registrati 
       tra contratti relativi allo stesso OLO e che hanno coperto la stessa
       Area Geografica**/
    public List<OF_AreaGeograficaJunction__c> getListaComuniOLO(List<String> comuniSelezionati)
    {
           List<OF_AreaGeograficaJunction__c> contrattiStessoOLOANDComuni = new List<OF_AreaGeograficaJunction__c>();
           
           system.debug('comuniSelezionati-->'+comuniSelezionati);
           system.debug('Servizio-->'+Servizio);
           
           if(comuniSelezionati.size()>0)
           {
               contrattiStessoOLOANDComuni = [SELECT Id,Name,OF_Contratto__r.AccountId,OF_AreaGeografica__r.OF_Istat__c,
                                              OF_AreaGeografica__r.OF_Comune__c,Servizio__r.Name  
                                              FROM OF_AreaGeograficaJunction__c 
                                              WHERE OF_AreaGeografica__r.OF_Comune__c IN : comuniSelezionati AND OF_Contratto__r.AccountId =: contr.AccountId AND Servizio__c =:Servizio];
            
           }
           system.debug('contrattiStessoOLOANDComuni-->'+contrattiStessoOLOANDComuni);
       return contrattiStessoOLOANDComuni;
    }
    
    /****Metodo Check for AreeSottostessoOLO****/
    public boolean checkAreeOLO()
    {
           List<OF_AreaGeograficaJunction__c> ContrattiStessoOLOANDComuni1 = getListaComuniOLO(Com);
           
           String comuniDup = '';
           String msgDaVisualizzare = '';
           String strServizio='';
           
           system.debug('ContrattiStessoOLOANDComuni>>>>'+ContrattiStessoOLOANDComuni1);
           
           if( ContrattiStessoOLOANDComuni1 != null && ContrattiStessoOLOANDComuni1.size() > 0 )
           {
                for( OF_AreaGeograficaJunction__c x : ContrattiStessoOLOANDComuni1 )
                {
                   comuniDup += x.OF_AreaGeografica__r.OF_Istat__c+'-';
                   strServizio = x.Servizio__r.Name;
                }
             
             msgDaVisualizzare = 'Per questo OLO e per questo servizio'+strServizio+' i seguenti ISTAT :'+comuniDup+'\n sono già stati coperti';
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,msgDaVisualizzare);
             ApexPages.addMessage(myMsg);
             return true;
           }
         return false;
    }
    
    public Map<String,String> getComProv()
    {
       Map<String,String> mpx = new Map<String,String>();
       
       List<OF_ElencoComuniItaliani__c> lmod = [SELECT OF_CodiceIstat__c,OF_Provincia__c
                                                FROM OF_ElencoComuniItaliani__c
                                                WHERE OF_Comune__c IN : mapCom.keyset()];
       
       system.debug('lmod:::'+lmod);
       if( lmod.size() > 0 && lmod != null )
       {
           for( OF_ElencoComuniItaliani__c lm : lmod )
           {
               mpx.put(lm.OF_CodiceIstat__c,lm.OF_Provincia__c);
           }
       }
     system.debug('mapComProv>>'+mpx);
     return mpx;
    }             
           
           
    
    /**Metodo SAVE().Da continuare i Commenti....**/
    public PageReference save()
    {
       PageReference pg = new PageReference('/'+contr.Id);
       pg.setRedirect(true);
       /*******************DEBUG DATI IN ARRIVO*********************/
       system.debug('---Dentro Save()---');
       system.debug('Reg::'+Reg);
       system.debug('Prov::'+Prov);
       system.debug('Com::'+Com);
       system.debug('mapCom(Comune,CodiceISTAT)>>>'+mapCom);
       system.debug('listServizi::'+listServizi);
       system.debug('mapServizi::'+mapServizi);
       
       /************************************************************/
       
       
       /**Controlli selezione Regione-Comune**/
       boolean checkEmptyRegionANDComuni = checkEmptyRegionComuni();
       if( checkEmptyRegionANDComuni == true ) return null;
       /**Fine Controlli selezione Regione-Comune**/
       
       /**Controllo selezione Servizio**/
       if( Servizio == '--Seleziona Servizio--' )
       {
          String msg4 = '';
          msg4 = 'E\' necessario indicare il servizio\n';
          ApexPages.Message errorMessage4 = new ApexPages.Message(ApexPages.severity.ERROR,msg4);
          ApexPages.addMessage(errorMessage4);
          return null;
       }
       /**Fine Controllo selezione Servizio**/
       
       /**Controllo che non ci siano Aree Coperte in precedenza**/
       boolean checkAreeOLOFlag = checkAreeOLO();
       if( checkAreeOLOFlag == true ) return null;
       /*****************Fine Controllo**************************/
       
       OF_AreaGeograficaCustom__c obj;
       
       /**Controllo per evitare di inserire ogni volta i Comuni delle aree geografiche che ci sono già**/
       List<OF_AreaGeograficaCustom__c> li = [SELECT OF_Istat__c,OF_Regione__c,OF_Comune__c,OF_Provincia__c,Id
                                              FROM OF_AreaGeograficaCustom__c
                                              WHERE OF_Comune__c IN:Com];
       system.debug('ListaComuniEsistenti-->'+li);
       Map<String,String> ComuniEsistenti = new Map<String,String>();
       
       if( li != null )
       {
           for( OF_AreaGeograficaCustom__c ef : li )
           {
             ComuniEsistenti.put(ef.OF_Comune__c,ef.OF_Istat__c);
           }
       }
       /*******************Fine Controllo*******************/
       
       /*******************Inizio Inserimento nel DataBase****/
       mapComProv = getComProv();
       
       if( Com.size() > 0 )
       {
               for(String s : Com )
               {
                   /**Creo solo le aree geografiche che non ci sono**/
                   if( ComuniEsistenti.get(s) == null )
                   {
                      obj = new OF_AreaGeograficaCustom__c();
                      obj.OF_Istat__c = mapCom.get(s);
                      obj.OF_Regione__c = Reg;
                      
                      if( Prov == '--Seleziona Provincia--' )
                      {
                        obj.OF_Provincia__c = mapComProv.get(mapCom.get(s));
                      }else{
                        obj.OF_Provincia__c = Prov;
                      }
                      obj.OF_Comune__c = s;
                      
                      elencoComuni.add(obj);
                    }
                }
       }
       
       try{
            system.debug('BeforeInsert-->ElencoComuni-->'+elencoComuni);
            insert elencoComuni;
            system.debug('After insert Comuni..');
            OF_AreaGeograficaJunction__c obj1;
            
            /**Creazione associazione Contratto-AreaGeografica
               quando i Comuni inseriti non ci sono**/
            for( OF_AreaGeograficaCustom__c cv : elencoComuni)
            {
            
                 obj1 = new OF_AreaGeograficaJunction__c();
                 obj1.OF_Contratto__c = contr.Id;
                 obj1.OF_AreaGeografica__c = cv.Id;
                 obj1.Name = cv.OF_Istat__c;
                 obj1.OF_Regione__c = cv.OF_Regione__c;
                 obj1.OF_Provincia__c = cv.OF_Provincia__c;
                 obj1.OF_Comune__c = cv.OF_Comune__c;
                 
                 if( !String.isBlank(Servizio) )
                 {
                 obj1.Servizio__c = Servizio;
                 }
                 elencoJunction.add(obj1);
            }
            
            OF_AreaGeograficaJunction__c obj2;
            
            if( li!=null)
            {
               for( OF_AreaGeograficaCustom__c cv1 : li)
               {
            
                 obj2 = new OF_AreaGeograficaJunction__c();
                 obj2.OF_Contratto__c = contr.Id;
                 obj2.OF_AreaGeografica__c = cv1.Id;
                 obj2.Name = cv1.OF_Istat__c;
                 obj2.OF_Regione__c = cv1.OF_Regione__c;
                 obj2.OF_Provincia__c = cv1.OF_Provincia__c;
                 obj2.OF_Comune__c = cv1.OF_Comune__c;
                 
                 if( !String.isBlank(Servizio) )
                 {
                 obj2.Servizio__c = Servizio;
                 }
                 elencoJunction.add(obj2);
                }
             }
             
             if(elencoJunction.size()>0) insert elencoJunction;
             system.debug('AfterINSERT_ID_Records>>>'+elencoComuni);
          }catch(DMLException ex)
          {
             system.debug('Errore_di_insert_Orlando:::'+ex.getMessage());
             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
             ApexPages.addMessage(myMsg);
             //return
          }
       
       
       
       return pg;
    }
    
    
    /**Caricamento di tutte le Regioni distinte,elencate in ordine Crescente**/
    public List<selectoption> getRegione()
    {
        listRegione.clear();
        List<AggregateResult> agrRes = [SELECT OF_Regione__c
                                        FROM OF_ElencoComuniItaliani__c
                                        GROUP BY OF_Regione__c ORDER BY OF_Regione__c desc];
      
        listRegione.add(new selectoption('--Seleziona Regione--','--Seleziona Regione--'));
      
        if( agrRes != null && agrRes.size()>0)
        {
            for( AggregateResult a : agrRes )
            {
               String x = (String)a.get('OF_Regione__c');
               listRegione.add(new selectoption(x,x));
            }
            return listRegione;
        }
      return null;
    } 
    
    
    /**Caricamento di tutte le Provincie distinte,elencate in ordine Crescente**/
    public List<selectoption> getProvincia()
    {
          listProvincia.clear();
          List<AggregateResult> agrRes = new List<AggregateResult>();
          system.debug('dentro getProvincia(),Reg='+Reg);
          if( Reg != null)
          {
              system.debug('dentro getProvincia()_dentro condizione su Regione');
              if(Reg == '--Seleziona Regione--')
              {
                system.debug('dentro getProvincia()_ setto la Regione');
                listProvincia.clear();
                return listProvincia;
              }
                    
              agrRes = [SELECT OF_Provincia__c
                        FROM OF_ElencoComuniItaliani__c
                        WHERE OF_Regione__c =: Reg GROUP BY OF_Provincia__c ORDER BY OF_Provincia__c desc]; 
          
              listProvincia.add(new selectoption('--Seleziona Provincia--','--Seleziona Provincia--'));
          
              if( agrRes.size() > 0 )
              {
                  for( AggregateResult a : agrRes ) 
                  {
                     String x = (String)a.get('OF_Provincia__c');
                     listProvincia.add(new selectoption(x.trim(),x.trim()));
                   }
                 return listProvincia;
               }
          
           }/**Chiusura if(Reg!=null)**/
             
        return listProvincia;
     
     }/**Chiusura metodo getProvincia()**/
     
     
     /**Caricamento di tutti i Comuni(Univoci),elencati in Ordine Crescente**/
     public List<selectoption> getComune()
     {
           listComune.clear();
           List<OF_ElencoComuniItaliani__c> agrRes;
              
            if( Reg == null )
            {
               return listComune;
            }
              
            if( Reg == '--Seleziona Regione--' )
            {
               listComune.clear();
               return listComune;
            }
           
            /**Quando Cambio la Regione,si deve popolare in automatico la PickList dei Comuni**/
            system.debug('Dentro getComune');
            if( Reg != '--Seleziona Regione--')
            {
               system.debug('Reg:'+Reg);
               if( listProvincia.size() > 0 )
               {
                  system.debug('dentro listProvinciaSize__Prov-->'+Prov);
                  agrRes = [SELECT OF_Comune__c,OF_CodiceIstat__c
                            FROM OF_ElencoComuniItaliani__c
                            WHERE OF_Regione__c =: Reg ORDER BY OF_Comune__c ASC];
                  
                    if( Prov != null && Prov != '--Seleziona Provincia--' && Prov != ProvPrecedente)
                    {
                      system.debug('secondo if__Prov->'+Prov);
                      agrRes.clear();
                      agrRes = [SELECT OF_Comune__c,OF_CodiceIstat__c
                                FROM OF_ElencoComuniItaliani__c
                                WHERE OF_Regione__c =: Reg AND OF_Provincia__c =: Prov ORDER BY OF_Comune__c ASC];
                  
                     }
                }/**Chiusura if(listProvincia.size() > 0 ) **/ 
               
             }/**Chiusura if(Reg != '--Seleziona Regione--')**/
              
            system.debug('Condizioni passate\n');
            if( agrRes != null && agrRes.size() > 0) 
            {              
                if(agrRes.size() > 1000)
                {
                   return listComune;
                }else
                {
                   listComune.add(new selectoption('--Seleziona Comune--','--Seleziona Comune--'));
                   for( OF_ElencoComuniItaliani__c a : agrRes )
                   {
                        String si = '\''+a.Id+'\'';
                        String c = '\''+a.OF_Comune__c.trim()+'\'';
                        listComune.add(new selectoption(a.OF_Comune__c.trim(),a.OF_Comune__c.trim()));
                        mapCom.put(a.OF_Comune__c.trim(),a.OF_CodiceIstat__c.trim());
                   }
                   
                   system.debug('listaComuni_selectOptions-->'+listComune.size());
                   
                   return listComune;
                }/**Chiusura else**/
              
              }else{
              system.debug('agrRes.size()->'+agrRes.size());
              return listComune;
              }
    }/**Chiusura metodo getComune()**/
    
    /**Metodo di Caricamento Servizi associati al Contratto**/
    public List<selectoption> getServiziContr()
    {
            listServizi.clear();
            List<OF_Servizio__c> servList;
                 
                 
            /**Modifica per prendere solo i Servizi associati a quel Contratto**/
            
            Set<ID> idC = new Set<ID>();
            List<OF_ContrattoServizio__c> listC = [SELECT OF_Servizio__c
                                                   FROM OF_ContrattoServizio__c
                                                   WHERE OF_Contract__c =: contr.Id];
            for( OF_ContrattoServizio__c cs : listC )
            {
                   idC.add(cs.OF_Servizio__c);
            }
            
                 
            servList = [SELECT Id,Name,OF_CatalogoCommerciale__r.Name
                        FROM OF_Servizio__c
                        WHERE Id IN: idC];
            system.debug('\nDentro getServiziContr\n');
            listServizi.add(new selectoption('--Seleziona Servizio--','--Seleziona Servizio--'));
            if( servList != null && servList.size() > 0 )
            {
                for( OF_Servizio__c a : servList )
                {
                   String s = a.Name + '-' +a.OF_CatalogoCommerciale__r.Name;
                   listServizi.add(new selectoption(a.Id,s));
                   mapServizi.put(s,a.Id);
                }
                system.debug('Dentro getServiziContr__OK');
            }
        return listServizi;
              
    }
     
      
}