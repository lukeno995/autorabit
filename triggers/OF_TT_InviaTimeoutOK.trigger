trigger OF_TT_InviaTimeoutOK on Case (after update) {
//trigger OF_TT_InviaTimeoutOK on Case (after insert, after update) { //AS ORI
System.debug('OF_TT_InviaTimeoutOK START');
if(checkRecursive.runOnce()){ //AS ADD RUNONCE
    System.debug('OF_TT_InviaTimeoutOK PRERUN');
    if(trigger.isAfter && trigger.isUpdate){
        System.debug('OF_TT_InviaTimeoutOK RUN'); 
        //27/06/2017 CRM query spostata fuori dal for
        RecordType checkRType = [select Id from recordtype where name = 'Trouble Ticket' and sobjecttype = 'Case' limit 1];
        //END 27/06/2017 CRM
        for(Case c : trigger.new){ 
            //RecordType checkRType = [select Id from recordtype where name = 'Trouble Ticket' and sobjecttype = 'Case' limit 1];
            if(c.recordtypeId==checkRType.id){
                if(c.status=='Richiesta Chiusura' && c.EOF_Timeout_OK__c==true){
                    System.debug('OF_TT_InviaTimeoutOK Richiesta Chiusura');
                    Case c2 = new Case();
                    c2.ID=c.Id;
                    c2.EOF_Timeout_OK__c=false;
                    OF_TT_Utils.Create_Notify(c,13,'','');
                    update c2;
                }
                
                if(c.status=='Sospeso' && c.EOF_Desospendi__c==true){
                    System.debug('OF_TT_InviaTimeoutOK Sospeso');
                    Case c2 = new Case();
                    c2.ID=c.Id;
                    c2.status='In Lavorazione';
                    c2.EOF_Fase__C='Da Lavorare';
                    c2.EOF_Desospendi__c=false;
                    Database.DMLOptions dmo = new Database.DMLOptions();
                    dmo.assignmentRuleHeader.useDefaultRule = true;
                    c2.setOptions(dmo);
                    update c2;
                    OF_TT_Utils.Create_Notify(c,7,'','Invia');
                }
                
            } 
            
        }
    }
}
System.debug('OF_TT_InviaTimeoutOK STOP');
}