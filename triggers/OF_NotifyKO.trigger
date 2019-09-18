//Trigger che mi legge la notifica di cessazione KO e mi prende i valori codice KO e descrizione KO
//DG 05-04-2017 - Aggiunto l'evento di after update per gestire quando OM non è attivo
//DG 28-06-2017 - Aggiunto controllo su univocità campo EOF_ID_Risorsa__c
trigger OF_NotifyKO on EOF_Notify__c (after insert, after update) {
/*
  try{
    if(trigger.isafter) 
    {
        map<id,EOF_Notify__c> MapNotiCase = new map<id,EOF_Notify__c>();
        map<id,EOF_Notify__c> MapNotiOrder = new map<id,EOF_Notify__c>();
                  
        list<order> ordToUpdate = new list<order>();
        integer index;
        for (EOF_notify__c noti : trigger.new){
            if(noti.Tipo_Comunicazione__c == 'Notifica di cessazione KO' && noti.EOF_Stato_Richiesta__c == 'KO'){
                MapNotiCase.put(noti.caso__c, noti);
            }
            if(noti.Tipo_Comunicazione__c == 'Notifica di acquisizione KO' && noti.EOF_Stato_Richiesta__c == 'KO'){
                MapNotiCase.put(noti.caso__c, noti);
            }
            if(noti.Tipo_Comunicazione__c == 'Notifica di espletamento'){
                index = 0;
                MapNotiCase.put(noti.caso__c, noti);
            }
        }
            
        system.debug('DG01 - MapNotiCase: ' + MapNotiCase);
    
        if(MapNotiCase.size() > 0){
            list<case> cas = new list<case>([select id, OF_Order__c, OF_Subject__c from case where id IN : MapNotiCase.keySet()]);
            system.debug('DG01 - cas: ' + cas);
        
            for(case ix : cas){
                MapNotiOrder.put(ix.OF_Order__c, MapNotiCase.get(ix.id));
            }
        
            system.debug('DG01 - MapNotiOrder: ' + MapNotiOrder);
            
            if(MapNotiOrder.size() > 0){
                list<order> ord = [select id, OF_CodiceKO__c, OF_DescrizioneKO__c, OF_IDSplitterSecondario__c, OF_PosizioneSplitterSecondario__c from order where id IN : MapNotiOrder.keySet() ]; //AND OF_Esito__c = 'KO'
                        
                system.debug('DG01 - ord: ' + ord);    
                
                for(order ix : ord){
                    ix.OF_CodiceKO__c = MapNotiOrder.get(ix.id).Codice_Rifiuto_Sospensione_Annullamento__c;
                    ix.OF_DescrizioneKO__c = MapNotiOrder.get(ix.id).Motivo_Rifiuto_Sospensione_Annullamento__c;
                    if(index == 0){
                        system.debug('DG01 - Dentro index 0');
                        ix.OF_IDSplitterSecondario__c = MapNotiOrder.get(ix.id).EOF_ID_Splitter_Secondario__c;
                        ix.OF_PosizioneSplitterSecondario__c = MapNotiOrder.get(ix.id).EOF_Posizione_Splitter_Secondario__c;
                    }
                    ordToUpdate.add(ix);
                }
            }
        }
        system.debug('DG01 - ordToUpdate: ' + ordToUpdate);
        
        if(ordToUpdate.size() > 0) update ordToUpdate;
    }
    /*
    //DG 28/07/2017 aggiunto controllo su univocità Id risorsa in fase di espletamento
    if(trigger.isBefore)
    {   
        list<EOF_Notify__c> NotifyList = new list<EOF_Notify__c>();
        for (EOF_notify__c noti : trigger.new){
            if(noti.Tipo_Comunicazione__c == 'Notifica di espletamento'){
                NotifyList.add(noti);
            }
        }
            
        if(NotifyList.size() > 0)
        {
            system.debug('DG_OF_NotifyKO - dentro if NotifyList: ' + NotifyList);
            
            //Considero solo gli asset di GPON Passiva e Risorsa
            list<asset> AssetToCompare = [select id, EOF_ID_Risorsa__c, Name from asset where (recordtype.name = 'GPON Passiva' OR recordtype.name = 'Risorsa') AND EOF_ID_Risorsa__c != null];
                        
            //ID Risorsa da comparare
            map<string, asset> RisorsaMap = new map<string, asset>();
            for(asset ass : AssetToCompare)
            {
                RisorsaMap.put(ass.EOF_ID_Risorsa__c, ass);
            }
            system.debug('DG_OF_NotifyKO - RisorsaMap: ' + RisorsaMap);
            
            list<EOF_Notify__c> NotToUpdate = new list<EOF_Notify__c>();
            for(EOF_Notify__c No : NotifyList)
            {
                system.debug('DG_OF_NotifyKO - No.OF_CheckEspletamento__c: ' + No.OF_CheckEspletamento__c);
                if(RisorsaMap.size() > 0 && No.EOF_ID_Risorsa__c != null && No.OF_CheckEspletamento__c == false)
                {
                    No.OF_CheckEspletamento__c = true;
                    if((RisorsaMap.keySet().contains(No.EOF_ID_Risorsa__c)))
                    {
                        system.debug('DG_OF_NotifyKO - dentro if errore');
                        
                        string errmessage = 'Esiste già un Asset a sistema con questo ID Risorsa: ';
                        errmessage += '<a href=\'/'+  RisorsaMap.get(No.EOF_ID_Risorsa__c).id +'\'> '+ RisorsaMap.get(No.EOF_ID_Risorsa__c).Name + '</a>'; 
                    
                        No.EOF_ID_Risorsa__c.adderror(errmessage, false);
                    }
                }
            }
        }
    }
    //END DG 28/07/2017
    */  /*
    }catch( Exception e )
    {
    OF_Utility.logMessage(true,'E',
                     'Trigger: OF_NotifyKO',
                     'sObject: EOF_Notify__c',
                     'Exception :' + e.getTypeName() + ' - ' + e.getLineNumber() + ' - ' + e.getStackTraceString() + ' - ' + e.getMessage()
                      );     
    }
    */
}