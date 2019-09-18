/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to TTM/Salesforce/OLO
* SI:           
*/
public class OF_TTM_WS_WRAP_Utility {
    
    public Map<String,String> tipoComunicazione;  //EOF_Notify__c.tipoComunicazione OF_TT_Tipo_Comunicazione__c
    public Map<String,String> descrEvRis;  //EOF_Notify__c.Descrizione_Evento_Risoluzione__c 
    public Map<String,String> causaleSospensione;

    //TIPO COMUNICAZIONE
    public Static String NOTIFY_RICHIESTA_RISOLUZIONE_GUASTO='Richiesta Risoluzione Guasto';
    public Static String NOTIFY_NOTIFICA_SCARTO='Notifica Scarto';
    public Static String NOTIFY_NOTIFICA_PRESA_IN_CARICO='Notifica Presa in Carico';
    public Static String NOTIFY_NOTIFICA_SOSPENSIONE='Notifica Sospensione';
    public Static String NOTIFY_NOTIFICA_RICHIESTA_CHIUSURA='Notifica Richiesta Chiusura';
    public Static String NOTIFY_RICHIESTA_DESOSPENSIONE='Richiesta Desospensione';
    public Static String NOTIFY_NOTIFICA_DESOSPENSIONE='Notifica Desospensione';
    public Static String NOTIFY_RICHIESTA_AUTORIPRISTINATO='Richiesta Autoripristinato';
    public Static String NOTIFY_RICHIESTA_ANNULLAMENTO='Richiesta Annullamento';
    public Static String NOTIFY_NOTIFICA_ANNULLAMENTO='Notifica Annullamento';
    public Static String NOTIFY_TEST_KO='Test KO';
    public Static String NOTIFY_TEST_OK='Test OK';
    public Static String NOTIFY_NOTIFICA_TIMEOUT_OK='Notifica Timeout OK';
    public Static String NOTIFY_RICHIESTA_AGGIORNAMENTO_DATI='Richiesta Aggiornamento Dati';
    public Static String NOTIFY_NOTIFICA_AGGIORNAMENTO_DATI='Notifica Aggiornamento Dati';

    //DESCRIZIONE EVENTO RISOLUZIONE
    public Static String NOTIFY_RISOLTO_TRATTA_VERTICALE ='Risolto: Tratta Verticale';
    public Static String NOTIFY_RISOLTO_TRATTA_ORIZZONTALE_CENTRALE ='Risolto Tratta Orizzontale: Centrale';
    public Static String NOTIFY_RISOLTO_TRATTA_ORIZZONTALE_RETE_PRIMARIA ='Risolto Tratta Orizzontale: Rete Primaria';
    public Static String NOTIFY_RISOLTO_TRATTA_ORIZZONTALE_RETE_SECONDARIA ='Risolto Tratta Orizzontale: Rete Secondaria';
    public Static String NOTIFY_NON_RISCONTRATO_SENZA_USCITA ='Non Riscontrato: Senza Uscita';
    public Static String NOTIFY_NON_RISCONTRATO_CON_USCITA ='Non Riscontrato: Con Uscita';
    public Static String NOTIFY_RISOLTO_SBRACCIO ='Risolto: Sbraccio';
    public Static String NOTIFY_RISOLTO_BORCHIA_OTTICA ='Risolto: Borchia Ottica';
    public Static String NOTIFY_NON_RISOLVIBILE_CAUSA_IMPIANTO_CLIENTE ='Non Risolvibile: Causa Impianto Cliente';
    public Static String NOTIFY_NON_RISOLVIBILE_CAUSA_CPE_CLIENTE ='Non Risolvibile: Causa CPE Cliente';
    public Static String NOTIFY_RISOLTO_OLO_CLIENTE_CONFIGURAZIONE_CPE_ONT_CLIENTE ='Risolto OLO/CLIENTE: Configurazione CPE/ONT Cliente';
    public Static String NOTIFY_RISOLTO_OLO_CLIENTE_SOSTITUZIONE_CPE_CLIENTE ='Risolto OLO/CLIENTE: Sostituzione CPE Cliente';
    public Static String NOTIFY_RISOLTO_OLO_CLIENTE_SOSTITUZIONE_ONT_CLIENTE ='Risolto OLO/CLIENTE: Sostituzione ONT Cliente';
    public Static String NOTIFY_RISOLTO_OLO_CLIENTE_RESET_CPE_ONT_CLIENTE ='Risolto OLO/CLIENTE: Reset CPE/ONT Cliente';
    public Static String NOTIFY_RISOLTO_OLO_CLIENTE_SOSTITUZIONE_BRETELLA_OTTICA ='Risolto OLO/CLIENTE: Sostituzione Bretella Ottica';
    public Static String NOTIFY_RIBALTAMENTO_EFFETTUATO ='Ribaltamento Effettuato';
    public Static String NOTIFY_NON_RISOLVIBILE_PROBLEMI_DI_RETE_OLO ='Non Risolvibile: Problemi Di Rete OLO (Es. Problema di Scheda In Centrale OLO, Problema Di Configurazione OLO)';
    public Static String NOTIFY_NON_RISOLVIBILE_PROBLEMI_DI_RETE_CLIENTE ='Non Risolvibile: Problemi Di Rete Cliente (Es. Wi-Fi Poco Performante Causa Disposizione Casa Cliente, Configurazione PC)';
    public Static String NOTIFY_RISOLTO_MEDIANTE_INTERVENTO_CONGIUNTO ='Risolto Mediante Intervento Congiunto';
    public Static String NOTIFY_CHIUSO_PER_TIMEOUT_OK ='Chiuso per Timeout_OK';

