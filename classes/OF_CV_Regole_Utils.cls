public class OF_CV_Regole_Utils {

    public static String ESITO_OK = 'OK';
    public static String ESITO_KO = 'KO';
    public static String nome_Regola = '';    

    public static OF_CV_WS_Schema_Get_Vendibilita.GetVendibilitaResponseType getVendibilitaByWs(String OLO,String SERVIZIO){
        OF_CV_WS_Get_Vendibilita.GetVendibilitaEndpoint stub = new OF_CV_WS_Get_Vendibilita.GetVendibilitaEndpoint();
        stub.timeout_x=30000;
        OF_CV_WS_Schema_Get_Vendibilita.GetVendibilitaResponseType response = new OF_CV_WS_Schema_Get_Vendibilita.GetVendibilitaResponseType();
        String id_req = String.valueOf(DateTime.now().getTime());
        response = stub.GetVendibilita(id_req, OLO, SERVIZIO.toUpperCase());
        system.debug('@@@@@@@@@@@@@@@@@> ' +  response.ESITO + ' - ' + response.MOTIVAZIONE + '  - ' + response.CODICE_MOTIVAZIONE );
        if(response != null){
           EOF_CV_TRACCIAMENTO_VENDIBILITA__c tracciato = new EOF_CV_TRACCIAMENTO_VENDIBILITA__c();
           tracciato.olo__c = OLO;
           tracciato.Servizio__c = SERVIZIO;
           tracciato.email__c = userInfo.getUserEmail();
           tracciato.esito__c = response.ESITO;
           tracciato.Id_request__c = id_req;
           insert tracciato;
        }
        return response;
    }
    public static OF_CV_WS_Schema_Get_PopComuni.GetPopResponseType getPopByWs(){
        OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint stub = new OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint();
        stub.timeout_x=30000; 
        OF_CV_WS_Schema_Get_PopComuni.GetPopResponseType response = new OF_CV_WS_Schema_Get_PopComuni.GetPopResponseType();
        response = stub.GetPop(String.valueOf(DateTime.now().getTime()));
        //return response.LISTA_POP.POP;
		return response;
    }
    
    public static List<String> getComuniPopByWs(List<String> popSelezionati){
        List<String> popcomuni_formatted = new List<String>();
        OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint stub = new OF_CV_WS_Get_PopComuni.GetPopComuniEndpoint();
        stub.timeout_x=30000; 
        OF_CV_WS_Schema_Get_PopComuni.GetComuniFromPopResponseType response = new OF_CV_WS_Schema_Get_PopComuni.GetComuniFromPopResponseType();
        OF_CV_WS_Schema_Get_PopComuni.ListaPopType listPops = new OF_CV_WS_Schema_Get_PopComuni.ListaPopType();
        listPops.POP = popSelezionati;
        
        response = stub.GetComuniFromPop(String.valueOf(DateTime.now().getTime()), listPops);
        List<OF_CV_WS_Schema_Get_PopComuni.POP_COMUNE_element> lstPopComuneToFormat = new List<OF_CV_WS_Schema_Get_PopComuni.POP_COMUNE_element>();
        
        lstPopComuneToFormat = response.LISTA_POPCOMUNI.POP_COMUNE;
        
        for(OF_CV_WS_Schema_Get_PopComuni.POP_COMUNE_element x : lstPopComuneToFormat){
            popcomuni_formatted.add(x.POP + '/' + x.COMUNE);
        }
        return popcomuni_formatted;
    }
    public static String writeRulesByWs(List<OF_CV_Regole_Vendita__c> lstRegole){
        OF_CV_WS_WriteRules.WriteRulesEndpoint stub = new OF_CV_WS_WriteRules.WriteRulesEndpoint();
        stub.timeout_x=30000;
        OF_CV_WS_Schema_WriteRules.WriteRulesResponseType response = new OF_CV_WS_Schema_WriteRules.WriteRulesResponseType();
        OF_CV_WS_Schema_WriteRules.LISTA_RIGHE_REGOLA_element listaRigheRegole = new OF_CV_WS_Schema_WriteRules.LISTA_RIGHE_REGOLA_element();
        listaRigheRegole.RIGA = new List<OF_CV_WS_Schema_WriteRules.RIGA_element>();
        for(OF_CV_Regole_Vendita__c rule : lstRegole){
            OF_CV_WS_Schema_WriteRules.RIGA_element tmp = new OF_CV_WS_Schema_WriteRules.RIGA_element();
            tmp.ID_RIGA = String.valueOf(rule.Riga__c);
            tmp.OLO = rule.Codice_OLO__c;
            tmp.SERVIZIO = rule.Servizio__c;
            tmp.POP = rule.Pop__c;
            tmp.COMUNE = rule.Comune__c;
            tmp.STATO = rule.Stato__c;
            tmp.ATTIVA = String.valueOf(rule.isAttiva__c);
            tmp.BLACKLIST = String.valueOf(rule.isBlacklist__c);
            tmp.ID_BUILDING_BLACKLIST = rule.Id_Building_BL_WS__c;
            tmp.ID_SCALA_BLACKLIST = rule.Id_Scala_BL_WS__c;
            tmp.CODICE_STRADA_BLACKLIST = rule.Codice_strada_BL_WS__c;
            tmp.WHERE_CONDITION = rule.WhereCondition__c;

            listaRigheRegole.RIGA.add(tmp);
        }
        response = stub.WriteRules(String.valueOf(DateTime.now().getTime()), lstRegole.get(0).Id_Regola__c, listaRigheRegole);
        System.debug('response.ESITO :'+response.ESITO);
        System.debug('response.MOTIVAZIONE :'+response.MOTIVAZIONE);
        System.debug('response.CODICE_MOTIVAZIONE :'+response.CODICE_MOTIVAZIONE);
        
        return response.ESITO;
    }
    public static String inserisciRegola(Boolean isComunePop, List<String> popOrComune, String olo, String servizio, String stato, String buildingBL, String idScalaBL, String codStradaBL, Boolean isBozza){
        try{
            //Lista di regole che andrò ad inserire alla fine
            List<OF_CV_Regole_Vendita__c> listRegole = new List<OF_CV_Regole_Vendita__c>();
            //Progressivo per identificare le regole
            Integer n = 0;
            //Done AA: richiamo al metodo di Pietro!!!
            system.debug('>>>>>>>>NomeRegola');
            String id_regola = '';
            if (nome_Regola != null && String.isNotBlank(nome_Regola)) {
                id_regola = nome_Regola;
            }else{
                id_regola = nomeRegola();//Done AA: richiamo al metodo di Pietro!!!
            }
            system.debug('>>>>>>>>NomeRegola ' + id_regola);
            //Regola 0, header della regola
            OF_CV_Regole_Vendita__c regolaHeader = new OF_CV_Regole_Vendita__c();
                regolaHeader.Id_Regola__c = id_regola;
                regolaHeader.Codice_OLO__c = olo;
                regolaHeader.Servizio__c = servizio;
                regolaHeader.Riga__c = n;
                regolaHeader.Stato__c = stato;
                if(isBozza){
                    regolaHeader.isAttiva__c = false;
                    regolaHeader.IsInviato__c = false;
                    regolaHeader.IsBozza__c = true;
                }else{
                    regolaHeader.isAttiva__c = true;
                    regolaHeader.IsInviato__c = true;
                    regolaHeader.IsBozza__c = false;
                }
          
            //Vado a controllare se sono stati inseriti dei valori in BL, in tal caso valorizzo l'header e ne creo una regola
            //Come da richiesta, aggiungo i valori relativi alla riga della BL sull'header (riga 0)
            if( (buildingBL != null && String.isNotBlank(buildingBL)) || (idScalaBL != null && String.isNotBlank(idScalaBL)) || (codStradaBL != null && String.isNotBlank(codStradaBL)) ){
                
                //Se sono presenti valori in BL, lo setto anche nell'header della regola
                regolaHeader.isBlacklist__c = true;
                regolaHeader.Id_Building_BL__c = buildingBL;
                regolaHeader.Id_Scala_BL__c = idScalaBL;
                regolaHeader.Codice_strada_BL__c = codStradaBL;
                regolaHeader.Id_Building_BL_WS__c = formatBLValues(buildingBL);
                regolaHeader.Id_Scala_BL_WS__c = formatBLValues(idScalaBL);
                regolaHeader.Codice_strada_BL_WS__c = formatBLValues(codStradaBL);
                regolaHeader.WhereCondition__c = blkListcondition(regolaHeader.Id_Building_BL__c, regolaHeader.Id_Scala_BL__c, regolaHeader.Codice_strada_BL__c);//Done AA: Richiamo al metodo di pietro per generare where condition!!!
            }
            
            //Aggiungo la regola header alla lista che inserirò
            listRegole.add(regolaHeader);
            //Vado a ciclarmi la lista di pop o pop/comune, in modo da creare le n regole
            for(String var : popOrComune){
                
                //Incremento il progressivo interno alla regola
                n++;
                //Istanzio una regola temp per aggiungerla alla lista che andrò ad inserire
                OF_CV_Regole_Vendita__c tmpRegola = new OF_CV_Regole_Vendita__c();
                    tmpRegola.Id_Regola__c = id_regola;
                    tmpRegola.Codice_OLO__c = olo;
                    tmpRegola.Servizio__c = servizio;
                    tmpRegola.Riga__c = n;
                    //Se l'utente ha inserito solo i pop, valorizzo con il valore della lista 
                    if(!isComunePop){
                        tmpRegola.Pop__c = var;
                        tmpRegola.WhereCondition__c = 'POP='+tmpRegola.Pop__c+' ';
                    }else{//Se l'utente ha inserito POP/Comune devo splittare il valore
                        //Recupero il comune
                        String comune = var.reverse().split('/')[0].reverse();
                        //Recupero il pop
                        Integer pos = var.lastIndexOf('/');
                        String pop = var.substring(0,pos);
                        
                        tmpRegola.Pop__c = pop.normalizeSpace();
                        tmpRegola.Comune__c = comune.normalizeSpace();
                        tmpRegola.WhereCondition__c = 'POP='+tmpRegola.Pop__c+' AND Comune='+tmpRegola.Comune__c+' ';
                    }
                System.debug('***Where Condition:'+tmpRegola.WhereCondition__c);
                //Aggiungo la regola alla lista per fare l'insert successivamente
                listRegole.add(tmpRegola);
            }
            
            //Se la lista di regole non è vuota, le inserisco
            if(!listRegole.isEmpty()){
                if(!isBozza){
                    //Vado a chiamare il ws per scrivere le regole
                    String esito = writeRulesByWs(listRegole);//Done AA - Aggiungere richiamo al ws writeRules
                    //TODO AA - Controllare esito
                    if(esito == 'OK'){//Se mi risponde un ACK, allora inserisco la lista
                        insert listRegole;
                        return ESITO_OK;
                    }else{//Se mi restituisce NACK non inserisco la lista e dò un errore
                        return ESITO_KO;
                    }
                }else{//Se stiamo salvando delle bozze inseriamo senza chiamare il ws
                    insert listRegole;
                }
                
            }
        }catch(Exception e){
            //Vado a catchare eventuali errori e restituisco un KO
            System.debug('KO: The following exception has occurred: ' + e.getMessage());
            return ESITO_KO;
        }
        //Se tutto è andato a buon fine, restituisco un OK
        return ESITO_OK;
    }
    public static String modificaRegola(String ruleName, Boolean isComunePop, List<String> popOrComune, String olo, String servizio, String stato, String buildingBL, String idScalaBL, String codStradaBL, Boolean isBozza){
        String returnValue = ESITO_KO;
        try{
            List<OF_CV_Regole_Vendita__c> listRegole = [SELECT Id
                                                        FROM OF_CV_Regole_Vendita__c
                                                        WHERE Id_Regola__c = :ruleName
                                                        AND Codice_OLO__c = :olo
                                                        AND Servizio__c = :servizio
                                                        ];
            if(!listRegole.isEmpty() ){//Se ci sono delel regole, le cancello e le vado a ricreare
                //Mi salvo nella var statica il nome della regola
                nome_Regola = ruleName;
                //Cancello tutte le regole
                //delete listRegole;
                //Vado a ricreare le regole
                returnValue = inserisciRegola(isComunePop, popOrComune, olo, servizio, stato, buildingBL, idScalaBL, codStradaBL, isBozza);
                if(returnValue==ESITO_OK)
                    delete listRegole;
            }
        }catch(Exception e){
            System.debug('KO: The following exception has occurred: ' + e.getMessage());
        }
        return returnValue;
    }
    public static String clonaRegola(String ruleName, String olo, String servizio, String oldServ, String oldOlo){
        try{
            //Vado a recuperarmi le regole da clonare
            List<OF_CV_Regole_Vendita__c> oldRulelst = [SELECT Id_Regola__c, Codice_OLO__c, Servizio__c, isAttiva__c, Pop__c, Comune__c, Riga__c  ,
                                                                Id_Building_BL__c, Id_Scala_BL__c, Codice_strada_BL__c, isBlacklist__c, Stato__c, WhereCondition__c,
                                                                Id_Building_BL_WS__c, Id_Scala_BL_WS__c, Codice_strada_BL_WS__c 
                                                        FROM OF_CV_Regole_Vendita__c
                                                        WHERE Id_Regola__c = :ruleName
                                                        AND Codice_OLO__c = :oldOlo
                                                        AND Servizio__c = :oldServ];
            //Clono le vecchie regole in una nuova lista così da poterla inserire, senza copiare id o timestamps
            List<OF_CV_Regole_Vendita__c> newRulelst = oldRulelst.deepClone(false, false, false);
            //Genero il nuovo nome regola
            String id_reg = OF_CV_Regole_Utils.nomeRegola();
            //Ciclo la lista di regole da inserire per modificare olo, servizio e nome regola
            for(OF_CV_Regole_Vendita__c tmp : newRulelst){
                tmp.Codice_OLO__c = olo;
                tmp.Servizio__c = servizio;
                tmp.Id_Regola__c = id_reg;
            }
            //Inserisco la nuova lista di regole
            //Vado a chiamare il ws per scrivere la regola copiata
            String esito = writeRulesByWs(newRulelst);
            if(esito == 'OK'){
                insert newRulelst;
                return ESITO_OK;
            }else{
                return ESITO_KO;
            }
        }catch(Exception e){
            System.debug('KO: The following exception has occurred: ' + e.getMessage());
            return ESITO_KO;
        }
    }
    public static String nomeRegola(){
        Integer maxRegola=0;
        Integer currRegola;
        String NomeRegola;

        AggregateResult[] nomeRegole = [select  count(id), Id_Regola__c 
                                from  OF_CV_Regole_Vendita__c 
                                group by Id_Regola__c];

        for(AggregateResult regola : nomeRegole){
	
            currRegola = integer.valueOf( regola.get('Id_Regola__c').toString().replace('Regola','')); 
            
            if (currRegola>maxRegola)
                maxRegola=currRegola;
        }
        maxRegola=maxRegola+1;
        NomeRegola='Regola'+maxRegola;
        return NomeRegola;
    }
    public static String blkListcondition(String strBuilding,String strScala,String strStrada){
    
        String strwhere='';

        if (strBuilding.length()>0){
            List<String>  lstBuilding = strBuilding.split(';');
            strwhere = 'idBuilding in (';
            for (String myBuilding : lstBuilding){
                strwhere =strwhere+ myBuilding + ',';
            } 
            strwhere = strwhere.substring(0,strwhere.length()-1) + ')';
        }
        
        if (strScala.length()>0){
            List<String>  lstScala = strScala.split(';');
            if (strwhere.length()>0) {
                strwhere = strwhere + ' OR idScala in (';
            } else{
                strwhere = 'idScala in (';
            } 
            for (String myScala : lstScala){
                strwhere =strwhere+  myScala + ',';
            } 
            strwhere = strwhere.substring(0,strwhere.length()-1) + ')';
        }
        
        if (strStrada.length()>0){
            List<String>  lstStrada = strStrada.split(';');
            if (strwhere.length()>0) {
                strwhere = strwhere + ' OR CodiceStrada in (';
            } else{
                strwhere = 'CodiceStrada in (';
            } 
            for (String myStrada : lstStrada){
                strwhere =strwhere  + myStrada + ',';
            } 
            strwhere = strwhere.substring(0,strwhere.length()-1) + ')';
        }
        System.debug('WHERE CONDITION: ' + strwhere );
        return strwhere;
    }
    /*
    public static void sendEmail(OF_CV_WS_Schema_Get_Vendibilita.GetVendibilitaResponseType response){
        String userEmail = UserInfo.getUserEmail();
        if(userEmail != null && String.isNotBlank(userEmail)){
            String subject = 'Export vendibilità';
            String textBody = 'Buonasera, di seguito il link per scaricare il file relativo alla vendibilità richiesta! \n ' + response.NOME_FILE;
            List<String> toAddresses = new List<string> {userEmail};

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject(subject);
                email.setToAddresses(toAddresses);
                email.setPlainTextBody(textBody);
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
    }
    */
    public static String formatBLValues(String valueToFormat){
        String strwhere = '';

        if (valueToFormat != null && String.isNotBlank(valueToFormat) ){
            List<String>  splittedValues = valueToFormat.split(';');
            for (String x : splittedValues){
                strwhere = strwhere  + x + ',';
            } 
            strwhere = strwhere.substring(0,strwhere.length()-1);
        }
        
        System.debug('WHERE CONDITION: ' + strwhere );
        return strwhere;
    }
}