@isTest
public class PO_FATT_WS_IN_PSM_NotifyTest 
{
    public static testMethod void PO_FATT_WS_IN_PSM_NotifyTestMethod()
    {
         PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = 'Test';
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '0';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        //psmNotify.ATTACHMENT = true;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse psmres = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
        psmres.ID_NOTIFICA = 'Test';
        psmres.ESITO = 'Test';
        psmres.CODICE_MOTIVAZIONE = 'Test';
        psmres.MOTIVAZIONE = 'Test';
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify(psmNotify);
    }
    
    public static testMethod void PO_FATT_WS_IN_PSM_NotifyTestMethod1()
    {
         PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = 'Test';
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '1';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        //psmNotify.ATTACHMENT = true;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse psmres = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
        psmres.ID_NOTIFICA = 'Test';
        psmres.ESITO = 'Test';
        psmres.CODICE_MOTIVAZIONE = 'Test';
        psmres.MOTIVAZIONE = 'Test';
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify(psmNotify);
    }
    public static testMethod void PO_FATT_WS_IN_PSM_NotifyTestMethod2()
    {
         PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = 'Test';
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '2';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        //psmNotify.ATTACHMENT = true;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse psmres = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
        psmres.ID_NOTIFICA = 'Test';
        psmres.ESITO = 'Test';
        psmres.CODICE_MOTIVAZIONE = 'Test';
        psmres.MOTIVAZIONE = 'Test';
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify(psmNotify);
    }
    public static testMethod void PO_FATT_WS_IN_PSM_NotifyTestMethod3()
    {
         PO_FATT_WS_IN_PSM_Notify.PSM_Notify psmNotify = new PO_FATT_WS_IN_PSM_Notify.PSM_Notify();
        psmNotify.DATA_NOTIFICA = 'Test';
        psmNotify.ID_NOTIFICA = 'Test';
        psmNotify.CODICE_ORDINE = 'Test' ; 
        psmNotify.CODICE_NOTIFICA = '3';        
        psmNotify.DATA_PREVISTA_ATTIVAZIONE = 'Test'; 
        psmNotify.MOTIVAZIONE_RIMODULAZIONE_DAC = 'Test';
        psmNotify.STATO_ORDINE = 'Test';
        psmNotify.ID_RISORSA = 'Test'; 
        psmNotify.ID_CIRCUITO_1 = 'Test';
        psmNotify.ID_CIRCUITO_2 = 'Test';
        psmNotify.DATA_ESPLETAMENTO_ORDINE = 'Test';
        psmNotify.NOTE = 'Test';
        //psmNotify.ATTACHMENT = true;
        
        PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse psmres = new PO_FATT_WS_IN_PSM_Notify.PSM_NotifyResponse();
        psmres.ID_NOTIFICA = 'Test';
        psmres.ESITO = 'Test';
        psmres.CODICE_MOTIVAZIONE = 'Test';
        psmres.MOTIVAZIONE = 'Test';
        
        PO_FATT_WS_IN_PSM_Notify.PSM_Notify(psmNotify);
    }
    
}