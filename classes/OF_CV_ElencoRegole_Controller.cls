public class OF_CV_ElencoRegole_Controller {
   
    public List<OF_CV_Regole_Vendita__c> lstRegole {get;set;}
    public string olo {get;set;}
    public string servizio {get;set;}
    public String operatore_selected {get;set;} 
    public String servizio_selected {get;set;} 
    public String id_regola {get;set;}
    public Map<String, Boolean> checkMapRuleIsActive = new Map<String, Boolean>();
    List<boolean> checkList {get;set;}
    
    public OF_CV_ElencoRegole_Controller()
    {
        olo = ApexPages.currentPage().getParameters().get('olo');
        servizio = ApexPages.currentPage().getParameters().get('servizio');
        lstRegole = [SELECT Id, Id_Regola__c, Codice_OLO__c, Servizio__c, Stato__c, isAttiva__c,  isBlacklist__c, isBozza__c, IsInviato__c 
                     FROM OF_CV_Regole_Vendita__c
                     WHERE Codice_OLO__c =:olo
                     AND Servizio__c =:servizio
                     AND Riga__c  = 0
                     ORDER BY Id_Regola__c];
                     
        checkList = new List<Boolean>();
        for (OF_CV_Regole_Vendita__c rule : lstRegole){
            checkMapRuleIsActive.put(rule.Id_Regola__c, rule.isAttiva__c);  

            checkList.add(rule.isAttiva__c);
        }
    }
    
    public PageReference creaRegola()
    {
        PageReference pg = new PageReference('/apex/OF_CV_CreaRegola');
        return pg;        
    }
    
    public PageReference clonaRegola()
    {
        PageReference pg = new PageReference('/apex/OF_CV_Clona_Regola'); 
            pg.getParameters().put('ruleName', id_regola);
            pg.getParameters().put('oldOlo', olo);
            pg.getParameters().put('oldServ', servizio_selected);
        return pg;        
        } 
    
     public PageReference annulla(){
        PageReference pg = new PageReference('/apex/OF_CV_home');
        return pg;        
    }  
    
    
    public PageReference modificaRegola(){
        PageReference pg = new PageReference('/apex/OF_CV_SceltaPOP');
            pg.getParameters().put('id_regola', id_regola);
            pg.getParameters().put('servizio_selected', servizio_selected);
            pg.getParameters().put('olo', operatore_selected);
        return pg;        
    }
    public void valorizzaDati(){
        operatore_selected = Apexpages.currentPage().getParameters().get('olo');
        servizio_selected = Apexpages.currentPage().getParameters().get('servizio');
        id_regola = Apexpages.currentPage().getParameters().get('id_regola');
    }
    public void confermaScelta(){
        //Controllo che ci sia almeno una regola
        if(!lstRegole.isEmpty()){
            //Vado a valorizzare una lista con i valori delle checkbox presenti in pagina
            List<String> rulesNameToUpdate = new List<String>();

            for(OF_CV_Regole_Vendita__c tmp : lstRegole){
                Boolean checkValueIsAttiva = checkMapRuleIsActive.get(tmp.Id_Regola__c);
                if(checkValueIsAttiva != tmp.isAttiva__c){
                    rulesNameToUpdate.add(tmp.Id_Regola__c);
                }
            }
            if(!rulesNameToUpdate.isEmpty()){//Se sono differenti aggiorno e chiamo il ws
                List<OF_CV_Regole_Vendita__c> lstRegoleToUpdate = [SELECT Id, Id_Regola__c, Codice_OLO__c, Servizio__c, Riga__c, Stato__c, isAttiva__c, IsInviato__c, 
                                                                   IsBozza__c, isBlacklist__c, Id_Building_BL__c, Id_Scala_BL__c, Codice_strada_BL__c, 
                                                                   Id_Building_BL_WS__c, Id_Scala_BL_WS__c, Codice_strada_BL_WS__c, WhereCondition__c, 
                                                                   Pop__c, Comune__c
                                                                   FROM OF_CV_Regole_Vendita__c
                                                                   WHERE Id_Regola__c IN :rulesNameToUpdate];
                for(OF_CV_Regole_Vendita__c tmpRule : lstRegoleToUpdate){
                    if (tmpRule.Riga__c == 0){
                        tmpRule.isAttiva__c = !checkMapRuleIsActive.get(tmpRule.Id_Regola__c);
                    }
                }
                try{
                    String esito = OF_CV_Regole_Utils.writeRulesByWs(lstRegoleToUpdate);
                    if(esito == 'OK'){
                        update lstRegoleToUpdate;
                        //Vado ad aggiornare la map con i nuovi valori
                        for(String x : rulesNameToUpdate){
                            checkMapRuleIsActive.put(x, !checkMapRuleIsActive.get(x));
                        }
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Modifiche salvate correttamente.'));
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'Errore durante il salvataggio delle informazioni, controllare i dati.'));
                    }
                }catch(Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'Servizio momentaneamente non disponibile.'));
                }
            }else{//Se non ci sono state modifiche, non eseguo operazioni
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'Non ci sono state modifiche.'));
            }
        }
    }
}