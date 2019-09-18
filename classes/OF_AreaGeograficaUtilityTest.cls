@isTest
public class OF_AreaGeograficaUtilityTest {
    
    /**Questo metodo serve per creare account_olo Wind e Vodafone come dati di Test**/
    public static List<Account> createAccountOLO()
    {
        List<Account> listaAccOLO = new List<Account>();
        Account accOloVOD = new Account(); 
        Account accOloWIND = new Account();
        Account accOloTIS = new Account();
        
        String oloAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('OLO').getRecordTypeId();
        
        accOloVOD.Name = 'Vodafone';
        accOloVOD.EOF_Codice_Operatore__c = 'VF';
        accOloVOD.Type = 'OLO';
        accOloVOD.Industry = 'Telecommunications';
        accOloVOD.RecordTYpeId = oloAccountRecordTypeId ;
        
        accOloWIND.Name = 'Wind';
        accOloWIND.EOF_Codice_Operatore__c = 'WN';
        accOloWIND.Type = 'OLO';
        accOloWIND.Industry = 'Telecommunications';
        accOloWIND.RecordTYpeId = oloAccountRecordTypeId ;
        
        accOloTIS.Name = 'Tiscali';
        accOloTIS.EOF_Codice_Operatore__c = 'TIS';
        accOloTIS.Type = 'OLO';
        accOloTIS.Industry = 'Telecommunications';
        accOloTIS.RecordTYpeId = oloAccountRecordTypeId ;
       
        listaAccOLO.add(accOloVOD);
        listaAccOLO.add(accOloWIND);
        listaAccOLO.add(accOloTIS);
        if( listaAccOLO.size()>0)insert listaAccOLO;
        
       // system.debug('listaAccOLO>>'+listaAccOLO);
        return listaAccOLO;
    }
    /**Questo metodo crea dei Servizi che sono:
     * OpenStream/GPONPassiva/Extra**/
    public static List<OF_Servizio__c> createServizi()
    {
              Date myDate = Date.newInstance(2016,1,1);
              Date newDate = Date.newInstance(2099,12,31);
              OF_CatalogoCommerciale__c catalogo = new OF_CatalogoCommerciale__c();
              OF_CatalogoCommerciale__c catalogo2 = new OF_CatalogoCommerciale__c();

              catalogo.Name = 'Catalogo 1';
              catalogo.OF_Attivo__c = true;
              catalogo.OF_DataInizioValidita__c = myDate;
              catalogo.OF_DataFineValidita__c = newDate;
              insert catalogo;
       
              /**Creazione Servizi**/
              List<OF_Servizio__c> listaServizi = new List<OF_Servizio__c>();
              OF_Servizio__c GPONAttiva = new OF_Servizio__c();
              OF_Servizio__c GPONPassiva = new OF_Servizio__c();
              OF_Servizio__c Fibra = new OF_Servizio__c();
      
              GPONAttiva.Name = 'Open Stream';
              GPONAttiva.OF_Attivo__c = true;
              GPONAttiva.OF_CatalogoCommerciale__c = catalogo.Id;
              GPONAttiva.OF_DataInizioValidita__c = myDate;
              GPONAttiva.OF_DataFineValidita__c = newDate;
                         listaServizi.add(GPONAttiva);
              GPONPassiva.Name = 'GPON Passiva';
              GPONPassiva.OF_Attivo__c = true;
              GPONPassiva.OF_CatalogoCommerciale__c = catalogo.Id;
              GPONPassiva.OF_DataInizioValidita__c = myDate;
              GPONPassiva.OF_DataFineValidita__c = newDate;
                         listaServizi.add(GPONPassiva);
              Fibra.Name = 'Extra';
              Fibra.OF_Attivo__c = true;
              Fibra.OF_CatalogoCommerciale__c = catalogo.Id;
              Fibra.OF_DataInizioValidita__c = myDate;
              Fibra.OF_DataFineValidita__c = newDate;
                         listaServizi.add(Fibra);
      
              if(listaServizi != null && listaServizi.size() > 0) insert listaServizi;
              
        
        return listaServizi;  
    
    }
    /**Questo metodo fornisce una mappa tra ID-chiave e Name come value di una lista di Account**/
    public static Map<ID,String> getMappa(List<Account> accLista )
    {
        Map<ID,String> mpx = new Map<ID,String>();
        if(accLista != null && accLista.size()>0)
        {
            for(Account acc : accLista)
            {
                mpx.put(acc.Id,acc.Name);
            }
        }
        return mpx;
    }
    public static List<OF_CommercialElement__c> createCommercialElement(List<OF_Servizio__c> listServizi)
    {
        List<OF_CommercialElement__c> listCommercial = new List<OF_CommercialElement__c>();
        
        Set<ID> X = new Set<ID>();
        for( OF_Servizio__c iter : listServizi)
        {
            X.add( iter.Id );
        }
        
        List<OF_Servizio__c> ls = [select id, Name from OF_Servizio__c  where id IN : X];
       // system.debug('OSCRM listServizi : '+listServizi);
        
        Integer index = 2;
        if( listServizi != null && listServizi.size()>0 )
        {
              for( OF_Servizio__c serv : ls )
              {
              OF_CommercialElement__c GPONPassiva2;
              OF_CommercialElement__c InterventoVuoto;
              
              if( serv.Name == 'Open Stream')
              {
                OF_CommercialElement__c OpenStream = new OF_CommercialElement__c();
                OF_CommercialElement__c CPE = new OF_CommercialElement__c();
                
                  OpenStream.OF_Servizio__c = serv.id;
                  OpenStream.OF_Attivo__c=true;
                  OpenStream.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
                  OpenStream.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
                  OpenStream.Name = 'SERVIZIO OPEN STREAM BASE';
                  listCommercial.add(OpenStream);
                  
                  CPE.OF_Servizio__c = serv.id;
                  CPE.OF_Attivo__c=true;
                  CPE.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
                  CPE.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
                  CPE.Name = 'CPE';
                  listCommercial.add(CPE);
              }
              
             
              if( serv.Name == 'GPON Passiva')
              {
              GPONPassiva2 = new OF_CommercialElement__c();
              GPONPassiva2.OF_Servizio__c = serv.id;
              //system.debug('OSCRM ix:'+serv.Name);
              GPONPassiva2.OF_Attivo__c=true;
              GPONPassiva2.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              GPONPassiva2.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              GPONPassiva2.Name = 'Test';
              
              
              InterventoVuoto = new OF_CommercialElement__c();
              InterventoVuoto.OF_Servizio__c = serv.id;
              //system.debug('OSCRM ix:'+serv.Name);
              InterventoVuoto.OF_Attivo__c=true;
              InterventoVuoto.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              InterventoVuoto.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              InterventoVuoto.Name = 'Intervento a vuoto';
              }
              
              
          
              OF_CommercialElement__c itemComm = new OF_CommercialElement__c();
              itemComm.OF_Servizio__c = serv.id;
              //system.debug('OSCRM ix:'+serv.Name);
              itemComm.OF_Attivo__c=true;
              itemComm.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
              itemComm.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
              itemComm.Name = 'Test'+index;
              listCommercial.add(itemComm);
              
              
              
              if( GPONPassiva2 != null )listCommercial.add(GPONPassiva2);
              if( InterventoVuoto != null)listCommercial.add( InterventoVuoto );
              
             // system.debug('OSCRM itemComm : '+itemComm.OF_Servizio__r.Name);
              //system.debug('OSCRM itemComm : '+itemComm.OF_Servizio__r.OF_Attivo__c);
              //system.debug('OSCRM itemComm : '+itemComm.OF_Servizio__r.OF_DataFineValidita__c);
              //system.debug('OSCRM itemComm : '+itemComm.OF_Servizio__r.OF_DataInizioValidita__c);
              index++;
              }
        }
        if( listCommercial.size()>0) insert listCommercial;
        //system.debug('OSCRM listCommercial: '+listCommercial );
        return listCommercial;
    }
    /**Questo metodo crea un associazione Servizio-Contratto**/
    public static List<OF_ContrattoServizio__c> createContractService(List<Contract> contratti,List<OF_Servizio__c> servizi,Map<ID,String> accName)
    {
        List<OF_ContrattoServizio__c> listaContrattiServizi = new List<OF_ContrattoServizio__c>();
        Integer index1 = 0;
       // system.debug('OSCRM servizi:'+servizi );
        for(Contract c : contratti)
        {      
                //system.debug('--Contratti--->'+contratti);
                String OLO = accName.get(c.AccountId);
                Integer index2 = 0;
                for(OF_Servizio__c s : servizi)
                {
                   OF_ContrattoServizio__c cs = new OF_ContrattoServizio__c();
                        if(index1 == 1 && index2 == 2)break;
                        if(index1 == 3 && index2 == 1)continue;
                        cs.OF_Contract__c = c.Id;
                        cs.OF_Servizio__c = s.Id;
                        listaContrattiServizi.add(cs);
                        index2++;
                        //system.debug('OSCRM cs.OF_Servizio__r.Name : '+ cs.OF_Servizio__r.Name );
                 }
             index1++;
              
          }
        if( listaContrattiServizi!=null && listaContrattiServizi.size()>0) insert listaContrattiServizi;
        return listaContrattiServizi;
            
   }
    /**Creazione Contratti 2 con Account VOD e altri due con Account Wind**/    
    public static List<Contract> createContract(List<Account> listaOLO)
    {
         List<Contract> listaContratti = new List<Contract>();
         Contract c1vod = new Contract();
         Contract c2vod = new Contract();
         Contract c1Wind = new Contract();
         Contract c2Wind = new Contract();
         Contract c1Tisc = new Contract();
         Contract c2Tisc = new Contract();
        
         for( Account acc : listaOLO)
         {
                   /**Creazione di due Contratti con OLO Vodafone**/
                   if( acc.Name == 'Vodafone' )
                    {
                        c1vod.AccountId = acc.Id;
                        c1vod.OF_IdContratto__c = '12';
                        c1vod.StartDate = Date.newInstance(2016,1,1);
                        c1vod.ContractTerm = 1;
                        c1vod.Status = 'Attivo';
                         listaContratti.add(c1vod);
                        c2vod.AccountId = acc.Id;
                        c2vod.OF_IdContratto__c = '13';
                        c2vod.StartDate = Date.newInstance(2099,12,31); 
                        c2vod.ContractTerm = 2;
                        c2vod.Status = 'Attivo';
                         listaContratti.add(c2vod);
                     }
                     if( acc.Name == 'Wind')
                     {
                        c1Wind.AccountId = acc.Id;
                        c1Wind.OF_IdContratto__c = '14';
                        c1Wind.StartDate = System.today();
                        c1Wind.ContractTerm = 3;
                        c1Wind.Status = 'Attivo';
                         listaContratti.add(c1Wind);
                        c2Wind.AccountId = acc.Id;
                        c2Wind.OF_IdContratto__c = '15';
                        c2Wind.StartDate = System.today();
                        c2Wind.ContractTerm = 3;
                        c2Wind.Status = 'Attivo';
                         listaContratti.add(c2Wind);
                      }
                      
                      if( acc.Name == 'Tiscali')
                     {
                        c1Tisc.AccountId = acc.Id;
                        c1Tisc.OF_IdContratto__c = '16';
                        c1Tisc.StartDate = System.today();
                        c1Tisc.ContractTerm = 3;
                        c1Tisc.Status = 'Attivo';
                         listaContratti.add(c1Tisc);
                        c2Tisc.AccountId = acc.Id;
                        c2Tisc.OF_IdContratto__c = '17';
                        c2Tisc.StartDate = System.today();
                        c2Tisc.ContractTerm = 3;
                        c2Tisc.Status = 'Attivo';
                         listaContratti.add(c2Tisc);
                      }
           }/**Chiusura for()**/
        if(listaContratti != null && listaContratti.size() > 0) insert listaContratti;
        //return;
        return listaContratti;
    }
    /**Questo metodo simula un elenco di Regione-Provinca-Comune**/
    public static void getElencoComuniData()
    {
        List<OF_ElencoComuniItaliani__c> listaComuni = new List<OF_ElencoComuniItaliani__c>();
        OF_ElencoComuniItaliani__c obj1 = new OF_ElencoComuniItaliani__c();
        OF_ElencoComuniItaliani__c obj2 = new OF_ElencoComuniItaliani__c();
        OF_ElencoComuniItaliani__c obj3 = new OF_ElencoComuniItaliani__c();
        OF_ElencoComuniItaliani__c obj4 = new OF_ElencoComuniItaliani__c();
        OF_ElencoComuniItaliani__c obj5 = new OF_ElencoComuniItaliani__c();
        OF_ElencoComuniItaliani__c obj6 = new OF_ElencoComuniItaliani__c();

        obj1.OF_CodiceIstat__c = '001008';
        obj1.OF_Regione__c = 'Piemonte';
        obj1.OF_Provincia__c = 'Torino';
        obj1.OF_Comune__c = 'Alpignano';
        listaComuni.add(obj1);
        obj2.OF_CodiceIstat__c = '001010';
        obj2.OF_Regione__c = 'Piemonte';
        obj2.OF_Provincia__c = 'Torino';
        obj2.OF_Comune__c = 'Andrate';
        listaComuni.add(obj2);
        obj3.OF_CodiceIstat__c = '001022';
        obj3.OF_Regione__c = 'Piemonte';
        obj3.OF_Provincia__c = 'Torino';
        obj3.OF_Comune__c = 'Bardonecchia';
        listaComuni.add(obj3);
        obj4.OF_CodiceIstat__c = '012092';
        obj4.OF_Regione__c = 'Lombardia';
        obj4.OF_Provincia__c = 'Varese';
        obj4.OF_Comune__c = 'Luino';
        listaComuni.add(obj4);
        obj5.OF_CodiceIstat__c = '012096';
        obj5.OF_Regione__c = 'Lombardia';
        obj5.OF_Provincia__c = 'Varese';
        obj5.OF_Comune__c = 'Malnate';
        listaComuni.add(obj5);
        obj6.OF_CodiceIstat__c = 'Istat1';
        obj6.OF_Regione__c = 'Regione1';
        obj6.OF_Provincia__c = 'Provincia1';
        obj6.OF_Comune__c = 'Comune1';
        listaComuni.add(obj6);
        
       
       if( listaComuni != null && listaComuni.size()>0 ) insert listaComuni;
       return;
    }
    /**Questo metodo serve per simulare il popolamento dell'oggetto 
     * OF_AreaGeograficaCustom__c in fase di scelta Reg-Prov-Comuni**/
     public static void setAreaGeograficaCustom(String istat,String Regione,String Comune,String Provincia)
     {
         OF_AreaGeograficaCustom__c obj = new OF_AreaGeograficaCustom__c();
         obj.OF_Istat__c = istat;
         obj.OF_Regione__c = Regione;
         obj.OF_Comune__c = Comune;
         obj.OF_Provincia__c = Provincia;
         insert obj;
         
     }
     
