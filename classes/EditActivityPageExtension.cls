public class EditActivityPageExtension{
    public Task taskObject {get;set;}
    DateTime taskDateTime; 
    String taskTimeHr;
    String taskTimeMin;
    public Date taskDate {get;set;}
    public Contact objContact{get;set;}
    public String taskTime{get;set;}
    public String timeVar {get;set;}
    public string dtr{get;set;}
    public boolean isCheck{get;set;}
    public boolean isNew{get;set;}  
    public Case c {get;set;}     
    public String caseId{get;set;}
    public String caseNumber{get;set;}
    public ID notID;
    public EOF_Notify__c notify;
    public static EOF_GW_WS_Request.FiberRequest fr_tmp; 
    public static EOF_GW_WS_Request.returnFiberResponse res_temp;
    public static boolean success{get;set;}    
    
    public EditActivityPageExtension(ApexPages.StandardController st){
        success = false;
        taskObject = new Task();
        isNew = true;
        taskDate = System.Today();
        objContact = new Contact();
        isCheck = false;
        c = new Case();
        if(st.getId()!=null){
            taskObject = [SELECT AccountId,ActivityDate,CallDisposition,CallDurationInSeconds,CallObject,CallType,Description,
                               Id,IsArchived,IsClosed,IsDeleted,IsRecurrence,IsReminderSet,OwnerId,Priority,
                               RecurrenceActivityId,
                               RecurrenceDayOfMonth,RecurrenceDayOfWeekMask,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceInterval,
                               RecurrenceMonthOfYear,RecurrenceRegeneratedType,RecurrenceStartDateOnly,RecurrenceTimeZoneSidKey,
                               RecurrenceType,EOF_Data_Ora_Chiamata__c,Data_Appuntamento__c,Fascia_Oraria_Appuntamento__c,
                               ReminderDateTime,Status,Subject,TaskSubtype,WhatId,WhoId,Who.Phone,Who.Email
                          FROM
                              Task
                          WHERE
                              id  = :st.getId()];            
            taskDateTime = taskObject.ReminderDateTime;
            isNew = false;
            isCheck = taskObject.IsReminderSet;
            dtr = taskObject.ReminderDateTime.date()+'';
            dtr = dtr.substringBefore(' ');
            if(dtr.contains('-')){
                dtr = dtr.replace('-','/');
            }
            taskTimeHr = String.valueOf(taskObject.ReminderDateTime.hour());
            taskTimeMin = String.valueOf(taskObject.ReminderDateTime.minute());
            taskTime = taskTimeHr +'.'+taskTimeMin;
            taskDate = taskObject.ReminderDateTime.Date();
            timeVar = taskTime;
        }
        else{
            taskObject = new Task();
            List<User> lstUser = new List<User>();
            lstUser = [select id from User where name =: 'EOF Operatore BO'];
            taskObject.OwnerId = lstUser[0].Id;
            isNew = true;
            Date dtCurrent = Date.newInstance(system.today().year(),system.today().month(),system.today().day());
            dtr = String.valueOf(dtCurrent);
             dtr = dtr.replace('-','/');
             taskTimeHr = '0';
             taskTimeMin = '0';
            if(ApexPages.currentPage().getParameters().get('what_id')!=null)
            taskObject.WhatId = ApexPages.currentPage().getParameters().get('what_id');
        }
        c = [Select ID,EOF_Data_Prevista_Attivazione__c,EOF_Nuova_DAC__c,EOF_Pertinenza_RDAC__c,EOF_Codice_Operatore_WS__c,EOF_Orario_Appuntamento__c,CaseNumber from Case where ID = :taskObject.WhatId];
       	caseId = c.Id;
        caseNumber = c.CaseNumber;
    }
        
    public List<SelectOption> getTimeOptions() {
        List<SelectOption> TimeOptions = new List<SelectOption>();
        TimeOptions.add(new SelectOption('0.00','0.00'));
        TimeOptions.add(new SelectOption('0.30','0.30'));
        TimeOptions.add(new SelectOption('1.00','1.00'));
        TimeOptions.add(new SelectOption('1.30','1.30'));
        TimeOptions.add(new SelectOption('2.00','2.00'));
        TimeOptions.add(new SelectOption('2.30','2.30'));
        TimeOptions.add(new SelectOption('3.00','3.00'));
        TimeOptions.add(new SelectOption('3.30','3.30'));
        TimeOptions.add(new SelectOption('4.00','4.00'));
        TimeOptions.add(new SelectOption('4.30','4.30'));
        TimeOptions.add(new SelectOption('5.00','5.00'));
        TimeOptions.add(new SelectOption('5.30','5.30'));
        TimeOptions.add(new SelectOption('6.00','6.00'));
        TimeOptions.add(new SelectOption('6.30','6.30'));
        TimeOptions.add(new SelectOption('7.00','7.00'));
        TimeOptions.add(new SelectOption('7.30','7.30'));
        TimeOptions.add(new SelectOption('8.00','8.00'));
        TimeOptions.add(new SelectOption('8.30','8.30'));
        TimeOptions.add(new SelectOption('9.00','9.00'));
        TimeOptions.add(new SelectOption('9.30','9.30'));
        TimeOptions.add(new SelectOption('10.00','10.00'));
        TimeOptions.add(new SelectOption('10.30','10.30'));
        TimeOptions.add(new SelectOption('11.00','11.00'));
        TimeOptions.add(new SelectOption('11.30','11.30'));
           
        return TimeOptions;
    }
    
    public Attachment attachment {
        get {
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    
    public void saveMethod(){
      system.debug('dtr val---'+dtr);
      List<String> lstDate = new List<String>();
        if(dtr !=''){
            dtr = dtr.replace('/','-');
            lstDate.addAll(dtr.split('-'));
            Datetime newDate;
            if(lstDate.size() > 0 && lstDate[2].length()>3)
                newDate = Date.newInstance(Integer.ValueOf(lstDate[2]),Integer.ValueOf(lstDate[1]),Integer.ValueOf(lstDate[0]));
            else
                newDate = Date.newInstance(Integer.ValueOf(lstDate[0]),Integer.ValueOf(lstDate[1]),Integer.ValueOf(lstDate[2]));
            system.debug('newDate-----111' + newDate);
            Datetime dt = datetime.newInstance(newDate.year(), newDate.month(),newDate.day(),Integer.ValueOf(taskTimeHr),Integer.ValueOf(taskTimeMin) ,0);
            system.debug('newDate-----' + newDate);
            system.debug('dt-----' + dt);
            taskObject.ReminderDateTime = dt; 
        }
        
        taskObject.IsReminderSet = isCheck;   
        taskObject.Status = 'Completata';
        taskObject.Priority = 'Alta';
        system.debug('taskObject.ReminderDateTime11-----' + taskObject.Data_Appuntamento__c);
        upsert taskObject;        
        Task t = new Task();
        t = [Select id,Data_Appuntamento__c,Subject,EOF_Esito_della_chiamata__c from Task where id =:taskObject.ID];  
        system.debug('task obj'+t);
        
        //---------create remodulation notify----
        if(t.Data_Appuntamento__c != null && t.EOF_Esito_della_chiamata__c=='Positivo') {
        	  
            c.canModify__c = true;
            c.EOF_Data_appuntamento__c=taskObject.Data_Appuntamento__c;
            if(!String.isBlank(taskObject.Fascia_Oraria_Appuntamento__c)){
                c.EOF_Nuova_DAC__c = DateTime.newInstance(taskObject.Data_Appuntamento__c, Time.newInstance(Integer.valueOf(taskObject.Fascia_Oraria_Appuntamento__c.substring(0,2)), 
                                                                                                Integer.valueOf(taskObject.Fascia_Oraria_Appuntamento__c.substring(3,5)), 0, 0));
                c.EOF_Orario_Appuntamento__c=taskObject.Fascia_Oraria_appuntamento__c;
            }
            else{
                c.EOF_Nuova_DAC__c = DateTime.newInstance(taskObject.Data_Appuntamento__c, Time.newInstance(0, 0, 0, 0));
                c.EOF_Orario_Appuntamento__c='';
            }  
             c.EOF_Pertinenza_RDAC__c = 'EOF';
             update c;
             
             RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'EOF_Notify__c' AND Name = 'Notifica di rimodulazione DAC' LIMIT 1];
             system.debug('t data --'+t.Data_Appuntamento__c);
            
            String orario_DAC = '';
            if(!String.isBlank(taskObject.Fascia_Oraria_Appuntamento__c))                
            	orario_DAC =  taskObject.Fascia_Oraria_Appuntamento__c;
             
            RecordType rtNotify = [SELECT Id FROM RecordType WHERE Name = 'FiberNotify'];
            notify = new EOF_Notify__c(
                        RecordTypeId = rt.id,
                        Caso__c = c.Id,
                        EOF_Codice_Operatore__c = c.EOF_Codice_Operatore_WS__c,
                        EOF_Codice_Ordine_EOF__c = c.Id,
                        EOF_ID_Notifica__c = String.valueOf(system.now().getTime()),                        
                        EOF_Data_Notifica__c = system.now(),
                        EOF_Nuova_DAC__c = t.Data_Appuntamento__c, 
                		EOF_Orario_DAC__c = orario_DAC,                                                            
                        EOF_Reason_Rimodulazione_DAC__c = 'Ripianificazione appuntamento causa Cliente',
                        Updated__c = true
                    );
                    //Debug level only --- In practical cases, notifies will be always correctly generated
                    try{
                        insert notify;
                        EOF_Notify__c notifyRec = new EOF_Notify__c();
                        notifyRec = [SELECT Caso__c,RecordType.Name,Codice_Rifiuto_Sospensione_Annullamento__c,
                                     EOF_Codice_Motivazione_Rimodulazione__c,EOF_Codice_Operatore__c,
                                     EOF_Codice_Ordine_EOF__c,EOF_Codice_Ordine_OLO__c,EOF_Data_Espletamento_Ordine__c,EOF_Data_Notifica__c,EOF_Esito_Consegna_Apparato_ctrl__c,EOF_Esito_Consegna_Apparato__c,
                                     EOF_GPON_Attestazione__c,EOF_ID_Apparato_Consegnato__c,EOF_ID_Notifica__c,EOF_ID_Risorsa__c,EOF_ID_Splitter_Secondario__c,
                                     EOF_Inviata__c,EOF_Note__c,EOF_Nuova_DAC__c,EOF_Parametri_Trasmissivi_Ottici__c,EOF_Posizione_Splitter_Secondario__c,EOF_Reason_Rimodulazione_DAC__c,
                                     EOF_Stato_Richiesta_ctrl__c,EOF_Stato_Richiesta__c,EOF_Tipo_Comunicazione_ctrl__c,Flag_Pagamento__c,Id,EOF_Orario_DAC__c,
                                     Motivo_Rifiuto_Sospensione_Annullamento__c,Name,Numero_Operatore__c,RecordTypeId, Updated__c,Tipo_Comunicazione__c FROM EOF_Notify__c where id=: notify.id];
                                                     
                        
                         EOF_EAI_Service_Log__c sl = EOF_GW_GE_Utils.Create_EAI_Log(notifyRec);
                        insert sl;
                        
                        //------calling webservice EOF_GW_WS_Notify ACK/NACK EAI Service Log----                        
                            EOF_GW_Utils.createAckNackNotifyServiceLog(notifyRec.Id+'');
                        	
                    }catch(Exception e){
                        //result.add(e.getmessage());
                        res_temp.CausaleErrore = e.getmessage();
                  }
                  
        	}
                
        system.debug('taskObject.ReminderDateTime-----' + taskObject.ReminderDateTime);
        attachment.OwnerId = taskObject.OwnerId;
        attachment.ParentId = taskObject.Id; // the record the file is attached to
        attachment.IsPrivate = false; 
        //PageReference p = new PageReference('/' + taskObject.Id);
             
        try {
            if(attachment.name != '' && attachment.body != null){
                insert attachment;
                system.debug('I am here--' + attachment.name);
                //return p;                
            }
            else if(attachment.body != null && (attachment.name == '' || attachment.name == null)){
                system.debug('I am here-12-' + attachment.name);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment. File Name might be missing',''));
                //return null;
            } 
            else{
                system.debug('I am here-1234-' + + attachment.name);
                //return p;
            } 
                    
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment. File Name might be missing',''));
            //return null;
        } 
        success = true;       
    }
    
    public void cancel_with_redirect(){}
}