public class OF_CO_ManageOrderFromCase_ChangeOrder {
    private static Order o;
     public static void manageOrderSync(Case c){ 
       //caso in cui il case è acquisito o Modificato KO (dopo controlli asincroni)
       //in ogni caso va creato il nuovo ordine
        if(!OF_CO_GE_Utils.checkRtMap){
            OF_CO_GE_Utils.RtMap=new Map<String,String>();
            for( Recordtype rt : [SELECT Id,DeveloperName FROM Recordtype]){
                OF_CO_GE_Utils.RtMap.put( rt.DeveloperName , rt.Id );
            }
            OF_CO_GE_Utils.checkRtMap=true;
        }
        Map <string, OF_CodificaProfiloListini__c> mapCodifica = OF_CodificaProfiloListini__c.getAll();

        o = new order();
        o.RecordTypeId = OF_CO_GE_Utils.RtMap.get('OF_CHANGEORDER');
        system.debug('@@@@ EOF_Account_OLO__c: '+c.EOF_Account_OLO__c);
        o.AccountId = c.EOF_Account_OLO__c;
        if(mapCodifica.get(c.OF_SA_Profilo__c) != null)
            o.OF_Profilo__c = mapCodifica.get(c.OF_SA_Profilo__c).OF_ListinoCanoneName__c;
        o.EffectiveDate = system.Today();
        Id contractId = [SELECT OF_Contract__c 
                      FROM OF_ContrattoServizio__c 
                      WHERE OF_Contract__r.accountid=:o.AccountId 
                      AND OF_Servizio__r.name='Open Stream'
                      AND OF_Contract__r.Status = 'Attivo' LIMIT 1].OF_Contract__c;
        c.OF_IDContratto__c=contractId;
        o.ContractId=contractId;
        o.OF_CaseID__c = c.id;
        o.OF_IDRisorsa__c = c.EOF_Id_Risorsa__c; 
        o.OF_CaseNome__c=c.caseNumber;
        o.OF_TipologiaDiServizio__c = 'Change Order';
        o.OF_IDOrdineOLO__c = c.EOF_Codice_Ordine_OLO__c;
        o.OF_IDOrdineEOF__c = c.codice_ordine_EOF__c;
        o.OF_Asset__c = c.assetId;
        if(c.status=='Modificato KO'){
            o.OF_Esito__c = 'KO';
            o.OF_DataEsito__c = system.Today();
          o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
          o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;
          o.Status = 'Chiuso';
        } 
        else{
            o.Status = 'Aperto';
        }
        boolean inserito=false;
        boolean templog=false;
        Account a = new Account();  
        Templog__c t = new Templog__c();
        for(integer x=0; x<50; x++){
            try{
              if(x==0){
              insert o;
              c.OF_Order__c = o.id;
            
              if(!test.isrunningtest()){
                  inserito=true; }
              }
              //provo l'inserimento togliendo account e contract 
              if(x==1){
                a.name=c.EOF_Codice_Ordine_OLO__c;
                a.type='Temp';
                insert a;
                o.AccountId=a.Id;
                o.contractId=null;
                o.OF_AccountTemporaneo__c=c.EOF_Account_OLO__c;
                o.OF_ContractTemporaneo__c=c.OF_IDContratto__c;
                insert o;
                c.OF_Order__c = o.Id;
                inserito=true;
              }
              //non ha funzionato quindi riprovo normalmente
              if(x>1){
                o.AccountId=o.OF_AccountTemporaneo__c;
                o.contractId=o.OF_ContractTemporaneo__c;
                o.OF_AccountTemporaneo__c=null;
                o.OF_ContractTemporaneo__c=null;
                insert o;
              c.OF_Order__c = o.id;
              inserito=true; 
              }
            }  
            catch(exception e){
              if(!templog){
                t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','OF_CO_ManageOrderFromCase_ChangeOrder','manageOrderSync',(x+1), e);
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
     @future 
     public static void manageOrderAsync(String caseId){
       //caso in cui vado ad aggiornare l'ordine dopo il flusso da OM
        Case c = [select id,EOF_Id_Risorsa__c,caseNumber,assetId,EOF_Account_OLO__c,status,EOF_Codice_Ordine_OLO__c,codice_ordine_EOF__c,EOF_Codice_Errore__c,
                    EOF_Causale_Errore__c, OF_SA_Profilo__c,OF_Order__c,OF_Order__r.OF_Profilo__c,OF_IDContratto__c, 
                    (select id from Commercial_element_istanziati__r) from case where id=:caseId];
        o = new order();
        o.OF_Profilo__c=c.OF_Order__r.OF_Profilo__c;
        o.id=c.OF_Order__c;
        o.OF_DataEsito__c = system.Today();
        o.Status = 'Chiuso';
         if(c.status=='Modificato KO'){
            o.OF_Esito__c = 'KO';
          o.OF_CodiceKO__c = c.EOF_Codice_Errore__c;  
          o.OF_DescrizioneKO__c = c.EOF_Causale_Errore__c;
        }
        else{
            o.OF_Asset__c = c.assetId;
            o.OF_Esito__c = 'OK';
        }
        boolean inserito=false;
        boolean templog=false;
            Account a = new Account();  
            Templog__c t = new Templog__c();
        for(integer x=0; x<50; x++){
          try{
            if(x==0){
              update o;                
                  //Commented  as suggested by Pietro on 16012019
            if(!test.isrunningtest()){
                inserito=true;}
            }
            //provo l'aggiornamento togliendo account e contract 
          if(x==1){
                a.name=c.EOF_Codice_Ordine_OLO__c;
                a.type='Temp';
                insert a;
                o.AccountId=a.Id;
                o.contractId=null;
                o.OF_AccountTemporaneo__c=c.EOF_Account_OLO__c;
                o.OF_ContractTemporaneo__c=c.OF_IDContratto__c;
                update o;
                inserito=true;
              }
              //non ha funzionato quindi riprovo normalmente
              if(x>1){
                o.AccountId=o.OF_AccountTemporaneo__c;
                o.contractId=o.OF_ContractTemporaneo__c;
                o.OF_AccountTemporaneo__c=null;
                o.OF_ContractTemporaneo__c=null;
              update o;
            inserito=true;
            }
            }
            catch(exception e){
              if(!templog){
                t=OF_Utility.logMessageNew2(c.EOF_Codice_Ordine_OLO__c,'E','OF_CO_ManageOrderFromCase_ChangeOrder','manageOrderAsync',(x+1), e);
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
        update c;
        if(c.assetId != null){ 
            if(!test.isrunningtest()){
            OF_CO_CRM_Handler.manageAssetBillingElement(c.assetId, o);
            OF_CO_CRM_Handler.manageAssetVlan(c.assetId,c.Commercial_element_istanziati__r);
            }
        }
     }
     //metodo per bonificare le locked row che non hanno fatto creare l'ordine
     @future(callout=true)
  public static void CreaOrdineInAsincrono(String caseId){  
    Case c = [Select Id, PO_SA_Portale__c, CaseNumber, Status, EOF_ID_Risorsa__c,Codice_ordine_Eof__c, EOF_Account_OLO__c,
                EOF_Codice_Ordine_Olo__c,EOF_Codice_Operatore_WS__c,EOF_Data_Prevista_Attivazione__c,
                EOF_Data_Notifica__c, EOF_Id_Notifica__c,recordtype.developername, 
                EOF_Identificativo_del_POP__c,EOF_ID_Building_WS__c,EOF_FASE__c,
                EOF_GPON_Vincolante__c,OF_SA_Motivazione__c,OF_SA_CODICE_PROGETTO_SPECIALE__c, OF_SA_Promozione__c, 
                OF_SA_Cluster_Promozione__c, EOF_Note__c, OF_SA_Profilo__c ,OF_Bonifica_Locked_Row__c,assetId
                from Case 
                where id=:caseId];
    OF_CO_ManageOrderFromCase_ChangeOrder.manageOrderSync(c);
    update c;
  } 
  
}