     public static void createListini(List<OF_ServizioBillingElement__c> listServizioBilling)
     {
         
         String ListRecordTypePassId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('GPON Passiva').getRecordTypeId();
         String ListRecordTypeAttId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Open Stream').getRecordTypeId();
         String ListRecordTypeExtraId = Schema.SObjectType.OF_Listino__c.getRecordTypeInfosByName().get('Extra').getRecordTypeId();
         
         
         List<OF_Listino__c> listListini = new List<OF_Listino__c>();
         
       //  system.debug('OSCRM listServizioBilling:'+listServizioBilling );
         Integer i = 0;
         for( OF_ServizioBillingElement__c item : listServizioBilling )
         {
             OF_Listino__c listinoItem = new OF_Listino__c();
             if ( item.OF_ServizioNome__c == 'GPON Passiva'){
                
                listinoItem.RecordTypeId = ListRecordTypePassId;
                 
             }else if(item.OF_ServizioNome__c == 'Open Stream'){
                 
                 listinoItem.RecordTypeId = ListRecordTypeAttId;
                
             }else if( item.OF_ServizioNome__c == 'Extra' )
             {
                 listinoItem.RecordTypeId = ListRecordTypeExtraId;
             }
             
             listinoItem.Name = item.Name;
             listinoItem.OF_Attivo__c=true;
             listinoItem.OF_DataInizioValidita__c = Date.newInstance(1990,04,24);
             listinoItem.OF_DataFineValidita__c = Date.newInstance(2020,04,24);
             listinoItem.OF_IDContract__c = item.OF_Contract__c;
             listinoItem.OF_ServizioBillingElement__c = item.Id;
             listinoItem.OF_ListinoDefault__c = true; 
          
             listListini.add(listinoItem);
             i++;
             if( i == 7 )break;
            // break;
          }
         if( listListini != null && listListini.size()>0) insert listListini;
         //system.debug('OSCRM listListini[0].RecordType.Name'+listListini[0].RecordType.Name );
         
         Set<ID> ids2 = new Set<ID>();
         for( OF_Listino__c obj : listListini )
         {
              ids2.add( obj.Id );
         }
         //system.debug('OSCRM lISTINI:'+[select id,recordtypeID,recordtype.Name from OF_Listino__c where id in : ids2]);
         
         //system.debug('OS30 listListini : '+listListini);
        
     }
    /**Questo metodo crea dei BillingElement**/
    public static List<OF_BillingElement__c> createBillingElement(List<OF_CommercialElement__c> listaCommercial)
    {
              List<OF_BillingElement__c> listBilling =new List<OF_BillingElement__c>();
              Integer index = 0;
              for( OF_CommercialElement__c item : listaCommercial)
              {
                 
                  OF_BillingElement__c billElem = new OF_BillingElement__c();
                  if( index == 0) billElem.Name = 'Canone';
                  if( index == 1) billElem.Name = 'Canone Premium';
                  if( index == 2) billElem.Name = 'Contributo Disattivazione';
                  if( index == 3) billElem.Name = 'Contributo attivazione';
                  if( index == 5) billElem.Name = 'Contributo istallazione';
                  if( index == 6) billElem.Name = 'Contributo Consegna';
                  if( index == 7) billElem.Name = 'Contributo ritiro';
                  else billElem.Name = 'Canone';
                  //if( index > 4) break;
                  billElem.OF_Attivo__c = true;
                  //if( item.Name == 'Test3')
                  billElem.OF_CommercialElement__c = item.Id;
                  billElem.OF_DataInizioValidita__c = Date.newInstance(2016,1,1);
                  billElem.OF_DataFineValidita__c = Date.newInstance(2099,12,31);
                  listBilling.add(billElem);
                  
                  //system.debug('OSCRM BE.OF_CommercalElement__r.OF_Servizio__c'+billElem.OF_CommercialElement__r.OF_Servizio__c);
                  
                  
                  index++;
              }
           if(listBilling != null && listBilling.size() > 0) insert listBilling;
           return listBilling;
    }
     /**Questo metodo crea dei ServiziBillingElement**/
    public static List<OF_ServizioBillingElement__c> createServiziBillingElement(List<OF_BillingElement__c> listBilling,List<OF_ContrattoServizio__c> listContrServ)
    {
        List<OF_ServizioBillingElement__c> listServBilling = new List<OF_ServizioBillingElement__c>();
       
        
            for( OF_ContrattoServizio__c item : listContrServ)
            {
               // system.debug('oscrm item:'+item.OF_Servizio__c);
                for( OF_BillingElement__c item1 : listBilling)
                 {
                    
                      OF_ServizioBillingElement__c obj = new OF_ServizioBillingElement__c();
                      obj.Name = item1.Name;
                      obj.OF_BillingElement__c = item1.Id;
                      obj.OF_Contract__c = item.OF_Contract__c;
                      obj.OF_Servizio__c = item.OF_Servizio__c;
                      //system.debug('OSCRM item.OF_Servizio__r.Name : '+item.OF_Servizio__r.Name);
                      //system.debug('OSCRM OF_ServizioBillingElement__c obj : '+ obj );
                      listServBilling.add(obj);
                  }
             }
         if( listServBilling != null & listServBilling.size() > 0 ) insert listServBilling;
         
         Set<ID> ids = new Set<ID>();
         for( OF_ServizioBillingElement__c obj : listServBilling) ids.add( obj.Id );
         
         List<OF_ServizioBillingElement__c> listSBE = [SELECT id,Name,OF_Contract__c,OF_Servizio__c,OF_ServizioNome__c,OF_BillingElement__r.name
                                                       FROM OF_ServizioBillingElement__c
                                                       WHERE Id IN : ids];
         return listSBE;
         
         //return listServBilling;
        
    }
      
