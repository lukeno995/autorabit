public class CQS_Allegato_customController {
    
            public String selectedType {get;set;} // optTipoAtt
//          public Boolean selectedAwesomeness {get;set;}//
            public String description {get;set;} //descrizione
        //  private OF_CQS_Evento__c ev {get;set;} 
            public String fileName {get;set;}
            public Blob fileBody {get;set;}
            private OF_CQS_Evento__c ev {get;set;}
            public String idEv {get;set;}
                    
    public CQS_Allegato_customController(ApexPages.StandardController controller) { 
        
        
        this.ev = (OF_CQS_Evento__c)controller.getRecord();
        idEv = ApexPages.currentPage().getParameters().get('evId');
        
        
      
      /*
        this.ev = (OF_CQS_Evento__c)controller.getRecord();
        string s= ApexPages.CurrentPage().getUrl();
        String idEv= ApexPages.currentPage().getParameters().get('id');
        String s1= s.substringBetween('&eid=','&ic=');
        System.debug('costruttore Evento. l\'id dell\'evento è: ' + this.ev +'. IdEvento: ' + idEv + ' s:' + s + ' s1:'+ s1);
        this.ev=[select id from OF_CQS_Evento__c where id=:idEv];
   
            PageReference pageRef= ApexPages.currentPage();
        System.debug('nel costruttore. la pagereference pageRef è: ' + pageRef);
        String idEv= ApexPages.currentPage().getParameters().get('id');
        OF_CQS_Evento__c ev = [select id, (select id, CQS_All_ev__c from CQS_Allegati__r) from OF_CQS_Evento__c where id=:idEv];
        System.debug('evento ev popolato con la query è il seguente: ' + ev);
        String s2= pageRef.getUrl();
        system.debug('@@@@@@ pageRef getUrl: ' + s2);
        CQS_Allegati__c al= new CQS_Allegati__c();
        al.CQS_All_ev__c=ev.id;
   
    */
    }   
    
    //JD/EC
    
    // creates a new CQS_Allegati__c record
    @TestVisible private Database.SaveResult saveCustomAttachment() {
        //idEv = ApexPages.currentPage().getParameters().get('evId');
        CQS_Allegati__c obj = new CQS_Allegati__c();
        obj.CQS_All_ev__c = idEv;// ev.Id; //masterdetail su evento
        obj.CQS_All_Descrizione__c = description;
        obj.CQS_All_Tipo_Allegato__c = selectedType; //in caso da cambiare con optTipoAtt
    //    obj.awesome__c = selectedAwesomeness;
        // fill out cust obj fields
        return Database.insert(obj);
        
    }
    
    // create an actual Attachment record with the Contact_Attachment__c as parent
    @TestVisible private Database.SaveResult saveStandardAttachment(Id parentId) {
        Database.SaveResult result;
        
        Attachment attachment = new Attachment();
        attachment.body = this.fileBody;
        attachment.name = this.fileName;
        attachment.parentId = parentId;
        // inser the attahcment
        result = Database.insert(attachment);
        // reset the file for the view state
        fileBody = Blob.valueOf(' ');
        return result;
    }
    //EC tentativo per testare il metodo soprastante privato
    //
     public void callMethod(){
            if(Test.isRunningTest())
            {
            saveCustomAttachment();
            }
        }
    
    
    /**
    * Upload process is:
    *  1. Insert new Contact_Attachment__c record
    *  2. Insert new Attachment with the new Contact_Attachment__c record as parent
    *  3. Update the Contact_Attachment__c record with the ID of the new Attachment
    **/
    public PageReference processUpload() {
        
        idEv = ApexPages.currentPage().getParameters().get('evId');
        system.debug('siamo nel metodo processUpload');
        try {
            Database.SaveResult customAttachmentResult = saveCustomAttachment();
                        system.debug('Database.SaveResult customAttachmentResult = ' + customAttachmentResult);
                        
            if (customAttachmentResult == null || !customAttachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));
                  
                return null;
            }
        
            Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());
            system.debug('Database.SaveResult attachmentResult= ' + attachmentResult);
        
            if (attachmentResult == null || !attachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));            
                return null;
            } else {
                // update the custom attachment record with some attachment info
                CQS_Allegati__c customAttachment = [select id, name, CQS_Ev_Allegato__c from CQS_Allegati__c where id = :customAttachmentResult.getId()];
                customAttachment.name = this.fileName;
                customAttachment.CQS_Ev_Allegato__c = attachmentResult.getId();
                update customAttachment;
             system.debug('customAttachment.name: ' + customAttachment.name +' Id Allegato: ' + customAttachment.CQS_Ev_Allegato__c + 'Id Evento: ' + idEv);
            }
        
        } catch (Exception e) {
            ApexPages.AddMessages(e);
            return null;
        }
       // return pageRef;
      return new PageReference('/'+idEv);
    
    }
    
    public PageReference back() {
        return new PageReference('/'+idEv);
    } 

}