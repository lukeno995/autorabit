public class OF_CV_Home_Controller {

    public List<OF_CV_Regole_Vendita__c> elencoVend{get;set;}
    public String operatore_selected {get;set;} 
    public String stato_selected {get;set;} 

    public OF_CV_Home_Controller()
    {
        elencoVend=getVenditeAttive();
    }
    
    public List<OF_CV_Regole_Vendita__c> getVenditeAttive()
    {
        List<OF_CV_Regole_Vendita__c> tmpVend = new List<OF_CV_Regole_Vendita__c>();
        
        List<AggregateResult> agrRes = [SELECT Codice_OLO__c,Servizio__c, COUNT(id)
                                        FROM OF_CV_Regole_Vendita__c
                                        GROUP BY Codice_OLO__c,Servizio__c];
      
        if( agrRes != null && agrRes.size()>0)
        {
            for( AggregateResult a : agrRes )
            {
               String OLO = (String)a.get('Codice_OLO__c');
               String Servizio = (String)a.get('Servizio__c');
               tmpVend.add(new OF_CV_Regole_Vendita__c(Codice_OLO__c=OLO,Servizio__c=Servizio));
            }
            return tmpVend;
        }
        return null;
    } 
    
    
    public void valorizzaDati()
    {
        operatore_selected = Apexpages.currentPage().getParameters().get('olo');
        stato_selected = Apexpages.currentPage().getParameters().get('servizio');
    }
    
    public PageReference visualizzaRegole()
    {
        system.debug('>>>>>>>>>>>>> Input Olo: ' + operatore_selected );
        system.debug('>>>>>>>>>>>>> Input Olo: ' + stato_selected );
        
        if (operatore_selected != null  && stato_selected!=null){
            PageReference pg = new PageReference('/apex/OF_CV_ElencoRegole');
            pg.getParameters().put('olo',operatore_selected);
            pg.getParameters().put('servizio',stato_selected);
            
            return pg;    
        }else{
            return null;
        }
    }
    
    public PageReference creaNuovaRegola()
    {
        PageReference pg = new PageReference('/apex/OF_CV_CreaRegola');
        return pg;       
    }
    public PageReference estraiVendibilita(){
        operatore_selected = Apexpages.currentPage().getParameters().get('olo');
        stato_selected = Apexpages.currentPage().getParameters().get('servizio');
        if(operatore_selected != null && String.isNotBlank(operatore_selected) && stato_selected != null && String.isNotBlank(stato_selected)){
            try{
                if(operatore_selected == 'VF' ){
                    operatore_selected = 'VOD';
                }else if(operatore_selected == 'WN'){
                    operatore_selected = 'WIN';
                }else if(operatore_selected == 'OF'){
                    operatore_selected = 'EOF';
                }
                OF_CV_WS_Schema_Get_Vendibilita.GetVendibilitaResponseType estraiResp = OF_CV_Regole_Utils.getVendibilitaByWs(operatore_selected, stato_selected);
                if(estraiResp != null ){
                    if (estraiResp.ESITO == 'OK'){//Presa in carico OK
                    	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Riceverà a breve una mail contenente il file relativo alla vendibilità.'));
                    }else{//Presa in carico KO
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, estraiResp.MOTIVAZIONE));
                    }
                }else{//Chiamata KO
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Servizio non raggiungibile.'));
                }
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Servizio momentaneamente non disponibile.'));
            }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'ERROR! Selezionare almeno una coppia OLO/Servizio.'));
        }
        return null;
    }
}