    /**Questo metodo crea delle notifiche associate ad un caso**/
    public static List<EOF_Notify__c> createNotify(case c)
    {
        list<EOF_Notify__c> notifyList = new list<EOF_Notify__c>();
        
        EOF_Notify__c noti = new EOF_Notify__c();
        noti.Caso__c = c.id;
        noti.Motivo_Rifiuto_Sospensione_Annullamento__c = 'Scala non collegabile RFA';
        noti.EOF_Inviata__c = false;
        
        notifyList.add(noti);
        if(notifyList != null && notifyList.size() > 0) insert notifyList;
        return notifyList;
    }
    
    /**Questo metodo crea delle network inventory associate ad un caso**/
    public static List<EOF_Network_Inventory__c> createNetworkInventory(case c)
    {
        list<EOF_Network_Inventory__c> NetInvList = new list<EOF_Network_Inventory__c>();
        
        EOF_Network_Inventory__c NetInv = new EOF_Network_Inventory__c();
            NetInv.EOF_ID_Building__c = c.EOF_ID_Building_WS__c;
            NetInv.EOF_Pop__c = c.EOF_Identificativo_del_POP__c;
            NetInv.EOF_Comune__c = '20141';
        NetInvList.add(NetInv);
        
        EOF_Network_Inventory__c NetInv1 = new EOF_Network_Inventory__c();
            NetInv1.EOF_ID_Building__c = '987654321';
            NetInv1.EOF_Pop__c = c.EOF_Identificativo_del_POP__c;
            NetInv1.EOF_Comune__c = '20000';
        NetInvList.add(NetInv1);
        
        if(NetInvList != null && NetInvList.size() > 0) insert NetInvList;
        return NetInvList;
    }
    
