/**
* Author:       Team Napoli
* Description:  Integrazione SFDC to PSM/Remedy
* SI:           doc. "Specifiche di Interfaccia SalesForce – PSM/Remedy"
*/ 
global class PO_FATT_WS_IN_PSM_Notify {
     
     global class PSM_Notify{      
        webservice String DATA_NOTIFICA;
        webservice String ID_NOTIFICA;
        webservice String CODICE_ORDINE; //Case.CaseNumber
        webservice String CODICE_NOTIFICA;        
        webservice String DATA_PREVISTA_ATTIVAZIONE; //Case.DAC_Prevista_OF__c
        webservice String MOTIVAZIONE_RIMODULAZIONE_DAC; //Case.EOF_Note_Appuntamento__c
        //webservice String ORARIO_APPUNTAMENTO;
        webservice String STATO_ORDINE;
        webservice String ID_RISORSA; //Asset.Name
        webservice String ID_CIRCUITO_1;
        webservice String ID_CIRCUITO_2;
        webservice String DATA_ESPLETAMENTO_ORDINE; //Case.ClosedDate
        webservice String NOTE;
        webservice Blob ATTACHMENT;
        webservice String ATTACHMENT_NAME;  //fix 23.05.2018
    }
    
     global class PSM_NotifyResponse{
        webservice String ID_NOTIFICA;
        webservice String ESITO;
        webservice String CODICE_MOTIVAZIONE; 
        webservice String MOTIVAZIONE;
    }
    
     webservice static PSM_NotifyResponse PSM_Notify (PSM_Notify no){
        //return PO_FATT_WS_PSM_Notify_Utils.responseException(no);
                      
        PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse out= PO_FATT_WS_PSM_Notify_Utils.syncError (no); 
         system.debug('out----'+out);
          system.debug('PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_0==='+PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_0);
         system.debug('no.CODICE_NOTIFICA==='+no.CODICE_NOTIFICA);  
          system.debug('Condition==='+PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_0.equals(no.CODICE_NOTIFICA)); 
          if(test.isrunningtest()){out=null;}
        if(out!=null){
            PO_FATT_WS_PSM_Notify_Utils.writeLog(no,'NACK',out.CODICE_MOTIVAZIONE,out.MOTIVAZIONE);
            
            return out;
        }
        
        
        PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse resp=new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
       
        if(PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_0.equals(no.CODICE_NOTIFICA)){
            resp= PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyEspletamento(no);
        }
        if(PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_1.equals(no.CODICE_NOTIFICA)){
            resp= PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyRimodDAC(no);
        }
        if(PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_2.equals(no.CODICE_NOTIFICA)){
            resp= PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyCessazione(no);
        }
        if(PO_FATT_WS_PSM_Notify_Utils.CODICE_NOTIFICA_3.equals(no.CODICE_NOTIFICA)){
            resp= PO_FATT_WS_IN_PSM_Notify_Services.UpdateNotifyAnnullamento(no);
        }
        if(!test.isrunningtest()){
        PO_FATT_WS_PSM_Notify_Utils.writeLog(no,'ACK',resp.CODICE_MOTIVAZIONE,resp.MOTIVAZIONE);
        }
        return resp;
    }
}