    //CAUSALE SOSPENSIONE
    public Static String NOTIFY_SEDE_OLO_CLIENTE_FINALE_INACCESSIBILE='SEDE OLO/CLIENTE FINALE INACCESSIBILE';
    public Static String NOTIFY_CLIENTE_IRREPERIBILE='CLIENTE IRREPERIBILE';
    public Static String NOTIFY_CLIENTE_INDISPONIBILE='CLIENTE INDISPONIBILE';


    public OF_TTM_WS_WRAP_Utility (){
      this.setValueTipoComunicazione();
      this.setValueDescrEvRis();
      this.setCausaleSosp();
    }
    
    private void setValueTipoComunicazione(){
      this.tipoComunicazione= new Map<String,String>(); 
      this.tipoComunicazione.put('1', NOTIFY_RICHIESTA_RISOLUZIONE_GUASTO);
      this.tipoComunicazione.put('2', NOTIFY_NOTIFICA_SCARTO);
      this.tipoComunicazione.put('3', NOTIFY_NOTIFICA_PRESA_IN_CARICO);
      this.tipoComunicazione.put('4', NOTIFY_NOTIFICA_SOSPENSIONE);
      this.tipoComunicazione.put('5', NOTIFY_NOTIFICA_RICHIESTA_CHIUSURA);
      this.tipoComunicazione.put('6', NOTIFY_RICHIESTA_DESOSPENSIONE);
      this.tipoComunicazione.put('7', NOTIFY_NOTIFICA_DESOSPENSIONE);
      this.tipoComunicazione.put('8', NOTIFY_RICHIESTA_AUTORIPRISTINATO);
      this.tipoComunicazione.put('9', NOTIFY_RICHIESTA_ANNULLAMENTO);
      this.tipoComunicazione.put('10',NOTIFY_NOTIFICA_ANNULLAMENTO);
      this.tipoComunicazione.put('11',NOTIFY_TEST_KO);
      this.tipoComunicazione.put('12',NOTIFY_TEST_OK);
      this.tipoComunicazione.put('13',NOTIFY_NOTIFICA_TIMEOUT_OK);
      this.tipoComunicazione.put('20',NOTIFY_RICHIESTA_AGGIORNAMENTO_DATI);
      this.tipoComunicazione.put('21',NOTIFY_NOTIFICA_AGGIORNAMENTO_DATI);
    }