    /**Questo metodo crea il CustomSetting OF_CaseOrderStateModelCS__c**/
    public static list<OF_CaseOrderStateModelCS__c> CustomSetting()
    {
    list<OF_CaseOrderStateModelCS__c> CustSettList = new list<OF_CaseOrderStateModelCS__c>();
    String OrderRecordTypeAttId = Schema.SObjectType.order.getRecordTypeInfosByName().get('INORDER').getRecordTypeId();
    String OrderRecordTypeCessId = Schema.SObjectType.order.getRecordTypeInfosByName().get('OUTORDER').getRecordTypeId();
    String OrderRecordTypeTTId = Schema.SObjectType.order.getRecordTypeInfosByName().get('TROUBLE TICKET').getRecordTypeId();
    String OrderRecordTypeCOId = Schema.SObjectType.order.getRecordTypeInfosByName().get('CHANGE ORDER').getRecordTypeId();
    String CaseRecordTypeAttId = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso - Attivazione').getRecordTypeId();
    String CaseRecordTypeCessId = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF Caso - Cessazione').getRecordTypeId();
    String CaseRecordTypettId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Trouble Ticket').getRecordTypeId();
    String CaseRecordTypeAttOSId = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Attivazione_OPENSTREAM').getRecordTypeId();
    String CaseRecordTypeCessOSId = Schema.SObjectType.case.getRecordTypeInfosByName().get('EOF_Caso_Cessazione_OPENSTREAM').getRecordTypeId();
    /*DG 25/07/2017 commentato perchè il portalino non va portato*/
    String CaseRecordTypePortP2P = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine P2P').getRecordTypeId();
    //String CaseRecordTypePortEventTemp = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine Evento Temporaneo').getRecordTypeId();
    String CaseRecordTypePortIRU = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine IRU').getRecordTypeId();
    String CaseRecordTypePortFibLink = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine Fiber Link').getRecordTypeId();
    String CaseRecordTypePortFinLease = Schema.SObjectType.case.getRecordTypeInfosByName().get('PO Ordine Fiber Lease').getRecordTypeId();
    
    OF_CaseOrderStateModelCS__c CustSett = new OF_CaseOrderStateModelCS__c(
        Name = '0001',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Acquisito',
        OF_StatoOrder__c = 'Aperto',
        OF_EsitoOrder__c = '',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett);
        
     OF_CaseOrderStateModelCS__c CustSett1 = new OF_CaseOrderStateModelCS__c(
        Name = '0002',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Acquisito',
        OF_StatoOrder__c = 'Aperto',
        OF_EsitoOrder__c = '',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett1);

    OF_CaseOrderStateModelCS__c CustSett2 = new OF_CaseOrderStateModelCS__c(
        Name = '0004',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Espletato',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'OK',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        /*DG 25/07/2017 commentato perchè il portalino non va portato*/
        PO_RecordTypeCaseOrdineP2P__c = CaseRecordTypePortP2P,
       // PO_RecordTypeCaseOrdineEventoTemporaneo__c = CaseRecordTypePortEventTemp,
        PO_RecordTypeCaseOrdineIRU__c = CaseRecordTypePortIRU,
        PO_RecordTypeCaseOrdineFiberLink__c = CaseRecordTypePortFibLink,
        PO_RecordTypeCaseOrdineFiberLease__c = CaseRecordTypePortFinLease,
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett2);
    
    OF_CaseOrderStateModelCS__c CustSett3 = new OF_CaseOrderStateModelCS__c(
        Name = '0005',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Accettato KO',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett3);
            
    OF_CaseOrderStateModelCS__c CustSett4 = new OF_CaseOrderStateModelCS__c(
        Name = '0006',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Espletato KO',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        /*DG 25/07/2017 commentato perchè il portalino non va portato
        PO_RecordTypeCaseOrdineP2P__c = CaseRecordTypePortP2P,
        PO_RecordTypeCaseOrdineEventoTemporaneo__c = CaseRecordTypePortEventTemp,
        PO_RecordTypeCaseOrdineIRU__c = CaseRecordTypePortIRU,
        PO_RecordTypeCaseOrdineFiberLink__c = CaseRecordTypePortFibLink,
        PO_RecordTypeCaseOrdineFiberLease__c = CaseRecordTypePortFinLease,*/
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett4);
    
    OF_CaseOrderStateModelCS__c CustSett5 = new OF_CaseOrderStateModelCS__c(
        Name = '0007',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Annullato',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        /*DG 25/07/2017 commentato perchè il portalino non va portato
        PO_RecordTypeCaseOrdineP2P__c = CaseRecordTypePortP2P,
        PO_RecordTypeCaseOrdineEventoTemporaneo__c = CaseRecordTypePortEventTemp,
        PO_RecordTypeCaseOrdineIRU__c = CaseRecordTypePortIRU,
        PO_RecordTypeCaseOrdineFiberLink__c = CaseRecordTypePortFibLink,
        PO_RecordTypeCaseOrdineFiberLease__c = CaseRecordTypePortFinLease,*/
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett5);

    OF_CaseOrderStateModelCS__c CustSett6 = new OF_CaseOrderStateModelCS__c(
        Name = '0008',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Cessato OK',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'OK',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett6);
        
    OF_CaseOrderStateModelCS__c CustSett7 = new OF_CaseOrderStateModelCS__c(
        Name = '0009',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Cessato KO',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett7);        
        
    OF_CaseOrderStateModelCS__c CustSett8 = new OF_CaseOrderStateModelCS__c(
        Name = '0010',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Annullato',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = false
    );
        CustSettList.add(CustSett8);    

    OF_CaseOrderStateModelCS__c CustSett9 = new OF_CaseOrderStateModelCS__c(
        Name = '0014',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Acquisito',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett9);

    OF_CaseOrderStateModelCS__c CustSett10 = new OF_CaseOrderStateModelCS__c(
        Name = '0015',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Acquisito KO',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett10);
        
    OF_CaseOrderStateModelCS__c CustSett11 = new OF_CaseOrderStateModelCS__c(
        Name = '0016',
        OF_TipologiaFlusso__c = 'Attivazione',
        OF_StatoCase__c = 'Acquisito KO',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeAttId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeAttOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeAttId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett11);
        
    OF_CaseOrderStateModelCS__c CustSett12 = new OF_CaseOrderStateModelCS__c(
        Name = '0017',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Cessato KO',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'KO',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett12);
        
    OF_CaseOrderStateModelCS__c CustSett13 = new OF_CaseOrderStateModelCS__c(
        Name = '0018',
        OF_TipologiaFlusso__c = 'Cessazione',
        OF_StatoCase__c = 'Cessato',
        OF_StatoOrder__c = 'Chiuso',
        OF_EsitoOrder__c = 'OK',
        OF_RecordTypeCasePassivo__c = CaseRecordTypeCessId,
        OF_RecordTypeCaseAttivo__c = CaseRecordTypeCessOSId,
        OF_RecordTypeOrder__c = OrderRecordTypeCessId,
        OF_FaseDiCreazione__c = true
    );
        CustSettList.add(CustSett13);
    
        //system.debug('DG-Test - CustSettList: ' + CustSettList);
     if(CustSettList.size() > 0 && CustSettList != null)    insert CustSettList;
     return CustSettList;
    }
    
    /**Questo metodo crea il CustomSetting OF_CaseOrderStateModelCS__c**/
    public static list<OF_CodificaProfiloListini__c> CustomSetting2()
    {
        list<OF_CodificaProfiloListini__c> CustSettList = new list<OF_CodificaProfiloListini__c>();
        
        OF_CodificaProfiloListini__c CS = new OF_CodificaProfiloListini__c(
        name = 'AA_01',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_20_5',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_20_5'
        );
        CustSettList.add(CS);
        
        OF_CodificaProfiloListini__c CS1 = new OF_CodificaProfiloListini__c(
        name = 'AB_01',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_100_20',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_100_20'
        );
        CustSettList.add(CS1);
        
        OF_CodificaProfiloListini__c CS2 = new OF_CodificaProfiloListini__c(
        name = 'AC_04',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_100_100',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_100_100'
        );
        CustSettList.add(CS2);
        
        OF_CodificaProfiloListini__c CS3 = new OF_CodificaProfiloListini__c(
        name = 'AD_01',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_200_30',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_200_30'
        );
        CustSettList.add(CS3);
        
        OF_CodificaProfiloListini__c CS4 = new OF_CodificaProfiloListini__c(
        name = 'AE_03',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_300_100',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_300_100'
        );
        CustSettList.add(CS4);
        
        OF_CodificaProfiloListini__c CS5 = new OF_CodificaProfiloListini__c(
        name = 'AF_03',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_500_100',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_500_100'
        );
        CustSettList.add(CS5);
        
        OF_CodificaProfiloListini__c CS6 = new OF_CodificaProfiloListini__c(
        name = 'AG_03',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_1000_300',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_1000_300'
        );
        CustSettList.add(CS6);
        
        OF_CodificaProfiloListini__c CS7 = new OF_CodificaProfiloListini__c(
        name = 'AH_12',
        OF_ProfiloCommerciale__c = 'OPENSTREAM_1000_500',
        OF_ListinoCanoneName__c = 'OPSTR_001_CAN_1000_500'
        );
        CustSettList.add(CS7);
                
        insert CustSettList;
        return CustSettList;
    }
    
    /**Metodo che associa ad ogni contratto delle aree geografiche**/
    public static void createAreaGeoJunction(list<Contract> contr, list<OF_Servizio__c> listServizi)
    {
        OF_Servizio__c servi = new OF_Servizio__c();
        for(OF_Servizio__c ser : listServizi){
            if (ser.name == 'GPON Passiva'){
                servi = ser;
                break;
            }
        }
        
        OF_AreaGeograficaCustom__c AreaGeoCustom = new OF_AreaGeograficaCustom__c();
        AreaGeoCustom.OF_Comune__c = 'Milano';
        AreaGeoCustom.OF_Istat__c = '20141';
        insert AreaGeoCustom;
        
        list<OF_AreaGeograficaJunction__c> AreaGeoJunction = new list<OF_AreaGeograficaJunction__c>();
        
        for(contract c : contr){
            OF_AreaGeograficaJunction__c AGJ = new OF_AreaGeograficaJunction__c();
            AGJ.OF_Contratto__c = c.Id;
            AGJ.OF_AreaGeografica__c = AreaGeoCustom.Id;
            AGJ.Servizio__c = servi.Id;
            AreaGeoJunction.add(AGJ);
        }
        if(AreaGeoJunction.size() > 0 && AreaGeoJunction != null) insert AreaGeoJunction;
    }
    /**Modifica 04_04_2017 Errore 11:53:05:000 FATAL_ERROR caused by: System.DmlException: Insert failed. First exception on row 0; first error: STANDARD_PRICE_NOT_DEFINED, 
     * No standard price defined for this product: []
     * Creazione Standard Price per i Dati di Test**/
    public static void createPriceBookStandard(List<Product2> listProd)
    {
      list<pricebookentry> StndPBEList = new list<pricebookentry>();
 
      ID id = Test.getStandardPricebookId();
      PriceBook2 pb2 = new PriceBook2();
      pb2.Id=id;
      update pb2;
      
       // if(StndPBList.size()>0){
         for(product2 p2 : listProd){
             pricebookentry pbe = new pricebookentry(
                 UnitPrice = 1,
                 IsActive = true,
                 Product2ID = p2.id,
                 Pricebook2ID = pb2.id  //pricebook standard
             );
             StndPBEList.add(pbe);
            }
         //system.debug('DG - StndPBEList ' + StndPBEList);
         if(StndPBEList.size()>0)        insert StndPBEList;
     
    }
    
    /*Questo metodo associa ad un case un asset**/
    public static void AssetToCase(case cas)
    {
        asset ass = new asset();
        ass.AccountId = cas.EOF_Account_OLO__c;
        ass.EOF_ID_Risorsa__c = 'risorsa';
        ass.Name = 'risorsa';
        
        insert ass;
        
        cas.AssetId = ass.Id;
    }
    
    /*Questo metodo associa ad un case un ordine**/
    public static void OrderToCase(case cas)
    {
        order ord = new order();
        ord.AccountId = cas.EOF_Account_OLO__c;
        ord.EffectiveDate = date.today();
        ord.status = 'Aperto';
        ord.OF_CaseID__c = cas.id;
        ord.ContractId = cas.OF_IDContratto__c;
        insert ord;
        
        cas.OF_Order__c = ord.Id;
    }
    
    public static OF_Configurazioni__c CustomSetting1()
    {
    OF_Configurazioni__c CustSett = new OF_Configurazioni__c();
        CustSett.Name = '001';
        CustSett.DataSwitchOM__c = datetime.newInstance(2017, 01, 01, 00, 00, 0);
        CustSett.OF_ServizioExtraName__c = 1;
        insert CustSett;
        return CustSett;
    }
    
    public static Parametri_Fattibilita__c CustomSetting3()
    {
    Parametri_Fattibilita__c CustSett = new Parametri_Fattibilita__c();
        CustSett.Name = 'Default';
        CustSett.Fascia1__c = 1;
        CustSett.Fascia2__c = 2;
        CustSett.Fascia3__c = 3;
        CustSett.Fascia4__c = 5;
        CustSett.Fascia5__c = 10;
        insert CustSett;
        return CustSett;
    }
    
    //21/09/2017 Modifica
    public static list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustomSettingFibLease()
    {
        list<OF_FiberLeaseListinoPrezzoAnnuo__c> CustSettList = new list<OF_FiberLeaseListinoPrezzoAnnuo__c>();
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs1 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '1',
            Anno__c = '2030',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs1);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs2 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '2',
            Anno__c = '2029',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs2);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs3 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '3',
            Anno__c = '2028',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs3);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs4 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '4',
            Anno__c = '2027',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs4);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs5 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '5',
            Anno__c = '2026',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs5);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs6 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '6',
            Anno__c = '2025',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs6);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs7 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '7',
            Anno__c = '2024',
            Prezzo__c = 2.5
        );
        CustSettList.add(cs7);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs8 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '8',
            Anno__c = '2023',
            Prezzo__c = 2.63
        );
        CustSettList.add(cs8);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs9 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '9',
            Anno__c = '2022',
            Prezzo__c = 2.79
        );
        CustSettList.add(cs9);
                
        OF_FiberLeaseListinoPrezzoAnnuo__c cs10 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '10',
            Anno__c = '2021',
            Prezzo__c = 3.10
        );
        CustSettList.add(cs10);
                
        OF_FiberLeaseListinoPrezzoAnnuo__c cs11 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '11',
            Anno__c = '2020',
            Prezzo__c = 3.41
        );
        CustSettList.add(cs11);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs12 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '12',
            Anno__c = '2019',
            Prezzo__c = 3.72
        );
        CustSettList.add(cs12);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs13 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '13',
            Anno__c = '2018',
            Prezzo__c = 4.03
        );
        CustSettList.add(cs13);
        
        OF_FiberLeaseListinoPrezzoAnnuo__c cs14 = new OF_FiberLeaseListinoPrezzoAnnuo__c(
            name = '14',
            Anno__c = '2017',
            Prezzo__c = 4.65
        );
        CustSettList.add(cs14);
        
        insert CustSettList;
        return CustSettList;
    }
    
    public static list<OF_FiberLeasePrezzoMedioAnnuo__c> CustomSettingFibLease1()
    {
        list<OF_FiberLeasePrezzoMedioAnnuo__c> CustSettList = new list<OF_FiberLeasePrezzoMedioAnnuo__c>();
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Backbone1',
            Prezzo__c = 0.34
        );
        CustSettList.add(cs);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs1 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Backbone2',
            Prezzo__c = 0.34
        );
        CustSettList.add(cs1);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs2 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Drop1',
            Prezzo__c = 2.63
        );
        CustSettList.add(cs2);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs3 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Drop2',
            Prezzo__c = 2.63
        );
        CustSettList.add(cs3);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs4 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'Drop2AltreCoppie',
            Prezzo__c = 0.84
        );
        CustSettList.add(cs4);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs5 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'CostanteFiberLease1',
            Prezzo__c = 0.08
        );
        CustSettList.add(cs5);
        
        OF_FiberLeasePrezzoMedioAnnuo__c cs6 = new OF_FiberLeasePrezzoMedioAnnuo__c(
            name = 'CostanteFiberLease2',
            Prezzo__c = 0.55
        );
        CustSettList.add(cs6);
            
        insert CustSettList;
        return CustSettList;
    }
    //21/09/2017 END Modifica    
    
    /**Creazione PriceBookEntry di Test**/
    public static void createPriceBookEntry( List<Product2> listaProduct2 , List<PriceBook2> listaPriceBook2 ,ID assetID)
    {
        List<PriceBookEntry> listaPriceBookEntry = new List<PriceBookEntry>();
        
        Map<Id,PriceBook2> mapPriceBook2 = new Map<Id,PriceBook2>();
        for( PriceBook2 pr2 : listaPriceBook2 ) mapPriceBook2.put( pr2.OF_Listino__c , pr2 );
        
        //system.debug('OSCRM mapPriceBook2: '+ listaPriceBook2);
        //system.debug('OSCRM mapPriceBook2: '+ mapPriceBook2);
        
        for( Product2 prod : listaProduct2)
        {
            PriceBookEntry prE = new PriceBookEntry();
            prE.Product2Id = prod.Id;
            //system.debug('OSCRM mapPriceBook2: '+ mapPriceBook2.get( prod.OF_ListinoCustom__c ).Id);
            
            prE.Pricebook2Id = mapPriceBook2.get( prod.OF_ListinoCustom__c ).Id;
            prE.OF_Asset__c = assetID;
            prE.UnitPrice = -9.999;
            //pricebook2.IsActive = true;
            listaPriceBookEntry.add( prE );
            
        }
        insert listaPriceBookEntry;
        //system.debug('OSCRM listaPriceBookEntryNONSTANDARD:'+listaPriceBookEntry);
        return;
    }
    /**Creazione CommercialElement Istanziati sotto l'Asset**/
    public static void createCEistanziatiSottoAsset(Asset asset  , String Servizio)
    {

        List<OF_Servizio__c> listServ = [select id,Name,(select id,Name from CommercialElements__r) from OF_Servizio__c where Name =: Servizio ];
        List<OF_CommercialElement__c> listCEist = listServ[0].CommercialElements__r;
        
        OF_CommercialElementIStanziato__c obj = new OF_CommercialElementIStanziato__c();
        obj.OF_Asset__c = asset.Id;
        obj.OF_CommercialElement__c = listCEist[0].Id;
        insert obj;
    }
    
}/**Chiusura Classe**/