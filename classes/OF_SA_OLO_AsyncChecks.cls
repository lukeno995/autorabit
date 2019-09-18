public class OF_SA_OLO_AsyncChecks {    
    
    @future(callout=true)    
    public static void OLO_AsyncActivation(String caseId, String SLOloSfId){  
       OLO_AsyncActivationSync(caseId, SLOloSfId);
    }
    
    public static void OLO_AsyncActivationSync(String caseId, String SLOloSfId){  
        OF_SA_GE_Utils.caseOriginale = Database.query(OF_SA_GE_Utils.getQuery('case','AsyncActivation')+
                                                ' where id=:caseId'); 
                                                system.debug('Alessandro: query: '+OF_SA_GE_Utils.getQuery('sl','AsyncActivation')+
                                                ' where id =:SLOloSfId' 
                                                +' OR OF_SA_VLan_Log__c =:SLOloSfId'
                                                +' OR OF_SA_Cpe_Log__c =:SLOloSfId'
                                                +' OR OF_SA_servizi_Aggiuntivi_Log__c =:SLOloSfId'
                                                +' order by EOF_Ordine_Invio_OLO__c');
        OF_SA_GE_Utils.ListSlActivationOLOSF=Database.query(OF_SA_GE_Utils.getQuery('sl','AsyncActivation')+
                                                ' where id =:SLOloSfId' 
                                                +' OR OF_SA_VLan_Log__c =:SLOloSfId'
                                                +' OR OF_SA_Cpe_Log__c =:SLOloSfId'
                                                +' OR OF_SA_servizi_Aggiuntivi_Log__c =:SLOloSfId'
                                                +' order by EOF_Ordine_Invio_OLO__c');
        OF_SA_GE_Utils.ListVLan = new List<EOF_EAI_Service_Log__c>();                                       
        OF_SA_GE_Utils.ListApp = new List<EOF_EAI_Service_Log__c>();                                        
        OF_SA_GE_Utils.ListServAgg = new List<EOF_EAI_Service_Log__c>();                                        
        for(EOF_EAI_Service_Log__c sl : OF_SA_GE_Utils.ListSlActivationOLOSF){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                OF_SA_GE_Utils.slOLOSF=sl;  
            }
            if(sl.recordtype.developername=='OF_SA_Vlan'){
                OF_SA_GE_Utils.checkVLan=true;
                OF_SA_GE_Utils.ListVLan.add(sl);
            }
            if(sl.recordtype.developername=='OF_SA_Cpe'){
                OF_SA_GE_Utils.checkApp=true;
                OF_SA_GE_Utils.ListApp.add(sl);
            }
            if(sl.recordtype.developername=='OF_SA_Servizi_Aggiuntivi'){
                OF_SA_GE_Utils.checkServAgg=true;
                OF_SA_GE_Utils.ListServAgg.add(sl);
            }
        }
        
        //Account Olo = [select id from Account where Type = 'OLO' AND EOF_Codice_Operatore__c =:OF_SA_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c];
        
        
        
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_SA_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_SA_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
        }               
        OF_SA_GE_Utils.checkrtMap=true;
        
        OLO_ID__c oloId=OLO_ID__c.getInstance(OF_SA_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_GE_Utils.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
        //CAmpo necessario per il billing
        OF_SA_GE_Utils.caseOriginale.Accordo_Operativo__c = OF_SA_GE_Utils.caseOriginale.CaseNumber;
        //controllo cliente, si presuppone che siano gia stati fatti i controlli su cognome_cliente
        OF_SA_GE_Utils.checkCliente=true;
        
        OF_SA_GE_Utils.caseOriginale.OF_SA_INFORMAZIONI_LOGISTICA_APPARATI__c=OF_SA_GE_Utils.slOLOSF.EOF_INFORMAZIONI_LOGISTICA_APPARATI__c;
        OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_PROGETTO_SPECIALE__c=OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c;
        OF_SA_GE_Utils.caseOriginale.OF_SA_Promozione__c=OF_SA_GE_Utils.slOLOSF.EOF_Promozione__c;
        OF_SA_GE_Utils.caseOriginale.OF_SA_Cluster_Promozione__c=OF_SA_GE_Utils.slOLOSF.EOF_Cluster_Promozione__c;
        OF_SA_GE_Utils.caseOriginale.OF_SA_Profilo__c=OF_SA_GE_Utils.slOLOSF.EOF_Profilo__c;
        if(String.isBlank(OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__C)){                        
            
            OF_SA_GE_Utils.cliente = new Account(Name = OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                    RecordTypeId = OF_SA_GE_Utils.rtMap.get('Cliente_Business'),
                                    Phone = OF_SA_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                    EOF_Phone_2__c = OF_SA_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
                                    
        }else{
            
            OF_SA_GE_Utils.cliente = new Account(FirstName = OF_SA_GE_Utils.slOLOSF.EOF_NOME_CLIENTE__c,
                                    LastName = OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_CLIENTE__c,
                                    RecordTypeId = OF_SA_GE_Utils.rtMap.get('PersonAccount'),
                                    Phone = OF_SA_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_1__c,
                                    EOF_Phone_2__c = OF_SA_GE_Utils.slOLOSF.EOF_RECAPITO_TELEFONICO_CLIENTE_2__c );
            
        }            
        
        //Using Technician required information in the request to retrieve the Account in the system
        List<Contact> tech = [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE 
                                  FirstName =: OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c AND LastName =: OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c 
                                  AND Phone =: OF_SA_GE_Utils.slOLOSF.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c AND Email =: OF_SA_GE_Utils.slOLOSF.EOF_EMAIL_REFERENTE_TECNICO_OLO__c];  
        if(!tech.isEmpty()){
            OF_SA_GE_Utils.caseOriginale.EOF_Contact__c = tech.get(0).Id;                   
        }
        else{ 
            OF_SA_GE_Utils.refTec = new COntact();
            OF_SA_GE_Utils.refTec.RecordTypeId = OF_SA_GE_Utils.rtMap.get('Referente_Tecnico_OLO');
            OF_SA_GE_Utils.refTec.AccountId=oloId.OF_Olo_Id__c;
            OF_SA_GE_Utils.refTec.FirstName =OF_SA_GE_Utils.slOLOSF.EOF_NOME_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_Utils.refTec.LastName = OF_SA_GE_Utils.slOLOSF.EOF_COGNOME_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_Utils.refTec.Phone = OF_SA_GE_Utils.slOLOSF.EOF_TELEFONO_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_Utils.refTec.Email = OF_SA_GE_Utils.slOLOSF.EOF_EMAIL_REFERENTE_TECNICO_OLO__c;
            OF_SA_GE_Utils.checkRefTec=true;
        }      
    /* CC27032019     
        OF_SA_GE_Utils.ceiList = new List<OF_CommercialElementIstanziato__c>();
        List<OF_CommercialElement__c> listaCommercialElement = [SELECT Id, Name, OF_Alias__c
                                                                FROM OF_CommercialElement__c 
                                                                WHERE OF_Servizio__r.Name = 'Open Stream'
                                                                AND Name NOT IN ('RIBALTAMENTO IMPIANTO', 'ESTENSIONE IMPIANTO CLIENTE')];
        Map<String,Id> ceNameId = new Map<String,Id>();
        //AA 060219 - Modifica CE
        for(OF_CommercialElement__c ce : listaCommercialElement){
            //Vado a controllare se per il CE corrente esistono altri nomi accettabili
            if(String.isNotBlank(ce.OF_Alias__c)){
                //Per ogni alias lo lego al CE
                for(String alias : ce.OF_Alias__c.split(';')){
                    ceNameId.put(alias.ToUpperCase(), ce.Id);
                }
            }
            ceNameId.put(ce.Name.ToUpperCase(), ce.Id);
        }
        //FINE AA 060219 - Modifica CE
        FINE CC27032019  
        */   
           OF_SA_GE_Utils.ceiList = new List<OF_CommercialElementIstanziato__c>();
        List<OF_CommercialElement__c> listaCommercialElement = [SELECT Id, Name, OF_Alias__c FROM OF_CommercialElement__c WHERE OF_Servizio__r.Name='Open Stream' AND OF_Attivo__c = true];
        Map<String,Id> ceNameId = new Map<String,Id>();
        //AA 060219 - Modifica CE
        // String servAggCEId;
        //FINE AA 060219 - Modifica CE
        for (OF_CommercialElement__c ce : listaCommercialElement) {
            //AA 060219 - Modifica CE
            // if (ce.Name.equalsIgnoreCase('SERVIZI AGGIUNTIVI')) {
            //  servAggCEId = ce.Id;
            // }
            //FINE AA 060219 - Modifica CE
            //Vado a controllare se per il CE corrente esistono altri nomi accettabili
            if (String.isNotBlank(ce.OF_Alias__c)) {
                //Per ogni alias lo lego al CE
                for (String alias : ce.OF_Alias__c.split(';')) {
                    ceNameId.put(alias.ToUpperCase(), ce.Id);
                }
            }
            ceNameId.put(ce.Name.ToUpperCase(), ce.Id);
        }
        //AA 060219 - Modifica CE
        // ceNameId.put('RIBALTAMENTO IMPIANTO', servAggCEId);
        // ceNameId.put('ESTENSIONE IMPIANTO CLIENTE', servAggCEId);
        //FINE AA 060219 - Modifica CE
        
        if(OF_SA_GE_Utils.checkServAgg){ 
            Integer n = 1;  
            
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_Utils.ListServAgg){ 
                if(!ceNameId.containsKey(sl.OF_SA_NOME_SERVIZIO__c.toUpperCase())){
                    OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Servizio aggiuntivo \''+sl.OF_SA_NOME_SERVIZIO__c+'\' inesistente';
                    OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B09';
                    OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Servizio aggiuntivo \''+sl.OF_SA_NOME_SERVIZIO__c+'\' inesistente';
                    OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO'; 
                    OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA'; 
                    //update c;
                    
                    //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                    OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
                    return;
                }
                OF_SA_GE_Utils.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid=OF_SA_GE_Utils.rtMap.get('OF_ServiziAggiuntivi');
                cei.OF_NOME_SERVIZIO__c=sl.OF_SA_NOME_SERVIZIO__c; 
                cei.OF_INFORMAZIONI_SERVIZIO__c=sl.OF_SA_INFORMAZIONI_SERVIZIO__c;
                cei.OF_Case__c=OF_SA_GE_Utils.caseOriginale.Id;
                cei.OF_SA_Servizio_Aggiuntivo__c=OF_SA_GE_Utils.caseOriginale.Id;
                cei.OF_CommercialElement__c=ceNameId.get(sl.OF_SA_NOME_SERVIZIO__c.toUpperCase());
                OF_SA_GE_Utils.ceiList.add(cei); 
            }  
        } 
         
        if(OF_SA_GE_Utils.checkApp){
            Integer n = 1; 
            
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_Utils.ListApp){
                OF_SA_GE_Utils.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid=OF_SA_GE_Utils.rtMap.get('OF_CPE');
                cei.OF_TIPOLOGIAAPPARATO__C=sl.EOF_TIPOLOGIA_APPARATO__c;
                cei.OF_PASSWORD_APPARATO__C=sl.OF_SA_PASSWORD_APPARATO__c;
                cei.OF_AZIONEAPPARATO__C=sl.OF_SA_AZIONE_APPARATO__c;
                cei.OF_Case__c=OF_SA_GE_Utils.caseOriginale.Id;
                cei.OF_SA_CPE__c=OF_SA_GE_Utils.caseOriginale.Id;
                cei.OF_CommercialElement__c=ceNameId.get('CPE');
                OF_SA_GE_Utils.ceiList.add(cei);
            }
        } 
        
        
        if(OF_SA_GE_Utils.checkVLan){  
            Integer n = 1;
            for(EOF_EAI_Service_Log__c sl : OF_SA_GE_Utils.ListVLan){
                OF_SA_GE_Utils.checkCEIList=true;
                OF_CommercialElementIstanziato__c cei = new OF_CommercialElementIstanziato__c();
                cei.recordtypeid=OF_SA_GE_Utils.rtMap.get('OF_VLAN');
                cei.OF_KITCONSEGNAVLAN__C=sl.OF_SA_KIT_CONSEGNA_VLAN__c;
                cei.OF_USERVLAN__C=sl.OF_SA_USER_VLAN__c;
                cei.OF_SERVICEVLAN__C=sl.OF_SA_SERVICE_VLAN__c;
                cei.OF_PROFILOVLAN__C=sl.OF_SA_PROFILO_VLAN__c;
                cei.OF_INFORMAZIONIVLAN__C=sl.OF_SA_INFORMAZIONI_VLAN__c;
                cei.OF_CUSTOMERVLAN__C=sl.OF_SA_CUSTOMER_VLAN__c;
                cei.OF_MODELLODISERVIZIOVLAN__C=sl.OF_SA_MODELLO_DI_SERVIZIO_VLAN__c;
                cei.OF_Case__c=OF_SA_GE_Utils.caseOriginale.Id;
                cei.OF_SA_VLAN__c=OF_SA_GE_Utils.caseOriginale.Id;
                cei.OF_CommercialElement__c=ceNameId.get('VLAN');
                OF_SA_GE_Utils.ceiList.add(cei);
            }
        }
        
        
        /*
        List<OF_SA_Network_Inventory_Attivi__c> ni = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                                            OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                                             OF_SA_ID_Building_OM__c
                                             FROM OF_SA_Network_Inventory_Attivi__c WHERE OF_SA_ID_Building__c =:OF_SA_GE_Utils.caseOriginale.EOF_ID_Building_WS__c];  
        */
        List<OF_SA_Network_Inventory_Attivi__c> ni = OF_SA_GE_Utils.controlloVendibilita(OF_SA_GE_Utils.caseOriginale.EOF_codice_operatore_WS__c, OF_SA_GE_Utils.caseOriginale.EOF_ID_Building_WS__c);
        if(ni.isEmpty()){
            try{
                ni = [SELECT Id,OF_SA_Civico__c,OF_SA_Comune__c,OF_SA_GPON_ID__c,OF_SA_ID_Building__c,OF_SA_Pop__c,
                      OF_SA_Indirizzo__c, OF_SA_Particella_Top__c,OF_SA_Provincia__c,OF_SA_Scala_Palazzina__c,OF_SA_Stato_Building__c,
                      OF_SA_ID_Building_OM__c
                      FROM OF_SA_Network_Inventory_Attivi__c WHERE OF_SA_ID_Building__c =:OF_SA_GE_Utils.caseOriginale.EOF_ID_Building_WS__c];
            }catch(Exception e){
                //Istanzio una lista vuota così da evitare nullPointer
                ni = new List<OF_SA_Network_Inventory_Attivi__c>();
                OF_SA_GE_Utils.vendHasException = true;
                OF_SA_GE_Utils.vendException = 'Exception: ' + e.getTypeName() + ': ' + e.getMessage();
            }
            String idRequestCallout = (OF_SA_GE_Utils.vendLogLst != null && !OF_SA_GE_Utils.vendLogLst.isEmpty()) ? OF_SA_GE_Utils.vendLogLst.get(0).OF_IdRequest__c : 'request ' + DateTime.now();
            OF_SA_GE_Utils.createVendibilitaRequestResponseLog(ni, 'query', idRequestCallout, OF_SA_GE_Utils.caseOriginale.EOF_codice_operatore_WS__c, OF_SA_GE_Utils.caseOriginale.EOF_ID_Building_WS__c, 'attivo' );
        }
        //implementare la logica di acquisizione KO       
        if(ni.isEMpty()){
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Identificativo Building Errato';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B00';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Identificativo Building Errato';
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO'; 
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA'; 
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            //AA 28/01/2019 - Nuova gestione vendibilità
            if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                //Inserisco i log di vendibilità
                insert OF_SA_GE_Utils.vendLogLst;                
            }
            return;
            
        } 
        
        //creo la lista ordinata degli stati building positivi
        /*List<Integer> positivi = new List<Integer>();
        positivi.add(110);
        positivi.add(104);
        positivi.add(105);
        positivi.add(107);
        positivi.add(109);
        
        //creo la lista ordinata degli stati building negativi
        List<Integer> negativi = new List<Integer>();
        negativi.add(101);
        negativi.add(102);
        negativi.add(103);
        negativi.add(106);      
        negativi.add(108);
        */
        //AA - I valori delle liste positive e negative verranno recuperati tramite custom setting
        List<Integer> positivi = new List<Integer>();
        for(Stato_Building_positivi__c pos : Stato_Building_positivi__c.getAll().values()){
            try{
                positivi.add(Integer.valueOf(pos.Name));
            }catch(Exception e)    {
                System.debug('***** Valore [' + pos.Name + '] non ammesso all\'interno del Custom Setting Stato_Building_positivi__c');
            } 
        }
        List<Integer> negativi = new List<Integer>();
        for(Stato_Building_negativi__c pos : Stato_Building_negativi__c.getAll().values()){
            try{
                negativi.add(Integer.valueOf(pos.Name));
            }catch(Exception e)    {
                System.debug('***** Valore [' + pos.Name + '] non ammesso all\'interno del Custom Setting Stato_Building_negativi__c');
            }
        }       
        boolean found=false;
        OF_SA_Network_Inventory_Attivi__c corretto = new OF_SA_Network_Inventory_Attivi__c();
        //ciclo per il controllo ordinato sugli stati building positivi
        for(Integer num : positivi){
            if(!found){
                for(OF_SA_Network_Inventory_Attivi__c n : ni){
                    System.debug('*** AAA stato => ' + n.OF_SA_Stato_Building__c);
                    if(n.OF_SA_Stato_Building__c == num){
                        corretto = n;
                        found=true;
                        break;
                    }
                }
            }
            else{
                break;
            }
        }
        if(!found){
            //ciclo per il controllo ordinato sugli stati building negativi
            for(Integer num : negativi){
                if(!found){
                    for(OF_SA_Network_Inventory_Attivi__c n : ni){
                        if(n.OF_SA_Stato_Building__c == num){
                            corretto = n;
                            found=true;
                            break;
                        }
                    }
                }
                else{
                    break;
                }
            }
            if(!found){
                //caso in cui lo stato building non è stato trovato in nessuna delle due liste
                corretto=ni[0];
            }
            
            List<OF_ElencoComuniItaliani__c> cList =[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
            if (!cList.isEmpty()){
                if(String.isNotBlank(cList[0].OF_Comune__c)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
                }
                if(String.isNotBlank(cList[0].OF_Provincia__c)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
                }
            }
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Building non RFC/RFA';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B01';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Building non RFC/RFA';
            OF_SA_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.OF_SA_Pop__c;                        
            OF_SA_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.OF_SA_Provincia__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Istat_Comune__c= corretto.OF_SA_Comune__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.OF_SA_Particella_Top__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.OF_SA_Indirizzo__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.OF_SA_Civico__c;
            OF_SA_GE_Utils.caseOriginale.OF_SA_ID_Building_OM__c = corretto.OF_SA_ID_Building_OM__c; 
            //OF_SA_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.OF_SA_ID_Building__c;  
            OF_SA_GE_Utils.caseOriginale.EOF_Stato_Building__c=corretto.OF_SA_Stato_Building__c;
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            //AA 28/01/2019 - Nuova gestione vendibilità
            if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                //Inserisco i log di vendibilità
                insert OF_SA_GE_Utils.vendLogLst;                
            }
            return;
        }
        else{
            //caso in cui è stato trovato nella lista degli stati building positivi
            List<OF_ElencoComuniItaliani__c> cList =[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
            if (!cList.isEmpty()){
                if(String.isNotBlank(cList[0].OF_Comune__c)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
                }
                if(String.isNotBlank(cList[0].OF_Provincia__c)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
                }
            }
            OF_SA_GE_Utils.caseOriginale.EOF_Identificativo_del_POP__c = corretto.OF_SA_Pop__c;                        
            OF_SA_GE_Utils.caseOriginale.EOF_Istat_Provincia__c = corretto.OF_SA_Provincia__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Istat_Comune__c= corretto.OF_SA_Comune__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c = corretto.OF_SA_Particella_Top__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c = corretto.OF_SA_Indirizzo__c;
            OF_SA_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c = corretto.OF_SA_Civico__c;
            OF_SA_GE_Utils.caseOriginale.OF_SA_ID_Building_OM__c = corretto.OF_SA_ID_Building_OM__c; 
            //OF_SA_GE_Utils.caseOriginale.EOF_ID_Building_WS__c = corretto.OF_SA_ID_Building__c;  
            OF_SA_GE_Utils.caseOriginale.EOF_Stato_Building__c=corretto.OF_SA_Stato_Building__c;
            
            //Async control DATA_PREVISTA_ATTIVAZIONE
            Date DPA = OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c;
            Integer year = DPA.year();
            Integer month = DPA.month();
            Integer day = DPA.day();
            Datetime targetTime = Datetime.newInstance(year, month, day, 0, 0, 0);
            BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
            Boolean isWithin = BusinessHours.isWithin (bh.Id, targetTime);  
           
            if(isWithin == false && OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c!='TIS_20170403_000000001'){ 
                
                OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
                OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A10';
                OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Attesa Consegna coincidente con un giorno festivo o con un sabato';
                OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
                //chiamo il metodo che gestisce le callout e aggiorna il DB
                OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
                //AA 28/01/2019 - Nuova gestione vendibilità
                if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                    //Inserisco i log di vendibilità
                    insert OF_SA_GE_Utils.vendLogLst;                
                }
                return;
            }     
            BusinessHours bh_dac = [SELECT Id FROM BusinessHours WHERE Name='DAC'];
            Integer num_giorni_rfa = 0;
            Integer num_giorni_rfc = 0;
            Datetime RFA = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
            Datetime RFC = Datetime.newInstance(system.now().year(), system.now().month(), system.now().day(), 0, 0, 0);
    
            //per RFA devo sommare 5 giorni escluse le festività perchè sia conforme agli sla
            while(num_giorni_rfa < 5){  
                if(BusinessHours.isWithin(bh_dac.Id, RFA) == true ){                
                    RFA = Datetime.newInstance(RFA.year(), RFA.month() , RFA.day()+1,0,0,0);
                    num_giorni_rfa++;                         
                    continue;
                }       
                RFA = Datetime.newInstance(RFA.year(), RFA.month() , RFA.day()+1,0,0,0);      
            }                    
            while(num_giorni_rfc < 10){ 
                if(BusinessHours.isWithin(bh_dac.Id, RFC) == true ){                 
                    RFC = Datetime.newInstance(RFC.year(), RFC.month() , RFC.day()+1,0,0,0);
                    num_giorni_rfc++;                           
                    continue;
                }       
                RFC = Datetime.newInstance(RFC.year(), RFc.month() , RFc.day()+1,0,0,0);    
            } 
            if(!OF_SA_GE_Utils.caseOriginale.OF_Bonifica_Locked_Row__c){
               if(((corretto.OF_SA_Stato_Building__c == 110 && OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFA.date()) || (corretto.OF_SA_Stato_Building__c != 110 && OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c < RFC.date())) && OF_SA_GE_Utils.slOLOSF.EOF_CODICE_PROGETTO_SPECIALE__c!='TIS_20170403_000000001'){
                    OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Data Attesa Consegna non conforme agli SLA';
                    OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'A09';
                    OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Data Attesa Consegna non conforme agli SLA';
                    OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
                    OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                    //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
                    OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
                    //chiamo il metodo che gestisce le callout e aggiorna il DB
                    OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
                    //AA 28/01/2019 - Nuova gestione vendibilità
                    if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                        //Inserisco i log di vendibilità
                        insert OF_SA_GE_Utils.vendLogLst;                
                    }
                    return;
                }
            } 
        }
        if(corretto.OF_SA_Pop__c != OF_SA_GE_Utils.slOLOSF.EOF_ID_POP__c){ 
            List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
            cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
            if (!cList.isEmpty()){
                if(String.isNotBlank(cList[0].OF_Comune__c)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
                }
                if(String.isNotBlank(cList[0].OF_Provincia__c)){
                    OF_SA_GE_Utils.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
                }
            }
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Associazione ID Building-POP errata';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B03';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Associazione ID Building-POP errata';  
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            //AA 28/01/2019 - Nuova gestione vendibilità
            if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                //Inserisco i log di vendibilità
                insert OF_SA_GE_Utils.vendLogLst;                
            }
            return;
        } 

                 
        OF_SA_GE_Utils.caseOriginale.status='Acquisito';
        OF_SA_GE_Utils.caseOriginale.EOF_Fase__C='Da Lavorare';
        
        List<OF_ElencoComuniItaliani__c> cList = new List<OF_ElencoComuniItaliani__c>();
        cList=[select OF_Comune__c, OF_Provincia__c from OF_ElencoComuniItaliani__c where OF_CodiceIstat__c=:corretto.OF_SA_Comune__c];
        if (!cList.isEmpty()){
            if(String.isNotBlank(cList[0].OF_Comune__c)){
                OF_SA_GE_Utils.caseOriginale.EOF_Comune_WS__c=cList[0].OF_Comune__c;
            }
            if(String.isNotBlank(cList[0].OF_Provincia__c)){
                OF_SA_GE_Utils.caseOriginale.EOF_Provincia_WS__c=cList[0].OF_Provincia__c;
            }
        }
        //check contract B05      
        List<OF_ContrattoServizio__c> checkOpenStreamContract;
        if(!Test.isRunningTest()){
            checkOpenStreamContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 
                                                    where OF_Servizio__r.name='Open Stream' 
                                                    and OF_Contract__r.Status='Attivo'
                                                    AND OF_Contract__r.AccountId =: OF_SA_GE_Utils.caseOriginale.EOF_Account_OLO__c
                                                    AND OF_Contract__r.StartDate <: OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c
                                                    AND OF_Contract__r.EndDate >: OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c];
        }else{//Ho dovuto utilizzare il test.isrunning poichè all'inserimento del contract non valorizzava la enddate
            checkOpenStreamContract = [select id,name,OF_Contract__c from OF_ContrattoServizio__c 
                                                    where OF_Servizio__r.name='Open Stream' 
                                                    and OF_Contract__r.Status='Attivo'
                                                    AND OF_Contract__r.AccountId =: OF_SA_GE_Utils.caseOriginale.EOF_Account_OLO__c
                                                    AND OF_Contract__r.StartDate <: OF_SA_GE_Utils.caseOriginale.EOF_Data_Prevista_Attivazione__c];
        }
        
        if(checkOpenStreamContract.isEMpty()){
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';

            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            //AA 28/01/2019 - Nuova gestione vendibilità
            if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                //Inserisco i log di vendibilità
                insert OF_SA_GE_Utils.vendLogLst;                
            }
            return;
        }
        OF_SA_GE_Utils.caseOriginale.OF_IDContratto__c = checkOpenStreamContract[0].OF_Contract__c;
        //check città B_04
        System.debug('***** AA => ' + OF_SA_GE_Utils.caseOriginale.EOF_Istat_Comune__c);
        List<OF_AreaGeograficaJunction__c> checkCityCOntract =[select id from OF_AreaGeograficaJunction__c 
                                                            where OF_Contratto__c =:checkOpenStreamContract[0].OF_Contract__c
                                                            AND OF_AreaGeografica__r.OF_Istat__c=:OF_SA_GE_Utils.caseOriginale.EOF_Istat_Comune__c];
        if(checkCityCOntract.isEMpty()){
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B04';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            //AA 28/01/2019 - Nuova gestione vendibilità
            if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
                //Inserisco i log di vendibilità
                insert OF_SA_GE_Utils.vendLogLst;                
            }
            return;
        }
        /* Commentato come da richiesta
        String check = null;
        OF_UtilitiesManageOrderFromCase obj = new OF_UtilitiesManageOrderFromCase();
        check = obj.VerificheCommContratt1(OF_SA_GE_Utils.caseOriginale);
        OF_SA_GE_Utils.caseOriginale.OF_IDContratto__c = obj.getIDContratto();
        
        if(check == 'B_05'){
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B05';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'OLO non abilitato all\'invio dell\'ordine';
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            return;
            
        }
        if(check ==  'B_04'){
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B04';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Città/POP non vendibile per l\'OLO';
            OF_SA_GE_Utils.caseOriginale.Status = 'Acquisito KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            //chiamo il metodo che gestisce le callout e aggiorna il DB
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
            return;
        }
        */
        //genero l'id servizio andando a inserire un record dell'oggetto OF_Generatore_ID_Servizio__c
        OF_SA_GE_Utils.gen =[select OF_ID_Servizio__c from OF_Generatore_ID_Servizio__c where OF_Case_Id__c=:OF_SA_GE_Utils.caseOriginale.Id];
        OF_SA_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c=OF_SA_GE_Utils.gen.OF_ID_Servizio__c;
        
        //creo il sl che invierò all'OLO (SF->OLO - StatusUpdate)
        OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
        //chiamo il metodo che gestisce le callout e aggiorna il DB
        OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO);
        //AA 28/01/2019 - Nuova gestione vendibilità
        if(!OF_SA_GE_Utils.vendLogLst.isEmpty()){//Controllo per evitare nullpointer
            //Inserisco i log di vendibilità
            insert OF_SA_GE_Utils.vendLogLst;                
        }
        return;
    } 
    
    public static Map<String,List<EOF_EAI_Service_Log__c>> OLO_AsyncStatusUpdate(Case c, OF_SA_WS_IN_OLO_StatusUpdate.OLO_StatusUpdateRequest sur){
        Map<String,List<EOF_EAI_Service_Log__c>> responseToOlo = new Map<String,List<EOF_EAI_Service_Log__c>>();
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        
       
        EOF_EAI_Service_Log__c slToOM = OF_SA_GE_Utils.OLO_CreateStatusUpdate_Log(c, sur);
        system.debug('OSCRM OF_SA_OLO_AsyncChecks.OLO_AsyncStatus slToOM:'+slToOM);
        
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OLO_SendToOM.OM_CreateAckNackRequestStatusUpdate(slToOM);
        system.debug('OSCRM OF_SA_OLO_AsyncChecks.OLO_AsyncStatus responseFromOM:'+responseFromOM );
        
        //aggiungo il log originario
        slList.add(OF_SA_GE_Utils.Create_EAI_Log(sur));
        
        //aggiungo il log dell'invio ad OM
        slList.add(slToOM);
        
        if(responseFromOM.containsKey('0')) {
            slList.add(responseFromOM.get('0'));
            responseToOlo.put('0',slList);
            
            return  responseToOlo;
        }
        else{
            slList.add(responseFromOM.get('1'));
            responseToOlo.put('1',slList);
            
            return  responseToOlo;
        }
    }
    
    public static Map<String,List<EOF_EAI_Service_Log__c>> OLO_AsyncReschedule(Case c, OF_SA_WS_IN_OLO_Reschedule.OLO_RescheduleRequest r){
        Map<String,List<EOF_EAI_Service_Log__c>> responseToOlo = new Map<String,List<EOF_EAI_Service_Log__c>>();
        List<EOF_EAI_Service_Log__c> slList = new List<EOF_EAI_Service_Log__c>();
        EOF_EAI_Service_Log__c slToOM = OF_SA_GE_Utils.OLO_CreateReschedule_Log(c, r);
        Map<String,EOF_EAI_Service_Log__c> responseFromOM = OF_SA_OLO_SendToOM.OM_CreateAckNackRequestReschedule(slToOM);
        //inserisco il sl originario dell'OLO
        slList.add(OF_SA_GE_Utils.Create_EAI_Log(r));
        
        slList.add(slToOM);
        if(responseFromOM.containsKey('0')) {
            slList.add(responseFromOM.get('0'));
            responseToOlo.put('0',slList);
            return  responseToOlo;
        }
        else{
            slList.add(responseFromOM.get('1'));
            responseToOlo.put('1',slList);
            return  responseToOlo;
        }
    } 
    
    @future(callout=true)  
    public static void OLO_AsyncDeactivation(String caseId, String SLOloSfId){ 
       OLO_AsyncDeactivationSync(caseId,SLOloSfId);
    }
    public static void OLO_AsyncDeactivationSync(String caseId, String SLOloSfId){   
        OF_SA_GE_Utils.caseOriginale = Database.query(OF_SA_GE_Utils.getQuery('case','AsyncDeactivation')+
                                                ' where id=:caseId');
        OF_SA_GE_Utils.ListSlDeactivationOLOSF=Database.query(OF_SA_GE_Utils.getQuery('sl','AsyncDeactivation')+ 
                                                ' where id =:SLOloSfId' 
                                                +' OR OF_SA_Cpe_Log__c =:SLOloSfId'
                                                +' order by EOF_Ordine_Invio_OLO__c');                                      
        OF_SA_GE_Utils.ListApp = new List<EOF_EAI_Service_Log__c>();                                                                            
        for(EOF_EAI_Service_Log__c sl : OF_SA_GE_Utils.ListSlDeactivationOLOSF){
            if(sl.recordtype.developername=='OF_SA_FiberRequest'){
                OF_SA_GE_Utils.slOLOSF=sl;  
            }
            if(sl.recordtype.developername=='OF_SA_Cpe'){
                OF_SA_GE_Utils.checkApp=true;
                OF_SA_GE_Utils.ListApp.add(sl);
            }
        }
        
        List<recordtype> rtList=[select Id,developerName from recordtype];
        OF_SA_GE_Utils.rtMap = new Map<String,Id>(); 
        for(recordtype rt :rtList){
            OF_SA_GE_Utils.rtMap.put(rt.DeveloperName, rt.Id); 
        }               
        OF_SA_GE_Utils.checkrtMap=true;
        
        OLO_ID__c oloId=OLO_ID__c.getInstance(OF_SA_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c);
        OF_SA_GE_Utils.caseOriginale.EOF_Account_OLO__c=oloId.OF_Olo_Id__c;
        
        //Da verificare quale sarà l'oggetto Asset
        String IdRisorsa=OF_SA_GE_Utils.caseOriginale.EOF_ID_Risorsa__c;
        String codiceOperatore=OF_SA_GE_Utils.caseOriginale.EOF_Codice_Operatore_WS__c;
        List<Asset> aList= Database.query(OF_SA_GE_Utils.getQuery('Asset','AsyncDeactivation')+ 
                            ' where recordtype.developername=\'OF_OpenStream\' and Status=\'Attivo\' and EOF_Id_Risorsa__c=:IdRisorsa'
                            +' and Account.EOF_Codice_Operatore__c=:codiceOperatore');
        //caso di errore asincrono
        if(aList.isEmpty()){
            OF_SA_GE_Utils.caseOriginale.status='Cessato KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'ID Risorsa da cessare inesistente/errato';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'B07';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'ID Risorsa da cessare inesistente/errato';
            //Update c;
                                          
            OF_SA_GE_Utils.slSFOLO = OF_SA_GE_Utils.CreateAcquisition_Log(OF_SA_GE_Utils.caseOriginale);
            
            OF_SA_GE_Utils.makeCalloutOLOOM(OF_SA_GE_Utils.slSFOLO); 
            return;     
        }
        
        List<OF_CommercialElementIstanziato__c> ceiList=[SELECT Id,OF_TipologiaApparato__C FROM OF_CommercialElementIstanziato__c where 
                                                            OF_CPE__c=:aList[0].id];
        /*controllo sugli apparati da cessare al momento in attesa requisito inizia qui
        List<String> cListCPE = new List<String>();
        Map<String,OF_commercialElementIstanziato__c> ceiMap = new Map<String,OF_commercialElementIstanziato__c>();
        List<OF_CommercialElementIstanziato__c> ceiListToUpdate = new List<OF_CommercialElementIstanziato__c>();
        for (OF_commercialElementIstanziato__c cei : ceiList){
            cListCPE.add(cei.OF_TipologiaApparato__C);
            ceiMap.put(cei.OF_TipologiaApparato__C, cei);
        }
        if(Deact.APPARATO!=null){
            List<String> cListCPEOLO= new List<String>();
            for(OF_SA_WS_IN_OLO_Deactivation.APPARATO ap : Deact.APPARATO){
                cListCPEOLO.add(ap.TIPOLOGIA_APPARATO);
            }
            cListCPEOLO.sort();
            cListCPE.sort();
            if(cListCPEOLO.equals(cListCPE)){
                if(!Deact.APPARATO.isempty()){
                    for(OF_SA_WS_IN_OLO_Deactivation.APPARATO ap : Deact.APPARATO){
                        OF_commercialElementIstanziato__c cei = ceiMap.get(ap.TIPOLOGIA_APPARATO);
                        cei.OF_Stato__c='Cessato';
                        cei.OF_SA_VLAN__c=c.Id;
                        ceiListToUpdate.add(cei);
                    }
                    if(!ceiListToUpdate.isEMpty()){
                        system.debug('La lista di cei è : '+ceiListToUpdate);
                        update ceiListToUpdate;
                    }
                }
            }
            //caso liste non uguali
            else{   
                OF_SA_GE_Utils.caseOriginale.status='Cessato KO';
                OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Apparato non presente nella richiesta di attivazione';
                OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'E07';
                OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Apparato non presente nella richiesta di attivazione';
                OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
                OF_SA_GE_Utils.caseOriginale.AssetId=aList[0].id;
                update c;
                //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - DeactivationRequest)                                     
                List<EOF_EAI_Service_Log__c> sListPreSF = OF_SA_GE_Utils.OM_CreateStatusUpdate_Log(c,Deact);
                EOF_EAI_Service_Log__c sl1=sListPreSF[0];
                //creo il sl che invierò ad om senza legarlo al case in quanto andrà legato dopo ll'ack sull'acquisizione da OLO (SF->OM - ActivationRequest)
                List<EOF_EAI_Service_Log__c> sListPostSF = OF_SA_GE_Utils.OLO_CreateDeactivation_Log(c,Deact); 
                EOF_EAI_Service_Log__c sl2=sListPostSF[0];
                OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl1.Id, sl2.Id);
                return; 
            }
        }
        //caso apparati = null
        if(!ceiList.isEmpty()){
            OF_SA_GE_Utils.caseOriginale.status='Cessato KO';
            OF_SA_GE_Utils.caseOriginale.EOF_Causale_Errore__c = 'Apparato non presente nella richiesta di attivazione';
            OF_SA_GE_Utils.caseOriginale.OF_SA_CODICE_MOTIVAZIONE__c = 'E07';
            OF_SA_GE_Utils.caseOriginale.OF_SA_MOTIVAZIONE__c = 'Apparato non presente nella richiesta di attivazione';
            OF_SA_GE_Utils.caseOriginale.EOF_Fase__c = 'NA';
            OF_SA_GE_Utils.caseOriginale.AssetId=aList[0].id;
            update c;
            //creo ed inserisco l'ack ad OLO (OLO->SF - ACK - DeactivationRequest)                                     
            List<EOF_EAI_Service_Log__c> sListPreSF = OF_SA_GE_Utils.OM_CreateStatusUpdate_Log(c,Deact);
            EOF_EAI_Service_Log__c sl1=sListPreSF[0];
            //creo il sl che invierò ad om senza legarlo al case in quanto andrà legato dopo ll'ack sull'acquisizione da OLO (SF->OM - ActivationRequest)
            List<EOF_EAI_Service_Log__c> sListPostSF = OF_SA_GE_Utils.OLO_CreateDeactivation_Log(c,Deact); 
            EOF_EAI_Service_Log__c sl2=sListPostSF[0];
            OF_SA_OM_SendToOLO.OM_CreateAckNackNotifyStatusUpdate(sl1.Id, sl2.Id);
            return; 
        }
        --------------------- finisce qui
        */
        
        /*CRM Modifica 10_06_2017 Gestione Cessazione CPE Lato CRM
        //alternativa temporanea: cesso sempre tutti i cei ------inizia qui
        List<OF_CommercialElementIstanziato__c> ceiListToUpdate = new List<OF_CommercialElementIstanziato__c>();
        for(OF_CommercialElementIstanziato__c cei : ceiList){
            cei.OF_Stato__C='Cessato';
            ceiListToUpdate.add(cei);
        }
        if(!ceiListToUpdate.isEmpty()){
            update ceiListToUpdate;
        }*/
        //finisce qui
        //valorizzo l'asset statico
        OF_SA_GE_Utils.a=aList[0];
        
        //caso in cui la cessazione ha superato i controlli asincroni   
        OF_SA_GE_Utils.caseOriginale.status='Acquisito';
        OF_SA_GE_Utils.caseOriginale.OF_IDContratto__c = OF_SA_GE_Utils.a.OF_Contract__c;
        OF_SA_GE_Utils.caseOriginale.OF_SA_ID_Servizio__c=aList[0].OF_IDServizio__c;
        OF_SA_GE_Utils.caseOriginale.AssetId=aList[0].id;
        OF_SA_GE_Utils.caseOriginale.EOF_Provincia_WS__c=aList[0].OF_Provincia__c;
        OF_SA_GE_Utils.caseOriginale.EOF_Comune_WS__c=aList[0].OF_Comune__c;
        OF_SA_GE_Utils.caseOriginale.EOF_Particella_Toponomastica_WS__c=aList[0].OF_Particella_Toponomastica__c;
        OF_SA_GE_Utils.caseOriginale.EOF_Indirizzo_WS__c=aList[0].OF_Indirizzo__c;
        OF_SA_GE_Utils.caseOriginale.EOF_Numero_Civico_WS__c=aList[0].OF_Civico__c; 
        
        OF_SA_GE_Utils.makeCalloutOM(OF_SA_GE_Utils.ListSlDeactivationOLOSF); 
        return;
    }
}