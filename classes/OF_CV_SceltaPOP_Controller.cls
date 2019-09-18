public class OF_CV_SceltaPOP_Controller {

    public List<String> selectedPop {get;set;}
    public List<String> removedPop {get;set;}
    public List<String> popDisponibiliList {get;set;}
    public List<String> popSelezionatiList {get;set;}
    public List<String> selectedComuni {get;set;}
    public List<String> removedComuni {get;set;}
    public List<String> comuniDisponibiliList {get;set;}
    public List<String> comuniSelezionatiList {get;set;}
    public List<String> lastSelectedPopList {get;set;}
    //AA
    public String id_regola{get;set;}
    public String servizio_selected{get;set;}
    public String olo{get;set;}
    public String stato{get;set;}
    public boolean mostraPop {get;set;}
    public boolean mostraComuni {get;set;}
    public boolean mostraBlacklist {get;set;}
    public boolean mostrabtnStatoRegola {get;set;}
    public boolean mostraStatoRegola {get;set;}
    public String pop_comune_manual {get;set;}    
    //PG - Var ID Building
    public String id_building {get;set;}
    public String id_scala {get;set;}
    public String codice_strada {get;set;}
    public Boolean isBozza = false;
    public Map<String,String> mapIstatComune{get;set;}

    public OF_CV_SceltaPOP_Controller(){        
        id_regola = Apexpages.currentPage().getParameters().get('id_regola');
        servizio_selected = Apexpages.currentPage().getParameters().get('servizio_selected');
        olo = Apexpages.currentPage().getParameters().get('olo');
        stato = Apexpages.currentPage().getParameters().get('statoRegola');

        initializeCollections();
        getPops();
        //getComuni();

        mostrabtnStatoRegola = false;
        mostraStatoRegola = false;
        mostraPop = true;
        mostraComuni = false;
        mostraBlacklist = false;

        if(id_regola!=null && String.isNotBlank(id_regola)){
            //mostrabtnStatoRegola = true;
            populateSelectedValues();
        }
    }
    private void populateSelectedValues(){
        List<OF_CV_Regole_Vendita__c> listRegole = [SELECT Id_Regola__c, Codice_OLO__c, Servizio__c, isAttiva__c, Pop__c, Comune__c,
                                                    Id_Building_BL__c, Id_Scala_BL__c, Codice_strada_BL__c, Stato__c
                                                    FROM OF_CV_Regole_Vendita__c
                                                    WHERE Id_Regola__c = :id_regola
                                                    AND Servizio__c = :servizio_selected
                                                    AND Codice_OLO__c = :olo
                                                    ];

        for(OF_CV_Regole_Vendita__c of_reg : listRegole){
            if(of_reg.Pop__c != null && String.isNotBlank(of_reg.Pop__c)){
                popSelezionatiList.add(of_reg.Pop__c);
            }
            if(of_reg.Comune__c != null && String.isNotBlank(of_reg.Comune__c)){
                comuniSelezionatiList.add(of_reg.Pop__c+'/'+of_reg.Comune__c);
            }
            if(of_reg.Id_Building_BL__c != null && String.isNotBlank(of_reg.Id_Building_BL__c)){
                id_building = of_reg.Id_Building_BL__c;
            }
            if(of_reg.Id_Scala_BL__c != null && String.isNotBlank(of_reg.Id_Scala_BL__c)){
                id_scala = of_reg.Id_Scala_BL__c;
            }
            if(of_reg.Codice_strada_BL__c != null && String.isNotBlank(of_reg.Codice_strada_BL__c)){
                codice_strada = of_reg.Codice_strada_BL__c;
            } 
            if(of_reg.Stato__c != null && String.isNotBlank(of_reg.Stato__c)){
                stato = of_reg.Stato__c;
            }
        }
    }
    public List<SelectOption> getStati(){
        List<SelectOption> stati = new List<SelectOption>();
        stati.add(new SelectOption('',''));
        stati.add(new SelectOption('101','101'));
        stati.add(new SelectOption('102','102'));
        stati.add(new SelectOption('103','103'));
        stati.add(new SelectOption('104','104'));
        stati.add(new SelectOption('105','105'));
        stati.add(new SelectOption('106','106'));

        return stati;
    }
	public void sceltaStatoRegola(){
        mostraStatoRegola = true;
        mostraPop = false;
        mostraComuni = false;
        mostraBlacklist = false;
        mostrabtnStatoRegola = false;
    }
	private void initializeCollections(){
        selectedPop = new List<String>();
        removedPop = new List<String>(); 
        popDisponibiliList = new List<String>(); 
        popSelezionatiList = new List<String>(); 
        selectedComuni = new List<String>();
        removedComuni = new List<String>();
        comuniDisponibiliList = new List<String>();
        comuniSelezionatiList = new List<String>();
        mapIstatComune = new Map<String,String>();
        lastSelectedPopList = new List<String>();
    }
    public void getPops() {
        //TODO AA - Cancellare try catch
        //try{
        if(popDisponibiliList.isEmpty()){
            //Richiamo il ws
            /*
            OF_CV_WS_Schema_Get_PopComuni.GetPopResponseType response = OF_CV_Regole_Utils.getPopByWs();
            if(response != null && response.ESITO == '0'){//Se la chiamata va a buon fine
                popDisponibiliList = response.LISTA_POP.POP;
            }else{//Se la chiamata risponde un NACK
                popDisponibiliList = new List<String>();
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Servizio momentaneamente non disponibile'));
            }
            */
            //popDisponibiliList = OF_CV_Regole_Utils.getPopByWs();
            //}
            /*
            }catch(Exception e){
            for(Pop__c p : [SELECT Id, Name FROM Pop__c]){
            popDisponibiliList.add(p.Name);
            }
            */
            //AA 011018 - Modifiche per la gestione ESITO
            OF_CV_WS_Schema_Get_PopComuni.GetPopResponseType response = OF_CV_Regole_Utils.getPopByWs();
            if(response != null && response.ESITO == 'OK'){//Se la chiamata va a buon fine
                popDisponibiliList = response.LISTA_POP.POP;
            }else{//Se la chiamata risponde un NACK
                popDisponibiliList = new List<String>();
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Servizio momentaneamente non disponibile'));
            }
        }
        
    }
    public void addPop(){
    	if (!selectedPop.isEmpty()){
    		for (String popName : selectedPop){
    		    for(Integer i = 0; i < popDisponibiliList.size(); i++){
    		        if (popDisponibiliList[i] == popName){
    		            popDisponibiliList.remove(i);
    		        }
    		    }
    			popSelezionatiList.add(popName);
    		}
    	}
    }
    public void removePop(){
        if (!removedPop.isEmpty()){
    		for (String popName : removedPop) {
    		    for(Integer i=0; i<popSelezionatiList.size(); i++){
    		        if (popSelezionatiList[i] == popName){
    		            popSelezionatiList.remove(i);
    		        }
    		    }
    			popDisponibiliList.add(popName);
    		}
    	}
    }
    public List<SelectOption> getPopDisponibili() {
    	List<SelectOption> popDispList = new List<SelectOption>();
    	for (String popName : popDisponibiliList) {
    		popDispList.add(new SelectOption(popName, popName));
    	}
    	return popDispList;
    }
    public List<SelectOption> getPopSelezionati() {
    	List<SelectOption> popSelList = new List<SelectOption>();
    	for (String popName : popSelezionatiList) {
    		popSelList.add(new SelectOption(popName, popName));
    	}
    	return popSelList; 
    }
    public String getComuni(){
        //Dond AA - Aggiungere richiamo al ws per recuperare i comuni dati i pop
        if(popSelezionatiList != null && !popSelezionatiList.isEmpty() ){  
            System.debug('Prima dell if ');
                    System.debug('**** Valore last selected ' + lastSelectedPopList);
                    System.debug('**** Valore pop selected ' + popSelezionatiList);          
            if(lastSelectedPopList != popSelezionatiList){
                //TODO AA- Togliere try catch
                //try{
                    System.debug('Prima di assegnare la lista ');
                    System.debug('**** Valore last selected ' + lastSelectedPopList);
                    System.debug('**** Valore pop selected ' + popSelezionatiList);
                    lastSelectedPopList = popSelezionatiList.clone();
                     System.debug('DOPO aver assegnato la lista ');
                    System.debug('**** Valore last selected ' + lastSelectedPopList);
                    System.debug('**** Valore pop selected ' + popSelezionatiList);
                    comuniDisponibiliList = OF_CV_Regole_Utils.getComuniPopByWs(popSelezionatiList);
                    system.debug('comuniDisponibiliList: ' + comuniDisponibiliList);
                /*
                }catch(Exception e){
                    comuniDisponibiliList.add('POP01/016249');
                    comuniDisponibiliList.add('POP02/017004');
                    comuniDisponibiliList.add('POP03/017009');
                    comuniDisponibiliList.add('POP04/017010');
                }
                */
            } 
            return 'OK';
        }else{
            return 'KO';
        }
    }
    public void addComuni(){
    	if (!selectedComuni.isEmpty()){
    		for (String comune : selectedComuni){
    		    for(Integer i=0; i<comuniDisponibiliList.size(); i++){
    		        if (comuniDisponibiliList[i] == comune){
    		            comuniDisponibiliList.remove(i);
    		        }
    		    }
    			comuniSelezionatiList.add(comune);
    		}
    	}
    }
    public void removeComuni() {
    	if (!removedComuni.isEmpty()){
            for (String comune : removedComuni){
                for(Integer i=0; i<comuniSelezionatiList.size(); i++){
                    if (comuniSelezionatiList[i] == comune){
                        comuniSelezionatiList.remove(i);
                    }
                }
                comuniDisponibiliList.add(comune);
    		}
    	}
    }
    public List<SelectOption> getComuniDisponibili() {
    	List<SelectOption> comuniDispList = new List<SelectOption>();
        //Done AA 
    	for (String comune : comuniDisponibiliList) {
            System.debug('**** comuniDisponibiliList = ' + comuniDisponibiliList);
            //List<String> comune_istat = comune.split('/');
            String comune_istat= comune.reverse().split('/')[0].reverse();
            //AA
            Integer pos = comune.lastIndexOf('/');
            
    		comuniDispList.add(new SelectOption(comune, comune.substring(0,pos) + '/' + mapIstatComune.get(comune_istat)));
    	}
    	return comuniDispList;
    }
    public List<SelectOption> getComuniSelezionati() {
    	List<SelectOption> comuniSelList = new List<SelectOption>();
    	for (String comune : comuniSelezionatiList) {
            //List<String> comune_istat = comune.split('/');
            String comune_istat= comune.reverse().split('/')[0].reverse();
            //AA
            Integer pos = comune.lastIndexOf('/');
            
    		comuniSelList.add(new SelectOption(comune, comune.substring(0,pos) + '/' + mapIstatComune.get(comune_istat)));
    		//comuniSelList.add(new SelectOption(comune, comune_istat[0] + '/' + mapIstatComune.get(comune_istat[1])));
    	}
    	return comuniSelList;
    }
    public void addManualPopComune(){
        if((pop_comune_manual != null) && (String.isNotBlank(pop_comune_manual))){
            List<String> splittedPopCom = pop_comune_manual.split('/');
            if(splittedPopCom.size() >= 2){
                String comune = pop_comune_manual.reverse().split('/')[0].reverse();
                List<OF_ElencoComuniItaliani__c> lstIstat = [SELECT Id, OF_CodiceIstat__c, OF_Comune__c 
                                                             FROM OF_ElencoComuniItaliani__c 
                                                             WHERE OF_Comune__c = :comune];
                if(!lstIstat.isEmpty()){
                    mapIstatComune.put(lstIstat[0].OF_CodiceIstat__c, lstIstat[0].OF_Comune__c);
                    Integer pos = pop_comune_manual.lastIndexOf('/');
                    
                    String pop_comune_formatted_istat = pop_comune_manual.substring(0,pos) + '/' + lstIstat[0].OF_CodiceIstat__c;
                    selectedComuni.add(pop_comune_formatted_istat);
                    comuniSelezionatiList.add(pop_comune_formatted_istat);
                }else{
                    selectedComuni.add(pop_comune_manual);
                    comuniSelezionatiList.add(pop_comune_manual);
                }
                getComuniSelezionati();
                pop_comune_manual = '';
            }
        }
    }
    public void sceltaComune(){
        if(getComuni()=='OK'){
            List<String> lstIstat = new List<String>();
            system.debug('@@@@@@@@@>>>: ELENCOCOMUNI'+comuniDisponibiliList);
            for(String comune : comuniDisponibiliList){
                //List<String> comune_istat = comune.split('/');
                String comune_istat = comune.reverse().split('/')[0].reverse();
                system.debug('@@@@@@@@@@@@@>>>:' + comune_istat);
                //if(comune_istat.size()>=2)
                if(comune_istat!=null){
                    system.debug('@@@@@@@@@@@@@>>> IF:' +  comune_istat);
                    lstIstat.add(comune_istat);
                }
            }
            
            
            for(OF_ElencoComuniItaliani__c var : [SELECT Id, OF_CodiceIstat__c, OF_Comune__c FROM OF_ElencoComuniItaliani__c WHERE OF_CodiceIstat__c IN :lstIstat]){
                mapIstatComune.put(var.OF_CodiceIstat__c, var.OF_Comune__c);
            }
            mostraPop = false;
            //mostrabtnStatoRegola = true;
            mostraComuni = true;
            mostraStatoRegola = false;
            mostraBlacklist = false;
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Selezionare almeno un POP'));
        }
    }
    public void sceltaBlacklist(){
        if(popSelezionatiList != null && !popSelezionatiList.isEmpty() ){
            mostraPop = false;
            mostraComuni = false;
            //mostrabtnStatoRegola = true;
            mostraStatoRegola = false;
            mostraBlacklist = true;
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Selezionare almeno un POP'));
        }
    }
    public PageReference annulla(){
        PageReference pg = new PageReference('/apex/OF_CV_Home');
        return pg;        
    }
    public void tornaIndietro_POP(){
        mostraPop = true;
        mostraComuni = false;  
        mostraStatoRegola = false;
        mostraBlacklist = false;
        //mostrabtnStatoRegola = true;
    }
    public void tornaIndietro_Comune(){
        mostraPop = false;
        mostraStatoRegola = false;
        //mostrabtnStatoRegola = true;
        mostraComuni = true;  
        mostraBlacklist = false;     
    }
    public PageReference regolaInBozza(){
        if(popSelezionatiList != null && !popSelezionatiList.isEmpty() ){
            isBozza = true;
            return regolaCompletata();
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Selezionare almeno un POP'));
            return null;
        }
    }
    public PageReference regolaCompletata(){
        if(popSelezionatiList != null && !popSelezionatiList.isEmpty() ){
            String esito = '';
            //Done AA Aggiungere il campo isBozza ai metodi!
            Boolean isComunePop = false;
            System.debug('***** inside regola completata');
            if(!comuniSelezionatiList.isEmpty()){
                isComunePop = true;
                //OF_CV_Regole_Utils.inserisciRegola(isComunePop, comuniSelezionatiList, olo, servizio_selected, stato, id_building, id_scala, codice_strada);
            }else{
                isComunePop = false;
                //OF_CV_Regole_Utils.inserisciRegola(isComunePop, popSelezionatiList, olo, servizio_selected, stato, id_building, id_scala, codice_strada);
            }
            System.debug('***** valore isComunePop = ' + isComunePop);
            if(id_regola != null && String.isNotBlank(id_regola)){//In caso sia update
                if(isComunePop){
                    esito = OF_CV_Regole_Utils.modificaRegola(id_regola, isComunePop, comuniSelezionatiList, olo, servizio_selected, stato, id_building, id_scala, codice_strada, isBozza);
                }else{
                    esito = OF_CV_Regole_Utils.modificaRegola(id_regola, isComunePop, popSelezionatiList, olo, servizio_selected, stato, id_building, id_scala, codice_strada, isBozza);
                }
            }else{
                System.debug('***** inside inserisci regola');
                if(isComunePop){
                    esito = OF_CV_Regole_Utils.inserisciRegola(isComunePop, comuniSelezionatiList, olo, servizio_selected, stato, id_building, id_scala, codice_strada, isBozza);
                }else{
                    esito = OF_CV_Regole_Utils.inserisciRegola(isComunePop, popSelezionatiList, olo, servizio_selected, stato, id_building, id_scala, codice_strada, isBozza);
                }
            }
            System.debug('****Esito :****'+esito);
            if(esito == 'OK'){
                PageReference pg = new PageReference('/apex/OF_CV_Home');
                return pg;
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Errore durante il salvataggio delle regole, riprovare piu\' tardi'));
                return null;
            }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Selezionare almeno un POP'));
            return null;
        }
    }
}