    private void setValueDescrEvRis(){
      this.descrEvRis= new Map<String,String>(); 
      this.descrEvRis.put('1',NOTIFY_RISOLTO_TRATTA_VERTICALE);
      this.descrEvRis.put('2',NOTIFY_RISOLTO_TRATTA_ORIZZONTALE_CENTRALE);
      this.descrEvRis.put('3',NOTIFY_RISOLTO_TRATTA_ORIZZONTALE_RETE_PRIMARIA);
      this.descrEvRis.put('4',NOTIFY_RISOLTO_TRATTA_ORIZZONTALE_RETE_SECONDARIA);
      this.descrEvRis.put('5',NOTIFY_NON_RISCONTRATO_SENZA_USCITA);
      this.descrEvRis.put('6',NOTIFY_NON_RISCONTRATO_CON_USCITA);
      this.descrEvRis.put('7',NOTIFY_RISOLTO_SBRACCIO);
      this.descrEvRis.put('8',NOTIFY_RISOLTO_BORCHIA_OTTICA);
      this.descrEvRis.put('9',NOTIFY_NON_RISOLVIBILE_CAUSA_IMPIANTO_CLIENTE);
      this.descrEvRis.put('10',NOTIFY_NON_RISOLVIBILE_CAUSA_CPE_CLIENTE);
      this.descrEvRis.put('11',NOTIFY_RISOLTO_OLO_CLIENTE_CONFIGURAZIONE_CPE_ONT_CLIENTE);
      this.descrEvRis.put('12',NOTIFY_RISOLTO_OLO_CLIENTE_SOSTITUZIONE_CPE_CLIENTE);
      this.descrEvRis.put('13',NOTIFY_RISOLTO_OLO_CLIENTE_SOSTITUZIONE_ONT_CLIENTE);
      this.descrEvRis.put('14',NOTIFY_RISOLTO_OLO_CLIENTE_RESET_CPE_ONT_CLIENTE);
      this.descrEvRis.put('15',NOTIFY_RISOLTO_OLO_CLIENTE_SOSTITUZIONE_BRETELLA_OTTICA);
      this.descrEvRis.put('16',NOTIFY_RIBALTAMENTO_EFFETTUATO);
      this.descrEvRis.put('17',NOTIFY_NON_RISOLVIBILE_PROBLEMI_DI_RETE_OLO);
      this.descrEvRis.put('18',NOTIFY_NON_RISOLVIBILE_PROBLEMI_DI_RETE_CLIENTE);
      this.descrEvRis.put('19',NOTIFY_RISOLTO_MEDIANTE_INTERVENTO_CONGIUNTO);
      this.descrEvRis.put('20',NOTIFY_CHIUSO_PER_TIMEOUT_OK);
    }

    private void setCausaleSosp(){
      this.causaleSospensione= new Map<String,String>(); 
      this.causaleSospensione.put('1', NOTIFY_SEDE_OLO_CLIENTE_FINALE_INACCESSIBILE);
      this.causaleSospensione.put('2', NOTIFY_CLIENTE_IRREPERIBILE);
      this.causaleSospensione.put('3', NOTIFY_CLIENTE_INDISPONIBILE);
    }

    public String getValueByKey_TipoComunicazione(String k){
      return tipoComunicazione.get(k);
    }
    
    public String getKeyByValue_TipoComunicazione(String value){
      
      if(!tipoComunicazione.isEmpty())
      {
        for(String k : tipoComunicazione.keySet())
        {
          if(tipoComunicazione.get(k).equalsIgnoreCase(value))
            return tipoComunicazione.get(k);
          else 
            return null;
        }
      }
      return null;
    }

     public String getValueByKey_DescrEvRis(String k){
      return descrEvRis.get(k);
    }
    
    public String getKeyByValue_DescrEvRis(String value){
      
      if(!descrEvRis.isEmpty())
      {
        for(String k : descrEvRis.keySet())
        {
          if(descrEvRis.get(k).equalsIgnoreCase(value))
            return descrEvRis.get(k);
          else 
            return null;
        }
      }
      return null;
    }

    public String getValueByKey_CausaleSosp(String k){
      return causaleSospensione.get(k);
    }
    
    public String getKeyByValue_CausaleSosp(String value){
      
      if(!causaleSospensione.isEmpty())
      {
        for(String k : causaleSospensione.keySet())
        {
          if(causaleSospensione.get(k).equalsIgnoreCase(value))
            return causaleSospensione.get(k);
          else 
            return null;
        }
      }
      return null;
    }


}